Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E85EB64D7
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jun 2023 14:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjFWOYp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jun 2023 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjFWOYo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jun 2023 10:24:44 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EB410C
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 07:24:43 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-666ecb24eb3so334644b3a.1
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687530283; x=1690122283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BXhTC2v6pUxG+hsvCgrpr6X6lmLWxVBU76yUJ1it6mc=;
        b=WwBmUsRkRn+d8K/CUFTITZPAiijq+mNGS23VxcXDWgRBaO3YeaAb9CGn5UYNvw8xuE
         is8581SmMpYLnoN3gopCiZicYEgrIlJsgqac5H1AF7ZnOWhdoT9h/BpiJUczHfcku7Eh
         8EV0af9YQFDIB/M88OhnjoEMPnIzFEVdVKYHik/izpp1ocZFmTaCdfRNWjI8/9HG/6TR
         vEFtwtAgAzYJW7bYhgj26Z3Zt7pDbKqs7galF5t81QJPtacywYWIVDzFtPR/Kohip92r
         /JwmOjZm8bzsO7Vd9sH6FhVTDK7VsTg/K6DrmiJ7/tYERHbJzNcO5hUnVHih1KxcJZ91
         9ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530283; x=1690122283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXhTC2v6pUxG+hsvCgrpr6X6lmLWxVBU76yUJ1it6mc=;
        b=gOE/uJiHJ46kRPbRWkuRKT/2E1PSyoAuEAi24BNQKaVi+BaguJw8+GScCBQE09FSuJ
         0mJwI9pfZuYd4I525PcpTwR8TRw/FmwocIH7I5kErxdr1b/nNmT4UJyYi5pQ6QJYsaQF
         CP79BaQEnSTe5qMTK7GpDUeG07RvMKQ/cxdAPqoHW6d41Fu8AkkKhvLbCnmS5GPPpl1s
         9syYK+Lh7Dwvo7JFdcMSySNX+rTe0u0hptCA/cBc1QHXBQrZ55ex17K4NS1PIes0Byia
         1J06VS3kLHNw4CC1Y3HL53CDkpzF2Ms6XflJ7aMKgqFBhDSNVJSy2Ohq26uvrYI5zsaM
         DXtQ==
X-Gm-Message-State: AC+VfDytIbx46cbBDneBCb3uw73ebbR58LJPHGrm80uCcxPGqqBszT2a
        QUJi9RhgOSDBfTaw7K1QMI2aWoviLRM=
X-Google-Smtp-Source: ACHHUZ6iBSV9DmoTyY1jspZcL24GA4euc/C+hM3clmSVzwcxNI+pnsjYRfjGYHdr6fPXdhC20bEdElnUsQU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:991:b0:659:ac9e:830 with SMTP id
 u17-20020a056a00099100b00659ac9e0830mr5944982pfg.2.1687530283463; Fri, 23 Jun
 2023 07:24:43 -0700 (PDT)
Date:   Fri, 23 Jun 2023 07:24:42 -0700
In-Reply-To: <20230623125416.481755-3-thuth@redhat.com>
Mime-Version: 1.0
References: <20230623125416.481755-1-thuth@redhat.com> <20230623125416.481755-3-thuth@redhat.com>
Message-ID: <ZJWrKtnflTrskPkX@google.com>
Subject: Re: [kvm-unit-tests PATCH 2/2] Link with "-z noexecstack" to avoid
 warning from newer versions of ld
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        "Nico =?iso-8859-1?Q?B=F6hr?=" <nrb@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Andrew Jones <andrew.jones@linux.dev>, kvmarm@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 23, 2023, Thomas Huth wrote:
> Newer versions of ld (from binutils 2.40) complain on s390x and x86:
> 
>  ld: warning: s390x/cpu.o: missing .note.GNU-stack section implies
>               executable stack
>  ld: NOTE: This behaviour is deprecated and will be removed in a
>            future version of the linker
> 
> We can silence these warnings by using "-z noexecstack" for linking
> (which should not have any real influence on the kvm-unit-tests since
> the information from the ELF header is not used here anyway, so it's
> just cosmetics).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 0e5d85a1..20f7137c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -96,7 +96,7 @@ CFLAGS += -Woverride-init -Wmissing-prototypes -Wstrict-prototypes
>  
>  autodepend-flags = -MMD -MF $(dir $*).$(notdir $*).d
>  
> -LDFLAGS += -nostdlib
> +LDFLAGS += -nostdlib -z noexecstack

Drat, the pull request[1] I sent to Paolo yesterday only fixes x86[2].

Paolo, want me to redo the pull request to drop the x86-specific patch? 

[1] https://lore.kernel.org/all/20230622211440.2595272-1-seanjc@google.com
[2] https://lore.kernel.org/all/20230406220839.835163-1-seanjc@google.com
