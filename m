From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 18/47] KVM: s390: convert pfault code
Date: Tue, 15 Apr 2014 14:00:21 +0200
Message-ID: <1397563250-3089-19-git-send-email-borntraeger@de.ibm.com>
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

Convert pfault code to new guest access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/diag.c     | 9 ++++-----
 arch/s390/kvm/kvm-s390.c | 5 +++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index ff768f1..5521ace 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -64,12 +64,12 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 	int rc;
 	u16 rx = (vcpu->arch.sie_block->ipa & 0xf0) >> 4;
 	u16 ry = (vcpu->arch.sie_block->ipa & 0x0f);
-	unsigned long hva_token = KVM_HVA_ERR_BAD;
 
 	if (vcpu->run->s.regs.gprs[rx] & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	if (copy_from_guest(vcpu, &parm, vcpu->run->s.regs.gprs[rx], sizeof(parm)))
-		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	rc = read_guest(vcpu, vcpu->run->s.regs.gprs[rx], &parm, sizeof(parm));
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
 	if (parm.parm_version != 2 || parm.parm_len < 5 || parm.code != 0x258)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
@@ -89,8 +89,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 		    parm.token_addr & 7 || parm.zarch != 0x8000000000000000ULL)
 			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-		hva_token = gfn_to_hva(vcpu->kvm, gpa_to_gfn(parm.token_addr));
-		if (kvm_is_error_hva(hva_token))
+		if (kvm_is_error_gpa(vcpu->kvm, parm.token_addr))
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 		vcpu->arch.pfault_token = parm.token_addr;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e1dfe24..6cee19c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1058,8 +1058,9 @@ static int kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu)
 	if (!vcpu->arch.gmap->pfault_enabled)
 		return 0;
 
-	hva = gmap_fault(current->thread.gmap_addr, vcpu->arch.gmap);
-	if (copy_from_guest(vcpu, &arch.pfault_token, vcpu->arch.pfault_token, 8))
+	hva = gfn_to_hva(vcpu->kvm, gpa_to_gfn(current->thread.gmap_addr));
+	hva += current->thread.gmap_addr & ~PAGE_MASK;
+	if (read_guest_real(vcpu, vcpu->arch.pfault_token, &arch.pfault_token, 8))
 		return 0;
 
 	rc = kvm_setup_async_pf(vcpu, current->thread.gmap_addr, hva, &arch);
-- 
1.8.4.2
