From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 28/47] KVM: s390: convert handle_lpsw[e]()
Date: Tue, 15 Apr 2014 14:00:31 +0200
Message-ID: <1397563250-3089-29-git-send-email-borntraeger@de.ibm.com>
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

Convert handle_lpsw[e]() to new guest access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index f4451f0..2de7454 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -381,6 +381,7 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
 	psw_compat_t new_psw;
 	u64 addr;
+	int rc;
 
 	if (gpsw->mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
@@ -388,8 +389,10 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	addr = kvm_s390_get_base_disp_s(vcpu);
 	if (addr & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	if (copy_from_guest(vcpu, &new_psw, addr, sizeof(new_psw)))
-		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+
+	rc = read_guest(vcpu, addr, &new_psw, sizeof(new_psw));
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
 	if (!(new_psw.mask & PSW32_MASK_BASE))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 	gpsw->mask = (new_psw.mask & ~PSW32_MASK_BASE) << 32;
@@ -405,6 +408,7 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 {
 	psw_t new_psw;
 	u64 addr;
+	int rc;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
@@ -412,8 +416,9 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 	addr = kvm_s390_get_base_disp_s(vcpu);
 	if (addr & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	if (copy_from_guest(vcpu, &new_psw, addr, sizeof(new_psw)))
-		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	rc = read_guest(vcpu, addr, &new_psw, sizeof(new_psw));
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
 	vcpu->arch.sie_block->gpsw = new_psw;
 	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-- 
1.8.4.2
