Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727227AbfGAQYC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Jul 2019 12:24:02 -0400
From: Farhan Ali <alifm@linux.ibm.com>
Subject: [RFC v1 1/4] vfio-ccw: Set orb.cmd.c64 before calling ccwchain_handle_ccw
Date: Mon,  1 Jul 2019 12:23:43 -0400
Message-Id: <050943a6f5a427317ea64100bc2b4ec6394a4411.1561997809.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1561997809.git.alifm@linux.ibm.com>
References: <cover.1561997809.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1561997809.git.alifm@linux.ibm.com>
References: <cover.1561997809.git.alifm@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, alifm@linux.ibm.com

Because ccwchain_handle_ccw calls ccwchain_calc_length and
as per the comment we should set orb.cmd.c64 before calling
ccwchanin_calc_length.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index d6a8dff..5ac4c1e 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -640,16 +640,16 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	memcpy(&cp->orb, orb, sizeof(*orb));
 	cp->mdev = mdev;
 
-	/* Build a ccwchain for the first CCW segment */
-	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
-	if (ret)
-		cp_free(cp);
-
 	/* It is safe to force: if not set but idals used
 	 * ccwchain_calc_length returns an error.
 	 */
 	cp->orb.cmd.c64 = 1;
 
+	/* Build a ccwchain for the first CCW segment */
+	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
+	if (ret)
+		cp_free(cp);
+
 	if (!ret)
 		cp->initialized = true;
 
-- 
2.7.4
