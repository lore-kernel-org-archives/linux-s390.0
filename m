From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 3/7] KVM: s390: Privileged operation checks moved to instruction handlers
Date: Thu, 20 Jun 2013 17:22:01 +0200
Message-ID: <1371741725-53624-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1371741725-53624-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371741725-53624-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

We need more fine-grained control about the point in time when we check
for privileged instructions, since the exceptions that can happen during
an instruction have a well-defined priority. For example, for the PFMF
instruction, the check for PGM_PRIVILEGED_OP must happen after the check
for PGM_OPERATION since the latter has a higher precedence - thus the
check for privileged operation must not be done in kvm_s390_handle_b9()
already.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c | 63 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 04dc4a1..0b19e22 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -37,6 +37,9 @@ static int handle_set_prefix(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.instruction_spx++;
 
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
 	operand2 = kvm_s390_get_base_disp_s(vcpu);
 
 	/* must be word boundary */
@@ -68,6 +71,9 @@ static int handle_store_prefix(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.instruction_stpx++;
 
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
 	operand2 = kvm_s390_get_base_disp_s(vcpu);
 
 	/* must be word boundary */
@@ -92,6 +98,9 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.instruction_stap++;
 
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
 	useraddr = kvm_s390_get_base_disp_s(vcpu);
 
 	if (useraddr & 1)
@@ -108,6 +117,10 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 static int handle_skey(struct kvm_vcpu *vcpu)
 {
 	vcpu->stat.instruction_storage_key++;
+
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
 	vcpu->arch.sie_block->gpsw.addr =
 		__rewind_psw(vcpu->arch.sie_block->gpsw, 4);
 	VCPU_EVENT(vcpu, 4, "%s", "retrying storage key operation");
@@ -186,6 +199,9 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
 {
 	VCPU_EVENT(vcpu, 4, "%s", "I/O instruction");
 
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
 	if (vcpu->kvm->arch.css_support) {
 		/*
 		 * Most I/O instructions will be handled by userspace.
@@ -214,6 +230,10 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 	int rc;
 
 	vcpu->stat.instruction_stfl++;
+
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
 	/* only pass the facility bits, which we can handle */
 	facility_list = S390_lowcore.stfl_fac_list & 0xff82fff3;
 
@@ -282,6 +302,9 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 	psw_t new_psw;
 	u64 addr;
 
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
 	addr = kvm_s390_get_base_disp_s(vcpu);
 	if (addr & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -300,6 +323,9 @@ static int handle_stidp(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.instruction_stidp++;
 
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
 	operand2 = kvm_s390_get_base_disp_s(vcpu);
 
 	if (operand2 & 7)
@@ -355,6 +381,9 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	vcpu->stat.instruction_stsi++;
 	VCPU_EVENT(vcpu, 4, "stsi: fc: %x sel1: %x sel2: %x", fc, sel1, sel2);
 
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
 	operand2 = kvm_s390_get_base_disp_s(vcpu);
 
 	if (operand2 & 0xfff && fc > 0)
@@ -436,20 +465,14 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
 	intercept_handler_t handler;
 
 	/*
-	 * a lot of B2 instructions are priviledged. We first check for
-	 * the privileged ones, that we can handle in the kernel. If the
-	 * kernel can handle this instruction, we check for the problem
-	 * state bit and (a) handle the instruction or (b) send a code 2
-	 * program check.
-	 * Anything else goes to userspace.*/
+	 * A lot of B2 instructions are priviledged. Here we check for
+	 * the privileged ones, that we can handle in the kernel.
+	 * Anything else goes to userspace.
+	 */
 	handler = b2_handlers[vcpu->arch.sie_block->ipa & 0x00ff];
-	if (handler) {
-		if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
-			return kvm_s390_inject_program_int(vcpu,
-							   PGM_PRIVILEGED_OP);
-		else
-			return handler(vcpu);
-	}
+	if (handler)
+		return handler(vcpu);
+
 	return -EOPNOTSUPP;
 }
 
@@ -560,14 +583,9 @@ int kvm_s390_handle_b9(struct kvm_vcpu *vcpu)
 
 	/* This is handled just as for the B2 instructions. */
 	handler = b9_handlers[vcpu->arch.sie_block->ipa & 0x00ff];
-	if (handler) {
-		if ((handler != handle_epsw) &&
-		    (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE))
-			return kvm_s390_inject_program_int(vcpu,
-							   PGM_PRIVILEGED_OP);
-		else
-			return handler(vcpu);
-	}
+	if (handler)
+		return handler(vcpu);
+
 	return -EOPNOTSUPP;
 }
 
@@ -579,9 +597,6 @@ int kvm_s390_handle_priv_eb(struct kvm_vcpu *vcpu)
 {
 	intercept_handler_t handler;
 
-	/* All eb instructions that end up here are privileged. */
-	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
-		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 	handler = eb_handlers[vcpu->arch.sie_block->ipb & 0xff];
 	if (handler)
 		return handler(vcpu);
-- 
1.8.2.2
