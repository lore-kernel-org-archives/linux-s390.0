From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v3 05/16] s390/mm: Add gmap pmd invalidation and clearing
Date: Fri,  9 Feb 2018 10:34:13 +0100
Message-ID: <1518168864-147803-6-git-send-email-frankja@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

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
---
 arch/s390/include/asm/pgtable.h |   4 ++
 arch/s390/mm/gmap.c             | 117 ++++++++++++++++++++++++++++++++++++++++
 arch/s390/mm/pgtable.c          |  17 ++++--
 3 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index e9b56b9..223791b 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1122,6 +1122,10 @@ int set_pgste_bits(struct mm_struct *mm, unsigned long addr,
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
index cb03e66..9046c91 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2371,6 +2371,123 @@ void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
 }
 EXPORT_SYMBOL_GPL(pmdp_notify);
 
+static void gmap_pmdp_clear(struct mm_struct *mm, unsigned long vmaddr,
+			    int purge)
+{
+	pmd_t *pmdp;
+	struct gmap *gmap;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
+		spin_lock(&gmap->guest_table_lock);
+		pmdp = (pmd_t *)radix_tree_delete(&gmap->host_to_guest,
+						   vmaddr >> PMD_SHIFT);
+		if (pmdp) {
+			if (purge)
+				__pmdp_csp(pmdp);
+			gmap_pmd_split_free(pmdp);
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
+			if (MACHINE_HAS_TLB_GUEST)
+				__pmdp_idte(gaddr, pmdp,
+					    IDTE_GUEST_ASCE,
+					    gmap->asce, IDTE_LOCAL);
+			else if (MACHINE_HAS_IDTE)
+				__pmdp_idte(gaddr, pmdp, 0, 0,
+					    IDTE_LOCAL);
+			gmap_pmd_split_free(pmdp);
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
+			if (MACHINE_HAS_TLB_GUEST)
+				__pmdp_idte(gaddr, pmdp,
+					    IDTE_GUEST_ASCE,
+					    gmap->asce, IDTE_GLOBAL);
+			else if (MACHINE_HAS_IDTE)
+				__pmdp_idte(gaddr, pmdp, 0, 0,
+					    IDTE_GLOBAL);
+			else
+				__pmdp_csp(pmdp);
+			gmap_pmd_split_free(pmdp);
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
index a6cc540..e690879 100644
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
2.7.4
