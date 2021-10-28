Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C75C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 28 Oct 2021 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196F3610D2
	for <linux-s390@archiver.kernel.org>; Thu, 28 Oct 2021 18:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ1SZd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhJ1SZd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 28 Oct 2021 14:25:33 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A98C061570;
        Thu, 28 Oct 2021 11:23:05 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t4so9520675oie.5;
        Thu, 28 Oct 2021 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=huVvxmimD4yAH/A6Y9OLvaPoqMhARnPLJLBzkidypAY=;
        b=EpQ4Cgk/KRPsVZSO8XT8ym1bp9HATFUscqocrjA4GZjp4lO33ltGHl2qqr+IY6gN0N
         ROpNZ6dA/QQJStbTYEiiFsBbxTZZwCPftutLo7N9mIUY3DgpZvZRQ/yNxW4HGfJMYOFN
         QRJ4r78iauQY6KYGUB9ye/KMJTuxu8GfJKN0QXX6Z+wybNYVv3ysrLzPl4InXvB6MC0a
         QjD3UuLNVNYoPSvfVmy+2hyxTJdH5nvludTwp+qnqvFb3FwvfCft6WfsvrEKbJjeE1pA
         3F6YprS4hiWJv0sC5Z2myndgGNLYxuKSzTJaU7WltN4Tp9EPzqLq0BtGgDgM5PYeGyV/
         Zfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=huVvxmimD4yAH/A6Y9OLvaPoqMhARnPLJLBzkidypAY=;
        b=u40Gy8AyYtuBcNkKq1VhvPBDwAs7aNZWFPhOjlTWY5tx75i7LYbzoW2DK+qdW5CZKV
         8vrO+BpO+4Wdg4H86rOfCBzHF8YnZGDaDbPOLrbt0eL5bKJQU2Z2dc1oeFh8ZadnH8WR
         IX6iDvDyLGe62rPxDuij6g36emnXjmOH2/6p7T433eFE+OEsIsAm0GEkXnf5trAPILKO
         oljyv3N6BugDg6d0lXu6ASXOYx/SkwTlL+poKrUXt5I/n2m3mKKX8E8PYmHkOEol6eOh
         2Ef7fnjL5juvlAoTkcdrDqA7mZ8I9WZ4W0/Damb2HSXEdW2oSyTWQA20+JeBaq5ts6B9
         U6wg==
X-Gm-Message-State: AOAM533skFjiKOlxRKyObolvtiKncVbKHbM9FTVaRcJ561Gz+4VAEFNx
        qjtXN54ncKsb2IVuoDDCovk=
X-Google-Smtp-Source: ABdhPJwkEkQDrdteZwRxlQLVHCdQqVNVv5YrcVd2q+VPWjeAB6rK9MlQsRU0SlhPiNEJB2b1u4qTUw==
X-Received: by 2002:a54:4f1d:: with SMTP id e29mr9931945oiy.179.1635445385247;
        Thu, 28 Oct 2021 11:23:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 8sm1273422oix.29.2021.10.28.11.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:23:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Oct 2021 11:23:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] delay.h: fix for removed kernel.h
Message-ID: <20211028182303.GA711390@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 28, 2021 at 08:01:43PM +0300, Andy Shevchenko wrote:
> To be folded to the commit 0d280a9fbbd9 ("include/linux/delay.h:
> replace kernel.h with the necessary inclusions")
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/riscv/lib/delay.c           | 4 ++++
>  arch/s390/include/asm/facility.h | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/lib/delay.c b/arch/riscv/lib/delay.c
> index f51c9a03bca1..49d510ba75fd 100644
> --- a/arch/riscv/lib/delay.c
> +++ b/arch/riscv/lib/delay.c
> @@ -4,10 +4,14 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/math.h>
>  #include <linux/param.h>
>  #include <linux/timex.h>
> +#include <linux/types.h>
>  #include <linux/export.h>
>  
> +#include <asm/processor.h>
> +
>  /*
>   * This is copies from arch/arm/include/asm/delay.h
>   *
> diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
> index e3aa354ab9f4..94b6919026df 100644
> --- a/arch/s390/include/asm/facility.h
> +++ b/arch/s390/include/asm/facility.h
> @@ -9,8 +9,12 @@
>  #define __ASM_FACILITY_H
>  
>  #include <asm/facility-defs.h>
> +
> +#include <linux/minmax.h>
>  #include <linux/string.h>
> +#include <linux/types.h>
>  #include <linux/preempt.h>
> +
>  #include <asm/lowcore.h>
>  
>  #define MAX_FACILITY_BIT (sizeof(stfle_fac_list) * 8)
> -- 
> 2.33.0
> 
