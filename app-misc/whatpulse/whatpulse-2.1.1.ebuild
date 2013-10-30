# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Benchmark your computer habits"

HOMEPAGE="http://www.whatpulse.org/"

SRC_URI="
	x86?	( http://amcdn.whatpulse.org/files/whatpulse-linux-32bit-${PV}.tar.gz )
	amd64?	( http://amcdn.whatpulse.org/files/whatpulse-linux-64bit-${PV}.tar.gz )
"


LICENSE="MIT"

SLOT="0"

KEYWORDS="-* x86 amd64"

IUSE="network"

RDEPEND="${DEPEND} dev-qt/qtwebkit dev-qt/qtsql
	network? ( net-libs/libpcap )"

src_unpack() {
	mkdir "${S}"
	cd "${S}"
	unpack ${A}
}

src_install() {
	echo ${S}
	echo ${D}
	mkdir -p ${D}usr/bin
	cp -pPR "${S}"/whatpulse "${D}"usr/bin || die "Installation failed"
	echo ${S}

	mkdir -p ${D}lib/udev/rules.d
    echo "KERNEL==\"event*\",       NAME=\"input/%k\", MODE=\"640\", GROUP=\"input\"" >> ${D}lib/udev/rules.d/99-whatpulse-input.rules
}

pkg_postinst() {
	enewgroup input
	echo "Created group 'input'."
	elog "To be able to use WhatPulse add your user to the 'input' group"
	elog "This can be done using this command:"
	elog "gpasswd -a \$USER input"
	elog ""
	elog "You also have to reboot to make sure the UDEV rules are aplied"
}
