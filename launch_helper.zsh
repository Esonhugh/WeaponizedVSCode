weapon_vscode_launch_helper () {
    if [ -f "/opt/weapon/zsh_history" ]; then
        export HIST_COMMAND_INDEXER="/opt/weapon/zsh_history"
    fi
    if [ -n "$PROJECT_FOLDER" ]; then
        if [ -f "$PROJECT_FOLDER/.vscode/.zshrc" ]; then
            source $PROJECT_FOLDER/.vscode/.zshrc
        fi
    fi
}
weapon_vscode_launch_helper