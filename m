Return-Path: <linux-kernel-owner+w=401wt.eu-S1756695AbZKMPUD@vger.kernel.org>
Message-Id: <20091113150913.579633730@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:48 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 24/52] [PATCH] s390: use change recording override for kernel mapping
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=123-dirty-override.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

We dont need the dirty bit if a write access is done via the kernel
mapping. In that case SetPageDirty and friends are used anyway, no
need to do that a second time. We can use the change-recording
overide function for the kernel mapping, if available.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/pgtable.h |    4 +++-
 arch/s390/mm/vmem.c             |   11 ++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/pgtable.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/pgtable.h	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/pgtable.h	2009-11-13 16:08:17.000000000 +0100
@@ -169,12 +169,13 @@
  * STL Segment-Table-Length:  Segment-table length (STL+1*16 entries -> up to 2048)
  *
  * A 64 bit pagetable entry of S390 has following format:
- * |                     PFRA                         |0IP0|  OS  |
+ * |			 PFRA			      |0IPC|  OS  |
  * 0000000000111111111122222222223333333333444444444455555555556666
  * 0123456789012345678901234567890123456789012345678901234567890123
  *
  * I Page-Invalid Bit:    Page is not available for address-translation
  * P Page-Protection Bit: Store access not possible for page
+ * C Change-bit override: HW is not required to set change bit
  *
  * A 64 bit segmenttable entry of S390 has following format:
  * |        P-table origin                              |      TT
@@ -218,6 +219,7 @@
  */
 
 /* Hardware bits in the page table entry */
+#define _PAGE_CO	0x100		/* HW Change-bit override */
 #define _PAGE_RO	0x200		/* HW read-only bit  */
 #define _PAGE_INVALID	0x400		/* HW invalid bit    */
 
Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c	2009-11-13 15:48:32.000000000 +0100
+++ quilt-2.6/arch/s390/mm/vmem.c	2009-11-13 16:08:17.000000000 +0100
@@ -70,8 +70,12 @@
 		pte = alloc_bootmem(PTRS_PER_PTE * sizeof(pte_t));
 	if (!pte)
 		return NULL;
-	clear_table((unsigned long *) pte, _PAGE_TYPE_EMPTY,
-		    PTRS_PER_PTE * sizeof(pte_t));
+	if (MACHINE_HAS_HPAGE)
+		clear_table((unsigned long *) pte, _PAGE_TYPE_EMPTY | _PAGE_CO,
+			    PTRS_PER_PTE * sizeof(pte_t));
+	else
+		clear_table((unsigned long *) pte, _PAGE_TYPE_EMPTY,
+			    PTRS_PER_PTE * sizeof(pte_t));
 	return pte;
 }
 
@@ -112,7 +116,8 @@
 		if (MACHINE_HAS_HPAGE && !(address & ~HPAGE_MASK) &&
 		    (address + HPAGE_SIZE <= start + size) &&
 		    (address >= HPAGE_SIZE)) {
-			pte_val(pte) |= _SEGMENT_ENTRY_LARGE;
+			pte_val(pte) |= _SEGMENT_ENTRY_LARGE |
+					_SEGMENT_ENTRY_CO;
 			pmd_val(*pm_dir) = pte_val(pte);
 			address += HPAGE_SIZE - PAGE_SIZE;
 			continue;
