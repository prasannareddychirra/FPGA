#
# This file is the spiclk recipe.
#

SUMMARY = "Simple spiclk application"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://clock_interface.h \
	   file://krm4zurf_presets.h \
	   file://clock_spi_interface.h \
	   file://clock_spi_interface.c \
	   file://spiclk.c \
	   file://Makefile \
	   file://spiclk-init.sh \
		  "

S = "${WORKDIR}"

inherit update-rc.d

INITSCRIPT_NAME = "spiclk-init"
INITSCRIPT_PARAMS = "start 99 5 ."

do_compile() {
	     oe_runmake
}

do_install() {
	     install -d ${D}${bindir}
	     install -m 0755 spiclk ${D}${bindir}
	     
	     install -d ${D}${sysconfdir}/init.d
	     install -m 0755 ${S}/spiclk-init.sh ${D}${sysconfdir}/init.d/spiclk-init
}

RDEPENDS_${PN}_append += "bash"

