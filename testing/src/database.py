import json
import sqlite3
from datetime import datetime
import pandas as pd


class ResultsDatabase:
    SCHEMA = """
    CREATE TABLE IF NOT EXISTS runs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        run_number INTEGER NOT NULL,
        timestamp TEXT NOT NULL,
        tests_folder TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS exhaustive_interpreter_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        run_id INTEGER NOT NULL,
        test TEXT NOT NULL,
        variant TEXT NOT NULL,
        injection_point TEXT NOT NULL,
        fault_type TEXT,
        fault_pc INTEGER,
        fault_reg TEXT,
        fault_bit INTEGER,
        returncode INTEGER NOT NULL,
        pc_before INTEGER,
        pc_after INTEGER,
        expected_exec_instr TEXT,
        actual_exec_instr TEXT,
        reg_old_value INTEGER,
        reg_new_value INTEGER,
        stdout TEXT,
        stderr TEXT,
        expected_output TEXT NOT NULL,
        matched_output_line TEXT,
        passed INTEGER NOT NULL,
        FOREIGN KEY (run_id) REFERENCES runs(id)
    );

    CREATE TABLE IF NOT EXISTS guided_interpreter_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        run_id INTEGER NOT NULL,
        test TEXT NOT NULL,
        variant TEXT NOT NULL,
        injection_point TEXT NOT NULL,
        fault_type TEXT,
        fault_pc INTEGER,
        fault_reg TEXT,
        fault_bit INTEGER,
        returncode INTEGER NOT NULL,
        pc_before INTEGER,
        pc_after INTEGER,
        expected_exec_instr TEXT,
        actual_exec_instr TEXT,
        reg_old_value INTEGER,
        reg_new_value INTEGER,
        stdout TEXT,
        stderr TEXT,
        expected_output TEXT NOT NULL,
        matched_output_line TEXT,
        passed INTEGER NOT NULL,
        FOREIGN KEY (run_id) REFERENCES runs(id)
    );


    CREATE TABLE IF NOT EXISTS symex_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        run_id INTEGER NOT NULL,
        test TEXT NOT NULL,
        variant TEXT NOT NULL,
        stmt INTEGER NOT NULL,
        faulty_bit INTEGER,
        result INTEGER NOT NULL,
        FOREIGN KEY (run_id) REFERENCES runs(id)
    );
    CREATE INDEX IF NOT EXISTS idx_test_results_run_id ON exhaustive_interpreter_results(run_id);
    CREATE INDEX IF NOT EXISTS idx_test_results_test ON exhaustive_interpreter_results(test);
    CREATE INDEX IF NOT EXISTS idx_test_results_variant ON exhaustive_interpreter_results(variant);
    CREATE INDEX IF NOT EXISTS idx_test_results_passed ON exhaustive_interpreter_results(passed);

    CREATE INDEX IF NOT EXISTS idx_test_results_run_id ON guided_interpreter_results(run_id);
    CREATE INDEX IF NOT EXISTS idx_test_results_test ON guided_interpreter_results(test);
    CREATE INDEX IF NOT EXISTS idx_test_results_variant ON guided_interpreter_results(variant);
    CREATE INDEX IF NOT EXISTS idx_test_results_passed ON guided_interpreter_results(passed);
    
    CREATE INDEX IF NOT EXISTS idx_test_results_run_id ON symex_results(run_id);
    CREATE INDEX IF NOT EXISTS idx_test_results_test ON symex_results(test);
    CREATE INDEX IF NOT EXISTS idx_test_results_variant ON symex_results(variant);
    CREATE INDEX IF NOT EXISTS idx_test_results_result ON symex_results(result);
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
    def insert_symex_results_batch(self, run_id, results):
        rows = []

        for res in results:
            rows.append((
                run_id,
                res["test"],
                res["variant"],
                res["stmt"],
                res["faulty_bit"],
                res["result"],
            ))

        self._conn.executemany(
            """
            INSERT INTO symex_results
            (run_id, test, variant, stmt, faulty_bit, result)
            VALUES (?, ?, ?, ?, ?, ?)
            """,
            rows,
        )
        self._conn.commit()

    def query_df(self, query):
        return pd.read_sql_query(query, self._conn)
        
    def insert_interpreter_results_batch(self, run_id, results, guided=False):
        rows = []
        for res in results:
            parts = res["injection_point"].split(":")
            if parts[0] == "pc":
                fault_type, fault_pc, fault_reg, fault_bit = ("pc", int(parts[1]), None, int(parts[2]))
            elif parts[0] == "reg":
                fault_type, fault_pc, fault_reg, fault_bit = ("reg", int(parts[1]), int(parts[2]), int(parts[3]))
            elif parts[0] == "cpsr":
                fault_type, fault_pc, fault_reg, fault_bit = ("cpsr", int(parts[1]), parts[2], None)
            else:
                fault_type, fault_pc, fault_reg, fault_bit = (None, None, None, None)
            test_report = json.loads(res["test_report"])
            pc_before = test_report.get("pc_old_value", None)
            pc_new = test_report.get("pc_new_value", None)
            expected_exec_instr = test_report.get("expected_exec_instr", "N/A")
            actual_exec_instr = test_report.get("actual_exec_instr", "N/A")
            reg_old_value = test_report.get("reg_old_value", None)
            reg_new_value = test_report.get("reg_new_value", None)

            def _clamp_int(val, max_val=2**63 - 1, min_val=-(2**63)):
                if val is None:
                    return None
                try:
                    int_val = int(val)
                except (ValueError, TypeError):
                    return None
                if int_val > max_val or int_val < min_val:
                    return str(int_val)
                return int_val

            pc_before = _clamp_int(pc_before)
            pc_new = _clamp_int(pc_new)
            reg_old_value = _clamp_int(reg_old_value)
            reg_new_value = _clamp_int(reg_new_value)

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
                pc_before,
                pc_new,
                expected_exec_instr,
                actual_exec_instr,
                reg_old_value,
                reg_new_value,
                res["stdout"],
                res["stderr"],
                res["expected_output"],
                res.get("matched_output_line"),
                int(res["passed"]),
            ))
        
        table = "exhaustive_interpreter_results"
        if guided:
            table = "guided_interpreter_results"
        self._conn.executemany(
            f"""
            INSERT INTO {table} 
            (run_id, test, variant, injection_point, fault_type, fault_pc, fault_reg, fault_bit,
            returncode, pc_before, pc_after, expected_exec_instr, actual_exec_instr, reg_old_value, reg_new_value, stdout, stderr, expected_output, matched_output_line, passed)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            rows,
        )
        self._conn.commit()
