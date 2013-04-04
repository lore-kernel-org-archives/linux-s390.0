From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH] KVM: s390: virtio_ccw: reset errors for new I/O.
Date: Thu,  4 Apr 2013 10:25:06 +0200
Message-ID: <1365063906-61392-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1365063906-61392-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1365063906-61392-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

ccw_io_helper neglected to reset vcdev->err after a new channel
program had been successfully started, resulting in stale errors
delivered after one I/O failed. Reset the error after a new
channel program has been successfully started with no old I/O
pending.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 42d507c..5948f2a 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -133,8 +133,11 @@ static int ccw_io_helper(struct virtio_ccw_device *vcdev,
 	do {
 		spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
 		ret = ccw_device_start(vcdev->cdev, ccw, intparm, 0, 0);
-		if (!ret)
+		if (!ret) {
+			if (!vcdev->curr_io)
+				vcdev->err = 0;
 			vcdev->curr_io |= flag;
+		}
 		spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev), flags);
 		cpu_relax();
 	} while (ret == -EBUSY);
-- 
1.7.12.4
