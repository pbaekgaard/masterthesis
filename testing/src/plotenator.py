from src.database import ResultsDatabase
import matplotlib.pyplot as plt
import pandas as pd

class Plotter:
    def __init__(self, db: ResultsDatabase):
        self.db = db

    def create_plots(self):
        return {
            "exhaustive": self.plot_exhaustive(edited=False),
            "exhaustive_edited": self.plot_exhaustive(edited=True),
            "guided": self.plot_guided(edited=False),
            "guided_edited": self.plot_guided(edited=True),
            "exhaustive_fault_types_normal": self.plot_fault_types(edited=False, table="exhaustive", variant="normal"),
            "exhaustive_fault_types_hard": self.plot_fault_types(edited=False, table="exhaustive", variant="hard"),
            "exhaustive_fault_types_normal_edited": self.plot_fault_types(edited=True, table="exhaustive", variant="normal"),
            "guided_fault_types_normal": self.plot_fault_types(edited=False, table="guided", variant="normal"),
            "guided_fault_types_hard": self.plot_fault_types(edited=False, table="guided", variant="hard"),
            "guided_fault_types_normal_edited": self.plot_fault_types(edited=True, table="guided", variant="normal"),
        }


    def plot_exhaustive(self, edited=False):
        suffix = " (Edited)" if edited else ""
        where = "WHERE edited = 1" if edited else "WHERE edited = 0"
        df = self.db.query_df(f"SELECT * FROM exhaustive_interpreter_results {where}")

        if df.empty:
            fig, ax = plt.subplots()
            ax.text(0.5, 0.5, f"No data{suffix}", ha='center', va='center', transform=ax.transAxes)
            ax.set_title(f"Exhaustive Interpreter - Outcome Distribution{suffix}")
            return fig

        grouped = df.groupby(["variant", "passed"]).size().unstack(fill_value=0)

        passed_labels = {
            0: "Faulty",
            1: "Normal Execution",
            2: "Panicked!",
            77: "Countermeasure Activated",
            78: "Faulty Jump to Countermeasure"
        }

        grouped = grouped.rename(columns=passed_labels)

        fig, ax = plt.subplots()
        grouped.plot(kind="bar", stacked=False, ax=ax)

        for container in ax.containers:
            ax.bar_label(container, labels=[f'{int(v.get_height())}' if v.get_height() > 0 else '' for v in container], padding=3, fontsize=8)

        ax.set_title(f"Exhaustive Interpreter - Outcome Distribution{suffix}")
        ax.set_ylabel("Count (log scale)")
        ax.set_xlabel("Variant")
        ax.set_yscale("log")
        ax.legend(title="Outcome")

        self._style_axes(ax)
        
        return fig

    def plot_guided(self, edited=False):
        suffix = " (Edited)" if edited else ""
        where = "WHERE edited = 1" if edited else "WHERE edited = 0"
        df = self.db.query_df(f"SELECT * FROM guided_interpreter_results {where}")

        if df.empty:
            fig, ax = plt.subplots()
            ax.text(0.5, 0.5, f"No data{suffix}", ha='center', va='center', transform=ax.transAxes)
            ax.set_title(f"Guided Interpreter - Outcome Distribution{suffix}")
            return fig

        grouped = df.groupby(["variant", "passed"]).size().unstack(fill_value=0)

        passed_labels = {
            0: "Faulty",
            1: "Normal Execution",
            2: "Panicked!",
            77: "Countermeasure Activated",
            78: "Faulty Jump to Countermeasure"
        }

        grouped = grouped.rename(columns=passed_labels)

        fig, ax = plt.subplots()

        grouped.plot(kind="bar", stacked=False, ax=ax)

        for container in ax.containers:
            ax.bar_label(container, labels=[f'{int(v.get_height())}' if v.get_height() > 0 else '' for v in container], padding=3, fontsize=8)

        ax.set_title(f"Guided Interpreter - Outcome Distribution{suffix}")
        ax.set_ylabel("Count (log scale)")
        ax.set_xlabel("Variant")
        ax.set_yscale("log")
        ax.legend(title="Passed value")

        self._style_axes(ax)
        
        return fig
    
    def _style_axes(self, ax):
        ax.xaxis.label.set_fontweight('bold')
        ax.yaxis.label.set_fontweight('bold')

    def export_symex_csv(self, output_path):
        df = self.db.query_df("SELECT * FROM symex_results")
        df.to_csv(output_path, index=False)

    def plot_fault_types(self, edited=False, table="exhaustive", variant="normal"):
        suffix = " (Edited)" if edited else ""
        variant_label = variant
        where = f"WHERE edited = {1 if edited else 0} AND variant = '{variant}'"
        table_name = f"{table}_interpreter_results"
        df = self.db.query_df(f"SELECT * FROM {table_name} {where}")

        if df.empty:
            fig, ax = plt.subplots()
            display_label = variant.title()
            ax.text(0.5, 0.5, f"No data ({display_label}){suffix}", ha='center', va='center', transform=ax.transAxes)
            ax.set_title(f"Fault Type Distribution - {display_label}{suffix}")
            return fig

        fault_outcomes = df[df["passed"].isin([0, 2])].copy()
        fault_outcomes["outcome"] = fault_outcomes["passed"].map({0: "Faulty", 2: "Panicked!"})

        fault_type_map = {"pc": "PC", "reg": "REG", "cpsr": "CPSR"}
        fault_outcomes["fault_type_label"] = fault_outcomes["fault_type"].map(fault_type_map)

        grouped = fault_outcomes.groupby(["outcome", "fault_type_label"]).size().unstack(fill_value=0)

        ordered_cols = ["PC", "REG", "CPSR"]
        for col in ordered_cols:
            if col not in grouped.columns:
                grouped[col] = 0
        grouped = grouped[ordered_cols]

        fig, ax = plt.subplots()
        grouped.plot(kind="bar", stacked=False, ax=ax)

        for container in ax.containers:
            ax.bar_label(container, labels=[f'{int(v.get_height())}' if v.get_height() > 0 else '' for v in container], padding=3, fontsize=8)

        interpreter_name = "Exhaustive" if table == "exhaustive" else "Guided"
        display_label = variant.title()
        ax.set_title(f"{interpreter_name} - Fault Type Distribution - {display_label}{suffix}")
        ax.set_ylabel("Count (log scale)")
        ax.set_xlabel("Outcome")
        ax.set_yscale("log")
        ax.legend(title="Fault Type")

        self._style_axes(ax)
        
        return fig
