.class Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;
.super Ljava/io/Writer;
.source "Logger.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lzhao/zizzy/bridgex/Logger;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "ImmediateLogWriter"
.end annotation


# instance fields
.field private priority:I

.field private tag:Ljava/lang/String;

.field final synthetic this$0:Lzhao/zizzy/bridgex/Logger;

.field private written:I


# direct methods
.method public constructor <init>(Lzhao/zizzy/bridgex/Logger;ILjava/lang/String;)V
    .locals 1
    .param p1, "this$0"    # Lzhao/zizzy/bridgex/Logger;
    .param p2, "priority"    # I
    .param p3, "tag"    # Ljava/lang/String;

    .line 649
    iput-object p1, p0, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;->this$0:Lzhao/zizzy/bridgex/Logger;

    invoke-direct {p0}, Ljava/io/Writer;-><init>()V

    .line 643
    const/4 v0, 0x0

    iput v0, p0, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;->written:I

    .line 650
    iput p2, p0, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;->priority:I

    .line 651
    iput-object p3, p0, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;->tag:Ljava/lang/String;

    .line 652
    return-void
.end method


# virtual methods
.method public close()V
    .locals 0

    .line 674
    return-void
.end method

.method public flush()V
    .locals 0

    .line 669
    return-void
.end method

.method public getWritten()I
    .locals 1

    .line 655
    iget v0, p0, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;->written:I

    return v0
.end method

.method public write([CII)V
    .locals 4
    .param p1, "cbuf"    # [C
    .param p2, "off"    # I
    .param p3, "len"    # I

    .line 663
    iget v0, p0, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;->written:I

    iget v1, p0, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;->priority:I

    iget-object v2, p0, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;->tag:Ljava/lang/String;

    new-instance v3, Ljava/lang/String;

    invoke-direct {v3, p1, p2, p3}, Ljava/lang/String;-><init>([CII)V

    invoke-static {v1, v2, v3}, Landroid/util/Log;->println(ILjava/lang/String;Ljava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    iput v0, p0, Lzhao/zizzy/bridgex/Logger$ImmediateLogWriter;->written:I

    .line 664
    return-void
.end method
