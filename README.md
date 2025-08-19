# WeaponizedVSCode

A lightweight penetration testing environment management tool based on Visual Studio Code, designed for cybersecurity professionals and penetration testers.

## 🎯 Project Goals

WeaponizedVSCode aims to solve the following problems in traditional penetration testing:

1. **Difficult Environment Switching** - Frequent switching between different project environment configurations
2. **Chaotic Tool Management** - Tools and payloads scattered across different directories
3. **Repetitive Configuration** - Each project requires reconfiguring Metasploit, reverse shells, etc.
4. **Scattered Records** - Credentials, notes, and files stored dispersedly
5. **Low Efficiency** - Lack of mechanisms for rapid payload generation

## ✨ Core Features

### 🔄 Project Environment Management
- **One-Click Project Environment Creation** - Use `createhack <project-name>` to quickly create pre-configured penetration testing projects
- **Smart Environment Switching** - Seamless switching between different projects with automatic configuration loading
- **Template-Based Configuration** - Pre-configured VSCode settings, tasks, and extension configurations

### 🛠️ Integrated Tool Support
- **300+ Security Tool Integration** - Pre-configured command completion for common penetration testing tools
- **Smart Command History** - Tool index-based command history and auto-completion
- **Environment Variable Management** - Automatic detection and management of tool-dependent environment variables

### 🎮 Multi-Mode Terminals
- **Standard Shell** - Enhanced Zsh terminal with status display
- **Meterpreter Handler** - Auto-configured Metasploit listener
- **MSF Console** - Pre-configured Metasploit console
- **Netcat Handler** - Reverse shell handling terminal
- **Web Delivery** - HTTP server mode for file transfer
- **Kali OrbStack** - Virtual machine integration support (macOS)

### 📋 Project Organization Features
- **Structured Directories** - Automatically create hosts, users, credentials directories
- **File Management** - Convenient project file and web transfer file management
- **Note System** - Integrated Foam extension with bidirectional linked notes
- **Credential Management** - Centralized management of discovered user credentials

### ⚡ Quick Operations
- **Payload Generation** - VSCode task integration for rapid Msfvenom payload generation
- **Automated Scanning** - Integration of RustScan, Nmap, and other scanning tools
- **Proxy Management** - Convenient proxy switching and configuration
- **Host Management** - Automatic /etc/hosts file updates

## 🔧 System Requirements

### Supported Platforms
- **Linux** (Recommended)
- **macOS**
- **Windows** (Partial functionality, not fully supported)

### Required Dependencies
```bash
# Core Tools
zsh                    # Shell environment
code                   # Visual Studio Code
python3                # Python runtime
vim                    # Editor

# Network Tools
nc                     # Netcat
rlwrap                 # Command line wrapper

# Parsing Tools
awk, sed, grep, tr     # Text processing tools
yq                     # YAML processor

# Security Tools
msfvenom               # Metasploit payload generator
rustscan               # Port scanner
wfuzz                  # Web fuzzing tool
hashcat                # Password cracking tool
```

### Recommended Tools
```bash
simplehttpserver       # Enhanced HTTP server
uv                     # Python package manager (performance optimization)
```

## 🚀 Installation Guide

### 1. Clone Repository
```bash
git clone https://github.com/Esonhugh/WeaponizedVSCode.git
cd WeaponizedVSCode
```

### 2. Build Project
```bash
# Build using Make (recommended)
make build

# Or build manually
uv run ./craft.py
uv run ./completion_creator.py
```

### 3. Install to System
```bash
# Default installation (installs to ~/.local/weapon)
./installer.sh

# Custom installation location
WEAPON_LOCATION=/your/custom/path ./installer.sh

# Force reinstallation
./installer.sh --force-install

# Enable performance tracing mode
./installer.sh --trace-mode
```

### 4. Verify Installation
```bash
# Check script integrity
python3 verify.py createhackenv.sh

# Reload shell configuration
source ~/.zshrc
```

## 📖 Usage

### Create New Project
```bash
# Create new penetration testing project
createhack my-project
# Or use alias
createhackenv my-project
```

### Environment Variable Configuration
Set environment variables in the project's `.vscode/env.zsh` file:
```bash
export RHOST="10.10.10.1"
export RPORT="4444"
export LHOST="10.10.14.1"
export LPORT="9001"
export DOMAIN="target.com"
```

### Terminal Mode Usage

#### 1. Standard Shell Mode
- Automatically load project environment variables
- Display current status information
- Support all tool command completion

#### 2. Meterpreter Handler Mode
```bash
# Select "meterpreter-handler" terminal profile in VSCode
# Automatically start configured Metasploit listener
```

#### 3. Web Delivery Mode
```bash
# Select "web-delivery" terminal profile in VSCode
# Automatically switch to $PROJECT_WEB_DELIVERY directory and start HTTP server
```

### Common Command Examples
```bash
# Host Management
set_current_host 10.10.10.1
dump_hosts | sudo tee -a /etc/hosts

# User Management
set_current_user administrator
update_user_cred_to_env

# Scanning Operations
rustscan -a $RHOST --ulimit 5000 -- -A --script=vuln
nmap -sC -sV -p 139,445,80,21 $RHOST

# Proxy Management
proxys on
proxys set http://127.0.0.1:8080

# File Operations
cp payload.exe $PROJECT_WEB_DELIVERY/
```

## 🏗️ Project Structure

```
WeaponizedVSCode/
├── craft.py                    # Environment build script
├── completion_creator.py       # Command completion generator
├── installer.sh               # Installation script
├── verify.py                  # Script verification tool
├── launch_helper.zsh          # Shell launch helper
├── Makefile                   # Build configuration
├── .vscode/                   # VSCode template configuration
│   ├── settings.json          # Editor settings
│   ├── tasks.json             # Task configuration
│   ├── extensions.json        # Recommended extensions
│   ├── env.zsh               # Environment variables
│   ├── metasploit_handler.rc  # MSF configuration
│   └── source_*.zsh          # Mode launch scripts
├── completion_indexer/        # Tool command index
│   ├── nmap                   # Nmap command set
│   ├── burpsuite             # Burp Suite command set
│   ├── metasploit            # Metasploit command set
│   ├── _weapon               # Built-in tool commands
│   └── ...                   # 300+ tool command sets
└── documents/                 # Project documentation
    ├── USE.md                # Usage instructions
    ├── CUSTOM.md             # Customization guide
    └── DEMO.md               # Demo documentation
```

### Created Project Structure
```
my-project/
├── .vscode/                   # VSCode configuration
│   ├── .zshrc                # Shell configuration
│   ├── env.zsh               # Environment variables
│   └── ...                   # Other configuration files
├── hosts/                     # Host information
├── users/                     # User information
├── credentials/               # Credential information
└── web-delivery/             # Web transfer files
```

## 🎨 Custom Configuration

### Modify Templates
1. Edit configuration files in the `.vscode/` directory
2. Run `python3 craft.py` to regenerate installation script
3. Commit changes to Git repository

### Add New Tools
1. Create new tool command files in the `completion_indexer/` directory
2. Run `python3 completion_creator.py` to update command index
3. Rebuild and install

### Environment Variable Check
```bash
# Check all used environment variables
python3 completion_creator.py
```

## 🔍 Troubleshooting

### Common Issues

#### 1. Command Completion Not Working
```bash
# Check if zsh_history file exists
ls -la ~/.local/weapon/zsh_history

# Regenerate command index
python3 completion_creator.py
```

#### 2. Metasploit Mode Cannot Start
```bash
# Check if Metasploit is properly installed
which msfconsole
msfconsole --version

# Check RC file
cat .vscode/metasploit_handler.rc
```

#### 3. Environment Variables Not Loading Correctly
```bash
# Check project environment variable file
source .vscode/env.zsh
echo $PROJECT_FOLDER
```

## 🤝 Contributing

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by Cobalt Strike's environment management concepts
- Thanks to all security tool developers for their contributions
- Thanks to the VSCode community for providing a powerful extension ecosystem

## 📞 Support

- **GitHub Issues**: [Report Issues](https://github.com/Esonhugh/WeaponizedVSCode/issues)
- **Author**: Esonhugh <weapon_vscode@eson.ninja>

---

**Happy Hacking! 🎯**

 ## 404Starlink
<img src lazysrc="https://github.com/knownsec/404StarLink-Project/raw/master/logo.png" width="30%">
WeaponizedVSCode has joined [404Starlink](https://github.com/knownsec/404StarLink)
