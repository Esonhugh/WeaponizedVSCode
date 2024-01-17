## Demo of usage

### Tasks

#### msfvenom payload generate

1. Ctrl+Shift+P to open command palette

![](./imgs/vsc-task-panel.png)

2. select `Tasks: Run Task` and select `msfvenom-payload-creating`

![](./imgs/vsc-choose-task.png)

3. input options for payload

![](./imgs/tasks-msf/choose-payload.png)
![](./imgs/tasks-msf/add-lhost.png)
![](./imgs/tasks-msf/add-lport.png)
![](./imgs/tasks-msf/choose-advanced-opt.png)
![](./imgs/tasks-msf/payload-format.png)
![](./imgs/tasks-msf/edit-output-file.png)

4. generate payload

![](./imgs/tasks-msf/task-run.png)

### Terminals 

using ![](./imgs/terminal.png)

#### normal zsh injected env

direct use `+` to init the default zsh shell

and you will got the env defined in `env.zsh` and `source.zsh` 

you can do thing like 

use env var in command ![](./imgs/env_define.png) ![](./imgs/env_reuse_in_rustscan.png)

fast folder jumping ![](./imgs/env_folder_jump.png)

#### meterpreter handler

use `meterpreter-handler` to init the msfconsole with the rcfile

![](./imgs/msfconsole.png) 

#### netcat handler

##### netcat + rlwrap (default)

use `netcat-handler` to init the netcat listener

(you know the 6789 port is default $LPORT in `env.zsh`, I just reuse it in `revshell.zsh`)

and victim using payload to reverse its shell 

![](./imgs/netcat-victim.png)

and gain the shell

![](./imgs/netcat-master.png)

##### pwncat-cs 

just replace payload in `revshell.zsh` with pwncat-cs

![](./imgs/modify_pwncat.png)

![](./imgs/pwncat-master.png)

and trigger shell on remote 

![](./imgs/netcat-victim.png)

gain shell with pwncat 

![](./imgs/pwncat-rev2.png)

and then do anything you need.

#### web delivery

use `web-delivery` to init the http server in the project folder, default is in the $PROJECT_WEB_DELIVERY

1. starting http server with `web-delivery` terminal

2. copy available payloads or scripts to $PROJECT_WEB_DELIVERY
![](./imgs/web-delivery-put-payload.png)

3. vicitim get payload via http
![](./imgs/web-delivery-victim.png)

4. attacker get the request log in the terminal
![](./imgs/web-delivery-log.png)

> ur can use such function get xss result as well. 

#### macos kali orbstack vm with injected env

![](./imgs/osx-orbstack-kali-root.png)

