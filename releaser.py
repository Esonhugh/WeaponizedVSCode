# /// script
# requires-python = ">=3.10"
# dependencies = []
# ///

template = """
# Weaponaized your VSCode

## What is this?

This is a simple script that will allow you to use VSCode as a weapon. 

It will open a new VSCode window and will open a new file with the name of the file you given. 

The `.vscode` folder will be created, and vscode will loaded settings from it.

## How to use it?

1. Download the script
2. unzip the zip file 
3. run ./installer.sh to install the weapon in to your ~/.local/weapon folder
4. use function `createhack <foldername>` with the name of the file you want to open
5. vscode will Automatically open the folder

## Script Hash

```
__VERIFY_OUTPUT__
```

## Update Log

__UPDATE_LOGS__

"""

import os
import sys

def main():
    verify_output = os.popen("python3 ./verify.py ./creathackenv.sh").read()
    with open(sys.argv[1], "r") as f: 
        log = f.read()
    update_logs = log
    print(template.replace("__VERIFY_OUTPUT__", verify_output).replace("__UPDATE_LOGS__", update_logs))
    pass

if __name__ == "__main__":
    main()
