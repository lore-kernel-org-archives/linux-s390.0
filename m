From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 45/52] KVM: s390: pfmf: fix end address calculation
Date: Tue, 14 Jun 2016 20:57:22 +0200
Message-ID: <201606141857.u5EIs1Wr040001@mx0b-001b2d01.pphosted.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

The current calculation is wrong if absolute != real address. Let's just
calculate the start address for 4k frames upfront. Otherwise, the
calculated end address will be wrong, resulting in wrong memory
location/storage keys getting touched.

To keep low-address protection working (using the effective address),
we have to move the check.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index c6deed7..bfba983 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -682,8 +682,15 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 	start = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
 	start = kvm_s390_logical_to_effective(vcpu, start);
 
+	if (vcpu->run->s.regs.gprs[reg1] & PFMF_CF) {
+		if (kvm_s390_check_low_addr_prot_real(vcpu, start))
+			return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
+	}
+
 	switch (vcpu->run->s.regs.gprs[reg1] & PFMF_FSC) {
 	case 0x00000000:
+		/* only 4k frames specify a real address */
+		start = kvm_s390_real_to_abs(vcpu, start);
 		end = (start + (1UL << 12)) & ~((1UL << 12) - 1);
 		break;
 	case 0x00001000:
@@ -701,20 +708,11 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 	}
 
-	if (vcpu->run->s.regs.gprs[reg1] & PFMF_CF) {
-		if (kvm_s390_check_low_addr_prot_real(vcpu, start))
-			return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
-	}
-
 	while (start < end) {
-		unsigned long useraddr, abs_addr;
+		unsigned long useraddr;
 
 		/* Translate guest address to host address */
-		if ((vcpu->run->s.regs.gprs[reg1] & PFMF_FSC) == 0)
-			abs_addr = kvm_s390_real_to_abs(vcpu, start);
-		else
-			abs_addr = start;
-		useraddr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(abs_addr));
+		useraddr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(start));
 		if (kvm_is_error_hva(useraddr))
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
-- 
2.5.5
