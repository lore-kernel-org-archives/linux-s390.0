Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8AAC4321E
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 08:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26084610FD
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 08:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbhICIFM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Sep 2021 04:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348134AbhICIEi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Sep 2021 04:04:38 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB68C061575;
        Fri,  3 Sep 2021 01:03:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f129so4818121pgc.1;
        Fri, 03 Sep 2021 01:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6L64VU0IF2J9r1dk8gShwbL6aTlx7NpiPDjd+XxYvPU=;
        b=Ltpz16+0MI/vRLTQNSqjmTEViTUxTZBeW/ro+ozL7tE9ux2vC/RZLYlFJWWutPCxCT
         Or0u+cx/xkJnwSk9vvMOIBXVx/8ESLEXzwuiDU5PojtigUJIWZSbEXSnaOuasewHpnqr
         YmufC1lUt+hIayVubApOGKtKD1Zox3JCh2SDccto7+W3vZX9rsDrkmyr/4HRYeloy+8i
         /1UOyqTMNtLy9rzWTDaKgBqZZKa9bu7WX6UhSxcb0iGHA4GwxEd/rGa9L2Q9/apPLKEC
         CzELDCvMSuFAI3bWH++mKFe1KnAIfJIT+FsxmfiTg+dRS2eUrMZc5ejZ6xgK5xaAqxAh
         M6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6L64VU0IF2J9r1dk8gShwbL6aTlx7NpiPDjd+XxYvPU=;
        b=kfZ4niicVkhT6NV8h0gyBrwjJC/i7qnx3dvw8JjSep3Rp0E14VlP45uXMx/EOzIz2u
         5SwFCz6K6q7pv0UR8+VAgDN6C+sfRk5UITXiTPs5d8lhJrp4IxXhCuMBJ+x5iXvIY98v
         +78WCj4D8YyCOl0utOsqnArfuFrv9k9UYhO3oIgn5Ste+REV46u/ryk8qUggcxc4M/+h
         CYQ+sPAFFj2w9XCZDYMorrb2Il/TSZshaqngz3sW95lC66yB0zZ2kKiqjarBg/Pn+Ns/
         Vjn1Px6cqHEEQ0tBiGnL9dNRDcUZGO4mqvudf/QzRyNF++i2xhRL9gjj3BHlqgU9TEYa
         rpgQ==
X-Gm-Message-State: AOAM530GFOfPW/zf52W69Mac+bLf8a/o6ECu5lrOIEzVHIcx/PZg5A2v
        TouxARyyVWgIhQ7NplcxugQ=
X-Google-Smtp-Source: ABdhPJwFH2cSsna4NAVhWoQSvXmPH2PjvbH+RaggZ/mwqlF6khocO59N3M1BWzXDPDsb39Wa7mQ+DQ==
X-Received: by 2002:a63:aa43:: with SMTP id x3mr2527544pgo.208.1630656205743;
        Fri, 03 Sep 2021 01:03:25 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 26sm6200531pgx.72.2021.09.03.01.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 01:03:25 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] s390/io: Fix ioremap and iounmap undefinded issue for s390
Date:   Fri,  3 Sep 2021 16:03:16 +0800
Message-Id: <20210903080316.2808017-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210903075641.2807623-1-zhang.lyra@gmail.com>
References: <20210903075641.2807623-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

There would not be ioremap and iounmap implementations if CONFIG_PCI is
not set for s390, so add default declarations of these two functions
for the case to avoid 'undefined reference' issue.

Fixes: 71ba41c9b1d9 ("s390/pci: provide support for MIO instructions")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
The issue was reported from https://lkml.org/lkml/2021/8/1/18
---
 arch/s390/include/asm/io.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index e3882b012bfa..9438370c6445 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -23,11 +23,8 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 #define IO_SPACE_LIMIT 0
 
 void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
-void __iomem *ioremap(phys_addr_t addr, size_t size);
 void __iomem *ioremap_wc(phys_addr_t addr, size_t size);
 void __iomem *ioremap_wt(phys_addr_t addr, size_t size);
-void iounmap(volatile void __iomem *addr);
-
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
 	return NULL;
@@ -39,6 +36,9 @@ static inline void ioport_unmap(void __iomem *p)
 
 #ifdef CONFIG_PCI
 
+void __iomem *ioremap(phys_addr_t addr, size_t size);
+void iounmap(volatile void __iomem *addr);
+
 /*
  * s390 needs a private implementation of pci_iomap since ioremap with its
  * offset parameter isn't sufficient. That's because BAR spaces are not
@@ -70,6 +70,15 @@ static inline void ioport_unmap(void __iomem *p)
 #define __raw_writel	zpci_write_u32
 #define __raw_writeq	zpci_write_u64
 
+#else
+static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
+{
+	return (void __iomem *) offset;
+}
+
+static inline void iounmap(void __iomem *addr)
+{
+}
 #endif /* CONFIG_PCI */
 
 #include <asm-generic/io.h>
-- 
2.25.1

