Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C6BC6FD1D
	for <linux-s390@archiver.kernel.org>; Wed, 15 Mar 2023 03:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjCODFb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Mar 2023 23:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCODFa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Mar 2023 23:05:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F44574EC
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so468910pjz.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678849529;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjXs6Q9el+E3DjFj75yzzOPO7Ucq3PFGsjms6Llyx9A=;
        b=mRz3PKHV4IBxR+2dOFKG5hwZul2ABonaRfC7Ehdx0OfdaJc8X1QKmjbUc3A/sMtQmb
         gbdDUmN6C0xqiSSvVk7V6RYl7rj70SnASOVED2xToUNivvfAXHpYOvdfNg9PNLDBWyDp
         IncEoQPsAhVH27iWxXjZiY9+MPHJp6iXyumIDVQgIFvnpqQ2awg+ak4Y4xvxSFjC0zod
         3dJQKPZ3iUEBFf1zv/1bEdn3ErqHsi/M0WCTCcYx6qxBUNzn+biRBb8C3pLH8Kmj08p4
         BzamwZHJuVc6k1iXhWSR7eCcnQcS6MM7x9tkiaPkVq0c4rPipsvwrOOR87W+SmOuO7ef
         mW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678849529;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjXs6Q9el+E3DjFj75yzzOPO7Ucq3PFGsjms6Llyx9A=;
        b=rTxI8nhrGKtjnp9kfScLmr7y4zvAQBzJZ09VnkWyJlZfpmHUyzztIejt1fyzsnsduc
         7qFoqWYY9+1KHul0sK0Tn4bp9jFiqe1Q10Ov8mmhjNM/7z3cgtERwfxtQ8eOCMtoFqLX
         6ws5dYIX+ydB6+U6r+POwwyaihqJDgnIPufjkdTz62vpszLGcEVRCe5gFCGi7ERIln/z
         LZHnxorUAIEzp9SRHRzaS3V54B9AZmAEj0NqbSQlEIKA7h5lJWBre5JrCMmPUq5Q8mOH
         0/yIrEISd8SJxK6vpLAyv5vI6FINCA13IDweYe/kMER0nSyZ0Fn1ZFTTSztw/ZLhtuM4
         heIw==
X-Gm-Message-State: AO0yUKVoCSMjIQDOukQQ3hETZhUXkCgVug9jvgqgwkW9KVbScKZvmlu6
        DEAWZEydx/P75fRp72KuhMk9ir2sr4ris5VCmio=
X-Google-Smtp-Source: AK7set8aNlVZNOCixnv/wCzZZa//jnHG6FrTV/mi2NGNpxsUbRVCAmKzBlXv1PxwH+TLgm6P1rGJNQ==
X-Received: by 2002:a17:903:48d:b0:19e:e39b:6d98 with SMTP id jj13-20020a170903048d00b0019ee39b6d98mr981507plb.35.1678849528720;
        Tue, 14 Mar 2023 20:05:28 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jz12-20020a170903430c00b0019f2cee9221sm2447268plb.95.2023.03.14.20.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:05:28 -0700 (PDT)
Subject: [PATCH v2 3/6] mm: Add VM_FAULT_ARCH_* codes
Date:   Tue, 14 Mar 2023 20:03:56 -0700
Message-Id: <20230315030359.14162-4-palmer@rivosinc.com>
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

A handful of architectures (arm, s390, and soon RISC-V) define their
own internal fault codes, so instead dedicate a few standard codes as
being architecture-specific to avoid conflicts.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/linux/mm_types.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index fd9b863869b4..47f36a2fdaac 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -938,6 +938,7 @@ typedef __bitwise unsigned int vm_fault_t;
  *				in DAX)
  * @VM_FAULT_COMPLETED:		->fault completed, meanwhile mmap lock released
  * @VM_FAULT_HINDEX_MASK:	mask HINDEX value
+ * @VM_FAULT_ARCH_*		Architecture-specific VM fault codes.
  *
  */
 enum vm_fault_reason {
@@ -955,6 +956,11 @@ enum vm_fault_reason {
 	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x0002000,
 	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x0004000,
 	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x00f0000,
+	VM_FAULT_ARCH_0         = (__force vm_fault_t)0x0100000,
+	VM_FAULT_ARCH_1         = (__force vm_fault_t)0x0200000,
+	VM_FAULT_ARCH_2         = (__force vm_fault_t)0x0400000,
+	VM_FAULT_ARCH_3         = (__force vm_fault_t)0x0800000,
+	VM_FAULT_ARCH_4         = (__force vm_fault_t)0x1000000,
 };
 
 /* Encode hstate index for a hwpoisoned large page */
@@ -977,7 +983,12 @@ enum vm_fault_reason {
 	{ VM_FAULT_RETRY,               "RETRY" },	\
 	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
 	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
-	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
+	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },  \
+	{ VM_FAULT_ARCH_0,              "ARCH_0" },     \
+	{ VM_FAULT_ARCH_1,              "ARCH_1" },     \
+	{ VM_FAULT_ARCH_2,              "ARCH_2" },     \
+	{ VM_FAULT_ARCH_3,              "ARCH_3" },     \
+	{ VM_FAULT_ARCH_4,              "ARCH_4" },     \
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
-- 
2.39.2

