From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/18] KVM: s390: read the correct opcode on SIE faults
Date: Fri, 12 Feb 2016 14:22:51 +0100
Message-ID: <1455283382-62999-8-git-send-email-borntraeger@de.ibm.com>
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

Let's use our fresh new function read_guest_instr() to access
guest storage via the correct addressing schema.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 85e169b..aa51a8d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2163,7 +2163,6 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 
 static int vcpu_post_run_fault_in_sie(struct kvm_vcpu *vcpu)
 {
-	psw_t *psw = &vcpu->arch.sie_block->gpsw;
 	u8 opcode;
 	int rc;
 
@@ -2178,7 +2177,7 @@ static int vcpu_post_run_fault_in_sie(struct kvm_vcpu *vcpu)
 	 * to look up the current opcode to get the length of the instruction
 	 * to be able to forward the PSW.
 	 */
-	rc = read_guest(vcpu, psw->addr, 0, &opcode, 1);
+	rc = read_guest_instr(vcpu, &opcode, 1);
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	kvm_s390_forward_psw(vcpu, insn_length(opcode));
-- 
2.3.0
