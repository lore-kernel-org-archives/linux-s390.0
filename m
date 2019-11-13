Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26784 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725996AbfKMJx2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 04:53:28 -0500
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] s390: vfio-ap: fix some comments
Date: Wed, 13 Nov 2019 10:53:19 +0100
Message-Id: <20191113095319.6154-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

The functions are called vfio_ap_irq_{en,dis}able.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Just some minor stuff I noted while grepping for something.

---
 drivers/s390/crypto/vfio_ap_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_a=
p_ops.c
index 5c0f53c6dde7..f8f3f3a4e5fd 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -182,7 +182,7 @@ struct ap_queue_status vfio_ap_irq_disable(struct vfio_=
ap_queue *q)
 }
=20
 /**
- * vfio_ap_setirq: Enable Interruption for a APQN
+ * vfio_ap_irq_enable: Enable Interruption for a APQN
  *
  * @dev: the device associated with the ap_queue
  * @q:=09 the vfio_ap_queue holding AQIC parameters
@@ -265,7 +265,7 @@ static struct ap_queue_status vfio_ap_irq_enable(struct=
 vfio_ap_queue *q,
  * - AP_RESPONSE_Q_NOT_AVAIL: if the queue is not available
  * - AP_RESPONSE_DECONFIGURED: if the queue is not configured
  * - AP_RESPONSE_NORMAL (0) : in case of successs
- *   Check vfio_ap_setirq() and vfio_ap_clrirq() for other possible RC.
+ *   Check vfio_ap_irq_enable() and vfio_ap_irq_disable() for other possib=
le RC.
  * We take the matrix_dev lock to ensure serialization on queues and
  * mediated device access.
  *
--=20
2.21.0
