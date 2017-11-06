From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 16/22] s390/mm: Add shadow segment code
Date: Mon,  6 Nov 2017 23:29:54 +0100
Message-ID: <1510007400-42493-17-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
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
 arch/s390/include/asm/gmap.h |   6 +-
 arch/s390/kvm/gaccess.c      |  35 +++++-
 arch/s390/mm/gmap.c          | 293 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 293 insertions(+), 41 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index ff6b2d0..2ce861f 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -129,9 +129,11 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
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
index 4bd15a9f..60a5dda 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -980,7 +980,7 @@ int kvm_s390_check_low_addr_prot_real(struct kvm_vcpu *vcpu, unsigned long gra)
  */
 static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 				  unsigned long *pgt, int *dat_protection,
-				  int *fake)
+				  int *fake, int *lvl)
 {
 	struct gmap *parent;
 	union asce asce;
@@ -1135,6 +1135,17 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
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
@@ -1171,8 +1182,9 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 {
 	union vaddress vaddr;
 	union page_table_entry pte;
+	union segment_table_entry ste;
 	unsigned long pgt;
-	int dat_protection, fake;
+	int dat_protection, fake, lvl, fc;
 	int rc;
 
 	down_read(&sg->mm->mmap_sem);
@@ -1183,12 +1195,26 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
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
@@ -1203,6 +1229,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	pte.p |= dat_protection;
 	if (!rc)
 		rc = gmap_shadow_page(sg, saddr, __pte(pte.val));
+out:
 	ipte_unlock(vcpu);
 	up_read(&sg->mm->mmap_sem);
 	return rc;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index bc77688..75c32de 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -613,7 +613,9 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 		}
 	} else if (*table & _SEGMENT_ENTRY_PROTECT &&
 		   !(pmd_val(*pmd) & _SEGMENT_ENTRY_PROTECT)) {
-		unprot = __pmd((*table & ~_SEGMENT_ENTRY_PROTECT)
+		unprot = __pmd((*table & (_SEGMENT_ENTRY_ORIGIN_LARGE
+					  | _SEGMENT_ENTRY_INVALID
+					  | _SEGMENT_ENTRY_LARGE))
 			       | _SEGMENT_ENTRY_GMAP_UC);
 		gmap_pmdp_xchg(gmap, (pmd_t *)table, unprot, gaddr);
 	}
@@ -1293,7 +1295,7 @@ static inline void gmap_insert_rmap(struct gmap *sg, unsigned long vmaddr,
 
 static int gmap_protect_rmap_large(struct gmap *sg, struct gmap_rmap *rmap,
 				   unsigned long paddr, unsigned long vmaddr,
-				   pmd_t *pmdp, int prot)
+				   pmd_t *pmdp, pmd_t *hpmdp, int prot)
 {
 	int rc = 0;
 
@@ -1302,7 +1304,7 @@ static int gmap_protect_rmap_large(struct gmap *sg, struct gmap_rmap *rmap,
 		return -EAGAIN;
 
 	spin_lock(&sg->guest_table_lock);
-	rc = gmap_protect_large(sg->parent, paddr, pmdp,
+	rc = gmap_protect_large(sg->parent, paddr, vmaddr, pmdp, hpmdp,
 				prot, GMAP_ENTRY_VSIE);
 	if (!rc)
 		gmap_insert_rmap(sg, vmaddr & HPAGE_MASK, rmap);
@@ -1358,7 +1360,8 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 	struct gmap *parent;
 	struct gmap_rmap *rmap;
 	unsigned long vmaddr;
-	pmd_t *pmdp;
+	spinlock_t *ptl;
+	pmd_t *pmdp, *hpmdp;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg));
@@ -1367,12 +1370,18 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 		vmaddr = __gmap_translate(parent, paddr);
 		if (IS_ERR_VALUE(vmaddr))
 			return vmaddr;
+		hpmdp = (pmd_t *)huge_pte_offset(parent->mm, vmaddr, HPAGE_SIZE);
+		/* Do we need tests here? */
+		ptl = pmd_lock(parent->mm, hpmdp);
 		rmap = kzalloc(sizeof(*rmap), GFP_KERNEL);
-		if (!rmap)
+		if (!rmap) {
+			spin_unlock(ptl);
 			return -ENOMEM;
+		}
 		rmap->raddr = raddr;
 		rc = radix_tree_preload(GFP_KERNEL);
 		if (rc) {
+			spin_unlock(ptl);
 			kfree(rmap);
 			return rc;
 		}
@@ -1388,7 +1397,8 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 				}
 			} else {
 				rc = gmap_protect_rmap_large(sg, rmap, paddr,
-							     vmaddr, pmdp, prot);
+							     vmaddr, pmdp,
+							     hpmdp, prot);
 				if (!rc) {
 					len = len < HPAGE_SIZE ? 0 : len - HPAGE_SIZE;
 					paddr = (paddr & HPAGE_MASK) + HPAGE_SIZE;
@@ -1396,6 +1406,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 			}
 			gmap_pmd_op_end(parent, pmdp);
 		}
+		spin_unlock(ptl);
 		radix_tree_preload_end();
 		if (rc) {
 			kfree(rmap);
@@ -1409,6 +1420,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 }
 
 #define _SHADOW_RMAP_MASK	0x7
+#define _SHADOW_RMAP_SEGMENT_LP	0x6
 #define _SHADOW_RMAP_REGION1	0x5
 #define _SHADOW_RMAP_REGION2	0x4
 #define _SHADOW_RMAP_REGION3	0x3
@@ -1517,13 +1529,16 @@ static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
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
 
@@ -2140,32 +2155,62 @@ EXPORT_SYMBOL_GPL(gmap_shadow_sgt);
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
@@ -2247,6 +2292,88 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
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
+				*spmdp =  __pmd(pmd_val(spmd) | _SEGMENT_ENTRY_GMAP_VSIE);
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
@@ -2323,6 +2450,78 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
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
+		switch (bits) {
+		case _SHADOW_RMAP_REGION1:
+			gmap_unshadow_r2t(sg, raddr);
+			break;
+		case _SHADOW_RMAP_REGION2:
+			gmap_unshadow_r3t(sg, raddr);
+			break;
+		case _SHADOW_RMAP_REGION3:
+			gmap_unshadow_sgt(sg, raddr);
+			break;
+		case _SHADOW_RMAP_SEGMENT_LP:
+			gmap_unshadow_segment(sg, raddr);
+			break;
+		}
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
@@ -2434,13 +2633,28 @@ EXPORT_SYMBOL_GPL(ptep_notify);
 static void pmdp_notify_gmap(struct gmap *gmap, unsigned long gaddr)
 {
 	unsigned long *table;
+	unsigned long vmaddr, bits;
+	struct gmap *sg, *next;
 
 	gaddr &= HPAGE_MASK;
 	table = gmap_table_walk(gmap, gaddr, 1);
-	if (!table || !(*table & _SEGMENT_ENTRY_GMAP_IN))
+	if (!table)
 		return;
-	*table &= ~_SEGMENT_ENTRY_GMAP_IN;
-	gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
+	bits = *table & (_SEGMENT_ENTRY_GMAP_IN | _SEGMENT_ENTRY_GMAP_VSIE);
+	if (!bits)
+		return;
+	*table ^= bits;
+	vmaddr = __gmap_translate(gmap, gaddr);
+	if (!list_empty(&gmap->children) && (bits & _SEGMENT_ENTRY_GMAP_VSIE)
+	    && (*table & _SEGMENT_ENTRY_PROTECT)) {
+		spin_lock(&gmap->shadow_lock);
+		list_for_each_entry_safe(sg, next,
+					 &gmap->children, list)
+			gmap_shadow_notify_pmd(sg, vmaddr, gaddr);
+		spin_unlock(&gmap->shadow_lock);
+	}
+	if (bits & _SEGMENT_ENTRY_GMAP_IN)
+		gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
 }
 
 /**
@@ -2452,22 +2666,31 @@ static void pmdp_notify_gmap(struct gmap *gmap, unsigned long gaddr)
  */
 void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
 {
-	unsigned long *table, gaddr;
-	struct gmap *gmap;
+	unsigned long *table, gaddr, bits;
+	struct gmap *gmap, *sg, *next;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
 		spin_lock(&gmap->guest_table_lock);
 		table = radix_tree_lookup(&gmap->host_to_guest,
 					  vmaddr >> PMD_SHIFT);
-		if (!table || !(*table & _SEGMENT_ENTRY_GMAP_IN)) {
+		if (!table) {
 			spin_unlock(&gmap->guest_table_lock);
 			continue;
 		}
+		bits = *table & (_SEGMENT_ENTRY_GMAP_IN | _SEGMENT_ENTRY_GMAP_VSIE);
+		*table ^= bits;
 		gaddr = __gmap_segment_gaddr(table);
-		*table &= ~_SEGMENT_ENTRY_GMAP_IN;
 		spin_unlock(&gmap->guest_table_lock);
-		gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
+		if (!list_empty(&gmap->children) && (bits & _SEGMENT_ENTRY_GMAP_VSIE)) {
+			spin_lock(&gmap->shadow_lock);
+			list_for_each_entry_safe(sg, next,
+						 &gmap->children, list)
+				gmap_shadow_notify_pmd(sg, vmaddr, gaddr);
+			spin_unlock(&gmap->shadow_lock);
+		}
+		if (bits & _SEGMENT_ENTRY_GMAP_IN)
+			gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
 	}
 	rcu_read_unlock();
 }
-- 
2.7.4
