---
title: ${1:$TM_FILENAME_BASE}
tags: user
foam_template:
  filepath: 'users/$FOAM_TITLE/$FOAM_TITLE.md'
  name: 'user'
  description: 'note when getting a user'
---

### ${1:$TM_FILENAME_BASE}

#### validated credentials

```yaml
- login: ${FOAM_TITLE/^(\S*)@//}
  user: ${FOAM_TITLE/@(\S*)$//}
  password: pass
```

#### information

1. 
2. 
3. 

#### Privileges / roles / groups 






