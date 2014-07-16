#!/bin/sh
#
# Copyright (c) 2009-2014 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

. ${DIR}/version.sh
if [ -f ${DIR}/system.sh ] ; then
	. ${DIR}/system.sh
fi

git="git am"
#git_patchset=""
#git_opts

if [ "${RUN_BISECT}" ] ; then
	git="git apply"
fi

echo "Starting patch.sh"

git_add () {
	git add .
	git commit -a -m 'testing patchset'
}

start_cleanup () {
	git="git am --whitespace=fix"
}

cleanup () {
	if [ "${number}" ] ; then
		git format-patch -${number} -o ${DIR}/patches/
	fi
	exit
}

external_git () {
	git_tag=""
	echo "pulling: ${git_tag}"
	git pull ${git_opts} ${git_patchset} ${git_tag}
}

local_patch () {
	echo "dir: dir"
	${git} "${DIR}/patches/dir/0001-patch.patch"
}

#external_git
#local_patch

dts () {
	echo "dir: dts"
	${git} "${DIR}/patches/dts/0001-arm-dts-am335x-boneblack-lcdc-add-panel-info.patch"
	${git} "${DIR}/patches/dts/0002-arm-dts-am335x-boneblack-add-cpu0-opp-points.patch"
	${git} "${DIR}/patches/dts/0003-arm-dts-am335x-bone-common-enable-and-use-i2c2.patch"
	${git} "${DIR}/patches/dts/0004-arm-dts-am335x-bone-common-setup-default-pinmux-http.patch"
}

fixes () {
	echo "dir: fixes"
	${git} "${DIR}/patches/fixes/0001-pinctrl-pinctrl-single-must-be-initialized-early.patch"
	${git} "${DIR}/patches/fixes/0002-tps65217-Enable-KEY_POWER-press-on-AC-loss-PWR_BUT.patch"
	${git} "${DIR}/patches/fixes/0003-am335x-bone-common-enable-ti-pmic-shutdown-controlle.patch"
	${git} "${DIR}/patches/fixes/0004-dt-bone-common-Add-interrupt-for-PMIC.patch"
	${git} "${DIR}/patches/fixes/0005-cpsw-Add-support-for-byte-queue-limits.patch"
	${git} "${DIR}/patches/fixes/0006-cpsw-napi-polling-of-64-is-good-for-gigE-less-good-f.patch"
	${git} "${DIR}/patches/fixes/0007-cpsw-search-for-phy.patch"
}

usb  () {
	echo "dir: usb"
	${git} "${DIR}/patches/usb/0001-usb-musb-musb_host-Enable-ISOCH-IN-handling-for-AM33.patch"
	${git} "${DIR}/patches/usb/0002-usb-musb-musb_cppi41-Make-CPPI-aware-of-high-bandwid.patch"
	${git} "${DIR}/patches/usb/0003-usb-musb-musb_cppi41-Handle-ISOCH-differently-and-no.patch"
}

reset () {
	echo "dir: reset"
	${git} "${DIR}/patches/reset/0001-drivers-reset-TI-SoC-reset-controller-support.patch"
	${git} "${DIR}/patches/reset/0002-ARM-TI-Describe-the-ti-reset-DT-entries.patch"
	${git} "${DIR}/patches/reset/0003-ARM-dts-am33xx-Add-prcm_resets-node.patch"
	${git} "${DIR}/patches/reset/0004-ARM-dts-am4372-Add-prcm_resets-node.patch"
	${git} "${DIR}/patches/reset/0005-ARM-dts-dra7-Add-prm_resets-node.patch"
	${git} "${DIR}/patches/reset/0006-ARM-dts-omap5-Add-prm_resets-node.patch"
	${git} "${DIR}/patches/reset/0007-SGX-reset-function-needed.patch"
}

sgx () {
	echo "dir: sgx"
#	${git} "${DIR}/patches/sgx/0001-reset-Add-driver-for-gpio-controlled-reset-pins.patch"
#	${git} "${DIR}/patches/sgx/0002-prcm-port-from-ti-linux-3.12.y.patch"
	${git} "${DIR}/patches/sgx/0003-ARM-DTS-AM335x-Add-SGX-DT-node.patch"
	${git} "${DIR}/patches/sgx/0004-arm-Export-cache-flush-management-symbols-when-MULTI.patch"
#	${git} "${DIR}/patches/sgx/0005-hack-port-da8xx-changes-from-ti-3.12-repo.patch"
#	${git} "${DIR}/patches/sgx/0006-Revert-drm-remove-procfs-code-take-2.patch"
	${git} "${DIR}/patches/sgx/0007-Changes-according-to-TI-for-SGX-support.patch"
}

dts_bone () {
	echo "dir: dts-bone"
	${git} "${DIR}/patches/dts-bone/0001-arm-dts-am335x-bone-common-add-uart2_pins-uart4_pins.patch"

}

dts_bone_capes () {
	echo "dir: dts-bone-capes"
	${git} "${DIR}/patches/dts-bone-capes/0001-capes-ttyO1-ttyO2-ttyO4.patch"
	${git} "${DIR}/patches/dts-bone-capes/0002-capes-Makefile.patch"
}

static_capes () {
	echo "dir: static-capes"
	${git} "${DIR}/patches/static-capes/0001-Added-Argus-UPS-cape-support.patch"
	${git} "${DIR}/patches/static-capes/0002-Added-Argus-UPS-cape-support-BBW.patch"
	${git} "${DIR}/patches/static-capes/0003-dts-bone-argus-fix-usb.patch"
	${git} "${DIR}/patches/static-capes/0004-ARM-dts-am335x-boneblack-cape-audi.patch"
}

saucy () {
	echo "dir: saucy"
	#Ubuntu Saucy: so Ubuntu decided to enable almost every Warning -> Error option...
	${git} "${DIR}/patches/saucy/0001-saucy-disable-Werror-pointer-sign.patch"
	${git} "${DIR}/patches/saucy/0002-saucy-error-variable-ilace-set-but-not-used-Werror-u.patch"
}

rt () {
	echo "dir: rt"
	${git} "${DIR}/patches/rt/0001-rt-3.14-patchset.patch"
}

###
dts
fixes
#usb
reset

dts_bone
dts_bone_capes
static_capes

#sgx

#saucy

#disabled by default
#rt

packaging_setup () {
	cp -v "${DIR}/3rdparty/packaging/builddeb" "${DIR}/KERNEL/scripts/package"
	git commit -a -m 'packaging: sync with mainline' -s

	git format-patch -1 -o "${DIR}/patches/packaging"
}

packaging () {
	echo "dir: packaging"
	${git} "${DIR}/patches/packaging/0001-packaging-sync-with-mainline.patch"
	${git} "${DIR}/patches/packaging/0002-deb-pkg-install-dtbs-in-linux-image-package.patch"
}

#packaging_setup
packaging
echo "patch.sh ran successful"
