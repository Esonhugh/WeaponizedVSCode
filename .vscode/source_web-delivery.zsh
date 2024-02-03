source $PROJECT_FOLDER/.vscode/env.zsh

if [ -z "$PROJECT_WEB_DELIVERY" ]; then
    echo "PROJECT_WEB_DELIVERY is not set. Please set it in .vscode/env.zsh"
else 
    if [ -d "$PROJECT_WEB_DELIVERY" ]; then
        echo "FOLDER $PROJECT_WEB_DELIVERY exists."
    else
        mkdir -p $PROJECT_WEB_DELIVERY
        echo "*" > $PROJECT_WEB_DELIVERY/.gitignore
        echo "FOLDER $PROJECT_WEB_DELIVERY created."
    fi
fi

cd $PROJECT_WEB_DELIVERY

# or projectdiscovery/simplehttpserver
python3 -m http.server 

# open http://localhost:8000