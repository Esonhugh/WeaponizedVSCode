source ${PROJECT_FOLDER}/.vscode/env.zsh

if [ "$WEB_DELIVERY_MODE" ]; then
    if [ -z "$PROJECT_WEB_DELIVERY" ]; then
        echo "PROJECT_WEB_DELIVERY is not set. Please set it in .vscode/env.zsh"
    else 
        if [ -d "$PROJECT_WEB_DELIVERY" ]; then
            echo "FOLDER $PROJECT_WEB_DELIVERY exists."
        else
            mkdir -p $PROJECT_WEB_DELIVERY
            echo "*" > $PROJECT_WEB_DELIVERY/.gitignore
            echo "FOLDER $PROJECT_WEB_DELIVERY created."
        fi
    fi
    cd $PROJECT_WEB_DELIVERY
    python3 -m http.server 8890
    exit 0
fi 

if [ "$METASPLOIT_HANDLER_MODE" ]; then
    msfconsole -r "$PROJECT_FOLDER/.vscode/metasploit_handler.rc"
    exit 0
fi

if [ "$METASPLOIT_CONSOLE_MODE" ]; then 
    msfconsole -r "$PROJECT_FOLDER/.vscode/msfconsole.rc"
    exit 0
fi

if [ "$REVERSE_SHELL_MODE" ]; then
    rlwrap -I -cAr nc -lvvp ${LPORT}
    exit 0
fi


exec zsh -i  # must be there. otherwise, the terminal will close immediately.
