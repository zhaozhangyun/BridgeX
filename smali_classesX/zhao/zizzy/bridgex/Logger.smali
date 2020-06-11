.class public Lzhao/zizzy/bridgex/Logger;
.super Ljava/lang/Object;
.source "Logger.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;,
        Lzhao/zizzy/bridgex/Logger$LoggerBuilder;,
        Lzhao/zizzy/bridgex/Logger$PreloadHolder;
    }
.end annotation


# static fields
.field private static DEBUG:Z

.field private static final TAG:Ljava/lang/String;

.field private static instance:Lzhao/zizzy/bridgex/Logger;


# instance fields
.field private atomI:Ljava/util/concurrent/atomic/AtomicInteger;

.field private debuggable:Z

.field private defaultTag:Ljava/lang/String;

.field private enableStackPackage:Z

.field private exportJson:Z

.field private exportJsonDir:Ljava/io/File;

.field private fileCache:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private maxLogStackIndex:I

.field private showAllStack:Z

.field private stackPackage:Ljava/lang/String;

.field private startIndex:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 32
    const-class v0, Lzhao/zizzy/bridgex/Logger;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lzhao/zizzy/bridgex/Logger;->TAG:Ljava/lang/String;

    .line 37
    const/4 v0, 0x0

    sput-boolean v0, Lzhao/zizzy/bridgex/Logger;->DEBUG:Z

    .line 38
    return-void
.end method

.method constructor <init>(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)V
    .locals 2
    .param p1, "builder"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 53
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$000(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    .line 54
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$100(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z

    move-result v0

    iput-boolean v0, p0, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    .line 55
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$200(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z

    move-result v0

    iput-boolean v0, p0, Lzhao/zizzy/bridgex/Logger;->showAllStack:Z

    .line 56
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$300(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)I

    move-result v0

    iput v0, p0, Lzhao/zizzy/bridgex/Logger;->maxLogStackIndex:I

    .line 57
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$400(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z

    move-result v0

    iput-boolean v0, p0, Lzhao/zizzy/bridgex/Logger;->enableStackPackage:Z

    .line 58
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$500(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)I

    move-result v0

    iput v0, p0, Lzhao/zizzy/bridgex/Logger;->startIndex:I

    .line 59
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$600(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger;->stackPackage:Ljava/lang/String;

    .line 60
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$700(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z

    move-result v0

    iput-boolean v0, p0, Lzhao/zizzy/bridgex/Logger;->exportJson:Z

    .line 61
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$800(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/io/File;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger;->exportJsonDir:Ljava/io/File;

    .line 63
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 64
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger;->fileCache:Ljava/util/Map;

    .line 65
    return-void
.end method

.method static synthetic access$1000()Lzhao/zizzy/bridgex/Logger;
    .locals 1

    .line 30
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    return-object v0
.end method

.method static synthetic access$1002(Lzhao/zizzy/bridgex/Logger;)Lzhao/zizzy/bridgex/Logger;
    .locals 0
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger;

    .line 30
    sput-object p0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    return-object p0
.end method

.method static synthetic access$900(Ljava/io/File;)Z
    .locals 1
    .param p0, "x0"    # Ljava/io/File;

    .line 30
    invoke-static {p0}, Lzhao/zizzy/bridgex/Logger;->ensureCreated(Ljava/io/File;)Z

    move-result v0

    return v0
.end method

.method private diff(Ljava/lang/String;Ljava/lang/String;)I
    .locals 10
    .param p1, "clazz"    # Ljava/lang/String;
    .param p2, "stackPackage"    # Ljava/lang/String;

    .line 380
    const-string v0, "\\."

    iget-boolean v1, p0, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v1, :cond_0

    .line 381
    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "call diff(): clazz="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ", stackPackage="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 383
    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    .line 384
    return v2

    .line 387
    :cond_1
    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v3, 0x1

    if-eqz v1, :cond_2

    .line 388
    return v3

    .line 392
    :cond_2
    :try_start_0
    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 393
    .local v1, "split1":[Ljava/lang/String;
    invoke-virtual {p2, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 394
    .local v0, "split2":[Ljava/lang/String;
    array-length v4, v1

    array-length v5, v0

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 395
    .local v4, "len":I
    const/4 v5, 0x0

    .line 396
    .local v5, "n":I
    const/4 v6, 0x0

    .line 398
    .local v6, "i":I
    :cond_3
    aget-object v7, v1, v6

    .line 399
    .local v7, "s1":Ljava/lang/String;
    aget-object v8, v0, v6

    .line 400
    .local v8, "s2":Ljava/lang/String;
    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v9, :cond_4

    .line 401
    add-int/lit8 v5, v5, 0x1

    .line 403
    .end local v7    # "s1":Ljava/lang/String;
    .end local v8    # "s2":Ljava/lang/String;
    :cond_4
    add-int/lit8 v6, v6, 0x1

    if-lt v6, v4, :cond_3

    .line 405
    if-ne v5, v4, :cond_5

    .line 406
    return v3

    .line 410
    .end local v0    # "split2":[Ljava/lang/String;
    .end local v1    # "split1":[Ljava/lang/String;
    .end local v4    # "len":I
    .end local v5    # "n":I
    .end local v6    # "i":I
    :cond_5
    goto :goto_0

    .line 408
    :catchall_0
    move-exception v0

    .line 409
    .local v0, "th":Ljava/lang/Throwable;
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    .line 412
    .end local v0    # "th":Ljava/lang/Throwable;
    :goto_0
    return v2
.end method

.method private static ensureCreated(Ljava/io/File;)Z
    .locals 3
    .param p0, "folder"    # Ljava/io/File;

    .line 168
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->mkdirs()Z

    move-result v0

    if-nez v0, :cond_0

    .line 169
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unable to create the directory: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 170
    const/4 v0, 0x0

    return v0

    .line 172
    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method private exportJson(Ljava/lang/Object;)Ljava/lang/String;
    .locals 8
    .param p1, "source"    # Ljava/lang/Object;

    .line 311
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 312
    return-object v1

    .line 315
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Md5Util;->getMd5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 316
    .local v0, "md5":Ljava/lang/String;
    iget-object v2, p0, Lzhao/zizzy/bridgex/Logger;->fileCache:Ljava/util/Map;

    if-eqz v2, :cond_1

    invoke-interface {v2, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 317
    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger;->fileCache:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    return-object v1

    .line 320
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ".json"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 321
    .local v2, "jsonFileName":Ljava/lang/String;
    new-instance v3, Ljava/io/File;

    iget-object v4, p0, Lzhao/zizzy/bridgex/Logger;->exportJsonDir:Ljava/io/File;

    invoke-direct {v3, v4, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 322
    .local v3, "file":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v4

    if-nez v4, :cond_2

    .line 324
    :try_start_0
    invoke-virtual {v3}, Ljava/io/File;->createNewFile()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 326
    goto :goto_0

    .line 325
    :catchall_0
    move-exception v4

    .line 329
    :cond_2
    :goto_0
    const/4 v4, 0x0

    .line 331
    .local v4, "bufWriter":Ljava/io/BufferedWriter;
    :try_start_1
    new-instance v5, Ljava/io/BufferedWriter;

    new-instance v6, Ljava/io/FileWriter;

    const/4 v7, 0x1

    invoke-direct {v6, v3, v7}, Ljava/io/FileWriter;-><init>(Ljava/io/File;Z)V

    invoke-direct {v5, v6}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    move-object v4, v5

    .line 332
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 333
    invoke-virtual {v4}, Ljava/io/BufferedWriter;->newLine()V

    .line 334
    invoke-virtual {v4}, Ljava/io/BufferedWriter;->flush()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 338
    nop

    .line 340
    :try_start_2
    invoke-virtual {v4}, Ljava/io/BufferedWriter;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 342
    :goto_1
    goto :goto_2

    .line 341
    :catch_0
    move-exception v1

    goto :goto_1

    .line 346
    :goto_2
    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger;->fileCache:Ljava/util/Map;

    if-eqz v1, :cond_3

    invoke-interface {v1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 347
    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger;->fileCache:Ljava/util/Map;

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v1, v0, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 350
    :cond_3
    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 335
    :catchall_1
    move-exception v5

    .line 336
    .local v5, "th":Ljava/lang/Throwable;
    nop

    .line 338
    if-eqz v4, :cond_4

    .line 340
    :try_start_3
    invoke-virtual {v4}, Ljava/io/BufferedWriter;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    .line 342
    goto :goto_3

    .line 341
    :catch_1
    move-exception v6

    .line 336
    :cond_4
    :goto_3
    return-object v1
.end method

.method private format(Ljava/lang/Object;)Ljava/lang/String;
    .locals 4
    .param p1, "source"    # Ljava/lang/Object;

    .line 447
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 448
    .local v0, "builder":Ljava/lang/StringBuilder;
    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 449
    const/16 v2, 0x64

    invoke-direct {p0, v2}, Lzhao/zizzy/bridgex/Logger;->getSplitter(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 450
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 451
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 452
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 453
    invoke-direct {p0, v2}, Lzhao/zizzy/bridgex/Logger;->getSplitter(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 454
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private formatJson(Ljava/lang/Object;)Ljava/lang/String;
    .locals 3
    .param p1, "source"    # Ljava/lang/Object;

    .line 420
    invoke-direct {p0, p1}, Lzhao/zizzy/bridgex/Logger;->getJsonObjFromStr(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 421
    .local v0, "o":Ljava/lang/Object;
    if-eqz v0, :cond_2

    .line 423
    :try_start_0
    instance-of v1, v0, Lorg/json/JSONObject;

    const/4 v2, 0x2

    if-eqz v1, :cond_0

    .line 424
    move-object v1, v0

    check-cast v1, Lorg/json/JSONObject;

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->toString(I)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 425
    :cond_0
    instance-of v1, v0, Lorg/json/JSONArray;

    if-eqz v1, :cond_1

    .line 426
    move-object v1, v0

    check-cast v1, Lorg/json/JSONArray;

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->toString(I)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 428
    :cond_1
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 430
    :catch_0
    move-exception v1

    .line 431
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 434
    .end local v1    # "e":Lorg/json/JSONException;
    :cond_2
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private getFormatLog(Ljava/lang/Object;)Ljava/lang/String;
    .locals 2
    .param p1, "o"    # Ljava/lang/Object;

    .line 416
    const/4 v0, 0x0

    if-nez p1, :cond_0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "---> <CALL>"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    aput-object p1, v1, v0

    const-string v0, "---> %s"

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method private getJsonObjFromStr(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4
    .param p1, "test"    # Ljava/lang/Object;

    .line 458
    const/4 v0, 0x0

    .line 460
    .local v0, "o":Ljava/lang/Object;
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 469
    goto :goto_0

    .line 461
    :catch_0
    move-exception v1

    .line 463
    .local v1, "ex":Lorg/json/JSONException;
    :try_start_1
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x13

    if-lt v2, v3, :cond_0

    .line 464
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2, p1}, Lorg/json/JSONArray;-><init>(Ljava/lang/Object;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    move-object v0, v2

    .line 468
    :cond_0
    nop

    .line 470
    .end local v1    # "ex":Lorg/json/JSONException;
    :goto_0
    return-object v0

    .line 466
    .restart local v1    # "ex":Lorg/json/JSONException;
    :catch_1
    move-exception v2

    .line 467
    .local v2, "ex1":Lorg/json/JSONException;
    const/4 v3, 0x0

    return-object v3
.end method

.method private getRealStackLen(Ljava/lang/String;Ljava/util/List;)I
    .locals 5
    .param p1, "diffSeq"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)I"
        }
    .end annotation

    .line 354
    .local p2, "stackList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v0, :cond_0

    .line 355
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "diffBuilder="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 358
    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 359
    const/4 v0, 0x0

    return v0

    .line 362
    :cond_1
    const/4 v0, 0x0

    .line 364
    .local v0, "stackLen":I
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "1"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 365
    invoke-virtual {p1, v1}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v1

    .line 366
    .local v1, "lastIndex":I
    iget-boolean v2, p0, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v2, :cond_2

    .line 367
    iget-object v2, p0, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "lastIndex="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 369
    :cond_2
    add-int/lit8 v0, v1, 0x1

    .line 372
    .end local v1    # "lastIndex":I
    :cond_3
    iget-boolean v1, p0, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v1, :cond_4

    .line 373
    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "stackLen="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 376
    :cond_4
    return v0
.end method

.method private getSplitter(I)Ljava/lang/String;
    .locals 3
    .param p1, "length"    # I

    .line 439
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 440
    .local v0, "builder":Ljava/lang/StringBuilder;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, p1, :cond_0

    .line 441
    const-string v2, "-"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 440
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 443
    .end local v1    # "i":I
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static log()V
    .locals 2

    .line 113
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 117
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 118
    const/4 v0, 0x0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->log([Ljava/lang/Object;)V

    .line 119
    return-void

    .line 114
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static log(D)V
    .locals 2
    .param p0, "source"    # D

    .line 95
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 99
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 100
    invoke-static {p0, p1}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/Object;)V

    .line 101
    return-void

    .line 96
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static log(F)V
    .locals 2
    .param p0, "source"    # F

    .line 86
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 90
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 91
    invoke-static {p0}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/Object;)V

    .line 92
    return-void

    .line 87
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static log(I)V
    .locals 2
    .param p0, "source"    # I

    .line 68
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 72
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 73
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/Object;)V

    .line 74
    return-void

    .line 69
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static log(J)V
    .locals 2
    .param p0, "source"    # J

    .line 77
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 81
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 82
    invoke-static {p0, p1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/Object;)V

    .line 83
    return-void

    .line 78
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static log(Ljava/lang/Object;)V
    .locals 2
    .param p0, "source"    # Ljava/lang/Object;

    .line 122
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 126
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 127
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 128
    .local v0, "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 129
    invoke-interface {v0}, Ljava/util/List;->toArray()[Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lzhao/zizzy/bridgex/Logger;->log([Ljava/lang/Object;)V

    .line 130
    return-void

    .line 123
    .end local v0    # "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private log(Ljava/lang/String;ILjava/lang/Object;Ljava/lang/Throwable;)V
    .locals 28
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "priority"    # I
    .param p3, "source"    # Ljava/lang/Object;
    .param p4, "th"    # Ljava/lang/Throwable;

    .line 177
    move-object/from16 v1, p0

    move-object/from16 v0, p1

    move-object/from16 v2, p3

    invoke-static/range {p1 .. p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    iget-object v3, v1, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 178
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, v1, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "-"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v3, v0

    .end local p1    # "tag":Ljava/lang/String;
    .local v0, "tag":Ljava/lang/String;
    goto :goto_0

    .line 180
    .end local v0    # "tag":Ljava/lang/String;
    .restart local p1    # "tag":Ljava/lang/String;
    :cond_0
    iget-object v0, v1, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    move-object v3, v0

    .line 183
    .end local p1    # "tag":Ljava/lang/String;
    .local v3, "tag":Ljava/lang/String;
    :goto_0
    if-eqz v2, :cond_1

    .line 184
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1a

    if-lt v0, v4, :cond_1

    iget-boolean v0, v1, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v0, :cond_1

    .line 185
    iget-object v0, v1, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "source type: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual/range {p3 .. p3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getTypeName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 189
    :cond_1
    new-instance v0, Ljava/lang/Throwable;

    invoke-direct {v0}, Ljava/lang/Throwable;-><init>()V

    move-object v4, v0

    .line 190
    .local v4, "throwable":Ljava/lang/Throwable;
    iget-boolean v0, v1, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v0, :cond_2

    sget-boolean v0, Lzhao/zizzy/bridgex/Logger;->DEBUG:Z

    if-eqz v0, :cond_2

    .line 191
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, " ++++++"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v2}, Lzhao/zizzy/bridgex/Logger;->getFormatLog(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v0, v5, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 194
    :cond_2
    iget-object v0, v1, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v0

    iget v5, v1, Lzhao/zizzy/bridgex/Logger;->startIndex:I

    add-int/2addr v5, v0

    .line 195
    .local v5, "currentIndex":I
    iget-boolean v0, v1, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v0, :cond_3

    .line 196
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "atomI: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v7, v1, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v7}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v0, v6}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 197
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "currentIndex: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v0, v6}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 204
    :cond_3
    const-string v6, " "

    .line 205
    .local v6, "space":Ljava/lang/String;
    const/4 v7, 0x0

    .line 207
    .local v7, "jsonFilePath":Ljava/lang/String;
    invoke-virtual {v4}, Ljava/lang/Throwable;->fillInStackTrace()Ljava/lang/Throwable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v8

    .line 208
    .local v8, "stacks":[Ljava/lang/StackTraceElement;
    iget v0, v1, Lzhao/zizzy/bridgex/Logger;->maxLogStackIndex:I

    add-int/2addr v0, v5

    const/4 v9, 0x1

    add-int/lit8 v10, v0, 0x1

    .line 209
    .local v10, "stackSize":I
    array-length v0, v8

    if-gt v10, v0, :cond_4

    move v0, v10

    goto :goto_1

    :cond_4
    array-length v0, v8

    :goto_1
    move v11, v0

    .line 210
    .local v11, "maxStackSize":I
    iget-boolean v0, v1, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v0, :cond_5

    .line 211
    iget-object v0, v1, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "stackSize: "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    array-length v13, v8

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v0, v12}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 212
    iget-object v0, v1, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "maxStackSize: "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v0, v12}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 215
    :cond_5
    if-eqz v2, :cond_7

    .line 218
    :try_start_0
    new-instance v0, Ljava/lang/ref/WeakReference;

    new-instance v12, Lorg/json/JSONObject;

    invoke-virtual/range {p3 .. p3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-direct {v12, v13}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v12}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    .line 219
    invoke-direct {v1, v2}, Lzhao/zizzy/bridgex/Logger;->formatJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-object v2, v0

    .line 220
    .end local p3    # "source":Ljava/lang/Object;
    .local v2, "source":Ljava/lang/Object;
    :try_start_1
    iget-boolean v0, v1, Lzhao/zizzy/bridgex/Logger;->exportJson:Z

    if-eqz v0, :cond_6

    .line 221
    invoke-direct {v1, v2}, Lzhao/zizzy/bridgex/Logger;->exportJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    move-object v7, v0

    .line 223
    :cond_6
    invoke-direct {v1, v2}, Lzhao/zizzy/bridgex/Logger;->format(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 226
    .end local v2    # "source":Ljava/lang/Object;
    .local v0, "source":Ljava/lang/Object;
    move-object v2, v0

    goto :goto_3

    .line 224
    .end local v0    # "source":Ljava/lang/Object;
    .restart local v2    # "source":Ljava/lang/Object;
    :catchall_0
    move-exception v0

    goto :goto_2

    .end local v2    # "source":Ljava/lang/Object;
    .restart local p3    # "source":Ljava/lang/Object;
    :catchall_1
    move-exception v0

    .line 225
    .end local p3    # "source":Ljava/lang/Object;
    .local v0, "t":Ljava/lang/Throwable;
    .restart local v2    # "source":Ljava/lang/Object;
    :goto_2
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    .line 229
    .end local v0    # "t":Ljava/lang/Throwable;
    :cond_7
    :goto_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 230
    .local v0, "stackBuilder":Ljava/lang/StringBuilder;
    const/4 v12, 0x1

    .line 231
    .local v12, "isFirstLine":Z
    new-instance v13, Ljava/util/ArrayList;

    invoke-direct {v13}, Ljava/util/ArrayList;-><init>()V

    .line 232
    .local v13, "stackList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const/4 v14, 0x0

    .line 234
    .local v14, "diffBuilder":Ljava/lang/StringBuilder;
    move v15, v5

    .local v15, "i":I
    :goto_4
    if-ge v15, v11, :cond_11

    .line 235
    aget-object v16, v8, v15

    .line 236
    .local v16, "element":Ljava/lang/StackTraceElement;
    invoke-virtual/range {v16 .. v16}, Ljava/lang/StackTraceElement;->getFileName()Ljava/lang/String;

    move-result-object v17

    .line 237
    .local v17, "fileName":Ljava/lang/String;
    invoke-virtual/range {v16 .. v16}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v9

    .line 238
    .local v9, "className":Ljava/lang/String;
    invoke-virtual/range {v16 .. v16}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object v18

    .line 239
    .local v18, "methodClass":Ljava/lang/String;
    invoke-virtual/range {v16 .. v16}, Ljava/lang/StackTraceElement;->getLineNumber()I

    move-result v19

    .line 241
    .local v19, "lineNumber":I
    invoke-static/range {v17 .. v17}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v20

    if-eqz v20, :cond_8

    .line 242
    const-string v17, "Unknown Source"

    .line 243
    const/16 v19, 0x0

    move/from16 v27, v19

    move-object/from16 v19, v4

    move/from16 v4, v27

    goto :goto_5

    .line 241
    :cond_8
    move/from16 v27, v19

    move-object/from16 v19, v4

    move/from16 v4, v27

    .line 246
    .local v4, "lineNumber":I
    .local v19, "throwable":Ljava/lang/Throwable;
    :goto_5
    move-object/from16 v20, v8

    .end local v8    # "stacks":[Ljava/lang/StackTraceElement;
    .local v20, "stacks":[Ljava/lang/StackTraceElement;
    const/4 v8, -0x2

    if-ne v4, v8, :cond_9

    .line 247
    const-string v17, "Native Method"

    .line 250
    :cond_9
    const/16 v22, 0x3

    const/16 v23, 0x2

    if-eqz v12, :cond_c

    .line 251
    const/4 v12, 0x0

    .line 253
    const/4 v8, -0x2

    if-eq v4, v8, :cond_a

    .line 254
    const/4 v8, 0x5

    new-array v8, v8, [Ljava/lang/Object;

    const/16 v21, 0x0

    aput-object v17, v8, v21

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v21

    const/16 v24, 0x1

    aput-object v21, v8, v24

    aput-object v9, v8, v23

    aput-object v18, v8, v22

    .line 255
    invoke-direct {v1, v2}, Lzhao/zizzy/bridgex/Logger;->getFormatLog(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v21

    move/from16 v25, v10

    const/4 v10, 0x4

    .end local v10    # "stackSize":I
    .local v25, "stackSize":I
    aput-object v21, v8, v10

    .line 254
    const-string v10, "--- [%s:%s] %s.%s %s"

    invoke-static {v10, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_6

    .line 257
    .end local v25    # "stackSize":I
    .restart local v10    # "stackSize":I
    :cond_a
    move/from16 v25, v10

    const/4 v10, 0x4

    .end local v10    # "stackSize":I
    .restart local v25    # "stackSize":I
    new-array v8, v10, [Ljava/lang/Object;

    const/4 v10, 0x0

    aput-object v17, v8, v10

    const/4 v10, 0x1

    aput-object v9, v8, v10

    aput-object v18, v8, v23

    .line 258
    invoke-direct {v1, v2}, Lzhao/zizzy/bridgex/Logger;->getFormatLog(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v22

    .line 257
    const-string v10, "--- [%s] %s.%s %s"

    invoke-static {v10, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 261
    :goto_6
    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_b

    .line 262
    const-string v8, "\n++++++ : "

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 265
    :cond_b
    invoke-static {v3, v2}, Lzhao/zizzy/bridgex/LogBridge;->log(Ljava/lang/String;Ljava/lang/Object;)V

    move-object/from16 v26, v2

    const/4 v8, 0x1

    goto/16 :goto_9

    .line 266
    .end local v25    # "stackSize":I
    .restart local v10    # "stackSize":I
    :cond_c
    move/from16 v25, v10

    .end local v10    # "stackSize":I
    .restart local v25    # "stackSize":I
    iget-boolean v8, v1, Lzhao/zizzy/bridgex/Logger;->showAllStack:Z

    if-eqz v8, :cond_10

    if-le v15, v5, :cond_10

    .line 267
    iget-boolean v8, v1, Lzhao/zizzy/bridgex/Logger;->enableStackPackage:Z

    if-eqz v8, :cond_e

    .line 268
    iget-object v8, v1, Lzhao/zizzy/bridgex/Logger;->stackPackage:Ljava/lang/String;

    invoke-direct {v1, v9, v8}, Lzhao/zizzy/bridgex/Logger;->diff(Ljava/lang/String;Ljava/lang/String;)I

    move-result v8

    .line 269
    .local v8, "diffValue":I
    if-nez v14, :cond_d

    .line 270
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    move-object v14, v10

    .line 272
    :cond_d
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v26, v2

    .end local v2    # "source":Ljava/lang/Object;
    .local v26, "source":Ljava/lang/Object;
    const-string v2, ""

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v14, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_7

    .line 267
    .end local v8    # "diffValue":I
    .end local v26    # "source":Ljava/lang/Object;
    .restart local v2    # "source":Ljava/lang/Object;
    :cond_e
    move-object/from16 v26, v2

    .line 275
    .end local v2    # "source":Ljava/lang/Object;
    .restart local v26    # "source":Ljava/lang/Object;
    :goto_7
    const/4 v2, -0x2

    if-eq v4, v2, :cond_f

    .line 276
    const/4 v2, 0x5

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v8, 0x0

    aput-object v6, v2, v8

    const/4 v8, 0x1

    aput-object v17, v2, v8

    .line 277
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v2, v23

    aput-object v9, v2, v22

    const/4 v8, 0x4

    aput-object v18, v2, v8

    .line 276
    const-string v8, "%s|-- [%s:%s] %s.%s"

    invoke-static {v8, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v13, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 v8, 0x1

    goto :goto_8

    .line 279
    :cond_f
    const/4 v8, 0x4

    new-array v2, v8, [Ljava/lang/Object;

    const/4 v8, 0x0

    aput-object v6, v2, v8

    const/4 v8, 0x1

    aput-object v17, v2, v8

    aput-object v9, v2, v23

    aput-object v18, v2, v22

    const-string v10, "%s|-- [%s] %s.%s"

    invoke-static {v10, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v13, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 282
    :goto_8
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v10, "  "

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v6, v2

    .end local v6    # "space":Ljava/lang/String;
    .local v2, "space":Ljava/lang/String;
    goto :goto_9

    .line 266
    .end local v26    # "source":Ljava/lang/Object;
    .local v2, "source":Ljava/lang/Object;
    .restart local v6    # "space":Ljava/lang/String;
    :cond_10
    move-object/from16 v26, v2

    const/4 v8, 0x1

    .line 234
    .end local v2    # "source":Ljava/lang/Object;
    .end local v16    # "element":Ljava/lang/StackTraceElement;
    .restart local v26    # "source":Ljava/lang/Object;
    :goto_9
    add-int/lit8 v15, v15, 0x1

    move-object/from16 v4, v19

    move-object/from16 v8, v20

    move/from16 v10, v25

    move-object/from16 v2, v26

    const/4 v9, 0x1

    goto/16 :goto_4

    .end local v9    # "className":Ljava/lang/String;
    .end local v17    # "fileName":Ljava/lang/String;
    .end local v18    # "methodClass":Ljava/lang/String;
    .end local v19    # "throwable":Ljava/lang/Throwable;
    .end local v20    # "stacks":[Ljava/lang/StackTraceElement;
    .end local v25    # "stackSize":I
    .end local v26    # "source":Ljava/lang/Object;
    .restart local v2    # "source":Ljava/lang/Object;
    .local v4, "throwable":Ljava/lang/Throwable;
    .local v8, "stacks":[Ljava/lang/StackTraceElement;
    .restart local v10    # "stackSize":I
    :cond_11
    move-object/from16 v26, v2

    move-object/from16 v19, v4

    move-object/from16 v20, v8

    move/from16 v25, v10

    .line 286
    .end local v2    # "source":Ljava/lang/Object;
    .end local v4    # "throwable":Ljava/lang/Throwable;
    .end local v8    # "stacks":[Ljava/lang/StackTraceElement;
    .end local v10    # "stackSize":I
    .end local v15    # "i":I
    .restart local v19    # "throwable":Ljava/lang/Throwable;
    .restart local v20    # "stacks":[Ljava/lang/StackTraceElement;
    .restart local v25    # "stackSize":I
    .restart local v26    # "source":Ljava/lang/Object;
    iget-boolean v2, v1, Lzhao/zizzy/bridgex/Logger;->showAllStack:Z

    if-eqz v2, :cond_14

    .line 287
    invoke-interface {v13}, Ljava/util/List;->size()I

    move-result v2

    .line 289
    .local v2, "stackLen":I
    iget-boolean v4, v1, Lzhao/zizzy/bridgex/Logger;->enableStackPackage:Z

    if-eqz v4, :cond_13

    .line 290
    const/4 v4, 0x0

    .line 291
    .local v4, "diffSeq":Ljava/lang/String;
    if-eqz v14, :cond_12

    .line 292
    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 294
    :cond_12
    invoke-direct {v1, v4, v13}, Lzhao/zizzy/bridgex/Logger;->getRealStackLen(Ljava/lang/String;Ljava/util/List;)I

    move-result v2

    .line 297
    .end local v4    # "diffSeq":Ljava/lang/String;
    :cond_13
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_a
    if-ge v4, v2, :cond_14

    .line 298
    const-string v8, "\n"

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {v13, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 297
    add-int/lit8 v4, v4, 0x1

    goto :goto_a

    .line 302
    .end local v2    # "stackLen":I
    .end local v4    # "i":I
    :cond_14
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move/from16 v4, p2

    move-object/from16 v8, p4

    invoke-direct {v1, v4, v3, v2, v8}, Lzhao/zizzy/bridgex/Logger;->printlns(ILjava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v2

    .line 303
    .local v2, "len":I
    iget-boolean v9, v1, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v9, :cond_15

    .line 304
    iget-object v9, v1, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "printLength: "

    invoke-virtual {v10, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 307
    :cond_15
    iget-object v9, v1, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v10, 0x0

    invoke-virtual {v9, v10}, Ljava/util/concurrent/atomic/AtomicInteger;->getAndSet(I)I

    .line 308
    return-void
.end method

.method public static log(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 3
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "source"    # Ljava/lang/Object;

    .line 159
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 163
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 164
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    const/4 v1, 0x3

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, p1, v2}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/String;ILjava/lang/Object;Ljava/lang/Throwable;)V

    .line 165
    return-void

    .line 160
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static log(Z)V
    .locals 2
    .param p0, "source"    # Z

    .line 104
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 108
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 109
    invoke-static {p0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/Object;)V

    .line 110
    return-void

    .line 105
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static varargs log([Ljava/lang/Object;)V
    .locals 8
    .param p0, "args"    # [Ljava/lang/Object;

    .line 133
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_4

    .line 137
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 139
    const/4 v0, 0x0

    if-eqz p0, :cond_3

    array-length v1, p0

    if-nez v1, :cond_0

    goto :goto_2

    .line 144
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 145
    .local v1, "builder":Ljava/lang/StringBuilder;
    const/4 v2, 0x1

    .line 146
    .local v2, "isFirst":Z
    array-length v3, p0

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_2

    aget-object v5, p0, v4

    .line 147
    .local v5, "arg":Ljava/lang/Object;
    if-eqz v2, :cond_1

    .line 148
    const/4 v2, 0x0

    .line 149
    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 151
    :cond_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, ", "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 146
    .end local v5    # "arg":Ljava/lang/Object;
    :goto_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 155
    :cond_2
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/String;Ljava/lang/Object;)V

    .line 156
    return-void

    .line 140
    .end local v1    # "builder":Ljava/lang/StringBuilder;
    .end local v2    # "isFirst":Z
    :cond_3
    :goto_2
    invoke-static {v0, v0}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/String;Ljava/lang/Object;)V

    .line 141
    return-void

    .line 134
    :cond_4
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    goto :goto_4

    :goto_3
    throw v0

    :goto_4
    goto :goto_3
.end method

.method private printlns(ILjava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    .locals 6
    .param p1, "priority"    # I
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "msg"    # Ljava/lang/String;
    .param p4, "tr"    # Ljava/lang/Throwable;

    .line 474
    new-instance v0, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;

    invoke-direct {v0, p0, p1, p2}, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;-><init>(Lzhao/zizzy/bridgex/Logger;ILjava/lang/String;)V

    .line 479
    .local v0, "logWriter":Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;
    if-eqz p2, :cond_0

    .line 481
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    rsub-int v1, v1, 0xf9e

    add-int/lit8 v1, v1, -0x20

    .line 484
    .local v1, "bufferSize":I
    const/16 v2, 0x64

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 486
    new-instance v2, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;

    invoke-direct {v2, v0, v1}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;-><init>(Ljava/io/Writer;I)V

    .line 488
    .local v2, "lbbw":Lzhao/zizzy/bridgex/LineBreakBufferedWriter;
    invoke-virtual {v2, p3}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->println(Ljava/lang/String;)V

    .line 490
    if-eqz p4, :cond_4

    .line 493
    move-object v3, p4

    .line 494
    .local v3, "t":Ljava/lang/Throwable;
    :goto_1
    if-eqz v3, :cond_3

    .line 495
    instance-of v4, v3, Ljava/net/UnknownHostException;

    if-eqz v4, :cond_1

    .line 496
    goto :goto_2

    .line 498
    :cond_1
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x18

    if-lt v4, v5, :cond_2

    .line 499
    instance-of v4, v3, Landroid/os/DeadSystemException;

    if-eqz v4, :cond_2

    .line 500
    const-string v4, "DeadSystemException: The system died; earlier logs will point to the root cause"

    invoke-virtual {v2, v4}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->println(Ljava/lang/String;)V

    .line 502
    goto :goto_2

    .line 505
    :cond_2
    invoke-virtual {v3}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v3

    goto :goto_1

    .line 507
    :cond_3
    :goto_2
    if-nez v3, :cond_4

    .line 508
    invoke-virtual {p4, v2}, Ljava/lang/Throwable;->printStackTrace(Ljava/io/PrintWriter;)V

    .line 512
    .end local v3    # "t":Ljava/lang/Throwable;
    :cond_4
    invoke-virtual {v2}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->flush()V

    .line 514
    invoke-virtual {v0}, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;->getWritten()I

    move-result v3

    return v3
.end method
