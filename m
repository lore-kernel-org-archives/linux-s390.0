From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v3 16/16] s390/mm: Add gmap lock classes
Date: Fri,  9 Feb 2018 10:34:24 +0100
Message-ID: <1518168864-147803-17-git-send-email-frankja@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

A shadow gmap and its parent are locked right after each other when
doing VSIE management. Lockdep can't differentiate between the two
classes without some help.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/gmap.h |  6 ++++++
 arch/s390/mm/gmap.c          | 36 ++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 1347ff5..f0c44fe 100644
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
index 0b81863..8edfef5 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1337,7 +1337,7 @@ static int gmap_protect_rmap_pte(struct gmap *sg, struct gmap_rmap *rmap,
 	if (unlikely(!ptep))
 		return -ENOMEM;
 
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	rc = gmap_protect_pte(sg->parent, paddr, vmaddr, pmdp, hpmdp,
 			      prot, GMAP_NOTIFY_SHADOW);
 	if (!rc)
@@ -1848,7 +1848,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 		/* only allow one real-space gmap shadow */
 		list_for_each_entry(sg, &parent->children, list) {
 			if (sg->orig_asce & _ASCE_REAL_SPACE) {
-				spin_lock(&sg->guest_table_lock);
+				spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 				gmap_unshadow(sg);
 				spin_unlock(&sg->guest_table_lock);
 				list_del(&sg->list);
@@ -1920,7 +1920,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_r2t = (unsigned long *) page_to_phys(page);
 	/* Install shadow region second table */
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	table = gmap_table_walk(sg, saddr, 4); /* get region-1 pointer */
 	if (!table) {
 		rc = -EAGAIN;		/* Race with unshadow */
@@ -1953,7 +1953,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 	offset = ((r2t & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
 	len = ((r2t & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
 	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 4);
 		if (!table || (*table & _REGION_ENTRY_ORIGIN) !=
@@ -2004,7 +2004,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_r3t = (unsigned long *) page_to_phys(page);
 	/* Install shadow region second table */
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	table = gmap_table_walk(sg, saddr, 3); /* get region-2 pointer */
 	if (!table) {
 		rc = -EAGAIN;		/* Race with unshadow */
@@ -2036,7 +2036,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 	offset = ((r3t & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
 	len = ((r3t & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
 	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 3);
 		if (!table || (*table & _REGION_ENTRY_ORIGIN) !=
@@ -2087,7 +2087,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_sgt = (unsigned long *) page_to_phys(page);
 	/* Install shadow region second table */
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	table = gmap_table_walk(sg, saddr, 2); /* get region-3 pointer */
 	if (!table) {
 		rc = -EAGAIN;		/* Race with unshadow */
@@ -2120,7 +2120,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 	offset = ((sgt & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
 	len = ((sgt & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
 	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 2);
 		if (!table || (*table & _REGION_ENTRY_ORIGIN) !=
@@ -2176,7 +2176,7 @@ int gmap_shadow_sgt_lookup(struct gmap *sg, unsigned long saddr,
 	int rc = -EAGAIN;
 
 	BUG_ON(!gmap_is_shadow(sg));
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (sg->asce & _ASCE_TYPE_MASK) {
 		/* >2 GB guest */
 		r3e = (unsigned long *) gmap_table_walk(sg, saddr, 2);
@@ -2243,7 +2243,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_pgt = (unsigned long *) page_to_phys(page);
 	/* Install shadow page table */
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	table = gmap_table_walk(sg, saddr, 1); /* get segment pointer */
 	if (!table) {
 		rc = -EAGAIN;		/* Race with unshadow */
@@ -2271,7 +2271,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	raddr = (saddr & _SEGMENT_MASK) | _SHADOW_RMAP_SEGMENT;
 	origin = pgt & _SEGMENT_ENTRY_ORIGIN & PAGE_MASK;
 	rc = gmap_protect_rmap(sg, raddr, origin, PAGE_SIZE, PROT_READ);
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 1);
 		if (!table || (*table & _SEGMENT_ENTRY_ORIGIN) !=
@@ -2325,7 +2325,7 @@ int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd)
 		/* Let's look up the parent's mapping */
 		spmdp = gmap_pmd_op_walk(parent, paddr);
 		if (spmdp) {
-			spin_lock(&sg->guest_table_lock);
+			spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 			/* Get shadow segment table pointer */
 			tpmdp = (pmd_t *) gmap_table_walk(sg, saddr, 1);
 			if (!tpmdp) {
@@ -2420,7 +2420,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 		rc = -EAGAIN;
 		spmdp = gmap_pmd_op_walk(parent, paddr);
 		if (spmdp && !(pmd_val(*spmdp) & _SEGMENT_ENTRY_INVALID)) {
-			spin_lock(&sg->guest_table_lock);
+			spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 			/* Get page table pointer */
 			tptep = (pte_t *) gmap_table_walk(sg, saddr, 0);
 			if (!tptep) {
@@ -2497,7 +2497,7 @@ static void gmap_shadow_notify_pmd(struct gmap *sg, unsigned long vmaddr,
 
 	BUG_ON(!gmap_is_shadow(sg));
 
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (sg->removed) {
 		spin_unlock(&sg->guest_table_lock);
 		return;
@@ -2542,7 +2542,7 @@ static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
 
 	BUG_ON(!gmap_is_shadow(sg));
 
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (sg->removed) {
 		spin_unlock(&sg->guest_table_lock);
 		return;
@@ -2793,7 +2793,7 @@ static void gmap_pmdp_clear(struct mm_struct *mm, unsigned long vmaddr,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
-		spin_lock(&gmap->guest_table_lock);
+		spin_lock_nested(&gmap->guest_table_lock, GMAP_LOCK_PARENT);
 		pmdp = (pmd_t *)radix_tree_delete(&gmap->host_to_guest,
 						   vmaddr >> PMD_SHIFT);
 		if (pmdp) {
@@ -2843,7 +2843,7 @@ void gmap_pmdp_idte_local(struct mm_struct *mm, unsigned long vmaddr)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
-		spin_lock(&gmap->guest_table_lock);
+		spin_lock_nested(&gmap->guest_table_lock, GMAP_LOCK_PARENT);
 		entry = radix_tree_delete(&gmap->host_to_guest,
 					  vmaddr >> PMD_SHIFT);
 		if (entry) {
@@ -2878,7 +2878,7 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
-		spin_lock(&gmap->guest_table_lock);
+		spin_lock_nested(&gmap->guest_table_lock, GMAP_LOCK_PARENT);
 		entry = radix_tree_delete(&gmap->host_to_guest,
 					  vmaddr >> PMD_SHIFT);
 		if (entry) {
-- 
2.7.4
