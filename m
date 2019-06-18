Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730358AbfFRUYC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Jun 2019 16:24:02 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IKH8xj057235
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2019 16:24:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t76hus6mx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2019 16:24:01 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Tue, 18 Jun 2019 21:23:59 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v1 4/5] vfio-ccw: Factor out the ccw0-to-ccw1 transition
Date: Tue, 18 Jun 2019 22:23:51 +0200
In-Reply-To: <20190618202352.39702-1-farman@linux.ibm.com>
References: <20190618202352.39702-1-farman@linux.ibm.com>
Message-Id: <20190618202352.39702-5-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

This is a really useful function, but it's buried in the
copy_ccw_from_iova() routine so that ccwchain_calc_length()
can just work with Format-1 CCWs while doing its counting.
But it means we're translating a full 2K of "CCWs" to Format-1,
when in reality there's probably far fewer in that space.

Let's factor it out, so maybe we can do something with it later.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 48 ++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index a55f8d110920..9a8bf06281e0 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -161,6 +161,27 @@ static inline void pfn_array_idal_create_words(
 	idaws[0] += pa->pa_iova & (PAGE_SIZE - 1);
 }
 
+void convert_ccw0_to_ccw1(struct ccw1 *source, unsigned long len)
+{
+	struct ccw0 ccw0;
+	struct ccw1 *pccw1 = source;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		ccw0 = *(struct ccw0 *)pccw1;
+		if ((pccw1->cmd_code & 0x0f) == CCW_CMD_TIC) {
+			pccw1->cmd_code = CCW_CMD_TIC;
+			pccw1->flags = 0;
+			pccw1->count = 0;
+		} else {
+			pccw1->cmd_code = ccw0.cmd_code;
+			pccw1->flags = ccw0.flags;
+			pccw1->count = ccw0.count;
+		}
+		pccw1->cda = ccw0.cda;
+		pccw1++;
+	}
+}
 
 /*
  * Within the domain (@mdev), copy @n bytes from a guest physical
@@ -211,32 +232,9 @@ static long copy_ccw_from_iova(struct channel_program *cp,
 			       struct ccw1 *to, u64 iova,
 			       unsigned long len)
 {
-	struct ccw0 ccw0;
-	struct ccw1 *pccw1;
 	int ret;
-	int i;
 
 	ret = copy_from_iova(cp->mdev, to, iova, len * sizeof(struct ccw1));
-	if (ret)
-		return ret;
-
-	if (!cp->orb.cmd.fmt) {
-		pccw1 = to;
-		for (i = 0; i < len; i++) {
-			ccw0 = *(struct ccw0 *)pccw1;
-			if ((pccw1->cmd_code & 0x0f) == CCW_CMD_TIC) {
-				pccw1->cmd_code = CCW_CMD_TIC;
-				pccw1->flags = 0;
-				pccw1->count = 0;
-			} else {
-				pccw1->cmd_code = ccw0.cmd_code;
-				pccw1->flags = ccw0.flags;
-				pccw1->count = ccw0.count;
-			}
-			pccw1->cda = ccw0.cda;
-			pccw1++;
-		}
-	}
 
 	return ret;
 }
@@ -441,6 +439,10 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 	if (len)
 		return len;
 
+	/* Convert any Format-0 CCWs to Format-1 */
+	if (!cp->orb.cmd.fmt)
+		convert_ccw0_to_ccw1(cp->guest_cp, len);
+
 	/* Count the CCWs in the current chain */
 	len = ccwchain_calc_length(cda, cp);
 	if (len < 0)
-- 
2.17.1
