# POST executed after the shell is loaded
# This file is loaded after .zshrc

# This file can be empty of deleted if not needed
# Loading Order
# vscode ==(inject PROJECT_FOLDER and check settings.json)==> source.zsh (PreHandling)
# source.zsh ==(source env.zsh)==> env.zsh
# source.zsh ==(Check Mode)==> Do any IF condition or keep continue
# source.zsh ==(exec zsh -i)==> ~/.zshrc
# ~/.zshrc ==(contains weapon_vscode_launch_helper function)==> launch_helper.zsh
# ~/.zshrc ==(if set, PROJECT_FOLDER and .vscode/.zshrc exists, source it)==> .vscode/.zshrc

# you can define any function 

if [ -d "$PROJECT_FOLDER/venv" ]; then
    source $PROJECT_FOLDER/venv/bin/activate
fi