Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A550C0015E
	for <linux-s390@archiver.kernel.org>; Tue,  1 Aug 2023 14:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjHAONQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 1 Aug 2023 10:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjHAOMh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Aug 2023 10:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52581B2
        for <linux-s390@vger.kernel.org>; Tue,  1 Aug 2023 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690899104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xldrEMWNHvIrgi5gRwah0haAG0ZLn+vKqaEMzPRqPCg=;
        b=A7XPACRUaSnqCy9n52g1TwVR/26vYLx/wq00NfvAP8kx8H7ZRizBH42b4Ryf1uvRSOi1Ql
        ZpToUOZ+0YvbgXEN2cLRwwJIqEn1THWhU5zdeYVVa41eJOy6WnBJgGKYJi3NKT5z/8wBw8
        iqK1FWYCbMo2VxF6baAWPnkXctFJezM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-gL9dqlNBNZ2lFOpmSr0ZtQ-1; Tue, 01 Aug 2023 10:11:42 -0400
X-MC-Unique: gL9dqlNBNZ2lFOpmSr0ZtQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5227fb36095so4425436a12.3
        for <linux-s390@vger.kernel.org>; Tue, 01 Aug 2023 07:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899101; x=1691503901;
        h=organization:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xldrEMWNHvIrgi5gRwah0haAG0ZLn+vKqaEMzPRqPCg=;
        b=Gk0czh9aftnlJwtqHn+Lch0+pH5HQFn/O8vyLiOKmJgYBi/Zad2kuKjUbdT1dW6Rx1
         5XELQgO4RCJuQ8uKEnkwzJ67E4d931O5sDo4TYSwsQczsIg/s6IRyKqaaYkWeNGoy6Do
         LcWIm4mb2B3LXDziSWFEolQQRzCxYCMnCXZP8vm6b90xZv6AUPXeyzv8aqTM9Zybo2Mx
         aFn2e20YcJcHuZEmgzv0S2ZZEDpAjS3S92n9OV4omyDnLThBQhiVGm9AAL2O0HLjyZ0u
         sfGMNoj46VlFsAfffmFmftBBC3umhTSZ+ORWAb6elMEQ3j9w7J2I+mHn+gNuMW8Pp0MY
         3uUg==
X-Gm-Message-State: ABy/qLbwawypg+aCvCBlnqpYqqEATXkUToIBSpKvJgbL4jByBgVMdjJJ
        nKi/TBAUDuysxeaoJNbiAVNw8WCEYy7rTi9UbAeHM1TYmMpS1z3FmUtnaDnz+/knidZdB/1c/UP
        UlBIhk86vDaconxDFTcG/4A==
X-Received: by 2002:a05:6402:7c5:b0:522:57f3:fb40 with SMTP id u5-20020a05640207c500b0052257f3fb40mr2510453edy.18.1690899101450;
        Tue, 01 Aug 2023 07:11:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJE0GEKw0woKe2dfLMZDLWq/AQyRX6IEQXg1EDQgMB47qD7HYPqpAUSJ3jBh1nIkj+0gsnOQ==
X-Received: by 2002:a05:6402:7c5:b0:522:57f3:fb40 with SMTP id u5-20020a05640207c500b0052257f3fb40mr2510440edy.18.1690899101061;
        Tue, 01 Aug 2023 07:11:41 -0700 (PDT)
Received: from dcbz.redhat.com (p200300fe2f0745fcc58fecdea3f8608e.dip0.t-ipconnect.de. [2003:fe:2f07:45fc:c58f:ecde:a3f8:608e])
        by smtp.gmail.com with ESMTPSA id c16-20020aa7df10000000b00522bd24790asm3843498edy.58.2023.08.01.07.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:11:40 -0700 (PDT)
Date:   Tue, 1 Aug 2023 16:11:39 +0200
From:   Adrian Reber <areber@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/ptrace: add missing linux/const.h include
Message-ID: <ZMkSm+CWmAJ9EOY5@dcbz.redhat.com>
References: <20230731183926.330932-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731183926.330932-1-hca@linux.ibm.com>
X-Operating-System: Linux (6.3.8-200.fc38.x86_64)
X-Load-Average: 0.92 1.32 1.49
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
Organization: Red Hat
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jul 31, 2023 at 08:39:26PM +0200, Heiko Carstens wrote:
> Adrian Reber reported the following CRIU build bug after
> commit b8af5999779d ("s390/ptrace: make all psw related
> defines also available for asm"):
> 
> compel/arch/s390/src/lib/infect.c: In function 'arch_can_dump_task':
> compel/arch/s390/src/lib/infect.c:523:25: error: 'UL' undeclared (first use in this function)
>   523 |         if (psw->mask & PSW_MASK_RI) {
>       |                         ^~~~~~~~~~~
> 
> Add the missing linux/const.h include to fix this.

Thanks. That fixes the build failure for me.

		Adrian

> Reported-by: Adrian Reber <areber@redhat.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2225745
> Link: https://github.com/checkpoint-restore/criu/pull/2232
> Fixes: b8af5999779d ("s390/ptrace: make all psw related defines also available for asm")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/uapi/asm/ptrace.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
> index f0fe3bcc78a8..bb0826024bb9 100644
> --- a/arch/s390/include/uapi/asm/ptrace.h
> +++ b/arch/s390/include/uapi/asm/ptrace.h
> @@ -8,6 +8,8 @@
>  #ifndef _UAPI_S390_PTRACE_H
>  #define _UAPI_S390_PTRACE_H
>  
> +#include <linux/const.h>
> +
>  /*
>   * Offsets in the user_regs_struct. They are used for the ptrace
>   * system call and in entry.S
> -- 
> 2.39.2
> 

