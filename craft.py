#!/usr/bin/env python3
import os
import json
from hashlib import sha256
from base64 import b64encode

def read_file_return_base64ed_content(filename):
    data = ""
    with open(filename, 'r') as f:
        data = f.read()
    return b64encode(data.encode('utf-8')).decode('utf-8')

def filename_to_variable_name(filename):
    basename = os.path.basename(filename)
    return basename.replace(".", "_").upper()

def create_value_map(filepath:str):
    variable_file_content_map = {}
    files = os.listdir(filepath)
    for file in files:
        curr_file = os.path.join(filepath, file)
        if os.path.isfile(curr_file):
            variable_file_content_map[curr_file] = read_file_return_base64ed_content(curr_file)
        if os.path.isdir(curr_file):
            variable_file_content_map.update(create_value_map(curr_file) )
    return variable_file_content_map

def read_file(filename):
    with open(filename) as f:
        data = f.read()
    return data

vscode_path = ".vscode"

template_head = """#!/bin/zsh
# __        __                        __     ______   ____          _      
# \ \      / /__  __ _ _ __   ___  _ _\ \   / / ___| / ___|___   __| | ___ 
#  \ \ /\ / / _ \/ _` | '_ \ / _ \| '_ \ \ / /\___ \| |   / _ \ / _` |/ _ \\
#   \ V  V /  __/ (_| | |_) | (_) | | | \ V /  ___) | |__| (_) | (_| |  __/
#    \_/\_/ \___|\__,_| .__/ \___/|_| |_|\_/  |____/ \____\___/ \__,_|\___|
#                    |_|                                                  
#
# Author: Esonhugh <weapon_vscode@eson.ninja>
# Path: createhackenv.sh
# Usage: createhackenv <foldername>
# Description: Create a hacking project with vscode based environment

weapon_vscode () {
	echo "Creating VSCode Hack Environment"
	echo "Usage: $0 <foldername>"
	if [ -z "$1" ]
	then
		echo "No folder name given"
		return 1
	fi
	mkdir -p $1/.vscode
"""

template_body = """
    # __FILEPATH__
	echo '__VALUE__' | base64 -d > $1/__FILEPATH__
"""

template_tail = """
	echo "*" > $1/.vscode/.gitignore
    echo "!env.zsh" >> $1/.vscode/.gitignore
    echo "!metasploit_handler.rc" >> $1/.vscode/.gitignore
	echo "!msfconsole.rc" >> $1/.vscode/.gitignore
	echo "!revshell.zsh" >> $1/.vscode/.gitignore

	echo "Generate Success" "Launched VSCode"
	code $1
}

# Create Alias for weapon_vscode
alias createhackenv=weapon_vscode
alias createhack=weapon_vscode

__LAUNCH_HELPER__

# Script Hash: __HASH__
"""


def generate_bash_script():
    bash_script_content = ""

    bash_script_content += template_head
    for key, value in create_value_map(vscode_path).items():
        bash_script_content += \
            template_body. \
                replace("__KEY__", filename_to_variable_name(key)). \
                    replace("__VALUE__", value). \
                        replace("__FILEPATH__", key)
    
    bash_script_content += template_tail. \
            replace("__LAUNCH_HELPER__", read_file("launch_helper.zsh"))

    return bash_script_content


def test():
    content = read_file_return_base64ed_content("./vscode/source.zsh")
    print(content)
    dicts = create_value_map(vscode_path)
    print(json.dumps(dicts, indent=4))
    print(filename_to_variable_name("./vscode/source.zsh"))
    print(filename_to_variable_name("./vscode/source.zsh"))
    print(generate_bash_script())

def content_hash(content):
    return sha256(content.encode('utf-8')).hexdigest()

def main():
    print("reGenerating bash script")
    content =  generate_bash_script()
    content = content.replace("__HASH__", content_hash(content))
    print("Content: ")
    print(content)
    print("Writing to createhackenv.sh file")
    with open("createhackenv.sh", 'w') as f:
        f.write(content)
    print("Done")

if __name__ == "__main__":
    main()
