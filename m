Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8059EC7EE29
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jun 2023 06:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjFMGfw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jun 2023 02:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjFMGfw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Jun 2023 02:35:52 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199D3E4A
        for <linux-s390@vger.kernel.org>; Mon, 12 Jun 2023 23:35:50 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-56ce96063bcso42709027b3.1
        for <linux-s390@vger.kernel.org>; Mon, 12 Jun 2023 23:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686638149; x=1689230149;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFlhYfT05gRGfWXFzY616GQregxgFkfQxnV5ZEMTYY8=;
        b=YNTUtJei8F473f4JPaKbdXaHBcijvokTgQbiDME0V5hA7P+2Ktrw988Zf5h5Nj3lqf
         cH9O9v+GuR3gvGy+GdoeyadyCn3W/ZoH5pT7JG7HxVHQSiIZStmxUi+aRznkD3RaO436
         yzZWsdkqc5WkWzdTw28zDRIYXQOyC36SDZg6ZsVtO21uLvvPNc9lVZH6zi5kFRCz5rJr
         sNh2bRt9mumXoH4RVulTT7ZVnSW16+5+JxW7q7bslL6TqoIL0DRRzVeVemWHMP54ZNI+
         dybmewOncocOfF8NCPLzgcOYsgcq+8keMKMDJlIbYA0m+/eNtPQ39sVCR0IPjkvICx8N
         9kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686638149; x=1689230149;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFlhYfT05gRGfWXFzY616GQregxgFkfQxnV5ZEMTYY8=;
        b=AaZosuViZCEm7tR9E7+/mAt/oLDsMfWoRANhAkKaxQNfjPq8D8A+Czrq0n3qByCQao
         c1zCDJQpv3YgPgDmP1UikubayHv9xTwo9m+CeDrZ/twBKTYwOuyBLHStU5YLtpLT2ytK
         mYJyHXQ6eOc8NSLA3aYmgsQHy53m2bv8tB1Y3ohmmzo6fusNQFVbdg8Q7VVJhBh85/dX
         zWqvbewuV4B7G+twa0lRTIbIFIKSZmEIj9zXSKTO3plVIjVC75CS8gQ8jhwqIEFDH0yg
         Fdxc76SXFRbOQy5P8GapQCXw6KrqUlIAvnae/k7tNVOFNhfeFm0yIcxeIwt+8PRjUN5W
         GUQw==
X-Gm-Message-State: AC+VfDy/jgkhDtv1+94i2Kygi/mTNno1mX3H21gkoGTDNC9+bQNlUbHe
        thcxS8ZmWYsqn3etRl25dm2uBcm2OhgmLYriDS7AEg==
X-Google-Smtp-Source: ACHHUZ6nX5deCaStEpM6bn3eSQJTlxZ0iIlwKVxybh2L/lK50SjSiJh378yPh+5xcO/nfJfv908hYw==
X-Received: by 2002:a81:5290:0:b0:569:74f3:f3f3 with SMTP id g138-20020a815290000000b0056974f3f3f3mr552714ywb.26.1686638149110;
        Mon, 12 Jun 2023 23:35:49 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u7-20020a0deb07000000b0056cffe97a11sm1892730ywe.13.2023.06.12.23.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 23:34:43 -0700 (PDT)
Date:   Mon, 12 Jun 2023 23:34:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 07/12] s390: add pte_free_defer(), with use of
 mmdrop_async()
In-Reply-To: <20230608174756.27cace18@thinkpad-T15>
Message-ID: <a948f24b-4fe6-8bc0-221a-65e9ccc8371a@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com> <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com> <20230606214037.09c6b280@thinkpad-T15> <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
 <20230608174756.27cace18@thinkpad-T15>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 8 Jun 2023, Gerald Schaefer wrote:
> On Wed, 7 Jun 2023 20:35:05 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
> > 
> > My current thinking (but may be proved wrong) is along the lines of:
> > why does something on its way to being freed need to be on any list
> > than the rcu_head list?  I expect the current answer is, that the
> > other half is allocated, so the page won't be freed; but I hope that
> > we can put it back on that list once we're through with the rcu_head.
> 
> Yes, that looks promising. Such a fragment would not necessarily need
> to be on the list, because while it is on its way, i.e. before the
> RCU call-back finished, it cannot be re-used anyway.
> 
> page_table_alloc() could currently find such a fragment on the list, but
> only to see the PP bits set, so it will not use it. Only after
> __tlb_remove_table() in the RCU call-back resets the bits, it would be
> usable again.
> 
> In your case, that could correspond to adding it back to the list.
> That could even be an improvement, because page_table_alloc() would
> not be bothered by such unusable fragments.

Cutting down the Ccs for now, to just the most interested parties:
here's what I came up with.  Which is entirely unbuilt and untested,
and I may have got several of those tricky mask conditionals wrong;
but seems a good way forward, except for the admitted unsolved flaw
(I do not want to mmgrab() for every single page table).

I don't think you're at all likely to hit that flaw in practice,
so if you have time, please do try reviewing and building and running
(a wrong mask conditional may stop it from even booting, but I hope
you'll be able to spot what's wrong without wasting too much time).
And maybe someone can come up with a good solution to the flaw.

Thanks!
Hugh

[PATCH 07/12] s390: add pte_free_defer() for pgtables sharing page

Add s390-specific pte_free_defer(), to call pte_free() via call_rcu().
pte_free_defer() will be called inside khugepaged's retract_page_tables()
loop, where allocating extra memory cannot be relied upon.  This precedes
the generic version to avoid build breakage from incompatible pgtable_t.

This version is more complicated than others: because s390 fits two 2K
page tables into one 4K page (so page->rcu_head must be shared between
both halves), and already uses page->lru (which page->rcu_head overlays)
to list any free halves; with clever management by page->_refcount bits.

Build upon the existing management, adjusted to follow a new rule that
a page is not linked to mm_context_t::pgtable_list while either half is
pending free, by either tlb_remove_table() or pte_free_defer(); but is
afterwards either relinked to the list (if other half is allocated), or
freed (if other half is free): by __tlb_remove_table() in both cases.

Set the page->pt_mm field to help with this.  But there is an unsolved
flaw: although reading that the other half is allocated guarantees that
the mm is still valid at that instant, what guarantees that it has not
already been freed before we take its context.lock?

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/s390/include/asm/pgalloc.h |   4 +
 arch/s390/mm/pgalloc.c          | 185 +++++++++++++++++++++++---------
 include/linux/mm_types.h        |   2 +-
 3 files changed, 142 insertions(+), 49 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 17eb618f1348..89a9d5ef94f8 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -143,6 +143,10 @@ static inline void pmd_populate(struct mm_struct *mm,
 #define pte_free_kernel(mm, pte) page_table_free(mm, (unsigned long *) pte)
 #define pte_free(mm, pte) page_table_free(mm, (unsigned long *) pte)
 
+/* arch use pte_free_defer() implementation in arch/s390/mm/pgalloc.c */
+#define pte_free_defer pte_free_defer
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
+
 void vmem_map_init(void);
 void *vmem_crst_alloc(unsigned long val);
 pte_t *vmem_pte_alloc(void);
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 66ab68db9842..b40b2c0008ca 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -172,7 +172,7 @@ void page_table_free_pgste(struct page *page)
  * When a parent page gets fully allocated it contains 2KB-pgtables in both
  * upper and lower halves and is removed from mm_context_t::pgtable_list.
  *
- * When 2KB-pgtable is freed from to fully allocated parent page that
+ * When 2KB-pgtable is freed from the fully allocated parent page that
  * page turns partially allocated and added to mm_context_t::pgtable_list.
  *
  * If 2KB-pgtable is freed from the partially allocated parent page that
@@ -182,16 +182,24 @@ void page_table_free_pgste(struct page *page)
  * As follows from the above, no unallocated or fully allocated parent
  * pages are contained in mm_context_t::pgtable_list.
  *
+ * NOTE NOTE NOTE: The commentary above and below has not yet been updated:
+ * the new rule is that a page is not linked to mm_context_t::pgtable_list
+ * while either half is pending free by any method; but afterwards is
+ * either relinked to it, or freed, by __tlb_remove_table().  This allows
+ * pte_free_defer() to use the page->rcu_head (which overlays page->lru).
+ *
  * The upper byte (bits 24-31) of the parent page _refcount is used
  * for tracking contained 2KB-pgtables and has the following format:
  *
- *   PP  AA
- * 01234567    upper byte (bits 24-31) of struct page::_refcount
- *   ||  ||
- *   ||  |+--- upper 2KB-pgtable is allocated
- *   ||  +---- lower 2KB-pgtable is allocated
- *   |+------- upper 2KB-pgtable is pending for removal
- *   +-------- lower 2KB-pgtable is pending for removal
+ *   PPHHAA
+ * 76543210    upper byte (bits 24-31) of struct page::_refcount
+ *   ||||||
+ *   |||||+--- lower 2KB-pgtable is allocated
+ *   ||||+---- upper 2KB-pgtable is allocated
+ *   |||+----- lower 2KB-pgtable is pending free by page->rcu_head
+ *   ||+------ upper 2KB-pgtable is pending free by page->rcu_head
+ *   |+------- lower 2KB-pgtable is pending free by any method
+ *   +-------- upper 2KB-pgtable is pending free by any method
  *
  * (See commit 620b4e903179 ("s390: use _refcount for pgtables") on why
  * using _refcount is possible).
@@ -200,7 +208,7 @@ void page_table_free_pgste(struct page *page)
  * The parent page is either:
  *   - added to mm_context_t::pgtable_list in case the second half of the
  *     parent page is still unallocated;
- *   - removed from mm_context_t::pgtable_list in case both hales of the
+ *   - removed from mm_context_t::pgtable_list in case both halves of the
  *     parent page are allocated;
  * These operations are protected with mm_context_t::lock.
  *
@@ -244,25 +252,15 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 			page = list_first_entry(&mm->context.pgtable_list,
 						struct page, lru);
 			mask = atomic_read(&page->_refcount) >> 24;
-			/*
-			 * The pending removal bits must also be checked.
-			 * Failure to do so might lead to an impossible
-			 * value of (i.e 0x13 or 0x23) written to _refcount.
-			 * Such values violate the assumption that pending and
-			 * allocation bits are mutually exclusive, and the rest
-			 * of the code unrails as result. That could lead to
-			 * a whole bunch of races and corruptions.
-			 */
-			mask = (mask | (mask >> 4)) & 0x03U;
-			if (mask != 0x03U) {
-				table = (unsigned long *) page_to_virt(page);
-				bit = mask & 1;		/* =1 -> second 2K */
-				if (bit)
-					table += PTRS_PER_PTE;
-				atomic_xor_bits(&page->_refcount,
-							0x01U << (bit + 24));
-				list_del(&page->lru);
-			}
+			/* Cannot be on this list if either half pending free */
+			WARN_ON_ONCE(mask & ~0x03U);
+			/* One or other half must be available, but not both */
+			WARN_ON_ONCE(mask == 0x00U || mask == 0x03U);
+			table = (unsigned long *)page_to_virt(page);
+			bit = mask & 0x01U;	/* =1 -> second 2K available */
+			table += bit * PTRS_PER_PTE;
+			atomic_xor_bits(&page->_refcount, 0x01U << (bit + 24));
+			list_del(&page->lru);
 		}
 		spin_unlock_bh(&mm->context.lock);
 		if (table)
@@ -278,6 +276,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	}
 	arch_set_page_dat(page, 0);
 	/* Initialize page table */
+	page->pt_mm = mm;
 	table = (unsigned long *) page_to_virt(page);
 	if (mm_alloc_pgste(mm)) {
 		/* Return 4K page table with PGSTEs */
@@ -295,7 +294,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	return table;
 }
 
-static void page_table_release_check(struct page *page, void *table,
+static void page_table_release_check(struct page *page, unsigned long *table,
 				     unsigned int half, unsigned int mask)
 {
 	char msg[128];
@@ -314,24 +313,22 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	struct page *page;
 
 	page = virt_to_page(table);
+	WARN_ON_ONCE(page->pt_mm != mm);
 	if (!mm_alloc_pgste(mm)) {
 		/* Free 2K page table fragment of a 4K page */
 		bit = ((unsigned long) table & ~PAGE_MASK)/(PTRS_PER_PTE*sizeof(pte_t));
 		spin_lock_bh(&mm->context.lock);
 		/*
-		 * Mark the page for delayed release. The actual release
-		 * will happen outside of the critical section from this
-		 * function or from __tlb_remove_table()
+		 * Mark the page for release. The actual release will happen
+		 * below from this function, or later from __tlb_remove_table().
 		 */
-		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
+		mask = atomic_xor_bits(&page->_refcount, 0x01U << (bit + 24));
 		mask >>= 24;
-		if (mask & 0x03U)
+		if (mask & 0x03U)		/* other half is allocated */
 			list_add(&page->lru, &mm->context.pgtable_list);
-		else
+		else if (!(mask & 0x30U))	/* other half not pending */
 			list_del(&page->lru);
 		spin_unlock_bh(&mm->context.lock);
-		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
-		mask >>= 24;
 		if (mask != 0x00U)
 			return;
 		half = 0x01U << bit;
@@ -355,6 +352,7 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 
 	mm = tlb->mm;
 	page = virt_to_page(table);
+	WARN_ON_ONCE(page->pt_mm != mm);
 	if (mm_alloc_pgste(mm)) {
 		gmap_unlink(mm, table, vmaddr);
 		table = (unsigned long *) ((unsigned long)table | 0x03U);
@@ -364,15 +362,13 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 	bit = ((unsigned long) table & ~PAGE_MASK) / (PTRS_PER_PTE*sizeof(pte_t));
 	spin_lock_bh(&mm->context.lock);
 	/*
-	 * Mark the page for delayed release. The actual release will happen
-	 * outside of the critical section from __tlb_remove_table() or from
-	 * page_table_free()
+	 * Mark the page for delayed release.
+	 * The actual release will happen later, from __tlb_remove_table().
 	 */
 	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
 	mask >>= 24;
-	if (mask & 0x03U)
-		list_add_tail(&page->lru, &mm->context.pgtable_list);
-	else
+	/* Other half not allocated? Other half not already pending free? */
+	if ((mask & 0x03U) == 0x00U && (mask & 0x30U) != 0x30U)
 		list_del(&page->lru);
 	spin_unlock_bh(&mm->context.lock);
 	table = (unsigned long *) ((unsigned long) table | (0x01U << bit));
@@ -382,17 +378,38 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 void __tlb_remove_table(void *_table)
 {
 	unsigned int mask = (unsigned long) _table & 0x03U, half = mask;
-	void *table = (void *)((unsigned long) _table ^ mask);
+	unsigned long *table = (unsigned long *)((unsigned long) _table ^ mask);
 	struct page *page = virt_to_page(table);
+	struct mm_struct *mm;
 
 	switch (half) {
 	case 0x00U:	/* pmd, pud, or p4d */
-		free_pages((unsigned long)table, CRST_ALLOC_ORDER);
+		__free_pages(page, CRST_ALLOC_ORDER);
 		return;
 	case 0x01U:	/* lower 2K of a 4K page table */
-	case 0x02U:	/* higher 2K of a 4K page table */
-		mask = atomic_xor_bits(&page->_refcount, mask << (4 + 24));
-		mask >>= 24;
+	case 0x02U:	/* upper 2K of a 4K page table */
+		/*
+		 * If the other half is marked as allocated, page->pt_mm must
+		 * still be valid, page->rcu_head no longer in use so page->lru
+		 * good for use, so now make the freed half available for reuse.
+		 * But be wary of races with that other half being freed.
+		 */
+		if (atomic_read(&page->_refcount) & (0x03U << 24)) {
+			mm = page->pt_mm;
+			/*
+			 * But what guarantees that mm has not been freed now?!
+			 * It's very unlikely, but we want certainty...
+			 */
+			spin_lock_bh(&mm->context.lock);
+			mask = atomic_xor_bits(&page->_refcount, mask << 28);
+			mask >>= 24;
+			if (mask & 0x03U)
+				list_add(&page->lru, &mm->context.pgtable_list);
+			spin_unlock_bh(&mm->context.lock);
+		} else {
+			mask = atomic_xor_bits(&page->_refcount, mask << 28);
+			mask >>= 24;
+		}
 		if (mask != 0x00U)
 			return;
 		break;
@@ -407,6 +424,78 @@ void __tlb_remove_table(void *_table)
 	__free_page(page);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void pte_free_now0(struct rcu_head *head);
+static void pte_free_now1(struct rcu_head *head);
+
+static void pte_free_pgste(struct rcu_head *head)
+{
+	unsigned long *table;
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	table = (unsigned long *)page_to_virt(page);
+	table = (unsigned long *)((unsigned long)table | 0x03U);
+	__tlb_remove_table(table);
+}
+
+static void pte_free_half(struct rcu_head *head, unsigned int bit)
+{
+	unsigned long *table;
+	struct page *page;
+	unsigned int mask;
+
+	page = container_of(head, struct page, rcu_head);
+	mask = atomic_xor_bits(&page->_refcount, 0x04U << (bit + 24));
+
+	table = (unsigned long *)page_to_virt(page);
+	table += bit * PTRS_PER_PTE;
+	table = (unsigned long *)((unsigned long)table | (0x01U << bit));
+	__tlb_remove_table(table);
+
+	/* If pte_free_defer() of the other half came in, queue it now */
+	if (mask & 0x0CU)
+		call_rcu(&page->rcu_head, bit ? pte_free_now0 : pte_free_now1);
+}
+
+static void pte_free_now0(struct rcu_head *head)
+{
+	pte_free_half(head, 0);
+}
+
+static void pte_free_now1(struct rcu_read *head)
+{
+	pte_free_half(head, 1);
+}
+
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	unsigned int bit, mask;
+	struct page *page;
+
+	page = virt_to_page(pgtable);
+	WARN_ON_ONCE(page->pt_mm != mm);
+	if (mm_alloc_pgste(mm)) {
+		call_rcu(&page->rcu_head, pte_free_pgste)
+		return;
+	}
+	bit = ((unsigned long)pgtable & ~PAGE_MASK) /
+			(PTRS_PER_PTE * sizeof(pte_t));
+
+	spin_lock_bh(&mm->context.lock);
+	mask = atomic_xor_bits(&page->_refcount, 0x15U << (bit + 24));
+	mask >>= 24;
+	/* Other half not allocated? Other half not already pending free? */
+	if ((mask & 0x03U) == 0x00U && (mask & 0x30U) != 0x30U)
+		list_del(&page->lru);
+	spin_unlock_bh(&mm->context.lock);
+
+	/* Do not relink on rcu_head if other half already linked on rcu_head */
+	if ((mask & 0x0CU) != 0x0CU)
+		call_rcu(&page->rcu_head, bit ? pte_free_now1 : pte_free_now0);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * Base infrastructure required to generate basic asces, region, segment,
  * and page tables that do not make use of enhanced features like EDAT1.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..1667a1bdb8a8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -146,7 +146,7 @@ struct page {
 			pgtable_t pmd_huge_pte; /* protected by page->ptl */
 			unsigned long _pt_pad_2;	/* mapping */
 			union {
-				struct mm_struct *pt_mm; /* x86 pgds only */
+				struct mm_struct *pt_mm; /* x86 pgd, s390 */
 				atomic_t pt_frag_refcount; /* powerpc */
 			};
 #if ALLOC_SPLIT_PTLOCKS
-- 
2.35.3

