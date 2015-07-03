Return-Path: <owner-linux-mm@kvack.org>
From: Dominik Dingel <dingel@linux.vnet.ibm.com>
Subject: [PATCH 2/4] Revert "s390/mm: make hugepages_supported a boot time decision"
Date: Fri,  3 Jul 2015 14:46:07 +0200
Message-Id: <1435927569-41132-3-git-send-email-dingel@linux.vnet.ibm.com>
In-Reply-To: <1435927569-41132-1-git-send-email-dingel@linux.vnet.ibm.com>
References: <1435927569-41132-1-git-send-email-dingel@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-mm@kvack.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This reverts commit bea41197ead3e03308bdd10c11db3ce91ae5c8ab.
---
 arch/s390/include/asm/page.h | 8 ++++----
 arch/s390/kernel/setup.c     | 2 --
 arch/s390/mm/pgtable.c       | 2 --
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 0844b78..53eacbd 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -17,10 +17,7 @@
 #define PAGE_DEFAULT_ACC	0
 #define PAGE_DEFAULT_KEY	(PAGE_DEFAULT_ACC << 4)
 
-#include <asm/setup.h>
-#ifndef __ASSEMBLY__
-
-extern unsigned int HPAGE_SHIFT;
+#define HPAGE_SHIFT	20
 #define HPAGE_SIZE	(1UL << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
@@ -30,6 +27,9 @@ extern unsigned int HPAGE_SHIFT;
 #define ARCH_HAS_PREPARE_HUGEPAGE
 #define ARCH_HAS_HUGEPAGE_CLEAR_FLUSH
 
+#include <asm/setup.h>
+#ifndef __ASSEMBLY__
+
 static inline void storage_key_init_range(unsigned long start, unsigned long end)
 {
 #if PAGE_DEFAULT_KEY
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index f7f027c..ca070d2 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -885,8 +885,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	setup_hwcaps();
 
-	HPAGE_SHIFT = MACHINE_HAS_HPAGE ? 20 : 0;
-
 	/*
 	 * Create kernel page tables and switch to virtual addressing.
 	 */
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 16154720..b33f661 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -31,8 +31,6 @@
 #define ALLOC_ORDER	2
 #define FRAG_MASK	0x03
 
-unsigned int HPAGE_SHIFT;
-
 unsigned long *crst_table_alloc(struct mm_struct *mm)
 {
 	struct page *page = alloc_pages(GFP_KERNEL, ALLOC_ORDER);
-- 
2.3.8

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
