Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726964AbfFFU2l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jun 2019 16:28:41 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56KQwfL006738
        for <linux-s390@vger.kernel.org>; Thu, 6 Jun 2019 16:28:39 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sy8xwjk3h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 06 Jun 2019 16:28:39 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Thu, 6 Jun 2019 21:28:37 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 9/9] s390/cio: Combine direct and indirect CCW paths
Date: Thu,  6 Jun 2019 22:28:31 +0200
In-Reply-To: <20190606202831.44135-1-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
Message-Id: <20190606202831.44135-10-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

With both the direct-addressed and indirect-addressed CCW paths
simplified to this point, the amount of shared code between them is
(hopefully) more easily visible.  Move the processing of IDA-specific
bits into the direct-addressed path, and add some useful commentary of
what the individual pieces are doing.  This allows us to remove the
entire ccwchain_fetch_idal() routine and maintain a single function
for any non-TIC CCW.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 115 +++++++++++----------------------
 1 file changed, 39 insertions(+), 76 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 8205d0b527fc..90d86e1354c1 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -534,10 +534,12 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 {
 	struct ccw1 *ccw;
 	struct pfn_array *pa;
+	u64 iova;
 	unsigned long *idaws;
 	int ret;
 	int bytes = 1;
-	int idaw_nr;
+	int idaw_nr, idal_len;
+	int i;
 
 	ccw = chain->ch_ccw + idx;
 
@@ -545,7 +547,17 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 		bytes = ccw->count;
 
 	/* Calculate size of IDAL */
-	idaw_nr = idal_nr_words((void *)(u64)ccw->cda, bytes);
+	if (ccw_is_idal(ccw)) {
+		/* Read first IDAW to see if it's 4K-aligned or not. */
+		/* All subsequent IDAws will be 4K-aligned. */
+		ret = copy_from_iova(cp->mdev, &iova, ccw->cda, sizeof(iova));
+		if (ret)
+			return ret;
+	} else {
+		iova = ccw->cda;
+	}
+	idaw_nr = idal_nr_words((void *)iova, bytes);
+	idal_len = idaw_nr * sizeof(*idaws);
 
 	/* Allocate an IDAL from host storage */
 	idaws = kcalloc(idaw_nr, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
@@ -555,15 +567,36 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	}
 
 	/*
-	 * Pin data page(s) in memory.
-	 * The number of pages actually is the count of the idaws which will be
-	 * needed when translating a direct ccw to a idal ccw.
+	 * Allocate an array of pfn's for pages to pin/translate.
+	 * The number of pages is actually the count of the idaws
+	 * required for the data transfer, since we only only support
+	 * 4K IDAWs today.
 	 */
 	pa = chain->ch_pa + idx;
-	ret = pfn_array_alloc(pa, ccw->cda, bytes);
+	ret = pfn_array_alloc(pa, iova, bytes);
 	if (ret < 0)
 		goto out_free_idaws;
 
+	if (ccw_is_idal(ccw)) {
+		/* Copy guest IDAL into host IDAL */
+		ret = copy_from_iova(cp->mdev, idaws, ccw->cda, idal_len);
+		if (ret)
+			goto out_unpin;
+
+		/*
+		 * Copy guest IDAWs into pfn_array, in case the memory they
+		 * occupy is not contiguous.
+		 */
+		for (i = 0; i < idaw_nr; i++)
+			pa->pa_iova_pfn[i] = idaws[i] >> PAGE_SHIFT;
+	} else {
+		/*
+		 * No action is required here; the iova addresses in pfn_array
+		 * were initialized sequentially in pfn_array_alloc() beginning
+		 * with the contents of ccw->cda.
+		 */
+	}
+
 	if (ccw_does_data_transfer(ccw)) {
 		ret = pfn_array_pin(pa, cp->mdev);
 		if (ret < 0)
@@ -589,73 +622,6 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 	return ret;
 }
 
-static int ccwchain_fetch_idal(struct ccwchain *chain,
-			       int idx,
-			       struct channel_program *cp)
-{
-	struct ccw1 *ccw;
-	struct pfn_array *pa;
-	unsigned long *idaws;
-	u64 idaw_iova;
-	unsigned int idaw_nr, idaw_len;
-	int i, ret;
-	int bytes = 1;
-
-	ccw = chain->ch_ccw + idx;
-
-	if (ccw->count)
-		bytes = ccw->count;
-
-	/* Calculate size of idaws. */
-	ret = copy_from_iova(cp->mdev, &idaw_iova, ccw->cda, sizeof(idaw_iova));
-	if (ret)
-		return ret;
-	idaw_nr = idal_nr_words((void *)(idaw_iova), bytes);
-	idaw_len = idaw_nr * sizeof(*idaws);
-
-	/* Pin data page(s) in memory. */
-	pa = chain->ch_pa + idx;
-	ret = pfn_array_alloc(pa, idaw_iova, bytes);
-	if (ret)
-		goto out_init;
-
-	/* Translate idal ccw to use new allocated idaws. */
-	idaws = kzalloc(idaw_len, GFP_DMA | GFP_KERNEL);
-	if (!idaws) {
-		ret = -ENOMEM;
-		goto out_unpin;
-	}
-
-	ret = copy_from_iova(cp->mdev, idaws, ccw->cda, idaw_len);
-	if (ret)
-		goto out_free_idaws;
-
-	ccw->cda = virt_to_phys(idaws);
-
-	for (i = 0; i < idaw_nr; i++)
-		pa->pa_iova_pfn[i] = idaws[i] >> PAGE_SHIFT;
-
-	if (ccw_does_data_transfer(ccw)) {
-		ret = pfn_array_pin(pa, cp->mdev);
-		if (ret < 0)
-			goto out_free_idaws;
-	} else {
-		pa->pa_nr = 0;
-	}
-
-	pfn_array_idal_create_words(pa, idaws);
-
-	return 0;
-
-out_free_idaws:
-	kfree(idaws);
-out_unpin:
-	pfn_array_unpin_free(pa, cp->mdev);
-out_init:
-	ccw->cda = 0;
-	return ret;
-}
-
 /*
  * Fetch one ccw.
  * To reduce memory copy, we'll pin the cda page in memory,
@@ -671,9 +637,6 @@ static int ccwchain_fetch_one(struct ccwchain *chain,
 	if (ccw_is_tic(ccw))
 		return ccwchain_fetch_tic(chain, idx, cp);
 
-	if (ccw_is_idal(ccw))
-		return ccwchain_fetch_idal(chain, idx, cp);
-
 	return ccwchain_fetch_direct(chain, idx, cp);
 }
 
-- 
2.17.1
