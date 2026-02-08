import json
import os
from datetime import datetime

LOG_DIR = os.path.join(os.getcwd(), 'tmp')
LOG_PATH = os.path.join(LOG_DIR, 'debug.log')

os.makedirs(LOG_DIR, exist_ok=True)


def debug_trace(hypothesis: str, location: str, data=None):
    """Write a structured debug trace to tmp/debug.log."""
    entry = json.dumps({
        "t": datetime.now().isoformat(),
        "h": hypothesis,
        "loc": location,
        "data": data,
    }) + "\n"
    try:
        with open(LOG_PATH, "a") as f:
            f.write(entry)
    except Exception:
        pass


def debug_clear():
    """Clear the log file before a new reproduction session."""
    try:
        with open(LOG_PATH, "w") as f:
            f.write("")
    except Exception:
        pass


def debug_has_logs() -> bool:
    """Check if the log file exists and has content."""
    try:
        return os.path.exists(LOG_PATH) and os.path.getsize(LOG_PATH) > 0
    except Exception:
        return False
