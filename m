From: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Subject: [PATCH v3 3/4] vfio: ccw: set ccw->cda to NULL defensively
Date: Wed, 23 May 2018 04:45:01 +0200
Message-ID: <20180523024502.94244-4-bjsdjshi@linux.ibm.com>
References: <20180523024502.94244-1-bjsdjshi@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523024502.94244-1-bjsdjshi@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

Let's avoid free on ccw->cda that points to a guest address
or an already freed memory area by setting it to NULL if memory
allocation didn't happen or failed.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 262f969b3b33..63c3df1c2ff2 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -491,7 +491,7 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	struct ccw1 *ccw;
 	struct pfn_array_table *pat;
 	unsigned long *idaws;
-	int idaw_nr;
+	int ret;
 
 	ccw = chain->ch_ccw + idx;
 
@@ -511,18 +511,19 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	 * needed when translating a direct ccw to a idal ccw.
 	 */
 	pat = chain->ch_pat + idx;
-	if (pfn_array_table_init(pat, 1))
-		return -ENOMEM;
-	idaw_nr = pfn_array_alloc_pin(pat->pat_pa, cp->mdev,
-				      ccw->cda, ccw->count);
-	if (idaw_nr < 0)
-		return idaw_nr;
+	ret = pfn_array_table_init(pat, 1);
+	if (ret)
+		goto out_init;
+
+	ret = pfn_array_alloc_pin(pat->pat_pa, cp->mdev, ccw->cda, ccw->count);
+	if (ret < 0)
+		goto out_init;
 
 	/* Translate this direct ccw to a idal ccw. */
-	idaws = kcalloc(idaw_nr, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
+	idaws = kcalloc(ret, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
 	if (!idaws) {
-		pfn_array_table_unpin_free(pat, cp->mdev);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_unpin;
 	}
 	ccw->cda = (__u32) virt_to_phys(idaws);
 	ccw->flags |= CCW_FLAG_IDA;
@@ -530,6 +531,12 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	pfn_array_table_idal_create_words(pat, idaws);
 
 	return 0;
+
+out_unpin:
+	pfn_array_table_unpin_free(pat, cp->mdev);
+out_init:
+	ccw->cda = 0;
+	return ret;
 }
 
 static int ccwchain_fetch_idal(struct ccwchain *chain,
@@ -559,7 +566,7 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
 	pat = chain->ch_pat + idx;
 	ret = pfn_array_table_init(pat, idaw_nr);
 	if (ret)
-		return ret;
+		goto out_init;
 
 	/* Translate idal ccw to use new allocated idaws. */
 	idaws = kzalloc(idaw_len, GFP_DMA | GFP_KERNEL);
@@ -591,6 +598,8 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
 	kfree(idaws);
 out_unpin:
 	pfn_array_table_unpin_free(pat, cp->mdev);
+out_init:
+	ccw->cda = 0;
 	return ret;
 }
 
-- 
2.16.3
