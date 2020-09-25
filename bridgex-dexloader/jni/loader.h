#ifndef __IAP_LOADER_H__
#define __IAP_LOADER_H__

#include <android/log.h>

#define DEBUG_LOADER 1
#define LOG_TAG_LOADER "bridgex-loader"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO,LOG_TAG_LOADER,__VA_ARGS__)
#define LOGW(...) __android_log_print(ANDROID_LOG_WARN,LOG_TAG_LOADER,__VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR,LOG_TAG_LOADER,__VA_ARGS__)
#define LOGD(...) if (DEBUG_LOADER) __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG_LOADER,__VA_ARGS__)
#define LOGV(...) if (DEBUG_LOADER) __android_log_print(ANDROID_LOG_VERBOSE,LOG_TAG_LOADER,__VA_ARGS__)

#endif  // __IAP_LOADER_H__
