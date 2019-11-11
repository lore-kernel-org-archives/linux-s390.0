Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41609 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726970AbfKKNui (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Nov 2019 08:50:38 -0500
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 4/4] vfio-ccw: Rework the io_fctl trace
Date: Mon, 11 Nov 2019 14:50:19 +0100
Message-Id: <20191111135019.2394-5-cohuck@redhat.com>
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

Using __field_struct for the schib is convenient, but it doesn't
appear to let us filter based on any of the schib elements.
Specifying the full schid or any element within it results
in various errors by the parser.  So, expand that out to its
component elements, so we can limit the trace to a single device.

While we are at it, rename this trace to the function name, so we
remember what is being traced instead of an abstract reference to the
function control bit of the SCSW.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20191016142040.14132-5-farman@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c   |  4 ++--
 drivers/s390/cio/vfio_ccw_trace.c |  2 +-
 drivers/s390/cio/vfio_ccw_trace.h | 18 +++++++++++-------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fs=
m.c
index 23648a9aa721..23e61aa638e4 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -318,8 +318,8 @@ static void fsm_io_request(struct vfio_ccw_private *pri=
vate,
 =09}
=20
 err_out:
-=09trace_vfio_ccw_io_fctl(scsw->cmd.fctl, schid,
-=09=09=09       io_region->ret_code, errstr);
+=09trace_vfio_ccw_fsm_io_request(scsw->cmd.fctl, schid,
+=09=09=09=09      io_region->ret_code, errstr);
 }
=20
 /*
diff --git a/drivers/s390/cio/vfio_ccw_trace.c b/drivers/s390/cio/vfio_ccw_=
trace.c
index 37ecbf8be805..8c671d2519f6 100644
--- a/drivers/s390/cio/vfio_ccw_trace.c
+++ b/drivers/s390/cio/vfio_ccw_trace.c
@@ -11,4 +11,4 @@
=20
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_async_request);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_event);
-EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_io_fctl);
+EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_io_request);
diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_=
trace.h
index 5f57cefa84dd..30162a318a8a 100644
--- a/drivers/s390/cio/vfio_ccw_trace.h
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -73,28 +73,32 @@ TRACE_EVENT(vfio_ccw_fsm_event,
 =09=09__entry->event)
 );
=20
-TRACE_EVENT(vfio_ccw_io_fctl,
+TRACE_EVENT(vfio_ccw_fsm_io_request,
 =09TP_PROTO(int fctl, struct subchannel_id schid, int errno, char *errstr)=
,
 =09TP_ARGS(fctl, schid, errno, errstr),
=20
 =09TP_STRUCT__entry(
+=09=09__field(u8, cssid)
+=09=09__field(u8, ssid)
+=09=09__field(u16, sch_no)
 =09=09__field(int, fctl)
-=09=09__field_struct(struct subchannel_id, schid)
 =09=09__field(int, errno)
 =09=09__field(char*, errstr)
 =09),
=20
 =09TP_fast_assign(
+=09=09__entry->cssid =3D schid.cssid;
+=09=09__entry->ssid =3D schid.ssid;
+=09=09__entry->sch_no =3D schid.sch_no;
 =09=09__entry->fctl =3D fctl;
-=09=09__entry->schid =3D schid;
 =09=09__entry->errno =3D errno;
 =09=09__entry->errstr =3D errstr;
 =09),
=20
-=09TP_printk("schid=3D%x.%x.%04x fctl=3D%x errno=3D%d info=3D%s",
-=09=09  __entry->schid.cssid,
-=09=09  __entry->schid.ssid,
-=09=09  __entry->schid.sch_no,
+=09TP_printk("schid=3D%x.%x.%04x fctl=3D0x%x errno=3D%d info=3D%s",
+=09=09  __entry->cssid,
+=09=09  __entry->ssid,
+=09=09  __entry->sch_no,
 =09=09  __entry->fctl,
 =09=09  __entry->errno,
 =09=09  __entry->errstr)
--=20
2.21.0
