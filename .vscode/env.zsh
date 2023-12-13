export RHOST=10.10.X.X
export LHOST=10.10.X.X
export DOMAIN=


## set systembased settings
export HOST=${DOMAIN:-${RHOST}} # if DOMAIN is not set, use RHOST
export host=${HOST} # alias as HOST
export TARGET=${HOST} # target is HOST

export IP=${RHOST} # alias rhost
export ip=${IP} # alias as IP

export PROJECT_WEB_DELIVERY=$PROJECT_FOLDER/.web-delivery # web-delivery is a folder in PROJECT_FOLDER
unset SSS_LOADED # make sure sss init shell is not set

# if you need to set functions definitions, you can do it here
# source $PROJECT_FOLDER/.vscode/utils.zsh