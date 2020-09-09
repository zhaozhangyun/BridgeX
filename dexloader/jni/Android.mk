# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
LOCAL_PATH := $(call my-dir)

$(info $(LOCAL_PATH))
$(info $(SYSROOT))

include $(CLEAR_VARS)

LOCAL_MODULE := bridgex-core

LOCAL_SRC_FILES := \
                   loader.cpp \
                   conf.cpp \
                   utils.cpp \
                   md5.cpp \

LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib
LOCAL_LDLIBS += -lm -llog -landroid -ldl

#ifeq ($(TARGET_ARCH),mips)
#    LOCAL_LDFLAGS += -Wl,--gc-sections
#else
#    LOCAL_LDFLAGS += -Wl,--gc-sections,--icf=safe
#endif
LOCAL_LDFLAGS += -Wl,--gc-sections
LOCAL_LDFLAGS += -shared
LOCAL_LDFLAGS += -fPIC
LOCAL_LDFLAGS += -Wall

LOCAL_CPPFLAGS := -Wno-write-strings
LOCAL_CPPFLAGS += -std=c++11 -std=gnu++11
LOCAL_CPPFLAGS += -ffunction-sections -fdata-sections -fvisibility=hidden
LOCAL_CFLAGS := -ffunction-sections -fdata-sections

include $(BUILD_SHARED_LIBRARY)
