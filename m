From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v2 07/22] RFC: s390/mm: Transfer guest pmd protection to host
Date: Wed, 13 Dec 2017 13:53:18 +0100
Message-ID: <1513169613-13509-8-git-send-email-frankja@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
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
 arch/s390/mm/gmap.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 103 insertions(+), 12 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index a252fe7..dfa3a0d 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -15,6 +15,7 @@
 #include <linux/swapops.h>
 #include <linux/ksm.h>
 #include <linux/mman.h>
+#include <linux/hugetlb.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -934,6 +935,84 @@ static inline void gmap_pmd_op_end(struct gmap *gmap, pmd_t *pmdp)
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
+	const int gpmd_i = pmd_val(*gpmdp) & _SEGMENT_ENTRY_INVALID;
+	const int gpmd_p = pmd_val(*gpmdp) & _SEGMENT_ENTRY_PROTECT;
+	const int hpmd_i = pmd_val(*hpmdp) & _SEGMENT_ENTRY_INVALID;
+	const int hpmd_p = pmd_val(*hpmdp) & _SEGMENT_ENTRY_PROTECT;
+	pmd_t new = *hpmdp;
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
+			    IDTE_NODAT | IDTE_GUEST_ASCE,
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
+	int pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
+	int pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
+	pmd_t new = *pmdp;
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
@@ -985,18 +1064,23 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
  * guest_table_lock held.
  */
 static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
-			    pmd_t *pmdp, int prot, unsigned long bits)
+			    unsigned long vmaddr, pmd_t *pmdp, pmd_t *hpmdp,
+			    int prot, unsigned long bits)
 {
-	const int pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
-	const int pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
+	unsigned long sbits = 0;
+	int ret = 0;
 
-	/* Fixup needed */
-	if ((pmd_i && (prot != PROT_NONE)) || (pmd_p && (prot & PROT_WRITE)))
-		return -EAGAIN;
+	sbits |= (bits & GMAP_NOTIFY_MPROT) ? _SEGMENT_ENTRY_GMAP_IN : 0;
+	/* Protect gmap pmd */
+	ret = gmap_pmdp_force_prot(gmap, gaddr, pmdp, prot, sbits);
+	/*
+	 * Transfer protection back to the host pmd, so userspace has
+	 * never more access rights than the VM.
+	 */
+	if (!ret)
+		gmap_pmdp_transfer_prot(gmap->mm, vmaddr, pmdp, hpmdp);
 
-	if (bits & GMAP_NOTIFY_MPROT)
-		pmd_val(*pmdp) |=  _SEGMENT_ENTRY_GMAP_IN;
-	return 0;
+	return ret;
 }
 
 /*
@@ -1017,12 +1101,18 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
 static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
 {
+	spinlock_t *ptl;
 	unsigned long vmaddr, dist;
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
@@ -1033,8 +1123,8 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 					gaddr += PAGE_SIZE;
 				}
 			} else {
-				rc = gmap_protect_pmd(gmap, gaddr, pmdp, prot,
-						      bits);
+				rc =  gmap_protect_pmd(gmap, gaddr, vmaddr,
+						       pmdp, hpmdp, prot, bits);
 				if (!rc) {
 					dist = HPAGE_SIZE - (gaddr & ~HPAGE_MASK);
 					len = len < dist ? 0 : len - dist;
@@ -1043,6 +1133,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			}
 			gmap_pmd_op_end(gmap, pmdp);
 		}
+		spin_unlock(ptl);
 		if (rc) {
 			vmaddr = __gmap_translate(gmap, gaddr);
 			if (IS_ERR_VALUE(vmaddr))
-- 
2.7.4
