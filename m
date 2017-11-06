From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 01/22] s390/mm: make gmap_protect_range more modular
Date: Mon,  6 Nov 2017 23:29:39 +0100
Message-ID: <1510007400-42493-2-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This patch reworks the gmap_protect_range logic and extracts the pte
handling into an own function. Also we do now walk to the pmd and make
it accessible in the function for later use. This way we can add huge
page handling logic more easily.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/mm/gmap.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 95 insertions(+), 9 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 2f66290..9757242 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -876,6 +876,91 @@ static void gmap_pte_op_end(spinlock_t *ptl)
 	spin_unlock(ptl);
 }
 
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
+	spin_lock(&gmap->guest_table_lock);
+	pmdp = (pmd_t *) gmap_table_walk(gmap, gaddr, 1);
+
+	/*
+	 * Empty pmds can become large after we give up the
+	 * guest_table_lock, so we have to check for pmd_none
+	 * here.
+	 */
+	if (!pmdp || pmd_none(*pmdp)) {
+		spin_unlock(&gmap->guest_table_lock);
+		return NULL;
+	}
+	/*
+	 * For plain 4k guests that do not run under the vsie it
+	 * suffices to take the pte lock later on. Thus we can unlock
+	 * the guest_table_lock here.
+	 */
+	if (!pmd_large(*pmdp) && !gmap_is_shadow(gmap))
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
+	if (pmd_large(*pmdp) || gmap_is_shadow(gmap))
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
+ * Expected to be called with sg->mm->mmap_sem in read and
+ * guest_table_lock held for shadow gmaps.
+ */
+static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
+			    pmd_t *pmdp, int prot, unsigned long bits)
+{
+	int rc;
+	pte_t *ptep;
+	spinlock_t *ptl = NULL;
+
+	/* We have no upper segment, let's go back and fix this up. */
+	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
+		return -EAGAIN;
+
+	if (gmap_is_shadow(gmap)) {
+		ptep = pte_offset_map(pmdp, gaddr);
+	} else {
+		ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
+		if (!ptep)
+			return -ENOMEM;
+	}
+
+	/* Protect and unlock. */
+	rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, bits);
+	if (ptl)
+		gmap_pte_op_end(ptl);
+	return rc;
+}
+
 /*
  * gmap_protect_range - remove access rights to memory and set pgste bits
  * @gmap: pointer to guest mapping meta data structure
@@ -895,16 +980,20 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
 {
 	unsigned long vmaddr;
-	spinlock_t *ptl;
-	pte_t *ptep;
+	pmd_t *pmdp;
 	int rc;
 
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
@@ -913,10 +1002,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
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
2.7.4
