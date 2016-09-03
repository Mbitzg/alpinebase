# docker image: alpinebase [Layer 1]

This layer 1 base image is built upon [alpine image](https://hub.docker.com/r/_/alpine/) `edge` tag,which itself is built from [Alpine Linux](https://alpinelinux.org/) [`Edge`](http://wiki.alpinelinux.org/wiki/Edge) branch for max coverage of new packages, such as php7@edge/testing repository.If the intent of this image is to be a minimal base for single-service containers, tracking `edge` is not expected to cause issues (packages are still stable releases, only Alpine itself is a development build).For multiple-process containers, it may generate some unexpected results, but the benefit over risk ratio seems high enough for non-critical applications (database applications using this image are required to do more testing before production).

## Description

Install [su-exec](https://github.com/ncopa/su-exec) instead of [gosu](https://github.com/tianon/gosu) to replace su and sudo [with shell alias]. Alias *sux=su-exec*.


## Upcoming Changes

TBD

## Additions
/:
	entry

/root/:
	.profile

/etc/apk/:
	repositories
    
/usr/bin/:
	apk-install
    apk-remove
    apk-cleanup
    set-timezone

## Tags

* `latest` tracks the `edge` tag from [upstream](https://hub.docker.com/r/_/alpine/)

_This includes the `main`, `testing`, and `community` repositories, but all packages outside `main` are masked. To import them, just use `apk-install pkgname@reponame`._

# License
[MIT](https://tldrlegal.com/license/mit-license)
