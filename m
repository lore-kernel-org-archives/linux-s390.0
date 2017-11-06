From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 07/22] RFC: s390/mm: Transfer guest pmd protection to host
Date: Mon,  6 Nov 2017 23:29:45 +0100
Message-ID: <1510007400-42493-8-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

If we protect the guest pmd, i.e. for dirty tracking, we need to
transfer the protection to the host pmd which we copied when linking
to the guest.

If we don't, we might loose changed that on migration, as changes on
host side don't get tracked.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/mm/gmap.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 106 insertions(+), 13 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index d0d56f6..3054b413 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -14,6 +14,7 @@
 #include <linux/swapops.h>
 #include <linux/ksm.h>
 #include <linux/mman.h>
+#include <linux/hugetlb.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -934,6 +935,88 @@ static inline void gmap_pmd_op_end(struct gmap *gmap, pmd_t *pmdp)
 		spin_unlock(&gmap->guest_table_lock);
 }
 
+/**
+ * gmap_pmdp_transfer_prot - transfer protection of guest pmd to host pmd
+ * @mm: the memory context
+ * @address: the affected host virtual address
+ * @gpmdp: guest pmd ptr
+ * @hpmdp: host pmd ptr
+ *
+ * Transfers the protection from a guest pmd to the associated guest
+ * pmd. This has to be done with a plain idte to circumvent the gmap
+ * invalidation hooks in the standard invalidation functions provided
+ * by pgtable.c.
+ */
+static void gmap_pmdp_transfer_prot(struct mm_struct *mm, unsigned long addr,
+				    pmd_t *gpmdp, pmd_t *hpmdp)
+{
+	int gpmd_i, gpmd_p, hpmd_i, hpmd_p;
+	pmd_t new = *hpmdp;
+
+	hpmd_i = pmd_val(*hpmdp) & _SEGMENT_ENTRY_INVALID;
+	hpmd_p = pmd_val(*hpmdp) & _SEGMENT_ENTRY_PROTECT;
+	gpmd_i = pmd_val(*gpmdp) & _SEGMENT_ENTRY_INVALID;
+	gpmd_p = pmd_val(*gpmdp) & _SEGMENT_ENTRY_PROTECT;
+
+	/* Fastpath, change not needed. */
+	if (hpmd_i || (hpmd_p && gpmd_p) || (!gpmd_i && !gpmd_p))
+		return;
+
+	if (gpmd_p && !hpmd_p)
+		pmd_val(new) |= _SEGMENT_ENTRY_PROTECT;
+	if (!gpmd_i && !hpmd_i)
+		pmd_val(new) &= ~_SEGMENT_ENTRY_INVALID;
+
+	if (MACHINE_HAS_TLB_GUEST)
+		__pmdp_idte(addr, hpmdp,
+			    IDTE_GUEST_ASCE,
+			    mm->context.asce, IDTE_GLOBAL);
+	else if (MACHINE_HAS_IDTE)
+		__pmdp_idte(addr, hpmdp, 0, 0,
+			    IDTE_GLOBAL);
+	else
+		__pmdp_csp(hpmdp);
+	*hpmdp = new;
+}
+
+/**
+ * gmap_pmdp_force_prot - change access rights of a locked pmd
+ * @mm: pointer to the process mm_struct
+ * @addr: virtual address in the guest address space
+ * @pmdp: pointer to the page table entry
+ * @prot: indicates guest access rights: PROT_NONE, PROT_READ or PROT_WRITE
+ * @bits: software bit to set (e.g. for notification)
+ *
+ * Returns 0 if the access rights were changed and -EAGAIN if the current
+ * and requested access rights are incompatible.
+ */
+static int gmap_pmdp_force_prot(struct gmap *gmap, unsigned long addr,
+				pmd_t *pmdp, int prot, unsigned long bits)
+{
+	int pmd_i, pmd_p;
+	pmd_t new = *pmdp;
+
+	pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
+	pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
+
+	/* Fixup needed */
+	if ((pmd_i && (prot != PROT_NONE)) || (pmd_p && (prot == PROT_WRITE)))
+		return -EAGAIN;
+
+	if (prot == PROT_NONE && !pmd_i) {
+		pmd_val(new) |= _SEGMENT_ENTRY_INVALID;
+		gmap_pmdp_xchg(gmap, pmdp, new, addr);
+	}
+
+	if (prot == PROT_READ && !pmd_p) {
+		pmd_val(new) &= ~_SEGMENT_ENTRY_INVALID;
+		pmd_val(new) |= _SEGMENT_ENTRY_PROTECT;
+		gmap_pmdp_xchg(gmap, pmdp, new, addr);
+	}
+	pmd_val(*pmdp) |=  bits;
+	return 0;
+}
+
 /*
  * gmap_protect_pte - remove access rights to memory and set pgste bits
  * @gmap: pointer to guest mapping meta data structure
@@ -990,20 +1073,23 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
  * guest_table_lock held.
  */
 static int gmap_protect_large(struct gmap *gmap, unsigned long gaddr,
-			      pmd_t *pmdp, int prot, unsigned long bits)
+			      unsigned long vmaddr, pmd_t *pmdp, pmd_t *hpmdp,
+			      int prot, unsigned long bits)
 {
-	int pmd_i, pmd_p;
+	unsigned long sbits = 0;
+	int ret = 0;
 
-	pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
-	pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
+	sbits |= (bits & GMAP_ENTRY_IN) ? _SEGMENT_ENTRY_GMAP_IN : 0;
+	/* Protect gmap pmd */
+	ret = gmap_pmdp_force_prot(gmap, gaddr, pmdp, prot, sbits);
+	/*
+	 * Transfer protection back to the host pmd, so userspace has
+	 * never more access rights than the VM.
+	 */
+	if (!ret)
+		gmap_pmdp_transfer_prot(gmap->mm, vmaddr, pmdp, hpmdp);
 
-	/* Fixup needed */
-	if ((pmd_i && (prot != PROT_NONE)) || (pmd_p && (prot & PROT_WRITE)))
-		return -EAGAIN;
-
-	if (bits & GMAP_ENTRY_IN)
-		pmd_val(*pmdp) |=  _SEGMENT_ENTRY_GMAP_IN;
-	return 0;
+	return ret;
 }
 
 /*
@@ -1024,12 +1110,18 @@ static int gmap_protect_large(struct gmap *gmap, unsigned long gaddr,
 static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
 {
+	spinlock_t *ptl;
 	unsigned long vmaddr;
-	pmd_t *pmdp;
+	pmd_t *pmdp, *hpmdp;
 	int rc;
 
 	while (len) {
 		rc = -EAGAIN;
+		vmaddr = __gmap_translate(gmap, gaddr);
+		hpmdp = (pmd_t *)huge_pte_offset(gmap->mm, vmaddr, HPAGE_SIZE);
+		/* Do we need tests here? */
+		ptl = pmd_lock(gmap->mm, hpmdp);
+
 		pmdp = gmap_pmd_op_walk(gmap, gaddr);
 		if (pmdp) {
 			if (!pmd_large(*pmdp)) {
@@ -1040,7 +1132,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 					gaddr += PAGE_SIZE;
 				}
 			} else {
-				rc =  gmap_protect_large(gmap, gaddr, pmdp,
+				rc =  gmap_protect_large(gmap, gaddr, vmaddr, pmdp, hpmdp,
 							 prot, bits);
 				if (!rc) {
 					len = len < HPAGE_SIZE ? 0 : len - HPAGE_SIZE;
@@ -1049,6 +1141,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			}
 			gmap_pmd_op_end(gmap, pmdp);
 		}
+		spin_unlock(ptl);
 		if (rc) {
 			vmaddr = __gmap_translate(gmap, gaddr);
 			if (IS_ERR_VALUE(vmaddr))
-- 
2.7.4
