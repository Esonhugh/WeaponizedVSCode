#!/bin/zsh

function check_command() {
    command -v "$1" >/dev/null 2>&1 && {
    } || {
        echo "detect $1 is not installed."
        echo "$2"
        return 2
    }
}

function check_requirements() {
    check_command "awk" "awk is required for parsing the output of commands, please install it." || return 2
    check_command "sed" "sed is required for parsing the output of commands, please install it." || return 2
    check_command "grep" "grep is required for parsing the output of commands, please install it." || return 2
    check_command "tr" "tr is required for parsing the output of commands, please install it." || return 2
    check_command "zsh" "zsh is core to WeaponizedVSCode integrated shell." || return 2
    check_command "vim" "vim is required for task edit /etc/hosts, please install it or change it." || return 2
    check_command "nc" "nc is core for netcat shell session handling or u can't use it, please install it." || return 2
    check_command "rlwrap" "rlwrap is required for netcat shell session handling, please install it" || return 2
    check_command "msfvenom" "You will not have meterpreter shell or msfconsole feature in vscode integrated terminal." || return 2
    check_command "code" "Visual Studio Code is required for WeaponizedVSCode, please for sure your 'code' command is available in PATH." || return 2
    check_command "yq" "yq is required for parsing YAML content to environment variable, install it with 'brew install yq' or 'apt install yq'." || return 2
    check_command "simplehttpserver" "simplehttpserver is cool for serving files with upload feature and dump http requests, install it with https://github.com/projectdiscovery/simplehttpserver" || return 2
    check_command "rustscan" "rustscan is required for the auto scanning task in vscode, fast and reliable, install it with https://github.com/bee-san/RustScan" || return 2
    check_command "wfuzz" "wfuzz is required for command wfuzz_vhost_https and wfuzz_vhost_http, to fuzz the subdomain and vhost. install it or u can't use that" || return 2
    check_command "hashcat" "hashcat is required for the hashcat cracking task in vscode, install it with 'apt install hashcat' or 'brew install hashcat'." || return 2
    check_command "python3" "Python3 is required for the Python scripts in WeaponizedVSCode, please install it." || return 2
    check_command "uv" "uv is optional but recommended for better performance, install it with 'pip install uv'. Their script is useful"
}

function main() {
    check_requirements
    if [[ $? -ne 0 && "$FORCE_INSTALL" != "true" ]]; then
        echo "Please install the required commands to continue."
        echo "If you want to force install without checking requirements, run the script with FORCE_INSTALL=true ./installer.sh"
        exit 1
    fi
    
    if [[ -z "$WEAPON_LOCATION" ]]; then
        echo "WEAPON_LOCATION is not set. set to default ~/.local/weapon"
        export WEAPON_LOCATION=~/.local/weapon
        echo "You can set it by exporting WEAPON_LOCATION=your_desired_path before running this script."
    fi

    if [[ -d "$WEAPON_LOCATION" ]]; then
        echo "Weapon already installed."
        exit 0
    fi
    export LOCATION="$WEAPON_LOCATION"
    echo "Weapon will be installed to $LOCATION, Press Enter key to continue or Ctrl+C to cancel..."
    read
    echo "Installing Weapon..."
    mkdir -p $LOCATION && echo "Weapon directory created at $LOCATION."
    cat ./createhackenv.sh |sed -e "s#__REPLACE__#$LOCATION#g" > $LOCATION/createhackenv.sh && echo "createhackenv.sh copied to $LOCATION."
    cp -f ./zsh_history $LOCATION && echo "zsh_history copied to $LOCATION."

    grep -zq "source $LOCATION/createhackenv.sh" ~/.zshrc
    if [[ $? -eq 0 ]]; then
        echo "createhackenv.sh already sourced in ~/.zshrc. sktpping..."
    else
        echo "Sourcing createhackenv.sh in ~/.zshrc..."
        echo "source $LOCATION/createhackenv.sh" >>~/.zshrc
    fi

    echo "Weaponized VSCode installation completed."
}

main "$@"
