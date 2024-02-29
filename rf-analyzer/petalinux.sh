#!/bin/bash
##
## Builds the PetaLinux project
##

#
# User configurations / project layout
# -----------------------------------------------------------------------------
XILINX_VERSION=2019.1
WS=$(cd "./"; pwd) #full path
PRJ_NAME=petalinux 
BITSTREAM_NAME="system"
TEMPLATE="zynqMP"
#DEFAULT_CONFIG=$(cd "../petalinux/config/"; pwd)
# -----------------------------------------------------------------------------

# mandatory for PetaLinux
SHELL=/bin/bash 

USAGE="
Usage: $0 [operation]

Operation:
  all                    : build and install the project
  build                  : build the full project
  build-[component]      : build only the select component
  clean                  : clean up the project build
  config                 : edit full project configuration
  config-[component]     : edit component configuration
  distclean              : clean up the project build and the generated bootable images
  init                   : initilize a new project with default configurations
  package                : create the BOOT.bin with the FPGA bitstream and u-boot
  shell                  : sent environment shell (/bin/bash)
  
Component:
  kernel
  rootfs
  u-boot
    
"

#
# PetaLinux project functions
# -----------------------------------------------------------------------------

# load PetaLinux configurations. Uses workaround to avoid passing this script
# arguments to PetaLinux settings
function source_petalinux {
	SETTINGS=/opt/Xilinx/PetaLinux/$XILINX_VERSION/settings.sh
	echo "Sourcing ${SETTINGS}"
	source ${SETTINGS} >> /dev/null 2>&1
	[ $? != 0 ] && echo "ERROR: Loading PetaLinux. $?" && exit 1;	
}


function init_petalinux {
	petalinux-create --type project --template ${TEMPLATE} --name ${PRJ_NAME}
	(cd ${PRJ_NAME} && petalinux-config --get-hw-description=$OUTPUTS_DIR)
}


#
# main
# -----------------------------------------------------------------------------
# create or reset petalinux project
		
#look for the Xilinx SDK project folder and abort if can not found it
OUTPUTS_DIR=$(find "${WS}" -maxdepth 1 -type d -name "images")
[ ! -d "${OUTPUTS_DIR}" ] && echo "Invalid OUTPUTS_DIR path ${OUTPUTS_DIR}" && exit 1

#load PetaLinux if needed
if ! [ -x "$(command -v petalinux-config)" ]; then
	source_petalinux
fi

case "$1" in
	"all")
		$0 init && $0 build && $0 package
		[ $? == 0 ] && echo -e "Build complete. To install it on a SD Card type\n$0 install."
		;;
	"build")
		(cd $WS/${PRJ_NAME} && petalinux-build)
		;;
	"build-"*)
		# forward the name of the component config-{linux,rootfs,u-boot}
		(cd $WS/${PRJ_NAME} && petalinux-build -c ${1:6})
		;;
	"clean")
		(cd $WS/${PRJ_NAME} && petalinux-build -x mrproper)
		;;
	"config")
		(cd $WS/${PRJ_NAME} && petalinux-config -v)
		;;
	"config-"*)
		# forward the name of the component config-{linux,rootfs,u-boot}
		(cd $WS/${PRJ_NAME} && petalinux-config -c ${1:7})
		;;
	"distclean")
		# clean up the project build and the generated bootable images
		(cd $WS/${PRJ_NAME} && petalinux-build -x distclean)
		;;
	"help")
		echo "${USAGE}";
		;;
	"init")
		(cd $WS && init_petalinux)
		;;
	"package")
		(cd ${WS}/${PRJ_NAME}/images/linux && petalinux-package --force --boot --fsbl --fpga --u-boot)
		;;
	"shell")
    (cd $WS/${PRJ_NAME} && ${SHELL})
		;;
	*)
		echo -e "\nInvalid parameters.\n${USAGE}"; exit 1;;
esac

#return last command result
exit $?

