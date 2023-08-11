Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86137C0015E
	for <linux-s390@archiver.kernel.org>; Fri, 11 Aug 2023 07:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjHKHCw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 11 Aug 2023 03:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjHKHCv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Aug 2023 03:02:51 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A0C26AE
        for <linux-s390@vger.kernel.org>; Fri, 11 Aug 2023 00:02:50 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9d3dacb33so25809391fa.1
        for <linux-s390@vger.kernel.org>; Fri, 11 Aug 2023 00:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691737369; x=1692342169;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YNg4syLFgaV0/aVnuzeWWgXpnl+cr4G1njIJ8+UBVvM=;
        b=P5Uqw3+/O2htfrWJ9jElM+zse04tPQhfFIUYZcUpfOkjORA58Yjt+BcaGOuJvfYQS2
         m/BkYoFKA+ING0UEMTqoL5bQ6MTpT7dm8N9V675MJThpXeCnqSrp6llqbcm8ID4w72nB
         QjYmhSl5Z/sPX0E7I4sT2N676nhnJqnTFIfJoqjIN713uI9j154usD2hY/m3ncOjv1Yc
         m1c1WlAURooLZ6UrindCfyvNp5eIe55RsMIww+DQeivJqcpnTL3ol7bjZAQoeH/7XL/j
         GxIVzqTKKlHNYDmJzWwx/ZtQcboYOV94w9ynFSLcLKOhJTHPu7qrR2OKgPkzZqlO7L4w
         lKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691737369; x=1692342169;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNg4syLFgaV0/aVnuzeWWgXpnl+cr4G1njIJ8+UBVvM=;
        b=fXKA4Vt4QuiqW0rpXnZr4ZOuOXxjeRvUWsRvLO8Oqra2/F40yE2LOC+MQZE2ZIHD+5
         SavqtSRosAwpkSEeItLDhhhxbSi9qD4hp1DoPZpe6l9RCQnRU7OTg0ygHCrICpXApU72
         V7E5lu5MG16mJ+AArCj8fohKgYnNNzs/IzdFLOAeovOmUZoU7+2GzZ2rcJrHrWYN//13
         0DaampYDSGW1TDPDMTDIkTmzQhKnN1icsr4KsZSlifKjUoSTc0CH6SOAn9g91D5BXP5/
         zV2Fz8U0TCEVgK09mrkJ43q9mWSm/g6HxJSJRKivkyme1pMrwqzvemqgyC5FMyA5GrTe
         Vjcw==
X-Gm-Message-State: AOJu0Ywjru3XKixQbmLdCqIHiK0fKSyZvQhzq8TAi4kFgV5AYn6cvKWA
        P6iLxXxf3CgUscgB0qHVkQhavw==
X-Google-Smtp-Source: AGHT+IEXKms+h4JS+9TeqNhIHgC54AdjsVpie14FkPGXAmcqpknCX5CvdffUhGNo96V4KNw+NUvzkw==
X-Received: by 2002:a05:651c:217:b0:2b6:e78e:1e58 with SMTP id y23-20020a05651c021700b002b6e78e1e58mr863999ljn.5.1691737369167;
        Fri, 11 Aug 2023 00:02:49 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h4-20020a2e9ec4000000b002b70aff9a97sm728848ljk.16.2023.08.11.00.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 00:02:48 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Aug 2023 09:02:47 +0200
Subject: [PATCH] s390/mm: Make virt_to_pfn() a static inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-virt-to-phys-s390-v1-1-b661426ca9cd@linaro.org>
X-B4-Tracking: v=1; b=H4sIABbd1WQC/x3MQQqAIBBA0avErBswRbCuEi0sx5xNhRNSRHdPW
 r7F/w8IZSaBoXkgU2Hhfavo2gaW5LeVkEM1aKWNcqrHwvnEc8cj3YJieoU6ehOMm52zFmp3ZIp
 8/c9xet8PXOY11GMAAAA=
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

For symmetry do the same with pfn_to_virt() reflecting the
current layout in asm-generic/page.h.

Doing this reveals a number of offenders in the arch code and
the S390-specific drivers, so just bite the bullet and fix up
all of those as well.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/s390/include/asm/kfence.h |  2 +-
 arch/s390/include/asm/page.h   | 12 ++++++++++--
 arch/s390/mm/cmm.c             |  2 +-
 arch/s390/mm/vmem.c            |  2 +-
 drivers/s390/block/scm_blk.c   |  2 +-
 drivers/s390/char/vmcp.c       |  2 +-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/kfence.h b/arch/s390/include/asm/kfence.h
index d55ba878378b..e47fd8cbe701 100644
--- a/arch/s390/include/asm/kfence.h
+++ b/arch/s390/include/asm/kfence.h
@@ -35,7 +35,7 @@ static __always_inline void kfence_split_mapping(void)
 
 static inline bool kfence_protect_page(unsigned long addr, bool protect)
 {
-	__kernel_map_pages(virt_to_page(addr), 1, !protect);
+	__kernel_map_pages(virt_to_page((void *)addr), 1, !protect);
 	return true;
 }
 
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index a9c138fcd2ad..cfec0743314e 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -191,8 +191,16 @@ int arch_make_page_accessible(struct page *page);
 #define phys_to_page(phys)	pfn_to_page(phys_to_pfn(phys))
 #define page_to_phys(page)	pfn_to_phys(page_to_pfn(page))
 
-#define pfn_to_virt(pfn)	__va(pfn_to_phys(pfn))
-#define virt_to_pfn(kaddr)	(phys_to_pfn(__pa(kaddr)))
+static inline void *pfn_to_virt(unsigned long pfn)
+{
+	return __va(pfn_to_phys(pfn));
+}
+
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return phys_to_pfn(__pa(kaddr));
+}
+
 #define pfn_to_kaddr(pfn)	pfn_to_virt(pfn)
 
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 5300c6867d5e..f47515313226 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -90,7 +90,7 @@ static long cmm_alloc_pages(long nr, long *counter,
 			} else
 				free_page((unsigned long) npa);
 		}
-		diag10_range(virt_to_pfn(addr), 1);
+		diag10_range(virt_to_pfn((void *)addr), 1);
 		pa->pages[pa->index++] = addr;
 		(*counter)++;
 		spin_unlock(&cmm_lock);
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b26649233d12..30cd6e1be10d 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -36,7 +36,7 @@ static void vmem_free_pages(unsigned long addr, int order)
 {
 	/* We don't expect boot memory to be removed ever. */
 	if (!slab_is_available() ||
-	    WARN_ON_ONCE(PageReserved(virt_to_page(addr))))
+	    WARN_ON_ONCE(PageReserved(virt_to_page((void *)addr))))
 		return;
 	free_pages(addr, order);
 }
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 0c1df1d5f1ac..3a9cc8a4a230 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -134,7 +134,7 @@ static void scm_request_done(struct scm_request *scmrq)
 
 		if ((msb->flags & MSB_FLAG_IDA) && aidaw &&
 		    IS_ALIGNED(aidaw, PAGE_SIZE))
-			mempool_free(virt_to_page(aidaw), aidaw_pool);
+			mempool_free(virt_to_page((void *)aidaw), aidaw_pool);
 	}
 
 	spin_lock_irqsave(&list_lock, flags);
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 4cebfaaa22b4..f66906da83c4 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -89,7 +89,7 @@ static void vmcp_response_free(struct vmcp_session *session)
 	order = get_order(session->bufsize);
 	nr_pages = ALIGN(session->bufsize, PAGE_SIZE) >> PAGE_SHIFT;
 	if (session->cma_alloc) {
-		page = virt_to_page((unsigned long)session->response);
+		page = virt_to_page((void *)session->response);
 		cma_release(vmcp_cma, page, nr_pages);
 		session->cma_alloc = 0;
 	} else {

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230809-virt-to-phys-s390-2fa3d38b8855

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

