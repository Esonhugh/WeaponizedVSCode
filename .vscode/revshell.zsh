source ${PROJECT_FOLDER}/.vscode/env.zsh

# pwncat-cs 
rlwrap -I -cAr nc -lvvp ${LPORT} 

