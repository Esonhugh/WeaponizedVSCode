export WEAPON_LOCATION=__REPLACE__

weapon_vscode_launch_helper () {
    if [ -f ${WEAPON_LOCATION}/zsh_history ]; then
        export HIST_COMMAND_INDEXER=${WEAPON_LOCATION}/zsh_history
    fi
    if [ -n "$PROJECT_FOLDER" ]; then
        if [ -f "$PROJECT_FOLDER/.vscode/.zshrc" ]; then
            source $PROJECT_FOLDER/.vscode/.zshrc
        fi
    fi
}
weapon_vscode_launch_helper