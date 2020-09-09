#include "conf.h"

#if CPP
std::string emptystr("");
#endif

static char *nullstr() {
    static char zero = char('\0');
    return &zero;
}

const char* VERSION = "1.0";

const char* DAT_SUFFIX = ".dat";
const char* APK_SUFFIX = ".apk";
const char* DEX_SUFFIX = ".dex";
const char* FILE_STUB = "zizzy.zhao.bridgex.core.dex";
