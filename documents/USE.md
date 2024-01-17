## Usage 

### Supported Platfrom 

linux/macos (windows is completely different)

### Requirements

1. zsh
2. vscode
3. python3 
4. metasploit 
5. esonhugh/sss \[Optional\] - shell script snippets

### install 

1. Copy and download file `createhackenv.sh` to your environment 

> no other files needed only `createhackenv.sh`

2. Source it directly or add it to your `.zshrc` file

```zsh
source createhackenv.sh

# Optional
# Create alias for createhack

alias weaponize-vsc=createhack
```

3. Create a templated hacking project folder with it

```zsh
createhack foldername # creates foldername and sets up environment with vscode automatically
```

4. and it will launched up vscode with the folder you just created automatically