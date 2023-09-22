#!/bin/python3

import subprocess
import json
import sys

# arbitrary values, i just wanted them to not be valid i3 workspaces
NOTHING = -2
BACKTRACKING = -1

i3_tree = subprocess.check_output(["i3-msg", "-t", "get_tree"], text=True)
i3_tree = json.loads(i3_tree)


def rec_find_workspace(tree: dict, window_name: str) -> int:
    for n in tree["nodes"]:
        if "window_properties" in n:
            if window_name.lower() in n["window_properties"]["class"].lower():
                return BACKTRACKING  # found the window, need to backtrack to its workspace parent node.

        ret_val = rec_find_workspace(n, window_name)
        if ret_val == BACKTRACKING:
            if n["type"] == "workspace":
                return n["num"]
            else:
                return BACKTRACKING
        elif ret_val != NOTHING:
            return ret_val
    return NOTHING


# either this will find a valid workspace, or it'll try with -2, which will break.
subprocess.call(["i3-msg", "workspace", "number", str(rec_find_workspace(i3_tree, sys.argv[1]))])