From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/6] KVM: s390: Fixes for PFMF
Date: Tue, 29 Apr 2014 15:36:45 +0200
Message-ID: <1398778608-3887-4-git-send-email-borntraeger@de.ibm.com>
References: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Add a check for low-address protection to the PFMF handler and
convert real-addresses to absolute if necessary, as it is defined
in the Principles of Operations specification.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 27f9051..a47157b 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -650,6 +650,11 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	start = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
+	if (vcpu->run->s.regs.gprs[reg1] & PFMF_CF) {
+		if (kvm_s390_check_low_addr_protection(vcpu, start))
+			return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
+	}
+
 	switch (vcpu->run->s.regs.gprs[reg1] & PFMF_FSC) {
 	case 0x00000000:
 		end = (start + (1UL << 12)) & ~((1UL << 12) - 1);
@@ -665,10 +670,15 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 	}
 	while (start < end) {
-		unsigned long useraddr;
-
-		useraddr = gmap_translate(start, vcpu->arch.gmap);
-		if (IS_ERR((void *)useraddr))
+		unsigned long useraddr, abs_addr;
+
+		/* Translate guest address to host address */
+		if ((vcpu->run->s.regs.gprs[reg1] & PFMF_FSC) == 0)
+			abs_addr = kvm_s390_real_to_abs(vcpu, start);
+		else
+			abs_addr = start;
+		useraddr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(abs_addr));
+		if (kvm_is_error_hva(useraddr))
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 		if (vcpu->run->s.regs.gprs[reg1] & PFMF_CF) {
-- 
1.8.4.2
