From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:43:55 +0000
Subject: [GIT PULL 09/19] s390/mm: Add gmap pmd notification bit setting
Message-Id: <20180731084405.28953-10-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

Like for ptes, we also need invalidation notification for pmds, to
make sure the guest lowcore pages are always accessible and later
addition of shadowed pmds.

With PMDs we do not have PGSTEs or some other bits we could use in the
host PMD. Instead we pick one of the free bits in the gmap PMD. Every
time a host pmd will be invalidated, we will check if the respective
gmap PMD has the bit set and in that case fire up the notifier.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/gmap.h |  3 ++
 arch/s390/mm/gmap.c          | 60 ++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index c1bc5633fc6e..276268b48aff 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -13,6 +13,9 @@
 #define GMAP_NOTIFY_SHADOW	0x2
 #define GMAP_NOTIFY_MPROT	0x1
 
+/* Status bits only for huge segment entries */
+#define _SEGMENT_ENTRY_GMAP_IN		0x8000	/* invalidation notify bit */
+
 /**
  * struct gmap_struct - guest address space
  * @list: list head for the mm->context gmap list
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 870e81fcb0cf..96dd94d51ad4 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -911,6 +911,40 @@ static inline void gmap_pmd_op_end(struct gmap *gmap, pmd_t *pmdp)
 		spin_unlock(&gmap->guest_table_lock);
 }
 
+/*
+ * gmap_protect_pmd - remove access rights to memory and set pmd notification bits
+ * @pmdp: pointer to the pmd to be protected
+ * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
+ * @bits: notification bits to set
+ *
+ * Returns:
+ * 0 if successfully protected
+ * -EAGAIN if a fixup is needed
+ * -EINVAL if unsupported notifier bits have been specified
+ *
+ * Expected to be called with sg->mm->mmap_sem in read and
+ * guest_table_lock held.
+ */
+static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
+			    pmd_t *pmdp, int prot, unsigned long bits)
+{
+	int pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
+	int pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
+
+	/* Fixup needed */
+	if ((pmd_i && (prot != PROT_NONE)) || (pmd_p && (prot == PROT_WRITE)))
+		return -EAGAIN;
+
+	if (bits & GMAP_NOTIFY_MPROT)
+		pmd_val(*pmdp) |= _SEGMENT_ENTRY_GMAP_IN;
+
+	/* Shadow GMAP protection needs split PMDs */
+	if (bits & GMAP_NOTIFY_SHADOW)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * gmap_protect_pte - remove access rights to memory and set pgste bits
  * @gmap: pointer to guest mapping meta data structure
@@ -963,7 +997,7 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
 {
-	unsigned long vmaddr;
+	unsigned long vmaddr, dist;
 	pmd_t *pmdp;
 	int rc;
 
@@ -972,15 +1006,29 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 		rc = -EAGAIN;
 		pmdp = gmap_pmd_op_walk(gmap, gaddr);
 		if (pmdp) {
-			rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
-					      bits);
-			if (!rc) {
-				len -= PAGE_SIZE;
-				gaddr += PAGE_SIZE;
+			if (!pmd_large(*pmdp)) {
+				rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
+						      bits);
+				if (!rc) {
+					len -= PAGE_SIZE;
+					gaddr += PAGE_SIZE;
+				}
+			} else {
+				rc = gmap_protect_pmd(gmap, gaddr, pmdp, prot,
+						      bits);
+				if (!rc) {
+					dist = HPAGE_SIZE - (gaddr & ~HPAGE_MASK);
+					len = len < dist ? 0 : len - dist;
+					gaddr = (gaddr & HPAGE_MASK) + HPAGE_SIZE;
+				}
 			}
 			gmap_pmd_op_end(gmap, pmdp);
 		}
 		if (rc) {
+			if (rc == -EINVAL)
+				return rc;
+
+			/* -EAGAIN, fixup of userspace mm and gmap */
 			vmaddr = __gmap_translate(gmap, gaddr);
 			if (IS_ERR_VALUE(vmaddr))
 				return vmaddr;
-- 
2.17.0
