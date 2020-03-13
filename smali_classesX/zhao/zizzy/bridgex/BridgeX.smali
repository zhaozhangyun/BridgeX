.class public Lzhao/zizzy/bridgex/BridgeX;
.super Ljava/lang/Object;
.source "BridgeX.java"


# static fields
.field private static DEBUGGABLE:Z

.field private static DEFAULT_TAG:Ljava/lang/String;

.field private static EXTERNAL_DIR:Ljava/io/File;

.field private static lock:Ljava/lang/Object;

.field private static logger:Lzhao/zizzy/bridgex/Logger;

.field private static sContext:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 20
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    sput-object v0, Lzhao/zizzy/bridgex/BridgeX;->lock:Ljava/lang/Object;

    .line 25
    const-class v0, Lzhao/zizzy/bridgex/BridgeX;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lzhao/zizzy/bridgex/BridgeX;->DEFAULT_TAG:Ljava/lang/String;

    .line 26
    const/4 v0, 0x1

    sput-boolean v0, Lzhao/zizzy/bridgex/BridgeX;->DEBUGGABLE:Z

    .line 27
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static ensureCreated(Ljava/io/File;)Z
    .locals 3
    .param p0, "folder"    # Ljava/io/File;

    .line 30
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->mkdirs()Z

    move-result v0

    if-nez v0, :cond_0

    .line 31
    sget-object v0, Lzhao/zizzy/bridgex/BridgeX;->DEFAULT_TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unable to create the directory: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 32
    const/4 v0, 0x0

    return v0

    .line 34
    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public static getExternalDatabaseName(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p0, "name"    # Ljava/lang/String;

    .line 87
    sget-object v0, Lzhao/zizzy/bridgex/BridgeX;->EXTERNAL_DIR:Ljava/io/File;

    invoke-static {v0}, Lzhao/zizzy/bridgex/BridgeX;->ensureCreated(Ljava/io/File;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 88
    sget-object v0, Lzhao/zizzy/bridgex/BridgeX;->sContext:Landroid/content/Context;

    invoke-virtual {v0, p0}, Landroid/content/Context;->getDatabasePath(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 91
    :cond_0
    new-instance v0, Ljava/io/File;

    sget-object v1, Lzhao/zizzy/bridgex/BridgeX;->EXTERNAL_DIR:Ljava/io/File;

    const-string v2, "db"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 92
    .local v0, "dbp":Ljava/io/File;
    invoke-static {v0}, Lzhao/zizzy/bridgex/BridgeX;->ensureCreated(Ljava/io/File;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 93
    sget-object v1, Lzhao/zizzy/bridgex/BridgeX;->sContext:Landroid/content/Context;

    invoke-virtual {v1, p0}, Landroid/content/Context;->getDatabasePath(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 95
    :cond_1
    sget-boolean v1, Lzhao/zizzy/bridgex/BridgeX;->DEBUGGABLE:Z

    if-eqz v1, :cond_2

    .line 96
    sget-object v1, Lzhao/zizzy/bridgex/BridgeX;->DEFAULT_TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dbp="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 99
    :cond_2
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0, p0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static init(Landroid/content/Context;)V
    .locals 8
    .param p0, "context"    # Landroid/content/Context;

    .line 39
    sput-object p0, Lzhao/zizzy/bridgex/BridgeX;->sContext:Landroid/content/Context;

    .line 40
    sget-object v0, Lzhao/zizzy/bridgex/BridgeX;->logger:Lzhao/zizzy/bridgex/Logger;

    if-nez v0, :cond_2

    .line 41
    sget-object v0, Lzhao/zizzy/bridgex/BridgeX;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 42
    :try_start_0
    sget-object v1, Lzhao/zizzy/bridgex/BridgeX;->logger:Lzhao/zizzy/bridgex/Logger;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    if-nez v1, :cond_1

    .line 43
    const/4 v1, 0x0

    .line 45
    .local v1, "is":Ljava/io/InputStream;
    :try_start_1
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    const-string v3, "bridgex_conf.json"

    invoke-virtual {v2, v3}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v2

    move-object v1, v2

    .line 46
    invoke-virtual {v1}, Ljava/io/InputStream;->available()I

    move-result v2

    .line 47
    .local v2, "size":I
    new-array v3, v2, [B

    .line 48
    .local v3, "buffer":[B
    invoke-virtual {v1, v3}, Ljava/io/InputStream;->read([B)I

    .line 49
    new-instance v4, Lorg/json/JSONObject;

    new-instance v5, Ljava/lang/String;

    invoke-direct {v5, v3}, Ljava/lang/String;-><init>([B)V

    invoke-direct {v4, v5}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 50
    .local v4, "json":Lorg/json/JSONObject;
    const-string v5, "debuggable"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v5

    sput-boolean v5, Lzhao/zizzy/bridgex/BridgeX;->DEBUGGABLE:Z

    .line 51
    new-instance v5, Ljava/io/File;

    const-string v6, "external_dir"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    sput-object v5, Lzhao/zizzy/bridgex/BridgeX;->EXTERNAL_DIR:Ljava/io/File;

    .line 52
    new-instance v5, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    invoke-direct {v5, p0}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;-><init>(Landroid/content/Context;)V

    const-string v6, "logger"

    .line 53
    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v6

    const-string v7, "default_tag"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->defaultTag(Ljava/lang/String;)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    move-result-object v5

    sget-boolean v6, Lzhao/zizzy/bridgex/BridgeX;->DEBUGGABLE:Z

    .line 54
    invoke-virtual {v5, v6}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->debuggable(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    move-result-object v5

    sget-object v6, Lzhao/zizzy/bridgex/BridgeX;->EXTERNAL_DIR:Ljava/io/File;

    .line 55
    invoke-virtual {v6}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->externalDir(Ljava/lang/String;)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    move-result-object v5

    const-string v6, "logger"

    .line 56
    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v6

    const-string v7, "show_all_stack"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v6

    invoke-virtual {v5, v6}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->showAllStack(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    move-result-object v5

    const-string v6, "logger"

    .line 57
    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v6

    const-string v7, "max_stack_index"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v5, v6}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->maxLogStackIndex(I)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    move-result-object v5

    const-string v6, "logger"

    .line 58
    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v6

    const-string v7, "stack_package"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v6

    const-string v7, "enable"

    .line 59
    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v6

    .line 58
    invoke-virtual {v5, v6}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->enableStackPackage(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    move-result-object v5

    const-string v6, "logger"

    .line 60
    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v6

    const-string v7, "stack_package"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v6

    const-string v7, "package"

    .line 61
    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 60
    invoke-virtual {v5, v6}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->stackPackage(Ljava/lang/String;)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    move-result-object v5

    const-string v6, "logger"

    .line 62
    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v6

    const-string v7, "export_json"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v6

    invoke-virtual {v5, v6}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJson(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    move-result-object v5

    .line 63
    invoke-virtual {v5}, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->build()Lzhao/zizzy/bridgex/Logger;

    move-result-object v5

    sput-object v5, Lzhao/zizzy/bridgex/BridgeX;->logger:Lzhao/zizzy/bridgex/Logger;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 67
    .end local v2    # "size":I
    .end local v3    # "buffer":[B
    .end local v4    # "json":Lorg/json/JSONObject;
    if-eqz v1, :cond_1

    .line 69
    :try_start_2
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_0

    .line 64
    :catchall_0
    move-exception v2

    .line 65
    .local v2, "th":Ljava/lang/Throwable;
    :try_start_3
    sget-object v3, Lzhao/zizzy/bridgex/BridgeX;->DEFAULT_TAG:Ljava/lang/String;

    const-string v4, "parse bridgex_conf.json error"

    invoke-static {v3, v4, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 67
    nop

    .end local v2    # "th":Ljava/lang/Throwable;
    if-eqz v1, :cond_1

    .line 69
    :try_start_4
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 71
    :goto_0
    goto :goto_2

    .line 70
    :catch_0
    move-exception v2

    goto :goto_0

    .line 67
    :catchall_1
    move-exception v2

    if-eqz v1, :cond_0

    .line 69
    :try_start_5
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 71
    goto :goto_1

    .line 70
    :catch_1
    move-exception v3

    .line 71
    :cond_0
    :goto_1
    nop

    .end local p0    # "context":Landroid/content/Context;
    :try_start_6
    throw v2

    .line 75
    .end local v1    # "is":Ljava/io/InputStream;
    .restart local p0    # "context":Landroid/content/Context;
    :cond_1
    :goto_2
    monitor-exit v0

    goto :goto_3

    :catchall_2
    move-exception v1

    monitor-exit v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    throw v1

    .line 77
    :cond_2
    :goto_3
    return-void
.end method

.method public static writeToFile(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 7
    .param p0, "fileName"    # Ljava/lang/String;
    .param p1, "content"    # Ljava/lang/Object;

    .line 110
    const-string v0, "."

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    .line 111
    const-string v1, "\\."

    invoke-virtual {p0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 112
    .local v1, "splited":[Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v3, 0x0

    aget-object v3, v1, v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "_"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v0, 0x1

    aget-object v0, v1, v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 115
    .end local v1    # "splited":[Ljava/lang/String;
    :cond_0
    new-instance v0, Ljava/io/File;

    sget-object v1, Lzhao/zizzy/bridgex/BridgeX;->EXTERNAL_DIR:Ljava/io/File;

    const-string v2, "file"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 116
    .local v0, "fileDir":Ljava/io/File;
    invoke-static {v0}, Lzhao/zizzy/bridgex/BridgeX;->ensureCreated(Ljava/io/File;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 117
    return-void

    .line 120
    :cond_1
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0, p0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    .line 121
    .local v1, "fp":Ljava/lang/String;
    sget-boolean v2, Lzhao/zizzy/bridgex/BridgeX;->DEBUGGABLE:Z

    if-eqz v2, :cond_2

    .line 122
    sget-object v2, Lzhao/zizzy/bridgex/BridgeX;->DEFAULT_TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "fp="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 125
    :cond_2
    const/4 v2, 0x0

    .line 127
    .local v2, "out":Ljava/io/BufferedWriter;
    :try_start_0
    new-instance v3, Ljava/io/BufferedWriter;

    new-instance v4, Ljava/io/OutputStreamWriter;

    new-instance v5, Ljava/io/FileOutputStream;

    invoke-direct {v5, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V

    const-string v6, "UTF-8"

    invoke-direct {v4, v5, v6}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    move-object v2, v3

    .line 128
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 131
    nop

    .line 133
    :try_start_1
    invoke-virtual {v2}, Ljava/io/BufferedWriter;->close()V

    .line 135
    :goto_0
    goto :goto_1

    .line 134
    :catch_0
    move-exception v3

    goto :goto_0

    .line 129
    :catchall_0
    move-exception v3

    .line 131
    if-eqz v2, :cond_3

    .line 133
    invoke-virtual {v2}, Ljava/io/BufferedWriter;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 138
    :cond_3
    :goto_1
    return-void
.end method
