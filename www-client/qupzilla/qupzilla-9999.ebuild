# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

	EGIT_REPO_URI="git://github.com/QupZilla/${PN}.git"

PLOCALES="ar_SA bg_BG ca_ES cs_CZ de_DE el_GR es_ES es_MX es_VE eu_ES fa_IR fi_FI fr_FR gl_ES he_IL hu_HU id_ID it_IT ja_JP ka_GE lg lv_LV nl_NL nqo pl_PL pt_BR pt_PT ro_RO ru_RU sk_SK sr@ijekavianlatin sr@ijekavian sr@latin sr sv_SE tr_TR uk_UA uz@Latn zh_CN zh_TW"

inherit l10n multilib qmake-utils git-r3

DESCRIPTION="Qt WebKit web browser"
HOMEPAGE="http://www.qupzilla.com/"

LICENSE="GPL-3"
SLOT="0"
IUSE="dbus debug kde nonblockdialogs"
KEYWORDS=""

DEPEND="
	dev-lang/python:2.7[xml]
        >=dev-qt/qtcore-5.6.0
        >=dev-qt/qtgui-5.6.0
        >=dev-qt/qtconcurrent-5.6.0
        >=dev-qt/qtprintsupport-5.6.0
        >=dev-qt/qtscript-5.6.0
        >=dev-qt/qtsql-5.6.0[sqlite]
        >=dev-qt/qtwebengine-5.6.0[widgets]
 		>=dev-qt/qtdeclarative-5.6.0[widgets]
		>=dev-qt/qtx11extras-5.6.0
        dbus? ( >=dev-qt/qtdbus-5.6.0 )"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS BUILDING CHANGELOG FAQ README.md )

src_prepare() {
	rm_loc() {
		sed -i -e "/${1}.ts/d" translations/translations.pri || die
		rm translations/${1}.ts || die
	}
	# remove outdated copies of localizations:
	rm -r bin/locale || die
	# remove empty locale
	rm translations/empty.ts || die

	l10n_find_plocales_changes "translations" "" ".ts"
	l10n_for_each_disabled_locale_do rm_loc
}

src_configure() {
        export \
                QUPZILLA_PREFIX="${EPREFIX}/usr/" \
                USE_LIBPATH="${EPREFIX}/usr/$(get_libdir)" \
                USE_QTWEBKIT_2_2=true \
                DISABLE_DBUS=$(usex dbus '' 'true') \
                KDE_INTEGRATION=$(usex kde 'true' '') \
                NONBLOCK_JS_DIALOGS=$(usex nonblockdialogs 'true' '')
	eqmake5
}

src_install() {
        emake INSTALL_ROOT="${D}" install
        einstalldocs
}
