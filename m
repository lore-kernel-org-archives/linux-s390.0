From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v6 56/99] lustre: Convert to XArray
Date: Wed, 17 Jan 2018 12:21:20 -0800
Message-ID: <20180117202203.19756-57-willy@infradead.org>
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
 drivers/staging/lustre/lustre/llite/glimpse.c   | 12 +++++-------
 drivers/staging/lustre/lustre/mdc/mdc_request.c | 16 ++++++++--------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/glimpse.c b/drivers/staging/lustre/lustre/llite/glimpse.c
index 5f2843da911c..25232fdf5797 100644
--- a/drivers/staging/lustre/lustre/llite/glimpse.c
+++ b/drivers/staging/lustre/lustre/llite/glimpse.c
@@ -57,7 +57,7 @@ static const struct cl_lock_descr whole_file = {
 };
 
 /*
- * Check whether file has possible unwriten pages.
+ * Check whether file has possible unwritten pages.
  *
  * \retval 1    file is mmap-ed or has dirty pages
  *	 0    otherwise
@@ -66,16 +66,14 @@ blkcnt_t dirty_cnt(struct inode *inode)
 {
 	blkcnt_t cnt = 0;
 	struct vvp_object *vob = cl_inode2vvp(inode);
-	void	      *results[1];
 
-	if (inode->i_mapping)
-		cnt += radix_tree_gang_lookup_tag(&inode->i_mapping->pages,
-						  results, 0, 1,
-						  PAGECACHE_TAG_DIRTY);
+	if (inode->i_mapping && xa_tagged(&inode->i_mapping->pages,
+				PAGECACHE_TAG_DIRTY))
+		cnt = 1;
 	if (cnt == 0 && atomic_read(&vob->vob_mmap_cnt) > 0)
 		cnt = 1;
 
-	return (cnt > 0) ? 1 : 0;
+	return cnt;
 }
 
 int cl_glimpse_lock(const struct lu_env *env, struct cl_io *io,
diff --git a/drivers/staging/lustre/lustre/mdc/mdc_request.c b/drivers/staging/lustre/lustre/mdc/mdc_request.c
index 2ec79a6b17da..ea23247e9e02 100644
--- a/drivers/staging/lustre/lustre/mdc/mdc_request.c
+++ b/drivers/staging/lustre/lustre/mdc/mdc_request.c
@@ -934,17 +934,18 @@ static struct page *mdc_page_locate(struct address_space *mapping, __u64 *hash,
 	 * hash _smaller_ than one we are looking for.
 	 */
 	unsigned long offset = hash_x_index(*hash, hash64);
+	XA_STATE(xas, &mapping->pages, offset);
 	struct page *page;
-	int found;
 
-	xa_lock_irq(&mapping->pages);
-	found = radix_tree_gang_lookup(&mapping->pages,
-				       (void **)&page, offset, 1);
-	if (found > 0 && !xa_is_value(page)) {
+	xas_lock_irq(&xas);
+	page = xas_find(&xas, ULONG_MAX);
+	if (xa_is_value(page))
+		page = NULL;
+	if (page) {
 		struct lu_dirpage *dp;
 
 		get_page(page);
-		xa_unlock_irq(&mapping->pages);
+		xas_unlock_irq(&xas);
 		/*
 		 * In contrast to find_lock_page() we are sure that directory
 		 * page cannot be truncated (while DLM lock is held) and,
@@ -992,8 +993,7 @@ static struct page *mdc_page_locate(struct address_space *mapping, __u64 *hash,
 			page = ERR_PTR(-EIO);
 		}
 	} else {
-		xa_unlock_irq(&mapping->pages);
-		page = NULL;
+		xas_unlock_irq(&xas);
 	}
 	return page;
 }
-- 
2.15.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
