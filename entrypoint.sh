#!/bin/bash
adduser ${USERNAME}
echo -e "${PASSWORD}\n${PASSWORD}" | smbpasswd -a -s ${USERNAME}
usermod -g users ${USERNAME}
unset PASSWORD
exec "$@"