From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 7/7] KVM: s390: Fixed priority of execution in STSI
Date: Thu, 20 Jun 2013 17:22:05 +0200
Message-ID: <1371741725-53624-8-git-send-email-cornelia.huck@de.ibm.com>
References: <1371741725-53624-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371741725-53624-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Added some missing validity checks for the operands and fixed the
priority of exceptions for some function codes according to the
"Principles of Operation" document.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index c7603f5..0da3e6e 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -385,16 +385,27 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	operand2 = kvm_s390_get_base_disp_s(vcpu);
+	if (fc > 3) {
+		vcpu->arch.sie_block->gpsw.mask |= 3ul << 44;	  /* cc 3 */
+		return 0;
+	}
 
-	if (operand2 & 0xfff && fc > 0)
+	if (vcpu->run->s.regs.gprs[0] & 0x0fffff00
+	    || vcpu->run->s.regs.gprs[1] & 0xffff0000)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	switch (fc) {
-	case 0:
+	if (fc == 0) {
 		vcpu->run->s.regs.gprs[0] = 3 << 28;
-		vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
+		vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);  /* cc 0 */
 		return 0;
+	}
+
+	operand2 = kvm_s390_get_base_disp_s(vcpu);
+
+	if (operand2 & 0xfff)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	switch (fc) {
 	case 1: /* same handling for 1 and 2 */
 	case 2:
 		mem = get_zeroed_page(GFP_KERNEL);
@@ -411,8 +422,6 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 			goto out_no_data;
 		handle_stsi_3_2_2(vcpu, (void *) mem);
 		break;
-	default:
-		goto out_no_data;
 	}
 
 	if (copy_to_guest_absolute(vcpu, operand2, (void *) mem, PAGE_SIZE)) {
-- 
1.8.2.2
