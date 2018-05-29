From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 4/6] vfio: ccw: refactor and improve pfn_array_alloc_pin()
Date: Tue, 29 May 2018 14:35:10 +0200
Message-ID: <20180529123512.14393-5-cohuck@redhat.com>
References: <20180529123512.14393-1-cohuck@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529123512.14393-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dong Jia Shi <bjsdjshi@linux.ibm.com>

This refactors pfn_array_alloc_pin() and also improves it by adding
defensive code in error handling so that calling pfn_array_unpin_free()
after error return won't lead to problem. This mainly does:
1. Merge pfn_array_pin() into pfn_array_alloc_pin(), since there is no
   other user of pfn_array_pin(). As a result, also remove kernel-doc
   for pfn_array_pin() and add/update kernel-doc for pfn_array_alloc_pin()
   and struct pfn_array.
2. For a vfio_pin_pages() failure, set pa->pa_nr to zero to indicate
   zero pages were pinned.
3. Set pa->pa_iova_pfn to NULL right after it was freed.

Suggested-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Message-Id: <20180523025645.8978-3-bjsdjshi@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 82 +++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 46 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index c532939c1c3f..b0f20230fc72 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -29,7 +29,7 @@ struct pfn_array {
 	unsigned long		*pa_iova_pfn;
 	/* Array that receives PFNs of the pages pinned. */
 	unsigned long		*pa_pfn;
-	/* Number of pages to pin/pinned from @pa_iova. */
+	/* Number of pages pinned from @pa_iova. */
 	int			pa_nr;
 };
 
@@ -50,64 +50,33 @@ struct ccwchain {
 };
 
 /*
- * pfn_array_pin() - pin user pages in memory
+ * pfn_array_alloc_pin() - alloc memory for PFNs, then pin user pages in memory
  * @pa: pfn_array on which to perform the operation
  * @mdev: the mediated device to perform pin/unpin operations
+ * @iova: target guest physical address
+ * @len: number of bytes that should be pinned from @iova
  *
- * Attempt to pin user pages in memory.
+ * Attempt to allocate memory for PFNs, and pin user pages in memory.
  *
  * Usage of pfn_array:
- * Any field in this structure should be initialized by caller.
- * We expect @pa->pa_nr > 0, and its value will be assigned by callee.
+ * We expect (pa_nr == 0) and (pa_iova_pfn == NULL), any field in
+ * this structure will be filled in by this function.
  *
  * Returns:
  *   Number of pages pinned on success.
- *   If @pa->pa_nr is 0 or negative, returns 0.
+ *   If @pa->pa_nr is not 0, or @pa->pa_iova_pfn is not NULL initially,
+ *   returns -EINVAL.
  *   If no pages were pinned, returns -errno.
  */
-static int pfn_array_pin(struct pfn_array *pa, struct device *mdev)
-{
-	int i, ret;
-
-	if (pa->pa_nr <= 0) {
-		pa->pa_nr = 0;
-		return 0;
-	}
-
-	pa->pa_iova_pfn[0] = pa->pa_iova >> PAGE_SHIFT;
-	for (i = 1; i < pa->pa_nr; i++)
-		pa->pa_iova_pfn[i] = pa->pa_iova_pfn[i - 1] + 1;
-
-	ret = vfio_pin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr,
-			     IOMMU_READ | IOMMU_WRITE, pa->pa_pfn);
-
-	if (ret > 0 && ret != pa->pa_nr) {
-		vfio_unpin_pages(mdev, pa->pa_iova_pfn, ret);
-		pa->pa_nr = 0;
-		return 0;
-	}
-
-	return ret;
-}
-
-/* Unpin the pages before releasing the memory. */
-static void pfn_array_unpin_free(struct pfn_array *pa, struct device *mdev)
-{
-	vfio_unpin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr);
-	pa->pa_nr = 0;
-	kfree(pa->pa_iova_pfn);
-}
-
-/* Alloc memory for PFNs, then pin pages with them. */
 static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
 			       u64 iova, unsigned int len)
 {
-	int ret = 0;
+	int i, ret = 0;
 
 	if (!len)
 		return 0;
 
-	if (pa->pa_nr)
+	if (pa->pa_nr || pa->pa_iova_pfn)
 		return -EINVAL;
 
 	pa->pa_iova = iova;
@@ -124,18 +93,39 @@ static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
 		return -ENOMEM;
 	pa->pa_pfn = pa->pa_iova_pfn + pa->pa_nr;
 
-	ret = pfn_array_pin(pa, mdev);
+	pa->pa_iova_pfn[0] = pa->pa_iova >> PAGE_SHIFT;
+	for (i = 1; i < pa->pa_nr; i++)
+		pa->pa_iova_pfn[i] = pa->pa_iova_pfn[i - 1] + 1;
+
+	ret = vfio_pin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr,
+			     IOMMU_READ | IOMMU_WRITE, pa->pa_pfn);
 
-	if (ret > 0)
-		return ret;
-	else if (!ret)
+	if (ret < 0) {
+		goto err_out;
+	} else if (ret > 0 && ret != pa->pa_nr) {
+		vfio_unpin_pages(mdev, pa->pa_iova_pfn, ret);
 		ret = -EINVAL;
+		goto err_out;
+	}
+
+	return ret;
 
+err_out:
+	pa->pa_nr = 0;
 	kfree(pa->pa_iova_pfn);
+	pa->pa_iova_pfn = NULL;
 
 	return ret;
 }
 
+/* Unpin the pages before releasing the memory. */
+static void pfn_array_unpin_free(struct pfn_array *pa, struct device *mdev)
+{
+	vfio_unpin_pages(mdev, pa->pa_iova_pfn, pa->pa_nr);
+	pa->pa_nr = 0;
+	kfree(pa->pa_iova_pfn);
+}
+
 static int pfn_array_table_init(struct pfn_array_table *pat, int nr)
 {
 	pat->pat_pa = kcalloc(nr, sizeof(*pat->pat_pa), GFP_KERNEL);
-- 
2.14.3
