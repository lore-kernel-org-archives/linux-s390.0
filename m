From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 7/8] KVM: s390: Implement TEST BLOCK
Date: Thu, 12 Sep 2013 10:33:48 +0200
Message-ID: <1378974829-46578-8-git-send-email-borntraeger@de.ibm.com>
References: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

This patch provides a simple version for the mandatory TEST BLOCK
instruction interception, so that guests that use this instruction
do not crash anymore.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 59200ee..6f95994 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -128,6 +128,33 @@ static int handle_skey(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int handle_test_block(struct kvm_vcpu *vcpu)
+{
+	unsigned long hva;
+	gpa_t addr;
+	int reg2;
+
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
+	kvm_s390_get_regs_rre(vcpu, NULL, &reg2);
+	addr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
+	addr = kvm_s390_real_to_abs(vcpu, addr);
+
+	hva = gfn_to_hva(vcpu->kvm, gpa_to_gfn(addr));
+	if (kvm_is_error_hva(hva))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	/*
+	 * We don't expect errors on modern systems, and do not care
+	 * about storage keys (yet), so let's just clear the page.
+	 */
+	if (clear_user((void __user *)hva, PAGE_SIZE) != 0)
+		return -EFAULT;
+	kvm_s390_set_psw_cc(vcpu, 0);
+	vcpu->run->s.regs.gprs[0] = 0;
+	return 0;
+}
+
 static int handle_tpi(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_interrupt_info *inti;
@@ -444,6 +471,7 @@ static const intercept_handler_t b2_handlers[256] = {
 	[0x29] = handle_skey,
 	[0x2a] = handle_skey,
 	[0x2b] = handle_skey,
+	[0x2c] = handle_test_block,
 	[0x30] = handle_io_inst,
 	[0x31] = handle_io_inst,
 	[0x32] = handle_io_inst,
-- 
1.8.3.1
