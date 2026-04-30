from src.database import ResultsDatabase
import matplotlib.pyplot as plt
class Plotter:
    def __init__(self, db: ResultsDatabase):
        self.db = db
    def create_plots(self):
        print("Running plots:")
        self.plot_symex()
        self.plot_exhaustive()
        self.plot_guided()
        

    def plot_symex(self):
        df = self.db.query_df("SELECT * FROM symex_results")

        fig, ax = plt.subplots(figsize=(12, 3))
        ax.axis('off')

        table = ax.table(
            cellText=df.values,
            colLabels=df.columns,
            loc='center',
            cellLoc='center'
        )

        table.auto_set_font_size(False)
        table.set_fontsize(12)
        table.auto_set_column_width(col=list(range(len(df.columns))))
        table.scale(1.2, 1.5)  # 👈 spacing fix

        # bold header
        for (row, col), cell in table.get_celld().items():
            if row == 0:
                cell.set_text_props(weight='bold')

        plt.title("SymEx Results", pad=20)
        plt.show()
    
    def plot_exhaustive(self):
        df = self.db.query_df("SELECT * FROM exhaustive_interpreter_results")

        grouped = df.groupby(["variant", "passed"]).size().unstack(fill_value=0)

        grouped.plot(kind="bar", stacked=False)

        plt.title("Exhaustive Interpreter - Outcome Distribution")
        plt.ylabel("Count")
        plt.xlabel("Variant")
        plt.legend(title="Passed value")
        plt.show()
        
    def plot_guided(self):
        df = self.db.query_df("SELECT * FROM guided_interpreter_results")

        grouped = df.groupby(["variant", "passed"]).size().unstack(fill_value=0)

        grouped.plot(kind="bar", stacked=False)

        plt.title("Guided Interpreter - Outcome Distribution")
        plt.ylabel("Count")
        plt.xlabel("Variant")
        plt.legend(title="Passed value")
        plt.show()