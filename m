Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F500C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 10:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiGKKgr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 06:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiGKKg1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 06:36:27 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287CDDC898
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 02:46:44 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id x125so1766598vsb.13
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLv23DdIWoIT+F0GlkICA37HjyDH+Azro/5MHVfYXAg=;
        b=Va2bjprWHX2ePduS8zHpZBcZKYufjnkOmKYYHJAyePKSdMImD4cvJ7YiZlz/iA+uiJ
         VkMr2WIlPctp05rzPkBM8rDZ7lLBZ8Cws9e8pcv0zUrjG1qbu3IJ+F2Qn9YINfugW8a5
         DgXqG518+z2QrhyEeaLFUtg7o5L/6hrSkJ4luLVS7970OtqAbZrh9UhxbNb19TEfZ+mr
         sbI4kWeCxIHhrLYKzfcsF+6noIACChBuUESDS3bIHdDihWrrmTWwGRckOrU9HybW0UtJ
         XFCulQjQfQjDOrUBWrnjZvd2xYyZ7k8z8slEWw8aNapL8qrYZZgMT71w2A+b1WjjZaLr
         LWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLv23DdIWoIT+F0GlkICA37HjyDH+Azro/5MHVfYXAg=;
        b=qhgOdUScYaT0ZJ5wbSUPQ7bUPaiGd5aJj2/+23vidd4ZPKldPLrRU03xEEOZqiu9By
         Mu/WYh5X2JoHfd8Dt/Z6w62Whudv7HMmKC2nWh3PaNHxu7Ww4A9cd652ldjQD4tO0aRK
         ZF+Gu0MBffeYOKRKoys7h+BYmq4ehvK0fR/kRtQHTqoujKduwXHccT7Kt7iBoJb/vGLx
         6sTxcs1L9AhIQSNW+XQDbdIScu+qQTSfwEw0bfYWovE3ok3zIJgsk5ci5P8Mi3cJ62fg
         fRxS/WnO01nnJQpf6NYEUnMhHsvF+qu+BGetzxrcgLurhuglw82u611gJ1DxfCiZjDTG
         APQg==
X-Gm-Message-State: AJIora9+vGzlA1IBDcOBE3R7uQW2Z6tnOa3bov1RXRKbHs3KzUP3bn1f
        GXad2LJnnzsJHAVSn0qg450vl19JdmtIWfgDGDi3qAkrH2cc7Q==
X-Google-Smtp-Source: AGRyM1uzr/iJ0twBv9isx6/B5WxT4Q0Tu15nzwvISnUXKYlY0Yw8l6f6udrxQPdOGR5HYs/WfoTiu0iOXK4rzF92RXI=
X-Received: by 2002:a05:6102:5d7:b0:357:4418:ab80 with SMTP id
 v23-20020a05610205d700b003574418ab80mr4544937vsf.82.1657532803928; Mon, 11
 Jul 2022 02:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220711094340.2829115-1-svens@linux.ibm.com>
In-Reply-To: <20220711094340.2829115-1-svens@linux.ibm.com>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Mon, 11 Jul 2022 12:46:28 +0300
Message-ID: <CAPpZLN7duFETcJWbtHx-OfzmafEFOOg63PhwEfVanp2x5Xi8-w@mail.gmail.com>
Subject: Re: [PATCH v2] trace-cmd: fix writing of uncompressed size
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jul 11, 2022 at 12:43 PM Sven Schnelle <svens@linux.ibm.com> wrote:
>
> pointer in struct tracecmd_compression is 'unsigned long', which is 8 byte
> in size on most platforms, but the tep_read_number() call in the next line
> treats it as a 4 byte value. As there's no need for unsigned long change
> the type to unsigned int.
>
> Fixes: 3f8447b1 ("trace-cmd library: Add support for compression algorithms")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Acked-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>

Thanks!

> ---
>  lib/trace-cmd/trace-compress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/trace-cmd/trace-compress.c b/lib/trace-cmd/trace-compress.c
> index a63295e..461de8d 100644
> --- a/lib/trace-cmd/trace-compress.c
> +++ b/lib/trace-cmd/trace-compress.c
> @@ -32,7 +32,7 @@ struct tracecmd_compression {
>         int                             fd;
>         unsigned int                    capacity;
>         unsigned int                    capacity_read;
> -       unsigned long                   pointer;
> +       unsigned int                    pointer;
>         char                            *buffer;
>         struct compress_proto           *proto;
>         struct tep_handle               *tep;
> --
> 2.36.1
>


-- 
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
