From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/23] KVM: s390: Introduce new structures
Date: Wed,  2 Dec 2015 12:06:10 +0100
Message-ID: <1449054384-76374-10-git-send-email-borntraeger@de.ibm.com>
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

This patch adds new structures and updates some existing ones to
provide the base for Extended SCA functionality.

The old sca_* structures were renamed to bsca_* to keep things uniform.

The access to fields of SIGP controls were turned into bitfields instead
of hardcoded bitmasks.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 47 +++++++++++++++++++++++++++++++++++-----
 arch/s390/kvm/interrupt.c        | 31 ++++++++++++++++----------
 arch/s390/kvm/kvm-s390.c         | 14 ++++++------
 arch/s390/kvm/kvm-s390.h         |  4 +++-
 4 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index efaac2c..923b13d 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -25,7 +25,9 @@
 #include <asm/fpu/api.h>
 #include <asm/isc.h>
 
-#define KVM_MAX_VCPUS 64
+#define KVM_S390_BSCA_CPU_SLOTS 64
+#define KVM_S390_ESCA_CPU_SLOTS 248
+#define KVM_MAX_VCPUS KVM_S390_BSCA_CPU_SLOTS
 #define KVM_USER_MEM_SLOTS 32
 
 /*
@@ -40,9 +42,34 @@
 #define SIGP_CTRL_C		0x80
 #define SIGP_CTRL_SCN_MASK	0x3f
 
-struct sca_entry {
+union bsca_sigp_ctrl {
+	__u8 value;
+	struct {
+		__u8 c : 1;
+		__u8 r : 1;
+		__u8 scn : 6;
+	};
+} __packed;
+
+union esca_sigp_ctrl {
+	__u16 value;
+	struct {
+		__u8 c : 1;
+		__u8 reserved: 7;
+		__u8 scn;
+	};
+} __packed;
+
+struct esca_entry {
+	union esca_sigp_ctrl sigp_ctrl;
+	__u16   reserved1[3];
+	__u64   sda;
+	__u64   reserved2[6];
+} __packed;
+
+struct bsca_entry {
 	__u8	reserved0;
-	__u8	sigp_ctrl;
+	union bsca_sigp_ctrl	sigp_ctrl;
 	__u16	reserved[3];
 	__u64	sda;
 	__u64	reserved2[2];
@@ -57,14 +84,22 @@ union ipte_control {
 	};
 };
 
-struct sca_block {
+struct bsca_block {
 	union ipte_control ipte_control;
 	__u64	reserved[5];
 	__u64	mcn;
 	__u64	reserved2;
-	struct sca_entry cpu[64];
+	struct bsca_entry cpu[KVM_S390_BSCA_CPU_SLOTS];
 } __attribute__((packed));
 
+struct esca_block {
+	union ipte_control ipte_control;
+	__u64   reserved1[7];
+	__u64   mcn[4];
+	__u64   reserved2[20];
+	struct esca_entry cpu[KVM_S390_ESCA_CPU_SLOTS];
+} __packed;
+
 #define CPUSTAT_STOPPED    0x80000000
 #define CPUSTAT_WAIT       0x10000000
 #define CPUSTAT_ECALL_PEND 0x08000000
@@ -585,7 +620,7 @@ struct kvm_s390_crypto_cb {
 };
 
 struct kvm_arch{
-	struct sca_block *sca;
+	struct bsca_block *sca;
 	debug_info_t *dbf;
 	struct kvm_s390_float_interrupt float_int;
 	struct kvm_device *flic;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2a4718a..aa221a4 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -37,25 +37,32 @@
 /* handle external calls via sigp interpretation facility */
 static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 {
-	struct sca_block *sca = vcpu->kvm->arch.sca;
-	uint8_t sigp_ctrl = sca->cpu[vcpu->vcpu_id].sigp_ctrl;
+	struct bsca_block *sca = vcpu->kvm->arch.sca;
+	union bsca_sigp_ctrl sigp_ctrl = sca->cpu[vcpu->vcpu_id].sigp_ctrl;
 
 	if (src_id)
-		*src_id = sigp_ctrl & SIGP_CTRL_SCN_MASK;
+		*src_id = sigp_ctrl.scn;
 
-	return sigp_ctrl & SIGP_CTRL_C &&
+	return sigp_ctrl.c &&
 		atomic_read(&vcpu->arch.sie_block->cpuflags) &
 			CPUSTAT_ECALL_PEND;
 }
 
 static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 {
-	struct sca_block *sca = vcpu->kvm->arch.sca;
-	uint8_t *sigp_ctrl = &(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
-	uint8_t new_val = SIGP_CTRL_C | (src_id & SIGP_CTRL_SCN_MASK);
-	uint8_t old_val = *sigp_ctrl & ~SIGP_CTRL_C;
+	int expect, rc;
+	struct bsca_block *sca = vcpu->kvm->arch.sca;
+	union bsca_sigp_ctrl *sigp_ctrl = &(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
+	union bsca_sigp_ctrl new_val = {0}, old_val = *sigp_ctrl;
 
-	if (cmpxchg(sigp_ctrl, old_val, new_val) != old_val) {
+	new_val.scn = src_id;
+	new_val.c = 1;
+	old_val.c = 0;
+
+	expect = old_val.value;
+	rc = cmpxchg(&sigp_ctrl->value, old_val.value, new_val.value);
+
+	if (rc != expect) {
 		/* another external call is pending */
 		return -EBUSY;
 	}
@@ -65,12 +72,12 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 
 static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 {
-	struct sca_block *sca = vcpu->kvm->arch.sca;
+	struct bsca_block *sca = vcpu->kvm->arch.sca;
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	uint8_t *sigp_ctrl = &(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
+	union bsca_sigp_ctrl *sigp_ctrl = &(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
 
 	atomic_andnot(CPUSTAT_ECALL_PEND, li->cpuflags);
-	*sigp_ctrl = 0;
+	sigp_ctrl->value = 0;
 }
 
 int psw_extint_disabled(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8ddd488..c268352 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1100,14 +1100,15 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	rc = -ENOMEM;
 
-	kvm->arch.sca = (struct sca_block *) get_zeroed_page(GFP_KERNEL);
+	kvm->arch.sca = (struct bsca_block *) get_zeroed_page(GFP_KERNEL);
 	if (!kvm->arch.sca)
 		goto out_err;
 	spin_lock(&kvm_lock);
 	sca_offset += 16;
-	if (sca_offset + sizeof(struct sca_block) > PAGE_SIZE)
+	if (sca_offset + sizeof(struct bsca_block) > PAGE_SIZE)
 		sca_offset = 0;
-	kvm->arch.sca = (struct sca_block *) ((char *) kvm->arch.sca + sca_offset);
+	kvm->arch.sca = (struct bsca_block *)
+			((char *) kvm->arch.sca + sca_offset);
 	spin_unlock(&kvm_lock);
 
 	sprintf(debug_name, "kvm-%u", current->pid);
@@ -1190,9 +1191,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_destroy_vcpu(vcpu->vcpu_id);
 	kvm_s390_clear_local_irqs(vcpu);
 	kvm_clear_async_pf_completion_queue(vcpu);
-	if (!kvm_is_ucontrol(vcpu->kvm)) {
+	if (!kvm_is_ucontrol(vcpu->kvm))
 		sca_del_vcpu(vcpu);
-	}
 	smp_mb();
 
 	if (kvm_is_ucontrol(vcpu->kvm))
@@ -1249,7 +1249,7 @@ static int __kvm_ucontrol_vcpu_init(struct kvm_vcpu *vcpu)
 
 static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 {
-	struct sca_block *sca = vcpu->kvm->arch.sca;
+	struct bsca_block *sca = vcpu->kvm->arch.sca;
 
 	clear_bit_inv(vcpu->vcpu_id, (unsigned long *) &sca->mcn);
 	if (sca->cpu[vcpu->vcpu_id].sda == (__u64) vcpu->arch.sie_block)
@@ -1259,7 +1259,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 static void sca_add_vcpu(struct kvm_vcpu *vcpu, struct kvm *kvm,
 			unsigned int id)
 {
-	struct sca_block *sca = kvm->arch.sca;
+	struct bsca_block *sca = kvm->arch.sca;
 
 	if (!sca->cpu[id].sda)
 		sca->cpu[id].sda = (__u64) vcpu->arch.sie_block;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 844f711..df1abad 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -343,6 +343,8 @@ void kvm_s390_handle_per_event(struct kvm_vcpu *vcpu);
 /* support for Basic/Extended SCA handling */
 static inline union ipte_control *kvm_s390_get_ipte_control(struct kvm *kvm)
 {
-	return &kvm->arch.sca->ipte_control;
+	struct bsca_block *sca = kvm->arch.sca; /* SCA version doesn't matter */
+
+	return &sca->ipte_control;
 }
 #endif
-- 
2.3.0
