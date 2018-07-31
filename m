From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:43:56 +0000
Subject: [GIT PULL 10/19] s390/mm: Add gmap pmd invalidation and clearing
Message-Id: <20180731084405.28953-11-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

If the host invalidates a pmd, we also have to invalidate the
corresponding gmap pmds, as well as flush them from the TLB. This is
necessary, as we don't share the pmd tables between host and guest as
we do with ptes.

The clearing part of these three new functions sets a guest pmd entry
to _SEGMENT_ENTRY_EMPTY, so the guest will fault on it and we will
re-link it.

Flushing the gmap is not necessary in the host's lazy local and csp
cases. Both purge the TLB completely.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/pgtable.h |   4 +
 arch/s390/mm/gmap.c             | 125 ++++++++++++++++++++++++++++++++
 arch/s390/mm/pgtable.c          |  17 ++++-
 3 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index fe36b3bb2afd..087e0282f165 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1118,6 +1118,10 @@ int set_pgste_bits(struct mm_struct *mm, unsigned long addr,
 int get_pgste(struct mm_struct *mm, unsigned long hva, unsigned long *pgstep);
 int pgste_perform_essa(struct mm_struct *mm, unsigned long hva, int orc,
 			unsigned long *oldpte, unsigned long *oldpgste);
+void gmap_pmdp_csp(struct mm_struct *mm, unsigned long vmaddr);
+void gmap_pmdp_invalidate(struct mm_struct *mm, unsigned long vmaddr);
+void gmap_pmdp_idte_local(struct mm_struct *mm, unsigned long vmaddr);
+void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr);
 
 /*
  * Certain architectures need to do special things when PTEs
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 96dd94d51ad4..87c174ee3a8c 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2221,6 +2221,131 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
 }
 EXPORT_SYMBOL_GPL(ptep_notify);
 
+static void pmdp_notify_gmap(struct gmap *gmap, pmd_t *pmdp,
+			     unsigned long gaddr)
+{
+	pmd_val(*pmdp) &= ~_SEGMENT_ENTRY_GMAP_IN;
+	gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
+}
+
+static void gmap_pmdp_clear(struct mm_struct *mm, unsigned long vmaddr,
+			    int purge)
+{
+	pmd_t *pmdp;
+	struct gmap *gmap;
+	unsigned long gaddr;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
+		spin_lock(&gmap->guest_table_lock);
+		pmdp = (pmd_t *)radix_tree_delete(&gmap->host_to_guest,
+						  vmaddr >> PMD_SHIFT);
+		if (pmdp) {
+			gaddr = __gmap_segment_gaddr((unsigned long *)pmdp);
+			pmdp_notify_gmap(gmap, pmdp, gaddr);
+			WARN_ON(pmd_val(*pmdp) & ~_SEGMENT_ENTRY_HARDWARE_BITS_LARGE);
+			if (purge)
+				__pmdp_csp(pmdp);
+			pmd_val(*pmdp) = _SEGMENT_ENTRY_EMPTY;
+		}
+		spin_unlock(&gmap->guest_table_lock);
+	}
+	rcu_read_unlock();
+}
+
+/**
+ * gmap_pmdp_invalidate - invalidate all affected guest pmd entries without
+ *                        flushing
+ * @mm: pointer to the process mm_struct
+ * @vmaddr: virtual address in the process address space
+ */
+void gmap_pmdp_invalidate(struct mm_struct *mm, unsigned long vmaddr)
+{
+	gmap_pmdp_clear(mm, vmaddr, 0);
+}
+EXPORT_SYMBOL_GPL(gmap_pmdp_invalidate);
+
+/**
+ * gmap_pmdp_csp - csp all affected guest pmd entries
+ * @mm: pointer to the process mm_struct
+ * @vmaddr: virtual address in the process address space
+ */
+void gmap_pmdp_csp(struct mm_struct *mm, unsigned long vmaddr)
+{
+	gmap_pmdp_clear(mm, vmaddr, 1);
+}
+EXPORT_SYMBOL_GPL(gmap_pmdp_csp);
+
+/**
+ * gmap_pmdp_idte_local - invalidate and clear a guest pmd entry
+ * @mm: pointer to the process mm_struct
+ * @vmaddr: virtual address in the process address space
+ */
+void gmap_pmdp_idte_local(struct mm_struct *mm, unsigned long vmaddr)
+{
+	unsigned long *entry, gaddr;
+	struct gmap *gmap;
+	pmd_t *pmdp;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
+		spin_lock(&gmap->guest_table_lock);
+		entry = radix_tree_delete(&gmap->host_to_guest,
+					  vmaddr >> PMD_SHIFT);
+		if (entry) {
+			pmdp = (pmd_t *)entry;
+			gaddr = __gmap_segment_gaddr(entry);
+			pmdp_notify_gmap(gmap, pmdp, gaddr);
+			WARN_ON(*entry & ~_SEGMENT_ENTRY_HARDWARE_BITS_LARGE);
+			if (MACHINE_HAS_TLB_GUEST)
+				__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE,
+					    gmap->asce, IDTE_LOCAL);
+			else if (MACHINE_HAS_IDTE)
+				__pmdp_idte(gaddr, pmdp, 0, 0, IDTE_LOCAL);
+			*entry = _SEGMENT_ENTRY_EMPTY;
+		}
+		spin_unlock(&gmap->guest_table_lock);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(gmap_pmdp_idte_local);
+
+/**
+ * gmap_pmdp_idte_global - invalidate and clear a guest pmd entry
+ * @mm: pointer to the process mm_struct
+ * @vmaddr: virtual address in the process address space
+ */
+void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
+{
+	unsigned long *entry, gaddr;
+	struct gmap *gmap;
+	pmd_t *pmdp;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
+		spin_lock(&gmap->guest_table_lock);
+		entry = radix_tree_delete(&gmap->host_to_guest,
+					  vmaddr >> PMD_SHIFT);
+		if (entry) {
+			pmdp = (pmd_t *)entry;
+			gaddr = __gmap_segment_gaddr(entry);
+			pmdp_notify_gmap(gmap, pmdp, gaddr);
+			WARN_ON(*entry & ~_SEGMENT_ENTRY_HARDWARE_BITS_LARGE);
+			if (MACHINE_HAS_TLB_GUEST)
+				__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE,
+					    gmap->asce, IDTE_GLOBAL);
+			else if (MACHINE_HAS_IDTE)
+				__pmdp_idte(gaddr, pmdp, 0, 0, IDTE_GLOBAL);
+			else
+				__pmdp_csp(pmdp);
+			*entry = _SEGMENT_ENTRY_EMPTY;
+		}
+		spin_unlock(&gmap->guest_table_lock);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(gmap_pmdp_idte_global);
+
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 301e466e4263..fe84c0715395 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -347,18 +347,27 @@ static inline void pmdp_idte_local(struct mm_struct *mm,
 			    mm->context.asce, IDTE_LOCAL);
 	else
 		__pmdp_idte(addr, pmdp, 0, 0, IDTE_LOCAL);
+	if (mm_has_pgste(mm))
+		gmap_pmdp_idte_local(mm, addr);
 }
 
 static inline void pmdp_idte_global(struct mm_struct *mm,
 				    unsigned long addr, pmd_t *pmdp)
 {
-	if (MACHINE_HAS_TLB_GUEST)
+	if (MACHINE_HAS_TLB_GUEST) {
 		__pmdp_idte(addr, pmdp, IDTE_NODAT | IDTE_GUEST_ASCE,
 			    mm->context.asce, IDTE_GLOBAL);
-	else if (MACHINE_HAS_IDTE)
+		if (mm_has_pgste(mm))
+			gmap_pmdp_idte_global(mm, addr);
+	} else if (MACHINE_HAS_IDTE) {
 		__pmdp_idte(addr, pmdp, 0, 0, IDTE_GLOBAL);
-	else
+		if (mm_has_pgste(mm))
+			gmap_pmdp_idte_global(mm, addr);
+	} else {
 		__pmdp_csp(pmdp);
+		if (mm_has_pgste(mm))
+			gmap_pmdp_csp(mm, addr);
+	}
 }
 
 static inline pmd_t pmdp_flush_direct(struct mm_struct *mm,
@@ -392,6 +401,8 @@ static inline pmd_t pmdp_flush_lazy(struct mm_struct *mm,
 			  cpumask_of(smp_processor_id()))) {
 		pmd_val(*pmdp) |= _SEGMENT_ENTRY_INVALID;
 		mm->context.flush_mm = 1;
+		if (mm_has_pgste(mm))
+			gmap_pmdp_invalidate(mm, addr);
 	} else {
 		pmdp_idte_global(mm, addr, pmdp);
 	}
-- 
2.17.0
