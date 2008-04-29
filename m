Return-Path: <linux-kernel-owner+w=401wt.eu-S1763670AbYD2OSp@vger.kernel.org>
Message-Id: <20080429140251.497575262@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/15] vmemmap: use clear_table to initialise page tables.
Content-Disposition: inline; filename=012-clear_table.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Always use clear_table to initialise page tables. The overlapping
memcpy is just a leftover of a previous version that wasn't fully
converted to clear_table.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/vmem.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -77,8 +77,7 @@ static inline pud_t *vmem_pud_alloc(void
 	pud = vmem_alloc_pages(2);
 	if (!pud)
 		return NULL;
-	pud_val(*pud) = _REGION3_ENTRY_EMPTY;
-	memcpy(pud + 1, pud, (PTRS_PER_PUD - 1)*sizeof(pud_t));
+	clear_table((unsigned long *) pud, _REGION3_ENTRY_EMPTY, PAGE_SIZE * 4);
 #endif
 	return pud;
 }
@@ -91,7 +90,7 @@ static inline pmd_t *vmem_pmd_alloc(void
 	pmd = vmem_alloc_pages(2);
 	if (!pmd)
 		return NULL;
-	clear_table((unsigned long *) pmd, _SEGMENT_ENTRY_EMPTY, PAGE_SIZE*4);
+	clear_table((unsigned long *) pmd, _SEGMENT_ENTRY_EMPTY, PAGE_SIZE * 4);
 #endif
 	return pmd;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
