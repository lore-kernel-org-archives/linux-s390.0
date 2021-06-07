Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3098C47082
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDE061002
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 09:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFGJVA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:21:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3447 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFGJU6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Jun 2021 05:20:58 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fz75b0byhz6wHk;
        Mon,  7 Jun 2021 17:16:03 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 17:19:05 +0800
Received: from SWX921481.china.huawei.com (10.126.200.77) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 7 Jun 2021 17:18:56 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <hpa@zytor.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <borntraeger@de.ibm.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>,
        <linux-s390@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2] kprobes: remove duplicated strong free_insn_page in x86 and s390
Date:   Mon, 7 Jun 2021 21:18:54 +1200
Message-ID: <20210607091854.31580-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.77]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

free_insn_page() in x86 and s390 are same with the common weak function
in kernel/kprobes.c.
Plus, the comment "Recover page to RW mode before releasing it" in x86
seems insensible to be there since resetting mapping is done by common
code in vfree() of module_memfree().
So drop these two duplicated strong functions and related comment, then
mark the common one in kernel/kprobes.c strong.

Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2:
 remove free_insn_page in s390 as well and remove the __weak in common
 code according to Christoph's comment;

 arch/s390/kernel/kprobes.c     | 5 -----
 arch/x86/kernel/kprobes/core.c | 6 ------
 kernel/kprobes.c               | 2 +-
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index aae24dc75df6..60cfbd24229b 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -44,11 +44,6 @@ void *alloc_insn_page(void)
 	return page;
 }
 
-void free_insn_page(void *page)
-{
-	module_memfree(page);
-}
-
 static void *alloc_s390_insn_page(void)
 {
 	if (xchg(&insn_page_in_use, 1) == 1)
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index d3d65545cb8b..3bce67d3a03c 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -422,12 +422,6 @@ void *alloc_insn_page(void)
 	return page;
 }
 
-/* Recover page to RW mode before releasing it */
-void free_insn_page(void *page)
-{
-	module_memfree(page);
-}
-
 /* Kprobe x86 instruction emulation - only regs->ip or IF flag modifiers */
 
 static void kprobe_emulate_ifmodifiers(struct kprobe *p, struct pt_regs *regs)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 745f08fdd7a6..ddb643f3879f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -106,7 +106,7 @@ void __weak *alloc_insn_page(void)
 	return module_alloc(PAGE_SIZE);
 }
 
-void __weak free_insn_page(void *page)
+void free_insn_page(void *page)
 {
 	module_memfree(page);
 }
-- 
2.25.1

