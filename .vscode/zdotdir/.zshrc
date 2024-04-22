if [ -f "$HOME/.zshenv" ]; then
  source "$HOME/.zshenv"
fi
if [ -f "$HOME/.zshrc" ]; then
  source "$HOME/.zshrc"
fi
if [ -f "$HOME/.zprofile" ]; then
  source "$HOME/.zprofile"
fi


source "$PROJECT_FOLDER/.vscode/source.zsh"