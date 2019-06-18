Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730429AbfFRUYB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Jun 2019 16:24:01 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IKHAlF099966
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2019 16:24:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t758mvjdk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2019 16:24:00 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Tue, 18 Jun 2019 21:23:59 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v1 3/5] vfio-ccw: Copy CCW data outside length calculation
Date: Tue, 18 Jun 2019 22:23:50 +0200
In-Reply-To: <20190618202352.39702-1-farman@linux.ibm.com>
References: <20190618202352.39702-1-farman@linux.ibm.com>
Message-Id: <20190618202352.39702-4-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

It doesn't make much sense to "hide" the copy to the channel_program
struct inside a routine that calculates the length of the chain.

Let's move it to the calling routine, which will later copy from
channel_program to the memory it allocated itself.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 37d513e86530..a55f8d110920 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -381,18 +381,8 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
 static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 {
 	struct ccw1 *ccw = cp->guest_cp;
-	int cnt;
+	int cnt = 0;
 
-	/*
-	 * Copy current chain from guest to host kernel.
-	 * Currently the chain length is limited to CCWCHAIN_LEN_MAX (256).
-	 * So copying 2K is enough (safe).
-	 */
-	cnt = copy_ccw_from_iova(cp, ccw, iova, CCWCHAIN_LEN_MAX);
-	if (cnt)
-		return cnt;
-
-	cnt = 0;
 	do {
 		cnt++;
 
@@ -446,7 +436,12 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 	struct ccwchain *chain;
 	int len;
 
-	/* Copy the chain from cda to cp, and count the CCWs in it */
+	/* Copy 2K (the most we support today) of possible CCWs */
+	len = copy_ccw_from_iova(cp, cp->guest_cp, cda, CCWCHAIN_LEN_MAX);
+	if (len)
+		return len;
+
+	/* Count the CCWs in the current chain */
 	len = ccwchain_calc_length(cda, cp);
 	if (len < 0)
 		return len;
-- 
2.17.1
