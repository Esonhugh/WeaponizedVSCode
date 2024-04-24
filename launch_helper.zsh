weapon_vscode_launch_helper () {
    if [ -n "$PROJECT_FOLDER" ]; then
        if [ -f "$PROJECT_FOLDER/.vscode/.zshrc" ]; then
            source $PROJECT_FOLDER/.vscode/.zshrc
        fi
    fi
}
weapon_vscode_launch_helper