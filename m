From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 17/51] s390/mm: support EDAT2 for gmap shadows
Date: Tue, 21 Jun 2016 15:12:55 +0200
Message-ID: <1466514809-146638-18-git-send-email-borntraeger@de.ibm.com>
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

If the guest is enabled for EDAT2, we can easily create shadows for
guest2 -> guest3 provided tables that make use of EDAT2.

If guest2 references a 2GB page, this memory looks consecutive for guest2,
but it does not have to be so for us. Therefore we have to create fake
segment and page tables.

This works just like EDAT1 support, so page tables are removed when the
parent table (r3t table entry) is changed.

We don't hve to care about:
- ACCF-Validity Control in RTTE
- Access-Control Bits in RTTE
- Fetch-Protection Bit in RTTE
- Common-Region Bit in RTTE

Just like for EDAT1, all bits might be dropped and there is no guaranteed
that they are active.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h |  3 ++-
 arch/s390/kvm/gaccess.c      | 22 ++++++++++++++++++++--
 arch/s390/mm/gmap.c          | 14 ++++++++++++--
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index c8ba5a1..2e4c3b2 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -111,7 +111,8 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 			 int edat_level);
 int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t);
 int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t);
-int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt);
+int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
+		    int fake);
 int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 		    int fake);
 int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index af1fc6f..fab03ec 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1042,17 +1042,35 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			return PGM_REGION_THIRD_TRANS;
 		if (rtte.tt != TABLE_TYPE_REGION3)
 			return PGM_TRANSLATION_SPEC;
+		if (rtte.cr && asce.p && sg->edat_level >= 2)
+			return PGM_TRANSLATION_SPEC;
+		if (rtte.fc && sg->edat_level >= 2) {
+			bool prot = rtte.fc1.p;
+
+			*fake = 1;
+			ptr = rtte.fc1.rfaa << 31UL;
+			rtte.val = ptr;
+			rtte.fc0.p = prot;
+			goto shadow_sgt;
+		}
 		if (vaddr.sx01 < rtte.fc0.tf || vaddr.sx01 > rtte.fc0.tl)
 			return PGM_SEGMENT_TRANSLATION;
-		rc = gmap_shadow_sgt(sg, saddr, rtte.val);
+		ptr = rtte.fc0.sto << 12UL;
+shadow_sgt:
+		rc = gmap_shadow_sgt(sg, saddr, rtte.val, *fake);
 		if (rc)
 			return rc;
-		ptr = rtte.fc0.sto * 4096;
 		/* fallthrough */
 	}
 	case ASCE_TYPE_SEGMENT: {
 		union segment_table_entry ste;
 
+		if (*fake) {
+			/* offset in 2G guest memory block */
+			ptr = ptr + ((unsigned long) vaddr.sx << 20UL);
+			ste.val = ptr;
+			goto shadow_pgt;
+		}
 		rc = gmap_read_table(parent, ptr + vaddr.sx * 8, &ste.val);
 		if (rc)
 			return rc;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index de7ad7b..c96bf30 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1631,6 +1631,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_r3t);
  * @sg: pointer to the shadow guest address space structure
  * @saddr: faulting address in the shadow gmap
  * @sgt: parent gmap address of the segment table to get shadowed
+ * @fake: sgt references contiguous guest memory block, not a sgt
  *
  * Returns: 0 if successfully shadowed or already shadowed, -EAGAIN if the
  * shadow table structure is incomplete, -ENOMEM if out of memory and
@@ -1638,19 +1639,22 @@ EXPORT_SYMBOL_GPL(gmap_shadow_r3t);
  *
  * Called with sg->mm->mmap_sem in read.
  */
-int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt)
+int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
+		    int fake)
 {
 	unsigned long raddr, origin, offset, len;
 	unsigned long *s_sgt, *table;
 	struct page *page;
 	int rc;
 
-	BUG_ON(!gmap_is_shadow(sg));
+	BUG_ON(!gmap_is_shadow(sg) || (sgt & _REGION3_ENTRY_LARGE));
 	/* Allocate a shadow segment table */
 	page = alloc_pages(GFP_KERNEL, 2);
 	if (!page)
 		return -ENOMEM;
 	page->index = sgt & _REGION_ENTRY_ORIGIN;
+	if (fake)
+		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_sgt = (unsigned long *) page_to_phys(page);
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
@@ -1673,6 +1677,12 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt)
 	if (sg->edat_level >= 1)
 		*table |= sgt & _REGION_ENTRY_PROTECT;
 	list_add(&page->lru, &sg->crst_list);
+	if (fake) {
+		/* nothing to protect for fake tables */
+		*table &= ~_REGION_ENTRY_INVALID;
+		spin_unlock(&sg->guest_table_lock);
+		return 0;
+	}
 	spin_unlock(&sg->guest_table_lock);
 	/* Make sgt read-only in parent gmap page table */
 	raddr = (saddr & 0xffffffff80000000UL) | _SHADOW_RMAP_REGION3;
-- 
2.5.5
