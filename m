Return-Path: <owner-linux-mm@kvack.org>
From: Dominik Dingel <dingel@linux.vnet.ibm.com>
Subject: [PATCH] s390/mm: change HPAGE_SHIFT type to int
Date: Thu, 25 Jun 2015 16:37:01 +0200
Message-Id: <1435243021-65315-1-git-send-email-dingel@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

With making HPAGE_SHIFT an unsigned integer we also accidentally changed pageblock_order.
In order to avoid compiler warnings we make HPAGE_SHFIT an int again.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
---
 arch/s390/include/asm/page.h | 2 +-
 arch/s390/mm/pgtable.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 0844b78..dd34523 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -20,7 +20,7 @@
 #include <asm/setup.h>
 #ifndef __ASSEMBLY__
 
-extern unsigned int HPAGE_SHIFT;
+extern int HPAGE_SHIFT;
 #define HPAGE_SIZE	(1UL << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index f76791e..1bae5dd 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -36,7 +36,7 @@
 #endif
 
 
-unsigned int HPAGE_SHIFT;
+int HPAGE_SHIFT;
 
 unsigned long *crst_table_alloc(struct mm_struct *mm)
 {
-- 
2.3.8

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
