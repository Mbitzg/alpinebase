FROM            alpine:edge
MAINTAINER      Howard Mei      <howardmei@mubiic.com>
ENV             LOCALE          en_US.UTF-8
# Run docker run -it --rm alpine:edge cat /etc/os-release
LABEL           OSVER           edge@3.4.0

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
	            NewPackages="su-exec libcap" && apk-install ${NewPackages} && \
	            ln -s $(which su-exec) /usr/sbin/sux && apk-cleanup && \
	            mkdir -p /var/www && chmod -R 0755 /var/www && \
	            addgroup -S www-data && adduser -S -s /bin/sh -g 'WWW Group' \
	            -G www-data -D www-data && chown -R www-data:www-data /var/www
				
# Set Default User and Wordking Dir
USER            root
ENV             HOME            /root
WORKDIR         /var/www

# Define the Entry Point and/or Default Command
ENTRYPOINT      ["/entrypoint"]
## Notice: Use ["/entrypoint"] as ENTRYPOINT instead of ["/bin/sh","-ilc"] to avoid arg parsing issue
## /bin/sh -ilc "arg1 arg2 ... argn" has its own builtin args parser which demands full quoted args
## where CMD ["cat","/etc/apk/repositories"] will cause errors and "cat /etc/apk/repositories" will work
## but it's incompatible with the default docker run convention. The /entrypoint works on both styles.
