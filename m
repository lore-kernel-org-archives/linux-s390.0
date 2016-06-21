From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/51] s390/mm: add reference counter to gmap structure
Date: Tue, 21 Jun 2016 15:12:42 +0200
Message-ID: <1466514809-146638-5-git-send-email-borntraeger@de.ibm.com>
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

Let's use a reference counter mechanism to control the lifetime of
gmap structures. This will be needed for further changes related to
gmap shadows.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h |  9 ++++-
 arch/s390/kvm/kvm-s390.c     | 16 ++++----
 arch/s390/mm/gmap.c          | 90 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 85 insertions(+), 30 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 6897a09..e69853c 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -15,6 +15,7 @@
  * @guest_to_host: radix tree with guest to host address translation
  * @host_to_guest: radix tree with pointer to segment table entries
  * @guest_table_lock: spinlock to protect all entries in the guest page table
+ * @ref_count: reference counter for the gmap structure
  * @table: pointer to the page directory
  * @asce: address space control element for gmap page table
  * @pfault_enabled: defines if pfaults are applicable for the guest
@@ -26,6 +27,7 @@ struct gmap {
 	struct radix_tree_root guest_to_host;
 	struct radix_tree_root host_to_guest;
 	spinlock_t guest_table_lock;
+	atomic_t ref_count;
 	unsigned long *table;
 	unsigned long asce;
 	unsigned long asce_end;
@@ -44,8 +46,11 @@ struct gmap_notifier {
 			      unsigned long end);
 };
 
-struct gmap *gmap_alloc(struct mm_struct *mm, unsigned long limit);
-void gmap_free(struct gmap *gmap);
+struct gmap *gmap_create(struct mm_struct *mm, unsigned long limit);
+void gmap_remove(struct gmap *gmap);
+struct gmap *gmap_get(struct gmap *gmap);
+void gmap_put(struct gmap *gmap);
+
 void gmap_enable(struct gmap *gmap);
 void gmap_disable(struct gmap *gmap);
 int gmap_map_segment(struct gmap *gmap, unsigned long from,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b6e7f66..9dd5298 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -532,20 +532,20 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (!new_limit)
 			return -EINVAL;
 
-		/* gmap_alloc takes last usable address */
+		/* gmap_create takes last usable address */
 		if (new_limit != KVM_S390_NO_MEM_LIMIT)
 			new_limit -= 1;
 
 		ret = -EBUSY;
 		mutex_lock(&kvm->lock);
 		if (!kvm->created_vcpus) {
-			/* gmap_alloc will round the limit up */
-			struct gmap *new = gmap_alloc(current->mm, new_limit);
+			/* gmap_create will round the limit up */
+			struct gmap *new = gmap_create(current->mm, new_limit);
 
 			if (!new) {
 				ret = -ENOMEM;
 			} else {
-				gmap_free(kvm->arch.gmap);
+				gmap_remove(kvm->arch.gmap);
 				new->private = kvm;
 				kvm->arch.gmap = new;
 				ret = 0;
@@ -1394,7 +1394,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		else
 			kvm->arch.mem_limit = min_t(unsigned long, TASK_MAX_SIZE,
 						    sclp.hamax + 1);
-		kvm->arch.gmap = gmap_alloc(current->mm, kvm->arch.mem_limit - 1);
+		kvm->arch.gmap = gmap_create(current->mm, kvm->arch.mem_limit - 1);
 		if (!kvm->arch.gmap)
 			goto out_err;
 		kvm->arch.gmap->private = kvm;
@@ -1427,7 +1427,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 		sca_del_vcpu(vcpu);
 
 	if (kvm_is_ucontrol(vcpu->kvm))
-		gmap_free(vcpu->arch.gmap);
+		gmap_remove(vcpu->arch.gmap);
 
 	if (vcpu->kvm->arch.use_cmma)
 		kvm_s390_vcpu_unsetup_cmma(vcpu);
@@ -1460,7 +1460,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	debug_unregister(kvm->arch.dbf);
 	free_page((unsigned long)kvm->arch.sie_page2);
 	if (!kvm_is_ucontrol(kvm))
-		gmap_free(kvm->arch.gmap);
+		gmap_remove(kvm->arch.gmap);
 	kvm_s390_destroy_adapters(kvm);
 	kvm_s390_clear_float_irqs(kvm);
 	KVM_EVENT(3, "vm 0x%pK destroyed", kvm);
@@ -1469,7 +1469,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 /* Section: vcpu related */
 static int __kvm_ucontrol_vcpu_init(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.gmap = gmap_alloc(current->mm, -1UL);
+	vcpu->arch.gmap = gmap_create(current->mm, -1UL);
 	if (!vcpu->arch.gmap)
 		return -ENOMEM;
 	vcpu->arch.gmap->private = vcpu->kvm;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 480c076..fe25f19 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -21,13 +21,13 @@
 #include <asm/tlb.h>
 
 /**
- * gmap_alloc - allocate a guest address space
+ * gmap_alloc - allocate and initialize a guest address space
  * @mm: pointer to the parent mm_struct
  * @limit: maximum address of the gmap address space
  *
  * Returns a guest address space structure.
  */
-struct gmap *gmap_alloc(struct mm_struct *mm, unsigned long limit)
+static struct gmap *gmap_alloc(unsigned long limit)
 {
 	struct gmap *gmap;
 	struct page *page;
@@ -58,7 +58,7 @@ struct gmap *gmap_alloc(struct mm_struct *mm, unsigned long limit)
 	INIT_RADIX_TREE(&gmap->guest_to_host, GFP_KERNEL);
 	INIT_RADIX_TREE(&gmap->host_to_guest, GFP_ATOMIC);
 	spin_lock_init(&gmap->guest_table_lock);
-	gmap->mm = mm;
+	atomic_set(&gmap->ref_count, 1);
 	page = alloc_pages(GFP_KERNEL, 2);
 	if (!page)
 		goto out_free;
@@ -70,9 +70,6 @@ struct gmap *gmap_alloc(struct mm_struct *mm, unsigned long limit)
 	gmap->asce = atype | _ASCE_TABLE_LENGTH |
 		_ASCE_USER_BITS | __pa(table);
 	gmap->asce_end = limit;
-	spin_lock(&mm->context.gmap_lock);
-	list_add_rcu(&gmap->list, &mm->context.gmap_list);
-	spin_unlock(&mm->context.gmap_lock);
 	return gmap;
 
 out_free:
@@ -80,7 +77,28 @@ out_free:
 out:
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(gmap_alloc);
+
+/**
+ * gmap_create - create a guest address space
+ * @mm: pointer to the parent mm_struct
+ * @limit: maximum size of the gmap address space
+ *
+ * Returns a guest address space structure.
+ */
+struct gmap *gmap_create(struct mm_struct *mm, unsigned long limit)
+{
+	struct gmap *gmap;
+
+	gmap = gmap_alloc(limit);
+	if (!gmap)
+		return NULL;
+	gmap->mm = mm;
+	spin_lock(&mm->context.gmap_lock);
+	list_add_rcu(&gmap->list, &mm->context.gmap_list);
+	spin_unlock(&mm->context.gmap_lock);
+	return gmap;
+}
+EXPORT_SYMBOL_GPL(gmap_create);
 
 static void gmap_flush_tlb(struct gmap *gmap)
 {
@@ -118,21 +136,10 @@ static void gmap_radix_tree_free(struct radix_tree_root *root)
  * gmap_free - free a guest address space
  * @gmap: pointer to the guest address space structure
  */
-void gmap_free(struct gmap *gmap)
+static void gmap_free(struct gmap *gmap)
 {
 	struct page *page, *next;
 
-	/* Flush tlb. */
-	if (MACHINE_HAS_IDTE)
-		__tlb_flush_asce(gmap->mm, gmap->asce);
-	else
-		__tlb_flush_global();
-
-	spin_lock(&gmap->mm->context.gmap_lock);
-	list_del_rcu(&gmap->list);
-	spin_unlock(&gmap->mm->context.gmap_lock);
-	synchronize_rcu();
-
 	/* Free all segment & region tables. */
 	list_for_each_entry_safe(page, next, &gmap->crst_list, lru)
 		__free_pages(page, 2);
@@ -140,7 +147,50 @@ void gmap_free(struct gmap *gmap)
 	gmap_radix_tree_free(&gmap->host_to_guest);
 	kfree(gmap);
 }
-EXPORT_SYMBOL_GPL(gmap_free);
+
+/**
+ * gmap_get - increase reference counter for guest address space
+ * @gmap: pointer to the guest address space structure
+ *
+ * Returns the gmap pointer
+ */
+struct gmap *gmap_get(struct gmap *gmap)
+{
+	atomic_inc(&gmap->ref_count);
+	return gmap;
+}
+EXPORT_SYMBOL_GPL(gmap_get);
+
+/**
+ * gmap_put - decrease reference counter for guest address space
+ * @gmap: pointer to the guest address space structure
+ *
+ * If the reference counter reaches zero the guest address space is freed.
+ */
+void gmap_put(struct gmap *gmap)
+{
+	if (atomic_dec_return(&gmap->ref_count) == 0)
+		gmap_free(gmap);
+}
+EXPORT_SYMBOL_GPL(gmap_put);
+
+/**
+ * gmap_remove - remove a guest address space but do not free it yet
+ * @gmap: pointer to the guest address space structure
+ */
+void gmap_remove(struct gmap *gmap)
+{
+	/* Flush tlb. */
+	gmap_flush_tlb(gmap);
+	/* Remove gmap from the pre-mm list */
+	spin_lock(&gmap->mm->context.gmap_lock);
+	list_del_rcu(&gmap->list);
+	spin_unlock(&gmap->mm->context.gmap_lock);
+	synchronize_rcu();
+	/* Put reference */
+	gmap_put(gmap);
+}
+EXPORT_SYMBOL_GPL(gmap_remove);
 
 /**
  * gmap_enable - switch primary space to the guest address space
-- 
2.5.5
