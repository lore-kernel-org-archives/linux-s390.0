Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2098CC48BE5
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 07:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE66F6044F
	for <linux-s390@archiver.kernel.org>; Wed, 16 Jun 2021 07:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhFPHhm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Jun 2021 03:37:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57743 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhFPHhl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Jun 2021 03:37:41 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <dimitri.ledkov@canonical.com>)
        id 1ltQ5H-0006NI-Ck
        for linux-s390@vger.kernel.org; Wed, 16 Jun 2021 07:35:35 +0000
Received: by mail-il1-f198.google.com with SMTP id b4-20020a920b040000b02901dc81bf7e72so1119977ilf.7
        for <linux-s390@vger.kernel.org>; Wed, 16 Jun 2021 00:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCv5taiiINLmRcYNh2cZYkv+GwtyeEEw74jPnQvzmFU=;
        b=r02lBuxHW4hl6Ag1cdm+fBrwkQ/tgXg5RvopbMAdHxrSbCQfiBHig71Utxg3DkhkoH
         dTJz69yPEvGMHj40QuiGwQjzHtODmzk5IsRyqmY3LcS9DA13G5fYiRGmZ7M00/QJljXl
         Ygca7vBp7ZPL8+S+CqTP/lECh6OdB3eAoWmCN31Iotx206Cd3xC1nUH5FexQ2SQFAiED
         qj421LTPmr5LL3eo2FZii0YB4ybE3hR3/U4Kola5ZXcvEhDeJUsc9T7BBYLIReC1IMT/
         2ET47w4sHJQ/lHEa0YbaxBn6tT2RR9mp9OyqZW3AfOCvYnlfkt7ul4sh/eM23jFaM34h
         TkQA==
X-Gm-Message-State: AOAM532zg4DHvf+JVm5tEKiQUtMTjHrCwliTsk1zcgzYEQzr3EdREV5N
        hStCIdAiBidF1TOS+N4vW1IaaU5k5R24bkbq4w+I2HTSyOQf1C31UULv949FdI3FGmdPV2bvBLt
        q+DT7xjydF6FsJ2B4IUWN9CSQ/OSfw59n/KJvsRYr8qV6k6Kahrk2Ym0=
X-Received: by 2002:a92:c56d:: with SMTP id b13mr2674029ilj.267.1623828934478;
        Wed, 16 Jun 2021 00:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB1U7wvq70SAIs/4TJahvYTzi6Pv8ottxiN303trgIWIeqOrOrGUa+AYp4lGxZ63sSiaLyusOLQ9YEYVWoDJ4=
X-Received: by 2002:a92:c56d:: with SMTP id b13mr2674013ilj.267.1623828934257;
 Wed, 16 Jun 2021 00:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210615114150.325080-1-dimitri.ledkov@canonical.com> <your-ad-here.call-01623799196-ext-1245@work.hours>
In-Reply-To: <your-ad-here.call-01623799196-ext-1245@work.hours>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Wed, 16 Jun 2021 08:34:58 +0100
Message-ID: <CADWks+bB2YsATLMaPvhtu6MoFsveKYd5cY6GxepeX7OZvto-Ew@mail.gmail.com>
Subject: Re: [PATCH] s390/boot: add zstd support
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 16, 2021 at 12:20 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> On Tue, Jun 15, 2021 at 12:41:50PM +0100, Dimitri John Ledkov wrote:
> > Enable ztsd support in s390/boot, to enable booting with zstd
> > compressed kernel when configured with CONFIG_KERNEL_ZSTD=y.
> >
> > BugLink: https://bugs.launchpad.net/bugs/1931725
> > Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> > cc: Heiko Carstens <hca@linux.ibm.com>
> > cc: Vasily Gorbik <gor@linux.ibm.com>
> > cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > cc: linux-s390@vger.kernel.org
> > ---
> >  arch/s390/Kconfig                        | 1 +
> >  arch/s390/boot/compressed/Makefile       | 4 ++++
> >  arch/s390/boot/compressed/decompressor.c | 4 ++++
> >  3 files changed, 9 insertions(+)
>
> Reviewing your patch I noticed that we use wrong condition to
> define BOOT_HEAP_SIZE. So I made a tiny fix:
>
> diff --git a/arch/s390/boot/compressed/decompressor.c b/arch/s390/boot/compressed/decompressor.c
> index 3061b11c4d27..cf2571050c68 100644
> --- a/arch/s390/boot/compressed/decompressor.c
> +++ b/arch/s390/boot/compressed/decompressor.c
> @@ -29,5 +29,5 @@ extern unsigned char _compressed_start[];
>  extern unsigned char _compressed_end[];
>
> -#ifdef CONFIG_HAVE_KERNEL_BZIP2
> +#ifdef CONFIG_KERNEL_BZIP2
>  #define BOOT_HEAP_SIZE 0x400000
>  #else
>

Nice. I guess it means all kernels were always built with large
HEAP_SIZE, and that's why my boot tests worked too.

Note this bug is also present in arch/sh/boot/compressed/misc.c.


> And applied your patch with the following changes:
> Added to the commit message:
> """
> BOOT_HEAP_SIZE is defined to 0x30000 in this case. Actual decompressor
> memory usage with allyesconfig is currently 0x26150.
> """
>

That's appropriate.

> diff --git a/arch/s390/boot/compressed/decompressor.c b/arch/s390/boot/compressed/decompressor.c
> index cf2571050c68..37a4a8d33c6c 100644
> --- a/arch/s390/boot/compressed/decompressor.c
> +++ b/arch/s390/boot/compressed/decompressor.c
> @@ -31,4 +31,6 @@ extern unsigned char _compressed_end[];
>  #ifdef CONFIG_KERNEL_BZIP2
>  #define BOOT_HEAP_SIZE 0x400000
> +#elif CONFIG_KERNEL_ZSTD
> +#define BOOT_HEAP_SIZE 0x30000
>  #else
>  #define BOOT_HEAP_SIZE 0x10000
>
> I hope you are ok with that, thanks!

Thank you!

-- 
Regards,

Dimitri.
