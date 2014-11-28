From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/11] KVM: s390: Small fixes for the PFMF handler
Date: Fri, 28 Nov 2014 14:25:29 +0100
Message-ID: <1417181139-25623-2-git-send-email-borntraeger@de.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

This patch includes two small fixes for the PFMF handler: First, the
start address for PFMF has to be masked according to the current
addressing mode, which is now done with kvm_s390_logical_to_effective().
Second, the protection exceptions have a lower priority than the
specification exceptions, so the check for low-address protection
has to be moved after the last spot where we inject a specification
exception.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9bde32f..04f70fd 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -646,10 +646,7 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	start = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
-	if (vcpu->run->s.regs.gprs[reg1] & PFMF_CF) {
-		if (kvm_s390_check_low_addr_protection(vcpu, start))
-			return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
-	}
+	start = kvm_s390_logical_to_effective(vcpu, start);
 
 	switch (vcpu->run->s.regs.gprs[reg1] & PFMF_FSC) {
 	case 0x00000000:
@@ -665,6 +662,12 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 	default:
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 	}
+
+	if (vcpu->run->s.regs.gprs[reg1] & PFMF_CF) {
+		if (kvm_s390_check_low_addr_protection(vcpu, start))
+			return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
+	}
+
 	while (start < end) {
 		unsigned long useraddr, abs_addr;
 
-- 
1.9.3
