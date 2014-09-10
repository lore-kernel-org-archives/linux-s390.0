From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/7] KVM: s390: unintended fallthrough for external call
Date: Wed, 10 Sep 2014 15:53:51 +0200
Message-ID: <1410357234-8937-5-git-send-email-borntraeger@de.ibm.com>
References: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We must not fallthrough if the conditions for external call are not met.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
---
 arch/s390/kvm/interrupt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index d56da1d..4abf819 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -86,6 +86,7 @@ static int __must_check __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
 			return 0;
 		if (vcpu->arch.sie_block->gcr[0] & 0x2000ul)
 			return 1;
+		return 0;
 	case KVM_S390_INT_EMERGENCY:
 		if (psw_extint_disabled(vcpu))
 			return 0;
-- 
1.8.4.2
