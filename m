From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/20] KVM: s390: Forward PSW to next instruction for addressing exceptions
Date: Fri,  6 Mar 2015 14:16:42 +0100
Message-ID: <1425647812-61838-11-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

When the SIE exited by a DAT access exceptions which we can not
resolve, the guest tried to access a page which is out of bounds
and can not be paged-in. In this case we have to signal the bad
access by injecting an address exception. However, address exceptions
are either suppressing or terminating, i.e. the PSW has to point to
the next instruction when the exception is delivered. Since the
originating DAT access exception is nullifying, the PSW still
points to the offending instruction instead, so we've got to forward
the PSW to the next instruction.
Having fixed this issue, we can now also enable the TPROT
interpretation facility again which had been disabled because
of this problem.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f6579cf..7ac40aa 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1148,8 +1148,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->eca |= 1;
 	if (sclp_has_sigpif())
 		vcpu->arch.sie_block->eca |= 0x10000000U;
-	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE |
-				      ICTL_TPROT;
+	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 
 	if (kvm_s390_cmma_enabled(vcpu->kvm)) {
 		rc = kvm_s390_vcpu_setup_cmma(vcpu);
@@ -1726,6 +1725,31 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int vcpu_post_run_fault_in_sie(struct kvm_vcpu *vcpu)
+{
+	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+	u8 opcode;
+	int rc;
+
+	VCPU_EVENT(vcpu, 3, "%s", "fault in sie instruction");
+	trace_kvm_s390_sie_fault(vcpu);
+
+	/*
+	 * We want to inject an addressing exception, which is defined as a
+	 * suppressing or terminating exception. However, since we came here
+	 * by a DAT access exception, the PSW still points to the faulting
+	 * instruction since DAT exceptions are nullifying. So we've got
+	 * to look up the current opcode to get the length of the instruction
+	 * to be able to forward the PSW.
+	 */
+	rc = read_guest(vcpu, psw->addr, &opcode, 1);
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
+	psw->addr = __rewind_psw(*psw, -insn_length(opcode));
+
+	return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+}
+
 static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 {
 	int rc = -1;
@@ -1757,11 +1781,8 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 		}
 	}
 
-	if (rc == -1) {
-		VCPU_EVENT(vcpu, 3, "%s", "fault in sie instruction");
-		trace_kvm_s390_sie_fault(vcpu);
-		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-	}
+	if (rc == -1)
+		rc = vcpu_post_run_fault_in_sie(vcpu);
 
 	memcpy(&vcpu->run->s.regs.gprs[14], &vcpu->arch.sie_block->gg14, 16);
 
-- 
2.3.0
