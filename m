Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29168 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727145AbfKKNug (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Nov 2019 08:50:36 -0500
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 3/4] vfio-ccw: Add a trace for asynchronous requests
Date: Mon, 11 Nov 2019 14:50:18 +0100
Message-Id: <20191111135019.2394-4-cohuck@redhat.com>
In-Reply-To: <20191111135019.2394-1-cohuck@redhat.com>
References: <20191111135019.2394-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

From: Eric Farman <farman@linux.ibm.com>

Since the asynchronous requests are typically associated with
error recovery, let's add a simple trace when one of those is
issued to a device.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20191016142040.14132-4-farman@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c   |  4 ++++
 drivers/s390/cio/vfio_ccw_trace.c |  1 +
 drivers/s390/cio/vfio_ccw_trace.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fs=
m.c
index d4119e4c4a8c..23648a9aa721 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -341,6 +341,10 @@ static void fsm_async_request(struct vfio_ccw_private =
*private,
 =09=09/* should not happen? */
 =09=09cmd_region->ret_code =3D -EINVAL;
 =09}
+
+=09trace_vfio_ccw_fsm_async_request(get_schid(private),
+=09=09=09=09=09 cmd_region->command,
+=09=09=09=09=09 cmd_region->ret_code);
 }
=20
 /*
diff --git a/drivers/s390/cio/vfio_ccw_trace.c b/drivers/s390/cio/vfio_ccw_=
trace.c
index b37bc68e7f18..37ecbf8be805 100644
--- a/drivers/s390/cio/vfio_ccw_trace.c
+++ b/drivers/s390/cio/vfio_ccw_trace.c
@@ -9,5 +9,6 @@
 #define CREATE_TRACE_POINTS
 #include "vfio_ccw_trace.h"
=20
+EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_async_request);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_event);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_io_fctl);
diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_=
trace.h
index 5005d57901b4..5f57cefa84dd 100644
--- a/drivers/s390/cio/vfio_ccw_trace.h
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -17,6 +17,36 @@
=20
 #include <linux/tracepoint.h>
=20
+TRACE_EVENT(vfio_ccw_fsm_async_request,
+=09TP_PROTO(struct subchannel_id schid,
+=09=09 int command,
+=09=09 int errno),
+=09TP_ARGS(schid, command, errno),
+
+=09TP_STRUCT__entry(
+=09=09__field(u8, cssid)
+=09=09__field(u8, ssid)
+=09=09__field(u16, sch_no)
+=09=09__field(int, command)
+=09=09__field(int, errno)
+=09),
+
+=09TP_fast_assign(
+=09=09__entry->cssid =3D schid.cssid;
+=09=09__entry->ssid =3D schid.ssid;
+=09=09__entry->sch_no =3D schid.sch_no;
+=09=09__entry->command =3D command;
+=09=09__entry->errno =3D errno;
+=09),
+
+=09TP_printk("schid=3D%x.%x.%04x command=3D0x%x errno=3D%d",
+=09=09  __entry->cssid,
+=09=09  __entry->ssid,
+=09=09  __entry->sch_no,
+=09=09  __entry->command,
+=09=09  __entry->errno)
+);
+
 TRACE_EVENT(vfio_ccw_fsm_event,
 =09TP_PROTO(struct subchannel_id schid, int state, int event),
 =09TP_ARGS(schid, state, event),
--=20
2.21.0
