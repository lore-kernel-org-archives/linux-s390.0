From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/10] KVM: s390: factor out and fix setting of guest TOD clock
Date: Tue, 13 Oct 2015 16:06:07 +0200
Message-ID: <1444745168-21479-10-git-send-email-borntraeger@de.ibm.com>
References: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's move that whole logic into one function. We now always use unsigned
values when calculating the epoch (to avoid over/underflow defined).
Also, we always have to get all VCPUs out of SIE before doing the update
to avoid running differing VCPUs with different TODs.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 28 +++++++++++++++++-----------
 arch/s390/kvm/kvm-s390.h |  1 +
 arch/s390/kvm/priv.c     | 15 +++------------
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a090779..87bd602 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -521,22 +521,12 @@ static int kvm_s390_set_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
 
 static int kvm_s390_set_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 {
-	struct kvm_vcpu *cur_vcpu;
-	unsigned int vcpu_idx;
 	u64 gtod;
 
 	if (copy_from_user(&gtod, (void __user *)attr->addr, sizeof(gtod)))
 		return -EFAULT;
 
-	mutex_lock(&kvm->lock);
-	preempt_disable();
-	kvm->arch.epoch = gtod - get_tod_clock();
-	kvm_s390_vcpu_block_all(kvm);
-	kvm_for_each_vcpu(vcpu_idx, cur_vcpu, kvm)
-		cur_vcpu->arch.sie_block->epoch = kvm->arch.epoch;
-	kvm_s390_vcpu_unblock_all(kvm);
-	preempt_enable();
-	mutex_unlock(&kvm->lock);
+	kvm_s390_set_tod_clock(kvm, gtod);
 	VM_EVENT(kvm, 3, "SET: TOD base: 0x%llx\n", gtod);
 	return 0;
 }
@@ -1906,6 +1896,22 @@ retry:
 	return 0;
 }
 
+void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod)
+{
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	mutex_lock(&kvm->lock);
+	preempt_disable();
+	kvm->arch.epoch = tod - get_tod_clock();
+	kvm_s390_vcpu_block_all(kvm);
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		vcpu->arch.sie_block->epoch = kvm->arch.epoch;
+	kvm_s390_vcpu_unblock_all(kvm);
+	preempt_enable();
+	mutex_unlock(&kvm->lock);
+}
+
 /**
  * kvm_arch_fault_in_page - fault-in guest page if necessary
  * @vcpu: The corresponding virtual cpu
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 3a368d2..cc15ea3 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -231,6 +231,7 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
 
 /* implemented in kvm-s390.c */
+void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod);
 long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
 int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
 int kvm_s390_store_adtl_status_unloaded(struct kvm_vcpu *vcpu,
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index b253de5..77191b8 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -33,11 +33,9 @@
 /* Handle SCK (SET CLOCK) interception */
 static int handle_set_clock(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu *cpup;
-	s64 val;
-	int i, rc;
+	int rc;
 	ar_t ar;
-	u64 op2;
+	u64 op2, val;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
@@ -50,14 +48,7 @@ static int handle_set_clock(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
 	VCPU_EVENT(vcpu, 3, "SCK: setting guest TOD to 0x%llx", val);
-
-	mutex_lock(&vcpu->kvm->lock);
-	preempt_disable();
-	val = (val - get_tod_clock()) & ~0x3fUL;
-	kvm_for_each_vcpu(i, cpup, vcpu->kvm)
-		cpup->arch.sie_block->epoch = val;
-	preempt_enable();
-	mutex_unlock(&vcpu->kvm->lock);
+	kvm_s390_set_tod_clock(vcpu->kvm, val);
 
 	kvm_s390_set_psw_cc(vcpu, 0);
 	return 0;
-- 
2.4.3
