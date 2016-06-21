From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/51] s390/mm: use RCU for gmap notifier list and the per-mm gmap list
Date: Tue, 21 Jun 2016 15:12:40 +0200
Message-ID: <1466514809-146638-3-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The gmap notifier list and the gmap list in the mm_struct change rarely.
Use RCU to optimize the reader of these lists.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h        |  1 +
 arch/s390/include/asm/mmu.h         | 11 +++++++----
 arch/s390/include/asm/mmu_context.h |  3 ++-
 arch/s390/mm/gmap.c                 | 39 ++++++++++++++++++++++---------------
 arch/s390/mm/pgalloc.c              | 16 +++++++--------
 5 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index bc0eadf..2cf49624 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -39,6 +39,7 @@ struct gmap {
  */
 struct gmap_notifier {
 	struct list_head list;
+	struct rcu_head rcu;
 	void (*notifier_call)(struct gmap *gmap, unsigned long start,
 			      unsigned long end);
 };
diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index 081b2ad..b941528 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -8,8 +8,9 @@ typedef struct {
 	cpumask_t cpu_attach_mask;
 	atomic_t attach_count;
 	unsigned int flush_mm;
-	spinlock_t list_lock;
+	spinlock_t pgtable_lock;
 	struct list_head pgtable_list;
+	spinlock_t gmap_lock;
 	struct list_head gmap_list;
 	unsigned long asce;
 	unsigned long asce_limit;
@@ -22,9 +23,11 @@ typedef struct {
 	unsigned int use_skey:1;
 } mm_context_t;
 
-#define INIT_MM_CONTEXT(name)						      \
-	.context.list_lock    = __SPIN_LOCK_UNLOCKED(name.context.list_lock), \
-	.context.pgtable_list = LIST_HEAD_INIT(name.context.pgtable_list),    \
+#define INIT_MM_CONTEXT(name)						   \
+	.context.pgtable_lock =						   \
+			__SPIN_LOCK_UNLOCKED(name.context.pgtable_lock),   \
+	.context.pgtable_list = LIST_HEAD_INIT(name.context.pgtable_list), \
+	.context.gmap_lock = __SPIN_LOCK_UNLOCKED(name.context.gmap_lock), \
 	.context.gmap_list = LIST_HEAD_INIT(name.context.gmap_list),
 
 static inline int tprot(unsigned long addr)
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index c837b79..3ce3854 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -15,8 +15,9 @@
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
-	spin_lock_init(&mm->context.list_lock);
+	spin_lock_init(&mm->context.pgtable_lock);
 	INIT_LIST_HEAD(&mm->context.pgtable_list);
+	spin_lock_init(&mm->context.gmap_lock);
 	INIT_LIST_HEAD(&mm->context.gmap_list);
 	cpumask_clear(&mm->context.cpu_attach_mask);
 	atomic_set(&mm->context.attach_count, 0);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index b5820bf..8b56423 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -70,9 +70,9 @@ struct gmap *gmap_alloc(struct mm_struct *mm, unsigned long limit)
 	gmap->asce = atype | _ASCE_TABLE_LENGTH |
 		_ASCE_USER_BITS | __pa(table);
 	gmap->asce_end = limit;
-	down_write(&mm->mmap_sem);
-	list_add(&gmap->list, &mm->context.gmap_list);
-	up_write(&mm->mmap_sem);
+	spin_lock(&mm->context.gmap_lock);
+	list_add_rcu(&gmap->list, &mm->context.gmap_list);
+	spin_unlock(&mm->context.gmap_lock);
 	return gmap;
 
 out_free:
@@ -128,14 +128,16 @@ void gmap_free(struct gmap *gmap)
 	else
 		__tlb_flush_global();
 
+	spin_lock(&gmap->mm->context.gmap_lock);
+	list_del_rcu(&gmap->list);
+	spin_unlock(&gmap->mm->context.gmap_lock);
+	synchronize_rcu();
+
 	/* Free all segment & region tables. */
 	list_for_each_entry_safe(page, next, &gmap->crst_list, lru)
 		__free_pages(page, 2);
 	gmap_radix_tree_free(&gmap->guest_to_host);
 	gmap_radix_tree_free(&gmap->host_to_guest);
-	down_write(&gmap->mm->mmap_sem);
-	list_del(&gmap->list);
-	up_write(&gmap->mm->mmap_sem);
 	kfree(gmap);
 }
 EXPORT_SYMBOL_GPL(gmap_free);
@@ -369,11 +371,13 @@ void gmap_unlink(struct mm_struct *mm, unsigned long *table,
 	struct gmap *gmap;
 	int flush;
 
-	list_for_each_entry(gmap, &mm->context.gmap_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
 		flush = __gmap_unlink_by_vmaddr(gmap, vmaddr);
 		if (flush)
 			gmap_flush_tlb(gmap);
 	}
+	rcu_read_unlock();
 }
 
 /**
@@ -555,7 +559,7 @@ static DEFINE_SPINLOCK(gmap_notifier_lock);
 void gmap_register_ipte_notifier(struct gmap_notifier *nb)
 {
 	spin_lock(&gmap_notifier_lock);
-	list_add(&nb->list, &gmap_notifier_list);
+	list_add_rcu(&nb->list, &gmap_notifier_list);
 	spin_unlock(&gmap_notifier_lock);
 }
 EXPORT_SYMBOL_GPL(gmap_register_ipte_notifier);
@@ -567,8 +571,9 @@ EXPORT_SYMBOL_GPL(gmap_register_ipte_notifier);
 void gmap_unregister_ipte_notifier(struct gmap_notifier *nb)
 {
 	spin_lock(&gmap_notifier_lock);
-	list_del_init(&nb->list);
+	list_del_rcu(&nb->list);
 	spin_unlock(&gmap_notifier_lock);
+	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(gmap_unregister_ipte_notifier);
 
@@ -662,16 +667,18 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr, pte_t *pte)
 
 	offset = ((unsigned long) pte) & (255 * sizeof(pte_t));
 	offset = offset * (4096 / sizeof(pte_t));
-	spin_lock(&gmap_notifier_lock);
-	list_for_each_entry(gmap, &mm->context.gmap_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
+		spin_lock(&gmap->guest_table_lock);
 		table = radix_tree_lookup(&gmap->host_to_guest,
 					  vmaddr >> PMD_SHIFT);
-		if (!table)
-			continue;
-		gaddr = __gmap_segment_gaddr(table) + offset;
-		gmap_call_notifier(gmap, gaddr, gaddr + PAGE_SIZE - 1);
+		if (table)
+			gaddr = __gmap_segment_gaddr(table) + offset;
+		spin_unlock(&gmap->guest_table_lock);
+		if (table)
+			gmap_call_notifier(gmap, gaddr, gaddr + PAGE_SIZE - 1);
 	}
-	spin_unlock(&gmap_notifier_lock);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(ptep_notify);
 
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index e8b5962..7be1f94 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -149,7 +149,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	/* Try to get a fragment of a 4K page as a 2K page table */
 	if (!mm_alloc_pgste(mm)) {
 		table = NULL;
-		spin_lock_bh(&mm->context.list_lock);
+		spin_lock_bh(&mm->context.pgtable_lock);
 		if (!list_empty(&mm->context.pgtable_list)) {
 			page = list_first_entry(&mm->context.pgtable_list,
 						struct page, lru);
@@ -164,7 +164,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 				list_del(&page->lru);
 			}
 		}
-		spin_unlock_bh(&mm->context.list_lock);
+		spin_unlock_bh(&mm->context.pgtable_lock);
 		if (table)
 			return table;
 	}
@@ -187,9 +187,9 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 		/* Return the first 2K fragment of the page */
 		atomic_set(&page->_mapcount, 1);
 		clear_table(table, _PAGE_INVALID, PAGE_SIZE);
-		spin_lock_bh(&mm->context.list_lock);
+		spin_lock_bh(&mm->context.pgtable_lock);
 		list_add(&page->lru, &mm->context.pgtable_list);
-		spin_unlock_bh(&mm->context.list_lock);
+		spin_unlock_bh(&mm->context.pgtable_lock);
 	}
 	return table;
 }
@@ -203,13 +203,13 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	if (!mm_alloc_pgste(mm)) {
 		/* Free 2K page table fragment of a 4K page */
 		bit = (__pa(table) & ~PAGE_MASK)/(PTRS_PER_PTE*sizeof(pte_t));
-		spin_lock_bh(&mm->context.list_lock);
+		spin_lock_bh(&mm->context.pgtable_lock);
 		mask = atomic_xor_bits(&page->_mapcount, 1U << bit);
 		if (mask & 3)
 			list_add(&page->lru, &mm->context.pgtable_list);
 		else
 			list_del(&page->lru);
-		spin_unlock_bh(&mm->context.list_lock);
+		spin_unlock_bh(&mm->context.pgtable_lock);
 		if (mask != 0)
 			return;
 	}
@@ -235,13 +235,13 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 		return;
 	}
 	bit = (__pa(table) & ~PAGE_MASK) / (PTRS_PER_PTE*sizeof(pte_t));
-	spin_lock_bh(&mm->context.list_lock);
+	spin_lock_bh(&mm->context.pgtable_lock);
 	mask = atomic_xor_bits(&page->_mapcount, 0x11U << bit);
 	if (mask & 3)
 		list_add_tail(&page->lru, &mm->context.pgtable_list);
 	else
 		list_del(&page->lru);
-	spin_unlock_bh(&mm->context.list_lock);
+	spin_unlock_bh(&mm->context.pgtable_lock);
 	table = (unsigned long *) (__pa(table) | (1U << bit));
 	tlb_remove_table(tlb, table);
 }
-- 
2.5.5
