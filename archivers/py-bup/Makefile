# Created by: Jos� Garc�a Juanino <jjuanino@gmail.com>
# $FreeBSD$

PORTNAME=	bup
PORTVERSION=	0.29.1
CATEGORIES=	archivers python
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	jjuanino@gmail.com
COMMENT=	Very efficient backup system based on the git packfile format

LICENSE=	LGPL21
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	${PYTHONPREFIX_SITELIBDIR}/posix1e.so:security/py-pylibacl \
		xattr:devel/py-xattr \
		git>=1.5.3.1:devel/git \
		par2cmdline>=0.4:archivers/par2cmdline
BUILD_DEPENDS=	bash:shells/bash git>=1.5.3.1:devel/git

PLIST_SUB=	MANDIR=${PREFIX}/man

OPTIONS_DEFINE=	TORNADO DOCS
OPTIONS_DEFAULT=	DOC
TORNADO_DESC=	Bup web server
TORNADO_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}tornado>=4:www/py-tornado
DOCS_DESC=	Build man files and html documentation
DOCS_BUILD_DEPENDS=	pandoc:textproc/hs-pandoc
DOCS_VARS=		PANDOC=pandoc
DOCS_VARS_OFF=		PANDOC=""

TEST_TARGET=		test
MAKE_ARGS=	PANDOC="${PANDOC}"
USES=		python:2.7 gmake
USE_GITHUB=	yes

.include <bsd.port.pre.mk>

post-install:
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/bup/bup/*.so
	test -z ${DOCS} || ${GZIP_CMD} ${STAGEDIR}${MANDIRS}/man1/bup*.1

.include <bsd.port.post.mk>
