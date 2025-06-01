# ENV settings for the project
################################################################
# Project settings for Zsh Prompt
# export HOST="[HackTheBox - Machine Name]"

################################################################
# Target settings
export RHOST=10.10.X.X
# works well on HTB and THM, Put your reverse IP here.

# use this if you are using a VPS or cloud server it can automatically get your public IP.
# export LHOST=`curl ifconfig.me` 
# export LHOST=`curl ip.me`
export LHOST=`ifconfig|grep '10\.10\.'|cut -d ' ' -f2` 
export ATTACKER_IP=$LHOST

export LPORT=6789
export DOMAIN=

export TARGET=${DOMAIN:-${RHOST}} # target is target hostname if not set use RHOST ip

export IP=${RHOST} # alias rhost
export ip=${IP} # alias as IP
export DC_IP=${RHOST} # alias rhost
export DC_HOST=dc01.${DOMAIN} # domain controller host, if not set use dc01.domain.com

export USER_A=username
export PASS_A=password
export NT_HASH_A=ffffffffffffffffffffffffffffffff # NTLM hash, if you have it

export USER_B=
export PASS_B=

export CURRENT=A # set the current username 
export CURRENT_USER=`eval echo '$USER_'$CURRENT` # alias for USER_A
export CURRENT_PASS=`eval echo '$PASS_'$CURRENT` # alias for PASS_A
export CURRENT_NT_HASH=`eval echo '$NT_HASH_'$CURRENT` # alias for NT_HASH_A

# defined variables if u need
export USER=${CURRENT_USER}
export USERNAME=${CURRENT_USER}
export PASS=${CURRENT_PASS}
export PASSWORD=${CURRENT_PASS} # alias for PASS
export NT_HASH=${CURRENT_NT_HASH} # alias for NT_HASH_A


# export KRB5CCNAME=

# FAKETIME settings
# export LD_PRELOAD=/usr/local/lib/libfaketime.so.1
# export LD_PRELOAD=/usr/lib/aarch64-linux-gnu/faketime/libfaketime.so.1
# export DYLD_FORCE_FLAT_NAMESPACE=1 DYLD_INSERT_LIBRARIES=/opt/homebrew/Cellar/libfaketime/0.9.10/lib/faketime/libfaketime.1.dylib
# export FAKETIME="-8h"


export METASPLOIT_INIT_COMMAND=""

################################################################
# Advanced settings

# AWS settings
# export AWS_DEFAULT_REGION=us-west-2
# export AWS_ACCESS_KEY_ID=AKIA...
# export AWS_SECRET_ACCESS_KEY=...
# export AWS_SESSION_TOKEN=...
# export AWS_ENDPOINT_URL=

# VAULT settings
# export VAULT_ADDR=
# export VAULT_TOKEN=...

# MINIO settings
# export MINIO_ROOT_USER=... # access key
# export MINIO_ROOT_PASSWORD=... # secret key
# export MINIO_ENDPOINT=
# export MC_HOST_myminio=http://${MINIO_ROOT_USER}:${MINIO_ROOT_PASSWORD}@${MINIO_ENDPOINT}

# Kubernetes settings
# export KUBECONFIG=${PROJECT_FOLDER}/kubeconfig

# Terraform settings
export TF_LOG=trace
export TF_LOG_PATH=$PROJECT_FOLDER/terraform.log
# export TF_VAR_aws_access_key=...
# export TF_VAR_aws_secret_key=...
# export TF_VAR_aws_session_token=...
# export TF_VAR_aws_region=us-west-2

# OpenStack settings
# export OS_USERNAME=username
# export OS_PASSWORD=password
# export OS_TENANT_NAME=projectName
# export OS_AUTH_URL=https://identityHost:portNumber/v2
# The following lines can be omitted
# export OS_TENANT_ID=tenantIDString
# export OS_REGION_NAME=regionName
# export OS_CACERT=/path/to/cacertFile
# export OS_TOKEN=tokenString

################################################################
# More default settings

export PROJECT_WEB_DELIVERY=$PROJECT_FOLDER/.web-delivery # web-delivery is a folder in PROJECT_FOLDER
unset SSS_LOADED # make sure sss init shell is not set

################################################################
# Network settings clean up and reset
unset https_proxy http_proxy all_proxy
# export http_proxy=
# export https_proxy=
# export all_proxy=

################################################################
# Hashcat settings

# useful settings like ROCKYOU, SECLIST, etc.
# export ROCKYOU=/usr/share/wordlists/rockyou.txt
# export SECLIST=/usr/share/wordlists/seclists/
# export TOP_DNS=${SECLIST}/Discovery/DNS/bitquark-subdomains-top100000.txt
# export WORDLISTS=/usr/share/wordlists/

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
    export Proxy="127.0.0.1"   # define as your favour
    export ProxyPort="7890"  # define as your favour
        case "$1" in
                (h)
                        echo "|==============================================|"
                        echo "|                   $0 Usage                   |"
                        echo "|         ---- fast commandline proxy switcher |"
                        echo "|==============================================|"
                        echo "| Basic Usage: $0 [SubCommand] [param1]        |"
                        echo "|==============================================|"
                        echo "|                Sub Command List              |"
                        echo "|==============================================|"
                        echo "| proxy [proxy_ip]          import ip temply   |"
                        echo "| port [port_id]            import port temply |"
                        echo "| loc                       import localhost   |"
                        echo "| on                        up the cli proxy   |"
                        echo "| off                       down the proxy     |"
                        echo "| *                         show proxy setting |"
                        echo "| h/help                    show help          |"
                        echo "|==============================================|"
                        ;;
                (proxy)
                        export Proxy="$2"
                        ;;
                (port)
                        export ProxyPort="$2"
                        ;;
                (loc)
                        export Proxy="127.0.0.1"        # define as your favour
                        export ProxyPort="7890"       # define as your favour
                        $0 on
                        ;;
                (on)
                        export https_proxy=http://$Proxy:$ProxyPort \
                        http_proxy=http://$Proxy:$ProxyPort && \
                        echo 'export Proxy complete' && $0 show
                        ;;
                (off)
                        unset https_proxy http_proxy all_proxy && echo 'unset Proxy complete'
                        ;;
                (help)
                        proxys h
                        ;;
                (*)
                        echo "Current Proxy Condition like ...."
                        export|grep proxy
                        echo "if you can't see any output like 'XX_PROXY=' there"
                        echo "That means no proxy is set"
                        ;;
        esac
}

function venv-init () {
    python3 -m venv venv
}

function venv-activate () {
        if [ -d "./venv/" ] 
        then
                source "./venv/bin/activate"
        else 
                echo "No Python venv there. Error"
        fi
}

function goproxy () {
        case "$1" in
                (on) export GOPROXY=https://goproxy.io,direct  ;;
                (off) unset GOPROXY ;;
                (*) $0 on/off ;;
        esac
}

function url () {
        case "$1" in
                (h |-h |help| --help) 
                    which $0
                            ;;
                (decode | d | -d | --decode) if [ -z "$2" ]
                        then
                                \python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));"
                        else
                                \python3 -c "import sys; from urllib.parse import unquote; print(unquote(' '.join(sys.argv[2:])));" "$@"
                        fi ;;
                (encode | e | -e | --encode) if [ -z "$2" ]
                        then
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

# unset -f wfuzz_vhost_https
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
