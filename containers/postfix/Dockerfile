FROM debian:bullseye-slim

COPY conf/etc/postfix/main.cf      /etc/postfix/main.cf
COPY conf/etc/postfix/sasl_passwd  /etc/postfix/sasl_passwd
COPY conf/usr/local/bin/entrypoint /usr/local/bin/entrypoint

ARG POSTFIX_CONTAINER_USER_NAME
ARG POSTFIX_CONTAINER_USER_ID

RUN chown root:root /etc/postfix/main.cf \
&& chmod 644        /etc/postfix/main.cf \
\
&& chown root:root /etc/postfix/sasl_passwd \
&& chmod 600       /etc/postfix/sasl_passwd \
\
&& chown root:root /usr/local/bin/entrypoint \
&& chmod 775       /usr/local/bin/entrypoint \
\
&& apt-get update\
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  cyrus-imapd \
  postfix \
  sudo \
&& apt-get install -y --no-install-recommends \
  mailutils \
  sasl2-bin \
\
# Prepare "/etc/sudoers". This file could not replace by Dockerfile or ***.sh file directly.
# But works the following method alternatively.
&& echo "app-user ALL=NOPASSWD: /usr/sbin/postfix start-fg" | EDITOR='tee -a' visudo >/dev/null \
&& echo "app-user ALL=NOPASSWD: /usr/sbin/postfix start"    | EDITOR='tee -a' visudo >/dev/null \
&& echo "app-user ALL=NOPASSWD: /usr/sbin/postfix stop"     | EDITOR='tee -a' visudo >/dev/null \
&& echo "app-user ALL=NOPASSWD: /usr/sbin/postmap"          | EDITOR='tee -a' visudo >/dev/null \
\
&& postfix start \
&& cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf \
&& chown root:root /etc/postfix/sasl_passwd \
&& chmod 600       /etc/postfix/sasl_passwd \
\
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Make a Typical-User and run as it. (Rootless)
RUN adduser ${POSTFIX_CONTAINER_USER_NAME} --disabled-password --uid ${POSTFIX_CONTAINER_USER_ID} --gecos "" --shell /sbin/nologin

USER ${POSTFIX_CONTAINER_USER_NAME}
ENTRYPOINT ["entrypoint"]
EXPOSE 25