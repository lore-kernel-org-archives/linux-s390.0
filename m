From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/9] KVM: s390: remove _bh locking from start_stop_lock
Date: Mon, 21 Jul 2014 21:14:19 +0200
Message-ID: <1405970065-3740-4-git-send-email-borntraeger@de.ibm.com>
References: <1405970065-3740-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1405970065-3740-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

The start_stop_lock is no longer acquired when in atomic context, therefore we
can convert it into an ordinary spin_lock.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a7bda18..b29a031 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1478,7 +1478,7 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 
 	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 1);
 	/* Only one cpu at a time may enter/leave the STOPPED state. */
-	spin_lock_bh(&vcpu->kvm->arch.start_stop_lock);
+	spin_lock(&vcpu->kvm->arch.start_stop_lock);
 	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
 
 	for (i = 0; i < online_vcpus; i++) {
@@ -1504,7 +1504,7 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 	 * Let's play safe and flush the VCPU at startup.
 	 */
 	vcpu->arch.sie_block->ihcpu  = 0xffff;
-	spin_unlock_bh(&vcpu->kvm->arch.start_stop_lock);
+	spin_unlock(&vcpu->kvm->arch.start_stop_lock);
 	return;
 }
 
@@ -1518,7 +1518,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 
 	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 0);
 	/* Only one cpu at a time may enter/leave the STOPPED state. */
-	spin_lock_bh(&vcpu->kvm->arch.start_stop_lock);
+	spin_lock(&vcpu->kvm->arch.start_stop_lock);
 	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
 
 	/* Need to lock access to action_bits to avoid a SIGP race condition */
@@ -1547,7 +1547,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 		__enable_ibs_on_vcpu(started_vcpu);
 	}
 
-	spin_unlock_bh(&vcpu->kvm->arch.start_stop_lock);
+	spin_unlock(&vcpu->kvm->arch.start_stop_lock);
 	return;
 }
 
-- 
1.8.4.2
