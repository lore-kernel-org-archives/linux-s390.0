Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF347C433B4
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 04:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A857461437
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 04:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhEJEgR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 10 May 2021 00:36:17 -0400
Received: from foss.arm.com ([217.140.110.172]:47316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhEJEgR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 May 2021 00:36:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6D641FB;
        Sun,  9 May 2021 21:35:12 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.77.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 965E63F718;
        Sun,  9 May 2021 21:35:09 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/thp: Make ARCH_ENABLE_SPLIT_PMD_PTLOCK dependent on PGTABLE_LEVELS > 2
Date:   Mon, 10 May 2021 10:05:45 +0530
Message-Id: <1620621345-29176-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

ARCH_ENABLE_SPLIT_PMD_PTLOCK is irrelevant unless there are two page table
levels including PMD (also per Documentation/vm/split_page_table_lock.rst).
Make this dependency explicit on remaining platforms i.e x86 and s390 where
ARCH_ENABLE_SPLIT_PMD_PTLOCK is subscribed.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/s390/Kconfig | 2 +-
 arch/x86/Kconfig  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b4c7c34069f8..fcc1ea339a9d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -62,7 +62,7 @@ config S390
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
-	select ARCH_ENABLE_SPLIT_PMD_PTLOCK
+	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b44190..ec9e9d3d7e3f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -63,7 +63,7 @@ config X86
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64 || (X86_32 && HIGHMEM)
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
-	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if X86_64 || X86_PAE
+	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if (PGTABLE_LEVELS > 2) && (X86_64 || X86_PAE)
 	select ARCH_ENABLE_THP_MIGRATION if X86_64 && TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CACHE_LINE_SIZE
-- 
2.20.1

