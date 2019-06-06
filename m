Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726950AbfFFU2k (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jun 2019 16:28:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56KQx2s054141
        for <linux-s390@vger.kernel.org>; Thu, 6 Jun 2019 16:28:39 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sy79xy76p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 06 Jun 2019 16:28:39 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Thu, 6 Jun 2019 21:28:37 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 1/9] s390/cio: Squash cp_free() and cp_unpin_free()
Date: Thu,  6 Jun 2019 22:28:23 +0200
In-Reply-To: <20190606202831.44135-1-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
Message-Id: <20190606202831.44135-2-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

The routine cp_free() does nothing but call cp_unpin_free(), and while
most places call cp_free() there is one caller of cp_unpin_free() used
when the cp is guaranteed to have not been marked initialized.

This seems like a dubious way to make a distinction, so let's combine
these routines and make cp_free() do all the work.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
The RFC version of this patch received r-b's from Farhan [1] and
Pierre [2].  This patch is almost identical to that one, but I
opted to not include those tags because of the cp->initialized
check that now has an impact here.  I still think this patch makes
sense, but want them (well, Farhan) to have a chance to look it
over since it's been six or seven months.

[1] https://patchwork.kernel.org/comment/22310411/
[2] https://patchwork.kernel.org/comment/22317927/
---
 drivers/s390/cio/vfio_ccw_cp.c | 36 +++++++++++++++-------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index f73cfcfdd032..47cd7f94f42f 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -412,23 +412,6 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
 	kfree((void *)(u64)ccw->cda);
 }
 
-/* Unpin the pages then free the memory resources. */
-static void cp_unpin_free(struct channel_program *cp)
-{
-	struct ccwchain *chain, *temp;
-	int i;
-
-	cp->initialized = false;
-	list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
-		for (i = 0; i < chain->ch_len; i++) {
-			pfn_array_table_unpin_free(chain->ch_pat + i,
-						   cp->mdev);
-			ccwchain_cda_free(chain, i);
-		}
-		ccwchain_free(chain);
-	}
-}
-
 /**
  * ccwchain_calc_length - calculate the length of the ccw chain.
  * @iova: guest physical address of the target ccw chain
@@ -796,7 +779,7 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	/* Now loop for its TICs. */
 	ret = ccwchain_loop_tic(chain, cp);
 	if (ret)
-		cp_unpin_free(cp);
+		cp_free(cp);
 	/* It is safe to force: if not set but idals used
 	 * ccwchain_calc_length returns an error.
 	 */
@@ -819,8 +802,21 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
  */
 void cp_free(struct channel_program *cp)
 {
-	if (cp->initialized)
-		cp_unpin_free(cp);
+	struct ccwchain *chain, *temp;
+	int i;
+
+	if (!cp->initialized)
+		return;
+
+	cp->initialized = false;
+	list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
+		for (i = 0; i < chain->ch_len; i++) {
+			pfn_array_table_unpin_free(chain->ch_pat + i,
+						   cp->mdev);
+			ccwchain_cda_free(chain, i);
+		}
+		ccwchain_free(chain);
+	}
 }
 
 /**
-- 
2.17.1
