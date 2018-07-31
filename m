From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:43:53 +0000
Subject: [GIT PULL 07/19] s390/mm: Abstract gmap notify bit setting
Message-Id: <20180731084405.28953-8-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

Currently we use the software PGSTE bits PGSTE_IN_BIT and
PGSTE_VSIE_BIT to notify before an invalidation occurs on a prefix
page or a VSIE page respectively. Both bits are pgste specific, but
are used when protecting a memory range.

Let's introduce abstract GMAP_NOTIFY_* bits that will be realized into
the respective bits when gmap DAT table entries are protected.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/gmap.h |  4 ++++
 arch/s390/mm/gmap.c          | 11 +++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index e07cce88dfb0..c1bc5633fc6e 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -9,6 +9,10 @@
 #ifndef _ASM_S390_GMAP_H
 #define _ASM_S390_GMAP_H
 
+/* Generic bits for GMAP notification on DAT table entry changes. */
+#define GMAP_NOTIFY_SHADOW	0x2
+#define GMAP_NOTIFY_MPROT	0x1
+
 /**
  * struct gmap_struct - guest address space
  * @list: list head for the mm->context gmap list
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 71b0e9ca0137..0bada5e097cb 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -912,7 +912,7 @@ static inline void gmap_pmd_op_end(struct gmap *gmap, pmd_t *pmdp)
  * @gaddr: virtual address in the guest address space
  * @pmdp: pointer to the pmd associated with the pte
  * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
- * @bits: pgste notification bits to set
+ * @bits: notification bits to set
  *
  * Returns 0 if successfully protected, -ENOMEM if out of memory and
  * -EAGAIN if a fixup is needed.
@@ -925,6 +925,7 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 	int rc;
 	pte_t *ptep;
 	spinlock_t *ptl = NULL;
+	unsigned long pbits = 0;
 
 	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
 		return -EAGAIN;
@@ -933,8 +934,10 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 	if (!ptep)
 		return -ENOMEM;
 
+	pbits |= (bits & GMAP_NOTIFY_MPROT) ? PGSTE_IN_BIT : 0;
+	pbits |= (bits & GMAP_NOTIFY_SHADOW) ? PGSTE_VSIE_BIT : 0;
 	/* Protect and unlock. */
-	rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, bits);
+	rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, pbits);
 	gmap_pte_op_end(ptl);
 	return rc;
 }
@@ -1008,7 +1011,7 @@ int gmap_mprotect_notify(struct gmap *gmap, unsigned long gaddr,
 	if (!MACHINE_HAS_ESOP && prot == PROT_READ)
 		return -EINVAL;
 	down_read(&gmap->mm->mmap_sem);
-	rc = gmap_protect_range(gmap, gaddr, len, prot, PGSTE_IN_BIT);
+	rc = gmap_protect_range(gmap, gaddr, len, prot, GMAP_NOTIFY_MPROT);
 	up_read(&gmap->mm->mmap_sem);
 	return rc;
 }
@@ -1599,7 +1602,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 	down_read(&parent->mm->mmap_sem);
 	rc = gmap_protect_range(parent, asce & _ASCE_ORIGIN,
 				((asce & _ASCE_TABLE_LENGTH) + 1) * PAGE_SIZE,
-				PROT_READ, PGSTE_VSIE_BIT);
+				PROT_READ, GMAP_NOTIFY_SHADOW);
 	up_read(&parent->mm->mmap_sem);
 	spin_lock(&parent->shadow_lock);
 	new->initialized = true;
-- 
2.17.0
