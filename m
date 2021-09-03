Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B11C433F5
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 07:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C543610A2
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 07:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347810AbhICH6O (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Sep 2021 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbhICH6O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Sep 2021 03:58:14 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8F6C061575;
        Fri,  3 Sep 2021 00:57:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e7so4805907pgk.2;
        Fri, 03 Sep 2021 00:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3EzTvK/9UwFvtjEDurK48O7RI8g22JgDw2/OSGI9Ff0=;
        b=JYFfX3O5Uxz2kOe9S7N2hFwmwhv6Ug6z7tVtB2GTYcdhv5XkDIID9By4MJKXFR/nxF
         WHMim5jjf6n85UFWs74FZ5oNH7pZMpSO8IoIz7+0bK6YCPAXYdmlSn9/TkPNWXN2LUCv
         N8mB4yycrSrUbYbVWnSc327+nvZWfZjt03Q99/VdLUIeRrPuEQi1lQgtjHRwzJRXTgo6
         cKhQZHXhYZI+k3eG9p84+5JMD6HX4A3V0+Ohs1h3leaG3Iohg/BA46O09stt5Z2LpxwD
         91Xg52ZHlGSSqz6KP7NU+m5vpEFTkhxGaVdV7jWCKiAlKTDT4Ge0CD3apY4cuvgS4B72
         lZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3EzTvK/9UwFvtjEDurK48O7RI8g22JgDw2/OSGI9Ff0=;
        b=YQ8mI086A+RNkqdoRDpocr0fTflJcdQjJCZjBpDFLOrFdSpN6/YWRWJV2q5le5nHYU
         QZ7poSO1wihOjPaJvMip8o+MymuBylovovJqUB0UuBOc26w7np3yORqkX44+g7JsVOPu
         E3Qq979/bEpuni2M8W8TErO94jkDaCA1hReT5djOgR0NvaTMi/SJWOErjZ3y2U2EjaLE
         daehIQYFyKQvYOXGIMeTKMpB8SqFP0jWL2LNBah6Py7yzJNhaci2Xr+ulvXwd5vIHLIL
         ieDEPqNGN85oxp/mYc8O37XJoXgSBjgVRwt7xWBZfgpXLDReqmtUHxl1h5ExGN8odD2U
         Jthg==
X-Gm-Message-State: AOAM532i2ro3uAjPEoX2y/jo1UJBRS6g2n0n/8qdurscqq0ssHsZxNmn
        A6eJcgmjt4lVK0MFksNU5CU=
X-Google-Smtp-Source: ABdhPJy19YKLiwBiT4dKpxkBvd2ya/HSDRLeb56Yw187UcLXiO6He29foQYh9JBsAqlY6BCoe0mGoA==
X-Received: by 2002:aa7:8097:0:b029:3cd:b205:cfe9 with SMTP id v23-20020aa780970000b02903cdb205cfe9mr2377877pff.1.1630655833936;
        Fri, 03 Sep 2021 00:57:13 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id u8sm5420534pgc.69.2021.09.03.00.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 00:57:13 -0700 (PDT)
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
Date:   Fri,  3 Sep 2021 15:56:41 +0800
Message-Id: <20210903075641.2807623-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

There would not be ioremap and iounmap implementations if CONFIG_PCI is
not set for s390, so add default declarations of these two functionsi
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

