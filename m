From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 19 Sep 2018 08:47:56 +0000
Subject: [RFC 08/14] s390/mm: Make gmap_read_table EDAT1 compatible
Message-Id: <20180919084802.183381-9-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

For the upcoming support of VSIE guests on huge page backed hosts, we
need to be able to read from large segments.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 26cc6ce19afb..ba0425f1c2c0 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1274,35 +1274,44 @@ EXPORT_SYMBOL_GPL(gmap_mprotect_notify);
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
2.14.3
