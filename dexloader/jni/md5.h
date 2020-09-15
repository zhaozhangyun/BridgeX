#ifndef __MD5_H__
#define __MD5_H__

#include "conf.h"
#include <stdio.h>
#if CPP
#include <string>
#include <iostream>
#else
#include <string.h>
#endif

// a small class for calculating MD5 hashes of strings or byte arrays
// it is not meant to be fast or secure
//
// usage: 1) feed it blocks of uchars with update()
//      2) finalize()
//      3) get hexdigest() string
//      or
//      MD5(std::string).hexdigest()
//
// assumes that char is 8 bit and int is 32 bit
class MD5 {
public:
    typedef unsigned int size_type; // must be 32bit

    MD5();
#if CPP
    MD5(const std::string& text);
#endif
    MD5(const char *buf, size_type length);
    MD5(const unsigned char *buf, size_type length);
    void update(const unsigned char *buf, size_type length);
    void update(const char *buf, size_type length);
    MD5& finalize();
#if CPP
    std::string hexdigest() const;
#else
    char* hexdigest() const;
#endif
#if CPP
    friend std::ostream& operator<<(std::ostream&, MD5 md5);
#endif

private:
    void init();
    typedef unsigned char uint1; //  8bit
    typedef unsigned int uint4; // 32bit
    enum {
        blocksize = 64
    }; // VC6 won't eat a const static int here

    void transform(const uint1 block[blocksize]);
    static void decode(uint4 output[], const uint1 input[], size_type len);
    static void encode(uint1 output[], const uint4 input[], size_type len);

    bool finalized;
    uint1 buffer[blocksize]; // bytes that didn't fit in last 64 byte chunk
    uint4 count[2]; // 64bit counter for number of bits (lo, hi)
    uint4 state[4]; // digest so far
    uint1 digest[16]; // the result

    // low level logic operations
    static inline uint4 F(uint4 x, uint4 y, uint4 z);
    static inline uint4 G(uint4 x, uint4 y, uint4 z);
    static inline uint4 H(uint4 x, uint4 y, uint4 z);
    static inline uint4 I(uint4 x, uint4 y, uint4 z);
    static inline uint4 rotate_left(uint4 x, int n);
    static inline void FF(uint4 &a, uint4 b, uint4 c, uint4 d, uint4 x, uint4 s,
            uint4 ac);
    static inline void GG(uint4 &a, uint4 b, uint4 c, uint4 d, uint4 x, uint4 s,
            uint4 ac);
    static inline void HH(uint4 &a, uint4 b, uint4 c, uint4 d, uint4 x, uint4 s,
            uint4 ac);
    static inline void II(uint4 &a, uint4 b, uint4 c, uint4 d, uint4 x, uint4 s,
            uint4 ac);
};

#if CPP
std::string md5(const std::string str);
std::string md5(const unsigned char *buf, unsigned int length);
#else
char* md5(const char *buf, unsigned int length);
char* md5(const unsigned char *buf, unsigned int length);
#endif

#endif // __MD5_H__