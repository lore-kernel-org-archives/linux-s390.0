From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 25/47] KVM: s390: convert handle_test_block()
Date: Tue, 15 Apr 2014 14:00:28 +0200
Message-ID: <1397563250-3089-26-git-send-email-borntraeger@de.ibm.com>
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

Convert handle_test_block() to new guest access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 36c34cf..5abfd53 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -198,7 +198,6 @@ static int handle_ipte_interlock(struct kvm_vcpu *vcpu)
 
 static int handle_test_block(struct kvm_vcpu *vcpu)
 {
-	unsigned long hva;
 	gpa_t addr;
 	int reg2;
 
@@ -209,14 +208,13 @@ static int handle_test_block(struct kvm_vcpu *vcpu)
 	addr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
 	addr = kvm_s390_real_to_abs(vcpu, addr);
 
-	hva = gfn_to_hva(vcpu->kvm, gpa_to_gfn(addr));
-	if (kvm_is_error_hva(hva))
+	if (kvm_is_error_gpa(vcpu->kvm, addr))
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 	/*
 	 * We don't expect errors on modern systems, and do not care
 	 * about storage keys (yet), so let's just clear the page.
 	 */
-	if (clear_user((void __user *)hva, PAGE_SIZE) != 0)
+	if (kvm_clear_guest(vcpu->kvm, addr, PAGE_SIZE))
 		return -EFAULT;
 	kvm_s390_set_psw_cc(vcpu, 0);
 	vcpu->run->s.regs.gprs[0] = 0;
-- 
1.8.4.2
