#!/bin/bash
adduser ${USERNAME}
echo "${PASSWORD}\n${PASSWORD}" | smbpasswd -a -s ${USERNAME}
usermod -g users ${USERNAME}
unset PASSWROD
exec "$@"