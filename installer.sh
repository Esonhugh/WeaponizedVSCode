#!/bin/zsh

if [[ -d /opt/weapon ]]; then
    echo "Weapon already installed."
    exit 0
fi

echo "Installing Weapon..."
mkdir -p /opt/weapon

cp -f ./createhackenv.sh /opt/weaopn
cp -f ./zsh_history /opt/weapon

echo "source /opt/weapon/createhackenv.sh" >> ~/.zshrc

echo "Weaponized VSCode installation completed."