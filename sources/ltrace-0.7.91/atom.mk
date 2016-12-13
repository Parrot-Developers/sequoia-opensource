
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := ltrace
LOCAL_DESCRIPTION := Trace library call
LOCAL_CATEGORY_PATH := devel

LOCAL_LIBRARIES := libelf

LOCAL_AUTOTOOLS_VERSION := 0.7.91
LOCAL_AUTOTOOLS_ARCHIVE := $(LOCAL_MODULE)-$(LOCAL_AUTOTOOLS_VERSION).tar.bz2
LOCAL_AUTOTOOLS_SUBDIR := $(LOCAL_MODULE)-$(LOCAL_AUTOTOOLS_VERSION)

LOCAL_AUTOTOOLS_PATCHES := \
	ltrace-0.7.91-fix-uninitialized-variables.patch

# Get architecture as ltrace wants it
ifeq ("$(TARGET_ARCH)","x86")
  LTRACE_ARCH := i386
else ifeq ("$(TARGET_ARCH)","x64")
  LTRACE_ARCH := x86_64
else
  LTRACE_ARCH := $(TARGET_ARCH)
endif

LOCAL_AUTOTOOLS_MAKE_BUILD_ARGS := \
	ARCH=$(LTRACE_ARCH)

LOCAL_AUTOTOOLS_MAKE_INSTALL_ARGS := \
	ARCH=$(LTRACE_ARCH)

define LOCAL_AUTOTOOLS_CMD_POST_CONFIGURE
	$(Q) sed -s 's/-o root -g root//' -i $(PRIVATE_SRC_DIR)/Makefile
endef

# Makefile has no 'uninstall' target, so we must clean staging dir.
define LOCAL_AUTOTOOLS_CMD_POST_CLEAN
	$(Q) rm -f $(TARGET_OUT_STAGING)/etc/ltrace.conf
	$(Q) rm -f $(TARGET_OUT_STAGING)/usr/bin/ltrace
	$(Q) rm -f $(TARGET_OUT_STAGING)/usr/man/man1/ltrace.1
	$(Q) rm -rf $(TARGET_OUT_STAGING)/usr/share/doc/ltrace
endef

include $(BUILD_AUTOTOOLS)

