"""
Transform raw stock data into a cleaned and feature-engineered dataset.
"""

import pandas as pd
from config import RAW_DATA_DIR, PROCESSED_DATA_DIR


def merge_and_clean_data():

    all_data = []

    # ==========================================================
    # Read all CSV files
    # ==========================================================
    for csv_file in RAW_DATA_DIR.glob("*.csv"):

        print(f"Reading {csv_file.name}")

        df = pd.read_csv(csv_file)

        # Add Company column
        df["Company"] = csv_file.stem

        all_data.append(df)

    # ==========================================================
    # Merge all datasets
    # ==========================================================
    merged_df = pd.concat(all_data, ignore_index=True)

    print("\n========== BEFORE CLEANING ==========")
    print(merged_df.info())

    # ==========================================================
    # Data Cleaning
    # ==========================================================

    # Convert Date column
    merged_df["Date"] = pd.to_datetime(merged_df["Date"])

    # Remove duplicate rows
    merged_df.drop_duplicates(inplace=True)

    # Remove missing values
    merged_df.dropna(inplace=True)

    # Sort data by Company and Date
    merged_df.sort_values(
        by=["Company", "Date"],
        inplace=True
    )

    # Reset index
    merged_df.reset_index(drop=True, inplace=True)

    print("\n========== AFTER CLEANING ==========")
    print(merged_df.info())

    # ==========================================================
    # Feature Engineering
    # ==========================================================

    # 1. Price Change
    merged_df["Price_Change"] = (
        merged_df["Close"] - merged_df["Open"]
    )

    # 2. Daily Return (%)
    merged_df["Daily_Return"] = (
        merged_df.groupby("Company")["Close"]
                 .pct_change() * 100
    )

    # 3. Moving Average (10 Days)
    merged_df["MA10"] = (
        merged_df.groupby("Company")["Close"]
                 .transform(lambda x: x.rolling(window=10).mean())
    )

    # 4. Moving Average (30 Days)
    merged_df["MA30"] = (
        merged_df.groupby("Company")["Close"]
                 .transform(lambda x: x.rolling(window=30).mean())
    )

    # 5. Daily Range
    merged_df["Daily_Range"] = (
        merged_df["High"] - merged_df["Low"]
    )

    # 6. 10-Day Average Trading Volume
    merged_df["Volume_MA10"] = (
        merged_df.groupby("Company")["Volume"]
                 .transform(lambda x: x.rolling(window=10).mean())
    )

    # 7. 30-Day Volatility
    merged_df["Volatility_30D"] = (
        merged_df.groupby("Company")["Daily_Return"]
                 .transform(lambda x: x.rolling(window=30).std())
    )

    # 8. Cumulative Return (%)
    merged_df["Cumulative_Return"] = (
        merged_df.groupby("Company")["Close"]
                 .transform(lambda x: ((x / x.iloc[0]) - 1) * 100)
    )

    # ==========================================================
    # Save Final Dataset
    # ==========================================================

    PROCESSED_DATA_DIR.mkdir(
        parents=True,
        exist_ok=True
    )

    merged_df.to_csv(
        PROCESSED_DATA_DIR / "final_stock_data.csv",
        index=False
    )

    print("\n========== FEATURE ENGINEERING COMPLETED ==========")
    print("Final Shape :", merged_df.shape)

    print("\nColumns:")
    print(merged_df.columns.tolist())

    return merged_df


if __name__ == "__main__":
    merge_and_clean_data()