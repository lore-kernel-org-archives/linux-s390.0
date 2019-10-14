Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732761AbfJNSJG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Oct 2019 14:09:06 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9EHvhGd083874
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 14:09:05 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vmwes19aw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 14:09:04 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Mon, 14 Oct 2019 19:09:02 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH 3/4] vfio-ccw: Add a trace for asynchronous requests
Date: Mon, 14 Oct 2019 20:08:54 +0200
In-Reply-To: <20191014180855.19400-1-farman@linux.ibm.com>
References: <20191014180855.19400-1-farman@linux.ibm.com>
Message-Id: <20191014180855.19400-4-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Since the asynchronous requests are typically associated with
error recovery, let's add a simple trace when one of those is
issued to a device.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c   |  4 ++++
 drivers/s390/cio/vfio_ccw_trace.c |  1 +
 drivers/s390/cio/vfio_ccw_trace.h | 26 ++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index d4119e4c4a8c..23648a9aa721 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -341,6 +341,10 @@ static void fsm_async_request(struct vfio_ccw_private *private,
 		/* should not happen? */
 		cmd_region->ret_code = -EINVAL;
 	}
+
+	trace_vfio_ccw_fsm_async_request(get_schid(private),
+					 cmd_region->command,
+					 cmd_region->ret_code);
 }
 
 /*
diff --git a/drivers/s390/cio/vfio_ccw_trace.c b/drivers/s390/cio/vfio_ccw_trace.c
index b37bc68e7f18..37ecbf8be805 100644
--- a/drivers/s390/cio/vfio_ccw_trace.c
+++ b/drivers/s390/cio/vfio_ccw_trace.c
@@ -9,5 +9,6 @@
 #define CREATE_TRACE_POINTS
 #include "vfio_ccw_trace.h"
 
+EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_async_request);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_event);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_io_fctl);
diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
index 24a8152acfdf..4be2e36242e6 100644
--- a/drivers/s390/cio/vfio_ccw_trace.h
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -17,6 +17,32 @@
 
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(vfio_ccw_fsm_async_request,
+	TP_PROTO(struct subchannel_id schid,
+		 int command,
+		 int errno),
+	TP_ARGS(schid, command, errno),
+
+	TP_STRUCT__entry(
+		__field_struct(struct subchannel_id, schid)
+		__field(int, command)
+		__field(int, errno)
+	),
+
+	TP_fast_assign(
+		__entry->schid = schid;
+		__entry->command = command;
+		__entry->errno = errno;
+	),
+
+	TP_printk("schid=%x.%x.%04x command=%d errno=%d",
+		  __entry->schid.cssid,
+		  __entry->schid.ssid,
+		  __entry->schid.sch_no,
+		  __entry->command,
+		  __entry->errno)
+);
+
 TRACE_EVENT(vfio_ccw_fsm_event,
 	TP_PROTO(struct subchannel_id schid, int state, int event),
 	TP_ARGS(schid, state, event),
-- 
2.17.1
