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

3. Create `env.zsh` for environments variables you want to set. it will be sourced at first line in `source_*.zsh` and `source.zsh`.

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

8. Create a new terminal in vscode and choose different one.

    > `zsh-shell` will create a new zsh shell with sourcing `source.zsh` file
    > 
    > `metasploit` will launch up a new msfconsole with the workspace_metasploit.rc file and it based on `source source_metasploit.zsh` file
    >
    > `web-delivery` will cd into the $PROJECT_WEB_DELIVERY folder and start a python http server for you to delivery web files. It based on `source source_web-delivery.zsh` file. 
    >   > you can use pdteam's simplehttpserver to replace it.
    >
    > `kali-orbstack` will launch orbstack virtual machine - kalilinx, source `source _kali-orbstack.zsh` and process env variables in `env.zsh` file inside env.
    > 
    >   > you can easily inject environment variables into the kali vm with this mode. and reuse command outside.
    >   > 
    >   > like `evil-winrm -i $RHOST -u $RUSER -p $RPASS` will work in kali vm and host machine. and you just need set the env variables in `env.zsh` file once.

### Supported Platfrom 

linux/macos (windows is completely different)

### Requirements

1. zsh
2. vscode
3. python3 \[Optional\]
4. metasploit \[Optional\]
5. esonhugh/sss \[Optional\] - shell script snippets

### problem this project try to solve

1. different enviroment in different hacking project - content switching

    > such as, you play #hackthebox machine and #tryhackme machine at the same time, and you have to switch the different environment for them.
    > 
    > you will cost a lot time on switching the environment, and you will forget to switch the environment sometimes although you have a note for it.

2. enviroments collections. put things about projects together. - save and clean

    > such as, you have a #hackthebox machine and you put all the tools together in a arsenal
    > 
    > Now you need craft some payload and delivery it to the target machine
    > 
    > before: you need to switch the environment to the arsenal folder , compile payloads and start a server(maybe http server or jndi server) to delivery the payload
    > 
    > that compile will make the arsenal folder dirty, and you need to clean it up before you commit it to git
    > 
    > and what you compile is useless for other projects which also need this payload
    >
    > if you want copy the payload back to the project folder, you need to find the project folder again and copy the path.
    >
    > now: you can create $PROJECT_WEB_DELIVERY for the payload and delivery it to the target machine, and you can easliy move the payload to $PROJECT_WEB_DELIVERY and delivery it to the target machine. also you save the payload for this project and you can use it again and keep the arsenal folder clean.

3. customized metaspoit rcfile for different projects

    > such as, you have a #hackthebox machine and you want create a handler fastly. when your machine is resetting and recover the reverse shell again.
    > 
    > now: you can edit the rcfile for project and use it in vscode terminal with `metasploit` mode. send trigger again and get the shell.

4. taking notes, log/save credentials, download files from remote machine 

    it works well with vscode. so you can use some vscode extensions and vscode features to do sth.

    like ssh with vscode or port fortwarding with vscode

    > such as, you have a #hackthebox machine and you want to save the credentials you found in the machine.
    > 
    > now: you can create a file named `cred` and save the credentials in it. `user` folder to save context with getting foothold and to user. `root` folder to save context with getting root.
    > 

5. more feature ...


### what's craft.py

it's a python script to create the creathackenv.sh file for you based on current folder vscode configuration.

It will pack the config files with base64 and put it in the creathackenv.sh file.

and createhackenv.sh will decode it and put it in the right place when you create a new hacking environment.

you can customize the createhackenv.sh file by yourself, but you need to make sure the base64 string is correct.

Happy hacking. ;)
