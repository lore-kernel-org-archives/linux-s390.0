Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729323AbgDQCaK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Apr 2020 22:30:10 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H23fnT164415
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2020 22:30:10 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30f1r0jtav-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2020 22:30:09 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Fri, 17 Apr 2020 03:29:48 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 8/8] vfio-ccw: Add trace for CRW event
Date: Fri, 17 Apr 2020 04:30:01 +0200
In-Reply-To: <20200417023001.65006-1-farman@linux.ibm.com>
References: <20200417023001.65006-1-farman@linux.ibm.com>
Message-Id: <20200417023001.65006-9-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>

Since CRW events are (should be) rare, let's put a trace
in that routine too.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c   |  1 +
 drivers/s390/cio/vfio_ccw_trace.c |  1 +
 drivers/s390/cio/vfio_ccw_trace.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index a0d8d2560c12..cd462b0849dc 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -336,6 +336,7 @@ static int vfio_ccw_chp_event(struct subchannel *sch,
 	if (!private || !mask)
 		return 0;
 
+	trace_vfio_ccw_chp_event(private->sch->schid, mask, event);
 	VFIO_CCW_MSG_EVENT(2, "%pUl (%x.%x.%04x): mask=0x%x event=%d\n",
 			   mdev_uuid(private->mdev), sch->schid.cssid,
 			   sch->schid.ssid, sch->schid.sch_no,
diff --git a/drivers/s390/cio/vfio_ccw_trace.c b/drivers/s390/cio/vfio_ccw_trace.c
index 8c671d2519f6..4a0205905afc 100644
--- a/drivers/s390/cio/vfio_ccw_trace.c
+++ b/drivers/s390/cio/vfio_ccw_trace.c
@@ -9,6 +9,7 @@
 #define CREATE_TRACE_POINTS
 #include "vfio_ccw_trace.h"
 
+EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_chp_event);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_async_request);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_event);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_io_request);
diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
index f5d31887d413..62fb30598d47 100644
--- a/drivers/s390/cio/vfio_ccw_trace.h
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -17,6 +17,36 @@
 
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(vfio_ccw_chp_event,
+	TP_PROTO(struct subchannel_id schid,
+		 int mask,
+		 int event),
+	TP_ARGS(schid, mask, event),
+
+	TP_STRUCT__entry(
+		__field(u8, cssid)
+		__field(u8, ssid)
+		__field(u16, sch_no)
+		__field(int, mask)
+		__field(int, event)
+	),
+
+	TP_fast_assign(
+		__entry->cssid = schid.cssid;
+		__entry->ssid = schid.ssid;
+		__entry->sch_no = schid.sch_no;
+		__entry->mask = mask;
+		__entry->event = event;
+	),
+
+	TP_printk("schid=%x.%x.%04x mask=0x%x event=%d",
+		  __entry->cssid,
+		  __entry->ssid,
+		  __entry->sch_no,
+		  __entry->mask,
+		  __entry->event)
+);
+
 TRACE_EVENT(vfio_ccw_fsm_async_request,
 	TP_PROTO(struct subchannel_id schid,
 		 int command,
-- 
2.17.1
