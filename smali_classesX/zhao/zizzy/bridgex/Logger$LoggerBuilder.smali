.class Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
.super Ljava/lang/Object;
.source "Logger.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lzhao/zizzy/bridgex/Logger;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "LoggerBuilder"
.end annotation


# static fields
.field private static final EXT_DIR_NAME:Ljava/lang/String; = "bridgex"


# instance fields
.field private context:Landroid/content/Context;

.field private debuggable:Z

.field private enableStackPackage:Z

.field private exportJson:Z

.field private exportJsonDir:Ljava/io/File;

.field private externalDir:Ljava/io/File;

.field private maxLogStackIndex:I

.field private showAllStack:Z

.field private stackPackage:Ljava/lang/String;

.field private startIndex:I

.field private tag:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 536
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 537
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    .line 538
    const-class v0, Lzhao/zizzy/bridgex/Logger;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->tag:Ljava/lang/String;

    .line 539
    const/16 v0, 0x10

    iput v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->maxLogStackIndex:I

    .line 540
    return-void
.end method

.method static synthetic access$000(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 521
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->tag:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 521
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->debuggable:Z

    return v0
.end method

.method static synthetic access$200(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 521
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->showAllStack:Z

    return v0
.end method

.method static synthetic access$300(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)I
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 521
    iget v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->maxLogStackIndex:I

    return v0
.end method

.method static synthetic access$400(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 521
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->enableStackPackage:Z

    return v0
.end method

.method static synthetic access$500(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)I
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 521
    iget v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->startIndex:I

    return v0
.end method

.method static synthetic access$600(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 521
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->stackPackage:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$700(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 521
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJson:Z

    return v0
.end method

.method static synthetic access$800(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/io/File;
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 521
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJsonDir:Ljava/io/File;

    return-object v0
.end method


# virtual methods
.method build()Lzhao/zizzy/bridgex/Logger;
    .locals 1

    .line 629
    new-instance v0, Lzhao/zizzy/bridgex/Logger;

    invoke-direct {v0, p0}, Lzhao/zizzy/bridgex/Logger;-><init>(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)V

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->access$1002(Lzhao/zizzy/bridgex/Logger;)Lzhao/zizzy/bridgex/Logger;

    .line 630
    invoke-static {}, Lzhao/zizzy/bridgex/Logger;->access$1000()Lzhao/zizzy/bridgex/Logger;

    move-result-object v0

    return-object v0
.end method

.method debuggable(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "debuggable"    # Z

    .line 543
    iput-boolean p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->debuggable:Z

    .line 544
    return-object p0
.end method

.method defaultTag(Ljava/lang/String;)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "tag"    # Ljava/lang/String;

    .line 548
    iput-object p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->tag:Ljava/lang/String;

    .line 549
    return-object p0
.end method

.method enableStackPackage(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "enableStackPackage"    # Z

    .line 563
    iput-boolean p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->enableStackPackage:Z

    .line 564
    return-object p0
.end method

.method exportJson(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 4
    .param p1, "exportJson"    # Z

    .line 593
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->externalDir:Ljava/io/File;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 597
    :cond_0
    iput-boolean p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJson:Z

    .line 599
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->externalDir:Ljava/io/File;

    const-string v2, "json"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 600
    .local v0, "jsonDir":Ljava/io/File;
    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->access$900(Ljava/io/File;)Z

    .line 601
    new-instance v1, Ljava/io/File;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lzhao/zizzy/bridgex/Md5Util;->getMd5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJsonDir:Ljava/io/File;

    .line 602
    invoke-static {v1}, Lzhao/zizzy/bridgex/Logger;->access$900(Ljava/io/File;)Z

    .line 603
    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->tag:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "==========> export json folder path: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJsonDir:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 604
    return-object p0

    .line 594
    .end local v0    # "jsonDir":Ljava/io/File;
    :cond_1
    :goto_0
    return-object p0
.end method

.method externalDir(Ljava/lang/String;)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 1
    .param p1, "dir"    # Ljava/lang/String;

    .line 608
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 609
    const-string p1, "bridgex"

    .line 620
    :cond_0
    :try_start_0
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    invoke-virtual {v0, p1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->externalDir:Ljava/io/File;

    .line 621
    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->access$900(Ljava/io/File;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 624
    goto :goto_0

    .line 622
    :catchall_0
    move-exception v0

    .line 623
    .local v0, "th":Ljava/lang/Throwable;
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    .line 625
    .end local v0    # "th":Ljava/lang/Throwable;
    :goto_0
    return-object p0
.end method

.method maxLogStackIndex(I)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "maxLogStackIndex"    # I

    .line 558
    iput p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->maxLogStackIndex:I

    .line 559
    return-object p0
.end method

.method showAllStack(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "showAllStack"    # Z

    .line 553
    iput-boolean p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->showAllStack:Z

    .line 554
    return-object p0
.end method

.method stackPackage(Ljava/lang/String;)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 1
    .param p1, "stackPackage"    # Ljava/lang/String;

    .line 576
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 577
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    .line 579
    :cond_0
    iput-object p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->stackPackage:Ljava/lang/String;

    .line 580
    return-object p0
.end method

.method startIndex(I)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "index"    # I

    .line 568
    if-gez p1, :cond_0

    .line 569
    const/4 p1, 0x0

    .line 571
    :cond_0
    iput p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->startIndex:I

    .line 572
    return-object p0
.end method
