#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
#branch?=master
branch?=$(shell git rev-parse --abbrev-ref HEAD)
export branch

default: GNUmakefile
	${MAKE} rule/override/default

%: rule/override/help
