# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs multilib-minimal

DESCRIPTION="An experimental GNU make clone"
HOMEPAGE="https://github.com/google/kati"
SRC_URI=""
EGIT_REPO_URI="https://github.com/google/kati.git"
PATCHES=(
	"${FILESDIR}/kati-fix-implicit-rules-with-no-makefile.patch"
	"${FILESDIR}/add_support.patch"
)

LICENSE="Apache-2.0"
SLOT="0"
IUSE="symlink"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-util/ninja"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" ckati
}

src_install() {
	dobin c${PN}
	
	if use symlink; then
		dosym c${PN} /usr/bin/make
	fi
}
