#!/usr/bin/env python3

import sys
import shutil
import subprocess
from pathlib import Path


def validate_args() -> tuple[str, Path]:
    """Validate command line arguments: Qt version (5 or 6) and output directory."""
    if len(sys.argv) != 3:
        sys.exit(1)

    qt_version = sys.argv[1]
    if qt_version not in ["5", "6"]:
        sys.exit(1)

    return qt_version, Path(sys.argv[2])


def check_aqt_installed() -> None:
    """Verify that the aqt (Qt installer) tool is available in PATH."""
    result = subprocess.run(["command", "-v", "aqt"], shell=True, capture_output=True)
    if result.returncode != 0:
        sys.exit(1)


def build_install_command(qt_version: str, output_dir: Path) -> tuple[list[str], str]:
    """Build the aqt install command based on Qt version.

    Qt 5.15.0: Install all modules (aqt ignores -m flag for Qt 5)
    Qt 6.8.0: Install only specific modules needed for compilation testing
    """
    if qt_version == "5":
        version_string = "5.15.0"
        cmd = ["aqt", "install-qt", "linux", "desktop", version_string, "-O", str(output_dir)]
    else:  # qt_version == "6"
        version_string = "6.8.0"
        modules = ["qtlocation", "qtmultimedia", "qtpositioning", "qtsensors", "qtserialbus", "qtserialport"]
        cmd = ["aqt", "install-qt", "linux", "desktop", version_string, "-O", str(output_dir), "-m"] + modules

    return cmd, version_string


def install_qt(cmd: list[str]) -> None:
    """Execute the Qt installation command."""
    subprocess.run(cmd, check=True)


def verify_installation(output_dir: Path, version_string: str) -> Path:
    """Verify that Qt was installed successfully by checking for the gcc_64 directory."""
    qt_dir = output_dir / version_string / "gcc_64"
    if not qt_dir.exists():
        sys.exit(1)
    return qt_dir


def cleanup_directories(qt_dir: Path) -> None:
    """Remove unnecessary documentation and example directories to reduce image size."""
    unneeded_dirs = ["doc", "examples", "translations", "tests", "phrasebooks"]
    for item in unneeded_dirs:
        path = qt_dir / item
        if path.exists():
            shutil.rmtree(path)


def cleanup_executables(qt_dir: Path, qt_version: str) -> None:
    """Remove unnecessary executables, keeping only those needed for CI compilation testing.

    Qt 5 keeps: qmake, qtdiag, qtpaths, qt.conf
    Qt 6 keeps: qmake6, qt-cmake, qt-cmake-create, qtdiag6, qtpaths6, qt.conf
    """
    if qt_version == "5":
        keep_executables = {"qmake", "qtdiag", "qtpaths", "qt.conf"}
    else:  # qt_version == "6"
        keep_executables = {"qmake6", "qt-cmake", "qt-cmake-create", "qtdiag6", "qtpaths6", "qt.conf"}

    bin_dir = qt_dir / "bin"
    if bin_dir.exists():
        for item in bin_dir.iterdir():
            if item.is_file() and item.name not in keep_executables:
                item.unlink()


def cleanup_tools(output_dir: Path) -> None:
    """Remove the Tools directory (contains Conan package manager, not needed for this image)."""
    tools_dir = output_dir / "Tools"
    if tools_dir.exists():
        shutil.rmtree(tools_dir)


def main() -> None:
    """Main workflow: validate, install, verify, and cleanup Qt."""
    qt_version, output_dir = validate_args()
    check_aqt_installed()

    # Install Qt
    cmd, version_string = build_install_command(qt_version, output_dir)
    install_qt(cmd)

    # Verify and cleanup
    qt_dir = verify_installation(output_dir, version_string)
    cleanup_directories(qt_dir)
    cleanup_executables(qt_dir, qt_version)
    cleanup_tools(output_dir)


if __name__ == "__main__":
    main()
