Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729961AbfFRUYB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Jun 2019 16:24:01 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IKHCOj064323
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2019 16:24:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t74dnq1hn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2019 16:23:59 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Tue, 18 Jun 2019 21:23:58 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v1 5/5] vfio-ccw: Remove copy_ccw_from_iova()
Date: Tue, 18 Jun 2019 22:23:52 +0200
In-Reply-To: <20190618202352.39702-1-farman@linux.ibm.com>
References: <20190618202352.39702-1-farman@linux.ibm.com>
Message-Id: <20190618202352.39702-6-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Just to keep things tidy.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 9a8bf06281e0..9cddc1288059 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -228,17 +228,6 @@ static long copy_from_iova(struct device *mdev,
 	return l;
 }
 
-static long copy_ccw_from_iova(struct channel_program *cp,
-			       struct ccw1 *to, u64 iova,
-			       unsigned long len)
-{
-	int ret;
-
-	ret = copy_from_iova(cp->mdev, to, iova, len * sizeof(struct ccw1));
-
-	return ret;
-}
-
 /*
  * Helpers to operate ccwchain.
  */
@@ -435,7 +424,8 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 	int len;
 
 	/* Copy 2K (the most we support today) of possible CCWs */
-	len = copy_ccw_from_iova(cp, cp->guest_cp, cda, CCWCHAIN_LEN_MAX);
+	len = copy_from_iova(cp->mdev, cp->guest_cp, cda,
+			     CCWCHAIN_LEN_MAX * sizeof(struct ccw1));
 	if (len)
 		return len;
 
-- 
2.17.1
