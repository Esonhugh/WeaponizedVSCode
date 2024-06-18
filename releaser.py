template = """
# Weaponaized your VSCode

## What is this?

This is a simple script that will allow you to use VSCode as a weapon. 

It will open a new VSCode window and will open a new file with the name of the file you given. 

The `.vscode` folder will be created, and vscode will loaded settings from it.

## How to use it?

1. Download the script
2. source it 
3. use function `createhack <foldername>` with the name of the file you want to open
4. vscode will Automatically open the folder

## Script Hash

```
__VERIFY_OUTPUT__
```

## Update Log

__UPDATE_LOGS__

"""

import os

def main():
    verify_output = os.popen("python3 ./verify.py ./creathackenv.sh").read()
    update_logs = os.popen("bash ./gitcmd.sh").read()
    print(template.replace("__VERIFY_OUTPUT__", verify_output).replace("__UPDATE_LOGS__", update_logs))
    pass

if __name__ == "__main__":
    main()