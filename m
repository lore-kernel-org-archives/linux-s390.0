Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2CCC4320E
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 19:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB1160BD3
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 19:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhG1TDH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:03:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230083AbhG1TDH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 15:03:07 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SIeVYX142956;
        Wed, 28 Jul 2021 15:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4QysXU3cgPE14ICbtSebIdAEvd2Whhmjixbyt0l4VQQ=;
 b=Dagu6+giLL60cqag0v4WOcH+hu02uMmqE/q8ViG3IQK/lYGVbOP1sygrA0jb5WSk7V+k
 8xXTghWUwbNhZCKryh2g0oy+kL1O/xF3h4PAMGni5ujNF4j/XeZKKSR0puZDRii/aARm
 BbeCxCfTLXeaS4o2i3Jkk1MfN1t3Zt+oKn2fApEEJ5Hhky2N6hXvKdQxtCQwSMbY5Zwk
 hyVIDGCH67gYRPZmFz2ewnwNdkGRUCTg5Rx3oI4VMQZii8ojHqLmd1TBS0/b0pIqeTKM
 9+2QlZwIu6/uVcDTdDRCFGddOFE53iP3x/XBUe3uRPOUCJurqv20PWv3syjVoTPFR6A1 CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a3bf7jety-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:03:02 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SIf6pS145086;
        Wed, 28 Jul 2021 15:03:02 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a3bf7jetb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:03:02 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SJ30nS014713;
        Wed, 28 Jul 2021 19:03:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3a235kgtux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 19:03:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SJ0GX924904094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 19:00:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E63D3AE04D;
        Wed, 28 Jul 2021 19:02:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 850FAAE045;
        Wed, 28 Jul 2021 19:02:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 19:02:56 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/4] s390: add support for KFENCE
Date:   Wed, 28 Jul 2021 21:02:53 +0200
Message-Id: <20210728190254.3921642-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728190254.3921642-1-hca@linux.ibm.com>
References: <20210728190254.3921642-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wG5MQjOYWukoOHGzEbQlaeySmTJNQ0TO
X-Proofpoint-ORIG-GUID: sP12_R-6Ygk47a7VgXJO8eOnkHK6yxHN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_09:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280106
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
[hca@linux.ibm.com: simplify/rework code]
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig              |  1 +
 arch/s390/include/asm/kfence.h | 42 ++++++++++++++++++++++++++++++++++
 arch/s390/mm/fault.c           |  9 ++++++--
 arch/s390/mm/init.c            |  3 ++-
 arch/s390/mm/pageattr.c        |  3 ++-
 5 files changed, 54 insertions(+), 4 deletions(-)
 create mode 100644 arch/s390/include/asm/kfence.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index a0e2130f0100..f20467af2ab2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -138,6 +138,7 @@ config S390
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_VMALLOC
+	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
diff --git a/arch/s390/include/asm/kfence.h b/arch/s390/include/asm/kfence.h
new file mode 100644
index 000000000000..d55ba878378b
--- /dev/null
+++ b/arch/s390/include/asm/kfence.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_S390_KFENCE_H
+#define _ASM_S390_KFENCE_H
+
+#include <linux/mm.h>
+#include <linux/kfence.h>
+#include <asm/set_memory.h>
+#include <asm/page.h>
+
+void __kernel_map_pages(struct page *page, int numpages, int enable);
+
+static __always_inline bool arch_kfence_init_pool(void)
+{
+	return true;
+}
+
+#define arch_kfence_test_address(addr) ((addr) & PAGE_MASK)
+
+/*
+ * Do not split kfence pool to 4k mapping with arch_kfence_init_pool(),
+ * but earlier where page table allocations still happen with memblock.
+ * Reason is that arch_kfence_init_pool() gets called when the system
+ * is still in a limbo state - disabling and enabling bottom halves is
+ * not yet allowed, but that is what our page_table_alloc() would do.
+ */
+static __always_inline void kfence_split_mapping(void)
+{
+#ifdef CONFIG_KFENCE
+	unsigned long pool_pages = KFENCE_POOL_SIZE >> PAGE_SHIFT;
+
+	set_memory_4k((unsigned long)__kfence_pool, pool_pages);
+#endif
+}
+
+static inline bool kfence_protect_page(unsigned long addr, bool protect)
+{
+	__kernel_map_pages(virt_to_page(addr), 1, !protect);
+	return true;
+}
+
+#endif /* _ASM_S390_KFENCE_H */
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index e33c43b38afe..52d82410486e 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -31,6 +31,7 @@
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
 #include <linux/hugetlb.h>
+#include <linux/kfence.h>
 #include <asm/asm-offsets.h>
 #include <asm/diag.h>
 #include <asm/gmap.h>
@@ -356,6 +357,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	unsigned long address;
 	unsigned int flags;
 	vm_fault_t fault;
+	bool is_write;
 
 	tsk = current;
 	/*
@@ -369,6 +371,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 
 	mm = tsk->mm;
 	trans_exc_code = regs->int_parm_long;
+	address = trans_exc_code & __FAIL_ADDR_MASK;
+	is_write = (trans_exc_code & store_indication) == 0x400;
 
 	/*
 	 * Verify that the fault happened in user space, that
@@ -379,6 +383,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	type = get_fault_type(regs);
 	switch (type) {
 	case KERNEL_FAULT:
+		if (kfence_handle_page_fault(address, is_write, regs))
+			return 0;
 		goto out;
 	case USER_FAULT:
 	case GMAP_FAULT:
@@ -387,12 +393,11 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 		break;
 	}
 
-	address = trans_exc_code & __FAIL_ADDR_MASK;
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	flags = FAULT_FLAG_DEFAULT;
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
-	if (access == VM_WRITE || (trans_exc_code & store_indication) == 0x400)
+	if (access == VM_WRITE || is_write)
 		flags |= FAULT_FLAG_WRITE;
 	mmap_read_lock(mm);
 
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 8ac710de1ab1..f3db3caa8447 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -34,6 +34,7 @@
 #include <asm/processor.h>
 #include <linux/uaccess.h>
 #include <asm/pgalloc.h>
+#include <asm/kfence.h>
 #include <asm/ptdump.h>
 #include <asm/dma.h>
 #include <asm/lowcore.h>
@@ -200,7 +201,7 @@ void __init mem_init(void)
         high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
 	pv_init();
-
+	kfence_split_mapping();
 	/* Setup guest page hinting */
 	cmma_init();
 
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index b09fd5c7f85f..550048843fd6 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -4,6 +4,7 @@
  * Author(s): Jan Glauber <jang@linux.vnet.ibm.com>
  */
 #include <linux/hugetlb.h>
+#include <linux/kfence.h>
 #include <linux/mm.h>
 #include <asm/cacheflush.h>
 #include <asm/facility.h>
@@ -324,7 +325,7 @@ int __set_memory(unsigned long addr, int numpages, unsigned long flags)
 	return change_page_attr(addr, addr + numpages * PAGE_SIZE, flags);
 }
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
+#if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
 
 static void ipte_range(pte_t *pte, unsigned long address, int nr)
 {
-- 
2.25.1

