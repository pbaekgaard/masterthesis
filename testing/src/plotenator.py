from matplotlib.axes import Axes
from src.database import ResultsDatabase
import matplotlib.pyplot as plt
import pandas as pd

OUTCOME_COLOR_MAP = {
    "Normal Execution": "#4daf4a",
    "Faulty (Authenticated = 1)": "#ff2a2c",
    "Faulty (Message Leaked)": "#ff2a2c",
    "Faulty (P or Q Derived)": "#ff2a2c",
    "Panicked": "#984ea3",
    "Infinite Loop": "#555555",
    "Message Leaked": "#e6ab02",
    "Wrong Hash Returned": "#e6ab02",
    "Faulty Encryption": "#ff7f00",
    "Countermeasure Activated": "#377eb8",
    "Faulty Jump to Countermeasure": "#00FFFF",
    "Other": "#FFFF00",
}
OUTCOME_COLORS = list(OUTCOME_COLOR_MAP.values())
FAULT_TYPE_COLORS = ["#a6cee3", "#ff4411", "#b2df8a"]
FIG_WIDTH = 14

class Plotter:
    def __init__(self, db: ResultsDatabase, test_name: str):
        self.db = db
        self.test_name = test_name

    def create_plots(self):
        return {
            "exhaustive": self.plot_exhaustive(edited=False),
            "exhaustive_edited": self.plot_exhaustive(edited=True),
            "guided": self.plot_guided(edited=False),
            "guided_edited": self.plot_guided(edited=True),
            "exhaustive_fault_types_normal": self.plot_fault_types(edited=False, table="exhaustive", variant="normal"),
            "exhaustive_fault_types_hard": self.plot_fault_types(edited=False, table="exhaustive", variant="hard"),
            "exhaustive_fault_types_sc": self.plot_fault_types(edited=False, table="exhaustive", variant="sc"),
            "exhaustive_fault_types_vd": self.plot_fault_types(edited=False, table="exhaustive", variant="vd"),
            "exhaustive_fault_types_normal_edited": self.plot_fault_types(edited=True, table="exhaustive", variant="normal"),
            "guided_fault_types_normal": self.plot_fault_types(edited=False, table="guided", variant="normal"),
            "guided_fault_types_hard": self.plot_fault_types(edited=False, table="guided", variant="hard"),
            "guided_fault_types_sc": self.plot_fault_types(edited=False, table="guided", variant="sc"),
            "guided_fault_types_vd": self.plot_fault_types(edited=False, table="guided", variant="vd"),
            "guided_fault_types_normal_edited": self.plot_fault_types(edited=True, table="guided", variant="normal"),
        }

    def get_return_labels(self, variant=None):
        if variant == "normal":
            if self.test_name == "crt":
                return {
                    0: "Faulty (P or Q Derived)",
                    1: "Normal Execution",
                    2: "Panicked",
                    3: "Infinite Loop",
                    4: "Message Leaked",
                    7: "Faulty Encryption",
                    77: "Faulty Encryption",
                    "Other": "Other",
                }
            elif self.test_name == "pinny":
                return {
                    0: "Faulty (Authenticated = 1)",
                    1: "Normal Execution",
                    2: "Panicked",
                    3: "Infinite Loop",
                    "Other": "Other",
                }
            elif self.test_name == "hash":
                return {
                    0: "Faulty (Message Leaked)",
                    1: "Normal Execution",
                    2: "Panicked",
                    4: "Wrong Hash Returned",
                    3: "Infinite Loop",
                    77: "Wrong Hash Returned",
                    "Other": "Other",
                }
            else:
                raise Exception("something wrong with the name")

        if self.test_name == "crt":
            return {
                0: "Faulty (P or Q Derived)",
                1: "Normal Execution",
                2: "Panicked",
                3: "Infinite Loop",
                4: "Message Leaked",
                7: "Faulty Encryption",
                77: "Countermeasure Activated",
                78: "Faulty Jump to Countermeasure",
                "Other": "Other",
            }
        elif self.test_name == "pinny":
            return {
                0: "Faulty (Authenticated = 1)",
                1: "Normal Execution",
                2: "Panicked",
                3: "Infinite Loop",
                77: "Countermeasure Activated",
                78: "Faulty Jump to Countermeasure",
                "Other": "Other",
            }
        elif self.test_name == "hash":
            return {
                0: "Faulty (Message Leaked)",
                1: "Normal Execution",
                2: "Panicked",
                4: "Wrong Hash Returned",
                3: "Infinite Loop",
                77: "Countermeasure Activated",
                78: "Faulty Jump to Countermeasure",
                "Other": "Other",
            }
        else:
            raise Exception("something wrong with the name")

    def plot_exhaustive(self, edited=False):
        suffix = " (Guided Manual Hardening)" if edited else ""
        where = "WHERE edited = 1" if edited else "WHERE edited = 0"
        df = self.db.query_df(f"SELECT * FROM exhaustive_interpreter_results {where}")

        if df.empty:
            fig, ax = plt.subplots(figsize=(FIG_WIDTH, 6))
            ax.text(0.5, 0.5, f"No data{suffix}", ha='center', va='center', transform=ax.transAxes)
            ax.set_title(f"Exhaustive Interpreter - Outcome Distribution{suffix}")
            return fig

        returncode_labels = self.get_return_labels()
        known_codes = {k for k in returncode_labels if isinstance(k, int)}
        df = df.copy()
        df["outcome"] = df["passed"].apply(
            lambda rc: rc if rc in known_codes else "Other"
        )
        fig, ax = plt.subplots(figsize=(FIG_WIDTH, 6))

        if edited:
            counts = df["outcome"].value_counts().rename(returncode_labels)
            ordered_outcomes = [c for c in returncode_labels.values() if c != "Other" and c in counts.index]
            if "Other" in counts.index:
                ordered_outcomes.append("Other")
            counts = counts[ordered_outcomes]

            colors = [OUTCOME_COLOR_MAP.get(outcome, "#a65628") for outcome in counts.index]
            ax.bar(range(len(counts)), counts.values, color=colors)
            ax.set_xticks(range(len(counts)))
            ax.set_xticklabels(counts.index, ha='center')
        else:
            grouped = df.groupby(["variant", "outcome"]).size().unstack(fill_value=0)
            grouped = grouped.rename(columns=returncode_labels)

            col_order = [c for c in returncode_labels.values() if c != "Other" and c in grouped.columns]
            if "Other" in grouped.columns:
                col_order.append("Other")
            grouped = grouped[col_order]

            variant_labels = {"sc": "Statement Counter", "vd": "Variable Duplication"}
            grouped.index = [variant_labels.get(v, v) for v in grouped.index]

            variants = grouped.index.tolist()
            n_variants = len(variants)
            max_bars = max((grouped.loc[v] > 0).sum() for v in variants) if variants else 1
            group_width = 0.8

            seen_outcomes = set()
            for i, variant in enumerate(variants):
                row = grouped.loc[variant]
                sorted_row = row.sort_values(ascending=False)
                sorted_row = sorted_row[sorted_row > 0]
                n = len(sorted_row)
                for j, (outcome, val) in enumerate(sorted_row.items()):
                    if n == 1:
                        x = i
                    else:
                        x = i - group_width / 2 + (j + 0.5) * group_width / n
                    color = OUTCOME_COLOR_MAP.get(outcome, "#a65628")
                    label = outcome if outcome not in seen_outcomes else None
                    if label:
                        seen_outcomes.add(outcome)
                    ax.bar(x, val, width=0.9 * group_width / n, color=color, label=label)

            ax.set_xticks(range(n_variants))
            ax.set_xticklabels(variants)

            for container in ax.containers:
                for patch in container:
                    h = patch.get_height()
                    if h > 0:
                        x = patch.get_x() + patch.get_width() / 2
                        ax.text(x, h / 2, f'{int(h)}', ha='center', va='center',
                                fontsize=8, rotation=90, color='black', fontweight='bold')

            self._add_horizontal_legend(fig, ax, "Outcome")

        ax.set_title(f"Exhaustive Interpreter - Outcome Distribution{suffix}")
        ax.set_xlabel(None)
        self._apply_scale(ax)

        if edited:
            ymin, ymax = ax.get_ylim()
            for i, (outcome, val) in enumerate(counts.items()):
                if val > 0:
                    if ax.get_yscale() == "log":
                        y_pos = (ymin * val) ** 0.5
                    else:
                        y_pos = val / 2
                    ax.text(i, y_pos, f'{int(val)}', ha='center', va='center',
                            fontsize=8, rotation=90, color='black', fontweight='bold')

        self._style_axes(ax)

        return fig

    def plot_guided(self, edited=False):
        suffix = " (Guided Manual Hardening)" if edited else ""
        where = "WHERE edited = 1" if edited else "WHERE edited = 0"
        df = self.db.query_df(f"SELECT * FROM guided_interpreter_results {where}")

        if df.empty:
            fig, ax = plt.subplots(figsize=(FIG_WIDTH, 6))
            ax.text(0.5, 0.5, f"No data{suffix}", ha='center', va='center', transform=ax.transAxes)
            ax.set_title(f"Guided Interpreter - Outcome Distribution{suffix}")
            return fig

        returncode_labels = self.get_return_labels()
        known_codes = {k for k in returncode_labels if isinstance(k, int)}
        df = df.copy()
        df["outcome"] = df["passed"].apply(
            lambda rc: rc if rc in known_codes else "Other"
        )

        fig, ax = plt.subplots(figsize=(FIG_WIDTH, 6))

        if edited:
            counts = df["outcome"].value_counts().rename(returncode_labels)
            ordered_outcomes = [c for c in returncode_labels.values() if c != "Other" and c in counts.index]
            if "Other" in counts.index:
                ordered_outcomes.append("Other")
            counts = counts[ordered_outcomes]

            colors = [OUTCOME_COLOR_MAP.get(outcome, "#a65628") for outcome in counts.index]
            ax.bar(range(len(counts)), counts.values, color=colors)
            ax.set_xticks(range(len(counts)))
            ax.set_xticklabels(counts.index, ha='center')
        else:
            grouped = df.groupby(["variant", "outcome"]).size().unstack(fill_value=0)
            grouped = grouped.rename(columns=returncode_labels)

            col_order = [c for c in returncode_labels.values() if c != "Other" and c in grouped.columns]
            if "Other" in grouped.columns:
                col_order.append("Other")
            grouped = grouped[col_order]

            variant_labels = {"sc": "Statement Counter", "vd": "Variable Duplication"}
            grouped.index = [variant_labels.get(v, v) for v in grouped.index]

            variants = grouped.index.tolist()
            n_variants = len(variants)
            max_bars = max((grouped.loc[v] > 0).sum() for v in variants) if variants else 1
            group_width = 0.8

            seen_outcomes = set()
            for i, variant in enumerate(variants):
                row = grouped.loc[variant]
                sorted_row = row.sort_values(ascending=False)
                sorted_row = sorted_row[sorted_row > 0]
                n = len(sorted_row)
                for j, (outcome, val) in enumerate(sorted_row.items()):
                    if n == 1:
                        x = i
                    else:
                        x = i - group_width / 2 + (j + 0.5) * group_width / n
                    color = OUTCOME_COLOR_MAP.get(outcome, "#a65628")
                    label = outcome if outcome not in seen_outcomes else None
                    if label:
                        seen_outcomes.add(outcome)
                    ax.bar(x, val, width=0.9 * group_width / n, color=color, label=label)

            ax.set_xticks(range(n_variants))
            ax.set_xticklabels(variants)

            for container in ax.containers:
                for patch in container:
                    h = patch.get_height()
                    if h > 0:
                        x = patch.get_x() + patch.get_width() / 2
                        ax.text(x, h / 2, f'{int(h)}', ha='center', va='center',
                                fontsize=8, rotation=90, color='black', fontweight='bold')

            self._add_horizontal_legend(fig, ax, "Outcome")

        ax.set_title(f"Guided Interpreter - Outcome Distribution{suffix}")
        ax.set_xlabel(None)
        self._apply_scale(ax)

        if edited:
            ymin, ymax = ax.get_ylim()
            for i, (outcome, val) in enumerate(counts.items()):
                if val > 0:
                    if ax.get_yscale() == "log":
                        y_pos = (ymin * val) ** 0.5
                    else:
                        y_pos = val / 2
                    ax.text(i, y_pos, f'{int(val)}', ha='center', va='center',
                            fontsize=8, rotation=90, color='black', fontweight='bold')

        self._style_axes(ax)

        return fig

    def _style_axes(self, ax: Axes):
        ax.xaxis.label.set_fontweight('bold')
        ax.yaxis.label.set_fontweight('bold')
        ax.tick_params(axis='x', rotation=0)

    def _apply_scale(self, ax: Axes, ratio_threshold=10):
        heights = []
        for container in ax.containers:
            for patch in container:
                h = patch.get_height()
                if h > 0:
                    heights.append(h)
        if not heights:
            ymin, ymax = ax.get_ylim()
            if ymax > 0:
                heights = [ymax]
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

    def _add_horizontal_legend(self, fig, ax, title):
        handles, labels = ax.get_legend_handles_labels()
        leg = fig.legend(
            handles, labels,
            title=title,
            loc='lower center',
            bbox_to_anchor=(0.5, 0.05),
            ncol=min(len(handles), 6),
            fontsize=8,
            title_fontsize=9,
            frameon=True,
        )
        leg.get_title().set_fontweight('bold')
        fig.tight_layout()
        fig.subplots_adjust(bottom=0.2)

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
            variant_display = {"sc": "Statement Counter", "vd": "Variable Duplication"}
            display_label = variant_display.get(variant, variant.title())
            ax.text(0.5, 0.5, f"No data ({display_label}){suffix}", ha='center', va='center', transform=ax.transAxes)
            ax.set_title(f"Fault Type Distribution - {display_label}{suffix}")
            return fig

        fault_outcomes = df.copy()

        returncode_labels = self.get_return_labels(variant=variant)
        known_codes = {k for k in returncode_labels if isinstance(k, int)}
        fault_outcomes["outcome"] = fault_outcomes["passed"].apply(
            lambda rc: rc if rc in known_codes else "Other"
        )
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

        fig, ax = plt.subplots(figsize=(FIG_WIDTH, 6))
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
        variant_display = {"sc": "Statement Counter", "vd": "Variable Duplication"}
        display_label = variant_display.get(variant, variant.title())
        testName = self.test_name.capitalize()
        if testName == "Hash":
            testName = "Hashy"
        elif testName == "Crt":
            testName == "CRT-RSA"

        ax.set_title(f"{interpreter_name} - Fault Type Distribution - {display_label}{suffix} ({testName})")
        ax.set_xlabel(None)
        self._apply_scale(ax)
        self._add_horizontal_legend(fig, ax, "Fault Type")

        self._style_axes(ax)

        return fig
