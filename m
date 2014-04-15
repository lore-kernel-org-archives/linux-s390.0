From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 22/47] KVM: s390: convert handle_set_clock()
Date: Tue, 15 Apr 2014 14:00:25 +0200
Message-ID: <1397563250-3089-23-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Convert handle_set_clock() to new guest access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index dd6ad84..9648504 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -35,8 +35,8 @@ static int handle_set_clock(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu *cpup;
 	s64 hostclk, val;
+	int i, rc;
 	u64 op2;
-	int i;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
@@ -44,8 +44,9 @@ static int handle_set_clock(struct kvm_vcpu *vcpu)
 	op2 = kvm_s390_get_base_disp_s(vcpu);
 	if (op2 & 7)	/* Operand must be on a doubleword boundary */
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	if (get_guest(vcpu, val, (u64 __user *) op2))
-		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	rc = read_guest(vcpu, op2, &val, sizeof(val));
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
 
 	if (store_tod_clock(&hostclk)) {
 		kvm_s390_set_psw_cc(vcpu, 3);
-- 
1.8.4.2
