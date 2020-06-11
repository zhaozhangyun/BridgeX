.class Lzhao/zizzy/bridgex/LineBreakBufferedWriter;
.super Ljava/io/PrintWriter;
.source "LineBreakBufferedWriter.java"


# instance fields
.field private buffer:[C

.field private bufferIndex:I

.field private final bufferSize:I

.field private lastNewline:I

.field private final lineSeparator:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/io/Writer;I)V
    .locals 1
    .param p1, "out"    # Ljava/io/Writer;
    .param p2, "bufferSize"    # I

    .line 49
    const/16 v0, 0x10

    invoke-direct {p0, p1, p2, v0}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;-><init>(Ljava/io/Writer;II)V

    .line 50
    return-void
.end method

.method constructor <init>(Ljava/io/Writer;II)V
    .locals 1
    .param p1, "out"    # Ljava/io/Writer;
    .param p2, "bufferSize"    # I
    .param p3, "initialCapacity"    # I

    .line 61
    invoke-direct {p0, p1}, Ljava/io/PrintWriter;-><init>(Ljava/io/Writer;)V

    .line 39
    const/4 v0, -0x1

    iput v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lastNewline:I

    .line 62
    invoke-static {p3, p2}, Ljava/lang/Math;->min(II)I

    move-result v0

    new-array v0, v0, [C

    iput-object v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->buffer:[C

    .line 63
    const/4 v0, 0x0

    iput v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    .line 64
    iput p2, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferSize:I

    .line 65
    const-string v0, "line.separator"

    invoke-static {v0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lineSeparator:Ljava/lang/String;

    .line 66
    return-void
.end method

.method private appendToBuffer(Ljava/lang/String;II)V
    .locals 3
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "off"    # I
    .param p3, "len"    # I

    .line 231
    iget v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    add-int v1, v0, p3

    iget-object v2, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->buffer:[C

    array-length v2, v2

    if-le v1, v2, :cond_0

    .line 232
    add-int/2addr v0, p3

    invoke-direct {p0, v0}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->ensureCapacity(I)V

    .line 234
    :cond_0
    add-int v0, p2, p3

    iget-object v1, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->buffer:[C

    iget v2, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    invoke-virtual {p1, p2, v0, v1, v2}, Ljava/lang/String;->getChars(II[CI)V

    .line 235
    iget v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    add-int/2addr v0, p3

    iput v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    .line 236
    return-void
.end method

.method private appendToBuffer([CII)V
    .locals 3
    .param p1, "buf"    # [C
    .param p2, "off"    # I
    .param p3, "len"    # I

    .line 215
    iget v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    add-int v1, v0, p3

    iget-object v2, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->buffer:[C

    array-length v2, v2

    if-le v1, v2, :cond_0

    .line 216
    add-int/2addr v0, p3

    invoke-direct {p0, v0}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->ensureCapacity(I)V

    .line 218
    :cond_0
    iget-object v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->buffer:[C

    iget v1, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    invoke-static {p1, p2, v0, v1, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 219
    iget v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    add-int/2addr v0, p3

    iput v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    .line 220
    return-void
.end method

.method private ensureCapacity(I)V
    .locals 2
    .param p1, "capacity"    # I

    .line 246
    iget-object v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->buffer:[C

    array-length v0, v0

    mul-int/lit8 v0, v0, 0x2

    add-int/lit8 v0, v0, 0x2

    .line 247
    .local v0, "newSize":I
    if-ge v0, p1, :cond_0

    .line 248
    move v0, p1

    .line 250
    :cond_0
    iget-object v1, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->buffer:[C

    invoke-static {v1, v0}, Ljava/util/Arrays;->copyOf([CI)[C

    move-result-object v1

    iput-object v1, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->buffer:[C

    .line 251
    return-void
.end method

.method private removeFromBuffer(I)V
    .locals 4
    .param p1, "i"    # I

    .line 260
    iget v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    sub-int v1, v0, p1

    .line 261
    .local v1, "rest":I
    const/4 v2, 0x0

    if-lez v1, :cond_0

    .line 262
    iget-object v3, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->buffer:[C

    sub-int/2addr v0, v1

    invoke-static {v3, v0, v3, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 263
    iput v1, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    goto :goto_0

    .line 265
    :cond_0
    iput v2, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    .line 267
    :goto_0
    return-void
.end method

.method private writeBuffer(I)V
    .locals 2
    .param p1, "length"    # I

    .line 275
    if-lez p1, :cond_0

    .line 276
    iget-object v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->buffer:[C

    const/4 v1, 0x0

    invoke-super {p0, v0, v1, p1}, Ljava/io/PrintWriter;->write([CII)V

    .line 278
    :cond_0
    return-void
.end method


# virtual methods
.method public flush()V
    .locals 1

    .line 73
    iget v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    invoke-direct {p0, v0}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->writeBuffer(I)V

    .line 74
    const/4 v0, 0x0

    iput v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    .line 75
    invoke-super {p0}, Ljava/io/PrintWriter;->flush()V

    .line 76
    return-void
.end method

.method public println()V
    .locals 1

    .line 95
    iget-object v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lineSeparator:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->write(Ljava/lang/String;)V

    .line 96
    return-void
.end method

.method public write(I)V
    .locals 4
    .param p1, "c"    # I

    .line 80
    iget v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    iget-object v1, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->buffer:[C

    array-length v2, v1

    const/4 v3, 0x1

    if-ge v0, v2, :cond_0

    .line 81
    int-to-char v2, p1

    aput-char v2, v1, v0

    .line 82
    add-int/2addr v0, v3

    iput v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    .line 83
    int-to-char v1, p1

    const/16 v2, 0xa

    if-ne v1, v2, :cond_1

    .line 84
    iput v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lastNewline:I

    goto :goto_0

    .line 89
    :cond_0
    new-array v0, v3, [C

    int-to-char v1, p1

    const/4 v2, 0x0

    aput-char v1, v0, v2

    invoke-virtual {p0, v0, v2, v3}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->write([CII)V

    .line 91
    :cond_1
    :goto_0
    return-void
.end method

.method public write(Ljava/lang/String;II)V
    .locals 6
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "off"    # I
    .param p3, "len"    # I

    .line 154
    :goto_0
    iget v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    add-int v1, v0, p3

    iget v2, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferSize:I

    const/16 v3, 0xa

    if-le v1, v2, :cond_4

    .line 157
    const/4 v1, -0x1

    .line 158
    .local v1, "nextNewLine":I
    sub-int/2addr v2, v0

    .line 159
    .local v2, "maxLength":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    if-ge v0, v2, :cond_1

    .line 160
    add-int v4, p2, v0

    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    if-ne v4, v3, :cond_0

    .line 161
    iget v4, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    add-int/2addr v4, v0

    iget v5, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferSize:I

    if-ge v4, v5, :cond_1

    .line 162
    move v1, v0

    .line 159
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 169
    .end local v0    # "i":I
    :cond_1
    const/4 v0, 0x0

    const/4 v3, -0x1

    if-eq v1, v3, :cond_2

    .line 171
    invoke-direct {p0, p1, p2, v1}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->appendToBuffer(Ljava/lang/String;II)V

    .line 172
    iget v4, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    invoke-direct {p0, v4}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->writeBuffer(I)V

    .line 173
    iput v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    .line 174
    iput v3, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lastNewline:I

    .line 175
    add-int/lit8 v0, v1, 0x1

    add-int/2addr p2, v0

    .line 176
    add-int/lit8 v0, v1, 0x1

    sub-int/2addr p3, v0

    goto :goto_2

    .line 177
    :cond_2
    iget v4, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lastNewline:I

    if-eq v4, v3, :cond_3

    .line 179
    invoke-direct {p0, v4}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->writeBuffer(I)V

    .line 180
    iget v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lastNewline:I

    add-int/lit8 v0, v0, 0x1

    invoke-direct {p0, v0}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->removeFromBuffer(I)V

    .line 181
    iput v3, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lastNewline:I

    goto :goto_2

    .line 184
    :cond_3
    iget v3, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferSize:I

    iget v4, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    sub-int/2addr v3, v4

    .line 185
    .local v3, "rest":I
    invoke-direct {p0, p1, p2, v3}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->appendToBuffer(Ljava/lang/String;II)V

    .line 186
    iget v4, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    invoke-direct {p0, v4}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->writeBuffer(I)V

    .line 187
    iput v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    .line 188
    add-int/2addr p2, v3

    .line 189
    sub-int/2addr p3, v3

    .line 191
    .end local v1    # "nextNewLine":I
    .end local v2    # "maxLength":I
    .end local v3    # "rest":I
    :goto_2
    goto :goto_0

    .line 194
    :cond_4
    if-lez p3, :cond_6

    .line 196
    invoke-direct {p0, p1, p2, p3}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->appendToBuffer(Ljava/lang/String;II)V

    .line 197
    add-int/lit8 v0, p3, -0x1

    .restart local v0    # "i":I
    :goto_3
    if-ltz v0, :cond_6

    .line 198
    add-int v1, p2, v0

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    if-ne v1, v3, :cond_5

    .line 199
    iget v1, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    sub-int/2addr v1, p3

    add-int/2addr v1, v0

    iput v1, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lastNewline:I

    .line 200
    goto :goto_4

    .line 197
    :cond_5
    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 204
    .end local v0    # "i":I
    :cond_6
    :goto_4
    return-void
.end method

.method public write([CII)V
    .locals 6
    .param p1, "buf"    # [C
    .param p2, "off"    # I
    .param p3, "len"    # I

    .line 100
    :goto_0
    iget v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    add-int v1, v0, p3

    iget v2, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferSize:I

    const/16 v3, 0xa

    if-le v1, v2, :cond_4

    .line 103
    const/4 v1, -0x1

    .line 104
    .local v1, "nextNewLine":I
    sub-int/2addr v2, v0

    .line 105
    .local v2, "maxLength":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    if-ge v0, v2, :cond_1

    .line 106
    add-int v4, p2, v0

    aget-char v4, p1, v4

    if-ne v4, v3, :cond_0

    .line 107
    iget v4, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    add-int/2addr v4, v0

    iget v5, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferSize:I

    if-ge v4, v5, :cond_1

    .line 108
    move v1, v0

    .line 105
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 115
    .end local v0    # "i":I
    :cond_1
    const/4 v0, 0x0

    const/4 v3, -0x1

    if-eq v1, v3, :cond_2

    .line 117
    invoke-direct {p0, p1, p2, v1}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->appendToBuffer([CII)V

    .line 118
    iget v4, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    invoke-direct {p0, v4}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->writeBuffer(I)V

    .line 119
    iput v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    .line 120
    iput v3, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lastNewline:I

    .line 121
    add-int/lit8 v0, v1, 0x1

    add-int/2addr p2, v0

    .line 122
    add-int/lit8 v0, v1, 0x1

    sub-int/2addr p3, v0

    goto :goto_2

    .line 123
    :cond_2
    iget v4, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lastNewline:I

    if-eq v4, v3, :cond_3

    .line 125
    invoke-direct {p0, v4}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->writeBuffer(I)V

    .line 126
    iget v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lastNewline:I

    add-int/lit8 v0, v0, 0x1

    invoke-direct {p0, v0}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->removeFromBuffer(I)V

    .line 127
    iput v3, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lastNewline:I

    goto :goto_2

    .line 130
    :cond_3
    iget v3, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferSize:I

    iget v4, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    sub-int/2addr v3, v4

    .line 131
    .local v3, "rest":I
    invoke-direct {p0, p1, p2, v3}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->appendToBuffer([CII)V

    .line 132
    iget v4, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    invoke-direct {p0, v4}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->writeBuffer(I)V

    .line 133
    iput v0, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    .line 134
    add-int/2addr p2, v3

    .line 135
    sub-int/2addr p3, v3

    .line 137
    .end local v1    # "nextNewLine":I
    .end local v2    # "maxLength":I
    .end local v3    # "rest":I
    :goto_2
    goto :goto_0

    .line 140
    :cond_4
    if-lez p3, :cond_6

    .line 142
    invoke-direct {p0, p1, p2, p3}, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->appendToBuffer([CII)V

    .line 143
    add-int/lit8 v0, p3, -0x1

    .restart local v0    # "i":I
    :goto_3
    if-ltz v0, :cond_6

    .line 144
    add-int v1, p2, v0

    aget-char v1, p1, v1

    if-ne v1, v3, :cond_5

    .line 145
    iget v1, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->bufferIndex:I

    sub-int/2addr v1, p3

    add-int/2addr v1, v0

    iput v1, p0, Lzhao/zizzy/bridgex/LineBreakBufferedWriter;->lastNewline:I

    .line 146
    goto :goto_4

    .line 143
    :cond_5
    add-int/lit8 v0, v0, -0x1

    goto :goto_3

    .line 150
    .end local v0    # "i":I
    :cond_6
    :goto_4
    return-void
.end method
