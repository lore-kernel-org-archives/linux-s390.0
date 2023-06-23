Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166A6EB64D7
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jun 2023 05:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjFWFup (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jun 2023 01:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjFWFuZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jun 2023 01:50:25 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E812685
        for <linux-s390@vger.kernel.org>; Thu, 22 Jun 2023 22:49:54 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-57338656a8aso1587937b3.0
        for <linux-s390@vger.kernel.org>; Thu, 22 Jun 2023 22:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687499393; x=1690091393;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nOzLr/GtOShg9JEsPIWHWPAAGI2FORIyZI4S3C5T5/g=;
        b=HokrwIlzYBAsTADZ3YnzLnzGRCXRAVQjWee3vWUsahnisPm2eEoq1P7OLl1MwIoINB
         8YQf2AcjhQaTvxNZ1W1L3O/+98rkLIXVrVv+R8v/hAbuWmaheYSwL6hyun480FsmaMFp
         /jEAQlyvjm3wVGX9+o70zOS3Kjig1Ly+LVYqYbsDK20j/23BJypacQDCuzEjkNSJqDN+
         vclX7ptk2h1DnOFc/CjTABw1atrRJNwxDufNLZ77BasSFfCUQjrLxk71xLM3+JQ1UsRS
         brj5Asgo+sBRRupjttyt3FW0KKlYuMSJnetySUZ+0rKdsx3yxuzq/UCzlR2rF/jglydj
         J2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687499393; x=1690091393;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOzLr/GtOShg9JEsPIWHWPAAGI2FORIyZI4S3C5T5/g=;
        b=iOCSNqAvA0ta7xqp3oQyBG/fWU0MGzDwONkp0SlcpGomtNRXkaDz3jGXc4jxAul+rP
         K1nqhx5t3suGFdR5zC1ncE2Iy0snxRZBSnGU5zfzvQqdaYENRF+KShfCyBALpbYy1fKt
         lqTmSPspXOEtLqaS/dR9ZmD+JzpLDVXI8JJRs20gBTihgCr79rnCL/ve2KXen+KdFMzI
         oWZ/YXxNcSZsawvRQj3C5vdiTTkRepsgPGtQLXPu7AmK/bIrnJWxRtbvwglEydvpprMR
         qUh5D2lHuTmS+inOAAo0yHkORizzlepgVpP6DJbP5MAqyhEwxY2TkJXHbyXtbuOSyo9b
         v50w==
X-Gm-Message-State: AC+VfDynFi8NxXZMkv7WRhpP6b1PMhSc801DzNPOS55e8qYjaEVNp2jh
        PpAySKJCh3L8pFYBILLhzUR9Lk8hyXkfmXyJjAlaOA==
X-Google-Smtp-Source: ACHHUZ7G6WPJN5lrXxANS3xsR9gUIW56P+Yi9cLpdv9OrGXmaNYUh/M6nRNR0I4kCtqJ4sf/LVxwAA==
X-Received: by 2002:a0d:d48f:0:b0:570:700c:ccbb with SMTP id w137-20020a0dd48f000000b00570700cccbbmr16401395ywd.33.1687499393108;
        Thu, 22 Jun 2023 22:49:53 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o206-20020a8173d7000000b0055a881abfc3sm2262281ywc.135.2023.06.22.22.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 22:49:52 -0700 (PDT)
Date:   Thu, 22 Jun 2023 22:49:43 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
cc:     Jason Gunthorpe <jgg@ziepe.ca>, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: prospective 13/12 s390 pgtable_list patch
Message-ID: <a69a26c0-ec93-3ad-a443-6655b5e49df2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Gerald,

It's that moment you've been dreading: I'm hoping that you can, please,
take a look at the patch below, and try building and running with it,
on top of the v2 series of 12 I sent out on Tuesday.

If this seems okay to you, I'll send it properly as 13/12 of that series,
to the full Cc list; but of course you may find I've missed typos and worse
- please don't waste your time on it if it's rubbish, but so far as I can
tell, it is complete and ready now.

Thanks!
Hugh

s390: SLAB_TYPESAFE_BY_RCU mm->context.pgtable_list

Move the s390 pgtable_list (with dedicated spinlock) out of mm->context
into a separate kmem_cache object specified with SLAB_TYPESAFE_BY_RCU:
which then allows __tlb_remove_table() to add a page back to the list,
safely, when the other half is still in use.

Update the commentary on pgtable_list above page_table_alloc().

Stop using pt_mm in struct page: this needs a pt_list in that union.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/s390/include/asm/mmu.h         |  10 +-
 arch/s390/include/asm/mmu_context.h |   8 +-
 arch/s390/mm/pgalloc.c              | 151 ++++++++++++++++++----------
 include/linux/mm_types.h            |   4 +-
 4 files changed, 117 insertions(+), 56 deletions(-)

diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index 829d68e2c685..069cdd612d86 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -6,12 +6,18 @@
 #include <linux/errno.h>
 #include <asm/asm-extable.h>
 
+struct pgtable_list {
+	struct list_head list;
+	spinlock_t lock;
+};
+extern struct pgtable_list init_pgtable_list;
+
 typedef struct {
 	spinlock_t lock;
 	cpumask_t cpu_attach_mask;
 	atomic_t flush_count;
 	unsigned int flush_mm;
-	struct list_head pgtable_list;
+	struct pgtable_list *pgtable_list;
 	struct list_head gmap_list;
 	unsigned long gmap_asce;
 	unsigned long asce;
@@ -39,7 +45,7 @@ typedef struct {
 
 #define INIT_MM_CONTEXT(name)						   \
 	.context.lock =	__SPIN_LOCK_UNLOCKED(name.context.lock),	   \
-	.context.pgtable_list = LIST_HEAD_INIT(name.context.pgtable_list), \
+	.context.pgtable_list = &init_pgtable_list,			   \
 	.context.gmap_list = LIST_HEAD_INIT(name.context.gmap_list),
 
 #endif
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 2a38af5a00c2..725f82c55036 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -15,14 +15,20 @@
 #include <asm/ctl_reg.h>
 #include <asm-generic/mm_hooks.h>
 
+bool alloc_pgtable_list(struct mm_struct *mm);
+void destroy_context(struct mm_struct *mm);
+#define destroy_context destroy_context
+
 #define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
 	unsigned long asce_type, init_entry;
 
+	if (!alloc_pgtable_list(mm))
+		return -ENOMEM;
+
 	spin_lock_init(&mm->context.lock);
-	INIT_LIST_HEAD(&mm->context.pgtable_list);
 	INIT_LIST_HEAD(&mm->context.gmap_list);
 	cpumask_clear(&mm->context.cpu_attach_mask);
 	atomic_set(&mm->context.flush_count, 0);
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 11983a3ff95a..7f851b2dad49 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -159,15 +159,41 @@ void page_table_free_pgste(struct page *page)
 
 #endif /* CONFIG_PGSTE */
 
-/*
- * Temporarily use a global spinlock instead of mm->context.lock.
- * This will be replaced by a per-mm spinlock in a followup commit.
- */
-static DEFINE_SPINLOCK(mm_pgtable_list_lock);
+struct pgtable_list init_pgtable_list = {
+	.list	= LIST_HEAD_INIT(init_pgtable_list.list),
+	.lock	= __SPIN_LOCK_UNLOCKED(init_pgtable_list.lock),
+};
+
+static struct kmem_cache *pgtable_list_cachep;
+
+static void pgtable_list_ctor(void *object)
+{
+	struct pgtable_list *pgtable_list = object;
+
+	INIT_LIST_HEAD(&pgtable_list->list);
+	spin_lock_init(&pgtable_list->lock);
+}
+
+bool alloc_pgtable_list(struct mm_struct *mm)
+{
+	if (unlikely(!pgtable_list_cachep)) {	/* first time */
+		pgtable_list_cachep = kmem_cache_create("pgtable_list",
+			sizeof(struct pgtable_list), 0,
+			SLAB_TYPESAFE_BY_RCU | SLAB_PANIC, pgtable_list_ctor);
+	}
+	mm->context.pgtable_list =
+		kmem_cache_alloc(pgtable_list_cachep, GFP_KERNEL);
+	return !!mm->context.pgtable_list;
+}
+
+void destroy_context(struct mm_struct *mm)
+{
+	kmem_cache_free(pgtable_list_cachep, mm->context.pgtable_list);
+}
+
 /*
  * A 2KB-pgtable is either upper or lower half of a normal page.
- * The second half of the page may be unused or used as another
- * 2KB-pgtable.
+ * The other half of the page may be unused or used as another 2KB-pgtable.
  *
  * Whenever possible the parent page for a new 2KB-pgtable is picked
  * from the list of partially allocated pages mm_context_t::pgtable_list.
@@ -187,11 +213,15 @@ static DEFINE_SPINLOCK(mm_pgtable_list_lock);
  * As follows from the above, no unallocated or fully allocated parent
  * pages are contained in mm_context_t::pgtable_list.
  *
- * NOTE NOTE NOTE: The commentary above and below has not yet been updated:
- * the new rule is that a page is not linked to mm_context_t::pgtable_list
- * while either half is pending free by any method; but afterwards is
- * either relinked to it, or freed, by __tlb_remove_table().  This allows
- * pte_free_defer() to use the page->rcu_head (which overlays page->lru).
+ * However, there is a further twist. If a 2KB-pgtable is allocated in
+ * advance, in case it might be needed, but is then freed without being
+ * used, then it is freed immediately as described above.
+ *
+ * But when a 2KB-pgtable is freed after use, it usually passes through
+ * the quarantine of an RCU grace period, pending the actual free. While
+ * in this pending state, it cannot be reallocated, and its parent page
+ * is not permitted on mm_context_t::pgtable_list - no matter whether
+ * the other half is allocated, or pending free, or free.
  *
  * The upper byte (bits 24-31) of the parent page _refcount is used
  * for tracking contained 2KB-pgtables and has the following format:
@@ -211,32 +241,37 @@ static DEFINE_SPINLOCK(mm_pgtable_list_lock);
  *
  * When 2KB-pgtable is allocated the corresponding AA bit is set to 1.
  * The parent page is either:
- *   - added to mm_context_t::pgtable_list in case the second half of the
+ *   - added to mm_context_t::pgtable_list in case the other half of the
  *     parent page is still unallocated;
  *   - removed from mm_context_t::pgtable_list in case both halves of the
  *     parent page are allocated;
- * These operations are protected with mm_context_t::lock.
+ * These operations are protected with mm_context_t::pgtable_list::lock.
  *
  * When 2KB-pgtable is deallocated the corresponding AA bit is set to 0
  * and the corresponding PP bit is set to 1 in a single atomic operation.
  * Thus, PP and AA bits corresponding to the same 2KB-pgtable are mutually
  * exclusive and may never be both set to 1!
  * The parent page is either:
- *   - added to mm_context_t::pgtable_list in case the second half of the
- *     parent page is still allocated;
- *   - removed from mm_context_t::pgtable_list in case the second half of
- *     the parent page is unallocated;
- * These operations are protected with mm_context_t::lock.
+ *   - added to mm_context_t::pgtable_list in case the other half of the
+ *     parent page is still allocated - but never when setting the PP bit;
+ *   - removed from mm_context_t::pgtable_list in case the other half of
+ *     the parent page is unallocated (and not pending free, when the
+ *     parent page would already have been removed from the list);
+ * These operations are protected with mm_context_t::pgtable_list::lock.
  *
- * It is important to understand that mm_context_t::lock only protects
- * mm_context_t::pgtable_list and AA bits, but not the parent page itself
- * and PP bits.
+ * It is important to understand that mm_context_t::pgtable_list::lock
+ * only protects mm_context_t::pgtable_list::list and AA bits, but not
+ * the parent page itself and PP bits.
  *
- * Releasing the parent page happens whenever the PP bit turns from 1 to 0,
- * while both AA bits and the second PP bit are already unset. Then the
- * parent page does not contain any 2KB-pgtable fragment anymore, and it has
- * also been removed from mm_context_t::pgtable_list. It is safe to release
- * the page therefore.
+ * Releasing the parent page happens whenever both PP bits and both AA bits
+ * are unset. Then the parent page does not contain a 2KB-pgtable fragment
+ * anymore, and it has also been removed from mm_context_t::pgtable_list.
+ * It is safe to release the page therefore.
+ *
+ * The HH bits play no part in this logic, but indicate whether either
+ * 2KB-pgtable is using, or is waiting to use, the parent page's rcu_head.
+ * When required, the HH bit is set at the same time as setting the PP bit,
+ * then unset just before unsetting the PP bit.
  *
  * PGSTE memory spaces use full 4KB-pgtables and do not need most of the
  * logic described above. Both AA bits are set to 1 to denote a 4KB-pgtable
@@ -245,6 +280,7 @@ static DEFINE_SPINLOCK(mm_pgtable_list_lock);
  */
 unsigned long *page_table_alloc(struct mm_struct *mm)
 {
+	struct pgtable_list *pgtable_list = mm->context.pgtable_list;
 	unsigned long *table;
 	struct page *page;
 	unsigned int mask, bit;
@@ -252,9 +288,9 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	/* Try to get a fragment of a 4K page as a 2K page table */
 	if (!mm_alloc_pgste(mm)) {
 		table = NULL;
-		spin_lock_bh(&mm_pgtable_list_lock);
-		if (!list_empty(&mm->context.pgtable_list)) {
-			page = list_first_entry(&mm->context.pgtable_list,
+		spin_lock_bh(&pgtable_list->lock);
+		if (!list_empty(&pgtable_list->list)) {
+			page = list_first_entry(&pgtable_list->list,
 						struct page, lru);
 			mask = atomic_read(&page->_refcount) >> 24;
 			/* Cannot be on this list if either half pending free */
@@ -267,7 +303,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 			atomic_xor_bits(&page->_refcount, 0x01U << (bit + 24));
 			list_del(&page->lru);
 		}
-		spin_unlock_bh(&mm_pgtable_list_lock);
+		spin_unlock_bh(&pgtable_list->lock);
 		if (table)
 			return table;
 	}
@@ -281,7 +317,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	}
 	arch_set_page_dat(page, 0);
 	/* Initialize page table */
-	page->pt_mm = mm;
+	page->pt_list = pgtable_list;
 	table = (unsigned long *) page_to_virt(page);
 	if (mm_alloc_pgste(mm)) {
 		/* Return 4K page table with PGSTEs */
@@ -292,9 +328,9 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 		/* Return the first 2K fragment of the page */
 		atomic_xor_bits(&page->_refcount, 0x01U << 24);
 		memset64((u64 *)table, _PAGE_INVALID, 2 * PTRS_PER_PTE);
-		spin_lock_bh(&mm_pgtable_list_lock);
-		list_add(&page->lru, &mm->context.pgtable_list);
-		spin_unlock_bh(&mm_pgtable_list_lock);
+		spin_lock_bh(&pgtable_list->lock);
+		list_add(&page->lru, &pgtable_list->list);
+		spin_unlock_bh(&pgtable_list->lock);
 	}
 	return table;
 }
@@ -314,6 +350,7 @@ static void page_table_release_check(struct page *page, unsigned long *table,
 
 void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
+	struct pgtable_list *pgtable_list;
 	unsigned int mask, bit, half;
 	struct page *page;
 
@@ -321,7 +358,8 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	if (!mm_alloc_pgste(mm)) {
 		/* Free 2K page table fragment of a 4K page */
 		bit = ((unsigned long) table & ~PAGE_MASK)/(PTRS_PER_PTE*sizeof(pte_t));
-		spin_lock_bh(&mm_pgtable_list_lock);
+		pgtable_list = mm->context.pgtable_list;
+		spin_lock_bh(&pgtable_list->lock);
 		/*
 		 * Mark the page for release. The actual release will happen
 		 * below from this function, or later from __tlb_remove_table().
@@ -329,10 +367,10 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 		mask = atomic_xor_bits(&page->_refcount, 0x01U << (bit + 24));
 		mask >>= 24;
 		if (mask & 0x03U)		/* other half is allocated */
-			list_add(&page->lru, &mm->context.pgtable_list);
+			list_add(&page->lru, &pgtable_list->list);
 		else if (!(mask & 0x30U))	/* other half not pending */
 			list_del(&page->lru);
-		spin_unlock_bh(&mm_pgtable_list_lock);
+		spin_unlock_bh(&pgtable_list->lock);
 		if (mask != 0x00U)
 			return;
 		half = 0x01U << bit;
@@ -350,6 +388,7 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 			 unsigned long vmaddr)
 {
+	struct pgtable_list *pgtable_list;
 	struct mm_struct *mm;
 	struct page *page;
 	unsigned int bit, mask;
@@ -363,7 +402,8 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 		return;
 	}
 	bit = ((unsigned long) table & ~PAGE_MASK) / (PTRS_PER_PTE*sizeof(pte_t));
-	spin_lock_bh(&mm_pgtable_list_lock);
+	pgtable_list = mm->context.pgtable_list;
+	spin_lock_bh(&pgtable_list->lock);
 	/*
 	 * Mark the page for delayed release.
 	 * The actual release will happen later, from __tlb_remove_table().
@@ -373,7 +413,7 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 	/* Other half not allocated? Other half not already pending free? */
 	if ((mask & 0x03U) == 0x00U && (mask & 0x30U) != 0x30U)
 		list_del(&page->lru);
-	spin_unlock_bh(&mm_pgtable_list_lock);
+	spin_unlock_bh(&pgtable_list->lock);
 	table = (unsigned long *) ((unsigned long) table | (0x01U << bit));
 	tlb_remove_table(tlb, table);
 }
@@ -391,30 +431,35 @@ void __tlb_remove_table(void *_table)
 	case 0x01U:	/* lower 2K of a 4K page table */
 	case 0x02U:	/* upper 2K of a 4K page table */
 		/*
-		 * If the other half is marked as allocated, page->pt_mm must
+		 * If other half is marked allocated, mm and page->pt_list must
 		 * still be valid, page->rcu_head no longer in use so page->lru
 		 * good for use, so now make the freed half available for reuse.
 		 * But be wary of races with that other half being freed.
 		 */
+		rcu_read_lock();
 		if (atomic_read(&page->_refcount) & (0x03U << 24)) {
-			struct mm_struct *mm = page->pt_mm;
+			struct pgtable_list *pgtable_list = page->pt_list;
 			/*
-			 * It is safe to use page->pt_mm when the other half
-			 * is seen allocated while holding pgtable_list lock;
-			 * but how will it be safe to acquire that spinlock?
-			 * Global mm_pgtable_list_lock is safe and easy for
-			 * now, then a followup commit will split it per-mm.
+			 * Here we are either directly freeing from a valid mm,
+			 * or in RCU callback context.  In the latter case, the
+			 * mm might already have been freed since the _refcount
+			 * check above; but SLAB_TYPESAFE_BY_RCU ensures that
+			 * pgtable_list still points to a valid pgtable_list,
+			 * with a spinlock_t in the right place, even if it is
+			 * no longer "ours".  Take that lock and recheck the
+			 * _refcount before adding to pgtable_list->list.
 			 */
-			spin_lock_bh(&mm_pgtable_list_lock);
+			spin_lock_bh(&pgtable_list->lock);
 			mask = atomic_xor_bits(&page->_refcount, mask << 28);
 			mask >>= 24;
 			if (mask & 0x03U)
-				list_add(&page->lru, &mm->context.pgtable_list);
-			spin_unlock_bh(&mm_pgtable_list_lock);
+				list_add(&page->lru, &pgtable_list->list);
+			spin_unlock_bh(&pgtable_list->lock);
 		} else {
 			mask = atomic_xor_bits(&page->_refcount, mask << 28);
 			mask >>= 24;
 		}
+		rcu_read_unlock();
 		if (mask != 0x00U)
 			return;
 		break;
@@ -475,6 +520,7 @@ static void pte_free_now1(struct rcu_head *head)
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 {
+	struct pgtable_list *pgtable_list;
 	unsigned int bit, mask;
 	struct page *page;
 
@@ -486,13 +532,14 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 	bit = ((unsigned long)pgtable & ~PAGE_MASK) /
 			(PTRS_PER_PTE * sizeof(pte_t));
 
-	spin_lock_bh(&mm_pgtable_list_lock);
+	pgtable_list = mm->context.pgtable_list;
+	spin_lock_bh(&pgtable_list->lock);
 	mask = atomic_xor_bits(&page->_refcount, 0x15U << (bit + 24));
 	mask >>= 24;
 	/* Other half not allocated? Other half not already pending free? */
 	if ((mask & 0x03U) == 0x00U && (mask & 0x30U) != 0x30U)
 		list_del(&page->lru);
-	spin_unlock_bh(&mm_pgtable_list_lock);
+	spin_unlock_bh(&pgtable_list->lock);
 
 	/* Do not relink on rcu_head if other half already linked on rcu_head */
 	if ((mask & 0x0CU) != 0x0CU)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 09335fa28c41..a5b131abd82f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -31,6 +31,7 @@
 
 struct address_space;
 struct mem_cgroup;
+struct pgtable_list;
 
 /*
  * Each physical page in the system has a struct page associated with
@@ -150,7 +151,8 @@ struct page {
 			 */
 			unsigned long _pt_pad_2;	/* mapping */
 			union {
-				struct mm_struct *pt_mm; /* x86 pgd, s390 */
+				struct mm_struct *pt_mm; /* x86 pgds only */
+				struct pgtable_list *pt_list; /* s390 */
 				atomic_t pt_frag_refcount; /* powerpc */
 			};
 #if ALLOC_SPLIT_PTLOCKS
-- 
2.35.3

