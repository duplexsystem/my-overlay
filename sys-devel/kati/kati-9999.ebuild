# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs flag-o-matic meson

DESCRIPTION="An experimental GNU make clone"
HOMEPAGE="https://github.com/google/kati"
SRC_URI=""
EGIT_REPO_URI="https://github.com/duplexsystem/kati.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="symlink"
KEYWORDS="~amd64 ~x86"

BDEPEND="virtual/pkgconfig"

src_compile() {
	meson_src_configure
}

src_install() {
	meson_src_install

	dobin "${ED}"/usr/bin/${PN}
	
	if use symlink; then
		dosym ${PN} /usr/bin/make
	fi
}
