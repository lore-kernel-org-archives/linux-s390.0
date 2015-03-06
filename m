From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 12/20] KVM: s390: perform vcpu model setup in a function
Date: Fri,  6 Mar 2015 14:16:44 +0100
Message-ID: <1425647812-61838-13-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The function kvm_s390_vcpu_setup_model() now performs all cpu model realated
setup tasks for a vcpu. Besides cpuid and ibc initialization, facility list
assignment takes place during the setup step as well. The model setup has been
pulled to the begin of vcpu setup to allow kvm facility tests.

There is no need to protect the cpu model setup with a lock since the attributes
can't be changed anymore as soon the first vcpu is online.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7ac40aa..f3517e7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1130,6 +1130,15 @@ int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static void kvm_s390_vcpu_setup_model(struct kvm_vcpu *vcpu)
+{
+	struct kvm_s390_cpu_model *model = &vcpu->kvm->arch.model;
+
+	vcpu->arch.cpu_id = model->cpu_id;
+	vcpu->arch.sie_block->ibc = model->ibc;
+	vcpu->arch.sie_block->fac = (int) (long) model->fac->list;
+}
+
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
 	int rc = 0;
@@ -1138,6 +1147,8 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 						    CPUSTAT_SM |
 						    CPUSTAT_STOPPED |
 						    CPUSTAT_GED);
+	kvm_s390_vcpu_setup_model(vcpu);
+
 	vcpu->arch.sie_block->ecb   = 6;
 	if (test_kvm_facility(vcpu->kvm, 50) && test_kvm_facility(vcpu->kvm, 73))
 		vcpu->arch.sie_block->ecb |= 0x10;
@@ -1158,11 +1169,6 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	vcpu->arch.ckc_timer.function = kvm_s390_idle_wakeup;
 
-	mutex_lock(&vcpu->kvm->lock);
-	vcpu->arch.cpu_id = vcpu->kvm->arch.model.cpu_id;
-	vcpu->arch.sie_block->ibc = vcpu->kvm->arch.model.ibc;
-	mutex_unlock(&vcpu->kvm->lock);
-
 	kvm_s390_vcpu_crypto_setup(vcpu);
 
 	return rc;
@@ -1205,7 +1211,6 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)kvm->arch.sca;
 		set_bit(63 - id, (unsigned long *) &kvm->arch.sca->mcn);
 	}
-	vcpu->arch.sie_block->fac = (int) (long) kvm->arch.model.fac->list;
 
 	spin_lock_init(&vcpu->arch.local_int.lock);
 	vcpu->arch.local_int.float_int = &kvm->arch.float_int;
-- 
2.3.0
