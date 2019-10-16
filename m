Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727872AbfJPB6b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Oct 2019 21:58:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G1q5VR038466
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2019 21:58:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vnngyxs87-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2019 21:58:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Wed, 16 Oct 2019 02:58:28 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 2/4] vfio-ccw: Trace the FSM jumptable
Date: Wed, 16 Oct 2019 03:58:20 +0200
In-Reply-To: <20191016015822.72425-1-farman@linux.ibm.com>
References: <20191016015822.72425-1-farman@linux.ibm.com>
Message-Id: <20191016015822.72425-3-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Steffen Maier <maier@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

It would be nice if we could track the sequence of events within
vfio-ccw, based on the state of the device/FSM and our calling
sequence within it.  So let's add a simple trace here so we can
watch the states change as things go, and allow it to be folded
into the rest of the other cio traces.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_private.h |  1 +
 drivers/s390/cio/vfio_ccw_trace.c   |  1 +
 drivers/s390/cio/vfio_ccw_trace.h   | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index bbe9babf767b..9b9bb4982972 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -135,6 +135,7 @@ extern fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
 static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
 				     int event)
 {
+	trace_vfio_ccw_fsm_event(private->sch->schid, private->state, event);
 	vfio_ccw_jumptable[private->state][event](private, event);
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_trace.c b/drivers/s390/cio/vfio_ccw_trace.c
index d5cc943c6864..b37bc68e7f18 100644
--- a/drivers/s390/cio/vfio_ccw_trace.c
+++ b/drivers/s390/cio/vfio_ccw_trace.c
@@ -9,4 +9,5 @@
 #define CREATE_TRACE_POINTS
 #include "vfio_ccw_trace.h"
 
+EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_event);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_io_fctl);
diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
index 2a2937a40124..5005d57901b4 100644
--- a/drivers/s390/cio/vfio_ccw_trace.h
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -17,6 +17,32 @@
 
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(vfio_ccw_fsm_event,
+	TP_PROTO(struct subchannel_id schid, int state, int event),
+	TP_ARGS(schid, state, event),
+
+	TP_STRUCT__entry(
+		__field(u8, cssid)
+		__field(u8, ssid)
+		__field(u16, schno)
+		__field(int, state)
+		__field(int, event)
+	),
+
+	TP_fast_assign(
+		__entry->cssid = schid.cssid;
+		__entry->ssid = schid.ssid;
+		__entry->schno = schid.sch_no;
+		__entry->state = state;
+		__entry->event = event;
+	),
+
+	TP_printk("schid=%x.%x.%04x state=%d event=%d",
+		__entry->cssid, __entry->ssid, __entry->schno,
+		__entry->state,
+		__entry->event)
+);
+
 TRACE_EVENT(vfio_ccw_io_fctl,
 	TP_PROTO(int fctl, struct subchannel_id schid, int errno, char *errstr),
 	TP_ARGS(fctl, schid, errno, errstr),
-- 
2.17.1
