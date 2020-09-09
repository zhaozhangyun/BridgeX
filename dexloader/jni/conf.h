#ifndef __CONF_H__
#define __CONF_H__

#define CPP 0

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if __ANDROID__
#include <android/api-level.h>
#endif

typedef unsigned char BYTE;

static char *nullstr();

extern const char* VERSION;

extern const char* DAT_SUFFIX;
extern const char* APK_SUFFIX;
extern const char* DEX_SUFFIX;
extern const char* FILE_STUB;

#endif // __CONF__
