#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
bsp?=generic
board_family?=${bsp}x86
board_variant?=64
MACHINE?=${board_family}-${board_variant}
machine?=${MACHINE}
machines?=${machine}
os?=oe
os_profile?=
distro?=poky
distro_conf?=${distro}-ivi-systemd
extra?=
init_name?=${os}${os_profile}
base_image?=genivi-demo-platform
image?=${base_image}
images?=${base_image} \
 #eol

sources_name?=sources-${MACHINE}
sources_layers_conf+=$(sort $(wildcard ${sources_name}/meta-*/conf/layer.conf))
sources_layers_conf+=${sources_name}/meta-openembedded/meta-oe/conf/layer.conf
sources_layers_conf+=${sources_name}/meta-openembedded/meta-ruby/conf/layer.conf
sources_layers_conf+=${sources_name}/meta-ivi/meta-ivi/conf/layer.conf
sources_layers_conf+=${sources_name}/meta-ivi/meta-ivi-bsp/conf/layer.conf
#sources_layers_conf+=${sources_name}/meta-ivi/meta-ivi-demo/conf/layer.conf

rule/overide/configure-conf: rule/configure-conf
	sed -e 's|^DISTRO.*=.*|DISTRO ?= "poky-ivi-systemd"|g' -i ${conf_file}

rule/overide/patch/meta-genivi-demo: ${sources_name}/meta-genivi-demo/conf/layer.conf 
	sed -e 's|BBFILE_PRIORITY_genividemo = "7"|BBFILE_PRIORITY_genividemo = "8"|g' -i $<

rule/overide/patch: rule/overide/patch/meta-genivi-demo
