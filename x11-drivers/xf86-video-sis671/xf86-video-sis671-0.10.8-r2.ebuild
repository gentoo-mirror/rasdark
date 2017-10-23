# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

EGIT_COMMIT="for-xorg-1.19"
EGIT_REPO_URI="https://github.com/rasdark/xf86-video-sis671.git"

inherit git-r3 autotools

DESCRIPTION="Xorg video driver for SIS M671/M672"
HOMEPAGE="has no url"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND=">=x11-base/xorg-server-1.19
        >=x11-base/xorg-drivers-1.19
        >=sys-devel/automake-1.15.1"

src_prepare() {
        eautoconf
        eautomake
}

src_configure() {
	econf --prefix=/usr --disable-static
}

src_compile() {
    emake || die "emake failed"
}

pkg_postinst() {
	einfo
	einfo "For 1366x768 resolution on some LCD panels need "
	einfo "  ... Option \"UseTiming1366\" \"true\""
	einfo "  ... in your xorg.conf"
	einfo
}
