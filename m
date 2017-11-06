From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 22/22] RFC: s390/mm: Add gmap lock classes
Date: Mon,  6 Nov 2017 23:30:00 +0100
Message-ID: <1510007400-42493-23-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

A shadow gmap and its parent are locked right after each other when
doing VSIE management. Lockdep can't differentiate between the two
classes without some help.

TODO: Not sure yet if I have to annotate all and if gmap_pmd_walk will
be used by both shadow and parent

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/gmap.h |  6 ++++++
 arch/s390/mm/gmap.c          | 40 ++++++++++++++++++++--------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 15a7834..31fad98 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -19,6 +19,12 @@
 #define _SEGMENT_ENTRY_GMAP_UC		0x4000	/* user dirty (migration) */
 #define _SEGMENT_ENTRY_GMAP_VSIE	0x8000	/* vsie bit */
 
+
+enum gmap_lock_class {
+	GMAP_LOCK_PARENT,
+	GMAP_LOCK_SHADOW
+};
+
 /**
  * struct gmap_struct - guest address space
  * @list: list head for the mm->context gmap list
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 3cc2765..b17f424 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -198,7 +198,7 @@ static void gmap_free(struct gmap *gmap)
 	gmap_radix_tree_free(&gmap->host_to_guest);
 
 	/* Free split pmd page tables */
-	spin_lock(&gmap->guest_table_lock);
+	spin_lock_nested(&gmap->guest_table_lock, GMAP_LOCK_PARENT);
 	list_for_each_entry_safe(page, next, &gmap->split_list, lru)
 		page_table_free_pgste(page);
 	spin_unlock(&gmap->guest_table_lock);
@@ -1385,7 +1385,7 @@ static int gmap_protect_rmap_large(struct gmap *sg, struct gmap_rmap *rmap,
 	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
 		return -EAGAIN;
 
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	rc = gmap_protect_large(sg->parent, paddr, vmaddr, pmdp, hpmdp,
 				prot, GMAP_ENTRY_VSIE);
 	if (!rc)
@@ -1413,7 +1413,7 @@ static int gmap_protect_rmap_pte(struct gmap *sg, struct gmap_rmap *rmap,
 		ptep = pte_alloc_map_lock(sg->parent->mm, pmdp, paddr, &ptl);
 
 	if (ptep) {
-		spin_lock(&sg->guest_table_lock);
+		spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 		rc = ptep_force_prot(sg->parent->mm, paddr, ptep, prot,
 				     PGSTE_VSIE_BIT);
 		if (!rc)
@@ -1932,7 +1932,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 		/* only allow one real-space gmap shadow */
 		list_for_each_entry(sg, &parent->children, list) {
 			if (sg->orig_asce & _ASCE_REAL_SPACE) {
-				spin_lock(&sg->guest_table_lock);
+				spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 				gmap_unshadow(sg);
 				spin_unlock(&sg->guest_table_lock);
 				list_del(&sg->list);
@@ -2004,7 +2004,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_r2t = (unsigned long *) page_to_phys(page);
 	/* Install shadow region second table */
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	table = gmap_table_walk(sg, saddr, 4); /* get region-1 pointer */
 	if (!table) {
 		rc = -EAGAIN;		/* Race with unshadow */
@@ -2037,7 +2037,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 	offset = ((r2t & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
 	len = ((r2t & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
 	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 4);
 		if (!table || (*table & _REGION_ENTRY_ORIGIN) !=
@@ -2088,7 +2088,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_r3t = (unsigned long *) page_to_phys(page);
 	/* Install shadow region second table */
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	table = gmap_table_walk(sg, saddr, 3); /* get region-2 pointer */
 	if (!table) {
 		rc = -EAGAIN;		/* Race with unshadow */
@@ -2120,7 +2120,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 	offset = ((r3t & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
 	len = ((r3t & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
 	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 3);
 		if (!table || (*table & _REGION_ENTRY_ORIGIN) !=
@@ -2171,7 +2171,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_sgt = (unsigned long *) page_to_phys(page);
 	/* Install shadow region second table */
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	table = gmap_table_walk(sg, saddr, 2); /* get region-3 pointer */
 	if (!table) {
 		rc = -EAGAIN;		/* Race with unshadow */
@@ -2204,7 +2204,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 	offset = ((sgt & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
 	len = ((sgt & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
 	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 2);
 		if (!table || (*table & _REGION_ENTRY_ORIGIN) !=
@@ -2260,7 +2260,7 @@ int gmap_shadow_sgt_lookup(struct gmap *sg, unsigned long saddr,
 	int rc = -EAGAIN;
 
 	BUG_ON(!gmap_is_shadow(sg));
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (sg->asce & _ASCE_TYPE_MASK) {
 		/* >2 GB guest */
 		r3e = (unsigned long *) gmap_table_walk(sg, saddr, 2);
@@ -2327,7 +2327,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_pgt = (unsigned long *) page_to_phys(page);
 	/* Install shadow page table */
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	table = gmap_table_walk(sg, saddr, 1); /* get segment pointer */
 	if (!table) {
 		rc = -EAGAIN;		/* Race with unshadow */
@@ -2355,7 +2355,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	raddr = (saddr & _SEGMENT_MASK) | _SHADOW_RMAP_SEGMENT;
 	origin = pgt & _SEGMENT_ENTRY_ORIGIN & PAGE_MASK;
 	rc = gmap_protect_rmap(sg, raddr, origin, PAGE_SIZE, PROT_READ);
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 1);
 		if (!table || (*table & _SEGMENT_ENTRY_ORIGIN) !=
@@ -2417,7 +2417,7 @@ int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd)
 		if (spmdp) {
 			if (!pmd_large(*spmdp))
 				BUG();
-			spin_lock(&sg->guest_table_lock);
+			spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 			/* Get shadow segment table pointer */
 			tpmdp = (pmd_t *) gmap_table_walk(sg, saddr, 1);
 			if (!tpmdp) {
@@ -2513,7 +2513,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 		rc = -EAGAIN;
 		spmdp = gmap_pmd_op_walk(parent, paddr);
 		if (spmdp && !(pmd_val(*spmdp) & _SEGMENT_ENTRY_INVALID)) {
-			spin_lock(&sg->guest_table_lock);
+			spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 			/* Get page table pointer */
 			tptep = (pte_t *) gmap_table_walk(sg, saddr, 0);
 			if (!tptep) {
@@ -2597,7 +2597,7 @@ static void gmap_shadow_notify_pmd(struct gmap *sg, unsigned long vmaddr,
 
 	BUG_ON(!gmap_is_shadow(sg));
 
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (sg->removed) {
 		spin_unlock(&sg->guest_table_lock);
 		return;
@@ -2658,7 +2658,7 @@ static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
 
 	BUG_ON(!gmap_is_shadow(sg));
 
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (sg->removed) {
 		spin_unlock(&sg->guest_table_lock);
 		return;
@@ -2899,7 +2899,7 @@ static void gmap_pmdp_clear(struct mm_struct *mm, unsigned long vmaddr,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
-		spin_lock(&gmap->guest_table_lock);
+		spin_lock_nested(&gmap->guest_table_lock, GMAP_LOCK_PARENT);
 		pmdp = (pmd_t *)radix_tree_delete(&gmap->host_to_guest,
 						   vmaddr >> PMD_SHIFT);
 		if (pmdp) {
@@ -2949,7 +2949,7 @@ void gmap_pmdp_idte_local(struct mm_struct *mm, unsigned long vmaddr)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
-		spin_lock(&gmap->guest_table_lock);
+		spin_lock_nested(&gmap->guest_table_lock, GMAP_LOCK_PARENT);
 		entry = radix_tree_delete(&gmap->host_to_guest,
 					  vmaddr >> PMD_SHIFT);
 		if (entry) {
@@ -2984,7 +2984,7 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
-		spin_lock(&gmap->guest_table_lock);
+		spin_lock_nested(&gmap->guest_table_lock, GMAP_LOCK_PARENT);
 		entry = radix_tree_delete(&gmap->host_to_guest,
 					  vmaddr >> PMD_SHIFT);
 		if (entry) {
-- 
2.7.4
