#ifndef __UTILS_H__
#define __UTILS_H__

#include <jni.h>
#include <android/log.h>
#include <android/asset_manager_jni.h>
#include <android/asset_manager.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <cctype>
#include <assert.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <dirent.h>
#include "conf.h"
#include "md5.h"

#define DEBUG_UTILS 1
#define LOG_TAG_UTILS "bridgex-utils"
#define LOGI_UTILS(...) __android_log_print(ANDROID_LOG_INFO,LOG_TAG_UTILS,__VA_ARGS__)
#define LOGW_UTILS(...) __android_log_print(ANDROID_LOG_WARN,LOG_TAG_UTILS,__VA_ARGS__)
#define LOGE_UTILS(...) __android_log_print(ANDROID_LOG_ERROR,LOG_TAG_UTILS,__VA_ARGS__)
#define LOGD_UTILS(...) if (DEBUG_UTILS) __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG_UTILS,__VA_ARGS__)
#define LOGV_UTILS(...) if (DEBUG_UTILS) __android_log_print(ANDROID_LOG_VERBOSE,LOG_TAG_UTILS,__VA_ARGS__)

using namespace std;

namespace utils {
char* replace_all(char const * const original, char const * const pattern, char const * const replacement);
void throw_exception(JNIEnv* env, const char* exception_clazz, const char* message);
bool check_exception(JNIEnv* env, bool is_throw);
bool check_exception(JNIEnv* env);
int api_version(JNIEnv* env);
void show_class_path(JNIEnv* env, jobject self);
jclass find_class(JNIEnv* env, const char* class_path);
jmethodID get_method_ID(JNIEnv* env, bool* p_exception, jclass clazz, const char* method, const char* sig);
jmethodID get_static_method_ID(JNIEnv* env, jclass clazz, const char* method, const char* sig);
jvalue invoke_method_by_name(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, va_list args);
jvalue invoke_static_method_by_name(JNIEnv* env, bool* p_exception, jclass clazz, const char* method, const char* sig, va_list args);
jvalue invoke_method(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, va_list args);
jvalue invoke_method(JNIEnv* env, bool* p_exception, jobject p_obj, const char* method, const char* sig, va_list args);
void invoke_void_method(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, ...);
void invoke_void_method(JNIEnv* env, bool* p_exception, jobject p_obj, const char* method, const char* sig, ...);
jobject invoke_object_method(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, ...);
jobject invoke_object_method(JNIEnv* env, bool* p_exception, jobject p_obj, const char* method, const char* sig, ...);
jstring invoke_string_method(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, ...);
jstring invoke_string_method(JNIEnv* env, bool* p_exception, jobject p_obj, const char* method, const char* sig, ...);
jint invoke_int_method(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, ...);
jint invoke_int_method(JNIEnv* env, bool* p_exception, jobject p_obj, const char* method, const char* sig, ...);
jint invoke_bool_method(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, ...);
jint invoke_bool_method(JNIEnv* env, bool* p_exception, jobject p_obj, const char* method, const char* sig, ...);
jobject invoke_static_object_method(JNIEnv* env, bool* p_exception, jclass clazz, const char* method, const char* sig, ...);
void invoke_static_void_method(JNIEnv* env, bool* p_exception, jclass clazz, const char* method, const char* sig, ...);
jobject invoke_init_method(JNIEnv* env, bool* p_exception, jclass clazz, const char* sig, ...);
jobject get_field(JNIEnv* env, jobject obj, const char* field, const char* sig);
void set_field(JNIEnv* env, jobject obj, const char* field, const char* sig, jobject value);
jobject get_context(JNIEnv* env);
char* make_file_md5(JNIEnv* env, const char* file_path);
char* make_asset_file_md5(JNIEnv* env, const char* file_name);
jobject get_asset_java(JNIEnv* env);
int get_value_int(const char* value);
bool get_value_bool(const char* value);
void string2hex(const char* src, BYTE* target);
void hex2string(const BYTE* data, int datasize, char *strp);
char* as_char_array(JNIEnv* env, jcharArray array);
BYTE* as_byte_array(JNIEnv* env, jbyteArray array);
jbyteArray as_jbyte_array(JNIEnv* env, const BYTE* buf, jsize len);
char* return_char(JNIEnv* env, jbyteArray jbyte_arr);
jstring return_jstring(JNIEnv* env, const char* pat);
unsigned int get_file_size(int fd);
bool enable_open_file(const char* file_path);
void close_file(int fd);
bool delete_file(const char* file_path);
bool create_file(const char* file_path);
char* pnew_arr(int p_size);
BYTE* pnew_arr2(int p_size);
void pdelete(char* p);
void pdelete2(BYTE* p);
int str_len(const char* p);
int str_len2(const BYTE* p);
int read_file(const char* file_path, char** file_buffer);
int read_file2(const char* file_path, BYTE** file_buffer);
void write_file(const char* file_path, char* file_buffer, int numBytesRead);
void write_file2(const char* file_path, BYTE* file_buffer, int numBytesRead);
void copy_file(jobject context, const char* file_path, char* file_buffer, int numBytesRead);
void copy_file2(jobject context, const char* file_path, BYTE* file_buffer, int numBytesRead);
int get_asset_content(JNIEnv* env, const char* file_name, char** asset_buf);
int get_asset_content2(JNIEnv* env, const char* file_name, BYTE** asset_buf);

#if CPP
template<typename U = char>
U* pnew_arr(int p_size) {
    assert(p_size > 0);

    U* pu = new U[p_size];
    assert(pu != NULL);
    memset(pu, 0, p_size);

    return pu;
}
#endif

#if CPP
template<typename U = char, typename ... ARGS>
U* pnew(ARGS ... args) {
    U* pu = new U(args...);
    assert(pu != NULL);

    return pu;
}
#endif

#if CPP
template<typename U = char>
void pdelete(U* p) {
    assert(p != NULL);

    delete p;
}
#endif

#if CPP
template<typename U = char>
int str_len(const U* p) {
    const U* tmp = p;
    while (*tmp)
    ++tmp;
    return tmp - p;
}
#endif

#if CPP
template<typename U = char>
int read_file(const char* file_path, U** file_buffer) {
    int ret = 0;

    int fd = open(file_path, O_RDONLY | O_EXCL);
    if (fd != -1) {
        int file_size = get_file_size(fd);
        if (file_size <= 0) {
            LOGE_UTILS("Failed to get %s size.", file_path);

            if (remove(file_path) != 0) {
                LOGE_UTILS("Failed to delete file %s.", file_path);
            }

            goto END;
        }

        *file_buffer = pnew_arr<U>(file_size + 1);
        ret = read(fd, *file_buffer, file_size);
        LOGD_UTILS("Read %s (%d)", file_path, ret);
    }

    END: close(fd);

    return ret;
}
#endif

#if CPP
template<typename U = char>
void write_file(const char* file_path, U* file_buffer, int numBytesRead = 0) {
    int fd = open(file_path, O_WRONLY | O_CREAT, 0640);
    if (fd != -1) {
        if (numBytesRead == 0) {
            numBytesRead = str_len(file_buffer);
        }

        int ret = write(fd, file_buffer, numBytesRead);
        if (ret > 0) {
            LOGD_UTILS("Success to write %s.", file_path);
        } else {
            LOGE_UTILS("Failed to write %s.", file_path);
        }
    }

    END: close(fd);
}
#endif

#if CPP
template<typename U = char>
void copy_file(jobject context, const char* file_path, U* file_buffer,
        int numBytesRead = 0) {
    delete_file(file_path);

    int fd = open(file_path, O_WRONLY | O_CREAT, 0640);
    if (fd != -1) {
        if (numBytesRead == 0) {
            numBytesRead = str_len(file_buffer);
        }

        int ret = write(fd, file_buffer, numBytesRead);
        if (ret > 0) {
            LOGD_UTILS("Success to copy %s(%d).", file_path, ret);
        } else {
            LOGE_UTILS("Failed to copy %s(%d).", file_path, ret);
            goto END;
        }

        int fd_new = open(file_path, O_RDONLY | O_EXCL);
        if (fd_new != -1) {
            int file_size = get_file_size(fd_new);
            if (file_size > 0) {
                LOGD_UTILS("Success to copy %s.", file_path);
            } else {
                LOGE_UTILS("Failed to copy %s.", file_path);
            }
        }
        close(fd_new);
    } else {
        LOGE_UTILS("Failed to create %s.", file_path);
    }

    END: close(fd);
}
#endif

#if CPP
template<typename Ch = char>
int get_asset_content(JNIEnv* env, const char* file_name, Ch** asset_buf) {
    jobject assetManager = get_asset_java(env);
    AAssetManager* assetMgr = AAssetManager_fromJava(env, assetManager);
    assert(assetMgr != NULL);

    AAsset* asset = AAssetManager_open(assetMgr, file_name,
            AASSET_MODE_UNKNOWN);
    assert(asset != NULL);

    off_t bufferSize = AAsset_getLength(asset);
    *asset_buf = pnew_arr<Ch>(bufferSize + 1);
    int numBytesRead = AAsset_read(asset, *asset_buf, bufferSize);
    AAsset_close(asset);

    env->DeleteLocalRef(assetManager);

    return numBytesRead;
}
#endif
} // utils

#endif // __UTILS_H__
