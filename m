From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 22 Feb 2018 11:15:06 +0000
Subject: [GIT PULL 2/4] KVM: s390: consider epoch index on hotplugged CPUs
Message-Id: <20180222111508.230489-3-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

We must copy both, the epoch and the epoch_idx.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180207114647.6220-4-david@redhat.com>
Fixes: 8fa1696ea781 ("KVM: s390: Multiple Epoch Facility support")
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: 8fa1696ea781 ("KVM: s390: Multiple Epoch Facility support")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ba4c7092335a..5b7fe80cda56 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2389,6 +2389,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	mutex_lock(&vcpu->kvm->lock);
 	preempt_disable();
 	vcpu->arch.sie_block->epoch = vcpu->kvm->arch.epoch;
+	vcpu->arch.sie_block->epdx = vcpu->kvm->arch.epdx;
 	preempt_enable();
 	mutex_unlock(&vcpu->kvm->lock);
 	if (!kvm_is_ucontrol(vcpu->kvm)) {
-- 
2.14.3
