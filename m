Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FEFC4338F
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 07:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFD560F6B
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 07:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhG2HtM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jul 2021 03:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbhG2HtJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Jul 2021 03:49:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68B8C061765
        for <linux-s390@vger.kernel.org>; Thu, 29 Jul 2021 00:49:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c16so5665982wrp.13
        for <linux-s390@vger.kernel.org>; Thu, 29 Jul 2021 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L6N0ezTtWFmQj4Q9ef8/0d56n3pMY70Zf97no+qDSJA=;
        b=tjwxZwURHTWvWkFtjs1Jrg/NcpQ+H2TF5AQKGqyhFX+fc1TzDSMl36rHNr9bRnoaCh
         B+GT81ypvW+IJ5L45witNhgXDu0m98Tlk9L++fA6GdfaNIHvesS2SSjg2iuLH5H/pt6Y
         Xeg6g6AMMwR2Gzyg+SpI7BHxnOX9v9yyayq+FTjFLG6TYaFU2tZ8oLmkx2BBDkhbXbuA
         qj+ze7iXB/npWV+/yui2jOoeylqH85O3xk7SZDvmQ/n2mZ99Yr8sWyAaxmkbvqWulXTc
         B27qEVfN1GadYAppW4+XErOv/JRb6+4UrYth2NwPUU2ao8+0s3idaEKPmQo2SxmB2s9h
         G5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L6N0ezTtWFmQj4Q9ef8/0d56n3pMY70Zf97no+qDSJA=;
        b=NGp9Rf9wQmBNmUsfX5vHQOFbaTd0N/t0pEyyHkOV/REwqXxXAuhSrgZzRVfBxbhB16
         0QEcKyQaw6G48TYikbiGAUWoy5tO8LObydtuob7vLvCQvhpChoYY+gibx6zRGaInxHY2
         lSdWUtbBJBLv6ZQYPsd6W7IQ+eDrmVQBtc4Ao3WSWF0c/csBkY9jmp2TX9dOmhjcSwy/
         OJG7qqlZ35jzuTifng4Wq2RyMusLTfoYFk2eBCj8RVIndQ1Sq0gA+BBpj3+RZRcrDtXk
         Y2QpKlJaAIER1zQbe69GsMgtyF8M60LnCYrosJb0b2MefjYSf4ANcGl2KqqLBVyFpulA
         gIlw==
X-Gm-Message-State: AOAM530B2j4EdsTL4A3SCSJ4fJgp9lSNw/Q093v7VSewRd1/dFofGqn6
        yHfj3iHh5472hTBWq9ciQ2JpYQ==
X-Google-Smtp-Source: ABdhPJzbR1HACnZZJBDhiL2ARbrJnGx5sYQIaYtEWpSvBcN3z0ditxTzHS+Wuapzs4HhC7B1gYUdMQ==
X-Received: by 2002:adf:de8a:: with SMTP id w10mr3331505wrl.61.1627544945144;
        Thu, 29 Jul 2021 00:49:05 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:377:4a06:5280:39bf])
        by smtp.gmail.com with ESMTPSA id k186sm9573131wme.45.2021.07.29.00.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:49:04 -0700 (PDT)
Date:   Thu, 29 Jul 2021 09:48:58 +0200
From:   Marco Elver <elver@google.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/4] kfence: add function to mask address bits
Message-ID: <YQJdarx6XSUQ1tFZ@elver.google.com>
References: <20210728190254.3921642-1-hca@linux.ibm.com>
 <20210728190254.3921642-3-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728190254.3921642-3-hca@linux.ibm.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 28, 2021 at 09:02PM +0200, Heiko Carstens wrote:
> From: Sven Schnelle <svens@linux.ibm.com>
> 
> s390 only reports the page address during a translation fault.
> To make the kfence unit tests pass, add a function that might
> be implemented by architectures to mask out address bits.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

I noticed this breaks on x86 if CONFIG_KFENCE_KUNIT_TEST=m, because x86
conditionally declares some asm functions if !MODULE.

I think the below is the simplest to fix, and if you agree, please carry
it as a patch in this series before this patch.

With the below, you can add to this patch:

	Reviewed-by: Marco Elver <elver@google.com>

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Wed, 28 Jul 2021 21:57:41 +0200
Subject: [PATCH] kfence, x86: only define helpers if !MODULE

x86's <asm/tlbflush.h> only declares non-module accessible functions
(such as flush_tlb_one_kernel) if !MODULE.

In preparation of including <asm/kfence.h> from the KFENCE test module,
only define the helpers if !MODULE to avoid breaking the build with
CONFIG_KFENCE_KUNIT_TEST=m.

Signed-off-by: Marco Elver <elver@google.com>
---
 arch/x86/include/asm/kfence.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
index 05b48b33baf0..ff5c7134a37a 100644
--- a/arch/x86/include/asm/kfence.h
+++ b/arch/x86/include/asm/kfence.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_X86_KFENCE_H
 #define _ASM_X86_KFENCE_H
 
+#ifndef MODULE
+
 #include <linux/bug.h>
 #include <linux/kfence.h>
 
@@ -66,4 +68,6 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
 	return true;
 }
 
+#endif /* !MODULE */
+
 #endif /* _ASM_X86_KFENCE_H */
-- 
2.32.0.554.ge1b32706d8-goog

