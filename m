From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/2] KVM: s390: Gracefully handle busy conditions on ccw_device_start
Date: Mon,  7 Jan 2013 15:51:52 +0100
Message-ID: <1357570312-32074-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1357570312-32074-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1357570312-32074-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

In rare cases a virtio command might try to issue a ccw before a former
ccw was answered with a tsch. This will cause CC=2 (busy). Lets just
retry in that case.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 70419a7..2edd94a 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -132,11 +132,14 @@ static int ccw_io_helper(struct virtio_ccw_device *vcdev,
 	unsigned long flags;
 	int flag = intparm & VIRTIO_CCW_INTPARM_MASK;
 
-	spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
-	ret = ccw_device_start(vcdev->cdev, ccw, intparm, 0, 0);
-	if (!ret)
-		vcdev->curr_io |= flag;
-	spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev), flags);
+	do {
+		spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
+		ret = ccw_device_start(vcdev->cdev, ccw, intparm, 0, 0);
+		if (!ret)
+			vcdev->curr_io |= flag;
+		spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev), flags);
+		cpu_relax();
+	} while (ret == -EBUSY);
 	wait_event(vcdev->wait_q, doing_io(vcdev, flag) == 0);
 	return ret ? ret : vcdev->err;
 }
-- 
1.7.12.4
