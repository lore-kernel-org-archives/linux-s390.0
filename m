From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:43:52 +0000
Subject: [GIT PULL 06/19] s390/mm: Make gmap_protect_range more modular
Message-Id: <20180731084405.28953-7-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

This patch reworks the gmap_protect_range logic and extracts the pte
handling into an own function. Also we do now walk to the pmd and make
it accessible in the function for later use. This way we can add huge
page handling logic more easily.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/mm/gmap.c | 93 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 10 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index bc56ec8abcf7..71b0e9ca0137 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -864,7 +864,79 @@ static int gmap_pte_op_fixup(struct gmap *gmap, unsigned long gaddr,
  */
 static void gmap_pte_op_end(spinlock_t *ptl)
 {
-	spin_unlock(ptl);
+	if (ptl)
+		spin_unlock(ptl);
+}
+
+/**
+ * gmap_pmd_op_walk - walk the gmap tables, get the guest table lock
+ *		      and return the pmd pointer
+ * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: virtual address in the guest address space
+ *
+ * Returns a pointer to the pmd for a guest address, or NULL
+ */
+static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr)
+{
+	pmd_t *pmdp;
+
+	BUG_ON(gmap_is_shadow(gmap));
+	spin_lock(&gmap->guest_table_lock);
+	pmdp = (pmd_t *) gmap_table_walk(gmap, gaddr, 1);
+
+	if (!pmdp || pmd_none(*pmdp)) {
+		spin_unlock(&gmap->guest_table_lock);
+		return NULL;
+	}
+
+	/* 4k page table entries are locked via the pte (pte_alloc_map_lock). */
+	if (!pmd_large(*pmdp))
+		spin_unlock(&gmap->guest_table_lock);
+	return pmdp;
+}
+
+/**
+ * gmap_pmd_op_end - release the guest_table_lock if needed
+ * @gmap: pointer to the guest mapping meta data structure
+ * @pmdp: pointer to the pmd
+ */
+static inline void gmap_pmd_op_end(struct gmap *gmap, pmd_t *pmdp)
+{
+	if (pmd_large(*pmdp))
+		spin_unlock(&gmap->guest_table_lock);
+}
+
+/*
+ * gmap_protect_pte - remove access rights to memory and set pgste bits
+ * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: virtual address in the guest address space
+ * @pmdp: pointer to the pmd associated with the pte
+ * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
+ * @bits: pgste notification bits to set
+ *
+ * Returns 0 if successfully protected, -ENOMEM if out of memory and
+ * -EAGAIN if a fixup is needed.
+ *
+ * Expected to be called with sg->mm->mmap_sem in read
+ */
+static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
+			    pmd_t *pmdp, int prot, unsigned long bits)
+{
+	int rc;
+	pte_t *ptep;
+	spinlock_t *ptl = NULL;
+
+	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
+		return -EAGAIN;
+
+	ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
+	if (!ptep)
+		return -ENOMEM;
+
+	/* Protect and unlock. */
+	rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, bits);
+	gmap_pte_op_end(ptl);
+	return rc;
 }
 
 /*
@@ -884,17 +956,21 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
 {
 	unsigned long vmaddr;
-	spinlock_t *ptl;
-	pte_t *ptep;
+	pmd_t *pmdp;
 	int rc;
 
 	BUG_ON(gmap_is_shadow(gmap));
 	while (len) {
 		rc = -EAGAIN;
-		ptep = gmap_pte_op_walk(gmap, gaddr, &ptl);
-		if (ptep) {
-			rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, bits);
-			gmap_pte_op_end(ptl);
+		pmdp = gmap_pmd_op_walk(gmap, gaddr);
+		if (pmdp) {
+			rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
+					      bits);
+			if (!rc) {
+				len -= PAGE_SIZE;
+				gaddr += PAGE_SIZE;
+			}
+			gmap_pmd_op_end(gmap, pmdp);
 		}
 		if (rc) {
 			vmaddr = __gmap_translate(gmap, gaddr);
@@ -903,10 +979,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr, prot);
 			if (rc)
 				return rc;
-			continue;
 		}
-		gaddr += PAGE_SIZE;
-		len -= PAGE_SIZE;
 	}
 	return 0;
 }
-- 
2.17.0
