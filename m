From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 16/51] s390/mm: support EDAT1 for gmap shadows
Date: Tue, 21 Jun 2016 15:12:54 +0200
Message-ID: <1466514809-146638-17-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If the guest is enabled for EDAT1, we can easily create shadows for
guest2 -> guest3 provided tables that make use of EDAT1.

If guest2 references a 1MB page, this memory looks consecutive for guest2,
but it might not be so for us. Therefore we have to create fake page tables.

We can easily add that to our existing infrastructure. The invalidation
mechanism will make sure that fake page tables are removed when the parent
table (sgt table entry) is changed.

As EDAT1 also introduced protection on all page table levels, we have to
also shadow these correctly.

We don't have to care about:
- ACCF-Validity Control in STE
- Access-Control Bits in STE
- Fetch-Protection Bit in STE
- Common-Segment Bit in STE

As all bits might be dropped and there is no guaranteed that they are
active ("unpredictable whether the CPU uses these bits", "may be used").
Without using EDAT1 in the shadow ourselfes (STE-format control == 0),
simply shadowing these bits would not be enough. They would be ignored.

Please note that we are using the "fake" flag to make this look consistent
with further changes (EDAT2, real-space designation support) and don't let
the shadow functions handle fc=1 stes.

In the future, with huge pages in the host, gmap_shadow_pgt() could simply
try to map a huge host page if "fake" is set to one and indicate via return
value that no lower fake tables / shadow ptes are required.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h |  5 +++--
 arch/s390/kvm/gaccess.c      | 34 +++++++++++++++++++++++++++-------
 arch/s390/mm/gmap.c          | 29 +++++++++++++++++++++++++----
 3 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 2ab397c..c8ba5a1 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -112,9 +112,10 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t);
 int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t);
 int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt);
-int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt);
+int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
+		    int fake);
 int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
-			   unsigned long *pgt, int *dat_protection);
+			   unsigned long *pgt, int *dat_protection, int *fake);
 int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte);
 
 void gmap_register_pte_notifier(struct gmap_notifier *);
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index a85bc6c..af1fc6f 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -953,9 +953,11 @@ int kvm_s390_check_low_addr_prot_real(struct kvm_vcpu *vcpu, unsigned long gra)
  * @sg: pointer to the shadow guest address space structure
  * @saddr: faulting address in the shadow gmap
  * @pgt: pointer to the page table address result
+ * @fake: pgt references contiguous guest memory block, not a pgtable
  */
 static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
-				  unsigned long *pgt, int *dat_protection)
+				  unsigned long *pgt, int *dat_protection,
+				  int *fake)
 {
 	struct gmap *parent;
 	union asce asce;
@@ -963,6 +965,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 	unsigned long ptr;
 	int rc;
 
+	*fake = 0;
 	parent = sg->parent;
 	vaddr.addr = saddr;
 	asce.val = sg->orig_asce;
@@ -1060,10 +1063,20 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		if (ste.cs && asce.p)
 			return PGM_TRANSLATION_SPEC;
 		*dat_protection = ste.fc0.p;
-		rc = gmap_shadow_pgt(sg, saddr, ste.val);
+		if (ste.fc && sg->edat_level >= 1) {
+			bool prot = ste.fc1.p;
+
+			*fake = 1;
+			ptr = ste.fc1.sfaa << 20UL;
+			ste.val = ptr;
+			ste.fc0.p = prot;
+			goto shadow_pgt;
+		}
+		ptr = ste.fc0.pto << 11UL;
+shadow_pgt:
+		rc = gmap_shadow_pgt(sg, saddr, ste.val, *fake);
 		if (rc)
 			return rc;
-		ptr = ste.fc0.pto * 2048;
 	}
 	}
 	/* Return the parent address of the page table */
@@ -1089,7 +1102,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	union vaddress vaddr;
 	union page_table_entry pte;
 	unsigned long pgt;
-	int dat_protection;
+	int dat_protection, fake;
 	int rc;
 
 	down_read(&sg->mm->mmap_sem);
@@ -1100,17 +1113,24 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	 */
 	ipte_lock(vcpu);
 
-	rc = gmap_shadow_pgt_lookup(sg, saddr, &pgt, &dat_protection);
+	rc = gmap_shadow_pgt_lookup(sg, saddr, &pgt, &dat_protection, &fake);
 	if (rc)
-		rc = kvm_s390_shadow_tables(sg, saddr, &pgt, &dat_protection);
+		rc = kvm_s390_shadow_tables(sg, saddr, &pgt, &dat_protection,
+					    &fake);
 
 	vaddr.addr = saddr;
+	if (fake) {
+		/* offset in 1MB guest memory block */
+		pte.val = pgt + ((unsigned long) vaddr.px << 12UL);
+		goto shadow_page;
+	}
 	if (!rc)
 		rc = gmap_read_table(sg->parent, pgt + vaddr.px * 8, &pte.val);
 	if (!rc && pte.i)
 		rc = PGM_PAGE_TRANSLATION;
-	if (!rc && (pte.z || pte.co))
+	if (!rc && (pte.z || (pte.co && sg->edat_level < 1)))
 		rc = PGM_TRANSLATION_SPEC;
+shadow_page:
 	pte.p |= dat_protection;
 	if (!rc)
 		rc = gmap_shadow_page(sg, saddr, __pte(pte.val));
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index f0b2a531..de7ad7b 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -20,6 +20,8 @@
 #include <asm/gmap.h>
 #include <asm/tlb.h>
 
+#define GMAP_SHADOW_FAKE_TABLE 1ULL
+
 /**
  * gmap_alloc - allocate and initialize a guest address space
  * @mm: pointer to the parent mm_struct
@@ -1521,6 +1523,8 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t)
 	/* mark as invalid as long as the parent table is not protected */
 	*table = (unsigned long) s_r2t | _REGION_ENTRY_LENGTH |
 		 _REGION_ENTRY_TYPE_R1 | _REGION_ENTRY_INVALID;
+	if (sg->edat_level >= 1)
+		*table |= (r2t & _REGION_ENTRY_PROTECT);
 	list_add(&page->lru, &sg->crst_list);
 	spin_unlock(&sg->guest_table_lock);
 	/* Make r2t read-only in parent gmap page table */
@@ -1592,6 +1596,8 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t)
 	/* mark as invalid as long as the parent table is not protected */
 	*table = (unsigned long) s_r3t | _REGION_ENTRY_LENGTH |
 		 _REGION_ENTRY_TYPE_R2 | _REGION_ENTRY_INVALID;
+	if (sg->edat_level >= 1)
+		*table |= (r3t & _REGION_ENTRY_PROTECT);
 	list_add(&page->lru, &sg->crst_list);
 	spin_unlock(&sg->guest_table_lock);
 	/* Make r3t read-only in parent gmap page table */
@@ -1664,6 +1670,8 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt)
 	/* mark as invalid as long as the parent table is not protected */
 	*table = (unsigned long) s_sgt | _REGION_ENTRY_LENGTH |
 		 _REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_INVALID;
+	if (sg->edat_level >= 1)
+		*table |= sgt & _REGION_ENTRY_PROTECT;
 	list_add(&page->lru, &sg->crst_list);
 	spin_unlock(&sg->guest_table_lock);
 	/* Make sgt read-only in parent gmap page table */
@@ -1698,6 +1706,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_sgt);
  * @saddr: the address in the shadow aguest address space
  * @pgt: parent gmap address of the page table to get shadowed
  * @dat_protection: if the pgtable is marked as protected by dat
+ * @fake: pgt references contiguous guest memory block, not a pgtable
  *
  * Returns 0 if the shadow page table was found and -EAGAIN if the page
  * table was not found.
@@ -1705,7 +1714,8 @@ EXPORT_SYMBOL_GPL(gmap_shadow_sgt);
  * Called with sg->mm->mmap_sem in read.
  */
 int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
-			   unsigned long *pgt, int *dat_protection)
+			   unsigned long *pgt, int *dat_protection,
+			   int *fake)
 {
 	unsigned long *table;
 	struct page *page;
@@ -1717,8 +1727,9 @@ int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
 	if (table && !(*table & _SEGMENT_ENTRY_INVALID)) {
 		/* Shadow page tables are full pages (pte+pgste) */
 		page = pfn_to_page(*table >> PAGE_SHIFT);
-		*pgt = page->index;
+		*pgt = page->index & ~GMAP_SHADOW_FAKE_TABLE;
 		*dat_protection = !!(*table & _SEGMENT_ENTRY_PROTECT);
+		*fake = !!(page->index & GMAP_SHADOW_FAKE_TABLE);
 		rc = 0;
 	} else  {
 		rc = -EAGAIN;
@@ -1734,6 +1745,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_pgt_lookup);
  * @sg: pointer to the shadow guest address space structure
  * @saddr: faulting address in the shadow gmap
  * @pgt: parent gmap address of the page table to get shadowed
+ * @fake: pgt references contiguous guest memory block, not a pgtable
  *
  * Returns 0 if successfully shadowed or already shadowed, -EAGAIN if the
  * shadow table structure is incomplete, -ENOMEM if out of memory,
@@ -1741,19 +1753,22 @@ EXPORT_SYMBOL_GPL(gmap_shadow_pgt_lookup);
  *
  * Called with gmap->mm->mmap_sem in read
  */
-int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt)
+int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
+		    int fake)
 {
 	unsigned long raddr, origin;
 	unsigned long *s_pgt, *table;
 	struct page *page;
 	int rc;
 
-	BUG_ON(!gmap_is_shadow(sg));
+	BUG_ON(!gmap_is_shadow(sg) || (pgt & _SEGMENT_ENTRY_LARGE));
 	/* Allocate a shadow page table */
 	page = page_table_alloc_pgste(sg->mm);
 	if (!page)
 		return -ENOMEM;
 	page->index = pgt & _SEGMENT_ENTRY_ORIGIN;
+	if (fake)
+		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_pgt = (unsigned long *) page_to_phys(page);
 	/* Install shadow page table */
 	spin_lock(&sg->guest_table_lock);
@@ -1773,6 +1788,12 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt)
 	*table = (unsigned long) s_pgt | _SEGMENT_ENTRY |
 		 (pgt & _SEGMENT_ENTRY_PROTECT) | _SEGMENT_ENTRY_INVALID;
 	list_add(&page->lru, &sg->pt_list);
+	if (fake) {
+		/* nothing to protect for fake tables */
+		*table &= ~_SEGMENT_ENTRY_INVALID;
+		spin_unlock(&sg->guest_table_lock);
+		return 0;
+	}
 	spin_unlock(&sg->guest_table_lock);
 	/* Make pgt read-only in parent gmap page table (not the pgste) */
 	raddr = (saddr & 0xfffffffffff00000UL) | _SHADOW_RMAP_SEGMENT;
-- 
2.5.5
