From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 03/22] s390/mm: add gmap PMD invalidation notification
Date: Mon,  6 Nov 2017 23:29:41 +0100
Message-ID: <1510007400-42493-4-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

For later migration of huge pages we want to write-protect guest
PMDs. While doing this, we have to make absolutely sure, that the
guest's lowcore is always accessible when the VCPU is running. With
PTEs, this is solved by marking the PGSTEs of the lowcore pages with
the invalidation notification bit and kicking the guest out of the SIE
via a notifier function if we need to invalidate such a page.

With PMDs we do not have PGSTEs or some other bits we could use in the
host PMD. Instead we pick one of the free bits in the gmap PMD. Every
time a host pmd will be invalidated, we will check if the respective
gmap PMD has the bit set and in that case fire up the notifier.

In the first step we only support setting the invalidation bit, but we
do not support restricting access of guest pmds. It will follow
shortly.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/gmap.h    |  3 ++
 arch/s390/include/asm/pgtable.h |  1 +
 arch/s390/mm/gmap.c             | 95 ++++++++++++++++++++++++++++++++++++-----
 arch/s390/mm/pgtable.c          |  4 ++
 4 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index f3d84a8..99cf6d8 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -12,6 +12,9 @@
 #define GMAP_ENTRY_VSIE	0x2
 #define GMAP_ENTRY_IN	0x1
 
+/* Status bits in the gmap segment entry. */
+#define _SEGMENT_ENTRY_GMAP_IN		0x0001	/* invalidation notify bit */
+
 /**
  * struct gmap_struct - guest address space
  * @list: list head for the mm->context gmap list
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 20e75a2..4707647 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1092,6 +1092,7 @@ void ptep_set_pte_at(struct mm_struct *mm, unsigned long addr,
 void ptep_set_notify(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 void ptep_notify(struct mm_struct *mm, unsigned long addr,
 		 pte_t *ptep, unsigned long bits);
+void pmdp_notify(struct mm_struct *mm, unsigned long addr);
 int ptep_force_prot(struct mm_struct *mm, unsigned long gaddr,
 		    pte_t *ptep, int prot, unsigned long bit);
 void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 74e2062..3961589 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -595,10 +595,17 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	if (*table == _SEGMENT_ENTRY_EMPTY) {
 		rc = radix_tree_insert(&gmap->host_to_guest,
 				       vmaddr >> PMD_SHIFT, table);
-		if (!rc)
-			*table = pmd_val(*pmd);
-	} else
-		rc = 0;
+		if (!rc) {
+			if (pmd_large(*pmd)) {
+				*table = pmd_val(*pmd) &
+					(_SEGMENT_ENTRY_ORIGIN_LARGE
+					 | _SEGMENT_ENTRY_INVALID
+					 | _SEGMENT_ENTRY_LARGE
+					 | _SEGMENT_ENTRY_PROTECT);
+			} else
+				*table = pmd_val(*pmd) & ~0x03UL;
+		}
+	}
 	spin_unlock(&gmap->guest_table_lock);
 	spin_unlock(ptl);
 	radix_tree_preload_end();
@@ -965,6 +972,35 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 }
 
 /*
+ * gmap_protect_large - set pmd notification bits
+ * @pmdp: pointer to the pmd to be protected
+ * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
+ * @bits: notification bits to set
+ *
+ * Returns 0 if successfully protected, -ENOMEM if out of memory and
+ * -EAGAIN if a fixup is needed.
+ *
+ * Expected to be called with sg->mm->mmap_sem in read and
+ * guest_table_lock held.
+ */
+static int gmap_protect_large(struct gmap *gmap, unsigned long gaddr,
+			      pmd_t *pmdp, int prot, unsigned long bits)
+{
+	int pmd_i, pmd_p;
+
+	pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
+	pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
+
+	/* Fixup needed */
+	if ((pmd_i && (prot != PROT_NONE)) || (pmd_p && (prot & PROT_WRITE)))
+		return -EAGAIN;
+
+	if (bits & GMAP_ENTRY_IN)
+		pmd_val(*pmdp) |=  _SEGMENT_ENTRY_GMAP_IN;
+	return 0;
+}
+
+/*
  * gmap_protect_range - remove access rights to memory and set pgste bits
  * @gmap: pointer to guest mapping meta data structure
  * @gaddr: virtual address in the guest address space
@@ -977,7 +1013,7 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
  *
  * Called with sg->mm->mmap_sem in read.
  *
- * Note: Can also be called for shadow gmaps.
+ * Note: Can also be called for shadow gmaps, but only with 4k pages.
  */
 static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
@@ -990,11 +1026,20 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
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
+				rc =  gmap_protect_large(gmap, gaddr, pmdp,
+							 prot, bits);
+				if (!rc) {
+					len = len < HPAGE_SIZE ? 0 : len - HPAGE_SIZE;
+					gaddr = (gaddr & HPAGE_MASK) + HPAGE_SIZE;
+				}
 			}
 			gmap_pmd_op_end(gmap, pmdp);
 		}
@@ -2191,6 +2236,36 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
 }
 EXPORT_SYMBOL_GPL(ptep_notify);
 
+/**
+ * pmdp_notify - call all invalidation callbacks for a specific pmd
+ * @mm: pointer to the process mm_struct
+ * @vmaddr: virtual address in the process address space
+ *
+ * This function is expected to be called with mmap_sem held in read.
+ */
+void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
+{
+	unsigned long *table, gaddr;
+	struct gmap *gmap;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
+		spin_lock(&gmap->guest_table_lock);
+		table = radix_tree_lookup(&gmap->host_to_guest,
+					  vmaddr >> PMD_SHIFT);
+		if (!table || !(*table & _SEGMENT_ENTRY_GMAP_IN)) {
+			spin_unlock(&gmap->guest_table_lock);
+			continue;
+		}
+		gaddr = __gmap_segment_gaddr(table);
+		*table &= ~_SEGMENT_ENTRY_GMAP_IN;
+		spin_unlock(&gmap->guest_table_lock);
+		gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(pmdp_notify);
+
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index ae677f8..79d35d0 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -404,6 +404,8 @@ pmd_t pmdp_xchg_direct(struct mm_struct *mm, unsigned long addr,
 	pmd_t old;
 
 	preempt_disable();
+	if (mm_has_pgste(mm))
+		pmdp_notify(mm, addr);
 	old = pmdp_flush_direct(mm, addr, pmdp);
 	*pmdp = new;
 	preempt_enable();
@@ -417,6 +419,8 @@ pmd_t pmdp_xchg_lazy(struct mm_struct *mm, unsigned long addr,
 	pmd_t old;
 
 	preempt_disable();
+	if (mm_has_pgste(mm))
+		pmdp_notify(mm, addr);
 	old = pmdp_flush_lazy(mm, addr, pmdp);
 	*pmdp = new;
 	preempt_enable();
-- 
2.7.4
