Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C074C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 08:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiGKIzy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiGKIzv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 04:55:51 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E845D12D06
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 01:55:50 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id s1so827996vsr.12
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3H9pNIrlcDhLUs5of4b9Q3v2+gl2sD51zO6qj0FPGA=;
        b=auLPpKKW27goTa0NxuOkjCiy+Iedm5gmRdbiF6m/XovXUL1jcHUbZcvD9wxunq/Vx5
         fnEOllnQf1s+0eSaBr4KOO5WCixbowOv1AjW4W4DORfavhlujWpWEWcsA9u7kDxErj/C
         AXUF4SClCRTLblX2TniHFhxLTNzTQrVIlINdO4pdJpL9VIo7A4HwUfq5QZ7WZ7KwiQOq
         5sSGOsOMea31xcT2OMTQypNg1bErhig1mwDIdYdPmsg2RVM02CyFXA4luPlZmGFnqj2s
         79t9teBq2KFRFzoloDda5BT7kzSSpM2LMj4B02WkjTlnahqrJtHh+/QFA2ky+NckMePY
         XWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3H9pNIrlcDhLUs5of4b9Q3v2+gl2sD51zO6qj0FPGA=;
        b=4nuy9C5K4SF9yFp0Wy2LJf5/GzAfgh4k8lsLS/8r2vd7UfqLDU/NxuJnPUBetrNnjP
         kHN+/zSE9XpXQ3O8n0mLOGXTFB+yck1FwgmV88HOdjAoik+NlkBEC3e9jfVKjjWJjxQQ
         Cky4ScZMumdlcPGnFH/XQsU9EpnGTg5YHLS/g/Ov+R0oDr0NO8e1j7i4JrrY4WO8rYrG
         as5CUMlcX5NqV69cAhy5XG2IXG1pciPsSUcZQD6b+vYpHpTlQbtNDvddtontxcEmnV94
         bDdCfGEvLKFCKvn9rG98+QPDIG7NPANHAfZqsKkz4xsxWZ2t7OythyVZlxrT43F+yigo
         C+tQ==
X-Gm-Message-State: AJIora/yr6mMlJVrrbL2vCRbGHxe7knCFmBLeAVGy2oWhjjakQL1pcVE
        LPqniwFILyhw2n/cAGxdeJ5TCqs2Da3vuuPKhEZ1x/wX+RAdxw==
X-Google-Smtp-Source: AGRyM1uud7eh0t5dfh4EocPA6/Ic6BIAclCiO5E5FwfWmipAKwO1UxbxNWsEg0epq4/sUVrkoYAV4K/uLFnJUKDL+4o=
X-Received: by 2002:a05:6102:5d7:b0:357:4418:ab80 with SMTP id
 v23-20020a05610205d700b003574418ab80mr4492681vsf.82.1657529749986; Mon, 11
 Jul 2022 01:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220711074418.858843-1-svens@linux.ibm.com>
In-Reply-To: <20220711074418.858843-1-svens@linux.ibm.com>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Mon, 11 Jul 2022 11:55:34 +0300
Message-ID: <CAPpZLN45rz5nTn-XixV_pozdxHQREZymP_Vp8PDQAPXRDwguXA@mail.gmail.com>
Subject: Re: [PATCH] trace-cmd: fix writing of uncompressed size
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jul 11, 2022 at 10:44 AM Sven Schnelle <svens@linux.ibm.com> wrote:
>
> Pass &size instead of &handle->pointer. Interestingly this doesn't hurt
> on x86, but makes trace-cmd fail on s390.

Hi Sven,
Thanks for testing this code on s390, I've tested it only on x86.
Please, can you give more information about the trace-cmd failure on
s390?

>
> Fixes: 3f8447b1 ("trace-cmd library: Add support for compression algorithms")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  lib/trace-cmd/trace-compress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/trace-cmd/trace-compress.c b/lib/trace-cmd/trace-compress.c
> index a63295e..ad9b7fc 100644
> --- a/lib/trace-cmd/trace-compress.c
> +++ b/lib/trace-cmd/trace-compress.c
> @@ -331,7 +331,7 @@ int tracecmd_compress_block(struct tracecmd_compression *handle)
>                 goto out;
>
>         /* Write uncompressed data size */
> -       endian4 = tep_read_number(handle->tep, &handle->pointer, 4);
> +       endian4 = tep_read_number(handle->tep, &size, 4);

Here 'size' is the size of the buffer, used by the compression
algorithm to compress the data block. That size depends on the
algorithm, but usually it is less than the uncompressed data size and
bigger than the compressed data size. On this position in the file
must be written the size of the uncompressed data, that is
'handle->pointer'. I agree that the name is a bit misleading, as this
is not a pointer to a memory address.  The 'handle->pointer' is the
offset within the compression buffer, where the next uncompressed data
will be written. The logic uses a dynamic buffer with given capacity.
When the buffer is empty, 'handle->pointer' is 0. With each
uncompressed data chunk, written into that buffer, 'handle->pointer'
increases with its size - i.e. the first byte is written on position 0
(the initial 'handle->pointer') and the pointer increases to 1. That's
why it reflects the size of the uncompressed data. When the pointer
reaches the capacity of the buffer, the buffer is extended. At the
end, that buffer is passed to the compression algorithm, to compress
the block.

>         ret = do_write(handle, &endian4, 4);
>         if (ret != 4) {
>                 ret = -1;
> --
> 2.36.1
>


-- 
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
