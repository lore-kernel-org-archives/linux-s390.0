Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D397C4321E
	for <linux-s390@archiver.kernel.org>; Sat,  3 Dec 2022 03:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiLCDFq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 2 Dec 2022 22:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiLCDFp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Dec 2022 22:05:45 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C4F7A09
        for <linux-s390@vger.kernel.org>; Fri,  2 Dec 2022 19:05:44 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jn7so6263771plb.13
        for <linux-s390@vger.kernel.org>; Fri, 02 Dec 2022 19:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUHGCrN2/GzmAYwHPUyKBA8Ge6xsvUhA3e+Vb+bqY68=;
        b=GTPXNM4I8XSeRWKFJbfehEVG870eOYMF/pKY9yMWeVjzuXAmyGPMV5Nuhgkd2Rpezc
         s+BSs8uV7IDAeaosxWjvuIEHbnwRyildLgIAk88UrLwNCF86OOw+gvsvp87gvdO7j5yY
         khg7Alr0W4R4/KHofpJ9D+lLwLem7Qb0wpi6ArvXA+llBKDEm0aE2tH//UDUW/zvNNNy
         gfVSZqmFmW+aoOXgq4s35qIFSAZ9WmYlvLQAEJEUCLULeQimBikv4W8YGE42LNgyHFBS
         veDXzJC3LeHh7Nnv4F5UhC6Q9SyzW2T+bBN93Ioth3DJNcJNlGBAnbsRy+dlZx3PTjOZ
         6m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUHGCrN2/GzmAYwHPUyKBA8Ge6xsvUhA3e+Vb+bqY68=;
        b=bUiE58rdmEza83tM41O3ayo4ipax77970EPJvN9LgdbcmjViRwrIfTZ1zrh+LHMGoh
         sevXOVL98kidEzTFpU4tnSdkEQ1EnQhRxBk6TrYFJLMJqcXzEO+RyRGkGKpyqjdelyaP
         Ap04Joo4W1bEnlOkrlFoji7m1tU8+m7LjVLFReiRDpb7ebaa79hbjuYPmALw9yoscCpM
         nknYOvkLL8uAgX9lVJdp+EB5clEtth+N20XdJFsTZ7NAqf0upHOi+tOTvT4SM8n0Ts0U
         DWj+VDLmh4xwnT1/fWS2Z80TJdKG1oIV6HenTlE7Ubt2PJgoZnY6hlaSEnUCm9i1k38r
         VYQQ==
X-Gm-Message-State: ANoB5plvcfMyQh2pRP8cBo+y9Ev+Dd/Pncf8y78+FfdGzkHZVwdBdgnX
        IyWXhc8qowIOqDglsPegzWAgQxRMoyXfEV3F
X-Google-Smtp-Source: AA0mqf6uIzMwjns2LD/gQeHWIsS+ZDiU1QORTWoif/bzBJr4V+crCrb3KCajLaMXkOYnYMNn1jPFyA==
X-Received: by 2002:a17:90b:609:b0:219:3ad9:64f5 with SMTP id gb9-20020a17090b060900b002193ad964f5mr29166277pjb.138.1670036743958;
        Fri, 02 Dec 2022 19:05:43 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b2-20020a62a102000000b005745635c5b5sm5713256pff.183.2022.12.02.19.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 19:05:43 -0800 (PST)
Subject: [PATCH 2/5] mm: Add VM_FAULT_ARCH_* codes
Date:   Fri,  2 Dec 2022 19:03:53 -0800
Message-Id: <20221203030356.3917-3-palmer@rivosinc.com>
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

A handful of architectures (arm, s390, and soon RISC-V) define their
own internal fault codes, so instead dedicate a few standard codes as
being architecture-specific to avoid conflicts.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/linux/mm_types.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 758eb70829cb..df1aa8d58444 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -880,6 +880,11 @@ enum vm_fault_reason {
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
@@ -903,7 +908,12 @@ enum vm_fault_reason {
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
2.38.1

