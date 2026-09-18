#!/usr/bin/env python3
import json
import subprocess
import sys
import time


def log(event: str, **details: object) -> None:
    print(json.dumps({"event": event, **details}), flush=True)


def main() -> int:
    command = ["dbt", "build", "--full-refresh"]
    started = time.monotonic()
    log("pipeline_started", command=" ".join(command))
    result = subprocess.run(command, check=False)
    elapsed = round(time.monotonic() - started, 2)
    log(
        "pipeline_completed" if result.returncode == 0 else "pipeline_failed",
        elapsed_seconds=elapsed,
        exit_code=result.returncode,
    )
    return result.returncode


if __name__ == "__main__":
    sys.exit(main())

