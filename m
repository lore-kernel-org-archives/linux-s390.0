From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/15] KVM: s390: don't use kvm lock in interrupt injection code
Date: Tue, 26 Aug 2014 10:28:21 +0200
Message-ID: <1409041707-39938-10-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

The kvm lock protects us against vcpus going away, but they only go
away when the virtual machine is shut down. We don't need this
mutex here, so let's get rid of it.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index e2f6240..ba89bbb 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -991,7 +991,6 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, s390int->type, s390int->parm,
 				   s390int->parm64, 2);
 
-	mutex_lock(&vcpu->kvm->lock);
 	li = &vcpu->arch.local_int;
 	spin_lock(&li->lock);
 	if (inti->type == KVM_S390_PROGRAM_INT)
@@ -1003,7 +1002,6 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 		li->action_bits |= ACTION_STOP_ON_STOP;
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	spin_unlock(&li->lock);
-	mutex_unlock(&vcpu->kvm->lock);
 	kvm_s390_vcpu_wakeup(vcpu);
 	return 0;
 }
-- 
1.8.4.2
