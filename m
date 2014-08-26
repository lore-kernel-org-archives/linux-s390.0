From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 12/15] KVM: s390/mm: cleanup gmap function arguments, variable names
Date: Tue, 26 Aug 2014 10:28:24 +0200
Message-ID: <1409041707-39938-13-git-send-email-borntraeger@de.ibm.com>
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

Make the order of arguments for the gmap calls more consistent,
if the gmap pointer is passed it is always the first argument.
In addition distinguish between guest address and user address
by naming the variables gaddr for a guest address and vmaddr for
a user address.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h |  14 ++---
 arch/s390/kvm/diag.c            |   8 +--
 arch/s390/kvm/interrupt.c       |   2 +-
 arch/s390/kvm/kvm-s390.c        |   4 +-
 arch/s390/kvm/priv.c            |   2 +-
 arch/s390/mm/fault.c            |   2 +-
 arch/s390/mm/pgtable.c          | 110 ++++++++++++++++++++--------------------
 7 files changed, 72 insertions(+), 70 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 4cd91ac..d95012f 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -834,7 +834,7 @@ struct gmap_pgtable {
  */
 struct gmap_notifier {
 	struct list_head list;
-	void (*notifier_call)(struct gmap *gmap, unsigned long address);
+	void (*notifier_call)(struct gmap *gmap, unsigned long gaddr);
 };
 
 struct gmap *gmap_alloc(struct mm_struct *mm);
@@ -844,12 +844,12 @@ void gmap_disable(struct gmap *gmap);
 int gmap_map_segment(struct gmap *gmap, unsigned long from,
 		     unsigned long to, unsigned long len);
 int gmap_unmap_segment(struct gmap *gmap, unsigned long to, unsigned long len);
-unsigned long __gmap_translate(unsigned long address, struct gmap *);
-unsigned long gmap_translate(unsigned long address, struct gmap *);
-unsigned long __gmap_fault(unsigned long address, struct gmap *);
-unsigned long gmap_fault(unsigned long address, struct gmap *);
-void gmap_discard(unsigned long from, unsigned long to, struct gmap *);
-void __gmap_zap(unsigned long address, struct gmap *);
+unsigned long __gmap_translate(struct gmap *, unsigned long gaddr);
+unsigned long gmap_translate(struct gmap *, unsigned long gaddr);
+unsigned long __gmap_fault(struct gmap *, unsigned long gaddr);
+unsigned long gmap_fault(struct gmap *, unsigned long gaddr);
+void gmap_discard(struct gmap *, unsigned long from, unsigned long to);
+void __gmap_zap(struct gmap *, unsigned long gaddr);
 bool gmap_test_and_clear_dirty(unsigned long address, struct gmap *);
 
 
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 59bd8f9..b374b6c 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -37,13 +37,13 @@ static int diag_release_pages(struct kvm_vcpu *vcpu)
 
 	/* we checked for start > end above */
 	if (end < prefix || start >= prefix + 2 * PAGE_SIZE) {
-		gmap_discard(start, end, vcpu->arch.gmap);
+		gmap_discard(vcpu->arch.gmap, start, end);
 	} else {
 		if (start < prefix)
-			gmap_discard(start, prefix, vcpu->arch.gmap);
+			gmap_discard(vcpu->arch.gmap, start, prefix);
 		if (end >= prefix)
-			gmap_discard(prefix + 2 * PAGE_SIZE,
-				     end, vcpu->arch.gmap);
+			gmap_discard(vcpu->arch.gmap,
+				     prefix + 2 * PAGE_SIZE, end);
 	}
 	return 0;
 }
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index ba89bbb..60a5cf4 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1241,7 +1241,7 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
 	}
 	INIT_LIST_HEAD(&map->list);
 	map->guest_addr = addr;
-	map->addr = gmap_translate(addr, kvm->arch.gmap);
+	map->addr = gmap_translate(kvm->arch.gmap, addr);
 	if (map->addr == -EFAULT) {
 		ret = -EFAULT;
 		goto out;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c2caa17..5c877c8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1096,7 +1096,7 @@ long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable)
 	hva_t hva;
 	long rc;
 
-	hva = gmap_fault(gpa, vcpu->arch.gmap);
+	hva = gmap_fault(vcpu->arch.gmap, gpa);
 	if (IS_ERR_VALUE(hva))
 		return (long)hva;
 	down_read(&mm->mmap_sem);
@@ -1683,7 +1683,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 #endif
 	case KVM_S390_VCPU_FAULT: {
-		r = gmap_fault(arg, vcpu->arch.gmap);
+		r = gmap_fault(vcpu->arch.gmap, arg);
 		if (!IS_ERR_VALUE(r))
 			r = 0;
 		break;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index d806f2c..72bb2dd 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -729,7 +729,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 			/* invalid entry */
 			break;
 		/* try to free backing */
-		__gmap_zap(cbrle, gmap);
+		__gmap_zap(gmap, cbrle);
 	}
 	up_read(&gmap->mm->mmap_sem);
 	if (i < entries)
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 3f3b354..4880399 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -445,7 +445,7 @@ static inline int do_exception(struct pt_regs *regs, int access)
 	gmap = (struct gmap *)
 		((current->flags & PF_VCPU) ? S390_lowcore.gmap : 0);
 	if (gmap) {
-		address = __gmap_fault(address, gmap);
+		address = __gmap_fault(gmap, address);
 		if (address == -EFAULT) {
 			fault = VM_FAULT_BADMAP;
 			goto out_up;
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index c09820d..16ca861 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -295,7 +295,7 @@ static int gmap_alloc_table(struct gmap *gmap,
 /**
  * gmap_unmap_segment - unmap segment from the guest address space
  * @gmap: pointer to the guest address space structure
- * @addr: address in the guest address space
+ * @to: address in the guest address space
  * @len: length of the memory area to unmap
  *
  * Returns 0 if the unmap succeeded, -EINVAL if not.
@@ -348,6 +348,7 @@ EXPORT_SYMBOL_GPL(gmap_unmap_segment);
  * @gmap: pointer to the guest address space structure
  * @from: source address in the parent address space
  * @to: target address in the guest address space
+ * @len: length of the memory area to map
  *
  * Returns 0 if the mmap succeeded, -EINVAL or -ENOMEM if not.
  */
@@ -405,30 +406,30 @@ out_unmap:
 }
 EXPORT_SYMBOL_GPL(gmap_map_segment);
 
-static unsigned long *gmap_table_walk(unsigned long address, struct gmap *gmap)
+static unsigned long *gmap_table_walk(struct gmap *gmap, unsigned long gaddr)
 {
 	unsigned long *table;
 
-	table = gmap->table + ((address >> 53) & 0x7ff);
+	table = gmap->table + ((gaddr >> 53) & 0x7ff);
 	if (unlikely(*table & _REGION_ENTRY_INVALID))
 		return ERR_PTR(-EFAULT);
 	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-	table = table + ((address >> 42) & 0x7ff);
+	table = table + ((gaddr >> 42) & 0x7ff);
 	if (unlikely(*table & _REGION_ENTRY_INVALID))
 		return ERR_PTR(-EFAULT);
 	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-	table = table + ((address >> 31) & 0x7ff);
+	table = table + ((gaddr >> 31) & 0x7ff);
 	if (unlikely(*table & _REGION_ENTRY_INVALID))
 		return ERR_PTR(-EFAULT);
 	table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-	table = table + ((address >> 20) & 0x7ff);
+	table = table + ((gaddr >> 20) & 0x7ff);
 	return table;
 }
 
 /**
  * __gmap_translate - translate a guest address to a user space address
- * @address: guest address
  * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: guest address
  *
  * Returns user space address which corresponds to the guest address or
  * -EFAULT if no such mapping exists.
@@ -436,14 +437,14 @@ static unsigned long *gmap_table_walk(unsigned long address, struct gmap *gmap)
  * The mmap_sem of the mm that belongs to the address space must be held
  * when this function gets called.
  */
-unsigned long __gmap_translate(unsigned long address, struct gmap *gmap)
+unsigned long __gmap_translate(struct gmap *gmap, unsigned long gaddr)
 {
 	unsigned long *segment_ptr, vmaddr, segment;
 	struct gmap_pgtable *mp;
 	struct page *page;
 
-	current->thread.gmap_addr = address;
-	segment_ptr = gmap_table_walk(address, gmap);
+	current->thread.gmap_addr = gaddr;
+	segment_ptr = gmap_table_walk(gmap, gaddr);
 	if (IS_ERR(segment_ptr))
 		return PTR_ERR(segment_ptr);
 	/* Convert the gmap address to an mm address. */
@@ -451,10 +452,10 @@ unsigned long __gmap_translate(unsigned long address, struct gmap *gmap)
 	if (!(segment & _SEGMENT_ENTRY_INVALID)) {
 		page = pfn_to_page(segment >> PAGE_SHIFT);
 		mp = (struct gmap_pgtable *) page->index;
-		return mp->vmaddr | (address & ~PMD_MASK);
+		return mp->vmaddr | (gaddr & ~PMD_MASK);
 	} else if (segment & _SEGMENT_ENTRY_PROTECT) {
 		vmaddr = segment & _SEGMENT_ENTRY_ORIGIN;
-		return vmaddr | (address & ~PMD_MASK);
+		return vmaddr | (gaddr & ~PMD_MASK);
 	}
 	return -EFAULT;
 }
@@ -462,26 +463,27 @@ EXPORT_SYMBOL_GPL(__gmap_translate);
 
 /**
  * gmap_translate - translate a guest address to a user space address
- * @address: guest address
  * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: guest address
  *
  * Returns user space address which corresponds to the guest address or
  * -EFAULT if no such mapping exists.
  * This function does not establish potentially missing page table entries.
  */
-unsigned long gmap_translate(unsigned long address, struct gmap *gmap)
+unsigned long gmap_translate(struct gmap *gmap, unsigned long gaddr)
 {
 	unsigned long rc;
 
 	down_read(&gmap->mm->mmap_sem);
-	rc = __gmap_translate(address, gmap);
+	rc = __gmap_translate(gmap, gaddr);
 	up_read(&gmap->mm->mmap_sem);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(gmap_translate);
 
-static int gmap_connect_pgtable(unsigned long address, unsigned long segment,
-				unsigned long *segment_ptr, struct gmap *gmap)
+static int gmap_connect_pgtable(struct gmap *gmap, unsigned long gaddr,
+				unsigned long segment,
+				unsigned long *segment_ptr)
 {
 	unsigned long vmaddr;
 	struct vm_area_struct *vma;
@@ -521,7 +523,7 @@ static int gmap_connect_pgtable(unsigned long address, unsigned long segment,
 	mp = (struct gmap_pgtable *) page->index;
 	rmap->gmap = gmap;
 	rmap->entry = segment_ptr;
-	rmap->vmaddr = address & PMD_MASK;
+	rmap->vmaddr = gaddr & PMD_MASK;
 	spin_lock(&mm->page_table_lock);
 	if (*segment_ptr == segment) {
 		list_add(&rmap->list, &mp->mapper);
@@ -560,15 +562,15 @@ static void gmap_disconnect_pgtable(struct mm_struct *mm, unsigned long *table)
 /*
  * this function is assumed to be called with mmap_sem held
  */
-unsigned long __gmap_fault(unsigned long address, struct gmap *gmap)
+unsigned long __gmap_fault(struct gmap *gmap, unsigned long gaddr)
 {
 	unsigned long *segment_ptr, segment;
 	struct gmap_pgtable *mp;
 	struct page *page;
 	int rc;
 
-	current->thread.gmap_addr = address;
-	segment_ptr = gmap_table_walk(address, gmap);
+	current->thread.gmap_addr = gaddr;
+	segment_ptr = gmap_table_walk(gmap, gaddr);
 	if (IS_ERR(segment_ptr))
 		return -EFAULT;
 	/* Convert the gmap address to an mm address. */
@@ -578,24 +580,24 @@ unsigned long __gmap_fault(unsigned long address, struct gmap *gmap)
 			/* Page table is present */
 			page = pfn_to_page(segment >> PAGE_SHIFT);
 			mp = (struct gmap_pgtable *) page->index;
-			return mp->vmaddr | (address & ~PMD_MASK);
+			return mp->vmaddr | (gaddr & ~PMD_MASK);
 		}
 		if (!(segment & _SEGMENT_ENTRY_PROTECT))
 			/* Nothing mapped in the gmap address space. */
 			break;
-		rc = gmap_connect_pgtable(address, segment, segment_ptr, gmap);
+		rc = gmap_connect_pgtable(gmap, gaddr, segment, segment_ptr);
 		if (rc)
 			return rc;
 	}
 	return -EFAULT;
 }
 
-unsigned long gmap_fault(unsigned long address, struct gmap *gmap)
+unsigned long gmap_fault(struct gmap *gmap, unsigned long gaddr)
 {
 	unsigned long rc;
 
 	down_read(&gmap->mm->mmap_sem);
-	rc = __gmap_fault(address, gmap);
+	rc = __gmap_fault(gmap, gaddr);
 	up_read(&gmap->mm->mmap_sem);
 
 	return rc;
@@ -620,14 +622,14 @@ static void gmap_zap_swap_entry(swp_entry_t entry, struct mm_struct *mm)
 /**
  * The mm->mmap_sem lock must be held
  */
-static void gmap_zap_unused(struct mm_struct *mm, unsigned long address)
+static void gmap_zap_unused(struct mm_struct *mm, unsigned long vmaddr)
 {
 	unsigned long ptev, pgstev;
 	spinlock_t *ptl;
 	pgste_t pgste;
 	pte_t *ptep, pte;
 
-	ptep = get_locked_pte(mm, address, &ptl);
+	ptep = get_locked_pte(mm, vmaddr, &ptl);
 	if (unlikely(!ptep))
 		return;
 	pte = *ptep;
@@ -640,7 +642,7 @@ static void gmap_zap_unused(struct mm_struct *mm, unsigned long address)
 	if (((pgstev & _PGSTE_GPS_USAGE_MASK) == _PGSTE_GPS_USAGE_UNUSED) ||
 	    ((pgstev & _PGSTE_GPS_ZERO) && (ptev & _PAGE_INVALID))) {
 		gmap_zap_swap_entry(pte_to_swp_entry(pte), mm);
-		pte_clear(mm, address, ptep);
+		pte_clear(mm, vmaddr, ptep);
 	}
 	pgste_set_unlock(ptep, pgste);
 out_pte:
@@ -650,14 +652,14 @@ out_pte:
 /*
  * this function is assumed to be called with mmap_sem held
  */
-void __gmap_zap(unsigned long address, struct gmap *gmap)
+void __gmap_zap(struct gmap *gmap, unsigned long gaddr)
 {
 	unsigned long *table, *segment_ptr;
-	unsigned long segment, pgstev, ptev;
+	unsigned long segment, vmaddr, pgstev, ptev;
 	struct gmap_pgtable *mp;
 	struct page *page;
 
-	segment_ptr = gmap_table_walk(address, gmap);
+	segment_ptr = gmap_table_walk(gmap, gaddr);
 	if (IS_ERR(segment_ptr))
 		return;
 	segment = *segment_ptr;
@@ -665,61 +667,61 @@ void __gmap_zap(unsigned long address, struct gmap *gmap)
 		return;
 	page = pfn_to_page(segment >> PAGE_SHIFT);
 	mp = (struct gmap_pgtable *) page->index;
-	address = mp->vmaddr | (address & ~PMD_MASK);
+	vmaddr = mp->vmaddr | (gaddr & ~PMD_MASK);
 	/* Page table is present */
 	table = (unsigned long *)(segment & _SEGMENT_ENTRY_ORIGIN);
-	table = table + ((address >> 12) & 0xff);
+	table = table + ((vmaddr >> 12) & 0xff);
 	pgstev = table[PTRS_PER_PTE];
 	ptev = table[0];
 	/* quick check, checked again with locks held */
 	if (((pgstev & _PGSTE_GPS_USAGE_MASK) == _PGSTE_GPS_USAGE_UNUSED) ||
 	    ((pgstev & _PGSTE_GPS_ZERO) && (ptev & _PAGE_INVALID)))
-		gmap_zap_unused(gmap->mm, address);
+		gmap_zap_unused(gmap->mm, vmaddr);
 }
 EXPORT_SYMBOL_GPL(__gmap_zap);
 
-void gmap_discard(unsigned long from, unsigned long to, struct gmap *gmap)
+void gmap_discard(struct gmap *gmap, unsigned long from, unsigned long to)
 {
 
-	unsigned long *table, address, size;
+	unsigned long *table, gaddr, size;
 	struct vm_area_struct *vma;
 	struct gmap_pgtable *mp;
 	struct page *page;
 
 	down_read(&gmap->mm->mmap_sem);
-	address = from;
-	while (address < to) {
+	gaddr = from;
+	while (gaddr < to) {
 		/* Walk the gmap address space page table */
-		table = gmap->table + ((address >> 53) & 0x7ff);
+		table = gmap->table + ((gaddr >> 53) & 0x7ff);
 		if (unlikely(*table & _REGION_ENTRY_INVALID)) {
-			address = (address + PMD_SIZE) & PMD_MASK;
+			gaddr = (gaddr + PMD_SIZE) & PMD_MASK;
 			continue;
 		}
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		table = table + ((address >> 42) & 0x7ff);
+		table = table + ((gaddr >> 42) & 0x7ff);
 		if (unlikely(*table & _REGION_ENTRY_INVALID)) {
-			address = (address + PMD_SIZE) & PMD_MASK;
+			gaddr = (gaddr + PMD_SIZE) & PMD_MASK;
 			continue;
 		}
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		table = table + ((address >> 31) & 0x7ff);
+		table = table + ((gaddr >> 31) & 0x7ff);
 		if (unlikely(*table & _REGION_ENTRY_INVALID)) {
-			address = (address + PMD_SIZE) & PMD_MASK;
+			gaddr = (gaddr + PMD_SIZE) & PMD_MASK;
 			continue;
 		}
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		table = table + ((address >> 20) & 0x7ff);
+		table = table + ((gaddr >> 20) & 0x7ff);
 		if (unlikely(*table & _SEGMENT_ENTRY_INVALID)) {
-			address = (address + PMD_SIZE) & PMD_MASK;
+			gaddr = (gaddr + PMD_SIZE) & PMD_MASK;
 			continue;
 		}
 		page = pfn_to_page(*table >> PAGE_SHIFT);
 		mp = (struct gmap_pgtable *) page->index;
 		vma = find_vma(gmap->mm, mp->vmaddr);
-		size = min(to - address, PMD_SIZE - (address & ~PMD_MASK));
-		zap_page_range(vma, mp->vmaddr | (address & ~PMD_MASK),
+		size = min(to - gaddr, PMD_SIZE - (gaddr & ~PMD_MASK));
+		zap_page_range(vma, mp->vmaddr | (gaddr & ~PMD_MASK),
 			       size, NULL);
-		address = (address + PMD_SIZE) & PMD_MASK;
+		gaddr = (gaddr + PMD_SIZE) & PMD_MASK;
 	}
 	up_read(&gmap->mm->mmap_sem);
 }
@@ -755,7 +757,7 @@ EXPORT_SYMBOL_GPL(gmap_unregister_ipte_notifier);
 /**
  * gmap_ipte_notify - mark a range of ptes for invalidation notification
  * @gmap: pointer to guest mapping meta data structure
- * @start: virtual address in the guest address space
+ * @gaddr: virtual address in the guest address space
  * @len: size of area
  *
  * Returns 0 if for each page in the given range a gmap mapping exists and
@@ -763,7 +765,7 @@ EXPORT_SYMBOL_GPL(gmap_unregister_ipte_notifier);
  * for one or more pages -EFAULT is returned. If no memory could be allocated
  * -ENOMEM is returned. This function establishes missing page table entries.
  */
-int gmap_ipte_notify(struct gmap *gmap, unsigned long start, unsigned long len)
+int gmap_ipte_notify(struct gmap *gmap, unsigned long gaddr, unsigned long len)
 {
 	unsigned long addr;
 	spinlock_t *ptl;
@@ -771,12 +773,12 @@ int gmap_ipte_notify(struct gmap *gmap, unsigned long start, unsigned long len)
 	pgste_t pgste;
 	int rc = 0;
 
-	if ((start & ~PAGE_MASK) || (len & ~PAGE_MASK))
+	if ((gaddr & ~PAGE_MASK) || (len & ~PAGE_MASK))
 		return -EINVAL;
 	down_read(&gmap->mm->mmap_sem);
 	while (len) {
 		/* Convert gmap address and connect the page tables */
-		addr = __gmap_fault(start, gmap);
+		addr = __gmap_fault(gmap, gaddr);
 		if (IS_ERR_VALUE(addr)) {
 			rc = addr;
 			break;
@@ -796,7 +798,7 @@ int gmap_ipte_notify(struct gmap *gmap, unsigned long start, unsigned long len)
 			pgste = pgste_get_lock(ptep);
 			pgste_val(pgste) |= PGSTE_IN_BIT;
 			pgste_set_unlock(ptep, pgste);
-			start += PAGE_SIZE;
+			gaddr += PAGE_SIZE;
 			len -= PAGE_SIZE;
 		}
 		spin_unlock(ptl);
-- 
1.8.4.2
