# ENV settings for the project
################################################################
# Project settings for Zsh Prompt
# export HOST="[HackTheBox - Machine Name]"
unset USER_ZDOTDIR

################################################################
# Self condition settings
# use this if you are using a VPS or cloud server it can automatically get your public IP.
# export LHOST=`curl ifconfig.me`
# export LHOST=`curl ip.me`
export LHOST=${$(ifconfig | grep '10\.10\.' | cut -d ' ' -f2):-10.0.0.1}
export ATTACKER_IP=$LHOST

export LPORT=6789

################################################################
# Target settings
# export RHOST=10.10.X.X
# works well on HTB and THM, Put your reverse IP here.
# export DOMAIN=

# export TARGET=${DOMAIN:-${RHOST}} # target is target hostname if not set use RHOST ip

# export IP=${RHOST}            # alias rhost
# export ip=${IP}               # alias as IP
# export DC_IP=${RHOST}         # alias rhost
# export DC_HOST=dc01.${DOMAIN} # domain controller host, if not set use dc01.domain.com

function cut_lines_from_markdown_codes() {
        local file_path=$1
        if [[ ! -f $file_path ]]; then
                echo "no such file!"
                return 1
        fi
        local identity='```'$2
        local line=$(grep -n -E '^```' "$file_path" | grep "$identity" -A1 | cut -d : -f1)
        local line_no_list=$(echo "$line" | awk 'NR%2==1{T=$0;next}{print T "|" $0}')
        for line_no in $(echo $line_no_list); do
                local line_no_start=$(echo $line_no | cut -d "|" -f 1)
                local line_no_end=$(echo $line_no | cut -d "|" -f 2)
                local line_start=$(($line_no_start + 1))
                if [[ "$line_no_end" == "$line_start" ]]; then # if the next line is the same as the start line, then it is empty
                        echo ""
                        return
                fi
                local line_end=$(($line_no_end - 1))
                if [[ "$line_start" == "1" && "$line_end" == "-1" ]]; then
                        return 1
                fi
                sed -n "${line_start},${line_end}p" "$file_path"
        done
}

function safe_name() {
        local name=$1
        if [[ -z $name ]]; then
                echo "Usage: safe_name <name>"
                return 1
        fi
        echo "$name" | tr '@$.- [](){}!#' '_' # replace . and - with _ to avoid env var issues
}

function update_host_to_env() {
        if [[ -x "$(command -v yq)" && -d "${PROJECT_FOLDER}/hosts" ]]; then
                for ur in ${(@f)"$(ls -1 ${PROJECT_FOLDER}/hosts)"}; do
                        local file="${PROJECT_FOLDER}/hosts/${ur}/${ur}.md"
                        if [ -f "$file" ]; then
                                local host_data=$(cut_lines_from_markdown_codes "$file" "yaml host")

                                local hostname=$(echo "$host_data" | yq '.[0].hostname' -r)
                                local _var=$(safe_name "$hostname" ) # replace . and - with _ to avoid env var issues

                                local ip=$(echo "$host_data" | yq '.[0].ip' -r)
                                local is_dc=$(echo "$host_data" | yq '.[0].is_dc' -r)
                                if [[ "$is_dc" == "true" ]]; then
                                        export DC_HOST_${_var}=$(echo "$host_data" | yq '.[0].alias.[0]')
                                        export DC_HOST=$(echo "$host_data" | yq '.[0].alias.[0]') # default dc01.domain.com
                                        export DC_IP_${_var}=$ip
                                        export DC_IP=${ip}
                                        export IS_DC_${_var}="true"
                                fi
                                local count=1
                                for alias in $(echo "$host_data"|yq '.[0].alias.[]' -r ); do
                                        export HOST_ALIAS_${_var}_${count}=$alias # replace . and - with _ to avoid env var issues
                                        count=$((count + 1))
                                done
                                export HOST_${_var}=$hostname
                                export IP_${_var}=$ip
                        fi
                done
        fi
}
update_host_to_env

function set_current_host() {
        if [[ -z $1 ]]; then
                echo "current host is set to ${CURRENT_HOST}"
                echo "Usage: set_current_host <hostname>"
                echo "Example: set_current_host dc01"
                echo "supported hosts: "
                echo ""
                env | egrep '^HOST_' | sed -e 's/HOST_//g' | awk '{printf "- " $1 "\n"}' | sed -e 's/=/: /g' | sort
                return 1
        fi

        export CURRENT_HOST=$(safe_name "$1") # replace . and - with _ to avoid env var issues
        export CURRENT_IP=$(eval echo '$IP_'$CURRENT_HOST)         # alias for IP_dc01 or IP_dc02
        export CURRENT_HOSTNAME=$(eval echo '$HOST_'$CURRENT_HOST) # alias for HOST_dc01 or HOST_dc02

        # defined variables if u need
        export RHOST=${CURRENT_IP}
        export IP=${CURRENT_IP}
        export DOMAIN=${CURRENT_HOSTNAME} # alias for DOMAIN_dc01 or DOMAIN_dc02
        export TARGET=${DOMAIN:-${RHOST}} # target is target hostname if not set use RHOST ip
        if [[ "$(eval echo '$IS_DC_'$CURRENT_HOST)" == "true" ]]; then
                export DC_IP=$(eval echo '$DC_IP_'$CURRENT_HOST)     # alias for DC_IP_dc01 or DC_IP_dc02
                export DC_HOST=$(eval echo '$DC_HOST_'$CURRENT_HOST) # alias for DC_HOST_dc01 or DC_HOST_dc02
        fi
}
# set_current_host xx.htb

# auto set the data in the
function update_user_cred_to_env() {
        if [[ -x "$(command -v yq)" && -d "${PROJECT_FOLDER}/users" ]]; then
                for ur in ${(@f)"$(ls -1 ${PROJECT_FOLDER}/users)"}; do
                        local file="${PROJECT_FOLDER}/users/${ur}/${ur}.md"
                        if [ -f "$file" ]; then
                                local usercred=$(cut_lines_from_markdown_codes "$file" "yaml credentials")
                                
                                local user=$(echo "$usercred" | yq '.[0].user' -r)
                                local _var=$(safe_name "$user") # replace . and - with _ to avoid env var issues
                                local pass=$(echo "$usercred" | yq '.[0].password' -r)
                                local nt_hash=$(echo "$usercred" | yq '.[0].nt_hash' -r)
                                local login=$(echo "$usercred" | yq '.[0].login' -r)
                                export LOGIN_${_var}=$login
                                export USER_${_var}=$user
                                export PASS_${_var}=$pass
                                export NT_HASH_${_var}=$nt_hash
                        fi
                done
        fi
}
update_user_cred_to_env

function set_current_user() {
        if [[ -z $1 ]]; then
                echo "current user is set to ${CURRENT}"
                echo "Usage: set_current_user <A|B|username>"
                echo "Example: set_current_user A"
                echo "supported users: "
                echo ""
                env | egrep '^USER_' | sed -e 's/USER_//g' | awk '{printf "- " $1 "\n"}' | sed -e 's/=/: /g' | sort
                return 1
        fi
        export CURRENT=$(safe_name "$1" ) # replace . and - with _ to avoid env var issues
        export CURRENT_USER=$(eval echo '$USER_'$CURRENT)       # alias for USER_A or USER_B
        export CURRENT_PASS=$(eval echo '$PASS_'$CURRENT)       # alias for PASS_A or PASS_B
        export CURRENT_NT_HASH=$(eval echo '$NT_HASH_'$CURRENT) # alias for NT_HASH_A or NT_HASH_B
        export CURRENT_LOGIN=$(eval echo '$LOGIN_'$CURRENT) # alias for LOGIN_A or LOGIN_B
        
        # defined variables if u need
        export USER=${CURRENT_USER}
        export USERNAME=${CURRENT_USER}
        export PASS=${CURRENT_PASS}
        export PASSWORD=${CURRENT_PASS}   # alias for PASS
        export NT_HASH=${CURRENT_NT_HASH} # alias for NT_HASH_A
        export LOGIN=${CURRENT_LOGIN}     # alias for LOGIN_A
}
# set_current_user 

### auto invoke the commands in markdown files
function auto_invoker() {
        for markdown in ${(@f)"$(find ${PROJECT_FOLDER}/{users,hosts,services} -iname "*.md" 2>/dev/null)"}; do # list all markdown files in users, hosts, services
                local auto_invoker=$(cut_lines_from_markdown_codes "$markdown" "zsh env-invoked")
                if [[ -n "$auto_invoker" ]]; then
                        source <(echo "$auto_invoker") # source it!
                fi
        done
}
auto_invoker

function current_status() {
        if [[ -z $CURRENT_RHOST ]]; then
                echo "No current host set."
        else
                echo "Current Host: ${TARGET} => ${DOMAIN} (${RHOST}) ${DC_HOST} ${DC_IP}"
        fi
        if [[ -z $CURRENT_USER ]]; then
                echo "No current user set."
        else
                echo "Current User: ${USER} => ${USER}:${PASS} (${NT_HASH})"
        fi
}
if [[ ! -z "$SHOW_CURRENT_STATUS" ]]; then
        current_status
fi

# export KRB5CCNAME=

# export LD_PRELOAD=/usr/local/lib/libfaketime.so.1
# export LD_PRELOAD=/usr/lib/aarch64-linux-gnu/faketime/libfaketime.so.1
# export DYLD_FORCE_FLAT_NAMESPACE=1 DYLD_INSERT_LIBRARIES=/opt/homebrew/Cellar/libfaketime/0.9.10/lib/faketime/libfaketime.1.dylib
# export FAKETIME="-8h"

export METASPLOIT_INIT_COMMAND=""

export PROJECT_WEB_DELIVERY=$PROJECT_FOLDER/.web-delivery # web-delivery is a folder in PROJECT_FOLDER
unset SSS_LOADED                                          # make sure sss init shell is not set

################################################################
# Network settings clean up and reset
unset https_proxy http_proxy all_proxy
# export http_proxy=
# export https_proxy=
# export all_proxy=

################################################################
# Hashcat settings

# useful settings like ROCKYOU, SECLIST, etc.
export WORDLIST=${WORDLIST:-/usr/share/wordlists}
export ROCKYOU=${WORDLIST}/rockyou.txt
export SECLIST=${WORDLIST}/seclists/
export TOP_DNS=${SECLIST}/Discovery/DNS/bitquark-subdomains-top100000.txt

export HASHCAT_MODE_WORDLIST=0
export HASHCAT_MODE_COMBINATION=1
export HASHCAT_MODE_TOGGLE_CASE=2
export HASHCAT_MODE_MASK_BRUTE_FORCE=3
export HASHCAT_MODE_WORDLIST_MASK=6
export HASHCAT_MODE_MASK_WORDLIST=7

export HASHCAT_DEVICE_CPU=1
export HASHCAT_DEVICE_GPU=2
export HASHCAT_DEVICE_FPGA=3

# URL: https://hashcat.net/wiki/doku.php?id=example_hashes
export HASH_MD5=0
export HASH_SHA1=100
export HASH_MD5CYPT=500
export HASH_MD4=900
export HASH_NTLM=1000
export HASH_SHA256=1400
export HASH_APRMD5=1600
export HASH_SHA512=1800
export HASH_BCRYPT=3200
export HASH_NETNTLMv2=5600
export HASH_SHA256CRYPT=7400
export HASH_KRB5_PA_23=7500
export HASH_KRB5_PA_17=19800
export HASH_KRB5_PA_18=19900
export HASH_DJANGO_PBKDF2_SHA256=10000
export HASH_PBKDF2_HMAC_SHA256=10900
export HASH_KRB5_TGS_23=13100
export HASH_KRB5_TGS_17=19600
export HASH_KRB5_TGS_18=19700
export HASH_JWT=16500
export HASH_KRB5_AS_REP_23=18200

# utils functions

### functions
function proxys() {
        export Proxy="127.0.0.1" # define as your favour
        export ProxyPort="7890"  # define as your favour
        case "$1" in
        h)
                echo "|==============================================|"
                echo "|                proxys Usage                  |"
                echo "|         ---- fast commandline proxy switcher |"
                echo "|==============================================|"
                echo "| Basic Usage: proxys [SubCommand] [param1]    |"
                echo "|==============================================|"
                echo "|                Sub Command List              |"
                echo "|==============================================|"
                echo "| proxy [proxy_ip]          import ip temply   |"
                echo "| port [port_id]            import port temply |"
                echo "| loc                       import localhost   |"
                echo "| set [protocol]://[proxy_ip]:[port] set proxy |"
                echo "| on                        up the cli proxy   |"
                echo "| off                       down the proxy     |"
                echo "| *                         show proxy setting |"
                echo "| h/help                    show help          |"
                echo "|==============================================|"
                ;;
        set)
                if [ -z "$2" ]; then
                        echo "Usage: $0 set [protocol]://[proxy_ip]:[port]"
                        echo "Example: $0 set http://127.0.0.1:8080"
                else
                        export http_proxy="$2" \
                                https_proxy="$2" \
                                all_proxy="$2" &&
                                echo "export Proxy complete" && $0 show
                fi
                ;;
        proxy)
                export Proxy="$2"
                ;;
        port)
                export ProxyPort="$2"
                ;;
        loc)
                export Proxy="127.0.0.1" # define as your favour
                export ProxyPort="7890"  # define as your favour
                $0 on
                ;;
        on)
                export https_proxy=http://$Proxy:$ProxyPort \
                        http_proxy=http://$Proxy:$ProxyPort &&
                        echo 'export Proxy complete' && $0 show
                ;;
        off)
                unset https_proxy http_proxy all_proxy && echo 'unset Proxy complete'
                ;;
        help)
                proxys h
                ;;
        *)
                echo "Current Proxy Condition like ...."
                export | grep proxy
                echo "if you can't see any output like 'XX_PROXY=' there"
                echo "That means no proxy is set"
                ;;
        esac
}

function venv-init() {
        python3 -m venv venv
}

function venv-activate() {
        if [ -d "./venv/" ]; then
                source "./venv/bin/activate"
        else
                echo "No Python venv there. Error"
        fi
}

function goproxy() {
        case "$1" in
        on) export GOPROXY=https://goproxy.io,direct ;;
        off) unset GOPROXY ;;
        *) $0 on/off ;;
        esac
}

function url() {
        case "$1" in
        h | -h | help | --help)
                which $0
                ;;
        decode | d | -d | --decode) if [ -z "$2" ]; then
                \python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));"
        else
                \python3 -c "import sys; from urllib.parse import unquote; print(unquote(' '.join(sys.argv[2:])));" "$@"
        fi ;;
        encode | e | -e | --encode) if [ -z "$2" ]; then
                \python3 -c "import sys; from urllib.parse import quote; print(quote(sys.stdin.read()[:-1]));"
        else
                \python3 -c "import sys; from urllib.parse import quote; print(quote(' '.join(sys.argv[2:])));" "$@"
        fi ;;
        esac
}

# Here is mode if-tree complete, Now will launch the shell
# export SUBDOMAIN_WORDLIST=$SECLIST/Discovery/DNS/bitquark-subdomains-top100000.txt
# pipx install wfuzz
# alias wfuzz=docker run --rm --name wfuzz -v /usr/share/wordlists:/wordlists/ -it ghcr.io/xmendez/wfuzz wfuzz
# usage: alias wfuzz_http_vhost='wfuzz -c -w $SUBDOMAIN_WORDLIST -H "Host: FUZZ.$host" -u "http://$host"'
# usage: alias wfuzz_https_vhost='wfuzz -c -w $SUBDOMAIN_WORDLIST -H "Host: FUZZ.$host" -u "https://$host"'
alias wfuzz=\wfuzz
# unset -f wfuzz_vhost_http
function wfuzz_vhost_http() {
        local host=$1
        local wordlist=$2
        if [[ -z $wordlist ]] || [[ -z $host ]]; then
                echo "Usage: wfuzz_vhost <host> <wordlist> [wfuzz options]"
                return
        fi
        wfuzz -c -w $wordlist -H "Host: FUZZ.$host" -u "http://$host" $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 $16 $17 $18 $19
}

# unset -f wfuzz_vhost_https
function wfuzz_vhost_https() {
        local host=$1
        local wordlist=$2
        if [[ -z $wordlist ]] || [[ -z $host ]]; then
                echo "Usage: wfuzz_vhost <host> <wordlist> [wfuzz options]"
                return
        fi
        wfuzz -c -w $wordlist -H "Host: FUZZ.$host" -u "https://$host" $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 $16 $17 $18 $19
}

function ntlm() {
        if [ -n "$1" ]; then
                python3 -c 'import hashlib,binascii;hash = hashlib.new("md4", "'$1'".encode("utf-16le")).digest();print(binascii.hexlify(hash).decode("utf-8"))'
                if [[ $? -ne 0 ]]; then
                        echo "Error: ntlm hash generation failed. "
                        echo "if not support md4 hash, please check your openssl config."
                        return 1
                fi
        else
                echo "usage: $0 password"
        fi
}

function dump_hosts() {
        for host in $(env|grep -E '^HOST_'|grep -v 'HOST_ALIAS'); do
                local _var=$(echo $host|sed -e 's/HOST_//g' | cut -d '=' -f1) # replace _ with - to get the original hostname
                local _ip=$(eval echo '$IP_'$_var)
                local _hostname=$(eval echo '$HOST_'$_var)
                local aliases=$(env | grep -E "^HOST_ALIAS_${_var}_" |cut -d '=' -f2 | tr '\n' ' ')
                echo "${_ip} ${_hostname} ${aliases}"
        done
}

function dump_users() {
        echo "dumping impacket format for users:"
        for user in $(env|grep -E '^USER_'|grep -v 'USER_ALIAS'); do
                local _var=$(echo $user|sed -e 's/USER_//g' | cut -d '=' -f1) # replace _ with - to get the original username
                local _user=$(eval echo '$USER_'$_var)
                local _pass=$(eval echo '$PASS_'$_var)
                local _nt_hash=$(eval echo '$NT_HASH_'$_var)
                local _login=$(eval echo '$LOGIN_'$_var)
                if [[ "$_login" == "$_user" ]]; then
                        _login=$DOMAIN
                fi
                if [[ "$_nt_hash" == "fffffffffffffffffffffffffffffffffff" ]]; then
                        echo "\"${_login}\"/\"${_user}\":'${_pass}' (No NT Hash)"
                else
                        echo "\"${_login}\"/\"${_user}\" (${_nt_hash})"
                fi
        done
        echo ""
        echo "# dumping environment variables for users:"
        for user in $(env|grep -E '^USER_'|grep -v 'USER_ALIAS'); do
                local _var=$(echo $user|sed -e 's/USER_//g' | cut -d '=' -f1)
                local _user=$(eval echo '$USER_'$_var)
                echo "# user: $_user"
                local _pass=$(eval echo '$PASS_'$_var)
                local _nt_hash=$(eval echo '$NT_HASH_'$_var)
                local _login=$(eval echo '$LOGIN_'$_var)
                echo "export USER_${_var}=\"${_user}\""
                echo "export PASS_${_var}=\"${_pass}\""
                echo "export NT_HASH_${_var}=\"${_nt_hash}\""
                echo "export LOGIN_${_var}=\"${_login}\""
        done
        echo ""
        echo "# dumping current user environment variables:"
        echo "export USER=${CURRENT_USER}"
        echo "export USERNAME=${CURRENT_PASS}"
        echo "export PASS=${CURRENT_PASS}"
        echo "export PASSWORD=${CURRENT_PASS}"
        echo "export NT_HASH=${CURRENT_NT_HASH}"
        echo "export LOGIN=${CURRENT_LOGIN}"
        echo ""
        echo "export CURRENT_USER=${CURRENT_USER}"
        echo "export CURRENT_PASS=${CURRENT_PASS}"
        echo "export CURRENT_NT_HASH=${CURRENT_NT_HASH}"
        echo "export CURRENT_LOGIN=${CURRENT_LOGIN}"
        echo "export CURRENT=${CURRENT}"
}

function differ() {
        if [[ -z $1 || -z $2 ]]; then
                echo "Usage: differ <file1> <file2>"
                return 1
        fi
        if [[ ! -f $1 || ! -f $2 ]]; then
                echo "File not found!"
                return 1
        fi
        code -d "$1" "$2"
}