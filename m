Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27574 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389581AbgEYJll (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 May 2020 05:41:41 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 04/10] vfio-ccw: Register a chp_event callback for vfio-ccw
Date: Mon, 25 May 2020 11:41:09 +0200
Message-Id: <20200525094115.222299-5-cohuck@redhat.com>
In-Reply-To: <20200525094115.222299-1-cohuck@redhat.com>
References: <20200525094115.222299-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Farhan Ali <alifm@linux.ibm.com>

Register the chp_event callback to receive channel path related
events for the subchannels managed by vfio-ccw.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200505122745.53208-3-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 47 +++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 8715c1c2f1e1..fb1275a7d1f5 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -19,6 +19,7 @@
 
 #include <asm/isc.h>
 
+#include "chp.h"
 #include "ioasm.h"
 #include "css.h"
 #include "vfio_ccw_private.h"
@@ -262,6 +263,51 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
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
+		if (sch->schib.pmcw.lpum & mask)
+			cio_cancel_halt_clear(sch, &retry);
+		break;
+	case CHP_OFFLINE:
+		/* Path is gone */
+		if (sch->schib.pmcw.lpum & mask)
+			cio_cancel_halt_clear(sch, &retry);
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
@@ -279,6 +325,7 @@ static struct css_driver vfio_ccw_sch_driver = {
 	.remove = vfio_ccw_sch_remove,
 	.shutdown = vfio_ccw_sch_shutdown,
 	.sch_event = vfio_ccw_sch_event,
+	.chp_event = vfio_ccw_chp_event,
 };
 
 static int __init vfio_ccw_debug_init(void)
-- 
2.25.4
