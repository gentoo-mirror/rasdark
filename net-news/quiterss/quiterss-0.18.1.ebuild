# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/quiterss/quiterss-0.15.4.ebuild,v 1.1 2014/04/26 19:13:54 maksbotan Exp $

EAPI=5
PLOCALES="ar bg cs de el_GR en es fa fi fr gl he hi hu it ja ko lt nl pl pt_BR pt_PT ro_RO ru sk sr sv tg_TJ th_TH tr uk vi zh_CN zh_TW"
PLOCALE_BACKUP="en"

inherit qt4-r2 l10n fdo-mime gnome2-utils eutils

MY_P="QuiteRSS-${PV}-src"
DESCRIPTION="A Qt5-based RSS/Atom feed reader"
HOMEPAGE="https://quiterss.org"
SRC_URI="https://quiterss.org/files/${PV}/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"

IUSE="debug phonon"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsingleapplication
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtwebkit:5
	phonon? ( || ( media-libs/phonon dev-qt/qtphonon:5 ) )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

S="${WORKDIR}/"

DOCS=( AUTHORS HISTORY_EN HISTORY_RU README.md )

src_prepare() {
    l10n_find_plocales_changes "${S}/lang" "${PN}_" '.ts'
}

src_configure() {
        eqmake5 PREFIX="${EPREFIX}/usr" \
                SYSTEMQTSA=1 \
                $(usex phonon '' 'DISABLE_PHONON=1')
}

gen_translation() {
        local mydir
        mydir="$(qt5_get_bindir)"
        ebegin "Generating $1 translation"
        "${mydir}"/lrelease ${PN}_${1}.ts
        eend $? || die "failed to generate $1 translation"
}

src_compile() {
	emake

        cd "${S}"/lang
        l10n_for_each_locale_do gen_translation
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
