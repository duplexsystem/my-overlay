# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs multilib-minimal

DESCRIPTION="netbsd-libcurses portable edition"
HOMEPAGE="https://github.com/sabotage-linux/netbsd-curses"
SRC_URI="https://github.com/sabotage-linux/netbsd-curses/archive/refs/tags/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE="+doc static-libs"
KEYWORDS="~amd64 ~x86"

RDEPEND="!sys-libs/ncurses"
DEPEND="${RDEPEND}
	sys-devel/make"

src_compile() {
	tc-export AR CC RANLIB
	local BUILD_CC
	tc-export_build_env BUILD_CC
	default
}

src_install() {
	emake PREFIX="${EPREFIX}/usr" DESTDIR="${D}" \
		$(usex static-libs install install-dynlibs) \
		$(usex doc install-manpages "")

	dodoc README.md

	# fix file collisions with attr
	if use doc; then
		rm "${ED%/}/usr/share/man/man3/attr_get.3" || die
		rm "${ED%/}/usr/share/man/man3/attr_set.3" || die
	fi
}
