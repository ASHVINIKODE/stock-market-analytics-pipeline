"""
Load transformed stock data into PostgreSQL.
"""

import pandas as pd
from sqlalchemy import create_engine

from config import (
    DB_NAME,
    DB_USER,
    DB_PASSWORD,
    DB_HOST,
    DB_PORT,
    PROCESSED_DATA_DIR,
)


def load_to_postgres():

    # Read final dataset
    df = pd.read_csv(
        PROCESSED_DATA_DIR / "final_stock_data.csv"
    )

    # ==========================================
    # Rename columns to snake_case
    # ==========================================
    df.columns = [
        "date",
        "adj_close",
        "close",
        "high",
        "low",
        "open",
        "volume",
        "company",
        "price_change",
        "daily_return",
        "ma10",
        "ma30",
        "daily_range",
        "volume_ma10",
        "volatility_30d",
        "cumulative_return"
    ]

    # ==========================================
    # PostgreSQL Connection
    # ==========================================
    engine = create_engine(
        f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    )

    # ==========================================
    # Load data into PostgreSQL
    # ==========================================
    df.to_sql(
        name="stock_data",
        con=engine,
        if_exists="replace",
        index=False
    )

    print("Data loaded successfully into PostgreSQL!")
    print(f"Total Rows Loaded : {len(df)}")
    print(f"Total Columns : {len(df.columns)}")


if __name__ == "__main__":
    load_to_postgres()