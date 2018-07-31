From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:44:04 +0000
Subject: [GIT PULL 18/19] s390/mm: Add huge page gmap linking support
Message-Id: <20180731084405.28953-19-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

Let's allow huge pmd linking when enabled through the
KVM_CAP_S390_HPAGE_1M capability. Also we can now restrict gmap
invalidation and notification to the cases where the capability has
been activated and save some cycles when that's not the case.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/mmu.h         | 2 ++
 arch/s390/include/asm/mmu_context.h | 1 +
 arch/s390/mm/gmap.c                 | 9 ++++++---
 arch/s390/mm/pgtable.c              | 8 ++++----
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index f5ff9dbad8ac..f31a15044c24 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -24,6 +24,8 @@ typedef struct {
 	unsigned int uses_skeys:1;
 	/* The mmu context uses CMM. */
 	unsigned int uses_cmm:1;
+	/* The gmaps associated with this context are allowed to use huge pages. */
+	unsigned int allow_gmap_hpage_1m:1;
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(name)						   \
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index d16bc79c30bb..0717ee76885d 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -32,6 +32,7 @@ static inline int init_new_context(struct task_struct *tsk,
 	mm->context.has_pgste = 0;
 	mm->context.uses_skeys = 0;
 	mm->context.uses_cmm = 0;
+	mm->context.allow_gmap_hpage_1m = 0;
 #endif
 	switch (mm->context.asce_limit) {
 	case _REGION2_SIZE:
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 736ed32a83c5..bb44990c8212 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2,8 +2,10 @@
 /*
  *  KVM guest address space mapping code
  *
- *    Copyright IBM Corp. 2007, 2016
+ *    Copyright IBM Corp. 2007, 2016, 2018
  *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *		 David Hildenbrand <david@redhat.com>
+ *		 Janosch Frank <frankja@linux.vnet.ibm.com>
  */
 
 #include <linux/kernel.h>
@@ -588,8 +590,8 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 		return -EFAULT;
 	pmd = pmd_offset(pud, vmaddr);
 	VM_BUG_ON(pmd_none(*pmd));
-	/* large pmds cannot yet be handled */
-	if (pmd_large(*pmd))
+	/* Are we allowed to use huge pages? */
+	if (pmd_large(*pmd) && !gmap->mm->context.allow_gmap_hpage_1m)
 		return -EFAULT;
 	/* Link gmap segment table entry location to page table. */
 	rc = radix_tree_preload(GFP_KERNEL);
@@ -1632,6 +1634,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 	unsigned long limit;
 	int rc;
 
+	BUG_ON(parent->mm->context.allow_gmap_hpage_1m);
 	BUG_ON(gmap_is_shadow(parent));
 	spin_lock(&parent->shadow_lock);
 	sg = gmap_find_shadow(parent, asce, edat_level);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 37d68706f5aa..f2cc7da473e4 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -347,7 +347,7 @@ static inline void pmdp_idte_local(struct mm_struct *mm,
 			    mm->context.asce, IDTE_LOCAL);
 	else
 		__pmdp_idte(addr, pmdp, 0, 0, IDTE_LOCAL);
-	if (mm_has_pgste(mm))
+	if (mm_has_pgste(mm) && mm->context.allow_gmap_hpage_1m)
 		gmap_pmdp_idte_local(mm, addr);
 }
 
@@ -357,15 +357,15 @@ static inline void pmdp_idte_global(struct mm_struct *mm,
 	if (MACHINE_HAS_TLB_GUEST) {
 		__pmdp_idte(addr, pmdp, IDTE_NODAT | IDTE_GUEST_ASCE,
 			    mm->context.asce, IDTE_GLOBAL);
-		if (mm_has_pgste(mm))
+		if (mm_has_pgste(mm) && mm->context.allow_gmap_hpage_1m)
 			gmap_pmdp_idte_global(mm, addr);
 	} else if (MACHINE_HAS_IDTE) {
 		__pmdp_idte(addr, pmdp, 0, 0, IDTE_GLOBAL);
-		if (mm_has_pgste(mm))
+		if (mm_has_pgste(mm) && mm->context.allow_gmap_hpage_1m)
 			gmap_pmdp_idte_global(mm, addr);
 	} else {
 		__pmdp_csp(pmdp);
-		if (mm_has_pgste(mm))
+		if (mm_has_pgste(mm) && mm->context.allow_gmap_hpage_1m)
 			gmap_pmdp_csp(mm, addr);
 	}
 }
-- 
2.17.0
