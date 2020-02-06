Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727559AbgBFVie (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Feb 2020 16:38:34 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016LaIUh132609
        for <linux-s390@vger.kernel.org>; Thu, 6 Feb 2020 16:38:33 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y0neckcdt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 06 Feb 2020 16:38:32 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Thu, 6 Feb 2020 21:38:30 -0000
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH v2 2/9] vfio-ccw: Register a chp_event callback for vfio-ccw
Date: Thu,  6 Feb 2020 22:38:18 +0100
In-Reply-To: <20200206213825.11444-1-farman@linux.ibm.com>
References: <20200206213825.11444-1-farman@linux.ibm.com>
Message-Id: <20200206213825.11444-3-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

From: Farhan Ali <alifm@linux.ibm.com>

Register the chp_event callback to receive channel path related
events for the subchannels managed by vfio-ccw.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v1->v2:
     - Move s390dbf before cio_update_schib() call [CH]
    
    v0->v1: [EF]
     - Add s390dbf trace

 drivers/s390/cio/vfio_ccw_drv.c | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 91989269faf1..a99705e2fd73 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -19,6 +19,7 @@
 
 #include <asm/isc.h>
 
+#include "chp.h"
 #include "ioasm.h"
 #include "css.h"
 #include "vfio_ccw_private.h"
@@ -257,6 +258,48 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 	return rc;
 }
 
+static int vfio_ccw_chp_event(struct subchannel *sch,
+			      struct chp_link *link, int event)
+{
+	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+	int mask = chp_ssd_get_mask(&sch->ssd_info, link);
+	int retry = 255;
+
+	if (!private || !mask)
+		return 0;
+
+	VFIO_CCW_MSG_EVENT(2, "%pUl (%x.%x.%04x): mask=0x%x event=%d\n",
+			   mdev_uuid(private->mdev), sch->schid.cssid,
+			   sch->schid.ssid, sch->schid.sch_no,
+			   mask, event);
+
+	if (cio_update_schib(sch))
+		return -ENODEV;
+
+	switch (event) {
+	case CHP_VARY_OFF:
+		/* Path logically turned off */
+		sch->opm &= ~mask;
+		sch->lpm &= ~mask;
+		break;
+	case CHP_OFFLINE:
+		/* Path is gone */
+		cio_cancel_halt_clear(sch, &retry);
+		break;
+	case CHP_VARY_ON:
+		/* Path logically turned on */
+		sch->opm |= mask;
+		sch->lpm |= mask;
+		break;
+	case CHP_ONLINE:
+		/* Path became available */
+		sch->lpm |= mask & sch->opm;
+		break;
+	}
+
+	return 0;
+}
+
 static struct css_device_id vfio_ccw_sch_ids[] = {
 	{ .match_flags = 0x1, .type = SUBCHANNEL_TYPE_IO, },
 	{ /* end of list */ },
@@ -274,6 +317,7 @@ static struct css_driver vfio_ccw_sch_driver = {
 	.remove = vfio_ccw_sch_remove,
 	.shutdown = vfio_ccw_sch_shutdown,
 	.sch_event = vfio_ccw_sch_event,
+	.chp_event = vfio_ccw_chp_event,
 };
 
 static int __init vfio_ccw_debug_init(void)
-- 
2.17.1
