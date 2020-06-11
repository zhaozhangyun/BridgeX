.class Lzhao/zizzy/bridgex/Md5Util;
.super Ljava/lang/Object;
.source "Md5Util.java"


# static fields
.field private static final TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 18
    const-class v0, Lzhao/zizzy/bridgex/Md5Util;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lzhao/zizzy/bridgex/Md5Util;->TAG:Ljava/lang/String;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static checkMD5(Ljava/lang/String;Ljava/io/File;)Z
    .locals 4
    .param p0, "md5"    # Ljava/lang/String;
    .param p1, "updateFile"    # Ljava/io/File;

    .line 52
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_2

    if-nez p1, :cond_0

    goto :goto_0

    .line 57
    :cond_0
    invoke-static {p1}, Lzhao/zizzy/bridgex/Md5Util;->getMd5(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    .line 58
    .local v0, "calculatedDigest":Ljava/lang/String;
    if-nez v0, :cond_1

    .line 59
    sget-object v2, Lzhao/zizzy/bridgex/Md5Util;->TAG:Ljava/lang/String;

    const-string v3, "calculatedDigest null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 60
    return v1

    .line 63
    :cond_1
    sget-object v1, Lzhao/zizzy/bridgex/Md5Util;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Calculated digest: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 64
    sget-object v1, Lzhao/zizzy/bridgex/Md5Util;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Provided digest: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 66
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    return v1

    .line 53
    .end local v0    # "calculatedDigest":Ljava/lang/String;
    :cond_2
    :goto_0
    sget-object v0, Lzhao/zizzy/bridgex/Md5Util;->TAG:Ljava/lang/String;

    const-string v2, "MD5 string empty or updateFile null"

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 54
    return v1
.end method

.method private static getDigest([BLjava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p0, "bytes"    # [B
    .param p1, "algorithm"    # Ljava/lang/String;

    .line 32
    const/4 v0, 0x0

    .line 35
    .local v0, "messageDigest":Ljava/security/MessageDigest;
    :try_start_0
    invoke-static {p1}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v1

    move-object v0, v1

    .line 36
    invoke-virtual {v0}, Ljava/security/MessageDigest;->reset()V

    .line 37
    invoke-virtual {v0, p0}, Ljava/security/MessageDigest;->update([B)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 40
    nop

    .line 42
    invoke-virtual {v0}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v1

    .line 43
    .local v1, "byteArray":[B
    new-instance v2, Ljava/lang/StringBuilder;

    array-length v3, v1

    mul-int/lit8 v3, v3, 0x2

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 44
    .local v2, "md5StrBuff":Ljava/lang/StringBuilder;
    array-length v3, v1

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_0

    aget-byte v5, v1, v4

    .line 45
    .local v5, "b":B
    and-int/lit16 v6, v5, 0xff

    shr-int/lit8 v6, v6, 0x4

    invoke-static {v6}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 46
    and-int/lit8 v6, v5, 0xf

    invoke-static {v6}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 44
    .end local v5    # "b":B
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 48
    :cond_0
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 38
    .end local v1    # "byteArray":[B
    .end local v2    # "md5StrBuff":Ljava/lang/StringBuilder;
    :catch_0
    move-exception v1

    .line 39
    .local v1, "e":Ljava/lang/Exception;
    const/4 v2, 0x0

    return-object v2
.end method

.method static getMd5(Ljava/io/File;)Ljava/lang/String;
    .locals 11
    .param p0, "updateFile"    # Ljava/io/File;

    .line 72
    const-string v0, "Exception on closing MD5 input stream"

    const/4 v1, 0x0

    :try_start_0
    const-string v2, "MD5"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_4

    .line 76
    .local v2, "digest":Ljava/security/MessageDigest;
    nop

    .line 80
    :try_start_1
    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_3

    move-object v1, v3

    .line 84
    .local v1, "is":Ljava/io/InputStream;
    nop

    .line 86
    const/16 v3, 0x2000

    new-array v3, v3, [B

    .line 89
    .local v3, "buffer":[B
    :goto_0
    :try_start_2
    invoke-virtual {v1, v3}, Ljava/io/InputStream;->read([B)I

    move-result v4

    move v5, v4

    .local v5, "read":I
    const/4 v6, 0x0

    if-lez v4, :cond_0

    .line 90
    invoke-virtual {v2, v3, v6, v5}, Ljava/security/MessageDigest;->update([BII)V

    goto :goto_0

    .line 92
    :cond_0
    invoke-virtual {v2}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v4

    .line 93
    .local v4, "md5sum":[B
    new-instance v7, Ljava/math/BigInteger;

    const/4 v8, 0x1

    invoke-direct {v7, v8, v4}, Ljava/math/BigInteger;-><init>(I[B)V

    .line 94
    .local v7, "bigInt":Ljava/math/BigInteger;
    const/16 v9, 0x10

    invoke-virtual {v7, v9}, Ljava/math/BigInteger;->toString(I)Ljava/lang/String;

    move-result-object v9

    .line 96
    .local v9, "output":Ljava/lang/String;
    const-string v10, "%32s"

    new-array v8, v8, [Ljava/lang/Object;

    aput-object v9, v8, v6

    invoke-static {v10, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const/16 v8, 0x20

    const/16 v10, 0x30

    invoke-virtual {v6, v8, v10}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v6
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 97
    .end local v9    # "output":Ljava/lang/String;
    .local v6, "output":Ljava/lang/String;
    nop

    .line 102
    :try_start_3
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    .line 105
    goto :goto_1

    .line 103
    :catch_0
    move-exception v8

    .line 104
    .local v8, "e":Ljava/io/IOException;
    sget-object v9, Lzhao/zizzy/bridgex/Md5Util;->TAG:Ljava/lang/String;

    invoke-static {v9, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 97
    .end local v8    # "e":Ljava/io/IOException;
    :goto_1
    return-object v6

    .line 101
    .end local v4    # "md5sum":[B
    .end local v5    # "read":I
    .end local v6    # "output":Ljava/lang/String;
    .end local v7    # "bigInt":Ljava/math/BigInteger;
    :catchall_0
    move-exception v4

    goto :goto_2

    .line 98
    :catch_1
    move-exception v4

    .line 99
    .local v4, "e":Ljava/io/IOException;
    :try_start_4
    new-instance v5, Ljava/lang/RuntimeException;

    const-string v6, "Unable to process file for MD5"

    invoke-direct {v5, v6}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    .end local v1    # "is":Ljava/io/InputStream;
    .end local v2    # "digest":Ljava/security/MessageDigest;
    .end local v3    # "buffer":[B
    .end local p0    # "updateFile":Ljava/io/File;
    throw v5
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 102
    .end local v4    # "e":Ljava/io/IOException;
    .restart local v1    # "is":Ljava/io/InputStream;
    .restart local v2    # "digest":Ljava/security/MessageDigest;
    .restart local v3    # "buffer":[B
    .restart local p0    # "updateFile":Ljava/io/File;
    :goto_2
    :try_start_5
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2

    .line 105
    goto :goto_3

    .line 103
    :catch_2
    move-exception v5

    .line 104
    .local v5, "e":Ljava/io/IOException;
    sget-object v6, Lzhao/zizzy/bridgex/Md5Util;->TAG:Ljava/lang/String;

    invoke-static {v6, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 105
    .end local v5    # "e":Ljava/io/IOException;
    :goto_3
    throw v4

    .line 81
    .end local v1    # "is":Ljava/io/InputStream;
    .end local v3    # "buffer":[B
    :catch_3
    move-exception v0

    .line 82
    .local v0, "e":Ljava/io/FileNotFoundException;
    sget-object v3, Lzhao/zizzy/bridgex/Md5Util;->TAG:Ljava/lang/String;

    const-string v4, "Exception while getting FileInputStream"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 83
    return-object v1

    .line 73
    .end local v0    # "e":Ljava/io/FileNotFoundException;
    .end local v2    # "digest":Ljava/security/MessageDigest;
    :catch_4
    move-exception v0

    .line 74
    .local v0, "e":Ljava/security/NoSuchAlgorithmException;
    sget-object v2, Lzhao/zizzy/bridgex/Md5Util;->TAG:Ljava/lang/String;

    const-string v3, "Exception while getting digest"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 75
    return-object v1
.end method

.method static getMd5(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "input"    # Ljava/lang/String;

    .line 21
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 22
    return-object v1

    .line 25
    :cond_0
    :try_start_0
    const-string v0, "UTF-8"

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    const-string v2, "MD5"

    invoke-static {v0, v2}, Lzhao/zizzy/bridgex/Md5Util;->getDigest([BLjava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 26
    :catch_0
    move-exception v0

    .line 27
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    return-object v1
.end method
