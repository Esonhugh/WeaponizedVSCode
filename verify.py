# /// script
# requires-python = ">=3.10"
# dependencies = []
# ///

from hashlib import sha256
import sys

def content_hash(content:str):
    return sha256(content.encode('utf-8')).hexdigest()

def read_file(filename):
    with open(filename, 'r') as f:
        data = f.readlines()
    return data

def regenerate_hash(filename):
    data = read_file("createhackenv.sh")
    script_hash_line = data[-1]
    # print(f"Script hash line: {script_hash_line}")
    raw_script_hash = script_hash_line.split(" ")[3].strip()
    # print(f"Script hash in Script: {raw_script_hash}")
    content = "".join(data)
    content = content.replace(raw_script_hash, "__HASH__")
    calc_script_hash = content_hash(content)
    # print(f"Script reCalc hash: {calc_script_hash}")
    # print(f"Script hash: {raw_script_hash}")
    return calc_script_hash, raw_script_hash

def verify_hash(calc_script_hash, raw_script_hash):
    print("Verifying script hash...")
    print(f"Script reCalc hash: {calc_script_hash}")
    print(f"Script hash wait for check: {raw_script_hash}")
    if calc_script_hash == raw_script_hash:
        print("Script hash is correct")
    else:
        print("Script hash is incorrect!")
        exit(114)

def main():
    if len(sys.argv) == 2 :
        regen_hash,raw_hash = regenerate_hash(sys.argv[1])
        verify_hash(regen_hash, raw_hash)
    elif len(sys.argv) == 3:
        user_hash = sys.argv[2]
        regen_hash,raw_hash = regenerate_hash(sys.argv[1])
        verify_hash(regen_hash, user_hash)
    else:
        print("Usage: python3 verify.py <filename> [<check_hash>]")
        exit(1)

if __name__ == "__main__":
    main()
