## Customization

### What is the project doing?

1. Creates a folder with the name you give it

2. Create a .vscode folder with all settings and zsh files

    > like `vscode setting.json tasks.json` and metasploit workspace rcfile `workspace_metasploit.rc`

3. Check [LaunchOrder.md](./LaunchOrder.md) for the launch order of zsh files and it will explain how they works.

### How to customize it?

#### in disk temporary

1. directly edit the folder you created via createhackenv.sh 

2. edit any files under .vscode

3. and it will auto enabled in vscode

#### create your own template

1. fork this repo

2. edit/update/add/delete the files under `.vscode` folder

3. before your commit, use `craft.py` to generate the new `createhackenv.sh` file

    > `python3 craft.py` will generate `createhackenv.sh` file

    > what is craft.py?
    >
    > it's a python script to create the creathackenv.sh file for you based on current folder vscode configuration.
    >
    > It will pack the config files with base64 and put it in the creathackenv.sh file.
    >
    > and createhackenv.sh will decode it and put it in the right place when you create a new hacking environment.
    >
    > you can customize the createhackenv.sh file by yourself, but you need to make sure the base64 string is correct.


4. add everything and commit, push to your own repo


### Explain for current files

- `settings.json` and `tasks.json` for vscode settings

    it is entry point for vscode to load settings and tasks for the project, just like index.

    and the detail commands will loadded in other zsh files.

    > `settings.json` defines the terminal modes in vscode 
    >
    > `tasks.json` defines commands which will run just once.
    >
    > current task is msfvenom payload fast generate task.
    > 
    > `extension.json` defines the extension you'd better to install in vscode.
    >
    > it extends vscode with other strong features like code analysis, code completion, etc.

- `env.zsh` for environments variables you want to set. it should be sourced `source*.zsh`. (recommended to source it in every .zsh file under .vscode folder)

    > e.g. `export RHOST=11.45.1.4`
    >
    > it also will auto set the envirnoment variable of $PROJECT_FOLDER to the folder you just created 
    > 
    > you can reuse like 
    > 
    > e.g. `cd $PROJECT_FOLDER` switch the pwd back to the project
    >

- `source.zsh` file will control the zsh shell behavior in vscode terminal with mode

    > e.g. `source.zsh` will be used when you set env varoiable `WEB_DELIVERY_MODE` in your new vscode terminal. 
    > 
    > you will launched a new zsh shell and execute the WEB_DELIVERY_MODE command in the block

    > `meterpreter-handler` will launch up a new msfconsole with the metasploit rcfile 
    > this terminal will called with msfconsole command in `source source_metasploit.zsh` file
    >
    > `netcat-handler` if you prefer netcat or pwncat-cs to handle reverse shell, you can use this mode terminal
    >
    > `web-delivery` will cd into the $PROJECT_WEB_DELIVERY folder and start a python http server for you to delivery web files. It based on `source source_web-delivery.zsh` file. 
    >   > you can use pdteam's simplehttpserver to replace it.
    >

- `kali-orbstack` file will launch orbstack virtual machine - kalilinx, source `source_kali-orbstack.zsh` and process env variables in `env.zsh` file inside env. it will also control the zsh behavior but in kali vm.

    >   > you can easily inject environment variables into the kali vm with this mode. and reuse command outside.
    >   > 
    >   > like `evil-winrm -i $RHOST -u $RUSER -p $RPASS` will work in kali vm and host machine. and you just need set the env variables in `env.zsh` file once.

- metasploit rcfile `metasploit_handler.rc` for you to use in vscode terminal (meterpreter-handler mode)

    > it launched as `msfconsole -r this.rc`
    >
    > you can use it to set up your own meterpreter handler with custom options / operations
    >
    > like use multi/handler set payloads lhost lport etc and run as job in background

### Warning

1. env.zsh and source_*.zsh will load before zshrc
