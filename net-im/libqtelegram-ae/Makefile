# Created by: Henry Hu <henry.hu.sh@gmail.com>
# $FreeBSD$

PORTNAME=	libqtelegram-ae
PORTVERSION=	6.1
PORTREVISION=	1
DISTVERSIONPREFIX=	v
DISTVERSIONSUFFIX=	-stable
CATEGORIES=	net-im

MAINTAINER=	henry.hu.sh@gmail.com
COMMENT=	Fork of libqtelegram by Aseman Team

LICENSE=	GPLv3
LICENSE_FILE=	${WRKSRC}/LICENSE

USE_GITHUB=	yes
GH_ACCOUNT=	Aseman-Land
GH_PROJECT=	libqtelegram-aseman-edition

USES=		qmake:outsource ssl
USE_QT5=	qmake_build buildtools_build core gui network multimedia
USE_LDCONFIG=	yes

post-patch:
	@${REINPLACE_CMD} -e "/OPENSSL_INCLUDE_PATH/d" \
		${WRKSRC}/libqtelegram-ae.pri

.include <bsd.port.mk>
