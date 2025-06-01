#!/bin/zsh

if [[ -d ~/.local/weapon ]]; then
    echo "Weapon already installed."
    exit 0
fi

export LOCATION=~/.local/weapon
echo "Installing Weapon..."
mkdir -p $LOCATION && echo "Weapon directory created at $LOCATION." 
cp -f ./createhackenv.sh $LOCATION && echo "createhackenv.sh copied to $LOCATION."
cp -f ./zsh_history $LOCATION && echo "zsh_history copied to $LOCATION."

grep -zq "source $LOCATION/createhackenv.sh" ~/.zshrc
if [[ $? -eq 0 ]]; then
    echo "createhackenv.sh already sourced in ~/.zshrc. sktpping..."
else
    echo "Sourcing createhackenv.sh in ~/.zshrc..."
    echo "source $LOCATION/createhackenv.sh" >> ~/.zshrc
fi

echo "Weaponized VSCode installation completed."