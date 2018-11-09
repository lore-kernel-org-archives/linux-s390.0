From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 09 Nov 2018 02:39:33 +0000
Subject: [RFC PATCH v1 06/10] s390/cio: Combine ccwchain_fetch _idal and _direct
Message-Id: <20181109023937.96105-7-farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

There's so much overlap between these functions, and the only
difference is whether or not the input CCW is a direct-address
or an Indirect Data Address (IDA) List or not.  Since the output
is an IDAL for both, let's combine the two routines.

We rename the resulting function ccwchain_fetch_ccw to express
its combined purpose.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 98 ++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 65 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 3957c46bdaea..efc30152a89a 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -450,14 +450,16 @@ static int ccwchain_fetch_tic(struct ccwchain *chain,
 	return -EFAULT;
 }
 
-static int ccwchain_fetch_direct(struct ccwchain *chain,
-				 int idx,
-				 struct channel_program *cp)
+static int ccwchain_fetch_ccw(struct ccwchain *chain,
+			      int idx,
+			      struct channel_program *cp)
 {
 	struct ccw1 *ccw;
 	struct pfn_array_table *pat;
 	unsigned long *idaws;
-	int ret;
+	u64 idaw_iova;
+	unsigned int idaw_nr, idaw_len;
+	int i, ret;
 
 	ccw = chain->ch_ccw + idx;
 
@@ -471,60 +473,17 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 		return 0;
 	}
 
-	/*
-	 * Pin data page(s) in memory.
-	 * The number of pages actually is the count of the idaws which will be
-	 * needed when translating a direct ccw to a idal ccw.
-	 */
-	pat = chain->ch_pat + idx;
-	ret = pfn_array_table_init(pat, 1);
-	if (ret)
-		goto out_init;
-
-	ret = pfn_array_alloc_pin(pat->pat_pa, cp->mdev, ccw->cda, ccw->count);
-	if (ret < 0)
-		goto out_unpin;
-
-	/* Translate this direct ccw to a idal ccw. */
-	idaws = kcalloc(ret, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
-	if (!idaws) {
-		ret = -ENOMEM;
-		goto out_unpin;
+	if (ccw_is_idal(ccw)) {
+		/* Read first IDAW to see if it's 4K-aligned or not. */
+		/* All subsequent IDAws will be 4K-aligned. */
+		ret = copy_from_iova(cp->mdev, &idaw_iova, ccw->cda,
+				     sizeof(idaw_iova));
+		if (ret)
+			return ret;
+	} else {
+		idaw_iova = ccw->cda;
 	}
-	ccw->cda = (__u32) virt_to_phys(idaws);
-	ccw->flags |= CCW_FLAG_IDA;
-
-	pfn_array_table_idal_create_words(pat, idaws);
 
-	return 0;
-
-out_unpin:
-	pfn_array_table_unpin_free(pat, cp->mdev);
-out_init:
-	ccw->cda = 0;
-	return ret;
-}
-
-static int ccwchain_fetch_idal(struct ccwchain *chain,
-			       int idx,
-			       struct channel_program *cp)
-{
-	struct ccw1 *ccw;
-	struct pfn_array_table *pat;
-	unsigned long *idaws;
-	u64 idaw_iova;
-	unsigned int idaw_nr, idaw_len;
-	int i, ret;
-
-	ccw = chain->ch_ccw + idx;
-
-	if (!ccw->count)
-		return 0;
-
-	/* Calculate size of idaws. */
-	ret = copy_from_iova(cp->mdev, &idaw_iova, ccw->cda, sizeof(idaw_iova));
-	if (ret)
-		return ret;
 	idaw_nr = idal_nr_words((void *)(idaw_iova), ccw->count);
 	idaw_len = idaw_nr * sizeof(*idaws);
 
@@ -534,18 +493,27 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
 	if (ret)
 		goto out_init;
 
-	/* Translate idal ccw to use new allocated idaws. */
 	idaws = kzalloc(idaw_len, GFP_DMA | GFP_KERNEL);
 	if (!idaws) {
 		ret = -ENOMEM;
 		goto out_unpin;
 	}
 
-	ret = copy_from_iova(cp->mdev, idaws, ccw->cda, idaw_len);
-	if (ret)
-		goto out_free_idaws;
+	if (ccw_is_idal(ccw)) {
+		/* Copy the IDAL to our storage */
+		ret = copy_from_iova(cp->mdev, idaws, ccw->cda, idaw_len);
+		if (ret)
+			goto out_free_idaws;
+	} else {
+		/* Build an IDAL based off the cda and subsequent pages */
+		idal_create_words(idaws, (void *)(u64)ccw->cda, ccw->count);
+	}
 
-	ccw->cda = virt_to_phys(idaws);
+	/*
+	 * We now have an IDAL of guest addresses, either because the CCW we
+	 * are processing provided an IDA, or we built one from the CDA.
+	 * Build the pfn structure so we can pin the associated pages.
+	 */
 
 	for (i = 0; i < idaw_nr; i++) {
 		idaw_iova = *(idaws + i);
@@ -556,6 +524,9 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
 			goto out_free_idaws;
 	}
 
+	ccw->cda = virt_to_phys(idaws);
+	ccw->flags |= CCW_FLAG_IDA;
+
 	pfn_array_table_idal_create_words(pat, idaws);
 
 	return 0;
@@ -587,10 +558,7 @@ static int ccwchain_fetch_one(struct ccwchain *chain,
 	if (ccw_is_tic(ccw))
 		return ccwchain_fetch_tic(chain, idx, cp);
 
-	if (ccw_is_idal(ccw))
-		return ccwchain_fetch_idal(chain, idx, cp);
-
-	return ccwchain_fetch_direct(chain, idx, cp);
+	return ccwchain_fetch_ccw(chain, idx, cp);
 }
 
 int process_channel_program(struct channel_program *cp, u32 iova)
-- 
2.16.4
