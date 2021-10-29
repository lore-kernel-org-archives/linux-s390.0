Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63CAC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 04:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A9760E90
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 04:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhJ2Eb2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 29 Oct 2021 00:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhJ2Eb1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 Oct 2021 00:31:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F82C061570
        for <linux-s390@vger.kernel.org>; Thu, 28 Oct 2021 21:29:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so2832866pjc.4
        for <linux-s390@vger.kernel.org>; Thu, 28 Oct 2021 21:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=1lw9CL6foQSlTHkgeMHIdtLwuJ0uzL85uTSVuDRoqTU=;
        b=4A88KEGK5lrhNn28n8g4+fu6NXvRjD7W437RHy4cNqHn8iB80kxqThDBcjcrk5mRX/
         008A/H33D1cXAKxcegdnF3iedtK1/oC1r7FiF+kcsPkJOAcWyR+Zcdc2Avl2gGKFosNG
         lsoSAMHBroL2nKxHSuBDagm1nnhVID4undXpkHmsZekfg8OpYvz0t+WAIleBKGMefwiK
         oju4ZEdFAKWUPOQVmF+PcPrPONkvDsXLB4HNf5NakjaCcx0seDz7ECG3gOJj82UBZg7s
         YTfopF00P20zEf7K2zyDDto7ZMzGLFTaYZ5JFPRdRim5fSVjIlToesUxbojcFRZES5oX
         ETlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=1lw9CL6foQSlTHkgeMHIdtLwuJ0uzL85uTSVuDRoqTU=;
        b=fEuhtNo+LX7nLI8o1rVtB4vwZrWzqNpS+t5mZvDeSBVtbR6uFTrllWSsqV/BMQ1zU5
         4JKOYkYXs7UFTQyKvj0EqFrlyQVH2v0viPBd64zVLaGW04/bm2eY9h26vQBnKVqyUvmM
         eYJXdeFbkfvwpLj+ZPoTVkQ0OFyJm0eLIMsQ4gwZPmDnvlzpm7gGHAG2yFu+hxJNSU0r
         hbA1nTzQzYSjECXimNWQWPnUcyD2pktxnJx8UwTvtfc3Ezb0NYB9H/9+pj1v48sPer3e
         lriYtEK1US57/0gbjEX9EAF+sAA1x3ArKZ8fyhfLam7g4d/ZP3qkrG0VHgTlX2eVS2Kl
         6xqw==
X-Gm-Message-State: AOAM531lFx1egyJmEB9wLCkWnqXTkTOhlD1JGnaf5TUBBk7V9hv2dE1f
        UUsc/uvXVFskH/tjHdfOoMxw1Q==
X-Google-Smtp-Source: ABdhPJw8xG0v7xWQxIJa0aMj2CwuoZQd+hB6fK4AAtAvMU+VrzOpOVXpYcs484b4w1MuP4fR36HJ0w==
X-Received: by 2002:a17:902:d2cf:b0:141:b347:df9d with SMTP id n15-20020a170902d2cf00b00141b347df9dmr291173plc.37.1635481738594;
        Thu, 28 Oct 2021 21:28:58 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d11sm5308221pfl.173.2021.10.28.21.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 21:28:58 -0700 (PDT)
Date:   Thu, 28 Oct 2021 21:28:58 -0700 (PDT)
X-Google-Original-Date: Thu, 28 Oct 2021 21:28:55 PDT (-0700)
Subject:     Re: [PATCH v1 1/1] delay.h: fix for removed kernel.h
In-Reply-To: <20211028182303.GA711390@roeck-us.net>
CC:     andriy.shevchenko@linux.intel.com, gor@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com, akpm@linux-foundation.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     linux@roeck-us.net
Message-ID: <mhng-dd929e9e-e3e3-4d04-a6a6-2c005f8c24df@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 28 Oct 2021 11:23:03 PDT (-0700), linux@roeck-us.net wrote:
> On Thu, Oct 28, 2021 at 08:01:43PM +0300, Andy Shevchenko wrote:
>> To be folded to the commit 0d280a9fbbd9 ("include/linux/delay.h:
>> replace kernel.h with the necessary inclusions")

I can't find that in any of my trees, so I'm assuming this is targeted 
at something else.

Acked-by: Palmer Dabbelt <palmer@dabbelt.com>

Thanks!

>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
>> ---
>>  arch/riscv/lib/delay.c           | 4 ++++
>>  arch/s390/include/asm/facility.h | 4 ++++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/riscv/lib/delay.c b/arch/riscv/lib/delay.c
>> index f51c9a03bca1..49d510ba75fd 100644
>> --- a/arch/riscv/lib/delay.c
>> +++ b/arch/riscv/lib/delay.c
>> @@ -4,10 +4,14 @@
>>   */
>>
>>  #include <linux/delay.h>
>> +#include <linux/math.h>
>>  #include <linux/param.h>
>>  #include <linux/timex.h>
>> +#include <linux/types.h>
>>  #include <linux/export.h>
>>
>> +#include <asm/processor.h>
>> +
>>  /*
>>   * This is copies from arch/arm/include/asm/delay.h
>>   *
>> diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
>> index e3aa354ab9f4..94b6919026df 100644
>> --- a/arch/s390/include/asm/facility.h
>> +++ b/arch/s390/include/asm/facility.h
>> @@ -9,8 +9,12 @@
>>  #define __ASM_FACILITY_H
>>
>>  #include <asm/facility-defs.h>
>> +
>> +#include <linux/minmax.h>
>>  #include <linux/string.h>
>> +#include <linux/types.h>
>>  #include <linux/preempt.h>
>> +
>>  #include <asm/lowcore.h>
>>
>>  #define MAX_FACILITY_BIT (sizeof(stfle_fac_list) * 8)
>> --
>> 2.33.0
>>
