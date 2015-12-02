From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/23] KVM: s390: Generalize access to SIGP controls
Date: Wed,  2 Dec 2015 12:06:08 +0100
Message-ID: <1449054384-76374-8-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: "Eugene (jno) Dvurechenski" <jno@linux.vnet.ibm.com>

This patch generalizes access to the SIGP controls, which is a part of SCA.
This is to prepare for upcoming introduction of Extended SCA support.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 72 +++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6a75352..2a4718a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -34,6 +34,45 @@
 #define PFAULT_DONE 0x0680
 #define VIRTIO_PARAM 0x0d00
 
+/* handle external calls via sigp interpretation facility */
+static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
+{
+	struct sca_block *sca = vcpu->kvm->arch.sca;
+	uint8_t sigp_ctrl = sca->cpu[vcpu->vcpu_id].sigp_ctrl;
+
+	if (src_id)
+		*src_id = sigp_ctrl & SIGP_CTRL_SCN_MASK;
+
+	return sigp_ctrl & SIGP_CTRL_C &&
+		atomic_read(&vcpu->arch.sie_block->cpuflags) &
+			CPUSTAT_ECALL_PEND;
+}
+
+static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
+{
+	struct sca_block *sca = vcpu->kvm->arch.sca;
+	uint8_t *sigp_ctrl = &(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
+	uint8_t new_val = SIGP_CTRL_C | (src_id & SIGP_CTRL_SCN_MASK);
+	uint8_t old_val = *sigp_ctrl & ~SIGP_CTRL_C;
+
+	if (cmpxchg(sigp_ctrl, old_val, new_val) != old_val) {
+		/* another external call is pending */
+		return -EBUSY;
+	}
+	atomic_or(CPUSTAT_ECALL_PEND, &vcpu->arch.sie_block->cpuflags);
+	return 0;
+}
+
+static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
+{
+	struct sca_block *sca = vcpu->kvm->arch.sca;
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	uint8_t *sigp_ctrl = &(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
+
+	atomic_andnot(CPUSTAT_ECALL_PEND, li->cpuflags);
+	*sigp_ctrl = 0;
+}
+
 int psw_extint_disabled(struct kvm_vcpu *vcpu)
 {
 	return !(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_EXT);
@@ -792,13 +831,11 @@ static const deliver_irq_t deliver_irq_funcs[] = {
 int kvm_s390_ext_call_pending(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	uint8_t sigp_ctrl = vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sigp_ctrl;
 
 	if (!sclp.has_sigpif)
 		return test_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs);
 
-	return (sigp_ctrl & SIGP_CTRL_C) &&
-	       (atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_ECALL_PEND);
+	return sca_ext_call_pending(vcpu, NULL);
 }
 
 int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop)
@@ -909,9 +946,7 @@ void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu)
 	memset(&li->irq, 0, sizeof(li->irq));
 	spin_unlock(&li->lock);
 
-	/* clear pending external calls set by sigp interpretation facility */
-	atomic_andnot(CPUSTAT_ECALL_PEND, li->cpuflags);
-	vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sigp_ctrl = 0;
+	sca_clear_ext_call(vcpu);
 }
 
 int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
@@ -1003,21 +1038,6 @@ static int __inject_pfault_init(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	return 0;
 }
 
-static int __inject_extcall_sigpif(struct kvm_vcpu *vcpu, uint16_t src_id)
-{
-	unsigned char new_val, old_val;
-	uint8_t *sigp_ctrl = &vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sigp_ctrl;
-
-	new_val = SIGP_CTRL_C | (src_id & SIGP_CTRL_SCN_MASK);
-	old_val = *sigp_ctrl & ~SIGP_CTRL_C;
-	if (cmpxchg(sigp_ctrl, old_val, new_val) != old_val) {
-		/* another external call is pending */
-		return -EBUSY;
-	}
-	atomic_or(CPUSTAT_ECALL_PEND, &vcpu->arch.sie_block->cpuflags);
-	return 0;
-}
-
 static int __inject_extcall(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
@@ -1034,7 +1054,7 @@ static int __inject_extcall(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 		return -EINVAL;
 
 	if (sclp.has_sigpif)
-		return __inject_extcall_sigpif(vcpu, src_id);
+		return sca_inject_ext_call(vcpu, src_id);
 
 	if (test_and_set_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs))
 		return -EBUSY;
@@ -2203,7 +2223,7 @@ static void store_local_irq(struct kvm_s390_local_interrupt *li,
 
 int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 {
-	uint8_t sigp_ctrl = vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sigp_ctrl;
+	int scn;
 	unsigned long sigp_emerg_pending[BITS_TO_LONGS(KVM_MAX_VCPUS)];
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	unsigned long pending_irqs;
@@ -2243,14 +2263,12 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 		}
 	}
 
-	if ((sigp_ctrl & SIGP_CTRL_C) &&
-	    (atomic_read(&vcpu->arch.sie_block->cpuflags) &
-	     CPUSTAT_ECALL_PEND)) {
+	if (sca_ext_call_pending(vcpu, &scn)) {
 		if (n + sizeof(irq) > len)
 			return -ENOBUFS;
 		memset(&irq, 0, sizeof(irq));
 		irq.type = KVM_S390_INT_EXTERNAL_CALL;
-		irq.u.extcall.code = sigp_ctrl & SIGP_CTRL_SCN_MASK;
+		irq.u.extcall.code = scn;
 		if (copy_to_user(&buf[n], &irq, sizeof(irq)))
 			return -EFAULT;
 		n += sizeof(irq);
-- 
2.3.0
