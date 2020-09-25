#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <dlfcn.h>
#include <limits.h>
#include <sys/system_properties.h>
#include <dlfcn.h>
#include "utils.h"

static const BYTE chartype_table[256] = { 55, 0, 0, 0, 0, 0, 0, 0, 0, 12, 12, 0,
        0, 63, 0,
        0, // 0-15
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, // 16-31
        8, 0, 6, 0, 0, 0, 7, 6, 0, 0, 0, 0, 0, 96, 64,
        0, // 32-47
        64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 192, 0, 1, 0, 48,
        0, // 48-63
        0, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
        192, // 64-79
        192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 0, 0, 16, 0,
        192, // 80-95
        0, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
        192, // 96-111
        192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 0, 0, 0, 0,
        0, // 112-127
        192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
        192,
        192, // 128+
        192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
        192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
        192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
        192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
        192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
        192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
        192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
        192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192, 192 };

#define PUGI__IS_CHARTYPE_IMPL(c, ct, table) (table[static_cast<BYTE>(c)] & (ct))
#define PUGI__IS_CHARTYPE(c, ct) PUGI__IS_CHARTYPE_IMPL(c, ct, chartype_table)

// Simple static assertion
#define PUGI__STATIC_ASSERT(cond) { static const char condition_failed[(cond) ? 1 : -1] = {0}; (void)condition_failed[0]; }

using namespace std;

namespace utils {
//https://github.com/ssllab/temper1/blob/722991add4a6a239271e1f029ebe4daaad719496/strreplace.c
char* replace_all(char const * const original, char const * const pattern, char const * const replacement) {
    int const replen = strlen(replacement);
    int const patlen = strlen(pattern);
    int const orilen = strlen(original);

    int patcnt = 0;
    const char * oriptr;
    const char * patloc;

    // find how many times the pattern occurs in the original string
    for (oriptr = original; (patloc = strstr(oriptr, pattern)); oriptr = patloc + patlen) {
        patcnt++;
    }

    {
        // allocate memory for the new string
        int const retlen = orilen + patcnt * (replen - patlen);
        char * const returned = (char*) malloc(sizeof(char) * (retlen + 1));

        if (returned != NULL) {
            // copy the original string,
            // replacing all the instances of the pattern
            char * retptr = returned;
            for (oriptr = original; (patloc = strstr(oriptr, pattern));
                    oriptr = patloc + patlen) {
                int const skplen = patloc - oriptr;
                // copy the section until the occurence of the pattern
                strncpy(retptr, oriptr, skplen);
                retptr += skplen;
                // copy the replacement
                strncpy(retptr, replacement, replen);
                retptr += replen;
            }
            // copy the rest of the string.
            strcpy(retptr, oriptr);
        }
        return returned;
    }
}

void throw_exception(JNIEnv* env, const char* exception_clazz, const char* message) {
    jclass clazz = NULL;

    clazz = find_class(env, exception_clazz);
    if (!clazz) {
        goto END;
    }

    env->ThrowNew(clazz, message);

    END: env->DeleteLocalRef(clazz);
}

bool check_exception(JNIEnv* env, bool is_throw) {
    bool result = JNI_FALSE;

    jthrowable exec = env->ExceptionOccurred();

    if (exec) {
        if (is_throw) {
            env->ExceptionDescribe();
            env->ExceptionClear();
            env->Throw(exec);
        } else {
            env->ExceptionClear();
        }

        result = JNI_TRUE;
    }

    env->DeleteLocalRef(exec);

    return result;
}

bool check_exception(JNIEnv* env) {
    return check_exception(env, false);
}

int api_version(JNIEnv* env) {
    jclass versionClass = env->FindClass("android/os/Build$VERSION");
    jfieldID sdkIntFieldID = env->GetStaticFieldID(versionClass, "SDK_INT",
            "I");
    int sdkInt = env->GetStaticIntField(versionClass, sdkIntFieldID);
    return sdkInt;
}

void show_class_path(JNIEnv* env, jobject self) {
    jclass cls = env->GetObjectClass(self);

    // First get the class object
    jmethodID mid = env->GetMethodID(cls, "getClass", "()Ljava/lang/Class;");
    jobject clsObj = env->CallObjectMethod(self, mid);

    // Now get the class object's class descriptor
    cls = env->GetObjectClass(clsObj);

    // Find the getName() method on the class object
    mid = env->GetMethodID(cls, "getName", "()Ljava/lang/String;");

    // Call the getName() to get a jstring object back
    jstring strObj = (jstring) env->CallObjectMethod(clsObj, mid);

    // Now get the c string from the java jstring object
    const char* str = env->GetStringUTFChars(strObj, NULL);

    // Print the class name
    LOGD_UTILS("Calling class is: %s", str);

    // Release the memory pinned char array
    env->ReleaseStringUTFChars(strObj, str);
}

jclass find_class(JNIEnv* env, const char* clazz) {
    jclass cls = NULL;

    cls = env->FindClass(clazz);
    if (cls == NULL && check_exception(env))
        ;

    return cls;
}

#if (__ANDROID_API__ >= 21)
// Android 'L' makes __system_property_get a non-global symbol.
// Here we provide a stub which loads the symbol from libc via dlsym.
typedef int (*PFN_SYSTEM_PROP_GET)(const char *, char *);
int __system_property_get(const char* name, char* value)
{
    static PFN_SYSTEM_PROP_GET __real_system_property_get = NULL;
    if (!__real_system_property_get)
    {
        // libc.so should already be open, get a handle to it.
        void *handle = dlopen("libc.so", RTLD_NOLOAD);
        if (!handle)
        {
            __android_log_print(ANDROID_LOG_ERROR, "foobar", "Cannot dlopen libc.so: %s.\n", dlerror());
        } else
        {
            __real_system_property_get = (PFN_SYSTEM_PROP_GET)dlsym(handle, "__system_property_get");
        }
        if (!__real_system_property_get)
        {
            __android_log_print(ANDROID_LOG_ERROR, "foobar", "Cannot resolve __system_property_get(): %s.\n", dlerror());
        }
    }
    return (*__real_system_property_get)(name, value);
}
#endif // __ANDROID_API__ >= 21
char parse_method_sig_return(JNIEnv* env, const char* sig) {
    const char *p = sig;
    while (*p != ')')
        p++;
    p++;

    return *p;
}

jmethodID get_method_ID(JNIEnv* env, bool* p_exception, jclass clazz, const char* method, const char* sig) {
    jmethodID mid = NULL;

    mid = env->GetMethodID(clazz, method, sig);
    if (p_exception ? *p_exception = check_exception(env) : check_exception(env))
        ;

    return mid;
}

jmethodID get_static_method_ID(JNIEnv* env, bool* p_exception, jclass clazz, const char* method, const char* sig) {
    jmethodID mid = NULL;

    mid = env->GetStaticMethodID(clazz, method, sig);
    if (p_exception ?
            *p_exception = check_exception(env) : check_exception(env))
        ;

    return mid;
}

jmethodID get_static_method_ID(JNIEnv* env, jclass clazz, const char* method, const char* sig) {
    return get_static_method_ID(env, NULL, clazz, method, sig);
}

void init_jvalue(jvalue* pv) {
    (*pv).z = false;
    (*pv).b = 0;
    (*pv).c = 0;
    (*pv).s = 0;
    (*pv).i = 0;
    (*pv).j = 0L;
    (*pv).f = 0.0f;
    (*pv).d = 0.0f;
    (*pv).l = NULL;
}

static jvalue* nulljvalue() {
    static jvalue v;

    v.z = false;
    v.b = 0;
    v.c = 0;
    v.s = 0;
    v.i = 0;
    v.j = 0L;
    v.f = 0.0f;
    v.d = 0.0f;
    v.l = NULL;

    return &v;
}

/**
 typedef union jvalue
 {
 jboolean z;
 jbyte b;
 jchar c;
 jshort s;
 jint i;
 jlong j;
 jfloat f;
 jdouble d;
 jobject l;
 } jvalue;
 */
jvalue invoke_method_by_name(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, va_list args) {
    jvalue result;
    jmethodID mid = NULL;
    char ch = '\0';

    init_jvalue(&result);

    mid = get_method_ID(env, p_exception, clazz, method, sig);
    if (*p_exception) {
        //LOGE_UTILS("Failed to get method: %s", method);
        goto END;
    }

    ch = parse_method_sig_return(env, sig);
    switch (ch) {
    case 'V':
        env->CallVoidMethodV(p_obj, mid, args);
        break;
    case '[':
    case 'L':
        result.l = env->CallObjectMethodV(p_obj, mid, args);
        break;
    case 'Z':
        result.z = env->CallBooleanMethodV(p_obj, mid, args);
        break;
    case 'B':
        result.b = env->CallByteMethodV(p_obj, mid, args);
        break;
    case 'C':
        result.c = env->CallCharMethodV(p_obj, mid, args);
        break;
    case 'S':
        result.s = env->CallShortMethodV(p_obj, mid, args);
        break;
    case 'I':
        result.i = env->CallIntMethodV(p_obj, mid, args);
        break;
    case 'J':
        result.j = env->CallLongMethodV(p_obj, mid, args);
        break;
    case 'F':
        result.f = env->CallFloatMethodV(p_obj, mid, args);
        break;
    case 'D':
        result.d = env->CallDoubleMethodV(p_obj, mid, args);
        break;
    }

    if (p_exception ? *p_exception = check_exception(env) : check_exception(env))
        goto END;

    END: ;

    return result;
}

/**
 typedef union jvalue
 {
 jboolean z;
 jbyte b;
 jchar c;
 jshort s;
 jint i;
 jlong j;
 jfloat f;
 jdouble d;
 jobject l;
 } jvalue;
 */
jvalue invoke_static_method_by_name(JNIEnv* env, bool* p_exception, jclass clazz, const char* method, const char* sig, va_list args) {
    jvalue result;
    jmethodID mid = NULL;

    init_jvalue(&result);

    mid = get_static_method_ID(env, p_exception, clazz, method, sig);
    if (*p_exception) {
        //LOGE_UTILS("Failed to get static method: %s", method);
        goto END;
    }

    switch (parse_method_sig_return(env, sig)) {
    case 'V':
        env->CallStaticVoidMethodV(clazz, mid, args);
        break;
    case '[':
    case 'L':
        result.l = env->CallStaticObjectMethodV(clazz, mid, args);
        break;
    case 'Z':
        result.z = env->CallStaticBooleanMethodV(clazz, mid, args);
        break;
    case 'B':
        result.b = env->CallStaticByteMethodV(clazz, mid, args);
        break;
    case 'C':
        result.c = env->CallStaticCharMethodV(clazz, mid, args);
        break;
    case 'S':
        result.s = env->CallStaticShortMethodV(clazz, mid, args);
        break;
    case 'I':
        result.i = env->CallStaticIntMethodV(clazz, mid, args);
        break;
    case 'J':
        result.j = env->CallStaticLongMethodV(clazz, mid, args);
        break;
    case 'F':
        result.f = env->CallStaticFloatMethodV(clazz, mid, args);
        break;
    case 'D':
        result.d = env->CallStaticDoubleMethodV(clazz, mid, args);
        break;
    }

    if (p_exception ? *p_exception = check_exception(env) : check_exception(env))
        goto END;

    END: ;

    return result;
}

jvalue invoke_method(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, va_list args) {
    jvalue result;

    result = invoke_method_by_name(env, p_exception, clazz, p_obj, method, sig, args);
    if (*p_exception) {
        result = invoke_static_method_by_name(env, p_exception, clazz, method, sig, args);
    }

#if DEBUG_UTILS && 0
    switch (parse_method_sig_return(env, sig))
    {
        case 'V':
        LOGD_UTILS("invoke [%s] {%s}", method, sig);
        break;
        case '[':
        case 'L':
        LOGD_UTILS("invoke [%s] {%s} %p", method, sig, result.l);
        break;
        case 'Z':
        LOGD_UTILS("invoke [%s] {%s} %d", method, sig, result.z);
        break;
        case 'B':
        LOGD_UTILS("invoke [%s] {%s} %d", method, sig, result.b);
        break;
        case 'C':
        LOGD_UTILS("invoke [%s] {%s} %c", method, sig, result.c);
        break;
        case 'S':
        LOGD_UTILS("invoke [%s] {%s} %d", method, sig, result.s);
        break;
        case 'I':
        LOGD_UTILS("invoke [%s] {%s} %d", method, sig, result.i);
        break;
        case 'J':
        LOGD_UTILS("invoke [%s] {%s} %ld", method, sig, (long) result.j);
        break;
        case 'F':
        LOGD_UTILS("invoke [%s] {%s} %f", method, sig, (float) result.f);
        break;
        case 'D':
        LOGD_UTILS("invoke [%s] {%s} %lf", method, sig, (double) result.d);
        break;
    }
#endif

    END: ;

    return result;
}

jvalue invoke_method(JNIEnv* env, bool* p_exception, jobject p_obj, const char* method, const char* sig, va_list args) {
    jvalue result;
    jclass clazz = NULL;

    init_jvalue(&result);

    clazz = env->GetObjectClass(p_obj);
    if (p_exception ? *p_exception = check_exception(env) : check_exception(env)) {
        goto END;
    }

    result = invoke_method(env, p_exception, clazz, p_obj, method, sig, args);

    END: env->DeleteLocalRef(clazz);

    return result;
}

void invoke_void_method(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, ...) {
    va_list args;

    va_start(args, sig);
    invoke_method(env, p_exception, clazz, p_obj, method, sig, args);
    va_end(args);
}

void invoke_void_method(JNIEnv* env, bool* p_exception, jobject p_obj, const char* method, const char* sig, ...) {
    va_list args;

    va_start(args, sig);
    invoke_method(env, p_exception, p_obj, method, sig, args);
    va_end(args);
}

jobject invoke_object_method(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, ...) {
    jvalue result;
    va_list args;

    va_start(args, sig);
    result = invoke_method(env, p_exception, clazz, p_obj, method, sig, args);
    va_end(args);

    return *p_exception ? NULL : result.l;
}

jobject invoke_object_method(JNIEnv* env, bool* p_exception, jobject p_obj, const char* method, const char* sig, ...) {
    jvalue result;
    va_list args;

    va_start(args, sig);
    result = invoke_method(env, p_exception, p_obj, method, sig, args);
    va_end(args);

    return *p_exception ? NULL : result.l;
}

jstring invoke_string_method(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, ...) {
    jobject result = NULL;
    va_list args;

    va_start(args, sig);
    result = invoke_object_method(env, p_exception, clazz, p_obj, method, sig, args);
    va_end(args);

    return *p_exception ? NULL : (jstring) result;
}

jstring invoke_string_method(JNIEnv* env, bool* p_exception, jobject p_obj,
        const char* method, const char* sig, ...) {
    jobject result = NULL;
    va_list args;

    va_start(args, sig);
    result = invoke_object_method(env, p_exception, p_obj, method, sig, args);
    va_end(args);

    return *p_exception ? NULL : (jstring) result;
}

jint invoke_int_method(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, ...) {
    jvalue result;
    va_list args;

    va_start(args, sig);
    result = invoke_method(env, p_exception, clazz, p_obj, method, sig, args);
    va_end(args);

    return *p_exception ? INT_MIN : result.i;
}

jint invoke_int_method(JNIEnv* env, bool* p_exception, jobject p_obj, const char* method, const char* sig, ...) {
    jvalue result;
    va_list args;

    va_start(args, sig);
    result = invoke_method(env, p_exception, p_obj, method, sig, args);
    va_end(args);

    return *p_exception ? INT_MIN : result.i;
}

jint invoke_bool_method(JNIEnv* env, bool* p_exception, jclass clazz, jobject p_obj, const char* method, const char* sig, ...) {
    jvalue result;
    va_list args;

    va_start(args, sig);
    result = invoke_method(env, p_exception, clazz, p_obj, method, sig, args);
    va_end(args);

    return *p_exception ? INT_MIN : (result.z ? 1 : 0);
}

jint invoke_bool_method(JNIEnv* env, bool* p_exception, jobject p_obj, const char* method, const char* sig, ...) {
    jvalue result;
    va_list args;

    va_start(args, sig);
    result = invoke_method(env, p_exception, p_obj, method, sig, args);
    va_end(args);

    return *p_exception ? INT_MIN : (result.z ? 1 : 0);
}

jobject invoke_static_object_method(JNIEnv* env, bool* p_exception, jclass clazz, const char* method, const char* sig, ...) {
    jvalue result;
    va_list args;

    va_start(args, sig);
    result = invoke_static_method_by_name(env, p_exception, clazz, method, sig, args);
    va_end(args);

    return *p_exception ? NULL : result.l;
}

void invoke_static_void_method(JNIEnv* env, bool* p_exception, jclass clazz, const char* method, const char* sig, ...) {
    jvalue result;
    va_list args;

    va_start(args, sig);
    result = invoke_static_method_by_name(env, p_exception, clazz, method, sig, args);
    va_end(args);
}

jobject invoke_init_method(JNIEnv* env, bool* p_exception, jclass clazz, const char* sig, ...) {
    jobject result = NULL;
    jmethodID constructor = NULL;
    va_list args;

    constructor = get_method_ID(env, p_exception, clazz, "<init>", sig);
    if (constructor == NULL) {
        //LOGE_UTILS("Failed to get method: %s", method);
        goto END;
    }

    va_start(args, sig);
    result = env->NewObjectV(clazz, constructor, args);
    va_end(args);

    if (p_exception ? *p_exception = check_exception(env) : check_exception(env))
        goto END;

    END: ;

    return result;
}

jobject get_field(JNIEnv* env, jobject p_obj, const char* field, const char* sig) {
    jclass cls = NULL;
    jfieldID fid = NULL;
    jobject fid_obj = NULL;

    cls = env->GetObjectClass(p_obj);

    fid = env->GetFieldID(cls, field, sig);
    if (!fid && check_exception(env)) {
        LOGE_UTILS("Failed to get field %s.", field);
        goto END;
    }

    fid_obj = env->GetObjectField(p_obj, fid);

    END: env->DeleteLocalRef(cls);

    return fid_obj;
}

void set_field(JNIEnv* env, jobject p_obj, const char* field, const char* sig, jobject value) {
    jclass cls = NULL;
    jfieldID fid = NULL;

    cls = env->GetObjectClass(p_obj);

    fid = env->GetFieldID(cls, field, sig);
    if (!fid && check_exception(env)) {
        LOGE_UTILS("Failed to get field %s.", field);
        goto END;
    }

    END: env->DeleteLocalRef(cls);

    env->SetObjectField(p_obj, fid, value);
}

jobject get_context(JNIEnv* env) {
    jclass clazz = NULL;
    jobject context = NULL;
    bool p_exception;

    clazz = find_class(env, "android/app/ActivityThread");
    if (!clazz) {
        LOGE_UTILS("Failed to find ActivityThread.");
        goto END;
    }

    context = invoke_static_object_method(env, &p_exception, clazz, "currentApplication", "()Landroid/app/Application;");

    END: env->DeleteLocalRef(clazz);

    return context;
}

char* pnew_arr(int p_size) {
    assert(p_size > 0);

    char* pu = (char*) malloc(sizeof(char) * (p_size));
    assert(pu != NULL);
    memset(pu, 0, p_size);

    return pu;
}

BYTE* pnew_arr2(int p_size) {
    assert(p_size > 0);

    BYTE* pu = (BYTE*) malloc(sizeof(BYTE) * (p_size));
    assert(pu != NULL);
    memset(pu, 0, p_size);

    return pu;
}

void pdelete(char* p) {
    assert(p != NULL);

    free(p);
    p = NULL;
}

void pdelete2(BYTE* p) {
    assert(p != NULL);

    free(p);
    p = NULL;
}

int str_len(const char* p) {
    const char* tmp = p;
    while (*tmp)
        ++tmp;
    return tmp - p;
}

int str_len2(const BYTE* p) {
    const BYTE* tmp = p;
    while (*tmp)
        ++tmp;
    return tmp - p;
}

int read_file(const char* file_path, char** file_buffer) {
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

        *file_buffer = pnew_arr(file_size + 1);

        ret = read(fd, *file_buffer, file_size);
        LOGD_UTILS("Read %s (%d)", file_path, ret);
    }

    END: close(fd);

    return ret;
}

int read_file2(const char* file_path, BYTE** file_buffer) {
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

        *file_buffer = pnew_arr2(file_size + 1);

        ret = read(fd, *file_buffer, file_size);
        LOGD_UTILS("Read %s (%d)", file_path, ret);
    }

    END: close(fd);

    return ret;
}

void write_file(const char* file_path, char* file_buffer, int numBytesRead) {
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

void write_file2(const char* file_path, BYTE* file_buffer, int numBytesRead) {
    int fd = open(file_path, O_WRONLY | O_CREAT, 0640);
    if (fd != -1) {
        if (numBytesRead == 0) {
            numBytesRead = str_len2(file_buffer);
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

void copy_file(jobject context, const char* file_path, char* file_buffer, int numBytesRead) {
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

void copy_file2(jobject context, const char* file_path, BYTE* file_buffer, int numBytesRead) {
    delete_file(file_path);

    int fd = open(file_path, O_WRONLY | O_CREAT, 0640);
    if (fd != -1) {
        if (numBytesRead == 0) {
            numBytesRead = str_len2(file_buffer);
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

int get_asset_content(JNIEnv* env, const char* file_name, char** asset_buf) {
    jobject assetManager = get_asset_java(env);
    AAssetManager* assetMgr = AAssetManager_fromJava(env, assetManager);
    assert(assetMgr != NULL);

    AAsset* asset = AAssetManager_open(assetMgr, file_name, AASSET_MODE_UNKNOWN);
    assert(asset != NULL);

    off_t bufferSize = AAsset_getLength(asset);
    *asset_buf = pnew_arr(bufferSize + 1);
    int numBytesRead = AAsset_read(asset, *asset_buf, bufferSize);
    AAsset_close(asset);

    env->DeleteLocalRef(assetManager);

    return numBytesRead;
}

int get_asset_content2(JNIEnv* env, const char* file_name, BYTE** asset_buf) {
    jobject assetManager = get_asset_java(env);
    AAssetManager* assetMgr = AAssetManager_fromJava(env, assetManager);
    assert(assetMgr != NULL);

    AAsset* asset = AAssetManager_open(assetMgr, file_name, AASSET_MODE_UNKNOWN);
    assert(asset != NULL);

    off_t bufferSize = AAsset_getLength(asset);
    *asset_buf = pnew_arr2(bufferSize + 1);
    int numBytesRead = AAsset_read(asset, *asset_buf, bufferSize);
    AAsset_close(asset);

    env->DeleteLocalRef(assetManager);

    return numBytesRead;
}

char* make_file_md5(JNIEnv* env, const char* file_path) {
    char* md5_str;

    BYTE* file_buf;
    int numBytesRead = read_file2(file_path, &file_buf);
    if (numBytesRead > 0) {
        md5_str = md5(file_buf, numBytesRead);
        pdelete2(file_buf);
    }

    return md5_str;
}

char* make_asset_file_md5(JNIEnv* env, const char* file_name) {
    char* md5_str;

    BYTE* file_buf;
    int numBytesRead = get_asset_content2(env, file_name, &file_buf);
    if (numBytesRead > 0) {
        md5_str = md5(file_buf, numBytesRead);
        pdelete2(file_buf);
    }

    return md5_str;
}

jobject get_asset_java(JNIEnv* env) {
    jobject context = NULL;
    jobject resources_obj = NULL;
    jobject assets_obj = NULL;
    bool has_exception;

    context = get_context(env);

    resources_obj = invoke_object_method(env, &has_exception, context, "getResources", "()Landroid/content/res/Resources;");
    if (has_exception) {
        LOGE_UTILS("Failed to call getResources.");
        goto END;
    }

    assets_obj = invoke_object_method(env, &has_exception, resources_obj, "getAssets", "()Landroid/content/res/AssetManager;");
    if (has_exception) {
        LOGE_UTILS("Failed to call getAssets.");
        goto END;
    }

    END: env->DeleteLocalRef(context);
    env->DeleteLocalRef(resources_obj);

    return assets_obj;
}

// get value with conversion functions
template<typename U> U string_to_integer(const char* value, U minneg, U maxpos) {
    U result = 0;
    const char* s = value;

    while (PUGI__IS_CHARTYPE(*s, 8))
        s++;

    bool negative = (*s == '-');

    s += (*s == '+' || *s == '-');

    bool overflow = false;

    if (s[0] == '0' && (s[1] | ' ') == 'x') {
        s += 2;

// since overflow detection relies on length of the sequence skip leading zeros
        while (*s == '0')
            s++;

        const char* start = s;

        for (;;) {
            if (static_cast<unsigned>(*s - '0') < 10)
                result = result * 16 + (*s - '0');
            else if (static_cast<unsigned>((*s | ' ') - 'a') < 6)
                result = result * 16 + ((*s | ' ') - 'a' + 10);
            else
                break;

            s++;
        }

        int digits = static_cast<int>(s - start);

        overflow = digits > sizeof(U) * 2;
    } else {
// since overflow detection relies on length of the sequence skip leading zeros
        while (*s == '0')
            s++;

        const char* start = s;

        for (;;) {
            if (static_cast<unsigned>(*s - '0') < 10)
                result = result * 10 + (*s - '0');
            else
                break;

            s++;
        }

        int digits = static_cast<int>(s - start);

        PUGI__STATIC_ASSERT(sizeof(U) == 8 || sizeof(U) == 4 || sizeof(U) == 2);

        const int max_digits10 = sizeof(U) == 8 ? 20 : sizeof(U) == 4 ? 10 : 5;
        const char max_lead = sizeof(U) == 8 ? '1' : sizeof(U) == 4 ? '4' : '6';
        const int high_bit = sizeof(U) * 8 - 1;

        overflow = digits >= max_digits10
                && !(digits == max_digits10
                        && (*start < max_lead
                                || (*start == max_lead && result >> high_bit)));
    }

    if (negative)
        return (overflow || result > minneg) ? 0 - minneg : 0 - result;
    else
        return (overflow || result > maxpos) ? maxpos : result;
}

int get_value_int(const char* value) {
    return string_to_integer<unsigned int>(value,
            0 - static_cast<unsigned int>(INT_MIN), INT_MAX);
}

bool get_value_bool(const char* value) {
    // only look at first char
    char first = *value;

    // 1*, t* (true), T* (True), y* (yes), Y* (YES)
    return (first == '1' || first == 't' || first == 'T' || first == 'y' || first == 'Y');
}

int char2int(char input) {
    if (input >= '0' && input <= '9')
        return input - '0';
    if (input >= 'A' && input <= 'F')
        return input - 'A' + 10;
    if (input >= 'a' && input <= 'f')
        return input - 'a' + 10;
    return -1;
}

void string2hex(const char* src, BYTE* target) {
    while (*src && isxdigit(*src) && src[1] && isxdigit(src[1])) {
        *(target++) = char2int(*src) * 16 + char2int(src[1]);
        src += 2;
    }
}

void hex2string(const BYTE* data, int datasize, char *strp) {
    for (int i = 0; i < datasize; i++) {
        snprintf(strp, 2, "%02X", data[i]);
        strp++;
    }
}

char* as_char_array(JNIEnv* env, jcharArray array) {
    jsize len = env->GetArrayLength(array);
    char* buf = pnew_arr(len + 1);
    env->GetCharArrayRegion(array, 0, len, (jchar*) buf);
    return buf;
}

BYTE* as_unsigned_char_array(JNIEnv* env, jbyteArray array) {
    jsize len = env->GetArrayLength(array);
    BYTE* buf = pnew_arr2(len + 1);
    env->GetByteArrayRegion(array, 0, len, (jbyte*) buf);
    return buf;
}

BYTE* as_byte_array(JNIEnv* env, jbyteArray array) {
    jsize len = env->GetArrayLength(array);
    BYTE* buf = pnew_arr2(len + 1);
    env->GetByteArrayRegion(array, 0, len, (jbyte*) buf);
    return buf;
}

jbyteArray as_jbyte_array(JNIEnv* env, const BYTE* buf, jsize len) {
    jbyteArray array = env->NewByteArray(len);
    env->SetByteArrayRegion(array, 0, len, (jbyte*) buf);
    return array;
}

char* return_char(JNIEnv* env, jbyteArray jbyte_arr) {
    jsize jbyte_arr_size = env->GetArrayLength(jbyte_arr);

    jbyte* byte_arr = (jbyte*) malloc(sizeof(jbyte) * (jbyte_arr_size + 1));
    memset(byte_arr, 0, jbyte_arr_size + 1);
    env->GetByteArrayRegion(jbyte_arr, 0, jbyte_arr_size, byte_arr);

    return (char*) byte_arr;
}

jstring return_jstring(JNIEnv* env, const char* pat) {
    jclass strClass = NULL;
    jbyteArray bytes = NULL;
    jstring encoding = NULL;
    jstring jstr = NULL;
    int pat_len = 0;
    bool p_exception;

    strClass = find_class(env, "java/lang/String");
    if (!strClass) {
        goto END;
    }

    pat_len = strlen(pat);

    bytes = env->NewByteArray(pat_len);
    if (!bytes && check_exception(env)) {
        LOGE_UTILS("Failed to new array.");
        goto END;
    }

    env->SetByteArrayRegion(bytes, 0, pat_len, (jbyte*) pat);

    encoding = env->NewStringUTF("UTF-8");

    jstr = (jstring) invoke_init_method(env, &p_exception, strClass,
            "([BLjava/lang/String;)V", bytes, encoding);

    END: env->DeleteLocalRef(strClass);
    env->DeleteLocalRef(bytes);
    env->DeleteLocalRef(encoding);

    return jstr;
}

unsigned int get_file_size(int fd) {
    struct stat statbuf;
    if (fstat(fd, &statbuf) < 0)
        return -1;
    return statbuf.st_size;
}

bool enable_open_file(const char* file_path) {
    bool result = true;

    int fd = open(file_path, O_RDONLY | O_EXCL);
    if (fd == -1) {
        LOGW_UTILS("Failed to open %s.", file_path);
        result = false;
    }

    END: close(fd);

    return result;
}

void close_file(int fd) {
    close(fd);
}

bool delete_file(const char* file_path) {
    bool result = false;

    int fd = open(file_path, O_RDONLY | O_EXCL);
    if (fd != -1) {
        if (remove(file_path) != 0) {
            LOGE_UTILS("Failed to delete %s.", file_path);
            result = false;
        } else {
            LOGD_UTILS("Success to delete %s.", file_path);
            result = true;
        }
    } else {
        LOGW_UTILS("%s is not exist.", file_path);
        result = false;
    }

    END: close(fd);

    return result;
}

bool create_file(const char* file_path) {
    bool result = false;

    int fd = open(file_path, O_WRONLY | O_CREAT, 0640);
    if (fd == -1) {
        int fd_new = open(file_path, O_RDONLY | O_EXCL);
        if (fd_new == -1) {
            LOGE_UTILS("Failed to create %s.", file_path);
            result = false;
        }
    } else {
        result = true;
    }

    END: close(fd);

    return result;
}
} // utils
