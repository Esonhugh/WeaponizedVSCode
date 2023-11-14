## Create Hacking Environment

### Usage:

```zsh
source createhackenv.sh
createhack foldername # creates foldername and sets up environment with vscode automatically
```

### What it does:

1. Creates a folder with the name you give it

2. Create a .vscode folder with all settings 

    > like `vscode setting.json` and metasploit workspace rcfile `workspace_metasploit.rc`

3. Create env.zsh for environments variables you want to set. it will auto sourced at first in `source_*.zsh` and `source.zsh`

    > e.g. `export RHOST=11.45.1.4`

4. Create `source_*.zsh` files for you to source your own scripts

    > e.g. `source_web-delivery.zsh` will be used when you use `web-delivery` mode in your new vscode terminal. 
    > 
    > and you can put your own script in it

5. Create workspace metasploit rcfile `workspace_metasploit.rc` for you to use in vscode terminal

    > e.g. `msfconsole -r workspace_metasploit.rc` 
    >
    > or
    > 
    > your can start msfconsole in new vscode terminal with `metasploit` mode

6. open up vscode with the folder you just created

7. it also will auto set the envirnoment variable of $PROJECT_FOLDER to the folder you just created, and $PROJECT_WEB_DELIVERY in the `source_web-delivery.zsh` file to the folder to delivery web files

    > so you can use it in your own scripts
    > 
    > e.g. `cd $PROJECT_FOLDER`


### what's craft.py

it's a python script to create the creathackenv.sh file for you based on current folder vscode configuration.

It will pack the config files with base64 and put it in the creathackenv.sh file.

and createhackenv.sh will decode it and put it in the right place when you create a new hacking environment.

you can customize the createhackenv.sh file by yourself, but you need to make sure the base64 string is correct.

Happy hacking. ;)
