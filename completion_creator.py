# /// script
# requires-python = ">=3.10"
# dependencies = []
# ///

import os
import re
import json

env_args = {}

def processor(f_to_read, f_to_write):
    data = f_to_read.read()
    # found unique environment variables
    for line in data.splitlines():
        if "$" in line:
            matched = re.search(r'\$({)?\w+(})?', line)
            if matched:
                matched_word = matched.group(0)
                if matched_word not in env_args:
                    env_args[matched_word] = {}
                print(f"Found environment variable: {matched_word} in file: {f_to_read.name}")
                if f_to_read.name not in env_args[matched_word]:
                    env_args[matched_word][f_to_read.name] = 1
                else:
                    env_args[matched_word][f_to_read.name] += 1
        if line:
            f_to_write.write(f"{line}\n")
        
def check_env_var():
    defined_list = []
    undefined_list = []
    for env_var, files in env_args.items():
        if os.getenv(env_var.strip("${}")) is None:
            flist = []
            for f, count in files.items():
                flist.append(f"filename: {f} (used {count} times)")
            undefined_list.append(f"Environment variable {env_var} is not defined! It is used in files: {', '.join(flist)}")  
        else:
            defined_list.append(f"Environment variable {env_var} is defined with value: {os.getenv(env_var.strip('${}'))}")
    
    for line in defined_list:
        print(line)
    for line in undefined_list:
        print(line)
    
def main() -> None:
    write_file = "./zsh_history"
    f = open(write_file, "w")
    for path, dictionaries, files in os.walk("./completion_indexer"):
        if files:
            for file in files:
                print(f"Processing file: {file} in {path}")
                with open(os.path.join(path, file), "r") as f_read:
                    processor(f_read, f)
    f.close()
    print(f"All environment variables found: {json.dumps(env_args, indent=4)}")
    print("Checking if environment variabkes are defined")
    check_env_var()
    

if __name__ == "__main__":
    main()
