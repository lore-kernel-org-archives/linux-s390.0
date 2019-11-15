Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbfKOD1j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 22:27:39 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAF39d5d182751
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 22:27:38 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w9jcm1g2e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 22:27:31 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Fri, 15 Nov 2019 02:56:24 -0000
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v1 03/10] vfio-ccw: Use subchannel lpm in the orb
Date: Fri, 15 Nov 2019 03:56:13 +0100
In-Reply-To: <20191115025620.19593-1-farman@linux.ibm.com>
References: <20191115025620.19593-1-farman@linux.ibm.com>
Message-Id: <20191115025620.19593-4-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>

From: Farhan Ali <alifm@linux.ibm.com>

The subchannel logical path mask (lpm) would have the most
up to date information of channel paths that are logically
available for the subchannel.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v0->v1: [EF]
     - None; however I am greatly confused by this one.  Thoughts?

 drivers/s390/cio/vfio_ccw_cp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 3645d1720c4b..d4a86fb9d162 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -779,9 +779,7 @@ union orb *cp_get_orb(struct channel_program *cp, u32 intparm, u8 lpm)
 	orb->cmd.intparm = intparm;
 	orb->cmd.fmt = 1;
 	orb->cmd.key = PAGE_DEFAULT_KEY >> 4;
-
-	if (orb->cmd.lpm == 0)
-		orb->cmd.lpm = lpm;
+	orb->cmd.lpm = lpm;
 
 	chain = list_first_entry(&cp->ccwchain_list, struct ccwchain, next);
 	cpa = chain->ch_ccw;
-- 
2.17.1
