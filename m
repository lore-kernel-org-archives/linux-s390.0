From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 19/51] s390/mm: support real-space for gmap shadows
Date: Tue, 21 Jun 2016 15:12:57 +0200
Message-ID: <1466514809-146638-20-git-send-email-borntraeger@de.ibm.com>
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

We can easily support real-space designation just like EDAT1 and EDAT2.
So guest2 can provide for guest3 an asce with the real-space control being
set.

We simply have to allocate the biggest page table possible and fake all
levels.

There is no protection to consider. If we exceed guest memory, vsie code
will inject an addressing exception (via program intercept). In the future,
we could limit the fake table level to the gmap page table.

As the top level page table can never go away, such gmap shadows will never
get unshadowed, we'll have to come up with another way to limit the number
of kept gmap shadows.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h |  6 ++++--
 arch/s390/kvm/gaccess.c      | 34 +++++++++++++++++++++++++++++-----
 arch/s390/mm/gmap.c          | 35 ++++++++++++++++++++++++++++++++---
 3 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 2e4c3b2..752cf47 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -109,8 +109,10 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val);
 
 struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 			 int edat_level);
-int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t);
-int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t);
+int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
+		    int fake);
+int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
+		    int fake);
 int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 		    int fake);
 int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index f6d556d..5420020 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -971,9 +971,13 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 	vaddr.addr = saddr;
 	asce.val = sg->orig_asce;
 	ptr = asce.origin * 4096;
+	if (asce.r) {
+		*fake = 1;
+		asce.dt = ASCE_TYPE_REGION1;
+	}
 	switch (asce.dt) {
 	case ASCE_TYPE_REGION1:
-		if (vaddr.rfx01 > asce.tl)
+		if (vaddr.rfx01 > asce.tl && !asce.r)
 			return PGM_REGION_FIRST_TRANS;
 		break;
 	case ASCE_TYPE_REGION2:
@@ -1000,6 +1004,12 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 	case ASCE_TYPE_REGION1: {
 		union region1_table_entry rfte;
 
+		if (*fake) {
+			/* offset in 16EB guest memory block */
+			ptr = ptr + ((unsigned long) vaddr.rsx << 53UL);
+			rfte.val = ptr;
+			goto shadow_r2t;
+		}
 		rc = gmap_read_table(parent, ptr + vaddr.rfx * 8, &rfte.val);
 		if (rc)
 			return rc;
@@ -1011,15 +1021,22 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			return PGM_REGION_SECOND_TRANS;
 		if (sg->edat_level >= 1)
 			*dat_protection |= rfte.p;
-		rc = gmap_shadow_r2t(sg, saddr, rfte.val);
+		ptr = rfte.rto << 12UL;
+shadow_r2t:
+		rc = gmap_shadow_r2t(sg, saddr, rfte.val, *fake);
 		if (rc)
 			return rc;
-		ptr = rfte.rto * 4096;
 		/* fallthrough */
 	}
 	case ASCE_TYPE_REGION2: {
 		union region2_table_entry rste;
 
+		if (*fake) {
+			/* offset in 8PB guest memory block */
+			ptr = ptr + ((unsigned long) vaddr.rtx << 42UL);
+			rste.val = ptr;
+			goto shadow_r3t;
+		}
 		rc = gmap_read_table(parent, ptr + vaddr.rsx * 8, &rste.val);
 		if (rc)
 			return rc;
@@ -1031,16 +1048,23 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			return PGM_REGION_THIRD_TRANS;
 		if (sg->edat_level >= 1)
 			*dat_protection |= rste.p;
+		ptr = rste.rto << 12UL;
+shadow_r3t:
 		rste.p |= *dat_protection;
-		rc = gmap_shadow_r3t(sg, saddr, rste.val);
+		rc = gmap_shadow_r3t(sg, saddr, rste.val, *fake);
 		if (rc)
 			return rc;
-		ptr = rste.rto * 4096;
 		/* fallthrough */
 	}
 	case ASCE_TYPE_REGION3: {
 		union region3_table_entry rtte;
 
+		if (*fake) {
+			/* offset in 4TB guest memory block */
+			ptr = ptr + ((unsigned long) vaddr.sx << 31UL);
+			rtte.val = ptr;
+			goto shadow_sgt;
+		}
 		rc = gmap_read_table(parent, ptr + vaddr.rtx * 8, &rtte.val);
 		if (rc)
 			return rc;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index c96bf30..c07d64f 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1437,6 +1437,8 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 		return sg;
 	/* Create a new shadow gmap */
 	limit = -1UL >> (33 - (((asce & _ASCE_TYPE_MASK) >> 2) * 11));
+	if (asce & _ASCE_REAL_SPACE)
+		limit = -1UL;
 	new = gmap_alloc(limit);
 	if (!new)
 		return ERR_PTR(-ENOMEM);
@@ -1455,6 +1457,12 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 	}
 	atomic_set(&new->ref_count, 2);
 	list_add(&new->list, &parent->children);
+	if (asce & _ASCE_REAL_SPACE) {
+		/* nothing to protect, return right away */
+		new->initialized = true;
+		spin_unlock(&parent->shadow_lock);
+		return new;
+	}
 	spin_unlock(&parent->shadow_lock);
 	/* protect after insertion, so it will get properly invalidated */
 	down_read(&parent->mm->mmap_sem);
@@ -1479,6 +1487,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow);
  * @sg: pointer to the shadow guest address space structure
  * @saddr: faulting address in the shadow gmap
  * @r2t: parent gmap address of the region 2 table to get shadowed
+ * @fake: r2t references contiguous guest memory block, not a r2t
  *
  * The r2t parameter specifies the address of the source table. The
  * four pages of the source table are made read-only in the parent gmap
@@ -1491,7 +1500,8 @@ EXPORT_SYMBOL_GPL(gmap_shadow);
  *
  * Called with sg->mm->mmap_sem in read.
  */
-int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t)
+int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
+		    int fake)
 {
 	unsigned long raddr, origin, offset, len;
 	unsigned long *s_r2t, *table;
@@ -1504,6 +1514,8 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t)
 	if (!page)
 		return -ENOMEM;
 	page->index = r2t & _REGION_ENTRY_ORIGIN;
+	if (fake)
+		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_r2t = (unsigned long *) page_to_phys(page);
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
@@ -1526,6 +1538,12 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t)
 	if (sg->edat_level >= 1)
 		*table |= (r2t & _REGION_ENTRY_PROTECT);
 	list_add(&page->lru, &sg->crst_list);
+	if (fake) {
+		/* nothing to protect for fake tables */
+		*table &= ~_REGION_ENTRY_INVALID;
+		spin_unlock(&sg->guest_table_lock);
+		return 0;
+	}
 	spin_unlock(&sg->guest_table_lock);
 	/* Make r2t read-only in parent gmap page table */
 	raddr = (saddr & 0xffe0000000000000UL) | _SHADOW_RMAP_REGION1;
@@ -1558,6 +1576,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_r2t);
  * @sg: pointer to the shadow guest address space structure
  * @saddr: faulting address in the shadow gmap
  * @r3t: parent gmap address of the region 3 table to get shadowed
+ * @fake: r3t references contiguous guest memory block, not a r3t
  *
  * Returns 0 if successfully shadowed or already shadowed, -EAGAIN if the
  * shadow table structure is incomplete, -ENOMEM if out of memory and
@@ -1565,7 +1584,8 @@ EXPORT_SYMBOL_GPL(gmap_shadow_r2t);
  *
  * Called with sg->mm->mmap_sem in read.
  */
-int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t)
+int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
+		    int fake)
 {
 	unsigned long raddr, origin, offset, len;
 	unsigned long *s_r3t, *table;
@@ -1578,6 +1598,8 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t)
 	if (!page)
 		return -ENOMEM;
 	page->index = r3t & _REGION_ENTRY_ORIGIN;
+	if (fake)
+		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_r3t = (unsigned long *) page_to_phys(page);
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
@@ -1599,6 +1621,12 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t)
 	if (sg->edat_level >= 1)
 		*table |= (r3t & _REGION_ENTRY_PROTECT);
 	list_add(&page->lru, &sg->crst_list);
+	if (fake) {
+		/* nothing to protect for fake tables */
+		*table &= ~_REGION_ENTRY_INVALID;
+		spin_unlock(&sg->guest_table_lock);
+		return 0;
+	}
 	spin_unlock(&sg->guest_table_lock);
 	/* Make r3t read-only in parent gmap page table */
 	raddr = (saddr & 0xfffffc0000000000UL) | _SHADOW_RMAP_REGION2;
@@ -1932,7 +1960,8 @@ static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
 	/* Check for top level table */
 	start = sg->orig_asce & _ASCE_ORIGIN;
 	end = start + ((sg->orig_asce & _ASCE_TABLE_LENGTH) + 1) * 4096;
-	if (gaddr >= start && gaddr < end) {
+	if (!(sg->orig_asce & _ASCE_REAL_SPACE) && gaddr >= start &&
+	    gaddr < end) {
 		/* The complete shadow table has to go */
 		gmap_unshadow(sg);
 		spin_unlock(&sg->guest_table_lock);
-- 
2.5.5
