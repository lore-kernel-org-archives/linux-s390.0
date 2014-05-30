From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/6] KVM: s390: clean up interrupt injection in sigp code
Date: Fri, 30 May 2014 11:00:09 +0200
Message-ID: <1401440412-20472-4-git-send-email-borntraeger@de.ibm.com>
References: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

We have all the logic to inject interrupts available in
kvm_s390_inject_vcpu(), so let's use it instead of
injecting irqs manually to the list in sigp code.

SIGP stop is special because we have to check the
action_flags before injecting the interrupt. As
the action_flags are not available in kvm_s390_inject_vcpu()
we leave the code for the stop order code untouched for now.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/sigp.c | 56 +++++++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index d0341d2..43079a4 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -54,33 +54,23 @@ static int __sigp_sense(struct kvm_vcpu *vcpu, u16 cpu_addr,
 
 static int __sigp_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr)
 {
-	struct kvm_s390_local_interrupt *li;
-	struct kvm_s390_interrupt_info *inti;
+	struct kvm_s390_interrupt s390int = {
+		.type = KVM_S390_INT_EMERGENCY,
+		.parm = vcpu->vcpu_id,
+	};
 	struct kvm_vcpu *dst_vcpu = NULL;
+	int rc = 0;
 
 	if (cpu_addr < KVM_MAX_VCPUS)
 		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
 	if (!dst_vcpu)
 		return SIGP_CC_NOT_OPERATIONAL;
 
-	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
-	if (!inti)
-		return -ENOMEM;
-
-	inti->type = KVM_S390_INT_EMERGENCY;
-	inti->emerg.code = vcpu->vcpu_id;
+	rc = kvm_s390_inject_vcpu(dst_vcpu, &s390int);
+	if (!rc)
+		VCPU_EVENT(vcpu, 4, "sent sigp emerg to cpu %x", cpu_addr);
 
-	li = &dst_vcpu->arch.local_int;
-	spin_lock_bh(&li->lock);
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
-	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
-	if (waitqueue_active(li->wq))
-		wake_up_interruptible(li->wq);
-	spin_unlock_bh(&li->lock);
-	VCPU_EVENT(vcpu, 4, "sent sigp emerg to cpu %x", cpu_addr);
-
-	return SIGP_CC_ORDER_CODE_ACCEPTED;
+	return rc ? rc : SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
 static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr,
@@ -116,33 +106,23 @@ static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr,
 
 static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
 {
-	struct kvm_s390_local_interrupt *li;
-	struct kvm_s390_interrupt_info *inti;
+	struct kvm_s390_interrupt s390int = {
+		.type = KVM_S390_INT_EXTERNAL_CALL,
+		.parm = vcpu->vcpu_id,
+	};
 	struct kvm_vcpu *dst_vcpu = NULL;
+	int rc;
 
 	if (cpu_addr < KVM_MAX_VCPUS)
 		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
 	if (!dst_vcpu)
 		return SIGP_CC_NOT_OPERATIONAL;
 
-	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
-	if (!inti)
-		return -ENOMEM;
-
-	inti->type = KVM_S390_INT_EXTERNAL_CALL;
-	inti->extcall.code = vcpu->vcpu_id;
-
-	li = &dst_vcpu->arch.local_int;
-	spin_lock_bh(&li->lock);
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
-	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
-	if (waitqueue_active(li->wq))
-		wake_up_interruptible(li->wq);
-	spin_unlock_bh(&li->lock);
-	VCPU_EVENT(vcpu, 4, "sent sigp ext call to cpu %x", cpu_addr);
+	rc = kvm_s390_inject_vcpu(dst_vcpu, &s390int);
+	if (!rc)
+		VCPU_EVENT(vcpu, 4, "sent sigp ext call to cpu %x", cpu_addr);
 
-	return SIGP_CC_ORDER_CODE_ACCEPTED;
+	return rc ? rc : SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
 static int __inject_sigp_stop(struct kvm_s390_local_interrupt *li, int action)
-- 
1.8.4.2
