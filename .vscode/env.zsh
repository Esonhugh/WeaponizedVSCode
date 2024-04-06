# ENV settings for the project
################################################################
# Project settings for Zsh Prompt
# export HOST="[HackTheBox - Machine Name]"

################################################################
# Target settings
export RHOST=10.10.X.X
# works well on HTB and THM, Put your reverse IP here.
export LHOST=`ifconfig|grep '10\.10\.'|cut -d ' ' -f2`
export LPORT=6789
export DOMAIN=

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

# if you need to set functions definitions, you can do it here
# source $PROJECT_FOLDER/.vscode/utils.zsh