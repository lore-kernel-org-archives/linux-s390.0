Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6C1C47082
	for <linux-s390@archiver.kernel.org>; Tue,  8 Jun 2021 06:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2516B61059
	for <linux-s390@archiver.kernel.org>; Tue,  8 Jun 2021 06:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFHG7j (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:59:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8073 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFHG7i (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Jun 2021 02:59:38 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzgwH1DP6zYrm0;
        Tue,  8 Jun 2021 14:54:55 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 14:57:44 +0800
Received: from SWX921481.china.huawei.com (10.126.203.90) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 14:57:39 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <hpa@zytor.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <borntraeger@de.ibm.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>,
        <linux-s390@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <liuqi115@huawei.com>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Christoph Hellwig" <hch@infradead.org>
Subject: [PATCH v3] kprobes: remove duplicated strong free_insn_page in x86 and s390
Date:   Tue, 8 Jun 2021 18:57:36 +1200
Message-ID: <20210608065736.32656-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.90]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

free_insn_page() in x86 and s390 is same with the common weak function
in kernel/kprobes.c.
Plus,  the comment "Recover page to RW mode before releasing it" in x86
seems insensible to be there since resetting mapping is done by common
code in vfree() of module_memfree().
So drop these two duplicated strong functions and related comment, then
mark the common one in kernel/kprobes.c strong.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v3: mark free_insn_page as static according to Christoph's comment

 arch/s390/kernel/kprobes.c     | 5 -----
 arch/x86/kernel/kprobes/core.c | 6 ------
 include/linux/kprobes.h        | 1 -
 kernel/kprobes.c               | 2 +-
 4 files changed, 1 insertion(+), 13 deletions(-)

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
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 1883a4a9f16a..c98a35a75f40 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -407,7 +407,6 @@ int enable_kprobe(struct kprobe *kp);
 void dump_kprobe(struct kprobe *kp);
 
 void *alloc_insn_page(void);
-void free_insn_page(void *page);
 
 int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		       char *sym);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 745f08fdd7a6..e0c4c9d57299 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -106,7 +106,7 @@ void __weak *alloc_insn_page(void)
 	return module_alloc(PAGE_SIZE);
 }
 
-void __weak free_insn_page(void *page)
+static void free_insn_page(void *page)
 {
 	module_memfree(page);
 }
-- 
2.25.1

