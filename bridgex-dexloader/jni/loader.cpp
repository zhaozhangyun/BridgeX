#include <jni.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <time.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <dirent.h>
#include "loader.h"
#include "conf.h"
#include "utils.h"
#include "md5.h"

//Class path name for Register
const char* CLAZZ_PROXY = "zhao/zizzy/bridgex/BridgeX";

#ifndef NELEM
#define NELEM(x) ((int) (sizeof(x) / sizeof((x)[0])))
#endif

//using namespace std;
using namespace utils;

jclass get_component_type(JNIEnv* env, jobject obj) {
    jclass cls = NULL;
    jobject clsObj = NULL;
    bool has_exception;

    clsObj = invoke_object_method(env, &has_exception, obj, "getClass", "()Ljava/lang/Class;");
    if (!clsObj)
        goto END;

    cls = (jclass) invoke_object_method(env, &has_exception, clsObj, "getComponentType", "()Ljava/lang/Class;");

    END: env->DeleteLocalRef(clsObj);

    return cls;
}

char* make_dex_file(JNIEnv* env, jobject context, const char* dex_path_char, const char* odex_path_char) {
    LOGD("call make_dex_file");
    LOGD("dex_path_char: %s", dex_path_char);
    LOGD("odex_path_char: %s", odex_path_char);

    assert(opendir(dex_path_char) != NULL);
    assert(opendir(odex_path_char) != NULL);

    /* get asset file md5 */
    char* md5Asset = make_asset_file_md5(env, FILE_STUB);
    LOGD("md5Asset: %s", md5Asset);
    /* get dex file md5 */
    char* apk_filename_new = replace_all(FILE_STUB, /*DAT_SUFFIX*/DEX_SUFFIX, /*APK_SUFFIX*/DEX_SUFFIX);
    LOGD("apk_filename_new: %s", apk_filename_new);

    char dexFilePath[256];
    strcpy(dexFilePath, dex_path_char);
    strcat(dexFilePath, "/");
    strcat(dexFilePath, apk_filename_new);
    LOGD("dexFilePath: %s %d", dexFilePath, str_len(dexFilePath));

    char* dex_file_path = pnew_arr(str_len(dexFilePath) + 1);
    strcpy(dex_file_path, dexFilePath);
    LOGD("dex_file_path: %s", dex_file_path);
//    const char* dex_file_path_new = dex_file_path;

//    char* md5Dex = make_file_md5(env, dex_file_path);
//    LOGD("md5Dex: %s", md5Dex);

    /* compare md5 */
//    if (strcmp(md5Asset, md5Dex) != 0) {
//        LOGW("%s md5 has changed.", FILE_STUB);
//        LOGI("%s md5: %s", FILE_STUB, md5Asset);

//        if (strcmp(md5Dex, "") == 0 || str_len(md5Dex) != 32) {
//            LOGD("%s is not exist.", dexFilePath);
//        } else {
//            LOGI("%s md5: %s", dexFilePath, md5Dex);
//        }

//        char* dex_filename_new = replace_all(apk_filename_new, /*APK_SUFFIX*/DEX_SUFFIX, DEX_SUFFIX);
//        LOGD("dex_filename_new: %s", dex_filename_new);
//        char odexFilePath[256];
//        strcpy(odexFilePath, odex_path_char);
//        strcat(odexFilePath, "/");
//        strcat(odexFilePath, dex_filename_new);
//        LOGD("odexFilePath: %s", odexFilePath);
//        delete_file(odexFilePath);

        BYTE* asset_buf;
        int numBytesRead = get_asset_content2(env, FILE_STUB, &asset_buf);
        if (numBytesRead > 0) {
            copy_file2(context, dex_file_path, asset_buf, numBytesRead);
            pdelete2(asset_buf);
        }

//        pdelete(dex_filename_new);
//    }

    pdelete(apk_filename_new);

    LOGD("dex_file_path: %s", dex_file_path);
    return dex_file_path;
}

jobject get_path_list(JNIEnv* env, jobject baseDexClassLoader) {
    return get_field(env, baseDexClassLoader, "pathList", "Ldalvik/system/DexPathList;");
}

jobject get_dex_elements(JNIEnv* env, jobject paramObj) {
    return get_field(env, paramObj, "dexElements", "[Ldalvik/system/DexPathList$Element;");
}

jobject append_array(JNIEnv* env, jobject array, jobject value) {
    LOGV("call append_array");

    jobjectArray arr = NULL;
    jclass localClass = NULL;
    jobjectArray resultArray = NULL;
    jsize i = 0;
    jsize j = 0;

    arr = (jobjectArray) array;
    if (!arr) {
        LOGE("Failed to get array.");
        goto END;
    }

    i = env->GetArrayLength(arr);
    j = i + 1;

    localClass = get_component_type(env, array);
    resultArray = (jobjectArray) env->NewObjectArray(j, localClass, NULL);

    for (int k = 0; k < j; ++k) {
        if (k < i) {
            env->SetObjectArrayElement(resultArray, k, env->GetObjectArrayElement(arr, k));
        } else {
            env->SetObjectArrayElement(resultArray, k, value);
        }
    }

    END: env->DeleteLocalRef(arr);

    return resultArray;
}

jobject combine_array(JNIEnv* env, jobject arrayLhs, jobject arrayRhs) {
    LOGV("call combine_array");

    jobjectArray arrLhs = NULL;
    jobjectArray arrRhs = NULL;
    jclass localClass = NULL;
    jobjectArray resultArray = NULL;
    jsize i = 0;
    jsize j = 0;

    arrLhs = (jobjectArray) arrayLhs;
    if (!arrLhs) {
        LOGE("Failed to get array.");
        goto END;
    }

    arrRhs = (jobjectArray) arrayRhs;
    if (!arrRhs) {
        LOGE("Failed to get array.");
        goto END;
    }

    i = env->GetArrayLength(arrLhs);
    j = i + env->GetArrayLength(arrRhs);

    localClass = get_component_type(env, arrayLhs);
    if (!localClass) {
        LOGE("Failed to get class component type.");
        goto END;
    }

    resultArray = (jobjectArray) env->NewObjectArray(j, localClass, NULL);
    if (!resultArray) {
        LOGE("Failed to new object array.");
        goto END;
    }

    for (int k = 0; k < j; ++k) {
        if (k < i) {
            env->SetObjectArrayElement(resultArray, k, env->GetObjectArrayElement(arrLhs, k));
        } else {
            env->SetObjectArrayElement(resultArray, k, env->GetObjectArrayElement(arrRhs, k - i));
        }
    }

    END: env->DeleteLocalRef(arrLhs);
    env->DeleteLocalRef(arrRhs);
    env->DeleteLocalRef(localClass);

    return resultArray;
}

jstring get_dir(JNIEnv* env, jobject context, const char* file_name) {
    jstring name = NULL;
    jobject file_obj = NULL;
    jstring file_path = NULL;
    bool has_exception;

    name = env->NewStringUTF(file_name);
    file_obj = invoke_object_method(env, &has_exception, context, "getDir", "(Ljava/lang/String;I)Ljava/io/File;", name, 0);
    file_path = invoke_string_method(env, &has_exception, file_obj, "getPath", "()Ljava/lang/String;");

    END: env->DeleteLocalRef(name);
    env->DeleteLocalRef(file_obj);

    return file_path;
}

jstring get_native_library_dir(JNIEnv* env, jobject context) {
    jmethodID get_application_info_method = NULL;
    jobject application_info_obj = NULL;
    jstring native_library_dir = NULL;
    bool has_exception;

    application_info_obj = invoke_object_method(env, &has_exception, context, "getApplicationInfo", "()Landroid/content/pm/ApplicationInfo;");
    native_library_dir = (jstring) get_field(env, application_info_obj, "nativeLibraryDir", "Ljava/lang/String;");
    if (!native_library_dir) {
        LOGE("Failed to get nativeLibraryDir.");
        goto END;
    }

    END: env->DeleteLocalRef(application_info_obj);

    return native_library_dir;
}

jobject get_class_loader(JNIEnv* env, jobject context) {
    jobject clazz_obj = NULL;
    jobject class_loader_obj = NULL;
    bool has_exception;

    clazz_obj = invoke_object_method(env, &has_exception, context, "getClass", "()Ljava/lang/Class;");
    if (has_exception) {
        LOGE("Failed to invoke object method: getClass()");
        goto END;
    }

    class_loader_obj = invoke_object_method(env, &has_exception, clazz_obj, "getClassLoader", "()Ljava/lang/ClassLoader;");
    if (has_exception) {
        LOGE("Failed to invoke object method: getClassLoader()");
        goto END;
    }

    END: env->DeleteLocalRef(clazz_obj);

    return class_loader_obj;
}

jobject inject_in_aliyunos(JNIEnv* env, jstring dexFilePath, jstring odexPath, jstring nativeLibPath, jobject class_loader) {
    LOGD("call inject_in_aliyunos");

    jclass dex_class_loader = NULL;
    jobject dexLoader = NULL;
    jclass classLoader = NULL;
    jobject method_obj = NULL;
    bool has_exception;
    const char* dex_path_char = env->GetStringUTFChars(dexFilePath, NULL);
    char* dex_path;

    dex_class_loader = find_class(env, "dalvik/system/DexClassLoader");
    if (!dex_class_loader) {
        goto END;
    }

    dexLoader = invoke_init_method(env, &has_exception, dex_class_loader,
            "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V",
            dexFilePath, odexPath, nativeLibPath, class_loader);
    if (has_exception) {
        LOGE("Failed to new DexClassLoader.");
        goto END;
    }

    //dex_path = return_string(env, dexFilePath);
    dex_path = replace_all(dex_path_char, "\\.[a-zA-Z0-9]+", ".lex");

    classLoader = find_class(env, "dalvik/system/LexClassLoader");
    if (!classLoader) {
        goto END;
    }

    method_obj = invoke_init_method(env, &has_exception, classLoader,
            "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V",
            dexFilePath, odexPath, nativeLibPath, class_loader);
    if (has_exception) {
        LOGE("Failed to new LexClassLoader.");
        goto END;
    }

    invoke_void_method(env, &has_exception, method_obj, "newInstance",
            "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V",
            true);

    set_field(env, class_loader, "mPaths", "[Ljava/lang/String;",
            append_array(env, get_field(env, class_loader, "mPaths", "[Ljava/lang/String;"),
                    get_field(env, dexLoader, "mRawDexPath", "Ljava/lang/String;")));

    set_field(env, class_loader, "mFiles", "[Ljava/io/File;",
            combine_array(env, get_field(env, class_loader, "mFiles", "[Ljava/io/File;"),
                    get_field(env, dexLoader, "mFiles", "[Ljava/io/File;")));

    set_field(env, class_loader, "mZips", "[Ljava/util/zip/ZipFile;",
            combine_array(env, get_field(env, class_loader, "mZips", "[Ljava/util/zip/ZipFile;"),
                    get_field(env, dexLoader, "mZips", "[Ljava/util/zip/ZipFile;")));

    set_field(env, class_loader, "mLexs", "[Ldalvik/system/DexFile;",
            combine_array(env, get_field(env, class_loader, "mLexs", "[Ldalvik/system/DexFile;"),
                    get_field(env, dexLoader, "mLexs", "[Ldalvik/system/DexFile;")));

    END: env->ReleaseStringUTFChars(dexFilePath, dex_path_char);
    env->DeleteLocalRef(dex_class_loader);
    env->DeleteLocalRef(classLoader);
    env->DeleteLocalRef(method_obj);

    free(dex_path);

    return dexLoader;
}

jobject inject_below_api_level14(JNIEnv* env, jstring dexFilePath, jstring odexPath, jstring nativeLibPath, jobject class_loader) {
    LOGD("call inject_below_api_level14");

    jclass dex_class_loader = NULL;
    jobject dexLoader = NULL;
    bool has_exception;

    dex_class_loader = find_class(env, "dalvik/system/DexClassLoader");
    if (!dex_class_loader) {
        goto END;
    }

    dexLoader = invoke_init_method(env, &has_exception, dex_class_loader,
            "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V",
            dexFilePath, odexPath, nativeLibPath, class_loader);
    if (has_exception) {
        LOGE("Failed to new DexClassLoader.");
        goto END;
    }

    set_field(env, class_loader, "mPaths", "[Ljava/lang/String;",
            append_array(env, get_field(env, class_loader, "mPaths", "[Ljava/lang/String;"),
                    get_field(env, dexLoader, "mRawDexPath", "Ljava/lang/String;")));
    set_field(env, class_loader, "mFiles", "[Ljava/io/File;",
            combine_array(env, get_field(env, class_loader, "mFiles", "[Ljava/io/File;"),
                    get_field(env, dexLoader, "mFiles", "[Ljava/io/File;")));
    set_field(env, class_loader, "mZips", "[Ljava/util/zip/ZipFile;",
            combine_array(env, get_field(env, class_loader, "mZips", "[Ljava/util/zip/ZipFile;"),
                    get_field(env, dexLoader, "mZips", "[Ljava/util/zip/ZipFile;")));
    set_field(env, class_loader, "mDexs", "[Ldalvik/system/DexFile;",
            combine_array(env, get_field(env, class_loader, "mDexs", "[Ldalvik/system/DexFile;"),
                    get_field(env, dexLoader, "mDexs", "[Ldalvik/system/DexFile;")));

    END: env->DeleteLocalRef(dex_class_loader);

    return dexLoader;
}

jobject inject_above_equal_api_level14(JNIEnv* env, jstring dexFilePath,
        jstring odexPath, jstring nativeLibPath, jobject class_loader) {
    LOGD("call inject_above_equal_api_level14");

    jclass dex_class_loader = NULL;
    jobject dexLoader = NULL;
    jobject dexElements = NULL;
    jobject pathList = NULL;
    bool has_exception;

    dex_class_loader = find_class(env, "dalvik/system/DexClassLoader");
    if (!dex_class_loader) {
        goto END;
    }

    dexLoader = invoke_init_method(env, &has_exception, dex_class_loader,
            "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V",
            dexFilePath, odexPath, nativeLibPath, class_loader);
    if (has_exception) {
        LOGE("Failed to new DexClassLoader.");
        goto END;
    }

    dexElements = combine_array(env, get_dex_elements(env, get_path_list(env, class_loader)),
            get_dex_elements(env, get_path_list(env, dexLoader)));
    pathList = get_path_list(env, class_loader);

    set_field(env, pathList, "dexElements", "[Ldalvik/system/DexPathList$Element;", dexElements);

    END: env->DeleteLocalRef(dex_class_loader);

    return dexLoader;
}

/*
char* execute_decrypt_xml(JNIEnv* env, const char* file_path) {
    LOGD("call execute_decrypt_xml file_path: %s", file_path);
    char* plain_text;

    clock_t start, finish;
    double totaltime;

    BYTE* encrypt_text;
    int encrypt_text_len = read_file2(file_path, &encrypt_text);

    start = clock();
    BYTE* decrypt_text;
    jbyteArray decrypt_text_arr = aesutil::native_decrypt(env, encrypt_text, encrypt_text_len, &decrypt_text, 0);
    decrypt_text = as_byte_array(env, decrypt_text_arr);
    pdelete2(encrypt_text);
    finish = clock();
    totaltime = ((double) (finish - start) / CLOCKS_PER_SEC) * 1000;
    LOGI("Decrypt %s cost %fms.", file_path, totaltime);

    plain_text = (char*) decrypt_text;
    //LOGD("plainText ----------------------------\n%s\n----------------------------", plain_text);
    return plain_text;
}

char* decrypt_assets_xml(JNIEnv* env, const char* file_name) {
    LOGD("call decrypt_assets_xml(): %s", file_name);

    jobject context = get_context(env);
    assert(context != NULL);

    char* xml_plugins_text = NULL;

    char* asset_file_md5 = make_asset_file_md5(env, file_name);

    jstring xml_path = get_dir(env, context, "xml");
    const char* xml_path_char = env->GetStringUTFChars(xml_path, NULL);

    char xml_file_name[256];
    strcpy(xml_file_name, xml_path_char);
    strcat(xml_file_name, "/");
    strcat(xml_file_name, file_name);
    LOGD("xml_file_name: %s", xml_file_name);
    env->ReleaseStringUTFChars(xml_path, xml_path_char);

    char* xml_file_md5 = make_file_md5(env, xml_file_name);

    if (strcmp(asset_file_md5, xml_file_md5) != 0) {
        LOGI("%s md5 has changed to %s", file_name, asset_file_md5);

        if (strcmp(xml_file_md5, "") == 0 || str_len(xml_file_md5) != 32) {
            LOGD("%s is not exist.", xml_file_name);
        } else {
            LOGI("%s md5 is %s", xml_file_name, xml_file_md5);
        }

        char* asset_buf;
        int numBytesRead = get_asset_content(env, file_name, &asset_buf);
        if (numBytesRead > 0) {
            copy_file(context, xml_file_name, asset_buf, numBytesRead);
            pdelete(asset_buf);
        }
    }

    return execute_decrypt_xml(env, xml_file_name);
}
*/

void attach_context(JNIEnv* env, jobject context, const char* class_path) {
    LOGD("call attach_context(): %s", class_path);

    jclass app_cls = NULL;
    bool has_exception;

    app_cls = find_class(env, class_path);
    if (app_cls == NULL) {
        LOGE("Failed to find class %s.", class_path);
        goto END;
    }

    invoke_static_void_method(env, &has_exception, app_cls, "attach", "(Landroid/content/Context;)V", context);
    if (has_exception) {
        LOGE("Failed to invoke attach method.");
        abort();
    }

    END: env->DeleteLocalRef(app_cls);
}

jobject hook_dex_injector(JNIEnv* env, jobject context) {
    LOGD("call hook_dex_injector");

    jobject class_loader = NULL;
    jstring dexPath = NULL;
    jstring odexPath = NULL;
    jstring nativeLibPath = NULL;
    jobject dexLoader = NULL;
    jclass classLoader = NULL;

    assert(context != null);

    dexPath = get_dir(env, context, "dex");
    odexPath = get_dir(env, context, "odex");
    nativeLibPath = get_native_library_dir(env, context);

    const char* dex_path_char = env->GetStringUTFChars(dexPath, NULL);
    const char* odex_path_char = env->GetStringUTFChars(odexPath, NULL);
    const char* dex_file_path = make_dex_file(env, context, dex_path_char, odex_path_char);
    LOGD("dexFilePath: %s", dex_file_path);

    class_loader = get_class_loader(env, context);
    assert(class_loader != NULL);

    classLoader = find_class(env, "dalvik/system/BaseDexClassLoader");
    if (classLoader) {
        dexLoader = inject_above_equal_api_level14(env,
                return_jstring(env, dex_file_path), odexPath, nativeLibPath,
                class_loader);
    } else {
        jclass classLoader = find_class(env, "dalvik/system/LexClassLoader");
        if (classLoader) {
            dexLoader = inject_in_aliyunos(env,
                    return_jstring(env, dex_file_path), odexPath, nativeLibPath,
                    class_loader);
        } else {
            dexLoader = inject_below_api_level14(env,
                    return_jstring(env, dex_file_path), odexPath, nativeLibPath,
                    class_loader);
        }
    }

    END: env->ReleaseStringUTFChars(dexPath, dex_path_char);
    env->ReleaseStringUTFChars(odexPath, odex_path_char);
    env->DeleteLocalRef(class_loader);
    env->DeleteLocalRef(nativeLibPath);
    env->DeleteLocalRef(classLoader);

    return dexLoader;
}

/*
jbyteArray native_decrypt(JNIEnv* env, jobject thiz, jint key_type,
        jstring encrypt_text) {
    return aesutil::native_decrypt(env, key_type, encrypt_text);
}

jbyteArray native_encrypt(JNIEnv* env, jobject thiz, jint key_type,
        jstring plain_text) {
    return aesutil::native_encrypt(env, key_type, plain_text);
}

jstring native_decrypt_assets_xml(JNIEnv* env, jobject thiz,
        jstring file_name) {
    const char* file_name_char = env->GetStringUTFChars(file_name, NULL);
    const char* plain_text = decrypt_assets_xml(env, file_name_char);
    jstring result = return_jstring(env, plain_text);
    env->ReleaseStringUTFChars(file_name, file_name_char);
    return result;
}

JNINativeMethod aesutilMethods[] = { { "doEncrypt", "(ILjava/lang/String;)[B",
        (void*) native_encrypt }, { "doDecrypt", "(ILjava/lang/String;)[B",
        (void*) native_decrypt }, { "decryptAssetsXml",
        "(Ljava/lang/String;)Ljava/lang/String;",
        (void*) native_decrypt_assets_xml } };
*/

/*
inline int registerNativeMethods(JNIEnv* env, const char* className, JNINativeMethod* gMethods, int numMethods) {
    jclass clazz = find_class(env, className);
    if (!clazz) {
        LOGE("Class %s not found!!!", className);
        return JNI_FALSE;
    }

    int register_result = env->RegisterNatives(clazz, gMethods, numMethods);
    if (register_result < 0) {
        env->DeleteLocalRef(clazz);
        check_exception(env, true);
        return JNI_FALSE;
    }

    env->DeleteLocalRef(clazz);

    return JNI_TRUE;
}

int registerNatives(JNIEnv* env) {
    if (!registerNativeMethods(env, CLAZZ_AESUTIL, aesutilMethods, NELEM(aesutilMethods))) {
        LOGE("Failed to register aesutil methods.");
        return JNI_FALSE;
    }

    return JNI_TRUE;
}
*/

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM* vm, void* reserved) {
    LOGI("call JNI_OnLoad");

    JNIEnv* env = NULL;
    jint result = JNI_FALSE;
    jobject context = NULL;
    jobject dex_loader = NULL;
    int api_ver;

    if (vm->GetEnv((void**) &env, JNI_VERSION_1_4) != JNI_OK) {
        goto END;
    }
    assert(env != NULL);

    LOGI("Android API: %d", __ANDROID_API__);
    api_ver = api_version(env);
    LOGI("Android SDK API: %d", api_ver);

    context = get_context(env);
    assert(context != NULL);

    dex_loader = hook_dex_injector(env, context);
    assert(dex_loader != NULL);

//    if (!registerNatives(env)) {
//        abort();
//    }

    attach_context(env, context, CLAZZ_PROXY);

    result = JNI_VERSION_1_4;

    END: env->DeleteLocalRef(context);
    env->DeleteLocalRef(dex_loader);

    return result;
}
