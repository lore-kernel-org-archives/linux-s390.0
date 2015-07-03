Return-Path: <owner-linux-mm@kvack.org>
From: Dominik Dingel <dingel@linux.vnet.ibm.com>
Subject: [PATCH 1/4] Revert "s390/mm: change HPAGE_SHIFT type to int"
Date: Fri,  3 Jul 2015 14:46:06 +0200
Message-Id: <1435927569-41132-2-git-send-email-dingel@linux.vnet.ibm.com>
In-Reply-To: <1435927569-41132-1-git-send-email-dingel@linux.vnet.ibm.com>
References: <1435927569-41132-1-git-send-email-dingel@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-mm@kvack.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This reverts commit cf54e2fce51c7ad2479fe8cf213a2ed618a8189b.
---
 arch/s390/include/asm/page.h | 2 +-
 arch/s390/mm/pgtable.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index dd34523..0844b78 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -20,7 +20,7 @@
 #include <asm/setup.h>
 #ifndef __ASSEMBLY__
 
-extern int HPAGE_SHIFT;
+extern unsigned int HPAGE_SHIFT;
 #define HPAGE_SIZE	(1UL << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 33082d0..16154720 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -31,7 +31,7 @@
 #define ALLOC_ORDER	2
 #define FRAG_MASK	0x03
 
-int HPAGE_SHIFT;
+unsigned int HPAGE_SHIFT;
 
 unsigned long *crst_table_alloc(struct mm_struct *mm)
 {
-- 
2.3.8

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
