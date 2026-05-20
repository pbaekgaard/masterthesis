from matplotlib.axes import Axes
from src.database import ResultsDatabase
import matplotlib.pyplot as plt
import pandas as pd
import textwrap

OUTCOME_COLORS = ["#ff2a2c", "#377eb8", "#4daf4a", "#984ea3", "#ff7f00", "#C9A227", "#a65628"]
FAULT_TYPE_COLORS = ["#a6cee3", "#ff4411", "#b2df8a"]

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
        suffix = " (Guided Manual Hardening)" if edited else ""
        where = "WHERE edited = 1" if edited else "WHERE edited = 0"
        df = self.db.query_df(f"SELECT * FROM exhaustive_interpreter_results {where}")

        if df.empty:
            fig, ax = plt.subplots()
            ax.text(0.5, 0.5, f"No data{suffix}", ha='center', va='center', transform=ax.transAxes)
            ax.set_title(f"Exhaustive Interpreter - Outcome Distribution{suffix}")
            return fig

        known_codes = {0, 1, 2, 3, 77, 78}
        df = df.copy()
        df["outcome"] = df["returncode"].apply(
            lambda rc: rc if rc in known_codes else "Other"
        )

        returncode_labels = {
            0: "Normal Execution",
            1: "Faulty",
            2: "Panicked",
            3: "Infinite Loop",
            77: "Countermeasure Activated",
            78: "Faulty Jump to Countermeasure",
            "Other": "Other",
        }

        grouped = df.groupby(["variant", "outcome"]).size().unstack(fill_value=0)
        grouped = grouped.rename(columns=returncode_labels)

        col_order = [c for c in returncode_labels.values() if c != "Other" and c in grouped.columns]
        if "Other" in grouped.columns:
            col_order.append("Other")
        grouped = grouped[col_order]

        fig, ax = plt.subplots()
        grouped.plot(kind="bar", stacked=False, ax=ax, color=OUTCOME_COLORS[:len(grouped.columns)], legend=False)

        for container in ax.containers:
            ax.bar_label(
                container,
                labels=[
                    f'{int(v.get_height())}' if v.get_height() > 0 else ''
                    for v in container
                ],
                label_type='center',
                fontsize=8,
                rotation=90,
                color='black',
                fontweight='bold'
            )

        ax.set_title(f"Exhaustive Interpreter - Outcome Distribution{suffix}")
        ax.set_xlabel(None)
        self._apply_scale(ax)
        self._add_horizontal_legend(fig, ax, "Outcome")

        self._style_axes(ax)
        
        return fig

    def plot_guided(self, edited=False):
        suffix = " (Guided Manual Hardening)" if edited else ""
        where = "WHERE edited = 1" if edited else "WHERE edited = 0"
        df = self.db.query_df(f"SELECT * FROM guided_interpreter_results {where}")

        if df.empty:
            fig, ax = plt.subplots()
            ax.text(0.5, 0.5, f"No data{suffix}", ha='center', va='center', transform=ax.transAxes)
            ax.set_title(f"Guided Interpreter - Outcome Distribution{suffix}")
            return fig

        known_codes = {0, 1, 2, 3, 77, 78}
        df = df.copy()
        df["outcome"] = df["returncode"].apply(
            lambda rc: rc if rc in known_codes else "Other"
        )

        returncode_labels = {
            0: "Normal Execution",
            1: "Faulty",
            2: "Panicked",
            3: "Infinite Loop",
            77: "Countermeasure Activated",
            78: "Faulty Jump to Countermeasure",
            "Other": "Other",
        }

        grouped = df.groupby(["variant", "outcome"]).size().unstack(fill_value=0)
        grouped = grouped.rename(columns=returncode_labels)

        col_order = [c for c in returncode_labels.values() if c != "Other" and c in grouped.columns]
        if "Other" in grouped.columns:
            col_order.append("Other")
        grouped = grouped[col_order]

        fig, ax = plt.subplots()

        grouped.plot(kind="bar", stacked=False, ax=ax, color=OUTCOME_COLORS[:len(grouped.columns)], legend=False)

        for container in ax.containers:
            ax.bar_label(
                container,
                labels=[
                    f'{int(v.get_height())}' if v.get_height() > 0 else ''
                    for v in container
                ],
                label_type='center',
                fontsize=8,
                rotation=90,
                color='black',
                fontweight='bold'
            )

        ax.set_title(f"Guided Interpreter - Outcome Distribution{suffix}")
        ax.set_xlabel(None)
        self._apply_scale(ax)
        self._add_horizontal_legend(fig, ax, "Outcome")

        self._style_axes(ax)
        
        return fig
    
    def _style_axes(self, ax: Axes):
        ax.xaxis.label.set_fontweight('bold')
        ax.yaxis.label.set_fontweight('bold')
        ax.tick_params(axis='x', rotation=0)
        
        # 1. Extract, wrap, and update the text of each label
        wrapped_labels = []
        for label in ax.get_xticklabels():
            text = label.get_text()
            # Wrap at 12–15 characters depending on your font size
            wrapped_text = textwrap.fill(text, width=14) 
            wrapped_labels.append(wrapped_text)
            
        # 2. Re-apply the wrapped strings back to the axis
        ax.set_xticklabels(wrapped_labels, ha='center')

    def _apply_scale(self, ax: Axes, ratio_threshold=10):
        heights = []
        for container in ax.containers:
            for patch in container:
                h = patch.get_height()
                if h > 0:
                    heights.append(h)
        if not heights:
            ax.set_ylabel("Count")
            return
        ratio = max(heights) / min(heights)
        if ratio > ratio_threshold:
            ax.set_yscale("log")
            ax.set_ylabel("Count (log scale)")
            ymin, ymax = ax.get_ylim()
        else:
            ax.set_ylabel("Count")
            ymin, ymax = ax.get_ylim()

    def _add_horizontal_legend(self, fig, ax, title, wrap_width=14):
        handles, labels = ax.get_legend_handles_labels()
        wrapped = [textwrap.fill(l, width=wrap_width) for l in labels]
        leg = fig.legend(
            handles, wrapped,
            title=title,
            loc='lower center',
            bbox_to_anchor=(0.5, 0.05),
            ncol=min(len(handles), 4),
            fontsize=8,
            title_fontsize=9,
            frameon=True,
        )
        leg.get_title().set_fontweight('bold')
        fig.tight_layout()
        fig.subplots_adjust(bottom=0.25)

    def export_symex_csv(self, output_path):
        df = self.db.query_df("SELECT * FROM symex_results")
        column_mapping = {
            'run_id': 'ID',
            'variant': 'Variant',
            'stmt': 'Stmt',
            'faulty_bit': 'Faulty Bit',
            'result': 'Result',
        }
        df = df.rename(columns=column_mapping)
        df.loc[df['edited'] == 1, 'Variant'] = 'Manual Hard'
        desired_columns = ['Variant', 'Stmt', 'Faulty Bit', 'Result']
        df = df[[col for col in desired_columns if col in df.columns]]
        df.to_csv(output_path, index=False)

    def plot_fault_types(self, edited=False, table="exhaustive", variant="normal"):
        suffix = " (Guided Manual Hardening)" if edited else ""
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

        fault_outcomes = df.copy()

        known_codes = {0, 1, 2, 3, 77, 78}
        fault_outcomes["outcome"] = fault_outcomes["returncode"].apply(
            lambda rc: rc if rc in known_codes else "Other"
        )

        returncode_labels = {
            0: "Normal Execution",
            1: "Faulty",
            2: "Panicked!",
            3: "Infinite Loop",
            77: "Countermeasure Activated",
            78: "Faulty Jump to Countermeasure",
            "Other": "Other",
        }
        fault_outcomes["outcome"] = fault_outcomes["outcome"].map(returncode_labels)

        fault_type_map = {"pc": "PC", "reg": "REG", "cpsr": "CPSR"}
        fault_outcomes["fault_type_label"] = fault_outcomes["fault_type"].map(fault_type_map)

        grouped = fault_outcomes.groupby(["outcome", "fault_type_label"]).size().unstack(fill_value=0)

        ordered_outcomes = [c for c in returncode_labels.values() if c != "Other" and c in grouped.index]
        if "Other" in grouped.index:
            ordered_outcomes.append("Other")
        grouped = grouped.reindex(ordered_outcomes)

        ordered_cols = ["PC", "REG", "CPSR"]
        for col in ordered_cols:
            if col not in grouped.columns:
                grouped[col] = 0
        grouped = grouped[ordered_cols]

        fig, ax = plt.subplots()
        grouped.plot(kind="bar", stacked=False, ax=ax, color=FAULT_TYPE_COLORS[:len(grouped.columns)], legend=False)

        for container in ax.containers:
            ax.bar_label(
                container,
                labels=[
                    f'{int(v.get_height())}' if v.get_height() > 0 else ''
                    for v in container
                ],
                label_type='center',
                fontsize=8,
                rotation=90,
                color='black',
                fontweight='bold'
            )

        interpreter_name = "Exhaustive" if table == "exhaustive" else "Guided"
        display_label = variant.title()
        ax.set_title(f"{interpreter_name} - Fault Type Distribution - {display_label}{suffix}")
        ax.set_xlabel(None)
        self._apply_scale(ax)
        self._add_horizontal_legend(fig, ax, "Fault Type")

        self._style_axes(ax)
        
        return fig
