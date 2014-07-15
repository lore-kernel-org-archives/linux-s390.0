From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/5] KVM: s390: move finalization of SIGP STOP orders to kvm_s390_vcpu_stop
Date: Tue, 15 Jul 2014 15:27:52 +0200
Message-ID: <1405430875-40722-3-git-send-email-borntraeger@de.ibm.com>
References: <1405430875-40722-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1405430875-40722-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's move the finalization of SIGP STOP and SIGP STOP AND STORE STATUS orders to
the point where the VCPU is actually stopped.

This change is needed to prepare for a user space driven VCPU state change. The
action_bits may only be cleared when setting the cpu state to STOPPED while
holding the local irq lock.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 31 ++++++++++++-------------------
 arch/s390/kvm/kvm-s390.c  |  8 ++++++++
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index a0b586c..ac6b325 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -56,32 +56,25 @@ static int handle_noop(struct kvm_vcpu *vcpu)
 static int handle_stop(struct kvm_vcpu *vcpu)
 {
 	int rc = 0;
+	unsigned int action_bits;
 
 	vcpu->stat.exit_stop_request++;
-	spin_lock_bh(&vcpu->arch.local_int.lock);
-
 	trace_kvm_s390_stop_request(vcpu->arch.local_int.action_bits);
 
-	if (vcpu->arch.local_int.action_bits & ACTION_STOP_ON_STOP) {
-		kvm_s390_vcpu_stop(vcpu);
-		vcpu->arch.local_int.action_bits &= ~ACTION_STOP_ON_STOP;
-		VCPU_EVENT(vcpu, 3, "%s", "cpu stopped");
-		rc = -EOPNOTSUPP;
-	}
+	action_bits = vcpu->arch.local_int.action_bits;
 
-	if (vcpu->arch.local_int.action_bits & ACTION_STORE_ON_STOP) {
-		vcpu->arch.local_int.action_bits &= ~ACTION_STORE_ON_STOP;
-		/* store status must be called unlocked. Since local_int.lock
-		 * only protects local_int.* and not guest memory we can give
-		 * up the lock here */
-		spin_unlock_bh(&vcpu->arch.local_int.lock);
+	if (!(action_bits & ACTION_STOP_ON_STOP))
+		return 0;
+
+	if (action_bits & ACTION_STORE_ON_STOP) {
 		rc = kvm_s390_vcpu_store_status(vcpu,
 						KVM_S390_STORE_STATUS_NOADDR);
-		if (rc >= 0)
-			rc = -EOPNOTSUPP;
-	} else
-		spin_unlock_bh(&vcpu->arch.local_int.lock);
-	return rc;
+		if (rc)
+			return rc;
+	}
+
+	kvm_s390_vcpu_stop(vcpu);
+	return -EOPNOTSUPP;
 }
 
 static int handle_validity(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2f3e14f..c507789 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1494,7 +1494,15 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 	spin_lock_bh(&vcpu->kvm->arch.start_stop_lock);
 	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
 
+	/* Need to lock access to action_bits to avoid a SIGP race condition */
+	spin_lock_bh(&vcpu->arch.local_int.lock);
 	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+
+	/* SIGP STOP and SIGP STOP AND STORE STATUS has been fully processed */
+	vcpu->arch.local_int.action_bits &=
+				 ~(ACTION_STOP_ON_STOP | ACTION_STORE_ON_STOP);
+	spin_unlock_bh(&vcpu->arch.local_int.lock);
+
 	__disable_ibs_on_vcpu(vcpu);
 
 	for (i = 0; i < online_vcpus; i++) {
-- 
1.8.4.2
