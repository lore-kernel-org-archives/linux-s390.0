Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726750AbfJPB6a (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Oct 2019 21:58:30 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G1q4k9029568
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2019 21:58:29 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vnmh0guc9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2019 21:58:28 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Wed, 16 Oct 2019 02:58:27 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 4/4] vfio-ccw: Rework the io_fctl trace
Date: Wed, 16 Oct 2019 03:58:22 +0200
In-Reply-To: <20191016015822.72425-1-farman@linux.ibm.com>
References: <20191016015822.72425-1-farman@linux.ibm.com>
Message-Id: <20191016015822.72425-5-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Steffen Maier <maier@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Using __field_struct for the schib is convenient, but it doesn't
appear to let us filter based on any of the schib elements.
Specifying, the full schid or any element within it results
in various errors by the parser.  So, expand that out to its
component elements, so we can limit the trace to a single device.

While we are at it, rename this trace to the function name, so we
remember what is being traced instead of an abstract reference to the
function control bit of the SCSW.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c   |  4 ++--
 drivers/s390/cio/vfio_ccw_trace.c |  2 +-
 drivers/s390/cio/vfio_ccw_trace.h | 18 +++++++++++-------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 23648a9aa721..23e61aa638e4 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -318,8 +318,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	}
 
 err_out:
-	trace_vfio_ccw_io_fctl(scsw->cmd.fctl, schid,
-			       io_region->ret_code, errstr);
+	trace_vfio_ccw_fsm_io_request(scsw->cmd.fctl, schid,
+				      io_region->ret_code, errstr);
 }
 
 /*
diff --git a/drivers/s390/cio/vfio_ccw_trace.c b/drivers/s390/cio/vfio_ccw_trace.c
index 37ecbf8be805..8c671d2519f6 100644
--- a/drivers/s390/cio/vfio_ccw_trace.c
+++ b/drivers/s390/cio/vfio_ccw_trace.c
@@ -11,4 +11,4 @@
 
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_async_request);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_event);
-EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_io_fctl);
+EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_io_request);
diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
index 23b288eb53dc..f2de5d23c312 100644
--- a/drivers/s390/cio/vfio_ccw_trace.h
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -73,28 +73,32 @@ TRACE_EVENT(vfio_ccw_fsm_event,
 		__entry->event)
 );
 
-TRACE_EVENT(vfio_ccw_io_fctl,
+TRACE_EVENT(vfio_ccw_fsm_io_request,
 	TP_PROTO(int fctl, struct subchannel_id schid, int errno, char *errstr),
 	TP_ARGS(fctl, schid, errno, errstr),
 
 	TP_STRUCT__entry(
+		__field(u8, cssid)
+		__field(u8, ssid)
+		__field(u16, sch_no)
 		__field(int, fctl)
-		__field_struct(struct subchannel_id, schid)
 		__field(int, errno)
 		__field(char*, errstr)
 	),
 
 	TP_fast_assign(
+		__entry->cssid = schid.cssid;
+		__entry->ssid = schid.ssid;
+		__entry->sch_no = schid.sch_no;
 		__entry->fctl = fctl;
-		__entry->schid = schid;
 		__entry->errno = errno;
 		__entry->errstr = errstr;
 	),
 
-	TP_printk("schid=%x.%x.%04x fctl=%x errno=%d info=%s",
-		  __entry->schid.cssid,
-		  __entry->schid.ssid,
-		  __entry->schid.sch_no,
+	TP_printk("schid=%x.%x.%04x fctl=0x%x errno=%d info=%s",
+		  __entry->cssid,
+		  __entry->ssid,
+		  __entry->sch_no,
 		  __entry->fctl,
 		  __entry->errno,
 		  __entry->errstr)
-- 
2.17.1
