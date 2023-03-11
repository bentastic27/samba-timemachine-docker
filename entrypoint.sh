#!/bin/bash
useradd -M ${USERNAME} -G USERS
echo -e "${PASSWORD}\n${PASSWORD}" | smbpasswd -a -s ${USERNAME}
unset PASSWORD
exec "$@"