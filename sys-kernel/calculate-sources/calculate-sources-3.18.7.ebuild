# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
ETYPE="sources"

inherit calculate-kernel-6 eutils

DESCRIPTION="Calculate Linux kernel image"
KEYWORDS="amd64 x86"
HOMEPAGE="http://www.calculate-linux.org"

IUSE="plymouth themes firmware"

DEPEND="vmlinuz? ( || ( app-arch/xz-utils app-arch/lzma-utils )
		sys-apps/v86d
		sys-boot/grub
	)
	firmware? ( sys-kernel/linux-firmware )
	themes? ( media-gfx/plymouth-themes-calculate )
	plymouth? ( sys-boot/plymouth sys-boot/plymouth-openrc-plugin )
	"

RDEPEND="${DEPEND}"

SRC_URI="${KERNEL_URI} ${ARCH_URI}"

src_unpack() {
	calculate-kernel-6_src_unpack
}

pkg_postinst() {
	calculate-kernel-6_pkg_postinst
}
