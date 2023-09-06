#!/bin/bash
useradd -M ${USERNAME} -G users
echo -e "${PASSWORD}\n${PASSWORD}" | smbpasswd -a -s ${USERNAME}
unset PASSWORD

CMD=("${@}")
CMD+=("--option=\"fruit:time machine max size\"=${TM_MAX_SIZE+500G}")

exec "$CMD"