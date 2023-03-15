Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98591C7618D
	for <linux-s390@archiver.kernel.org>; Wed, 15 Mar 2023 03:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCODFe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Mar 2023 23:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCODFb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Mar 2023 23:05:31 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7111E58B7C
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id p6so10064141pga.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678849530;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CSfwyQHlQ4M4jXaSH+LdMi3uBUPZy3NPttk2ev1MeM=;
        b=4mZhqkrZl2MkO6B6mqEDLTirH3SlLVvooXtpQuTuH/xzUmMWO0qlG33s8kcsf8vR+X
         1FoOK2Rk0bJmVb+8FuKG/2Jxjnt0oUDaFG+VqsxM9hrbjvOV2ZarD+HZLutU5YIiAVXL
         IZDZQgKVdEkHiqO2TWB2SNLAlsr0Wiul9s5npuCAjeBOJ5joViCl/33dOtfcuNA0qTKJ
         wI89dyMtuHkmCnCcbUMyMFUQHfyAxxbiJrKXeydYHQhFoxpswgDnmjyFK1K2t7/bFmGC
         dvm2FAw3pTK46SBSowzA4dhLd1uqkTrpZPHWJKiwmyDolqIdJoRm8AiDKGHFgfo1NVtm
         xglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678849530;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CSfwyQHlQ4M4jXaSH+LdMi3uBUPZy3NPttk2ev1MeM=;
        b=Ti/NFHZM+BA5tmMx/Lqcq3Vz/U+dgHRdO9zJldZjjDPkrYBLjIo0EX5wKUsvf4FX8J
         aflXBcFDADWjs7nVqaN9NMehc3Z/74xkouyTF8v7ajxcWboVXl9drJi7YLYlbByp10CT
         YIOZV7avx5xPjBlc0oSOGVJ319utOPKHxet820u7kog76qvSxJnAEgGhBnRYqRkBbpY3
         jJLhaDGpxAwSgzciT/MXjoXpWDO3Tf0DcFe8nqgKmh4mb1qObwibct+lI4TUTzO7dkeH
         b7JvNa+4LONOIMmZhhmv0JTpXvHGp0EeesSy7d4xIgWGHEa4YqbFVlQmVxy6mjo+jnBM
         HW3g==
X-Gm-Message-State: AO0yUKWeLA/+V5c3oBVfYXNeJ1I5cuD1FCgJ8Dzup+Gcmec0PMRcTNXH
        lIAQMcvlH777YLKrzum995150mi2enU9ms2og0g=
X-Google-Smtp-Source: AK7set9ZnZdofrFWQ0U8lJyHxwjbzhYXBh8dBYrjkL6TD0h/9D1nJL1aS2SUyiziKQzZO7kTArkNIA==
X-Received: by 2002:a62:18c8:0:b0:622:bdec:d49 with SMTP id 191-20020a6218c8000000b00622bdec0d49mr9133281pfy.11.1678849529904;
        Tue, 14 Mar 2023 20:05:29 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id o6-20020a63f146000000b0050376cedb3asm2230300pgk.24.2023.03.14.20.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:05:29 -0700 (PDT)
Subject: [PATCH v2 4/6] RISC-V: fault: Convert to VM_FAULT_ARCH_* codes
Date:   Tue, 14 Mar 2023 20:03:57 -0700
Message-Id: <20230315030359.14162-5-palmer@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315030359.14162-1-palmer@rivosinc.com>
References: <20230315030359.14162-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     akpm@linux-foundation.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

These conflict with VM_FAULT_HINDEX_MASK, so move to some designated
arch-specific values.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 0a8c9afeee22..5b035c0ae782 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -202,8 +202,8 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 	return false;
 }
 
-#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
+#define VM_FAULT_BADMAP		VM_FAULT_ARCH_0
+#define VM_FAULT_BADACCESS	VM_FAULT_ARCH_1
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 				unsigned int mm_flags, struct pt_regs *regs)
-- 
2.39.2

