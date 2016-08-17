LOCAL_PATH := $(call my-dir)

###############################################################################
# mtd
###############################################################################

include $(CLEAR_VARS)

LOCAL_MODULE := mtd
LOCAL_DESCRIPTION := MTD, UBI and UBIFS userland tools
LOCAL_CATEGORY_PATH := fs

LOCAL_LIBRARIES := zlib

LOCAL_AUTOTOOLS_VERSION := 1.5.1
LOCAL_AUTOTOOLS_ARCHIVE := mtd-utils-$(LOCAL_AUTOTOOLS_VERSION).tar.gz
LOCAL_AUTOTOOLS_SUBDIR := mtd-utils-9f10713

MTD_BUILD_DIR := $(call local-get-build-dir)/$(LOCAL_AUTOTOOLS_SUBDIR)

LOCAL_AUTOTOOLS_PATCHES := \
	mtd-utils-1.5.1-no-mkfs.patch \
	mtd-utils-1.5.1-uninstall.patch \
	mtd-utils-1.5.1-nandwrite-skip-empty-bad.patch \
	mtd-utils-1.5.1-nandwrite-end-warnings.patch

LOCAL_CFLAGS := \
	-I$(MTD_BUILD_DIR)/include \
	-I$(MTD_BUILD_DIR)/ubi-utils/include \
	-I$(MTD_BUILD_DIR)/ubi-utils/src

# Compiler (from default autotools env) shall be given as arg to override mtd
# makefile. CFLAGS arguments are accumulated to global ones in make cmd line
# Parallel build sometimes fails, force -j1
LOCAL_AUTOTOOLS_MAKE_BUILD_ARGS := \
	$(AUTOTOOLS_CONFIGURE_ENV) \
	WITHOUT_LZO=1 \
	CFLAGS+="$(LOCAL_CFLAGS)" \
	-j1

# Skip configure step
define LOCAL_AUTOTOOLS_CMD_CONFIGURE
	$(empty)
endef

include $(BUILD_AUTOTOOLS)
