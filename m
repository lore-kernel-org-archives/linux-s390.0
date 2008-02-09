Return-Path: <linux-kernel-owner+w=401wt.eu-S1758606AbYBIMFK@vger.kernel.org>
Message-Id: <20080209120308.269844869@de.ibm.com>
References: <20080209120157.885371603@de.ibm.com>
Date: Sat, 09 Feb 2008 13:02:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/11] VMEM_MAX_PHYS overflow on 31 bit.
Content-Disposition: inline; filename=005-overflow.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

With the new space saving spinlock_t and a non-debug configuration
the struct page only has 32 bytes for 31 bit s390. The causes an
overflow in the calculation of VMEM_MAX_PHYS which renders the
kernel unbootable.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/pgtable.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: quilt-2.6/include/asm-s390/pgtable.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgtable.h
+++ quilt-2.6/include/asm-s390/pgtable.h
@@ -127,8 +127,9 @@ extern char empty_zero_page[PAGE_SIZE];
  * mapping. This needs to be calculated at compile time since the size of the
  * VMEM_MAP is static but the size of struct page can change.
  */
-#define VMEM_MAX_PHYS	min(VMALLOC_START, ((VMEM_MAP_END - VMALLOC_END) / \
-			  sizeof(struct page) * PAGE_SIZE) & ~((16 << 20) - 1))
+#define VMEM_MAX_PAGES	((VMEM_MAP_END - VMALLOC_END) / sizeof(struct page))
+#define VMEM_MAX_PFN	min(VMALLOC_START >> PAGE_SHIFT, VMEM_MAX_PAGES)
+#define VMEM_MAX_PHYS	((VMEM_MAX_PFN << PAGE_SHIFT) & ~((16 << 20) - 1))
 #define VMEM_MAP	((struct page *) VMALLOC_END)
 
 /*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
