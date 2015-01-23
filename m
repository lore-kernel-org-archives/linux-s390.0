From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 23/24] KVM: s390: fix bug in interrupt parameter check
Date: Fri, 23 Jan 2015 13:37:21 +0100
Message-ID: <1422016642-52513-5-git-send-email-borntraeger@de.ibm.com>
References: <1422016642-52513-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1422016642-52513-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

When we convert interrupt data from struct kvm_s390_interrupt to
struct kvm_s390_irq we need to check the data in the input parameter
not the output parameter.

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6d7513e..60d9edd0 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1354,12 +1354,12 @@ int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
 		irq->u.stop.flags = s390int->parm;
 		break;
 	case KVM_S390_INT_EXTERNAL_CALL:
-		if (irq->u.extcall.code & 0xffff0000)
+		if (s390int->parm & 0xffff0000)
 			return -EINVAL;
 		irq->u.extcall.code = s390int->parm;
 		break;
 	case KVM_S390_INT_EMERGENCY:
-		if (irq->u.emerg.code & 0xffff0000)
+		if (s390int->parm & 0xffff0000)
 			return -EINVAL;
 		irq->u.emerg.code = s390int->parm;
 		break;
-- 
1.9.3
