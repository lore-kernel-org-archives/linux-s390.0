From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v6 58/99] dax: Convert lock_slot to XArray
Date: Wed, 17 Jan 2018 12:21:22 -0800
Message-ID: <20180117202203.19756-59-willy@infradead.org>
References: <20180117202203.19756-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20180117202203.19756-1-willy@infradead.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
List-Archive: <https://lore.kernel.org/intel-gfx/>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-nilfs@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, linux-sh@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Stefano Stabellini <sstabellini@kernel.org>, linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-btrfs@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/dax.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index f3463d93a6ce..8eab0b56f7f9 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -188,12 +188,11 @@ static void dax_wake_mapping_entry_waiter(struct address_space *mapping,
 /*
  * Mark the given slot as locked.  Must be called with xa_lock held.
  */
-static inline void *lock_slot(struct address_space *mapping, void **slot)
+static inline void *lock_slot(struct xa_state *xas)
 {
-	unsigned long v = xa_to_value(
-		radix_tree_deref_slot_protected(slot, &mapping->pages.xa_lock));
+	unsigned long v = xa_to_value(xas_load(xas));
 	void *entry = xa_mk_value(v | DAX_ENTRY_LOCK);
-	radix_tree_replace_slot(&mapping->pages, slot, entry);
+	xas_store(xas, entry);
 	return entry;
 }
 
@@ -244,7 +243,7 @@ static void dax_unlock_mapping_entry(struct address_space *mapping,
 
 	xas_lock_irq(&xas);
 	entry = xas_load(&xas);
-	if (WARN_ON_ONCE(!entry || !xa_is_value(entry) || !dax_locked(entry))) {
+	if (WARN_ON_ONCE(!xa_is_value(entry) || !dax_locked(entry))) {
 		xas_unlock_irq(&xas);
 		return;
 	}
@@ -303,6 +302,7 @@ static void put_unlocked_mapping_entry(struct address_space *mapping,
 static void *grab_mapping_entry(struct address_space *mapping, pgoff_t index,
 		unsigned long size_flag)
 {
+	XA_STATE(xas, &mapping->pages, index);
 	bool pmd_downgrade = false; /* splitting 2MiB entry into 4k entries? */
 	void *entry, **slot;
 
@@ -341,7 +341,7 @@ static void *grab_mapping_entry(struct address_space *mapping, pgoff_t index,
 			 * Make sure 'entry' remains valid while we drop
 			 * xa_lock.
 			 */
-			entry = lock_slot(mapping, slot);
+			entry = lock_slot(&xas);
 		}
 
 		xa_unlock_irq(&mapping->pages);
@@ -408,7 +408,7 @@ static void *grab_mapping_entry(struct address_space *mapping, pgoff_t index,
 		xa_unlock_irq(&mapping->pages);
 		return entry;
 	}
-	entry = lock_slot(mapping, slot);
+	entry = lock_slot(&xas);
  out_unlock:
 	xa_unlock_irq(&mapping->pages);
 	return entry;
@@ -639,6 +639,7 @@ static int dax_writeback_one(struct block_device *bdev,
 		pgoff_t index, void *entry)
 {
 	struct radix_tree_root *pages = &mapping->pages;
+	XA_STATE(xas, pages, index);
 	void *entry2, **slot, *kaddr;
 	long ret = 0, id;
 	sector_t sector;
@@ -675,7 +676,7 @@ static int dax_writeback_one(struct block_device *bdev,
 	if (!radix_tree_tag_get(pages, index, PAGECACHE_TAG_TOWRITE))
 		goto put_unlocked;
 	/* Lock the entry to serialize with page faults */
-	entry = lock_slot(mapping, slot);
+	entry = lock_slot(&xas);
 	/*
 	 * We can clear the tag now but we have to be careful so that concurrent
 	 * dax_writeback_one() calls for the same index cannot finish before we
@@ -1500,8 +1501,9 @@ static int dax_insert_pfn_mkwrite(struct vm_fault *vmf,
 				  pfn_t pfn)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	void *entry, **slot;
 	pgoff_t index = vmf->pgoff;
+	XA_STATE(xas, &mapping->pages, index);
+	void *entry, **slot;
 	int vmf_ret, error;
 
 	xa_lock_irq(&mapping->pages);
@@ -1517,7 +1519,7 @@ static int dax_insert_pfn_mkwrite(struct vm_fault *vmf,
 		return VM_FAULT_NOPAGE;
 	}
 	radix_tree_tag_set(&mapping->pages, index, PAGECACHE_TAG_DIRTY);
-	entry = lock_slot(mapping, slot);
+	entry = lock_slot(&xas);
 	xa_unlock_irq(&mapping->pages);
 	switch (pe_size) {
 	case PE_SIZE_PTE:
-- 
2.15.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
