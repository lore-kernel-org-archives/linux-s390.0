From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 1/1] KVM: s390: virtio_ccw: remove unused variable
Date: Mon,  3 Nov 2014 12:29:52 +0100
Message-ID: <1415014192-19194-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1415014192-19194-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1415014192-19194-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

=46rom: Sebastian Ott <sebott@linux.vnet.ibm.com>

=46ix this warning:
drivers/s390/kvm/virtio_ccw.c: In function =E2=80=98virtio_ccw_int_hand=
ler=E2=80=99:
drivers/s390/kvm/virtio_ccw.c:891:24: warning: unused variable =E2=80=98=
drv=E2=80=99 [-Wunused-variable]
    struct virtio_driver *drv;

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_cc=
w.c
index 6cbe6ef..bda52f1 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -888,7 +888,6 @@ static void virtio_ccw_int_handler(struct ccw_devic=
e *cdev,
 	struct virtio_ccw_device *vcdev =3D dev_get_drvdata(&cdev->dev);
 	int i;
 	struct virtqueue *vq;
-	struct virtio_driver *drv;
=20
 	if (!vcdev)
 		return;
--=20
1.7.9.5
