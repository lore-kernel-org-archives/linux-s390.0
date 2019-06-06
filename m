Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbfFFU2k (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jun 2019 16:28:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56KRXwd083380
        for <linux-s390@vger.kernel.org>; Thu, 6 Jun 2019 16:28:39 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sy71hg957-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 06 Jun 2019 16:28:39 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Thu, 6 Jun 2019 21:28:37 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 3/9] s390/cio: Generalize the TIC handler
Date: Thu,  6 Jun 2019 22:28:25 +0200
In-Reply-To: <20190606202831.44135-1-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
Message-Id: <20190606202831.44135-4-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Refactor ccwchain_handle_tic() into a routine that handles a channel
program address (which itself is a CCW pointer), rather than a CCW pointer
that is only a TIC CCW.  This will make it easier to reuse this code for
other CCW commands.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 628daf1a8f9a..52735cdb0270 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -497,13 +497,13 @@ static int tic_target_chain_exists(struct ccw1 *tic, struct channel_program *cp)
 static int ccwchain_loop_tic(struct ccwchain *chain,
 			     struct channel_program *cp);
 
-static int ccwchain_handle_tic(struct ccw1 *tic, struct channel_program *cp)
+static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 {
 	struct ccwchain *chain;
 	int len, ret;
 
 	/* Get chain length. */
-	len = ccwchain_calc_length(tic->cda, cp);
+	len = ccwchain_calc_length(cda, cp);
 	if (len < 0)
 		return len;
 
@@ -511,10 +511,10 @@ static int ccwchain_handle_tic(struct ccw1 *tic, struct channel_program *cp)
 	chain = ccwchain_alloc(cp, len);
 	if (!chain)
 		return -ENOMEM;
-	chain->ch_iova = tic->cda;
+	chain->ch_iova = cda;
 
 	/* Copy the new chain from user. */
-	ret = copy_ccw_from_iova(cp, chain->ch_ccw, tic->cda, len);
+	ret = copy_ccw_from_iova(cp, chain->ch_ccw, cda, len);
 	if (ret) {
 		ccwchain_free(chain);
 		return ret;
@@ -540,7 +540,8 @@ static int ccwchain_loop_tic(struct ccwchain *chain, struct channel_program *cp)
 		if (tic_target_chain_exists(tic, cp))
 			continue;
 
-		ret = ccwchain_handle_tic(tic, cp);
+		/* Build a ccwchain for the next segment */
+		ret = ccwchain_handle_ccw(tic->cda, cp);
 		if (ret)
 			return ret;
 	}
-- 
2.17.1
