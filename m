From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 09 Nov 2018 02:39:34 +0000
Subject: [RFC PATCH v1 07/10] s390/cio: Tell pfn_array_alloc_pin to pin pages, not bytes
Message-Id: <20181109023937.96105-8-farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This simplifies the code a little bit, both now and for later patches.

The inline function idal_nr_words() performs the same function that
we were doing here, which is figure out how many pages a given
contiguous piece of memory might span.  (That is, len/4K if aligned
on a 4K page, or len/4K + 1 if not.)  So we'll use this routine as
a matter of convenience, even though we're not building an IDAL.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index efc30152a89a..5f16aa88c629 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -54,7 +54,7 @@ struct ccwchain {
  * @pa: pfn_array on which to perform the operation
  * @mdev: the mediated device to perform pin/unpin operations
  * @iova: target guest physical address
- * @len: number of bytes that should be pinned from @iova
+ * @len: number of pages that should be pinned from @iova
  *
  * Attempt to allocate memory for PFNs, and pin user pages in memory.
  *
@@ -80,10 +80,7 @@ static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
 		return -EINVAL;
 
 	pa->pa_iova = iova;
-
-	pa->pa_nr = ((iova & ~PAGE_MASK) + len + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
-	if (!pa->pa_nr)
-		return -EINVAL;
+	pa->pa_nr = len;
 
 	pa->pa_iova_pfn = kcalloc(pa->pa_nr,
 				  sizeof(*pa->pa_iova_pfn) +
@@ -209,7 +206,8 @@ static long copy_from_iova(struct device *mdev,
 	int i, ret;
 	unsigned long l, m;
 
-	ret = pfn_array_alloc_pin(&pa, mdev, iova, n);
+	ret = pfn_array_alloc_pin(&pa, mdev, iova,
+				  idal_nr_words((void *)(iova), n));
 	if (ret <= 0)
 		return ret;
 
-- 
2.16.4
