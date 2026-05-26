from pathlib import Path
import pandas as pd
import math

def calc_passed_val(actual_output, expected_pass, n_value) -> bool:
    # If the output matches the expected pass, it's not a faulty cipher
    if actual_output == expected_pass:
        return False

    diff = abs(actual_output - expected_pass)
    recovered = math.gcd(diff, n_value)

    # If the recovered GCD is a prime factor (greater than 1 and less than n)
    # then we successfully derived P or Q.
    if 1 < recovered < n_value:
        return True

    return False

# Fault maps for each test type
FAULT_MAPS = {
    "crt": {
        0: "Faulty (P or Q Derived)",
        2790: "Normal Execution",
        65: "Message Leaked",
        77: "Countermeasure Activated",
    },

    "pinny": {
        1: "Faulty",
        0: "Normal Execution",
        77: "Countermeasure Activated",
    },

    "hash": {
        12345: "Faulty (Message Leaked)",
        97028: "Normal Execution",
        77: "Countermeasure Activated",
    }
}


# Folder containing this script
base_dir = Path(__file__).parent

# Input/output folders
input_dir = base_dir / "csv_files"
output_dir = base_dir / "output_files"

# Create output folder if it does not exist
output_dir.mkdir(exist_ok=True)

# Find all CSV files
csv_files = list(input_dir.glob("*.csv"))

if not csv_files:
    print(f"No CSV files found in: {input_dir}")
    exit()

for csv_file in csv_files:
    filename_lower = csv_file.name.lower()

    # Determine test type + output folder
    if "pinny" in filename_lower:
        test_type = "pinny"
        subfolder = output_dir / "pinny"

    elif "hash" in filename_lower:
        test_type = "hash"
        subfolder = output_dir / "hashy"

    elif "crt" in filename_lower:
        test_type = "crt"
        subfolder = output_dir / "crt"

    else:
        print(f"Skipping unknown file type: {csv_file.name}")
        continue

    print(f"Processing: {csv_file.name} ({test_type})")

    # Create output subfolder if needed
    subfolder.mkdir(parents=True, exist_ok=True)

    # Select correct fault map
    fault_map = FAULT_MAPS[test_type]

    # Read CSV
    df = pd.read_csv(csv_file)
    
    if "crt" in filename_lower:    
        n_value = 3233
        expected_pass = 2790

        # Use a lambda function to check each row
        mask = df['actual_output'].apply(lambda x: calc_passed_val(x, expected_pass, n_value))

        # Update the 'results' column to 0 where the attack is successful
        df.loc[mask, 'results'] = 0

    # Map numeric result -> readable fault type
    df["FaultType"] = df["Result"].map(
        lambda x: fault_map.get(x, "Other")
    )

    # Group statements together
    grouped = (
        df.groupby(["Variant", "FaultType"])["Stmt"]
          .apply(lambda stmts: sorted(set(stmts)))
          .reset_index()
    )

    # Convert statement lists into compact string
    grouped["Stmt"] = grouped["Stmt"].apply(
        lambda x: ",".join(map(str, x))
    )

    # Reorder columns
    grouped = grouped[["Variant", "Stmt", "FaultType"]]

    # Output filename
    output_file = subfolder / "symex_results.csv"

    # Save CSV
    grouped.to_csv(output_file, index=False, sep=";")

    print(f"Saved: {output_file}")

print("Done.")