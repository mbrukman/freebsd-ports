# Created by: Kubilay Kocak <koobs@FreeBSD.org>
# $FreeBSD$

PORTNAME=	slackclient
PORTVERSION=	1.2.1
CATEGORIES=	net-im python
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	koobs@FreeBSD.org
COMMENT=	Python client for Slack.com

LICENSE=	MIT

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}websocket-client>=0.35:www/py-websocket-client@${FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}requests>=2.11:www/py-requests@${FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}six>=1.10:devel/py-six@${FLAVOR}
TEST_DEPENDS=	${PYTHON_PKGNAMEPREFIX}pytest>0:devel/py-pytest@${FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}pytest-mock>0:devel/py-pytest-mock@${FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}responses>0:devel/py-responses@${FLAVOR}

USES=		python
USE_GITHUB=	yes
USE_PYTHON=	autoplist distutils

# Does not currently include tests in sdist
GH_ACCOUNT=	slackapi
GH_PROJECT=	python-${PORTNAME}

NO_ARCH=	yes

do-test:
	@cd ${WRKSRC} && ${PYTHON_CMD} -m pytest -v

.include <bsd.port.mk>
