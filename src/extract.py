"""
Extract historical stock market data from Yahoo Finance
and save it as CSV files.
"""

import yfinance as yf
from config import STOCK_SYMBOLS, START_DATE, END_DATE, RAW_DATA_DIR


def download_stock_data():

    # Create the raw folder if it doesn't exist
    RAW_DATA_DIR.mkdir(parents=True, exist_ok=True)

    for stock in STOCK_SYMBOLS:

        print(f"Downloading {stock}...")

        # Download data
        df = yf.download(
            stock,
            start=START_DATE,
            end=END_DATE,
            progress=False,
            auto_adjust=False
        )

        # Convert Date index into a normal column
        df.reset_index(inplace=True)

        # Flatten columns if MultiIndex exists
        if hasattr(df.columns, "levels"):
            df.columns = df.columns.get_level_values(0)

        # Skip if no data
        if df.empty:
            print(f"No data found for {stock}")
            continue

        # Save CSV
        output_file = RAW_DATA_DIR / f"{stock}.csv"
        df.to_csv(output_file, index=False)

        print(f"Saved -> {output_file}")


if __name__ == "__main__":
    download_stock_data()