#!/usr/bin/env python3

import sys
import shutil
import subprocess
from pathlib import Path

def main():
    if len(sys.argv) != 3:
        sys.exit(1)

    qt_version = sys.argv[1]
    output_dir = Path(sys.argv[2])

    # Validate Qt version
    if qt_version not in ["5", "6"]:
        sys.exit(1)

    # Check aqt exists
    result = subprocess.run(["command", "-v", "aqt"], shell=True, capture_output=True)
    if result.returncode != 0:
        sys.exit(1)

    # Set version strings and modules
    if qt_version == "5":
        version_string = "5.15.0"
        cmd = ["aqt", "install-qt", "linux", "desktop", version_string, "-O", str(output_dir)]
    else:
        version_string = "6.8.0"
        modules = ["qtlocation", "qtmultimedia", "qtpositioning", "qtsensors", "qtserialbus", "qtserialport"]
        cmd = ["aqt", "install-qt", "linux", "desktop", version_string, "-O", str(output_dir), "-m"] + modules

    # Install Qt
    subprocess.run(cmd, check=True)

    # Verify installation
    qt_dir = output_dir / version_string / "gcc_64"
    if not qt_dir.exists():
        sys.exit(1)

    # Cleanup unnecessary files
    for item in ["doc", "examples", "translations", "tests", "phrasebooks"]:
        path = qt_dir / item
        if path.exists():
            shutil.rmtree(path)

    # Remove unneeded executables
    if qt_version == "5":
        keep_executables = {
            "qmake", "qtdiag", "qtpaths", "qt.conf"
        }
    else:  # qt_version == "6"
        keep_executables = {
            "qmake6", "qt-cmake", "qt-cmake-create", "qtdiag6", "qtpaths6", "qt.conf"
        }

    bin_dir = qt_dir / "bin"
    if bin_dir.exists():
        for item in bin_dir.iterdir():
            if item.is_file() and item.name not in keep_executables:
                item.unlink()

    # Remove Tools directory
    tools_dir = output_dir / "Tools"
    if tools_dir.exists():
        shutil.rmtree(tools_dir)

if __name__ == "__main__":
    main()
