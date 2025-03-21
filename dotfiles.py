#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
`dotfiles` is a script to backup my dotfiles and other configuration files; it uses `rsync`
through Python `subprocess`
"""

import sys
import os
import re
import subprocess

from typing import Any
import argparse

# App version
__app_name__     : str = "dotfiles"
__author__       : str = "idealtitude"
__version__      : str = "0.1.0"
__license__      : str = "MT108"

# Constants
EXIT_SUCCESS: int = 0
EXIT_FAILURE: int = 1

BACKUPS_PATH: str = "/home/stephane/Documents/Perso/DOTFILES/BACKUPS"
BACKUPS_LIST: str = "/home/stephane/Documents/Perso/DOTFILES/files.txt"

PATHS_PTN: Any = re.compile(r"^(?P<src>[^ ]+) (?P<dest>.+)$")

def get_files_list() -> list[str] | None:
    files_list: list[str] | None = None

    if not os.path.isfile(BACKUPS_LIST):
        print(f"Error: files list not found; expected location -> {BACKUPS_LIST}")
        return None

    with open(BACKUPS_LIST) as fd:
        files_list = fd.readlines()

    files_list = [f.strip() for f in files_list]

    if len(files_list) == 0:
        print(f"Error: the files list is empty; check the content of {BACKUPS_LIST}")
        return None

    return files_list

def exec_cmd(cmd: list[str]) -> bool:
    files: list[str] | None = get_files_list()
    exec_result: bool = True

    if files is None:
        return False

    for file in files:
        if _m := re.match(PATHS_PTN, file):
            cmd[2] = _m.group("src")
            cmd[3] = os.path.join(BACKUPS_PATH, _m.group("dest"))
        else:
            cmd[2] = file

        try:
            res = subprocess.Popen(cmd, stdout=subprocess.PIPE, encoding='utf8')
            while True:
                output = res.stdout.readline()
                if output == '' and res.poll() is not None:
                    break
                if output:
                    print(output.strip())
            rc = res.poll()

            if cmd[0] == "rsync":
                print(rc)

        except subprocess.CalledProcessError as ex:
            exec_result = False
            print(f"Command failed with return code {ex.returncode}: {ex}")

    return  exec_result

# Command line arguments
def get_args() -> Any:
    """Parsing command line arguments"""
    parser: Any = argparse.ArgumentParser(
        prog=f"{__app_name__}", description="Backup ditfiles with rsync", epilog=f"Do `{__app_name__} --help` for the usage"
    )

    parser.add_argument("-d", "--diffonly", action="store_true", help="Perform a `diff` only")
    parser.add_argument(
        "-v", "--version", action="version", version=f"%(prog)s {__version__}"
    )

    return parser.parse_args()

def main() -> int:
    """Entry point, main function."""

    args: Any = get_args()

    cmd: list[str] = ["rsync", "-rvh", "nil", BACKUPS_PATH]

    if args.diffonly:
        cmd[0] = "diff"
        cmd[1] = "-q"

    execution: bool = exec_cmd(cmd)

    if not execution:
        print("One or more errors occured; exiting now")
        return EXIT_FAILURE

    print(f"\n{cmd[0]} finished succesfully!")

    return EXIT_SUCCESS

if __name__ == "__main__":
    sys.exit(main())
