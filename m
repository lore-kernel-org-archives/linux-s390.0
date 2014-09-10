From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 7/7] KVM: s390/interrupt: remove double assignment
Date: Wed, 10 Sep 2014 15:53:54 +0200
Message-ID: <1410357234-8937-8-git-send-email-borntraeger@de.ibm.com>
References: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

r is already initialized to 0.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
---
 arch/s390/kvm/interrupt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 4abf819..4cad00a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1352,7 +1352,6 @@ static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		r = enqueue_floating_irq(dev, attr);
 		break;
 	case KVM_DEV_FLIC_CLEAR_IRQS:
-		r = 0;
 		kvm_s390_clear_float_irqs(dev->kvm);
 		break;
 	case KVM_DEV_FLIC_APF_ENABLE:
-- 
1.8.4.2
