Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727394AbhAMJm0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:26 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 12/14] s390/mm: Add gmap lock classes
Date: Wed, 13 Jan 2021 09:41:11 +0000
Message-Id: <20210113094113.133668-13-frankja@linux.ibm.com>
In-Reply-To: <20210113094113.133668-1-frankja@linux.ibm.com>
References: <20210113094113.133668-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

A shadow gmap and its parent are locked right after each other when
doing VSIE management. Lockdep can't differentiate between the two
classes without some help.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/gmap.h |  6 ++++++
 arch/s390/mm/gmap.c          | 40 +++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 4133d09597a5..4edbeb012e2a 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -26,6 +26,12 @@
 #define GMAP_SEGMENT_STATUS_BITS (_SEGMENT_ENTRY_GMAP_UC | _SEGMENT_ENTRY_GMAP_SPLIT)
 #define GMAP_SEGMENT_NOTIFY_BITS (_SEGMENT_ENTRY_GMAP_IN | _SEGMENT_ENTRY_GMAP_VSIE)
 
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
index 50dd95946d32..bc89fb974367 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1339,7 +1339,7 @@ static int gmap_protect_rmap_pte(struct gmap *sg, struct gmap_rmap *rmap,
 {
 	int rc = 0;
 
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	rc = gmap_protect_pte(sg->parent, paddr, vmaddr, ptep,
 			      prot, GMAP_NOTIFY_SHADOW);
 	if (!rc)
@@ -1874,7 +1874,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 		/* only allow one real-space gmap shadow */
 		list_for_each_entry(sg, &parent->children, list) {
 			if (sg->orig_asce & _ASCE_REAL_SPACE) {
-				spin_lock(&sg->guest_table_lock);
+				spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 				gmap_unshadow(sg);
 				spin_unlock(&sg->guest_table_lock);
 				list_del(&sg->list);
@@ -1946,7 +1946,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_r2t = (unsigned long *) page_to_phys(page);
 	/* Install shadow region second table */
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	table = gmap_table_walk(sg, saddr, 4); /* get region-1 pointer */
 	if (!table) {
 		rc = -EAGAIN;		/* Race with unshadow */
@@ -1979,7 +1979,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 	offset = ((r2t & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
 	len = ((r2t & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
 	rc = gmap_protect_rmap(sg, raddr, origin + offset, len);
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 4);
 		if (!table || (*table & _REGION_ENTRY_ORIGIN) !=
@@ -2030,7 +2030,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_r3t = (unsigned long *) page_to_phys(page);
 	/* Install shadow region second table */
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	table = gmap_table_walk(sg, saddr, 3); /* get region-2 pointer */
 	if (!table) {
 		rc = -EAGAIN;		/* Race with unshadow */
@@ -2063,7 +2063,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 	offset = ((r3t & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
 	len = ((r3t & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
 	rc = gmap_protect_rmap(sg, raddr, origin + offset, len);
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 3);
 		if (!table || (*table & _REGION_ENTRY_ORIGIN) !=
@@ -2114,7 +2114,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_sgt = (unsigned long *) page_to_phys(page);
 	/* Install shadow region second table */
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	table = gmap_table_walk(sg, saddr, 2); /* get region-3 pointer */
 	if (!table) {
 		rc = -EAGAIN;		/* Race with unshadow */
@@ -2147,7 +2147,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 	offset = ((sgt & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
 	len = ((sgt & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
 	rc = gmap_protect_rmap(sg, raddr, origin + offset, len);
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 2);
 		if (!table || (*table & _REGION_ENTRY_ORIGIN) !=
@@ -2203,7 +2203,7 @@ int gmap_shadow_sgt_lookup(struct gmap *sg, unsigned long saddr,
 	int rc = -EAGAIN;
 
 	BUG_ON(!gmap_is_shadow(sg));
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (sg->asce & _ASCE_TYPE_MASK) {
 		/* >2 GB guest */
 		r3e = (unsigned long *) gmap_table_walk(sg, saddr, 2);
@@ -2270,7 +2270,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 		page->index |= GMAP_SHADOW_FAKE_TABLE;
 	s_pgt = (unsigned long *) page_to_phys(page);
 	/* Install shadow page table */
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	table = gmap_table_walk(sg, saddr, 1); /* get segment pointer */
 	if (!table) {
 		rc = -EAGAIN;		/* Race with unshadow */
@@ -2298,7 +2298,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	raddr = (saddr & _SEGMENT_MASK) | _SHADOW_RMAP_SEGMENT;
 	origin = pgt & _SEGMENT_ENTRY_ORIGIN & PAGE_MASK;
 	rc = gmap_protect_rmap(sg, raddr, origin, PAGE_SIZE);
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 1);
 		if (!table || (*table & _SEGMENT_ENTRY_ORIGIN) !=
@@ -2359,7 +2359,7 @@ int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd)
 				rc = -EISDIR;
 				break;
 			}
-			spin_lock(&sg->guest_table_lock);
+			spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 			/* Get shadow segment table pointer */
 			tpmdp = (pmd_t *) gmap_table_walk(sg, saddr, 1);
 			if (!tpmdp) {
@@ -2464,7 +2464,8 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 			if (pmd_large(*spmdp)) {
 				pte_t spte;
 				if (!(pmd_val(*spmdp) & _SEGMENT_ENTRY_PROTECT)) {
-					spin_lock(&sg->guest_table_lock);
+					spin_lock_nested(&sg->guest_table_lock,
+							 GMAP_LOCK_SHADOW);
 					spte = __pte((pmd_val(*spmdp) &
 						      _SEGMENT_ENTRY_ORIGIN_LARGE)
 						     + (pte_index(paddr) << 12));
@@ -2477,7 +2478,8 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 				}
 			} else {
 				sptep = gmap_pte_from_pmd(parent, spmdp, paddr, &ptl_pte);
-				spin_lock(&sg->guest_table_lock);
+				spin_lock_nested(&sg->guest_table_lock,
+						 GMAP_LOCK_SHADOW);
 				if (sptep) {
 					rc = ptep_shadow_pte(sg->mm, saddr, sptep, tptep, pte);
 					if (rc > 0) {
@@ -2535,7 +2537,7 @@ static void gmap_shadow_notify_pmd(struct gmap *sg, unsigned long vmaddr,
 
 	BUG_ON(!gmap_is_shadow(sg));
 
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (sg->removed) {
 		spin_unlock(&sg->guest_table_lock);
 		return;
@@ -2586,7 +2588,7 @@ static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
 
 	BUG_ON(!gmap_is_shadow(sg));
 
-	spin_lock(&sg->guest_table_lock);
+	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
 	if (sg->removed) {
 		spin_unlock(&sg->guest_table_lock);
 		return;
@@ -2761,7 +2763,7 @@ static void gmap_pmdp_clear(struct mm_struct *mm, unsigned long vmaddr,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
-		spin_lock(&gmap->guest_table_lock);
+		spin_lock_nested(&gmap->guest_table_lock, GMAP_LOCK_PARENT);
 		pmdp = (pmd_t *)radix_tree_delete(&gmap->host_to_guest,
 						  vmaddr >> PMD_SHIFT);
 		if (pmdp) {
@@ -2816,7 +2818,7 @@ void gmap_pmdp_idte_local(struct mm_struct *mm, unsigned long vmaddr)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
-		spin_lock(&gmap->guest_table_lock);
+		spin_lock_nested(&gmap->guest_table_lock, GMAP_LOCK_PARENT);
 		entry = radix_tree_delete(&gmap->host_to_guest,
 					  vmaddr >> PMD_SHIFT);
 		if (entry) {
@@ -2852,7 +2854,7 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
-		spin_lock(&gmap->guest_table_lock);
+		spin_lock_nested(&gmap->guest_table_lock, GMAP_LOCK_PARENT);
 		entry = radix_tree_delete(&gmap->host_to_guest,
 					  vmaddr >> PMD_SHIFT);
 		if (entry) {
-- 
2.27.0
