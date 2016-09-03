FROM            alpine:edge
MAINTAINER      Howard Mei      <howardmei@mubiic.com>
ENV             LOCALE          en_US.UTF-8


# Add apk repository mirror list and user local bin
COPY            entrypoint      /entrypoint
COPY            etc             /etc
COPY            usr             /usr
COPY            root            /root

ENV             LANG            $LOCALE
ENV             LANGUAGE        $LOCALE
ENV             LC_ALL          $LOCALE

RUN 			mkdir -p /usr/sbin && mkdir -p /usr/local/sbin && \
				chmod -R 0755 /usr/sbin /usr/local/sbin && \
				chmod 0755 /entrypoint && chmod 0644 /etc/apk/repositories && \
				chmod 0755 /usr/bin/apk-install /usr/bin/apk-remove \
				/usr/bin/apk-cleanup /usr/bin/set-timezone && \
	            NewPackages="su-exec" && apk-install ${NewPackages} && \
	            ln -s $(which su-exec) /usr/sbin/sux && apk-cleanup && \
	            addgroup -S devops && adduser -S -s /bin/sh -g 'DevOps \
	            User in Sudo Group' -G devops -D -h /home/devops devops && \
	            cp /root/.profile /home/devops && chown -R devops:devops /home/devops
				
# Set Default User and Wordking Dir
USER            devops
ENV             HOME            /home/devops
WORKDIR         /home/devops

# Define the Entry Point and/or Default Command
ENTRYPOINT      ["/entrypoint"]
## Notice: Use ["/entrypoint"] as ENTRYPOINT instead of ["/bin/sh","-ilc"] to avoid arg parsing issue
## /bin/sh -ilc "arg1 arg2 ... argn" has its own builtin args parser which demands full quoted args
## where CMD ["cat","/etc/apk/repositories"] will cause errors and "cat /etc/apk/repositories" will work
## but it's incompatible with the default docker run convention. The /entrypoint works on both styles.
