From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v6 43/99] shmem: Convert find_swap_entry to XArray
Date: Wed, 17 Jan 2018 12:21:07 -0800
Message-ID: <20180117202203.19756-44-willy@infradead.org>
References: <20180117202203.19756-1-willy@infradead.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20180117202203.19756-1-willy@infradead.org>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/intel-gfx/>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
To: linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-usb@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, iommu@lists.linux-foundation.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org, linux-sh@vger.kernel.org, David Howells <dhowells@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

This is a 1:1 conversion.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/shmem.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 654f367aca90..ce285ae635ea 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1076,28 +1076,27 @@ static void shmem_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
-static unsigned long find_swap_entry(struct radix_tree_root *root, void *item)
+static unsigned long find_swap_entry(struct xarray *xa, void *item)
 {
-	struct radix_tree_iter iter;
-	void **slot;
-	unsigned long found = -1;
+	XA_STATE(xas, xa, 0);
 	unsigned int checked = 0;
+	void *entry;
 
 	rcu_read_lock();
-	radix_tree_for_each_slot(slot, root, &iter, 0) {
-		if (*slot == item) {
-			found = iter.index;
+	xas_for_each(&xas, entry, ULONG_MAX) {
+		if (xas_retry(&xas, entry))
+			continue;
+		if (entry == item)
 			break;
-		}
 		checked++;
-		if ((checked % 4096) != 0)
+		if ((checked % XA_CHECK_SCHED) != 0)
 			continue;
-		slot = radix_tree_iter_resume(slot, &iter);
+		xas_pause(&xas);
 		cond_resched_rcu();
 	}
-
 	rcu_read_unlock();
-	return found;
+
+	return xas_invalid(&xas) ? -1 : xas.xa_index;
 }
 
 /*
-- 
2.15.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
