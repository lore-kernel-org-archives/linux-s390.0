Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbfFFU2l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jun 2019 16:28:41 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56KQsjG003775
        for <linux-s390@vger.kernel.org>; Thu, 6 Jun 2019 16:28:39 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sy7xed8wm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 06 Jun 2019 16:28:39 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Thu, 6 Jun 2019 21:28:37 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 2/9] s390/cio: Refactor the routine that handles TIC CCWs
Date: Thu,  6 Jun 2019 22:28:24 +0200
In-Reply-To: <20190606202831.44135-1-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
Message-Id: <20190606202831.44135-3-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Extract the "does the target of this TIC already exist?" check from
ccwchain_handle_tic(), so that it's easier to refactor that function
into one that cp_init() is able to use.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 47cd7f94f42f..628daf1a8f9a 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -502,10 +502,6 @@ static int ccwchain_handle_tic(struct ccw1 *tic, struct channel_program *cp)
 	struct ccwchain *chain;
 	int len, ret;
 
-	/* May transfer to an existing chain. */
-	if (tic_target_chain_exists(tic, cp))
-		return 0;
-
 	/* Get chain length. */
 	len = ccwchain_calc_length(tic->cda, cp);
 	if (len < 0)
@@ -540,6 +536,10 @@ static int ccwchain_loop_tic(struct ccwchain *chain, struct channel_program *cp)
 		if (!ccw_is_tic(tic))
 			continue;
 
+		/* May transfer to an existing chain. */
+		if (tic_target_chain_exists(tic, cp))
+			continue;
+
 		ret = ccwchain_handle_tic(tic, cp);
 		if (ret)
 			return ret;
-- 
2.17.1
