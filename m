From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/18] KVM: s390: provide prog irq ilc on SIE faults
Date: Fri, 12 Feb 2016 14:22:54 +0100
Message-ID: <1455283382-62999-11-git-send-email-borntraeger@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

On SIE faults, the ilc cannot be detected automatically, as the icptcode
is 0. The ilc indicated in the program irq will always be 0. Therefore we
have to manually specify the ilc in order to tell the guest which ilen was
used when forwarding the PSW.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index aa51a8d..12cec63ed 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2163,7 +2163,10 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 
 static int vcpu_post_run_fault_in_sie(struct kvm_vcpu *vcpu)
 {
-	u8 opcode;
+	struct kvm_s390_pgm_info pgm_info = {
+		.code = PGM_ADDRESSING,
+	};
+	u8 opcode, ilen;
 	int rc;
 
 	VCPU_EVENT(vcpu, 3, "%s", "fault in sie instruction");
@@ -2180,9 +2183,10 @@ static int vcpu_post_run_fault_in_sie(struct kvm_vcpu *vcpu)
 	rc = read_guest_instr(vcpu, &opcode, 1);
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
-	kvm_s390_forward_psw(vcpu, insn_length(opcode));
-
-	return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	ilen = insn_length(opcode);
+	pgm_info.flags = ilen | KVM_S390_PGM_FLAGS_ILC_VALID;
+	kvm_s390_forward_psw(vcpu, ilen);
+	return kvm_s390_inject_prog_irq(vcpu, &pgm_info);
 }
 
 static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
-- 
2.3.0
