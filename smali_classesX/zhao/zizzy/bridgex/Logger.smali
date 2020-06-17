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

    .line 28
    const-class v0, Lzhao/zizzy/bridgex/Logger;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lzhao/zizzy/bridgex/Logger;->TAG:Ljava/lang/String;

    .line 33
    const/4 v0, 0x0

    sput-boolean v0, Lzhao/zizzy/bridgex/Logger;->DEBUG:Z

    .line 34
    return-void
.end method

.method constructor <init>(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)V
    .locals 2
    .param p1, "builder"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$000(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    .line 50
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$100(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z

    move-result v0

    iput-boolean v0, p0, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    .line 51
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$200(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z

    move-result v0

    iput-boolean v0, p0, Lzhao/zizzy/bridgex/Logger;->showAllStack:Z

    .line 52
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$300(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)I

    move-result v0

    iput v0, p0, Lzhao/zizzy/bridgex/Logger;->maxLogStackIndex:I

    .line 53
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$400(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z

    move-result v0

    iput-boolean v0, p0, Lzhao/zizzy/bridgex/Logger;->enableStackPackage:Z

    .line 54
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$500(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)I

    move-result v0

    iput v0, p0, Lzhao/zizzy/bridgex/Logger;->startIndex:I

    .line 55
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$600(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger;->stackPackage:Ljava/lang/String;

    .line 56
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$700(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z

    move-result v0

    iput-boolean v0, p0, Lzhao/zizzy/bridgex/Logger;->exportJson:Z

    .line 57
    invoke-static {p1}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->access$800(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/io/File;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger;->exportJsonDir:Ljava/io/File;

    .line 59
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 60
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger;->fileCache:Ljava/util/Map;

    .line 61
    return-void
.end method

.method static synthetic access$1000()Lzhao/zizzy/bridgex/Logger;
    .locals 1

    .line 26
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    return-object v0
.end method

.method static synthetic access$1002(Lzhao/zizzy/bridgex/Logger;)Lzhao/zizzy/bridgex/Logger;
    .locals 0
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger;

    .line 26
    sput-object p0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    return-object p0
.end method

.method static synthetic access$900(Ljava/io/File;)Z
    .locals 1
    .param p0, "x0"    # Ljava/io/File;

    .line 26
    invoke-static {p0}, Lzhao/zizzy/bridgex/Logger;->ensureCreated(Ljava/io/File;)Z

    move-result v0

    return v0
.end method

.method private diff(Ljava/lang/String;Ljava/lang/String;)I
    .locals 10
    .param p1, "clazz"    # Ljava/lang/String;
    .param p2, "stackPackage"    # Ljava/lang/String;

    .line 383
    const-string v0, "\\."

    iget-boolean v1, p0, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v1, :cond_0

    .line 384
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

    .line 386
    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    .line 387
    return v2

    .line 390
    :cond_1
    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v3, 0x1

    if-eqz v1, :cond_2

    .line 391
    return v3

    .line 395
    :cond_2
    :try_start_0
    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 396
    .local v1, "split1":[Ljava/lang/String;
    invoke-virtual {p2, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 397
    .local v0, "split2":[Ljava/lang/String;
    array-length v4, v1

    array-length v5, v0

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 398
    .local v4, "len":I
    const/4 v5, 0x0

    .line 399
    .local v5, "n":I
    const/4 v6, 0x0

    .line 401
    .local v6, "i":I
    :cond_3
    aget-object v7, v1, v6

    .line 402
    .local v7, "s1":Ljava/lang/String;
    aget-object v8, v0, v6

    .line 403
    .local v8, "s2":Ljava/lang/String;
    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v9, :cond_4

    .line 404
    add-int/lit8 v5, v5, 0x1

    .line 406
    .end local v7    # "s1":Ljava/lang/String;
    .end local v8    # "s2":Ljava/lang/String;
    :cond_4
    add-int/lit8 v6, v6, 0x1

    if-lt v6, v4, :cond_3

    .line 408
    if-ne v5, v4, :cond_5

    .line 409
    return v3

    .line 413
    .end local v0    # "split2":[Ljava/lang/String;
    .end local v1    # "split1":[Ljava/lang/String;
    .end local v4    # "len":I
    .end local v5    # "n":I
    .end local v6    # "i":I
    :cond_5
    goto :goto_0

    .line 411
    :catchall_0
    move-exception v0

    .line 412
    .local v0, "th":Ljava/lang/Throwable;
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    .line 415
    .end local v0    # "th":Ljava/lang/Throwable;
    :goto_0
    return v2
.end method

.method private static ensureCreated(Ljava/io/File;)Z
    .locals 3
    .param p0, "folder"    # Ljava/io/File;

    .line 164
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->mkdirs()Z

    move-result v0

    if-nez v0, :cond_0

    .line 165
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

    .line 166
    const/4 v0, 0x0

    return v0

    .line 168
    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method private exportJson(Ljava/lang/Object;)Ljava/lang/String;
    .locals 8
    .param p1, "source"    # Ljava/lang/Object;

    .line 314
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 315
    return-object v1

    .line 318
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Md5Util;->getMd5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 319
    .local v0, "md5":Ljava/lang/String;
    iget-object v2, p0, Lzhao/zizzy/bridgex/Logger;->fileCache:Ljava/util/Map;

    if-eqz v2, :cond_1

    invoke-interface {v2, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 320
    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger;->fileCache:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    return-object v1

    .line 323
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ".json"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 324
    .local v2, "jsonFileName":Ljava/lang/String;
    new-instance v3, Ljava/io/File;

    iget-object v4, p0, Lzhao/zizzy/bridgex/Logger;->exportJsonDir:Ljava/io/File;

    invoke-direct {v3, v4, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 325
    .local v3, "file":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v4

    if-nez v4, :cond_2

    .line 327
    :try_start_0
    invoke-virtual {v3}, Ljava/io/File;->createNewFile()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 329
    goto :goto_0

    .line 328
    :catchall_0
    move-exception v4

    .line 332
    :cond_2
    :goto_0
    const/4 v4, 0x0

    .line 334
    .local v4, "bufWriter":Ljava/io/BufferedWriter;
    :try_start_1
    new-instance v5, Ljava/io/BufferedWriter;

    new-instance v6, Ljava/io/FileWriter;

    const/4 v7, 0x1

    invoke-direct {v6, v3, v7}, Ljava/io/FileWriter;-><init>(Ljava/io/File;Z)V

    invoke-direct {v5, v6}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    move-object v4, v5

    .line 335
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 336
    invoke-virtual {v4}, Ljava/io/BufferedWriter;->newLine()V

    .line 337
    invoke-virtual {v4}, Ljava/io/BufferedWriter;->flush()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 341
    nop

    .line 343
    :try_start_2
    invoke-virtual {v4}, Ljava/io/BufferedWriter;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 345
    :goto_1
    goto :goto_2

    .line 344
    :catch_0
    move-exception v1

    goto :goto_1

    .line 349
    :goto_2
    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger;->fileCache:Ljava/util/Map;

    if-eqz v1, :cond_3

    invoke-interface {v1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 350
    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger;->fileCache:Ljava/util/Map;

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v1, v0, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 353
    :cond_3
    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 338
    :catchall_1
    move-exception v5

    .line 339
    .local v5, "th":Ljava/lang/Throwable;
    nop

    .line 341
    if-eqz v4, :cond_4

    .line 343
    :try_start_3
    invoke-virtual {v4}, Ljava/io/BufferedWriter;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    .line 345
    goto :goto_3

    .line 344
    :catch_1
    move-exception v6

    .line 339
    :cond_4
    :goto_3
    return-object v1
.end method

.method private format(Ljava/lang/Object;)Ljava/lang/String;
    .locals 4
    .param p1, "source"    # Ljava/lang/Object;

    .line 450
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 451
    .local v0, "builder":Ljava/lang/StringBuilder;
    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 452
    const/16 v2, 0x64

    invoke-direct {p0, v2}, Lzhao/zizzy/bridgex/Logger;->getSplitter(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 453
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 454
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 455
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 456
    invoke-direct {p0, v2}, Lzhao/zizzy/bridgex/Logger;->getSplitter(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 457
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private formatJson(Ljava/lang/Object;)Ljava/lang/String;
    .locals 3
    .param p1, "source"    # Ljava/lang/Object;

    .line 423
    invoke-direct {p0, p1}, Lzhao/zizzy/bridgex/Logger;->getJsonObjFromStr(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 424
    .local v0, "o":Ljava/lang/Object;
    if-eqz v0, :cond_2

    .line 426
    :try_start_0
    instance-of v1, v0, Lorg/json/JSONObject;

    const/4 v2, 0x2

    if-eqz v1, :cond_0

    .line 427
    move-object v1, v0

    check-cast v1, Lorg/json/JSONObject;

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->toString(I)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 428
    :cond_0
    instance-of v1, v0, Lorg/json/JSONArray;

    if-eqz v1, :cond_1

    .line 429
    move-object v1, v0

    check-cast v1, Lorg/json/JSONArray;

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->toString(I)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 431
    :cond_1
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 433
    :catch_0
    move-exception v1

    .line 434
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 437
    .end local v1    # "e":Lorg/json/JSONException;
    :cond_2
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private getFormatLog(Ljava/lang/Object;)Ljava/lang/String;
    .locals 2
    .param p1, "o"    # Ljava/lang/Object;

    .line 419
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

    .line 461
    const/4 v0, 0x0

    .line 463
    .local v0, "o":Ljava/lang/Object;
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 472
    goto :goto_0

    .line 464
    :catch_0
    move-exception v1

    .line 466
    .local v1, "ex":Lorg/json/JSONException;
    :try_start_1
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x13

    if-lt v2, v3, :cond_0

    .line 467
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2, p1}, Lorg/json/JSONArray;-><init>(Ljava/lang/Object;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    move-object v0, v2

    .line 471
    :cond_0
    nop

    .line 473
    .end local v1    # "ex":Lorg/json/JSONException;
    :goto_0
    return-object v0

    .line 469
    .restart local v1    # "ex":Lorg/json/JSONException;
    :catch_1
    move-exception v2

    .line 470
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

    .line 357
    .local p2, "stackList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v0, :cond_0

    .line 358
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "diffBuilder="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 361
    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 362
    const/4 v0, 0x0

    return v0

    .line 365
    :cond_1
    const/4 v0, 0x0

    .line 367
    .local v0, "stackLen":I
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "1"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 368
    invoke-virtual {p1, v1}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v1

    .line 369
    .local v1, "lastIndex":I
    iget-boolean v2, p0, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v2, :cond_2

    .line 370
    iget-object v2, p0, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "lastIndex="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 372
    :cond_2
    add-int/lit8 v0, v1, 0x1

    .line 375
    .end local v1    # "lastIndex":I
    :cond_3
    iget-boolean v1, p0, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v1, :cond_4

    .line 376
    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "stackLen="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 379
    :cond_4
    return v0
.end method

.method private getSplitter(I)Ljava/lang/String;
    .locals 3
    .param p1, "length"    # I

    .line 442
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 443
    .local v0, "builder":Ljava/lang/StringBuilder;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, p1, :cond_0

    .line 444
    const-string v2, "-"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 443
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 446
    .end local v1    # "i":I
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static log()V
    .locals 2

    .line 109
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 113
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 114
    const/4 v0, 0x0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->log([Ljava/lang/Object;)V

    .line 115
    return-void

    .line 110
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static log(D)V
    .locals 2
    .param p0, "source"    # D

    .line 91
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 95
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 96
    invoke-static {p0, p1}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/Object;)V

    .line 97
    return-void

    .line 92
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static log(F)V
    .locals 2
    .param p0, "source"    # F

    .line 82
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 86
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 87
    invoke-static {p0}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/Object;)V

    .line 88
    return-void

    .line 83
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static log(I)V
    .locals 2
    .param p0, "source"    # I

    .line 64
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 68
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 69
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/Object;)V

    .line 70
    return-void

    .line 65
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static log(J)V
    .locals 2
    .param p0, "source"    # J

    .line 73
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 77
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 78
    invoke-static {p0, p1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/Object;)V

    .line 79
    return-void

    .line 74
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static log(Ljava/lang/Object;)V
    .locals 2
    .param p0, "source"    # Ljava/lang/Object;

    .line 118
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 122
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 123
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 124
    .local v0, "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 125
    invoke-interface {v0}, Ljava/util/List;->toArray()[Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lzhao/zizzy/bridgex/Logger;->log([Ljava/lang/Object;)V

    .line 126
    return-void

    .line 119
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

    .line 173
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

    .line 174
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

    .line 176
    .end local v0    # "tag":Ljava/lang/String;
    .restart local p1    # "tag":Ljava/lang/String;
    :cond_0
    iget-object v0, v1, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    move-object v3, v0

    .line 179
    .end local p1    # "tag":Ljava/lang/String;
    .local v3, "tag":Ljava/lang/String;
    :goto_0
    if-eqz v2, :cond_1

    .line 180
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1a

    if-lt v0, v4, :cond_1

    iget-boolean v0, v1, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v0, :cond_1

    .line 181
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

    .line 185
    :cond_1
    new-instance v0, Ljava/lang/Throwable;

    invoke-direct {v0}, Ljava/lang/Throwable;-><init>()V

    move-object v4, v0

    .line 186
    .local v4, "throwable":Ljava/lang/Throwable;
    iget-boolean v0, v1, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v0, :cond_2

    sget-boolean v0, Lzhao/zizzy/bridgex/Logger;->DEBUG:Z

    if-eqz v0, :cond_2

    .line 187
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

    .line 190
    :cond_2
    iget-object v0, v1, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v0

    iget v5, v1, Lzhao/zizzy/bridgex/Logger;->startIndex:I

    add-int/2addr v5, v0

    .line 191
    .local v5, "currentIndex":I
    iget-boolean v0, v1, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v0, :cond_3

    .line 192
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

    .line 193
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

    .line 200
    :cond_3
    const-string v6, " "

    .line 201
    .local v6, "space":Ljava/lang/String;
    const/4 v7, 0x0

    .line 203
    .local v7, "jsonFilePath":Ljava/lang/String;
    invoke-virtual {v4}, Ljava/lang/Throwable;->fillInStackTrace()Ljava/lang/Throwable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v8

    .line 204
    .local v8, "stacks":[Ljava/lang/StackTraceElement;
    iget v0, v1, Lzhao/zizzy/bridgex/Logger;->maxLogStackIndex:I

    add-int/2addr v0, v5

    const/4 v9, 0x1

    add-int/lit8 v10, v0, 0x1

    .line 205
    .local v10, "stackSize":I
    array-length v0, v8

    if-gt v10, v0, :cond_4

    move v0, v10

    goto :goto_1

    :cond_4
    array-length v0, v8

    :goto_1
    move v11, v0

    .line 206
    .local v11, "maxStackSize":I
    iget-boolean v0, v1, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v0, :cond_5

    .line 207
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

    .line 208
    iget-object v0, v1, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "maxStackSize: "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v0, v12}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 211
    :cond_5
    if-eqz v2, :cond_7

    .line 213
    const/4 v12, 0x0

    .line 215
    .local v12, "wr":Ljava/lang/ref/WeakReference;
    :try_start_0
    new-instance v0, Ljava/lang/ref/WeakReference;

    new-instance v13, Lorg/json/JSONObject;

    invoke-virtual/range {p3 .. p3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-direct {v13, v14}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v13}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v12, v0

    .line 221
    goto :goto_2

    .line 216
    :catchall_0
    move-exception v0

    move-object v13, v0

    .line 218
    .local v13, "th1":Ljava/lang/Throwable;
    :try_start_1
    new-instance v0, Ljava/lang/ref/WeakReference;

    new-instance v14, Lorg/json/JSONArray;

    invoke-virtual/range {p3 .. p3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-direct {v14, v15}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v14}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-object v12, v0

    .line 220
    goto :goto_2

    .line 219
    :catchall_1
    move-exception v0

    .line 223
    .end local v13    # "th1":Ljava/lang/Throwable;
    :goto_2
    if-eqz v12, :cond_7

    .line 224
    invoke-direct {v1, v2}, Lzhao/zizzy/bridgex/Logger;->formatJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 225
    .end local p3    # "source":Ljava/lang/Object;
    .local v0, "source":Ljava/lang/Object;
    iget-boolean v2, v1, Lzhao/zizzy/bridgex/Logger;->exportJson:Z

    if-eqz v2, :cond_6

    .line 226
    invoke-direct {v1, v0}, Lzhao/zizzy/bridgex/Logger;->exportJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    move-object v7, v2

    .line 228
    :cond_6
    invoke-direct {v1, v0}, Lzhao/zizzy/bridgex/Logger;->format(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_3

    .line 232
    .end local v0    # "source":Ljava/lang/Object;
    .end local v12    # "wr":Ljava/lang/ref/WeakReference;
    .restart local p3    # "source":Ljava/lang/Object;
    :cond_7
    move-object v0, v2

    .end local p3    # "source":Ljava/lang/Object;
    .restart local v0    # "source":Ljava/lang/Object;
    :goto_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 233
    .local v2, "stackBuilder":Ljava/lang/StringBuilder;
    const/4 v12, 0x1

    .line 234
    .local v12, "isFirstLine":Z
    new-instance v13, Ljava/util/ArrayList;

    invoke-direct {v13}, Ljava/util/ArrayList;-><init>()V

    .line 235
    .local v13, "stackList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const/4 v14, 0x0

    .line 237
    .local v14, "diffBuilder":Ljava/lang/StringBuilder;
    move v15, v5

    .local v15, "i":I
    :goto_4
    if-ge v15, v11, :cond_11

    .line 238
    aget-object v16, v8, v15

    .line 239
    .local v16, "element":Ljava/lang/StackTraceElement;
    invoke-virtual/range {v16 .. v16}, Ljava/lang/StackTraceElement;->getFileName()Ljava/lang/String;

    move-result-object v17

    .line 240
    .local v17, "fileName":Ljava/lang/String;
    invoke-virtual/range {v16 .. v16}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v9

    .line 241
    .local v9, "className":Ljava/lang/String;
    invoke-virtual/range {v16 .. v16}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object v18

    .line 242
    .local v18, "methodClass":Ljava/lang/String;
    invoke-virtual/range {v16 .. v16}, Ljava/lang/StackTraceElement;->getLineNumber()I

    move-result v19

    .line 244
    .local v19, "lineNumber":I
    invoke-static/range {v17 .. v17}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v20

    if-eqz v20, :cond_8

    .line 245
    const-string v17, "Unknown Source"

    .line 246
    const/16 v19, 0x0

    move/from16 v27, v19

    move-object/from16 v19, v4

    move/from16 v4, v27

    goto :goto_5

    .line 244
    :cond_8
    move/from16 v27, v19

    move-object/from16 v19, v4

    move/from16 v4, v27

    .line 249
    .local v4, "lineNumber":I
    .local v19, "throwable":Ljava/lang/Throwable;
    :goto_5
    move-object/from16 v20, v8

    .end local v8    # "stacks":[Ljava/lang/StackTraceElement;
    .local v20, "stacks":[Ljava/lang/StackTraceElement;
    const/4 v8, -0x2

    if-ne v4, v8, :cond_9

    .line 250
    const-string v17, "Native Method"

    .line 253
    :cond_9
    const/16 v22, 0x3

    const/16 v23, 0x2

    if-eqz v12, :cond_c

    .line 254
    const/4 v12, 0x0

    .line 256
    const/4 v8, -0x2

    if-eq v4, v8, :cond_a

    .line 257
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

    .line 258
    invoke-direct {v1, v0}, Lzhao/zizzy/bridgex/Logger;->getFormatLog(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v21

    move/from16 v25, v10

    const/4 v10, 0x4

    .end local v10    # "stackSize":I
    .local v25, "stackSize":I
    aput-object v21, v8, v10

    .line 257
    const-string v10, "--- [%s:%s] %s.%s %s"

    invoke-static {v10, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_6

    .line 260
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

    .line 261
    invoke-direct {v1, v0}, Lzhao/zizzy/bridgex/Logger;->getFormatLog(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v22

    .line 260
    const-string v10, "--- [%s] %s.%s %s"

    invoke-static {v10, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 264
    :goto_6
    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_b

    .line 265
    const-string v8, "\n++++++ : "

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 268
    :cond_b
    invoke-static {v3, v0}, Lzhao/zizzy/bridgex/LogBridge;->log(Ljava/lang/String;Ljava/lang/Object;)V

    move-object/from16 v26, v0

    const/4 v8, 0x1

    goto/16 :goto_9

    .line 269
    .end local v25    # "stackSize":I
    .restart local v10    # "stackSize":I
    :cond_c
    move/from16 v25, v10

    .end local v10    # "stackSize":I
    .restart local v25    # "stackSize":I
    iget-boolean v8, v1, Lzhao/zizzy/bridgex/Logger;->showAllStack:Z

    if-eqz v8, :cond_10

    if-le v15, v5, :cond_10

    .line 270
    iget-boolean v8, v1, Lzhao/zizzy/bridgex/Logger;->enableStackPackage:Z

    if-eqz v8, :cond_e

    .line 271
    iget-object v8, v1, Lzhao/zizzy/bridgex/Logger;->stackPackage:Ljava/lang/String;

    invoke-direct {v1, v9, v8}, Lzhao/zizzy/bridgex/Logger;->diff(Ljava/lang/String;Ljava/lang/String;)I

    move-result v8

    .line 272
    .local v8, "diffValue":I
    if-nez v14, :cond_d

    .line 273
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    move-object v14, v10

    .line 275
    :cond_d
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v26, v0

    .end local v0    # "source":Ljava/lang/Object;
    .local v26, "source":Ljava/lang/Object;
    const-string v0, ""

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v14, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_7

    .line 270
    .end local v8    # "diffValue":I
    .end local v26    # "source":Ljava/lang/Object;
    .restart local v0    # "source":Ljava/lang/Object;
    :cond_e
    move-object/from16 v26, v0

    .line 278
    .end local v0    # "source":Ljava/lang/Object;
    .restart local v26    # "source":Ljava/lang/Object;
    :goto_7
    const/4 v0, -0x2

    if-eq v4, v0, :cond_f

    .line 279
    const/4 v0, 0x5

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v8, 0x0

    aput-object v6, v0, v8

    const/4 v8, 0x1

    aput-object v17, v0, v8

    .line 280
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v0, v23

    aput-object v9, v0, v22

    const/4 v8, 0x4

    aput-object v18, v0, v8

    .line 279
    const-string v8, "%s|-- [%s:%s] %s.%s"

    invoke-static {v8, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v13, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 v8, 0x1

    goto :goto_8

    .line 282
    :cond_f
    const/4 v8, 0x4

    new-array v0, v8, [Ljava/lang/Object;

    const/4 v8, 0x0

    aput-object v6, v0, v8

    const/4 v8, 0x1

    aput-object v17, v0, v8

    aput-object v9, v0, v23

    aput-object v18, v0, v22

    const-string v10, "%s|-- [%s] %s.%s"

    invoke-static {v10, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v13, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 285
    :goto_8
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v10, "  "

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v6, v0

    .end local v6    # "space":Ljava/lang/String;
    .local v0, "space":Ljava/lang/String;
    goto :goto_9

    .line 269
    .end local v26    # "source":Ljava/lang/Object;
    .local v0, "source":Ljava/lang/Object;
    .restart local v6    # "space":Ljava/lang/String;
    :cond_10
    move-object/from16 v26, v0

    const/4 v8, 0x1

    .line 237
    .end local v0    # "source":Ljava/lang/Object;
    .end local v16    # "element":Ljava/lang/StackTraceElement;
    .restart local v26    # "source":Ljava/lang/Object;
    :goto_9
    add-int/lit8 v15, v15, 0x1

    move-object/from16 v4, v19

    move-object/from16 v8, v20

    move/from16 v10, v25

    move-object/from16 v0, v26

    const/4 v9, 0x1

    goto/16 :goto_4

    .end local v9    # "className":Ljava/lang/String;
    .end local v17    # "fileName":Ljava/lang/String;
    .end local v18    # "methodClass":Ljava/lang/String;
    .end local v19    # "throwable":Ljava/lang/Throwable;
    .end local v20    # "stacks":[Ljava/lang/StackTraceElement;
    .end local v25    # "stackSize":I
    .end local v26    # "source":Ljava/lang/Object;
    .restart local v0    # "source":Ljava/lang/Object;
    .local v4, "throwable":Ljava/lang/Throwable;
    .local v8, "stacks":[Ljava/lang/StackTraceElement;
    .restart local v10    # "stackSize":I
    :cond_11
    move-object/from16 v26, v0

    move-object/from16 v19, v4

    move-object/from16 v20, v8

    move/from16 v25, v10

    .line 289
    .end local v0    # "source":Ljava/lang/Object;
    .end local v4    # "throwable":Ljava/lang/Throwable;
    .end local v8    # "stacks":[Ljava/lang/StackTraceElement;
    .end local v10    # "stackSize":I
    .end local v15    # "i":I
    .restart local v19    # "throwable":Ljava/lang/Throwable;
    .restart local v20    # "stacks":[Ljava/lang/StackTraceElement;
    .restart local v25    # "stackSize":I
    .restart local v26    # "source":Ljava/lang/Object;
    iget-boolean v0, v1, Lzhao/zizzy/bridgex/Logger;->showAllStack:Z

    if-eqz v0, :cond_14

    .line 290
    invoke-interface {v13}, Ljava/util/List;->size()I

    move-result v0

    .line 292
    .local v0, "stackLen":I
    iget-boolean v4, v1, Lzhao/zizzy/bridgex/Logger;->enableStackPackage:Z

    if-eqz v4, :cond_13

    .line 293
    const/4 v4, 0x0

    .line 294
    .local v4, "diffSeq":Ljava/lang/String;
    if-eqz v14, :cond_12

    .line 295
    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 297
    :cond_12
    invoke-direct {v1, v4, v13}, Lzhao/zizzy/bridgex/Logger;->getRealStackLen(Ljava/lang/String;Ljava/util/List;)I

    move-result v0

    .line 300
    .end local v4    # "diffSeq":Ljava/lang/String;
    :cond_13
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_a
    if-ge v4, v0, :cond_14

    .line 301
    const-string v8, "\n"

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {v13, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 300
    add-int/lit8 v4, v4, 0x1

    goto :goto_a

    .line 305
    .end local v0    # "stackLen":I
    .end local v4    # "i":I
    :cond_14
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move/from16 v4, p2

    move-object/from16 v8, p4

    invoke-direct {v1, v4, v3, v0, v8}, Lzhao/zizzy/bridgex/Logger;->printlns(ILjava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v0

    .line 306
    .local v0, "len":I
    iget-boolean v9, v1, Lzhao/zizzy/bridgex/Logger;->debuggable:Z

    if-eqz v9, :cond_15

    .line 307
    iget-object v9, v1, Lzhao/zizzy/bridgex/Logger;->defaultTag:Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "printLength: "

    invoke-virtual {v10, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 310
    :cond_15
    iget-object v9, v1, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v10, 0x0

    invoke-virtual {v9, v10}, Ljava/util/concurrent/atomic/AtomicInteger;->getAndSet(I)I

    .line 311
    return-void
.end method

.method public static log(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 3
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "source"    # Ljava/lang/Object;

    .line 155
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 159
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 160
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    const/4 v1, 0x3

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, p1, v2}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/String;ILjava/lang/Object;Ljava/lang/Throwable;)V

    .line 161
    return-void

    .line 156
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static log(Z)V
    .locals 2
    .param p0, "source"    # Z

    .line 100
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_0

    .line 104
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 105
    invoke-static {p0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/Object;)V

    .line 106
    return-void

    .line 101
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "The Logger instance is null!"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static varargs log([Ljava/lang/Object;)V
    .locals 8
    .param p0, "args"    # [Ljava/lang/Object;

    .line 129
    sget-object v0, Lzhao/zizzy/bridgex/Logger;->instance:Lzhao/zizzy/bridgex/Logger;

    if-eqz v0, :cond_4

    .line 133
    iget-object v0, v0, Lzhao/zizzy/bridgex/Logger;->atomI:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    .line 135
    const/4 v0, 0x0

    if-eqz p0, :cond_3

    array-length v1, p0

    if-nez v1, :cond_0

    goto :goto_2

    .line 140
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 141
    .local v1, "builder":Ljava/lang/StringBuilder;
    const/4 v2, 0x1

    .line 142
    .local v2, "isFirst":Z
    array-length v3, p0

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_2

    aget-object v5, p0, v4

    .line 143
    .local v5, "arg":Ljava/lang/Object;
    if-eqz v2, :cond_1

    .line 144
    const/4 v2, 0x0

    .line 145
    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 147
    :cond_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, ", "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 142
    .end local v5    # "arg":Ljava/lang/Object;
    :goto_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 151
    :cond_2
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/String;Ljava/lang/Object;)V

    .line 152
    return-void

    .line 136
    .end local v1    # "builder":Ljava/lang/StringBuilder;
    .end local v2    # "isFirst":Z
    :cond_3
    :goto_2
    invoke-static {v0, v0}, Lzhao/zizzy/bridgex/Logger;->log(Ljava/lang/String;Ljava/lang/Object;)V

    .line 137
    return-void

    .line 130
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

    .line 477
    new-instance v0, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;

    invoke-direct {v0, p0, p1, p2}, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;-><init>(Lzhao/zizzy/bridgex/Logger;ILjava/lang/String;)V

    .line 482
    .local v0, "logWriter":Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;
    if-eqz p2, :cond_0

    .line 484
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    rsub-int v1, v1, 0xf9e

    add-int/lit8 v1, v1, -0x20

    .line 487
    .local v1, "bufferSize":I
    const/16 v2, 0x64

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 489
    new-instance v2, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;

    invoke-direct {v2, v0, v1}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;-><init>(Ljava/io/Writer;I)V

    .line 491
    .local v2, "lbbw":Lzhao/zizzy/bridgex/LineBreakBufferedWriter;
    invoke-virtual {v2, p3}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->println(Ljava/lang/String;)V

    .line 493
    if-eqz p4, :cond_4

    .line 496
    move-object v3, p4

    .line 497
    .local v3, "t":Ljava/lang/Throwable;
    :goto_1
    if-eqz v3, :cond_3

    .line 498
    instance-of v4, v3, Ljava/net/UnknownHostException;

    if-eqz v4, :cond_1

    .line 499
    goto :goto_2

    .line 501
    :cond_1
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x18

    if-lt v4, v5, :cond_2

    .line 502
    instance-of v4, v3, Landroid/os/DeadSystemException;

    if-eqz v4, :cond_2

    .line 503
    const-string v4, "DeadSystemException: The system died; earlier logs will point to the root cause"

    invoke-virtual {v2, v4}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->println(Ljava/lang/String;)V

    .line 505
    goto :goto_2

    .line 508
    :cond_2
    invoke-virtual {v3}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v3

    goto :goto_1

    .line 510
    :cond_3
    :goto_2
    if-nez v3, :cond_4

    .line 511
    invoke-virtual {p4, v2}, Ljava/lang/Throwable;->printStackTrace(Ljava/io/PrintWriter;)V

    .line 515
    .end local v3    # "t":Ljava/lang/Throwable;
    :cond_4
    invoke-virtual {v2}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->flush()V

    .line 517
    invoke-virtual {v0}, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;->getWritten()I

    move-result v3

    return v3
.end method
