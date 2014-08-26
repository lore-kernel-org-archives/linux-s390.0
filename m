From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 14/15] KVM: s390/mm: support gmap page tables with less than 5 levels
Date: Tue, 26 Aug 2014 10:28:26 +0200
Message-ID: <1409041707-39938-15-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add an addressing limit to the gmap address spaces and only allocate
the page table levels that are needed for the given limit. The limit
is fixed and can not be changed after a gmap has been created.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h |  3 +-
 arch/s390/kvm/kvm-s390.c        |  4 +-
 arch/s390/mm/pgtable.c          | 85 ++++++++++++++++++++++++++---------------
 3 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 9bfdbca..7705180 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -808,6 +808,7 @@ struct gmap {
 	spinlock_t guest_table_lock;
 	unsigned long *table;
 	unsigned long asce;
+	unsigned long asce_end;
 	void *private;
 	bool pfault_enabled;
 };
@@ -844,7 +845,7 @@ struct gmap_notifier {
 	void (*notifier_call)(struct gmap *gmap, unsigned long gaddr);
 };
 
-struct gmap *gmap_alloc(struct mm_struct *mm);
+struct gmap *gmap_alloc(struct mm_struct *mm, unsigned long limit);
 void gmap_free(struct gmap *gmap);
 void gmap_enable(struct gmap *gmap);
 void gmap_disable(struct gmap *gmap);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 543c24b..82065dc 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -451,7 +451,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (type & KVM_VM_S390_UCONTROL) {
 		kvm->arch.gmap = NULL;
 	} else {
-		kvm->arch.gmap = gmap_alloc(current->mm);
+		kvm->arch.gmap = gmap_alloc(current->mm, -1UL);
 		if (!kvm->arch.gmap)
 			goto out_nogmap;
 		kvm->arch.gmap->private = kvm;
@@ -535,7 +535,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
 	kvm_clear_async_pf_completion_queue(vcpu);
 	if (kvm_is_ucontrol(vcpu->kvm)) {
-		vcpu->arch.gmap = gmap_alloc(current->mm);
+		vcpu->arch.gmap = gmap_alloc(current->mm, -1UL);
 		if (!vcpu->arch.gmap)
 			return -ENOMEM;
 		vcpu->arch.gmap->private = vcpu->kvm;
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 74dfd9e..665714b 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -145,15 +145,34 @@ void crst_table_downgrade(struct mm_struct *mm, unsigned long limit)
 /**
  * gmap_alloc - allocate a guest address space
  * @mm: pointer to the parent mm_struct
+ * @limit: maximum size of the gmap address space
  *
  * Returns a guest address space structure.
  */
-struct gmap *gmap_alloc(struct mm_struct *mm)
+struct gmap *gmap_alloc(struct mm_struct *mm, unsigned long limit)
 {
 	struct gmap *gmap;
 	struct page *page;
 	unsigned long *table;
-
+	unsigned long etype, atype;
+
+	if (limit < (1UL << 31)) {
+		limit = (1UL << 31) - 1;
+		atype = _ASCE_TYPE_SEGMENT;
+		etype = _SEGMENT_ENTRY_EMPTY;
+	} else if (limit < (1UL << 42)) {
+		limit = (1UL << 42) - 1;
+		atype = _ASCE_TYPE_REGION3;
+		etype = _REGION3_ENTRY_EMPTY;
+	} else if (limit < (1UL << 53)) {
+		limit = (1UL << 53) - 1;
+		atype = _ASCE_TYPE_REGION2;
+		etype = _REGION2_ENTRY_EMPTY;
+	} else {
+		limit = -1UL;
+		atype = _ASCE_TYPE_REGION1;
+		etype = _REGION1_ENTRY_EMPTY;
+	}
 	gmap = kzalloc(sizeof(struct gmap), GFP_KERNEL);
 	if (!gmap)
 		goto out;
@@ -168,10 +187,11 @@ struct gmap *gmap_alloc(struct mm_struct *mm)
 	page->index = 0;
 	list_add(&page->lru, &gmap->crst_list);
 	table = (unsigned long *) page_to_phys(page);
-	crst_table_init(table, _REGION1_ENTRY_EMPTY);
+	crst_table_init(table, etype);
 	gmap->table = table;
-	gmap->asce = _ASCE_TYPE_REGION1 | _ASCE_TABLE_LENGTH |
-		     _ASCE_USER_BITS | __pa(table);
+	gmap->asce = atype | _ASCE_TABLE_LENGTH |
+		_ASCE_USER_BITS | __pa(table);
+	gmap->asce_end = limit;
 	down_write(&mm->mmap_sem);
 	list_add(&gmap->list, &mm->context.gmap_list);
 	up_write(&mm->mmap_sem);
@@ -187,8 +207,7 @@ EXPORT_SYMBOL_GPL(gmap_alloc);
 static void gmap_flush_tlb(struct gmap *gmap)
 {
 	if (MACHINE_HAS_IDTE)
-		__tlb_flush_asce(gmap->mm, (unsigned long) gmap->table |
-				 _ASCE_TYPE_REGION1);
+		__tlb_flush_asce(gmap->mm, gmap->asce);
 	else
 		__tlb_flush_global();
 }
@@ -227,8 +246,7 @@ void gmap_free(struct gmap *gmap)
 
 	/* Flush tlb. */
 	if (MACHINE_HAS_IDTE)
-		__tlb_flush_asce(gmap->mm, (unsigned long) gmap->table |
-				 _ASCE_TYPE_REGION1);
+		__tlb_flush_asce(gmap->mm, gmap->asce);
 	else
 		__tlb_flush_global();
 
@@ -394,8 +412,8 @@ int gmap_map_segment(struct gmap *gmap, unsigned long from,
 
 	if ((from | to | len) & (PMD_SIZE - 1))
 		return -EINVAL;
-	if (len == 0 || from + len > TASK_MAX_SIZE ||
-	    from + len < from || to + len < to)
+	if (len == 0 || from + len < from || to + len < to ||
+	    from + len > TASK_MAX_SIZE || to + len > gmap->asce_end)
 		return -EINVAL;
 
 	flush = 0;
@@ -501,25 +519,32 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	int rc;
 
 	/* Create higher level tables in the gmap page table */
-	table = gmap->table + ((gaddr >> 53) & 0x7ff);
-	if ((*table & _REGION_ENTRY_INVALID) &&
-	    gmap_alloc_table(gmap, table, _REGION2_ENTRY_EMPTY,
-			     gaddr & 0xffe0000000000000))
-		return -ENOMEM;
-	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-	table = table + ((gaddr >> 42) & 0x7ff);
-	if ((*table & _REGION_ENTRY_INVALID) &&
-	    gmap_alloc_table(gmap, table, _REGION3_ENTRY_EMPTY,
-			     gaddr & 0xfffffc0000000000))
-		return -ENOMEM;
-	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-	table = table + ((gaddr >> 31) & 0x7ff);
-	if ((*table & _REGION_ENTRY_INVALID) &&
-	    gmap_alloc_table(gmap, table, _SEGMENT_ENTRY_EMPTY,
-			     gaddr & 0xffffffff80000000))
-		return -ENOMEM;
-	table = (unsigned long *) (*table & _REGION_ENTRY_ORIGIN);
-	table = table + ((gaddr >> 20) & 0x7ff);
+	table = gmap->table;
+	if ((gmap->asce & _ASCE_TYPE_MASK) >= _ASCE_TYPE_REGION1) {
+		table += (gaddr >> 53) & 0x7ff;
+		if ((*table & _REGION_ENTRY_INVALID) &&
+		    gmap_alloc_table(gmap, table, _REGION2_ENTRY_EMPTY,
+				     gaddr & 0xffe0000000000000))
+			return -ENOMEM;
+		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
+	}
+	if ((gmap->asce & _ASCE_TYPE_MASK) >= _ASCE_TYPE_REGION2) {
+		table += (gaddr >> 42) & 0x7ff;
+		if ((*table & _REGION_ENTRY_INVALID) &&
+		    gmap_alloc_table(gmap, table, _REGION3_ENTRY_EMPTY,
+				     gaddr & 0xfffffc0000000000))
+			return -ENOMEM;
+		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
+	}
+	if ((gmap->asce & _ASCE_TYPE_MASK) >= _ASCE_TYPE_REGION3) {
+		table += (gaddr >> 31) & 0x7ff;
+		if ((*table & _REGION_ENTRY_INVALID) &&
+		    gmap_alloc_table(gmap, table, _SEGMENT_ENTRY_EMPTY,
+				     gaddr & 0xffffffff80000000))
+			return -ENOMEM;
+		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
+	}
+	table += (gaddr >> 20) & 0x7ff;
 	/* Walk the parent mm page table */
 	mm = gmap->mm;
 	pgd = pgd_offset(mm, vmaddr);
-- 
1.8.4.2
