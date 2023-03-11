FROM debian:11

RUN apt update && apt install --yes \
  samba && rm -rf /var/lib/apt/lists/*

COPY smb.conf /etc/samba/smb.conf

RUN mkdir /timemachine && \
  chown .users /timemachine && \
  chmod 771 /timemachine

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 445

ENTRYPOINT ["/entrypoint.sh"]
CMD ["smbd", "-F", "--no-process-group"]