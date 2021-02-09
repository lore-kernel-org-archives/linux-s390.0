Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232137AbhBIOzL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 09:55:11 -0500
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v1 2/4] s390x: lib: fix and improve pgtable.h
Date: Tue,  9 Feb 2021 15:38:33 +0100
Message-Id: <20210209143835.1031617-3-imbrenda@linux.ibm.com>
In-Reply-To: <20210209143835.1031617-1-imbrenda@linux.ibm.com>
References: <20210209143835.1031617-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, frankja@linux.ibm.com, cohuck@redhat.com, pmorel@linux.ibm.com

Fix and improve pgtable.h:

* SEGMENT_ENTRY_SFAA had one extra bit set
* pmd entries don't have a length
* ipte does not need to clear the lower bits
* add macros to check whether a pmd or a pud are large / huge
* add idte functions for pmd, pud, p4d and pgd

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 lib/s390x/asm/pgtable.h | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/lib/s390x/asm/pgtable.h b/lib/s390x/asm/pgtable.h
index 277f3480..4269ab62 100644
--- a/lib/s390x/asm/pgtable.h
+++ b/lib/s390x/asm/pgtable.h
@@ -60,7 +60,7 @@
 #define SEGMENT_SHIFT			20
 
 #define SEGMENT_ENTRY_ORIGIN		0xfffffffffffff800UL
-#define SEGMENT_ENTRY_SFAA		0xfffffffffff80000UL
+#define SEGMENT_ENTRY_SFAA		0xfffffffffff00000UL
 #define SEGMENT_ENTRY_AV		0x0000000000010000UL
 #define SEGMENT_ENTRY_ACC		0x000000000000f000UL
 #define SEGMENT_ENTRY_F			0x0000000000000800UL
@@ -100,6 +100,9 @@
 #define pmd_none(entry) (pmd_val(entry) & SEGMENT_ENTRY_I)
 #define pte_none(entry) (pte_val(entry) & PAGE_ENTRY_I)
 
+#define pud_huge(entry)  (pud_val(entry) & REGION3_ENTRY_FC)
+#define pmd_large(entry) (pmd_val(entry) & SEGMENT_ENTRY_FC)
+
 #define pgd_addr(entry) __va(pgd_val(entry) & REGION_ENTRY_ORIGIN)
 #define p4d_addr(entry) __va(p4d_val(entry) & REGION_ENTRY_ORIGIN)
 #define pud_addr(entry) __va(pud_val(entry) & REGION_ENTRY_ORIGIN)
@@ -202,21 +205,48 @@ static inline pte_t *pte_alloc(pmd_t *pmd, unsigned long addr)
 {
 	if (pmd_none(*pmd)) {
 		pte_t *pte = pte_alloc_one();
-		pmd_val(*pmd) = __pa(pte) | SEGMENT_ENTRY_TT_SEGMENT |
-				SEGMENT_TABLE_LENGTH;
+		pmd_val(*pmd) = __pa(pte) | SEGMENT_ENTRY_TT_SEGMENT;
 	}
 	return pte_offset(pmd, addr);
 }
 
 static inline void ipte(unsigned long vaddr, pteval_t *p_pte)
 {
-	unsigned long table_origin = (unsigned long)p_pte & PAGE_MASK;
+	unsigned long table_origin = (unsigned long)p_pte;
 
 	asm volatile(
 		"	ipte %0,%1\n"
 		: : "a" (table_origin), "a" (vaddr) : "memory");
 }
 
+static inline void idte(unsigned long table_origin, unsigned long vaddr)
+{
+	vaddr &= SEGMENT_ENTRY_SFAA;
+	asm volatile(
+		"	idte %0,0,%1\n"
+		: : "a" (table_origin), "a" (vaddr) : "memory");
+}
+
+static inline void idte_pmdp(unsigned long vaddr, pmdval_t *pmdp)
+{
+	idte((unsigned long)(pmdp - pmd_index(vaddr)) | ASCE_DT_SEGMENT, vaddr);
+}
+
+static inline void idte_pudp(unsigned long vaddr, pudval_t *pudp)
+{
+	idte((unsigned long)(pudp - pud_index(vaddr)) | ASCE_DT_REGION3, vaddr);
+}
+
+static inline void idte_p4dp(unsigned long vaddr, p4dval_t *p4dp)
+{
+	idte((unsigned long)(p4dp - p4d_index(vaddr)) | ASCE_DT_REGION2, vaddr);
+}
+
+static inline void idte_pgdp(unsigned long vaddr, pgdval_t *pgdp)
+{
+	idte((unsigned long)(pgdp - pgd_index(vaddr)) | ASCE_DT_REGION1, vaddr);
+}
+
 void configure_dat(int enable);
 
 #endif /* _ASMS390X_PGTABLE_H_ */
-- 
2.26.2
