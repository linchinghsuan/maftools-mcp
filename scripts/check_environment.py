"""Check the recorded Python runtime without contacting package repositories."""
from pathlib import Path
import importlib.metadata as metadata
import json
import platform
import sys

def main():
    errors=[]
    if platform.python_version() != "3.11.5":
        errors.append(f"Python: expected 3.11.5, found {platform.python_version()}")
    lock=Path(__file__).resolve().parents[1]/"environment/python-requirements.lock.txt"
    for line in lock.read_text().splitlines():
        if "==" in line:
            name,version=line.split("==",1)
            try: actual=metadata.version(name)
            except metadata.PackageNotFoundError: actual="missing"
            if actual != version: errors.append(f"{name}: expected {version}, found {actual}")
    try:
        dist=metadata.distribution("fastmcp")
        record=json.loads(dist.read_text("direct_url.json") or "{}")
        commit=record.get("vcs_info",{}).get("commit_id")
        if commit != "b3bce0c2312444f50863a9887fc3d46917bd8f71":
            errors.append(f"FastMCP source commit differs: {commit}")
    except metadata.PackageNotFoundError: errors.append("fastmcp missing")
    if errors:
        print("\n".join(errors));return 1
    print("Python version, locked packages and FastMCP commit match.");return 0

if __name__ == "__main__": sys.exit(main())
