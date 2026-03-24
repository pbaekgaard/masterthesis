import sqlite3
from datetime import datetime


class ResultsDatabase:
    SCHEMA = """
    CREATE TABLE IF NOT EXISTS runs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        run_number INTEGER NOT NULL,
        timestamp TEXT NOT NULL,
        tests_folder TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS test_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        run_id INTEGER NOT NULL,
        test TEXT NOT NULL,
        variant TEXT NOT NULL,
        injection_point TEXT NOT NULL,
        fault_type TEXT,
        fault_pc INTEGER,
        fault_reg INTEGER,
        fault_bit INTEGER,
        returncode INTEGER NOT NULL,
        stdout TEXT,
        stderr TEXT,
        expected_output TEXT NOT NULL,
        matched_output_line TEXT,
        passed INTEGER NOT NULL,
        FOREIGN KEY (run_id) REFERENCES runs(id)
    );

    CREATE INDEX IF NOT EXISTS idx_test_results_run_id ON test_results(run_id);
    CREATE INDEX IF NOT EXISTS idx_test_results_test ON test_results(test);
    CREATE INDEX IF NOT EXISTS idx_test_results_variant ON test_results(variant);
    CREATE INDEX IF NOT EXISTS idx_test_results_passed ON test_results(passed);
    """

    def __init__(self, db_path):
        self.db_path = db_path
        self._conn = None
        self._init_db()

    def _init_db(self):
        self._conn = sqlite3.connect(self.db_path)
        self._conn.executescript(self.SCHEMA)
        self._conn.commit()

    def close(self):
        if self._conn:
            self._conn.close()
            self._conn = None

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()

    def create_run(self, run_number, tests_folder=None):
        timestamp = datetime.now().isoformat()
        cursor = self._conn.execute(
            "INSERT INTO runs (run_number, timestamp, tests_folder) VALUES (?, ?, ?)",
            (run_number, timestamp, tests_folder),
        )
        self._conn.commit()
        return cursor.lastrowid

    def insert_results_batch(self, run_id, results):
        rows = []
        for res in results:
            parts = res["injection_point"].split(":")
            if parts[0] == "pc":
                fault_type, fault_pc, fault_reg, fault_bit = ("pc", int(parts[1]), None, int(parts[2]))
            elif parts[0] == "reg":
                fault_type, fault_pc, fault_reg, fault_bit = ("reg", int(parts[1]), int(parts[2]), int(parts[3]))
            else:
                fault_type, fault_pc, fault_reg, fault_bit = (None, None, None, None)
            
            rows.append((
                run_id,
                res["test"],
                res["variant"],
                res["injection_point"],
                fault_type,
                fault_pc,
                fault_reg,
                fault_bit,
                res["returncode"],
                res["stdout"],
                res["stderr"],
                res["expected_output"],
                res.get("matched_output_line"),
                int(res["passed"]),
            ))
        
        self._conn.executemany(
            """
            INSERT INTO test_results 
            (run_id, test, variant, injection_point, fault_type, fault_pc, fault_reg, fault_bit,
             returncode, stdout, stderr, expected_output, matched_output_line, passed)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            rows,
        )
        self._conn.commit()
