FROM debian:11

RUN apt update && apt install --yes \
  samba && rm -rf /var/lib/apt/lists/*

COPY smb.conf /etc/samba/smb.conf

RUN mkdir /data && \
  chown .users /data && \
  chmod 771 /data

COPY entrypoint.sh /entrypoint.sh
COPY dummy_quota_cmd.sh /dummy_quota_cmd.sh
RUN chmod +x /entrypoint.sh /dummy_quota_cmd.sh

EXPOSE 445

ENV TM_MAX_SIZE=100G
ENTRYPOINT ["/entrypoint.sh"]
CMD ["smbd", "-F", "--log-stdout", "--no-process-group"]