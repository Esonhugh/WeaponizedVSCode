---
title: ${1:$TM_FILENAME_BASE}
tags: host
foam_template:
  filepath: 'hosts/$FOAM_TITLE/$FOAM_TITLE.md'
  name: 'host'
  description: 'note when hacking a host'
---

### ${1:$TM_FILENAME_BASE}

#### host location

```yaml host
- hostname: ${1:$TM_FILENAME_BASE}
  is_dc: false
  ip: 10.10.10.10
  alias: ["${1:$TM_FILENAME_BASE}"] # if is DC, please set the dc hostname as the first alias, such as ["dc01.example.com"]
```

```zsh env-invoked
set_current_host ${1:$TM_FILENAME_BASE}
```

#### ports

##### 80

#### information

1. Linux/Windows
2. Kernel version
3. ...

##### Nmap
```

```

#### vulnerabilities / exploits

privsec problem with user xxxx and using exploit 

#### related information

##### services

##### users

#### proof

local proof? machine proof? screenshot?
