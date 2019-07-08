Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731866AbfGHUKr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jul 2019 16:10:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68K7La5118772
        for <linux-s390@vger.kernel.org>; Mon, 8 Jul 2019 16:10:46 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tm99mq5sd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 08 Jul 2019 16:10:46 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <alifm@linux.ibm.com>;
        Mon, 8 Jul 2019 21:10:45 +0100
From: Farhan Ali <alifm@linux.ibm.com>
Subject: [RFC v2 1/5] vfio-ccw: Fix misleading comment when setting orb.cmd.c64
Date: Mon,  8 Jul 2019 16:10:34 -0400
In-Reply-To: <cover.1562616169.git.alifm@linux.ibm.com>
References: <cover.1562616169.git.alifm@linux.ibm.com>
In-Reply-To: <cover.1562616169.git.alifm@linux.ibm.com>
References: <cover.1562616169.git.alifm@linux.ibm.com>
Message-Id: <25a5bf8ae538a392f8483e6fd4b9b165de40bfce.1562616169.git.alifm@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, alifm@linux.ibm.com

The comment is misleading because it tells us that
we should set orb.cmd.c64 before calling ccwchain_calc_length,
otherwise the function ccwchain_calc_length would return an
error. This is not completely accurate.

We want to allow an orb without cmd.c64, and this is fine
as long as the channel program does not use IDALs. But we do
want to reject any channel program that uses IDALs and does
not set the flag, which what we do in ccwchain_calc_length.

After we have done the ccw processing, it should be safe
to set cmd.c64, since we will convert them into IDALs.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index d6a8dff..7622b72 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -645,8 +645,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	if (ret)
 		cp_free(cp);
 
-	/* It is safe to force: if not set but idals used
-	 * ccwchain_calc_length returns an error.
+	/* It is safe to force: if it was not set but idals used
+	 * ccwchain_calc_length would have returned an error.
 	 */
 	cp->orb.cmd.c64 = 1;
 
-- 
2.7.4
