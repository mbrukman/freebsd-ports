# $FreeBSD$

PORTNAME=	konqueror
DISTVERSION=	${KDE_APPLICATIONS_VERSION}
CATEGORIES=	x11-fm www kde kde-applications

MAINTAINER=	kde@FreeBSD.org
COMMENT=	KDE system log application

LIB_DEPENDS=	libtidy.so:www/tidy-lib

USES=		cmake:outsource desktop-file-utils gettext kde:5 pkgconfig tar:xz
USE_KDE=	activities  archive auth bookmarks codecs completion config configwidgets \
		coreaddons crash dbusaddons guiaddons i18n iconthemes \
		itemviews jobwidgets js kcmutils kdelibs4support \
		kdesu khtml kio notifications parts pty service solid sonnet \
		textwidgets unitconversion widgetsaddons windowsystem xmlgui
USE_QT5=	core dbus gui location network printsupport qml quick script \
		speech webchannel webengine widgets x11extras xml \
		buildtools_build qmake_build
USE_XORG=	ice sm x11 xext

.include <bsd.port.mk>
