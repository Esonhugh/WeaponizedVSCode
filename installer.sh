#!/bin/zsh

if [[ -d ~/.local/weapon ]]; then
    echo "Weapon already installed."
    exit 0
fi

echo "Installing Weapon..."
mkdir -p ~/.local/weapon

export LOCATION=~/.local/weapon
cp -f ./createhackenv.sh $LOCATION
cp -f ./zsh_history $LOCATION

echo "source $LOCATION/createhackenv.sh" >> ~/.zshrc

echo "Weaponized VSCode installation completed."