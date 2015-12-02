From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/23] KVM: s390: Make provisions for ESCA utilization
Date: Wed,  2 Dec 2015 12:06:11 +0100
Message-ID: <1449054384-76374-11-git-send-email-borntraeger@de.ibm.com>
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

This patch updates the routines (sca_*) to provide transparent access
to and manipulation on the data for both Basic and Extended SCA in use.
The kvm.arch.sca is generalized to (void *) to handle BSCA/ESCA cases.
Also the kvm.arch.use_esca flag is provided.
The actual functionality is kept the same.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  3 +-
 arch/s390/kvm/interrupt.c        | 78 +++++++++++++++++++++++++++++++---------
 arch/s390/kvm/kvm-s390.c         | 54 +++++++++++++++++++++-------
 3 files changed, 106 insertions(+), 29 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 923b13d..25fdbf8 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -620,7 +620,8 @@ struct kvm_s390_crypto_cb {
 };
 
 struct kvm_arch{
-	struct bsca_block *sca;
+	void *sca;
+	int use_esca;
 	debug_info_t *dbf;
 	struct kvm_s390_float_interrupt float_int;
 	struct kvm_device *flic;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index aa221a4..60b36b0 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -37,30 +37,60 @@
 /* handle external calls via sigp interpretation facility */
 static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 {
-	struct bsca_block *sca = vcpu->kvm->arch.sca;
-	union bsca_sigp_ctrl sigp_ctrl = sca->cpu[vcpu->vcpu_id].sigp_ctrl;
+	int c, scn;
+
+	if (vcpu->kvm->arch.use_esca) {
+		struct esca_block *sca = vcpu->kvm->arch.sca;
+		union esca_sigp_ctrl sigp_ctrl =
+			sca->cpu[vcpu->vcpu_id].sigp_ctrl;
+
+		c = sigp_ctrl.c;
+		scn = sigp_ctrl.scn;
+	} else {
+		struct bsca_block *sca = vcpu->kvm->arch.sca;
+		union bsca_sigp_ctrl sigp_ctrl =
+			sca->cpu[vcpu->vcpu_id].sigp_ctrl;
+
+		c = sigp_ctrl.c;
+		scn = sigp_ctrl.scn;
+	}
 
 	if (src_id)
-		*src_id = sigp_ctrl.scn;
+		*src_id = scn;
 
-	return sigp_ctrl.c &&
-		atomic_read(&vcpu->arch.sie_block->cpuflags) &
+	return c && atomic_read(&vcpu->arch.sie_block->cpuflags) &
 			CPUSTAT_ECALL_PEND;
 }
 
 static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 {
 	int expect, rc;
-	struct bsca_block *sca = vcpu->kvm->arch.sca;
-	union bsca_sigp_ctrl *sigp_ctrl = &(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
-	union bsca_sigp_ctrl new_val = {0}, old_val = *sigp_ctrl;
 
-	new_val.scn = src_id;
-	new_val.c = 1;
-	old_val.c = 0;
+	if (vcpu->kvm->arch.use_esca) {
+		struct esca_block *sca = vcpu->kvm->arch.sca;
+		union esca_sigp_ctrl *sigp_ctrl =
+			&(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
+		union esca_sigp_ctrl new_val = {0}, old_val = *sigp_ctrl;
 
-	expect = old_val.value;
-	rc = cmpxchg(&sigp_ctrl->value, old_val.value, new_val.value);
+		new_val.scn = src_id;
+		new_val.c = 1;
+		old_val.c = 0;
+
+		expect = old_val.value;
+		rc = cmpxchg(&sigp_ctrl->value, old_val.value, new_val.value);
+	} else {
+		struct bsca_block *sca = vcpu->kvm->arch.sca;
+		union bsca_sigp_ctrl *sigp_ctrl =
+			&(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
+		union bsca_sigp_ctrl new_val = {0}, old_val = *sigp_ctrl;
+
+		new_val.scn = src_id;
+		new_val.c = 1;
+		old_val.c = 0;
+
+		expect = old_val.value;
+		rc = cmpxchg(&sigp_ctrl->value, old_val.value, new_val.value);
+	}
 
 	if (rc != expect) {
 		/* another external call is pending */
@@ -72,12 +102,28 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 
 static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 {
-	struct bsca_block *sca = vcpu->kvm->arch.sca;
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	union bsca_sigp_ctrl *sigp_ctrl = &(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
+	int rc, expect;
 
 	atomic_andnot(CPUSTAT_ECALL_PEND, li->cpuflags);
-	sigp_ctrl->value = 0;
+	if (vcpu->kvm->arch.use_esca) {
+		struct esca_block *sca = vcpu->kvm->arch.sca;
+		union esca_sigp_ctrl *sigp_ctrl =
+			&(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
+		union esca_sigp_ctrl old = *sigp_ctrl;
+
+		expect = old.value;
+		rc = cmpxchg(&sigp_ctrl->value, old.value, 0);
+	} else {
+		struct bsca_block *sca = vcpu->kvm->arch.sca;
+		union bsca_sigp_ctrl *sigp_ctrl =
+			&(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
+		union bsca_sigp_ctrl old = *sigp_ctrl;
+
+		expect = old.value;
+		rc = cmpxchg(&sigp_ctrl->value, old.value, 0);
+	}
+	WARN_ON(rc != expect); /* cannot clear? */
 }
 
 int psw_extint_disabled(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c268352..41b3fed 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1077,6 +1077,15 @@ static int kvm_s390_crypto_init(struct kvm *kvm)
 	return 0;
 }
 
+static void sca_dispose(struct kvm *kvm)
+{
+	if (kvm->arch.use_esca)
+		BUG(); /* not implemented yet */
+	else
+		free_page((unsigned long)(kvm->arch.sca));
+	kvm->arch.sca = NULL;
+}
+
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	int i, rc;
@@ -1100,6 +1109,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	rc = -ENOMEM;
 
+	kvm->arch.use_esca = 0; /* start with basic SCA */
 	kvm->arch.sca = (struct bsca_block *) get_zeroed_page(GFP_KERNEL);
 	if (!kvm->arch.sca)
 		goto out_err;
@@ -1180,7 +1190,7 @@ out_err:
 	kfree(kvm->arch.crypto.crycb);
 	free_page((unsigned long)kvm->arch.model.fac);
 	debug_unregister(kvm->arch.dbf);
-	free_page((unsigned long)(kvm->arch.sca));
+	sca_dispose(kvm);
 	KVM_EVENT(3, "creation of vm failed: %d", rc);
 	return rc;
 }
@@ -1226,7 +1236,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	kvm_free_vcpus(kvm);
 	free_page((unsigned long)kvm->arch.model.fac);
-	free_page((unsigned long)(kvm->arch.sca));
+	sca_dispose(kvm);
 	debug_unregister(kvm->arch.dbf);
 	kfree(kvm->arch.crypto.crycb);
 	if (!kvm_is_ucontrol(kvm))
@@ -1249,23 +1259,41 @@ static int __kvm_ucontrol_vcpu_init(struct kvm_vcpu *vcpu)
 
 static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 {
-	struct bsca_block *sca = vcpu->kvm->arch.sca;
+	if (vcpu->kvm->arch.use_esca) {
+		struct esca_block *sca = vcpu->kvm->arch.sca;
 
-	clear_bit_inv(vcpu->vcpu_id, (unsigned long *) &sca->mcn);
-	if (sca->cpu[vcpu->vcpu_id].sda == (__u64) vcpu->arch.sie_block)
-		sca->cpu[vcpu->vcpu_id].sda = 0;
+		clear_bit_inv(vcpu->vcpu_id, (unsigned long *) sca->mcn);
+		if (sca->cpu[vcpu->vcpu_id].sda == (__u64) vcpu->arch.sie_block)
+			sca->cpu[vcpu->vcpu_id].sda = 0;
+	} else {
+		struct bsca_block *sca = vcpu->kvm->arch.sca;
+
+		clear_bit_inv(vcpu->vcpu_id, (unsigned long *) &sca->mcn);
+		if (sca->cpu[vcpu->vcpu_id].sda == (__u64) vcpu->arch.sie_block)
+			sca->cpu[vcpu->vcpu_id].sda = 0;
+	}
 }
 
 static void sca_add_vcpu(struct kvm_vcpu *vcpu, struct kvm *kvm,
 			unsigned int id)
 {
-	struct bsca_block *sca = kvm->arch.sca;
+	if (kvm->arch.use_esca) {
+		struct esca_block *sca = kvm->arch.sca;
 
-	if (!sca->cpu[id].sda)
-		sca->cpu[id].sda = (__u64) vcpu->arch.sie_block;
-	vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
-	vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
-	set_bit_inv(id, (unsigned long *) &sca->mcn);
+		if (!sca->cpu[id].sda)
+			sca->cpu[id].sda = (__u64) vcpu->arch.sie_block;
+		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
+		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca & ~0x3fU;
+		set_bit_inv(id, (unsigned long *) sca->mcn);
+	} else {
+		struct bsca_block *sca = kvm->arch.sca;
+
+		if (!sca->cpu[id].sda)
+			sca->cpu[id].sda = (__u64) vcpu->arch.sie_block;
+		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
+		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
+		set_bit_inv(id, (unsigned long *) &sca->mcn);
+	}
 }
 
 static int sca_can_add_vcpu(struct kvm *kvm, unsigned int id)
@@ -1458,6 +1486,8 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->ecb |= 0x10;
 
 	vcpu->arch.sie_block->ecb2  = 8;
+	if (vcpu->kvm->arch.use_esca)
+		vcpu->arch.sie_block->ecb2 |= 4;
 	vcpu->arch.sie_block->eca   = 0xC1002000U;
 	if (sclp.has_siif)
 		vcpu->arch.sie_block->eca |= 1;
-- 
2.3.0
