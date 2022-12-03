Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F487C47088
	for <linux-s390@archiver.kernel.org>; Sat,  3 Dec 2022 03:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiLCDFu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 2 Dec 2022 22:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiLCDFr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Dec 2022 22:05:47 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49D0F818E
        for <linux-s390@vger.kernel.org>; Fri,  2 Dec 2022 19:05:46 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y4so6295180plb.2
        for <linux-s390@vger.kernel.org>; Fri, 02 Dec 2022 19:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXyyhDtl8c7AV1KDvPOaTLsEEraDYLnRgQTRKevMxLE=;
        b=J9nA5zFzEgIt8zsxxMPn+sGlIH86WVlgcK5M4y+MnARF9MADgB6h9QisIFpQgAX5Xc
         gT+JZZbSYIwNPr5lPusi+V73ZxiVkLhM81QZ6t8o4/bUs0p7dwivbSNGIto+U0W3vJje
         odd1RyOpgxE8uPgVe+OvIiemZQ8s/XdQJhhr+yDr90iN2d2hOZAsbJWqu8yYBosqrxer
         9lITxlUrsZAUjRZJKcN0IbJ2m0ZjxM8c9gapj57wHECA6g4hNRl0vKRmp3L5kzuNEkTN
         fw8pU5isxRHsgpJlmPJcoUscGfiLE65hETmvjd9z7oAjQb+boL6+grwCz+iNw1swFZvZ
         utXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXyyhDtl8c7AV1KDvPOaTLsEEraDYLnRgQTRKevMxLE=;
        b=Q8YMW4d/8dtg086UbCAsN/sz0m+HWWbHnZ+hf0HBSj+65s27HXNVXxHjrzqDcVUNh4
         AQl5fQh4YjWz5GijUXo74wNfeXNdXjWnq3kIUm8KLjDSax6Y4KFSW+ABS362R3qZ++hA
         ca9wdyqXNuOumUohHSUFD1qxLMuucLfJbuaIeclwXfi10gsG6YL0+YGnrhtIxKl3FyS1
         0//mo4q5AhYx2KBrlfYbQC7oTQ4V+OluYmQTrjqRe5d8Pk50Yg8EPyJVzx7pra70SkeV
         CXvquhOLZlSoWqc1TwfNeMjMvF4+nc8ZN1qETsfmdGazvxRUbAGNoSZ8gVJS5B1SMjKI
         aF3A==
X-Gm-Message-State: ANoB5pmAaqhOkPZ9J4u4VU3NFRJohHUzR5bYqivizqaPoqTpTkCWHe5d
        OQWEZD6ObOzuqQmCNaSVYgf2Ow==
X-Google-Smtp-Source: AA0mqf7g0g8qmEYMQvaaJVG+LEYazPjzCbvT60LuJ6AU8Q984Tt5DyiX5U2wTDFpAbMwx/ydl7UUTA==
X-Received: by 2002:a17:902:ce8e:b0:174:b537:266d with SMTP id f14-20020a170902ce8e00b00174b537266dmr54845874plg.144.1670036746128;
        Fri, 02 Dec 2022 19:05:46 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b001886ff822ffsm6147005plm.186.2022.12.02.19.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 19:05:45 -0800 (PST)
Subject: [PATCH 4/5] s390: fault: Convert to VM_FAULT_ARCH_* codes
Date:   Fri,  2 Dec 2022 19:03:55 -0800
Message-Id: <20221203030356.3917-5-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203030356.3917-1-palmer@rivosinc.com>
References: <20221203030356.3917-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
           linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

These conflict with VM_FAULT_HINDEX_MASK, so move to some designated
arch-specific values.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/s390/mm/fault.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 9649d9382e0a..464a74e52465 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -46,11 +46,11 @@
 #define __SUBCODE_MASK 0x0600
 #define __PF_RES_FIELD 0x8000000000000000ULL
 
-#define VM_FAULT_BADCONTEXT	((__force vm_fault_t) 0x010000)
-#define VM_FAULT_BADMAP		((__force vm_fault_t) 0x020000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t) 0x040000)
-#define VM_FAULT_SIGNAL		((__force vm_fault_t) 0x080000)
-#define VM_FAULT_PFAULT		((__force vm_fault_t) 0x100000)
+#define VM_FAULT_BADCONTEXT	VM_FAULT_ARCH_0
+#define VM_FAULT_BADMAP		VM_FAULT_ARCH_1
+#define VM_FAULT_BADACCESS	VM_FAULT_ARCH_2
+#define VM_FAULT_SIGNAL		VM_FAULT_ARCH_3
+#define VM_FAULT_PFAULT		VM_FAULT_ARCH_4
 
 enum fault_type {
 	KERNEL_FAULT,
-- 
2.38.1

