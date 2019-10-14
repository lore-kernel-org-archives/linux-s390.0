Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732631AbfJNSJG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Oct 2019 14:09:06 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9EHvxCP109212
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 14:09:04 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vmuq7way5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 14:09:04 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Mon, 14 Oct 2019 19:09:02 +0100
From: Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH 4/4] vfio-ccw: Rename the io_fctl trace
Date: Mon, 14 Oct 2019 20:08:55 +0200
In-Reply-To: <20191014180855.19400-1-farman@linux.ibm.com>
References: <20191014180855.19400-1-farman@linux.ibm.com>
Message-Id: <20191014180855.19400-5-farman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Rename this trace to the function name, so we remember what is being
traced instead of an abstract reference to the function control bit
of the SCSW (since that exists in the IRB, but not the ORB).

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c   | 4 ++--
 drivers/s390/cio/vfio_ccw_trace.c | 2 +-
 drivers/s390/cio/vfio_ccw_trace.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

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
index 4be2e36242e6..415aa23658ad 100644
--- a/drivers/s390/cio/vfio_ccw_trace.h
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -69,7 +69,7 @@ TRACE_EVENT(vfio_ccw_fsm_event,
 		__entry->event)
 );
 
-TRACE_EVENT(vfio_ccw_io_fctl,
+TRACE_EVENT(vfio_ccw_fsm_io_request,
 	TP_PROTO(int fctl, struct subchannel_id schid, int errno, char *errstr),
 	TP_ARGS(fctl, schid, errno, errstr),
 
-- 
2.17.1
