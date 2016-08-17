LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE        := lzo
LOCAL_DESCRIPTION   :=                                              \
	LZO is a data compression library which is suitable for data    \
   	de-/compression in real-time. This means it favours speeds      \
   	over compression ratio.                                         \
	See http://www.oberhumer.com/opensource/lzo
LOCAL_CATEGORY_PATH := libs/compression

LOCAL_AUTOTOOLS_VERSION := 2.06
LOCAL_AUTOTOOLS_ARCHIVE := $(LOCAL_MODULE)-$(LOCAL_AUTOTOOLS_VERSION).tar.gz
LOCAL_AUTOTOOLS_SUBDIR  := $(LOCAL_MODULE)-$(LOCAL_AUTOTOOLS_VERSION)

LOCAL_AUTOTOOLS_CONFIGURE_ARGS  := --enable-shared

LOCAL_EXPORT_LDLIBS := -llzo2

include $(BUILD_AUTOTOOLS)
