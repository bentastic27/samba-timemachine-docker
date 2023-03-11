adduser ${USERNAME}
echo "${PASSWROD}\n${PASSWROD}" | smbpasswd -a -s ${USERNAME}
usermod -g users ${USERNAME}
unset PASSWROD
