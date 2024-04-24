weapon_vscode_launch_helper () {
    if [ -n "$PROJECT_FOLDER" ]; then
        # do anything if PROJECT_FOLDER is set
        if [ -d "$PROJECT_FOLDER/venv"]; then
            source $PROJECT_FOLDER/venv/bin/activate
        fi
    fi
}
weapon_vscode_launch_helper