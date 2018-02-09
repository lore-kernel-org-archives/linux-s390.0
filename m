From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v3 09/16] s390/mm: Add shadow segment code
Date: Fri,  9 Feb 2018 10:34:17 +0100
Message-ID: <1518168864-147803-10-git-send-email-frankja@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The VSIE code does not yet support shadowing large hosts. Let's add
large to large shadowing.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/gmap.h |   7 +-
 arch/s390/kvm/gaccess.c      |  35 ++++-
 arch/s390/mm/gmap.c          | 332 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 314 insertions(+), 60 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index e7592e1..8387fdc 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -17,6 +17,7 @@
 #define _SEGMENT_ENTRY_GMAP_SPLIT	0x0001  /* split huge pmd */
 /* Status bits only for huge segment entries */
 #define _SEGMENT_ENTRY_GMAP_UC		0x4000	/* user dirty (migration) */
+#define _SEGMENT_ENTRY_GMAP_VSIE	0x8000	/* vsie bit */
 
 /**
  * struct gmap_struct - guest address space
@@ -141,9 +142,11 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 		    int fake);
 int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 		    int fake);
-int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
-			   unsigned long *pgt, int *dat_protection, int *fake);
+int gmap_shadow_sgt_lookup(struct gmap *sg, unsigned long saddr,
+			   unsigned long *pgt, int *dat_protection,
+			   int *fake);
 int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte);
+int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd);
 
 void gmap_register_pte_notifier(struct gmap_notifier *);
 void gmap_unregister_pte_notifier(struct gmap_notifier *);
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index f9c5cc0..045d12e 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -981,7 +981,7 @@ int kvm_s390_check_low_addr_prot_real(struct kvm_vcpu *vcpu, unsigned long gra)
  */
 static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 				  unsigned long *pgt, int *dat_protection,
-				  int *fake)
+				  int *fake, int *lvl)
 {
 	struct gmap *parent;
 	union asce asce;
@@ -1136,6 +1136,17 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		if (ste.cs && asce.p)
 			return PGM_TRANSLATION_SPEC;
 		*dat_protection |= ste.fc0.p;
+
+		/* Parent is mapped by huge pages. */
+		if (fc) {
+			/* Guest is also huge, easy case. */
+			if (ste.fc && sg->edat_level >= 1) {
+				*lvl = 1;
+				*pgt = ptr;
+				return 0;
+			}
+		}
+		/* Small to small and small to huge case */
 		if (ste.fc && sg->edat_level >= 1) {
 			*fake = 1;
 			ptr = ste.fc1.sfaa * _SEGMENT_SIZE;
@@ -1172,8 +1183,9 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 {
 	union vaddress vaddr;
 	union page_table_entry pte;
+	union segment_table_entry ste;
 	unsigned long pgt;
-	int dat_protection, fake, fc;
+	int dat_protection, fake, lvl, fc;
 	int rc;
 
 	down_read(&sg->mm->mmap_sem);
@@ -1184,12 +1196,26 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	 */
 	ipte_lock(vcpu);
 
-	rc = gmap_shadow_pgt_lookup(sg, saddr, &pgt, &dat_protection, &fake);
+	rc = gmap_shadow_sgt_lookup(sg, saddr, &pgt, &dat_protection, &fake);
 	if (rc)
 		rc = kvm_s390_shadow_tables(sg, saddr, &pgt, &dat_protection,
-					    &fake);
+					    &fake, &lvl);
 
 	vaddr.addr = saddr;
+
+	/* Shadow stopped at segment level, we map pmd to pmd */
+	if (lvl) {
+		if (!rc)
+			rc = gmap_read_table(sg->parent, pgt + vaddr.sx * 8,
+					     &ste.val, &fc);
+		if (!rc && ste.i)
+			rc = PGM_PAGE_TRANSLATION;
+		ste.fc1.p |= dat_protection;
+		if (!rc)
+			rc = gmap_shadow_segment(sg, saddr, __pmd(ste.val));
+		goto out;
+	}
+
 	if (fake) {
 		pte.val = pgt + vaddr.px * PAGE_SIZE;
 		goto shadow_page;
@@ -1204,6 +1230,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	pte.p |= dat_protection;
 	if (!rc)
 		rc = gmap_shadow_page(sg, saddr, __pte(pte.val));
+out:
 	ipte_unlock(vcpu);
 	up_read(&sg->mm->mmap_sem);
 	return rc;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 66789e2..f805ec9 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1405,6 +1405,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 		if (IS_ERR_VALUE(vmaddr))
 			return vmaddr;
 		hpmdp = (pmd_t *)huge_pte_offset(parent->mm, vmaddr, HPAGE_SIZE);
+		/* Do we need tests here? */
 		ptl = pmd_lock(parent->mm, hpmdp);
 		rmap = kzalloc(sizeof(*rmap), GFP_KERNEL);
 		if (!rmap) {
@@ -1450,6 +1451,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 }
 
 #define _SHADOW_RMAP_MASK	0x7
+#define _SHADOW_RMAP_SEGMENT_LP	0x6
 #define _SHADOW_RMAP_REGION1	0x5
 #define _SHADOW_RMAP_REGION2	0x4
 #define _SHADOW_RMAP_REGION3	0x3
@@ -1557,13 +1559,16 @@ static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 	for (i = 0; i < _CRST_ENTRIES; i++, raddr += _SEGMENT_SIZE) {
 		if (!(sgt[i] & _SEGMENT_ENTRY_ORIGIN))
 			continue;
-		pgt = (unsigned long *)(sgt[i] & _REGION_ENTRY_ORIGIN);
+
+		if (!(sgt[i] & _SEGMENT_ENTRY_LARGE)) {
+			pgt = (unsigned long *)(sgt[i] & _REGION_ENTRY_ORIGIN);
+			__gmap_unshadow_pgt(sg, raddr, pgt);
+			/* Free page table */
+			page = pfn_to_page(__pa(pgt) >> PAGE_SHIFT);
+			list_del(&page->lru);
+			page_table_free_pgste(page);
+		}
 		sgt[i] = _SEGMENT_ENTRY_EMPTY;
-		__gmap_unshadow_pgt(sg, raddr, pgt);
-		/* Free page table */
-		page = pfn_to_page(__pa(pgt) >> PAGE_SHIFT);
-		list_del(&page->lru);
-		page_table_free_pgste(page);
 	}
 }
 
@@ -2178,32 +2183,62 @@ EXPORT_SYMBOL_GPL(gmap_shadow_sgt);
  *
  * Called with sg->mm->mmap_sem in read.
  */
-int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
+void gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long *sge,
+			    unsigned long saddr, unsigned long *pgt,
+			    int *dat_protection, int *fake)
+{
+	struct page *page;
+
+	/* Shadow page tables are full pages (pte+pgste) */
+	page = pfn_to_page(*sge >> PAGE_SHIFT);
+	*pgt = page->index & ~GMAP_SHADOW_FAKE_TABLE;
+	*dat_protection = !!(*sge & _SEGMENT_ENTRY_PROTECT);
+	*fake = !!(page->index & GMAP_SHADOW_FAKE_TABLE);
+}
+EXPORT_SYMBOL_GPL(gmap_shadow_pgt_lookup);
+
+int gmap_shadow_sgt_lookup(struct gmap *sg, unsigned long saddr,
 			   unsigned long *pgt, int *dat_protection,
 			   int *fake)
 {
-	unsigned long *table;
+	unsigned long *sge, *r3e = NULL;
 	struct page *page;
-	int rc;
+	int rc = -EAGAIN;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	spin_lock(&sg->guest_table_lock);
-	table = gmap_table_walk(sg, saddr, 1); /* get segment pointer */
-	if (table && !(*table & _SEGMENT_ENTRY_INVALID)) {
-		/* Shadow page tables are full pages (pte+pgste) */
-		page = pfn_to_page(*table >> PAGE_SHIFT);
-		*pgt = page->index & ~GMAP_SHADOW_FAKE_TABLE;
-		*dat_protection = !!(*table & _SEGMENT_ENTRY_PROTECT);
-		*fake = !!(page->index & GMAP_SHADOW_FAKE_TABLE);
-		rc = 0;
-	} else  {
-		rc = -EAGAIN;
+	if (sg->asce & _ASCE_TYPE_MASK) {
+		/* >2 GB guest */
+		r3e = (unsigned long *) gmap_table_walk(sg, saddr, 2);
+		if (!r3e || (*r3e & _REGION_ENTRY_INVALID))
+			goto out;
+		sge = (unsigned long *)(*r3e & _REGION_ENTRY_ORIGIN) + ((saddr & _SEGMENT_INDEX) >> _SEGMENT_SHIFT);
+	} else {
+		sge = (unsigned long *)(sg->asce & PAGE_MASK) + ((saddr & _SEGMENT_INDEX) >> _SEGMENT_SHIFT);
 	}
+	if (*sge & _SEGMENT_ENTRY_INVALID)
+		goto out;
+	rc = 0;
+	if (*sge & _SEGMENT_ENTRY_LARGE) {
+		if (r3e) {
+			page = pfn_to_page(*r3e >> PAGE_SHIFT);
+			*pgt = page->index & ~GMAP_SHADOW_FAKE_TABLE;
+			*dat_protection = !!(*r3e & _SEGMENT_ENTRY_PROTECT);
+			*fake = !!(page->index & GMAP_SHADOW_FAKE_TABLE);
+		} else {
+			*pgt = sg->orig_asce & PAGE_MASK;
+			*dat_protection = 0;
+			*fake = 0;
+		}
+	} else {
+		gmap_shadow_pgt_lookup(sg, sge, saddr, pgt,
+				       dat_protection, fake);
+	}
+out:
 	spin_unlock(&sg->guest_table_lock);
 	return rc;
-
 }
-EXPORT_SYMBOL_GPL(gmap_shadow_pgt_lookup);
+EXPORT_SYMBOL_GPL(gmap_shadow_sgt_lookup);
 
 /**
  * gmap_shadow_pgt - instantiate a shadow page table
@@ -2285,6 +2320,89 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 }
 EXPORT_SYMBOL_GPL(gmap_shadow_pgt);
 
+int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd)
+{
+	struct gmap *parent;
+	struct gmap_rmap *rmap;
+	unsigned long vmaddr, paddr;
+	pmd_t spmd, tpmd, *spmdp = NULL, *tpmdp;
+	int prot;
+	int rc;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	parent = sg->parent;
+
+	prot = (pmd_val(pmd) & _SEGMENT_ENTRY_PROTECT) ? PROT_READ : PROT_WRITE;
+	rmap = kzalloc(sizeof(*rmap), GFP_KERNEL);
+	if (!rmap)
+		return -ENOMEM;
+	rmap->raddr = (saddr & HPAGE_MASK) | _SHADOW_RMAP_SEGMENT_LP;
+
+	while (1) {
+		paddr = pmd_val(pmd) & HPAGE_MASK;
+		vmaddr = __gmap_translate(parent, paddr);
+		if (IS_ERR_VALUE(vmaddr)) {
+			rc = vmaddr;
+			break;
+		}
+		rc = radix_tree_preload(GFP_KERNEL);
+		if (rc)
+			break;
+		rc = -EAGAIN;
+
+		/* Let's look up the parent's mapping */
+		spmdp = gmap_pmd_op_walk(parent, paddr);
+		if (spmdp) {
+			spin_lock(&sg->guest_table_lock);
+			/* Get shadow segment table pointer */
+			tpmdp = (pmd_t *) gmap_table_walk(sg, saddr, 1);
+			if (!tpmdp) {
+				spin_unlock(&sg->guest_table_lock);
+				gmap_pmd_op_end(parent, spmdp);
+				radix_tree_preload_end();
+				break;
+			}
+			/* Shadowing magic happens here. */
+			if (!(pmd_val(*tpmdp) & _SEGMENT_ENTRY_INVALID)) {
+				rc = 0;	/* already shadowed */
+				spin_unlock(&sg->guest_table_lock);
+				gmap_pmd_op_end(parent, spmdp);
+				radix_tree_preload_end();
+				break;
+			}
+			spmd = *spmdp;
+			if (!(pmd_val(spmd) & _SEGMENT_ENTRY_INVALID) &&
+			    !((pmd_val(spmd) & _SEGMENT_ENTRY_PROTECT) &&
+			      !(pmd_val(pmd) & _SEGMENT_ENTRY_PROTECT))) {
+
+				*spmdp = __pmd(pmd_val(spmd)
+					       | _SEGMENT_ENTRY_GMAP_VSIE);
+
+				/* Insert shadow ste */
+				pmd_val(tpmd) = ((pmd_val(spmd) & HPAGE_MASK) |
+						 _SEGMENT_ENTRY_LARGE |
+						 (pmd_val(pmd) & _SEGMENT_ENTRY_PROTECT));
+				*tpmdp = tpmd;
+
+				gmap_insert_rmap(sg, vmaddr, rmap);
+				rc = 0;
+			}
+			spin_unlock(&sg->guest_table_lock);
+			gmap_pmd_op_end(parent, spmdp);
+		}
+		radix_tree_preload_end();
+		if (!rc)
+			break;
+		rc = gmap_pte_op_fixup(parent, paddr, vmaddr, prot);
+		if (rc)
+			break;
+	}
+	if (rc)
+		kfree(rmap);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(gmap_shadow_segment);
+
 /**
  * gmap_shadow_page - create a shadow page mapping
  * @sg: pointer to the shadow guest address space structure
@@ -2361,6 +2479,65 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 EXPORT_SYMBOL_GPL(gmap_shadow_page);
 
 /**
+ * gmap_unshadow_segment - remove a huge segment from a shadow segment table
+ * @sg: pointer to the shadow guest address space structure
+ * @raddr: rmap address in the shadow guest address space
+ *
+ * Called with the sg->guest_table_lock
+ */
+static void gmap_unshadow_segment(struct gmap *sg, unsigned long raddr)
+{
+	unsigned long *table;
+
+	BUG_ON(!gmap_is_shadow(sg));
+	/* We already have the lock */
+	table = gmap_table_walk(sg, raddr, 1); /* get segment table pointer */
+	if (!table || *table & _SEGMENT_ENTRY_INVALID ||
+	    !(*table & _SEGMENT_ENTRY_LARGE))
+		return;
+	gmap_call_notifier(sg, raddr, raddr + (1UL << 20) - 1);
+	gmap_pmdp_xchg(sg, (pmd_t *)table, __pmd(_SEGMENT_ENTRY_EMPTY), raddr);
+}
+
+static void gmap_shadow_notify_pmd(struct gmap *sg, unsigned long vmaddr,
+				   unsigned long gaddr)
+{
+	struct gmap_rmap *rmap, *rnext, *head;
+	unsigned long start, end, bits, raddr;
+
+
+	BUG_ON(!gmap_is_shadow(sg));
+
+	spin_lock(&sg->guest_table_lock);
+	if (sg->removed) {
+		spin_unlock(&sg->guest_table_lock);
+		return;
+	}
+	/* Check for top level table */
+	start = sg->orig_asce & _ASCE_ORIGIN;
+	end = start + ((sg->orig_asce & _ASCE_TABLE_LENGTH) + 1) * 4096;
+	if (!(sg->orig_asce & _ASCE_REAL_SPACE) && gaddr >= start &&
+	    gaddr < ((end & HPAGE_MASK) + HPAGE_SIZE - 1)) {
+		/* The complete shadow table has to go */
+		gmap_unshadow(sg);
+		spin_unlock(&sg->guest_table_lock);
+		list_del(&sg->list);
+		gmap_put(sg);
+		return;
+	}
+	/* Remove the page table tree from on specific entry */
+	head = radix_tree_delete(&sg->host_to_rmap, (vmaddr & HPAGE_MASK) >> PAGE_SHIFT);
+	gmap_for_each_rmap_safe(rmap, rnext, head) {
+		bits = rmap->raddr & _SHADOW_RMAP_MASK;
+		raddr = rmap->raddr ^ bits;
+		gmap_unshadow_segment(sg, raddr);
+		kfree(rmap);
+	}
+	spin_unlock(&sg->guest_table_lock);
+}
+
+
+/**
  * gmap_shadow_notify - handle notifications for shadow gmap
  *
  * Called with sg->parent->shadow_lock.
@@ -2512,6 +2689,85 @@ static void pmdp_notify_split(struct mm_struct *mm, unsigned long vmaddr,
 }
 
 /**
+ * pmdp_notify_gmap - call all invalidation callbacks for a specific pmd
+ * @gmap: pointer to the guest address space structure
+ * @gaddr: guest address which is affected
+ *
+ * This function is expected to be called with a locked
+ * guest_table_lock.
+ */
+static void pmdp_notify_gmap(struct gmap *gmap, unsigned long gaddr)
+{
+	unsigned long *table;
+	unsigned long vmaddr, bits;
+	struct gmap *sg, *next;
+
+	gaddr &= HPAGE_MASK;
+	table = gmap_table_walk(gmap, gaddr, 1);
+	if (!table)
+		return;
+	if (pmd_large(__pmd(*table)) && (*table & _SEGMENT_ENTRY_GMAP_VSIE))
+		bits = _SEGMENT_ENTRY_GMAP_VSIE;
+	if (!bits)
+		return;
+	*table &= ~bits;
+	vmaddr = __gmap_translate(gmap, gaddr);
+	if (!list_empty(&gmap->children) && (bits & _SEGMENT_ENTRY_GMAP_VSIE)
+	    && (*table & _SEGMENT_ENTRY_PROTECT)) {
+		spin_lock(&gmap->shadow_lock);
+		list_for_each_entry_safe(sg, next,
+					 &gmap->children, list)
+			gmap_shadow_notify_pmd(sg, vmaddr, gaddr);
+		spin_unlock(&gmap->shadow_lock);
+	}
+}
+
+/**
+ * pmdp_notify - call all invalidation callbacks for a specific pmd
+ * @mm: pointer to the process mm_struct
+ * @vmaddr: virtual address in the process address space
+ *
+ * This function is expected to be called with mmap_sem held in read.
+ */
+void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
+{
+	unsigned long *table, gaddr, bits;
+	struct gmap *gmap, *sg, *next;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
+		spin_lock(&gmap->guest_table_lock);
+		table = radix_tree_lookup(&gmap->host_to_guest,
+					  vmaddr >> PMD_SHIFT);
+		if (!table) {
+			spin_unlock(&gmap->guest_table_lock);
+			continue;
+		}
+
+		if (gmap_pmd_is_split((pmd_t *)table)) {
+			pmdp_notify_split(mm, vmaddr, table);
+			spin_unlock(&gmap->guest_table_lock);
+			continue;
+		}
+
+		if (pmd_large(__pmd(*table)) && (*table & _SEGMENT_ENTRY_GMAP_VSIE))
+			bits = _SEGMENT_ENTRY_GMAP_VSIE;
+		*table &= ~bits;
+		gaddr = __gmap_segment_gaddr(table);
+		spin_unlock(&gmap->guest_table_lock);
+		if (!list_empty(&gmap->children) && (bits & _SEGMENT_ENTRY_GMAP_VSIE)) {
+			spin_lock(&gmap->shadow_lock);
+			list_for_each_entry_safe(sg, next,
+						 &gmap->children, list)
+				gmap_shadow_notify_pmd(sg, vmaddr, gaddr);
+			spin_unlock(&gmap->shadow_lock);
+		}
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(pmdp_notify);
+
+/**
  * gmap_pmdp_xchg - exchange a gmap pmd with another and notify
  * @gmap: pointer to the guest address space structure
  * @pmdp: pointer to the pmd entry
@@ -2524,6 +2780,7 @@ static void pmdp_notify_split(struct mm_struct *mm, unsigned long vmaddr,
 static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
 			   unsigned long gaddr)
 {
+	pmdp_notify_gmap(gmap, gaddr);
 	if (MACHINE_HAS_TLB_GUEST)
 		__pmdp_idte(gaddr, (pmd_t *)pmdp,
 			    IDTE_GUEST_ASCE, gmap->asce,
@@ -2536,39 +2793,6 @@ static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
 	*pmdp = new;
 }
 
-/**
- * pmdp_notify - call all invalidation callbacks for a specific pmd
- * @mm: pointer to the process mm_struct
- * @vmaddr: virtual address in the process address space
- *
- * This function is expected to be called with mmap_sem held in read.
- */
-void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
-{
-	unsigned long *table, gaddr;
-	struct gmap *gmap;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
-		spin_lock(&gmap->guest_table_lock);
-		table = radix_tree_lookup(&gmap->host_to_guest,
-					  vmaddr >> PMD_SHIFT);
-		if (!table) {
-			spin_unlock(&gmap->guest_table_lock);
-			continue;
-		}
-		gaddr = __gmap_segment_gaddr(table);
-		if (gmap_pmd_is_split((pmd_t *)table)) {
-			pmdp_notify_split(mm, vmaddr, table);
-			spin_unlock(&gmap->guest_table_lock);
-			continue;
-		}
-		spin_unlock(&gmap->guest_table_lock);
-	}
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL_GPL(pmdp_notify);
-
 static void gmap_pmdp_clear(struct mm_struct *mm, unsigned long vmaddr,
 			    int purge)
 {
-- 
2.7.4
