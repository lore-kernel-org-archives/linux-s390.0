Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52153 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbgC0Mp0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 08:45:26 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 2/2] s390/cio: generate delayed uevent for vfio-ccw subchannels
Date: Fri, 27 Mar 2020 13:45:03 +0100
Message-Id: <20200327124503.9794-3-cohuck@redhat.com>
In-Reply-To: <20200327124503.9794-1-cohuck@redhat.com>
References: <20200327124503.9794-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

The common I/O layer delays the ADD uevent for subchannels and
delegates generating this uevent to the individual subchannel
drivers. The vfio-ccw I/O subchannel driver, however, did not
do that, and will not generate an ADD uevent for subchannels
that had not been bound to a different driver (or none at all,
which also triggers the uevent).

Generate the ADD uevent at the end of the probe function if
uevents were still suppressed for the device.

Fixes: 63f1934d562d ("vfio: ccw: basic implementation for vfio_ccw driver=
")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
index e401a3d0aa57..339a6bc0339b 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -167,6 +167,11 @@ static int vfio_ccw_sch_probe(struct subchannel *sch=
)
 	if (ret)
 		goto out_disable;
=20
+	if (dev_get_uevent_suppress(&sch->dev)) {
+		dev_set_uevent_suppress(&sch->dev, 0);
+		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+	}
+
 	VFIO_CCW_MSG_EVENT(4, "bound to subchannel %x.%x.%04x\n",
 			   sch->schid.cssid, sch->schid.ssid,
 			   sch->schid.sch_no);
--=20
2.21.1
