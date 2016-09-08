From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/11] KVM: s390: lazy enable RI
Date: Thu,  8 Sep 2016 14:00:20 +0200
Message-ID: <1473336023-15522-9-git-send-email-borntraeger@de.ibm.com>
References: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Fan Zhang <zhangfan@linux.vnet.ibm.com>

Only enable runtime instrumentation if the guest issues an RI related
instruction or if userspace changes the riccb to a valid state.
This makes entry/exit a tiny bit faster.

Initial patch by Christian Borntraeger
Signed-off-by: Fan Zhang <zhangfan@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c |  1 +
 arch/s390/kvm/kvm-s390.c  | 15 +++++++++++++--
 arch/s390/kvm/kvm-s390.h  |  1 +
 arch/s390/kvm/priv.c      | 21 +++++++++++++++++++++
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index dfd0ca2..1cab8a1 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -29,6 +29,7 @@ static const intercept_handler_t instruction_handlers[256] = {
 	[0x01] = kvm_s390_handle_01,
 	[0x82] = kvm_s390_handle_lpsw,
 	[0x83] = kvm_s390_handle_diag,
+	[0xaa] = kvm_s390_handle_aa,
 	[0xae] = kvm_s390_handle_sigp,
 	[0xb2] = kvm_s390_handle_b2,
 	[0xb6] = kvm_s390_handle_stctl,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index dead20a..892abf4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1938,8 +1938,6 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->eca |= 1;
 	if (sclp.has_sigpif)
 		vcpu->arch.sie_block->eca |= 0x10000000U;
-	if (test_kvm_facility(vcpu->kvm, 64))
-		vcpu->arch.sie_block->ecb3 |= 0x01;
 	if (test_kvm_facility(vcpu->kvm, 129)) {
 		vcpu->arch.sie_block->eca |= 0x00020000;
 		vcpu->arch.sie_block->ecd |= 0x20000000;
@@ -2694,6 +2692,19 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		if (vcpu->arch.pfault_token == KVM_S390_PFAULT_TOKEN_INVALID)
 			kvm_clear_async_pf_completion_queue(vcpu);
 	}
+	/*
+	 * If userspace sets the riccb (e.g. after migration) to a valid state,
+	 * we should enable RI here instead of doing the lazy enablement.
+	 */
+	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_RICCB) &&
+	    test_kvm_facility(vcpu->kvm, 64)) {
+		struct runtime_instr_cb *riccb =
+			(struct runtime_instr_cb *) &kvm_run->s.regs.riccb;
+
+		if (riccb->valid)
+			vcpu->arch.sie_block->ecb3 |= 0x01;
+	}
+
 	kvm_run->kvm_dirty_regs = 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index c3d4f16..9995cab 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -245,6 +245,7 @@ static inline void kvm_s390_retry_instr(struct kvm_vcpu *vcpu)
 
 /* implemented in priv.c */
 int is_valid_psw(psw_t *psw);
+int kvm_s390_handle_aa(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_b2(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_e5(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_01(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 4616038..e184353 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -32,6 +32,24 @@
 #include "kvm-s390.h"
 #include "trace.h"
 
+static int handle_ri(struct kvm_vcpu *vcpu)
+{
+	if (test_kvm_facility(vcpu->kvm, 64)) {
+		vcpu->arch.sie_block->ecb3 |= 0x01;
+		kvm_s390_retry_instr(vcpu);
+		return 0;
+	} else
+		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
+}
+
+int kvm_s390_handle_aa(struct kvm_vcpu *vcpu)
+{
+	if ((vcpu->arch.sie_block->ipa & 0xf) <= 4)
+		return handle_ri(vcpu);
+	else
+		return -EOPNOTSUPP;
+}
+
 /* Handle SCK (SET CLOCK) interception */
 static int handle_set_clock(struct kvm_vcpu *vcpu)
 {
@@ -1093,6 +1111,9 @@ static int handle_stctg(struct kvm_vcpu *vcpu)
 static const intercept_handler_t eb_handlers[256] = {
 	[0x2f] = handle_lctlg,
 	[0x25] = handle_stctg,
+	[0x60] = handle_ri,
+	[0x61] = handle_ri,
+	[0x62] = handle_ri,
 };
 
 int kvm_s390_handle_eb(struct kvm_vcpu *vcpu)
-- 
2.5.5
