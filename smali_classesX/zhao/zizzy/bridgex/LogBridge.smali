.class public Lzhao/zizzy/bridgex/LogBridge;
.super Ljava/lang/Object;
.source "LogBridge.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lzhao/zizzy/bridgex/LogBridge$ILogger;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String;

.field private static instance:Lzhao/zizzy/bridgex/LogBridge;


# instance fields
.field private logger:Lzhao/zizzy/bridgex/LogBridge$ILogger;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 7
    const-class v0, Lzhao/zizzy/bridgex/LogBridge;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lzhao/zizzy/bridgex/LogBridge;->TAG:Ljava/lang/String;

    .line 8
    new-instance v0, Lzhao/zizzy/bridgex/LogBridge;

    invoke-direct {v0}, Lzhao/zizzy/bridgex/LogBridge;-><init>()V

    sput-object v0, Lzhao/zizzy/bridgex/LogBridge;->instance:Lzhao/zizzy/bridgex/LogBridge;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    return-void
.end method

.method public static inject(Lzhao/zizzy/bridgex/LogBridge$ILogger;)V
    .locals 1
    .param p0, "logger"    # Lzhao/zizzy/bridgex/LogBridge$ILogger;

    .line 15
    sget-object v0, Lzhao/zizzy/bridgex/LogBridge;->instance:Lzhao/zizzy/bridgex/LogBridge;

    iput-object p0, v0, Lzhao/zizzy/bridgex/LogBridge;->logger:Lzhao/zizzy/bridgex/LogBridge$ILogger;

    .line 16
    return-void
.end method

.method public static log(Ljava/lang/Object;)V
    .locals 3
    .param p0, "source"    # Ljava/lang/Object;

    .line 19
    sget-object v0, Lzhao/zizzy/bridgex/LogBridge;->instance:Lzhao/zizzy/bridgex/LogBridge;

    iget-object v0, v0, Lzhao/zizzy/bridgex/LogBridge;->logger:Lzhao/zizzy/bridgex/LogBridge$ILogger;

    if-nez v0, :cond_0

    .line 20
    sget-object v0, Lzhao/zizzy/bridgex/LogBridge;->TAG:Ljava/lang/String;

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 21
    return-void

    .line 23
    :cond_0
    invoke-interface {v0, p0}, Lzhao/zizzy/bridgex/LogBridge$ILogger;->log(Ljava/lang/Object;)V

    .line 24
    return-void
.end method

.method public static log(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "source"    # Ljava/lang/Object;

    .line 45
    sget-object v0, Lzhao/zizzy/bridgex/LogBridge;->instance:Lzhao/zizzy/bridgex/LogBridge;

    iget-object v0, v0, Lzhao/zizzy/bridgex/LogBridge;->logger:Lzhao/zizzy/bridgex/LogBridge$ILogger;

    if-nez v0, :cond_0

    .line 46
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 47
    return-void

    .line 49
    :cond_0
    invoke-interface {v0, p0, p1}, Lzhao/zizzy/bridgex/LogBridge$ILogger;->log(Ljava/lang/String;Ljava/lang/Object;)V

    .line 50
    return-void
.end method

.method public static varargs log([Ljava/lang/Object;)V
    .locals 7
    .param p0, "args"    # [Ljava/lang/Object;

    .line 27
    sget-object v0, Lzhao/zizzy/bridgex/LogBridge;->instance:Lzhao/zizzy/bridgex/LogBridge;

    iget-object v0, v0, Lzhao/zizzy/bridgex/LogBridge;->logger:Lzhao/zizzy/bridgex/LogBridge$ILogger;

    if-nez v0, :cond_2

    .line 28
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 29
    .local v0, "builder":Ljava/lang/StringBuilder;
    const/4 v1, 0x1

    .line 30
    .local v1, "isFirst":Z
    array-length v2, p0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_1

    aget-object v4, p0, v3

    .line 31
    .local v4, "arg":Ljava/lang/Object;
    if-eqz v1, :cond_0

    .line 32
    const/4 v1, 0x0

    .line 33
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 35
    :cond_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, ", "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 30
    .end local v4    # "arg":Ljava/lang/Object;
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 38
    :cond_1
    sget-object v2, Lzhao/zizzy/bridgex/LogBridge;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 39
    return-void

    .line 41
    .end local v0    # "builder":Ljava/lang/StringBuilder;
    .end local v1    # "isFirst":Z
    :cond_2
    invoke-interface {v0, p0}, Lzhao/zizzy/bridgex/LogBridge$ILogger;->log([Ljava/lang/Object;)V

    .line 42
    return-void
.end method
