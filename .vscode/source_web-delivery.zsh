source $PROJECT_FOLDER/.vscode/env.zsh

mkdir -p $PROJECT_WEB_DELIVERY

cd $PROJECT_WEB_DELIVERY

# or projectdiscovery/simplehttpserver
python3 -m http.server 

# open http://localhost:8000