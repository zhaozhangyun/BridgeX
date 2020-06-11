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

    .line 540
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 541
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    .line 542
    const-class v0, Lzhao/zizzy/bridgex/Logger;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->tag:Ljava/lang/String;

    .line 543
    const/16 v0, 0x10

    iput v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->maxLogStackIndex:I

    .line 544
    return-void
.end method

.method static synthetic access$000(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 525
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->tag:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 525
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->debuggable:Z

    return v0
.end method

.method static synthetic access$200(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 525
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->showAllStack:Z

    return v0
.end method

.method static synthetic access$300(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)I
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 525
    iget v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->maxLogStackIndex:I

    return v0
.end method

.method static synthetic access$400(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 525
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->enableStackPackage:Z

    return v0
.end method

.method static synthetic access$500(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)I
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 525
    iget v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->startIndex:I

    return v0
.end method

.method static synthetic access$600(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 525
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->stackPackage:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$700(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 525
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJson:Z

    return v0
.end method

.method static synthetic access$800(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/io/File;
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 525
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

    .line 547
    iput-boolean p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->debuggable:Z

    .line 548
    return-object p0
.end method

.method defaultTag(Ljava/lang/String;)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "tag"    # Ljava/lang/String;

    .line 552
    iput-object p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->tag:Ljava/lang/String;

    .line 553
    return-object p0
.end method

.method enableStackPackage(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "enableStackPackage"    # Z

    .line 567
    iput-boolean p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->enableStackPackage:Z

    .line 568
    return-object p0
.end method

.method exportJson(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 6
    .param p1, "exportJson"    # Z

    .line 588
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "android.permission.WRITE_EXTERNAL_STORAGE"

    invoke-static {v0, v1}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    .line 590
    .local v0, "permission1":I
    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "android.permission.READ_EXTERNAL_STORAGE"

    invoke-static {v1, v2}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    .line 592
    .local v1, "permission2":I
    if-nez v0, :cond_2

    if-eqz v1, :cond_0

    goto :goto_0

    .line 597
    :cond_0
    iget-object v2, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->externalDir:Ljava/io/File;

    if-nez v2, :cond_1

    .line 598
    return-object p0

    .line 601
    :cond_1
    iput-boolean p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJson:Z

    .line 603
    new-instance v2, Ljava/io/File;

    iget-object v3, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->externalDir:Ljava/io/File;

    const-string v4, "json"

    invoke-direct {v2, v3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 604
    .local v2, "jsonDir":Ljava/io/File;
    invoke-static {v2}, Lzhao/zizzy/bridgex/Logger;->access$900(Ljava/io/File;)Z

    .line 605
    new-instance v3, Ljava/io/File;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lzhao/zizzy/bridgex/Md5Util;->getMd5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v2, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v3, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJsonDir:Ljava/io/File;

    .line 606
    invoke-static {v3}, Lzhao/zizzy/bridgex/Logger;->access$900(Ljava/io/File;)Z

    .line 607
    iget-object v3, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->tag:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "==========> export json folder path: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJsonDir:Ljava/io/File;

    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 608
    return-object p0

    .line 594
    .end local v2    # "jsonDir":Ljava/io/File;
    :cond_2
    :goto_0
    return-object p0
.end method

.method externalDir(Ljava/lang/String;)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 3
    .param p1, "dir"    # Ljava/lang/String;

    .line 612
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 613
    const-string p1, "bridgex"

    .line 615
    :cond_0
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "android.permission.WRITE_EXTERNAL_STORAGE"

    invoke-static {v0, v1}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    .line 617
    .local v0, "permission1":I
    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "android.permission.READ_EXTERNAL_STORAGE"

    invoke-static {v1, v2}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    .line 619
    .local v1, "permission2":I
    if-nez v0, :cond_2

    if-eqz v1, :cond_1

    goto :goto_0

    .line 623
    :cond_1
    iget-object v2, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    invoke-virtual {v2, p1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    iput-object v2, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->externalDir:Ljava/io/File;

    .line 624
    invoke-static {v2}, Lzhao/zizzy/bridgex/Logger;->access$900(Ljava/io/File;)Z

    .line 625
    return-object p0

    .line 621
    :cond_2
    :goto_0
    return-object p0
.end method

.method maxLogStackIndex(I)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "maxLogStackIndex"    # I

    .line 562
    iput p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->maxLogStackIndex:I

    .line 563
    return-object p0
.end method

.method showAllStack(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "showAllStack"    # Z

    .line 557
    iput-boolean p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->showAllStack:Z

    .line 558
    return-object p0
.end method

.method stackPackage(Ljava/lang/String;)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 1
    .param p1, "stackPackage"    # Ljava/lang/String;

    .line 580
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 581
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    .line 583
    :cond_0
    iput-object p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->stackPackage:Ljava/lang/String;

    .line 584
    return-object p0
.end method

.method startIndex(I)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "index"    # I

    .line 572
    if-gez p1, :cond_0

    .line 573
    const/4 p1, 0x0

    .line 575
    :cond_0
    iput p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->startIndex:I

    .line 576
    return-object p0
.end method
