From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/3] KVM: s390: implementation of kvm_arch_vcpu_runnable()
Date: Wed, 26 Feb 2014 16:14:17 +0100
Message-ID: <1393427659-42501-2-git-send-email-borntraeger@de.ibm.com>
References: <1393427659-42501-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393427659-42501-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

A vcpu is defined to be runnable if an interrupt is pending.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a5da2cc..18959bb 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -483,9 +483,7 @@ out:
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 {
-	/* kvm common code refers to this, but never calls it */
-	BUG();
-	return 0;
+	return kvm_cpu_has_interrupt(vcpu);
 }
 
 void s390_vcpu_block(struct kvm_vcpu *vcpu)
-- 
1.8.4.2
