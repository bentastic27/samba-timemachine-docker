#!/bin/bash
useradd -M ${USERNAME} -G users
echo -e "${PASSWORD}\n${PASSWORD}" | smbpasswd -a -s ${USERNAME}
unset PASSWORD
exec "$@"