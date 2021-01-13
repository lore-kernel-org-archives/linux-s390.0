Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727376AbhAMJmY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:24 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 08/14] s390/mm: Make gmap_read_table EDAT1 compatible
Date: Wed, 13 Jan 2021 09:41:07 +0000
Message-Id: <20210113094113.133668-9-frankja@linux.ibm.com>
In-Reply-To: <20210113094113.133668-1-frankja@linux.ibm.com>
References: <20210113094113.133668-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

For the upcoming support of VSIE guests on huge page backed hosts, we
need to be able to read from large segments.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index f89e710c31af..910371dc511d 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1282,35 +1282,44 @@ EXPORT_SYMBOL_GPL(gmap_mprotect_notify);
 int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
 {
 	unsigned long address, vmaddr;
-	spinlock_t *ptl;
+	spinlock_t *ptl_pmd = NULL, *ptl_pte = NULL;
+	pmd_t *pmdp;
 	pte_t *ptep, pte;
 	int rc;
 
-	if (gmap_is_shadow(gmap))
-		return -EINVAL;
+	BUG_ON(gmap_is_shadow(gmap));
 
 	while (1) {
 		rc = -EAGAIN;
-		ptep = gmap_pte_op_walk(gmap, gaddr, &ptl);
-		if (ptep) {
-			pte = *ptep;
-			if (pte_present(pte) && (pte_val(pte) & _PAGE_READ)) {
-				address = pte_val(pte) & PAGE_MASK;
-				address += gaddr & ~PAGE_MASK;
+		vmaddr = __gmap_translate(gmap, gaddr);
+		if (IS_ERR_VALUE(vmaddr))
+			return vmaddr;
+		pmdp = gmap_pmd_op_walk(gmap, gaddr, vmaddr, &ptl_pmd);
+		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
+			if (!pmd_large(*pmdp)) {
+				ptep = gmap_pte_from_pmd(gmap, pmdp, vmaddr, &ptl_pte);
+				if (ptep) {
+					pte = *ptep;
+					if (pte_present(pte) && (pte_val(pte) & _PAGE_READ)) {
+						address = pte_val(pte) & PAGE_MASK;
+						address += gaddr & ~PAGE_MASK;
+						*val = *(unsigned long *) address;
+						pte_val(*ptep) |= _PAGE_YOUNG;
+						/* Do *NOT* clear the _PAGE_INVALID bit! */
+						rc = 0;
+					}
+				}
+				gmap_pte_op_end(ptl_pte);
+			} else {
+				address = pmd_val(*pmdp) & HPAGE_MASK;
+				address += gaddr & ~HPAGE_MASK;
 				*val = *(unsigned long *) address;
-				pte_val(*ptep) |= _PAGE_YOUNG;
-				/* Do *NOT* clear the _PAGE_INVALID bit! */
 				rc = 0;
 			}
-			gmap_pte_op_end(ptl);
+			gmap_pmd_op_end(ptl_pmd);
 		}
 		if (!rc)
 			break;
-		vmaddr = __gmap_translate(gmap, gaddr);
-		if (IS_ERR_VALUE(vmaddr)) {
-			rc = vmaddr;
-			break;
-		}
 		rc = gmap_fixup(gmap, gaddr, vmaddr, PROT_READ);
 		if (rc)
 			break;
-- 
2.27.0
