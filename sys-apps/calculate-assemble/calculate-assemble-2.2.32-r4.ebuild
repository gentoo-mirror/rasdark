# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

inherit distutils-r1 eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2
	http://mirror.yandex.ru/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The utilities for assembling tasks of Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="~sys-apps/calculate-builder-2.2.32"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# fix rebuild changed packages
	epatch "${FILESDIR}/calculate-assemble-2.2.32-fix_rebuild.patch"

	# fix assemble path
	epatch "${FILESDIR}/calculate-assemble-2.2.32-fix_assemble.patch"

	# fix name of distr by rasdark
	epatch "${FILESDIR}/calculate-assemble-2.2.32-fix_vars_share.patch"

}
