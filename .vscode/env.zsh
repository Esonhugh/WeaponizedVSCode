# ENV settings for the project
################################################################
# Project settings for Zsh Prompt
# export HOST="[HackTheBox - Machine Name]"

################################################################
# Target settings
export RHOST=10.10.X.X
# works well on HTB and THM, Put your reverse IP here.
export LHOST=`ifconfig|grep '10\.10\.'|cut -d ' ' -f2` 

# use this if you are using a VPS or cloud server it can automatically get your public IP.
# export LHOST=`curl ifconfig.me` 
# export LHOST=`curl ip.me`
export LPORT=6789
export DOMAIN=

# export USER_A=
# export PASS_A=

# export USER_B=
# export PASS_B=


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
export TARGET=${DOMAIN:-${RHOST}} # target is target hostname if not set use RHOST ip

export IP=${RHOST} # alias rhost
export ip=${IP} # alias as IP

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
export HASH_KRB5_PREAUTH=7500
export HASH_DJANGO_PBKDF2_SHA256=10000
export HASH_PBKDF2_HMAC_SHA256=10900
export HASH_KRB5_TGS=13100
export HASH_JWT=16500


# utils functions

# automatically set the AWS environment variables from the json output of `aws sts assume-role` 
aws_sts_env () {
        if [[ -n "$1" ]]
        then
            local cred=$1
        fi
        if [[ -z "$cred" ]]
        then
                echo "Usage: $0 \`json\`"
                echo "Example: export cred=\`aws sts assume-role --role-arn xxxx --role-session-name xxxx|jq ".Credentials"\`"
                echo "         or get metadata from remote"
                echo "         export cred=\`curl 169.254.169.254/latest/meta-data/identity-credentials/ec2/security-credentials/ec2-instance\`"
                echo "         aws_sts_env '[\$cred optional]'"
                return
        fi
        export AWS_ACCESS_KEY_ID=`echo $cred|jq -r '.AccessKeyId' ` 
        export AWS_SECRET_ACCESS_KEY=`echo $cred|jq -r '.SecretAccessKey'`  
        export AWS_SESSION_TOKEN=`echo $cred|jq -r '(if .SessionToken == null then .Token else .SessionToken end)'` 
        echo "SET AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN in environment."
        unset cred
        env | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} AWS | awk '{ print "export " $0 }'
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

