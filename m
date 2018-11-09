From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 09 Nov 2018 02:39:35 +0000
Subject: [RFC PATCH v1 08/10] s390/cio: Split pfn_array_alloc_pin into pieces
Message-Id: <20181109023937.96105-9-farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The pfn_array_alloc_pin routine is doing too much.  Today, it does the
alloc of the pfn_array struct and its member arrays, builds the iova
address lists out of a contiguous piece of guest memory, and asks vfio
to pin the resulting pages.  While the input iova variable points to a
contiguous piece of memory, the pfn_array, uh, array would permit a
non-contiguous range of addresses such as those provided by an IDA List.

By breaking pfn_array_alloc_pin into its component pieces, we will be in
a good place to share this code regardless of what pfn_array contains.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 96 +++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 52 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 5f16aa88c629..d01e146289fb 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -49,37 +49,32 @@ struct ccwchain {
 	struct pfn_array_table	*ch_pat;
 };
 
-/*
- * pfn_array_alloc_pin() - alloc memory for PFNs, then pin user pages in memory
- * @pa: pfn_array on which to perform the operation
- * @mdev: the mediated device to perform pin/unpin operations
- * @iova: target guest physical address
- * @len: number of pages that should be pinned from @iova
- *
- * Attempt to allocate memory for PFNs, and pin user pages in memory.
- *
- * Usage of pfn_array:
- * We expect (pa_nr == 0) and (pa_iova_pfn == NULL), any field in
- * this structure will be filled in by this function.
- *
- * Returns:
- *   Number of pages pinned on success.
- *   If @pa->pa_nr is not 0, or @pa->pa_iova_pfn is not NULL initially,
- *   returns -EINVAL.
- *   If no pages were pinned, returns -errno.
- */
-static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
-			       u64 iova, unsigned int len)
+static int pfn_array_pin(struct pfn_array *pa, struct device *mdev)
 {
-	int i, ret = 0;
+	int ret = 0;
+
+	ret = vfio_pin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr,
+			     IOMMU_READ | IOMMU_WRITE, pa->pa_pfn);
+
+	if (ret > 0 && ret != pa->pa_nr) {
+		vfio_unpin_pages(mdev, pa->pa_iova_pfn, ret);
+		ret = -EINVAL;
+	}
 
+	if (ret < 0)
+		pa->pa_iova = 0;
+
+	return ret;
+}
+
+static int pfn_array_alloc(struct pfn_array *pa, unsigned int len)
+{
 	if (!len)
 		return 0;
 
 	if (pa->pa_nr || pa->pa_iova_pfn)
 		return -EINVAL;
 
-	pa->pa_iova = iova;
 	pa->pa_nr = len;
 
 	pa->pa_iova_pfn = kcalloc(pa->pa_nr,
@@ -90,35 +85,14 @@ static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
 		return -ENOMEM;
 	pa->pa_pfn = pa->pa_iova_pfn + pa->pa_nr;
 
-	pa->pa_iova_pfn[0] = pa->pa_iova >> PAGE_SHIFT;
-	for (i = 1; i < pa->pa_nr; i++)
-		pa->pa_iova_pfn[i] = pa->pa_iova_pfn[i - 1] + 1;
-
-	ret = vfio_pin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr,
-			     IOMMU_READ | IOMMU_WRITE, pa->pa_pfn);
-
-	if (ret < 0) {
-		goto err_out;
-	} else if (ret > 0 && ret != pa->pa_nr) {
-		vfio_unpin_pages(mdev, pa->pa_iova_pfn, ret);
-		ret = -EINVAL;
-		goto err_out;
-	}
-
-	return ret;
-
-err_out:
-	pa->pa_nr = 0;
-	kfree(pa->pa_iova_pfn);
-	pa->pa_iova_pfn = NULL;
-
-	return ret;
+	return 0;
 }
 
 /* Unpin the pages before releasing the memory. */
 static void pfn_array_unpin_free(struct pfn_array *pa, struct device *mdev)
 {
-	vfio_unpin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr);
+	if (pa->pa_iova)
+		vfio_unpin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr);
 	pa->pa_nr = 0;
 	kfree(pa->pa_iova_pfn);
 }
@@ -206,11 +180,21 @@ static long copy_from_iova(struct device *mdev,
 	int i, ret;
 	unsigned long l, m;
 
-	ret = pfn_array_alloc_pin(&pa, mdev, iova,
-				  idal_nr_words((void *)(iova), n));
-	if (ret <= 0)
+	ret = pfn_array_alloc(&pa, idal_nr_words((void *)(iova), n));
+	if (ret < 0)
 		return ret;
 
+	pa.pa_iova = iova;
+	pa.pa_iova_pfn[0] = pa.pa_iova >> PAGE_SHIFT;
+	for (i = 1; i < pa.pa_nr; i++)
+		pa.pa_iova_pfn[i] = pa.pa_iova_pfn[i - 1] + 1;
+
+	ret = pfn_array_pin(&pa, mdev);
+	if (ret <= 0) {
+		pfn_array_unpin_free(&pa, mdev);
+		return ret;
+	}
+
 	l = n;
 	for (i = 0; i < pa.pa_nr; i++) {
 		from = pa.pa_pfn[i] << PAGE_SHIFT;
@@ -454,6 +438,7 @@ static int ccwchain_fetch_ccw(struct ccwchain *chain,
 {
 	struct ccw1 *ccw;
 	struct pfn_array_table *pat;
+	struct pfn_array *pa;
 	unsigned long *idaws;
 	u64 idaw_iova;
 	unsigned int idaw_nr, idaw_len;
@@ -515,11 +500,18 @@ static int ccwchain_fetch_ccw(struct ccwchain *chain,
 
 	for (i = 0; i < idaw_nr; i++) {
 		idaw_iova = *(idaws + i);
+		pa = pat->pat_pa + i;
 
-		ret = pfn_array_alloc_pin(pat->pat_pa + i, cp->mdev,
-					  idaw_iova, 1);
+		ret = pfn_array_alloc(pa, 1);
 		if (ret < 0)
 			goto out_free_idaws;
+
+		pa->pa_iova = idaws[0];
+		pa->pa_iova_pfn[0] = idaws[i] >> PAGE_SHIFT;
+
+		ret = pfn_array_pin(pa, cp->mdev);
+		if (ret <= 0)
+			goto out_free_idaws;
 	}
 
 	ccw->cda = virt_to_phys(idaws);
-- 
2.16.4
