Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A30C76196
	for <linux-s390@archiver.kernel.org>; Wed, 15 Mar 2023 03:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCODFg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Mar 2023 23:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCODFd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Mar 2023 23:05:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E448D574FB
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id ix20so12131075plb.3
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678849532;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOZC9xlq5oK9zfHrbfD1I5w67GRN7lAgeCV10VaVF3k=;
        b=K9waOzhTSocf5S/wDOQBDgV8dv2EBbrWlB6icT3n3eOn3aBwCzE1quBWWS5eLBl43v
         2GIX8VAElVK01zF7Q159vC0+esGvSNVEgVo1krYdOpl58TPEA72YrMA4t5AldEkXWuvT
         d8RLRXgJUdL5i/Q9N7TPgh6s0Dd6c0p3dhRvCjQbX4bcG+gYii0edSeZeYzcTH5W4OFX
         5zBs70RjyU2IUiz+9csHcPQxfGOe01e4ihaZj84AhEovkIliRoH0+xNZddmNKkpvvRYq
         NnRXeKLrhnhS7VS97vZc9U4pYx0wGeJV79JPP30ZFOtR587Idcxeo3jvJJsC3P0+Jxsn
         Ztcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678849532;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOZC9xlq5oK9zfHrbfD1I5w67GRN7lAgeCV10VaVF3k=;
        b=Ih/Zga98MKZQagS+c6FBT7mLqRDvb7b2a+a71X76mG7+7N4PRDeZdug3U0PQZ+7rCd
         jO5pffwYiG5NmT8XRPCtdI9oh6N0mIhqx95pyv57nImH53UOVKuSWyQP9d7Dxv/jSuFM
         88I0hXEomdV0GSKeJ3fhSYcgj5bw/zTLae+KL/kN6hXuT2X3/ksCmCU+rX9jSOgo735c
         V/OeUJdw4OOVkqBALN1oEpSnognhXcVs3p+XwtraK+1j/roMWLTa8ocINe5XBVJhN40w
         939WsCwHdIaawDputdEHaLofDYVbbKDR/sI7iAh4US6SZrhtDHi0m3DqnNWIJTRGOclN
         YZ9Q==
X-Gm-Message-State: AO0yUKXuiTTQ8YYh8J2ixpsleL1e6j6cAXxaWL/XQCk3vbRlr5pqdY5/
        OQ9/fd+L+r6l/MKsZq1bfa28ig==
X-Google-Smtp-Source: AK7set9kCiiyWzQ3igLEvZCSypTckIX+ebt5Tmlk9BmpkJZJwcIqMSFzq7VaBKi++BxTMFzZG1Gyrw==
X-Received: by 2002:a17:903:138b:b0:19f:3e7a:4290 with SMTP id jx11-20020a170903138b00b0019f3e7a4290mr890658plb.17.1678849532243;
        Tue, 14 Mar 2023 20:05:32 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b0019460ac7c6asm2406194ple.283.2023.03.14.20.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:05:31 -0700 (PDT)
Subject: [PATCH v2 6/6] s390: fault: Convert to VM_FAULT_ARCH_* codes
Date:   Tue, 14 Mar 2023 20:03:59 -0700
Message-Id: <20230315030359.14162-7-palmer@rivosinc.com>
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
 arch/s390/mm/fault.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index a2632fd97d00..f1a186a4c465 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -50,11 +50,11 @@
  * Allocate private vm_fault_reason from top.  Please make sure it won't
  * collide with vm_fault_reason.
  */
-#define VM_FAULT_BADCONTEXT	((__force vm_fault_t)0x80000000)
-#define VM_FAULT_BADMAP		((__force vm_fault_t)0x40000000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x20000000)
-#define VM_FAULT_SIGNAL		((__force vm_fault_t)0x10000000)
-#define VM_FAULT_PFAULT		((__force vm_fault_t)0x8000000)
+#define VM_FAULT_BADCONTEXT	VM_FAULT_ARCH_0
+#define VM_FAULT_BADMAP		VM_FAULT_ARCH_1
+#define VM_FAULT_BADACCESS	VM_FAULT_ARCH_2
+#define VM_FAULT_SIGNAL		VM_FAULT_ARCH_3
+#define VM_FAULT_PFAULT		VM_FAULT_ARCH_4
 
 enum fault_type {
 	KERNEL_FAULT,
-- 
2.39.2

