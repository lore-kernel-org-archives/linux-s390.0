From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/6] KVM: s390: drop use of spin lock in __floating_irq_kick
Date: Tue, 16 Jan 2018 16:03:12 +0100
Message-ID: <20180116150314.201352-5-borntraeger@de.ibm.com>
References: <20180116150314.201352-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116150314.201352-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

It is not required to take to a lock to protect access to the cpuflags
of the local interrupt structure of a vcpu as the performed operation
is an atomic_or.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 024ad8bcc516..818aa4248b0f 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1569,7 +1569,6 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
 
 	/* make the VCPU drop out of the SIE, or wake it up if sleeping */
 	li = &dst_vcpu->arch.local_int;
-	spin_lock(&li->lock);
 	switch (type) {
 	case KVM_S390_MCHK:
 		atomic_or(CPUSTAT_STOP_INT, li->cpuflags);
@@ -1581,7 +1580,6 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
 		atomic_or(CPUSTAT_EXT_INT, li->cpuflags);
 		break;
 	}
-	spin_unlock(&li->lock);
 	kvm_s390_vcpu_wakeup(dst_vcpu);
 }
 
-- 
2.13.4
