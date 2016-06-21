From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/51] s390/mm: extended gmap pte notifier
Date: Tue, 21 Jun 2016 15:12:41 +0200
Message-ID: <1466514809-146638-4-git-send-email-borntraeger@de.ibm.com>
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

The current gmap pte notifier forces a pte into to a read-write state.
If the pte is invalidated the gmap notifier is called to inform KVM
that the mapping will go away.

Extend this approach to allow read-write, read-only and no-access
as possible target states and call the pte notifier for any change
to the pte.

This mechanism is used to temporarily set specific access rights for
a pte without doing the heavy work of a true mprotect call.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h    |   9 ++-
 arch/s390/include/asm/pgtable.h |   2 +
 arch/s390/kvm/kvm-s390.c        |  13 +--
 arch/s390/mm/gmap.c             | 170 ++++++++++++++++++++++++++++++----------
 arch/s390/mm/pgtable.c          |  54 +++++++++++--
 5 files changed, 193 insertions(+), 55 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 2cf49624..6897a09 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -59,8 +59,11 @@ void gmap_discard(struct gmap *, unsigned long from, unsigned long to);
 void __gmap_zap(struct gmap *, unsigned long gaddr);
 void gmap_unlink(struct mm_struct *, unsigned long *table, unsigned long vmaddr);
 
-void gmap_register_ipte_notifier(struct gmap_notifier *);
-void gmap_unregister_ipte_notifier(struct gmap_notifier *);
-int gmap_ipte_notify(struct gmap *, unsigned long start, unsigned long len);
+void gmap_register_pte_notifier(struct gmap_notifier *);
+void gmap_unregister_pte_notifier(struct gmap_notifier *);
+void gmap_pte_notify(struct mm_struct *, unsigned long addr, pte_t *);
+
+int gmap_mprotect_notify(struct gmap *, unsigned long start,
+			 unsigned long len, int prot);
 
 #endif /* _ASM_S390_GMAP_H */
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 9951e7e..35dde6a 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -886,6 +886,8 @@ void ptep_set_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t entry);
 void ptep_set_notify(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 void ptep_notify(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+int ptep_force_prot(struct mm_struct *mm, unsigned long gaddr,
+		    pte_t *ptep, int prot);
 void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep , int reset);
 void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 67f1b6b..b6e7f66 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+#include <linux/mman.h>
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/slab.h>
@@ -185,7 +186,7 @@ static struct notifier_block kvm_clock_notifier = {
 int kvm_arch_hardware_setup(void)
 {
 	gmap_notifier.notifier_call = kvm_gmap_notifier;
-	gmap_register_ipte_notifier(&gmap_notifier);
+	gmap_register_pte_notifier(&gmap_notifier);
 	atomic_notifier_chain_register(&s390_epoch_delta_notifier,
 				       &kvm_clock_notifier);
 	return 0;
@@ -193,7 +194,7 @@ int kvm_arch_hardware_setup(void)
 
 void kvm_arch_hardware_unsetup(void)
 {
-	gmap_unregister_ipte_notifier(&gmap_notifier);
+	gmap_unregister_pte_notifier(&gmap_notifier);
 	atomic_notifier_chain_unregister(&s390_epoch_delta_notifier,
 					 &kvm_clock_notifier);
 }
@@ -2272,16 +2273,16 @@ retry:
 		return 0;
 	/*
 	 * We use MMU_RELOAD just to re-arm the ipte notifier for the
-	 * guest prefix page. gmap_ipte_notify will wait on the ptl lock.
+	 * guest prefix page. gmap_mprotect_notify will wait on the ptl lock.
 	 * This ensures that the ipte instruction for this request has
 	 * already finished. We might race against a second unmapper that
 	 * wants to set the blocking bit. Lets just retry the request loop.
 	 */
 	if (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu)) {
 		int rc;
-		rc = gmap_ipte_notify(vcpu->arch.gmap,
-				      kvm_s390_get_prefix(vcpu),
-				      PAGE_SIZE * 2);
+		rc = gmap_mprotect_notify(vcpu->arch.gmap,
+					  kvm_s390_get_prefix(vcpu),
+					  PAGE_SIZE * 2, PROT_WRITE);
 		if (rc)
 			return rc;
 		goto retry;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 8b56423..480c076 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -553,29 +553,29 @@ static LIST_HEAD(gmap_notifier_list);
 static DEFINE_SPINLOCK(gmap_notifier_lock);
 
 /**
- * gmap_register_ipte_notifier - register a pte invalidation callback
+ * gmap_register_pte_notifier - register a pte invalidation callback
  * @nb: pointer to the gmap notifier block
  */
-void gmap_register_ipte_notifier(struct gmap_notifier *nb)
+void gmap_register_pte_notifier(struct gmap_notifier *nb)
 {
 	spin_lock(&gmap_notifier_lock);
 	list_add_rcu(&nb->list, &gmap_notifier_list);
 	spin_unlock(&gmap_notifier_lock);
 }
-EXPORT_SYMBOL_GPL(gmap_register_ipte_notifier);
+EXPORT_SYMBOL_GPL(gmap_register_pte_notifier);
 
 /**
- * gmap_unregister_ipte_notifier - remove a pte invalidation callback
+ * gmap_unregister_pte_notifier - remove a pte invalidation callback
  * @nb: pointer to the gmap notifier block
  */
-void gmap_unregister_ipte_notifier(struct gmap_notifier *nb)
+void gmap_unregister_pte_notifier(struct gmap_notifier *nb)
 {
 	spin_lock(&gmap_notifier_lock);
 	list_del_rcu(&nb->list);
 	spin_unlock(&gmap_notifier_lock);
 	synchronize_rcu();
 }
-EXPORT_SYMBOL_GPL(gmap_unregister_ipte_notifier);
+EXPORT_SYMBOL_GPL(gmap_unregister_pte_notifier);
 
 /**
  * gmap_call_notifier - call all registered invalidation callbacks
@@ -593,62 +593,150 @@ static void gmap_call_notifier(struct gmap *gmap, unsigned long start,
 }
 
 /**
- * gmap_ipte_notify - mark a range of ptes for invalidation notification
+ * gmap_table_walk - walk the gmap page tables
+ * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: virtual address in the guest address space
+ *
+ * Returns a table pointer for the given guest address.
+ */
+static inline unsigned long *gmap_table_walk(struct gmap *gmap,
+					     unsigned long gaddr)
+{
+	unsigned long *table;
+
+	table = gmap->table;
+	switch (gmap->asce & _ASCE_TYPE_MASK) {
+	case _ASCE_TYPE_REGION1:
+		table += (gaddr >> 53) & 0x7ff;
+		if (*table & _REGION_ENTRY_INVALID)
+			return NULL;
+		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
+		/* Fallthrough */
+	case _ASCE_TYPE_REGION2:
+		table += (gaddr >> 42) & 0x7ff;
+		if (*table & _REGION_ENTRY_INVALID)
+			return NULL;
+		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
+		/* Fallthrough */
+	case _ASCE_TYPE_REGION3:
+		table += (gaddr >> 31) & 0x7ff;
+		if (*table & _REGION_ENTRY_INVALID)
+			return NULL;
+		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
+		/* Fallthrough */
+	case _ASCE_TYPE_SEGMENT:
+		table += (gaddr >> 20) & 0x7ff;
+	}
+	return table;
+}
+
+/**
+ * gmap_pte_op_walk - walk the gmap page table, get the page table lock
+ *		      and return the pte pointer
+ * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: virtual address in the guest address space
+ * @ptl: pointer to the spinlock pointer
+ *
+ * Returns a pointer to the locked pte for a guest address, or NULL
+ */
+static pte_t *gmap_pte_op_walk(struct gmap *gmap, unsigned long gaddr,
+			       spinlock_t **ptl)
+{
+	unsigned long *table;
+
+	/* Walk the gmap page table, lock and get pte pointer */
+	table = gmap_table_walk(gmap, gaddr);
+	if (!table || *table & _SEGMENT_ENTRY_INVALID)
+		return NULL;
+	return pte_alloc_map_lock(gmap->mm, (pmd_t *) table, gaddr, ptl);
+}
+
+/**
+ * gmap_pte_op_fixup - force a page in and connect the gmap page table
+ * @gmap: pointer to guest mapping meta data structure
+ * @gaddr: virtual address in the guest address space
+ * @vmaddr: address in the host process address space
+ *
+ * Returns 0 if the caller can retry __gmap_translate (might fail again),
+ * -ENOMEM if out of memory and -EFAULT if anything goes wrong while fixing
+ * up or connecting the gmap page table.
+ */
+static int gmap_pte_op_fixup(struct gmap *gmap, unsigned long gaddr,
+			     unsigned long vmaddr)
+{
+	struct mm_struct *mm = gmap->mm;
+	bool unlocked = false;
+
+	if (fixup_user_fault(current, mm, vmaddr, FAULT_FLAG_WRITE, &unlocked))
+		return -EFAULT;
+	if (unlocked)
+		/* lost mmap_sem, caller has to retry __gmap_translate */
+		return 0;
+	/* Connect the page tables */
+	return __gmap_link(gmap, gaddr, vmaddr);
+}
+
+/**
+ * gmap_pte_op_end - release the page table lock
+ * @ptl: pointer to the spinlock pointer
+ */
+static void gmap_pte_op_end(spinlock_t *ptl)
+{
+	spin_unlock(ptl);
+}
+
+/**
+ * gmap_mprotect_notify - change access rights for a range of ptes and
+ *                        call the notifier if any pte changes again
  * @gmap: pointer to guest mapping meta data structure
  * @gaddr: virtual address in the guest address space
  * @len: size of area
+ * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
  *
- * Returns 0 if for each page in the given range a gmap mapping exists and
- * the invalidation notification could be set. If the gmap mapping is missing
- * for one or more pages -EFAULT is returned. If no memory could be allocated
- * -ENOMEM is returned. This function establishes missing page table entries.
+ * Returns 0 if for each page in the given range a gmap mapping exists,
+ * the new access rights could be set and the notifier could be armed.
+ * If the gmap mapping is missing for one or more pages -EFAULT is
+ * returned. If no memory could be allocated -ENOMEM is returned.
+ * This function establishes missing page table entries.
  */
-int gmap_ipte_notify(struct gmap *gmap, unsigned long gaddr, unsigned long len)
+int gmap_mprotect_notify(struct gmap *gmap, unsigned long gaddr,
+			 unsigned long len, int prot)
 {
-	unsigned long addr;
+	unsigned long vmaddr;
 	spinlock_t *ptl;
 	pte_t *ptep;
-	bool unlocked;
 	int rc = 0;
 
 	if ((gaddr & ~PAGE_MASK) || (len & ~PAGE_MASK))
 		return -EINVAL;
+	if (!MACHINE_HAS_ESOP && prot == PROT_READ)
+		return -EINVAL;
 	down_read(&gmap->mm->mmap_sem);
 	while (len) {
-		unlocked = false;
-		/* Convert gmap address and connect the page tables */
-		addr = __gmap_translate(gmap, gaddr);
-		if (IS_ERR_VALUE(addr)) {
-			rc = addr;
-			break;
+		rc = -EAGAIN;
+		ptep = gmap_pte_op_walk(gmap, gaddr, &ptl);
+		if (ptep) {
+			rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot);
+			gmap_pte_op_end(ptl);
 		}
-		/* Get the page mapped */
-		if (fixup_user_fault(current, gmap->mm, addr, FAULT_FLAG_WRITE,
-				     &unlocked)) {
-			rc = -EFAULT;
-			break;
-		}
-		/* While trying to map mmap_sem got unlocked. Let us retry */
-		if (unlocked)
+		if (rc) {
+			vmaddr = __gmap_translate(gmap, gaddr);
+			if (IS_ERR_VALUE(vmaddr)) {
+				rc = vmaddr;
+				break;
+			}
+			rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr);
+			if (rc)
+				break;
 			continue;
-		rc = __gmap_link(gmap, gaddr, addr);
-		if (rc)
-			break;
-		/* Walk the process page table, lock and get pte pointer */
-		ptep = get_locked_pte(gmap->mm, addr, &ptl);
-		VM_BUG_ON(!ptep);
-		/* Set notification bit in the pgste of the pte */
-		if ((pte_val(*ptep) & (_PAGE_INVALID | _PAGE_PROTECT)) == 0) {
-			ptep_set_notify(gmap->mm, addr, ptep);
-			gaddr += PAGE_SIZE;
-			len -= PAGE_SIZE;
 		}
-		pte_unmap_unlock(ptep, ptl);
+		gaddr += PAGE_SIZE;
+		len -= PAGE_SIZE;
 	}
 	up_read(&gmap->mm->mmap_sem);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(gmap_ipte_notify);
+EXPORT_SYMBOL_GPL(gmap_mprotect_notify);
 
 /**
  * ptep_notify - call all invalidation callbacks for a specific pte.
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index fa286d0..ab65fb1 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -179,9 +179,9 @@ static inline pgste_t pgste_set_pte(pte_t *ptep, pgste_t pgste, pte_t entry)
 	return pgste;
 }
 
-static inline pgste_t pgste_ipte_notify(struct mm_struct *mm,
-					unsigned long addr,
-					pte_t *ptep, pgste_t pgste)
+static inline pgste_t pgste_pte_notify(struct mm_struct *mm,
+				       unsigned long addr,
+				       pte_t *ptep, pgste_t pgste)
 {
 #ifdef CONFIG_PGSTE
 	if (pgste_val(pgste) & PGSTE_IN_BIT) {
@@ -199,7 +199,7 @@ static inline pgste_t ptep_xchg_start(struct mm_struct *mm,
 
 	if (mm_has_pgste(mm)) {
 		pgste = pgste_get_lock(ptep);
-		pgste = pgste_ipte_notify(mm, addr, ptep, pgste);
+		pgste = pgste_pte_notify(mm, addr, ptep, pgste);
 	}
 	return pgste;
 }
@@ -414,6 +414,50 @@ void ptep_set_notify(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 	pgste_set_unlock(ptep, pgste);
 }
 
+/**
+ * ptep_force_prot - change access rights of a locked pte
+ * @mm: pointer to the process mm_struct
+ * @addr: virtual address in the guest address space
+ * @ptep: pointer to the page table entry
+ * @prot: indicates guest access rights: PROT_NONE, PROT_READ or PROT_WRITE
+ *
+ * Returns 0 if the access rights were changed and -EAGAIN if the current
+ * and requested access rights are incompatible.
+ */
+int ptep_force_prot(struct mm_struct *mm, unsigned long addr,
+		    pte_t *ptep, int prot)
+{
+	pte_t entry;
+	pgste_t pgste;
+	int pte_i, pte_p;
+
+	pgste = pgste_get_lock(ptep);
+	entry = *ptep;
+	/* Check pte entry after all locks have been acquired */
+	pte_i = pte_val(entry) & _PAGE_INVALID;
+	pte_p = pte_val(entry) & _PAGE_PROTECT;
+	if ((pte_i && (prot != PROT_NONE)) ||
+	    (pte_p && (prot & PROT_WRITE))) {
+		pgste_set_unlock(ptep, pgste);
+		return -EAGAIN;
+	}
+	/* Change access rights and set the pgste notification bit */
+	if (prot == PROT_NONE && !pte_i) {
+		ptep_flush_direct(mm, addr, ptep);
+		pgste = pgste_update_all(entry, pgste, mm);
+		pte_val(entry) |= _PAGE_INVALID;
+	}
+	if (prot == PROT_READ && !pte_p) {
+		ptep_flush_direct(mm, addr, ptep);
+		pte_val(entry) &= ~_PAGE_INVALID;
+		pte_val(entry) |= _PAGE_PROTECT;
+	}
+	pgste_val(pgste) |= PGSTE_IN_BIT;
+	pgste = pgste_set_pte(ptep, pgste, entry);
+	pgste_set_unlock(ptep, pgste);
+	return 0;
+}
+
 static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 {
 	if (!non_swap_entry(entry))
@@ -483,7 +527,7 @@ bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long addr)
 	pgste_val(pgste) &= ~PGSTE_UC_BIT;
 	pte = *ptep;
 	if (dirty && (pte_val(pte) & _PAGE_PRESENT)) {
-		pgste = pgste_ipte_notify(mm, addr, ptep, pgste);
+		pgste = pgste_pte_notify(mm, addr, ptep, pgste);
 		__ptep_ipte(addr, ptep);
 		if (MACHINE_HAS_ESOP || !(pte_val(pte) & _PAGE_WRITE))
 			pte_val(pte) |= _PAGE_PROTECT;
-- 
2.5.5
