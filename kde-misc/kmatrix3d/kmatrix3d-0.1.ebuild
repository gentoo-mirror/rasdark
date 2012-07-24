# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde

DESCRIPTION="3D matrix OpenGL screen saver for KDE."
HOMEPAGE="http://kmatrix3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/kmatrix3d/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"
RESTRICT="nomirror"

need-kde 3.4
S=${WORKDIR}/${PN}

src_install() {
	einstall || die "make install failed"
}
