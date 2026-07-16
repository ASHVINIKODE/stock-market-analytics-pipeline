"""
Configuration File
------------------
This file stores all the project settings such as:
- Folder paths
- Stock symbols
- Date range
- Database configuration
"""

from pathlib import Path

# ============================================================
# Project Paths
# ============================================================

# Root directory of the project
BASE_DIR = Path(__file__).resolve().parent.parent

# Data folders
RAW_DATA_DIR = BASE_DIR / "data" / "raw"
PROCESSED_DATA_DIR = BASE_DIR / "data" / "processed"

# ============================================================
# Stock Symbols
# ============================================================

STOCK_SYMBOLS = [
    # Technology
    "AAPL", "MSFT", "GOOG", "AMZN", "META",
    "TSLA", "NVDA", "NFLX", "ADBE", "CRM",

    # Finance
    "JPM", "BAC", "WFC", "GS", "MS",

    # Healthcare
    "JNJ", "PFE", "MRK", "ABBV", "UNH",

    # Consumer Goods
    "KO", "PEP", "PG", "MCD", "SBUX",

    # Retail
    "WMT", "COST", "HD", "LOW", "TGT",

    # Semiconductor
    "AMD", "INTC", "QCOM", "TXN", "AVGO",

    # Energy
    "XOM", "CVX", "COP", "SLB", "EOG",

    # Industrial
    "CAT", "GE", "HON", "UPS", "BA",

    # Communication
    "DIS", "VZ", "T", "CMCSA", "CHTR"
]

# ============================================================
# Date Range
# ============================================================

START_DATE = "2015-01-01"
END_DATE = "2025-01-01"

# ============================================================
# PostgreSQL Configuration
# (We'll use this later)
# ============================================================

DB_NAME = "stock_market"

DB_USER = "postgres"

DB_PASSWORD = "yourpassword"

DB_HOST = "localhost"

DB_PORT = 5432