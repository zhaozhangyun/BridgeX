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

.field private tag:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 532
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 533
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    .line 534
    const-class v0, Lzhao/zizzy/bridgex/Logger;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->tag:Ljava/lang/String;

    .line 535
    const/16 v0, 0x10

    iput v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->maxLogStackIndex:I

    .line 536
    return-void
.end method

.method static synthetic access$000(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 518
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$100(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 518
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->tag:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$200(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 518
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->debuggable:Z

    return v0
.end method

.method static synthetic access$300(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 518
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->showAllStack:Z

    return v0
.end method

.method static synthetic access$400(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)I
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 518
    iget v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->maxLogStackIndex:I

    return v0
.end method

.method static synthetic access$500(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 518
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->enableStackPackage:Z

    return v0
.end method

.method static synthetic access$600(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 518
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->stackPackage:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$700(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Z
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 518
    iget-boolean v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJson:Z

    return v0
.end method

.method static synthetic access$800(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)Ljava/io/File;
    .locals 1
    .param p0, "x0"    # Lzhao/zizzy/bridgex/Logger$LoggerBuilder;

    .line 518
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJsonDir:Ljava/io/File;

    return-object v0
.end method


# virtual methods
.method build()Lzhao/zizzy/bridgex/Logger;
    .locals 1

    .line 596
    new-instance v0, Lzhao/zizzy/bridgex/Logger;

    invoke-direct {v0, p0}, Lzhao/zizzy/bridgex/Logger;-><init>(Lzhao/zizzy/bridgex/Logger$LoggerBuilder;)V

    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->access$1002(Lzhao/zizzy/bridgex/Logger;)Lzhao/zizzy/bridgex/Logger;

    .line 597
    invoke-static {}, Lzhao/zizzy/bridgex/Logger;->access$1000()Lzhao/zizzy/bridgex/Logger;

    move-result-object v0

    return-object v0
.end method

.method debuggable(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "debuggable"    # Z

    .line 539
    iput-boolean p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->debuggable:Z

    .line 540
    return-object p0
.end method

.method defaultTag(Ljava/lang/String;)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "tag"    # Ljava/lang/String;

    .line 544
    iput-object p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->tag:Ljava/lang/String;

    .line 545
    return-object p0
.end method

.method enableStackPackage(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "enableStackPackage"    # Z

    .line 559
    iput-boolean p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->enableStackPackage:Z

    .line 560
    return-object p0
.end method

.method exportJson(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 4
    .param p1, "exportJson"    # Z

    .line 572
    iput-boolean p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJson:Z

    .line 574
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->externalDir:Ljava/io/File;

    if-eqz v0, :cond_0

    .line 578
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->externalDir:Ljava/io/File;

    const-string v2, "json"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 579
    .local v0, "jsonDir":Ljava/io/File;
    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->access$900(Ljava/io/File;)Z

    .line 580
    new-instance v1, Ljava/io/File;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lzhao/zizzy/bridgex/Md5Util;->getMd5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->exportJsonDir:Ljava/io/File;

    .line 581
    invoke-static {v1}, Lzhao/zizzy/bridgex/Logger;->access$900(Ljava/io/File;)Z

    .line 582
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

    .line 583
    return-object p0

    .line 575
    .end local v0    # "jsonDir":Ljava/io/File;
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "You must call externalDir method first!"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method externalDir(Ljava/lang/String;)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 1
    .param p1, "dir"    # Ljava/lang/String;

    .line 587
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 588
    const-string p1, "bridgex"

    .line 590
    :cond_0
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    invoke-virtual {v0, p1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->externalDir:Ljava/io/File;

    .line 591
    invoke-static {v0}, Lzhao/zizzy/bridgex/Logger;->access$900(Ljava/io/File;)Z

    .line 592
    return-object p0
.end method

.method maxLogStackIndex(I)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "maxLogStackIndex"    # I

    .line 554
    iput p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->maxLogStackIndex:I

    .line 555
    return-object p0
.end method

.method showAllStack(Z)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 0
    .param p1, "showAllStack"    # Z

    .line 549
    iput-boolean p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->showAllStack:Z

    .line 550
    return-object p0
.end method

.method stackPackage(Ljava/lang/String;)Lzhao/zizzy/bridgex/Logger$LoggerBuilder;
    .locals 1
    .param p1, "stackPackage"    # Ljava/lang/String;

    .line 564
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 565
    iget-object v0, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    .line 567
    :cond_0
    iput-object p1, p0, Lzhao/zizzy/bridgex/Logger$LoggerBuilder;->stackPackage:Ljava/lang/String;

    .line 568
    return-object p0
.end method
