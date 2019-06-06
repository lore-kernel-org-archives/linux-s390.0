Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbfFFU2k (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jun 2019 16:28:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56KQvif019192
        for <linux-s390@vger.kernel.org>; Thu, 6 Jun 2019 16:28:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sy86xmmq7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 06 Jun 2019 16:28:39 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Thu, 6 Jun 2019 21:28:36 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 4/9] s390/cio: Use generalized CCW handler in cp_init()
Date: Thu,  6 Jun 2019 22:28:26 +0200
In-Reply-To: <20190606202831.44135-1-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
Message-Id: <20190606202831.44135-5-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

It is now pretty apparent that ccwchain_handle_ccw()
(nee ccwchain_handle_tic()) does everything that cp_init()
wants to do.

Let's remove that duplicated code from cp_init() and let
ccwchain_handle_ccw() handle it itself.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 52735cdb0270..5b98bea433b7 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -744,9 +744,7 @@ static int ccwchain_fetch_one(struct ccwchain *chain,
  */
 int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 {
-	u64 iova = orb->cmd.cpa;
-	struct ccwchain *chain;
-	int len, ret;
+	int ret;
 
 	/*
 	 * XXX:
@@ -759,28 +757,11 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	memcpy(&cp->orb, orb, sizeof(*orb));
 	cp->mdev = mdev;
 
-	/* Get chain length. */
-	len = ccwchain_calc_length(iova, cp);
-	if (len < 0)
-		return len;
-
-	/* Alloc mem for the head chain. */
-	chain = ccwchain_alloc(cp, len);
-	if (!chain)
-		return -ENOMEM;
-	chain->ch_iova = iova;
-
-	/* Copy the head chain from guest. */
-	ret = copy_ccw_from_iova(cp, chain->ch_ccw, iova, len);
-	if (ret) {
-		ccwchain_free(chain);
-		return ret;
-	}
-
-	/* Now loop for its TICs. */
-	ret = ccwchain_loop_tic(chain, cp);
+	/* Build a ccwchain for the first CCW segment */
+	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
 	if (ret)
 		cp_free(cp);
+
 	/* It is safe to force: if not set but idals used
 	 * ccwchain_calc_length returns an error.
 	 */
-- 
2.17.1
