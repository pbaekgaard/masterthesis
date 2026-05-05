from src.database import ResultsDatabase
import matplotlib.pyplot as plt

class Plotter:
    def __init__(self, db: ResultsDatabase):
        self.db = db

    def create_plots(self):
        print("Running plots:")
        return {
            "exhaustive": self.plot_exhaustive(),
            "guided": self.plot_guided()
        }


    def plot_exhaustive(self):
        df = self.db.query_df("SELECT * FROM exhaustive_interpreter_results")

        grouped = df.groupby(["variant", "passed"]).size().unstack(fill_value=0)

        fig, ax = plt.subplots()
        grouped.plot(kind="bar", stacked=False, ax=ax)

        ax.set_title("Exhaustive Interpreter - Outcome Distribution")
        ax.set_ylabel("Count (log scale)")
        ax.set_xlabel("Variant")
        ax.set_yscale("log")
        ax.legend(title="Passed value")

        self._style_axes(ax)
        
        return fig

    def plot_guided(self):
        df = self.db.query_df("SELECT * FROM guided_interpreter_results")

        grouped = df.groupby(["variant", "passed"]).size().unstack(fill_value=0)

        fig, ax = plt.subplots()
        grouped.plot(kind="bar", stacked=False, ax=ax)

        ax.set_title("Guided Interpreter - Outcome Distribution")
        ax.set_ylabel("Count (log scale)")
        ax.set_xlabel("Variant")
        ax.set_yscale("log")
        ax.legend(title="Passed value")

        self._style_axes(ax)
        
        return fig
    
    def _style_axes(self, ax):
        # axis labels
        ax.xaxis.label.set_fontweight('bold')
        ax.yaxis.label.set_fontweight('bold')

        # # tick labels (numbers, "hard", "normal", etc.)
        # for label in ax.get_xticklabels():
        #     label.set_fontweight('bold')

        # for label in ax.get_yticklabels():
        #     label.set_fontweight('bold')

        # legend
        # legend = ax.get_legend()
        # if legend:
        #     for text in legend.get_texts():
        #         text.set_fontweight('bold')
    def export_symex_csv(self, output_path):
        df = self.db.query_df("SELECT * FROM symex_results")
        df.to_csv(output_path, index=False)