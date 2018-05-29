From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 5/6] vfio: ccw: set ccw->cda to NULL defensively
Date: Tue, 29 May 2018 14:35:11 +0200
Message-ID: <20180529123512.14393-6-cohuck@redhat.com>
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

Let's avoid free on ccw->cda that points to a guest address
or an already freed memory area by setting it to NULL if memory
allocation didn't happen or failed.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Message-Id: <20180523025645.8978-4-bjsdjshi@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index b0f20230fc72..dbe7c7ac9ac8 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -502,7 +502,7 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	struct ccw1 *ccw;
 	struct pfn_array_table *pat;
 	unsigned long *idaws;
-	int idaw_nr;
+	int ret;
 
 	ccw = chain->ch_ccw + idx;
 
@@ -522,18 +522,19 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
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
@@ -541,6 +542,12 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
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
@@ -570,7 +577,7 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
 	pat = chain->ch_pat + idx;
 	ret = pfn_array_table_init(pat, idaw_nr);
 	if (ret)
-		return ret;
+		goto out_init;
 
 	/* Translate idal ccw to use new allocated idaws. */
 	idaws = kzalloc(idaw_len, GFP_DMA | GFP_KERNEL);
@@ -602,6 +609,8 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
 	kfree(idaws);
 out_unpin:
 	pfn_array_table_unpin_free(pat, cp->mdev);
+out_init:
+	ccw->cda = 0;
 	return ret;
 }
 
-- 
2.14.3
