From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 8/8] KVM: s390: Intercept SCK instruction
Date: Thu, 12 Sep 2013 10:33:49 +0200
Message-ID: <1378974829-46578-9-git-send-email-borntraeger@de.ibm.com>
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

Interception of the SET CLOCK instruction is mandatory, so this patch
provides a simple handler for this instruction (by setting up the
"epoch" field in the sie_block).

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 6f95994..2440602 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -30,6 +30,38 @@
 #include "kvm-s390.h"
 #include "trace.h"
 
+/* Handle SCK (SET CLOCK) interception */
+static int handle_set_clock(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu *cpup;
+	s64 hostclk, val;
+	u64 op2;
+	int i;
+
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
+	op2 = kvm_s390_get_base_disp_s(vcpu);
+	if (op2 & 7)	/* Operand must be on a doubleword boundary */
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+	if (get_guest(vcpu, val, (u64 __user *) op2))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+
+	if (store_tod_clock(&hostclk)) {
+		kvm_s390_set_psw_cc(vcpu, 3);
+		return 0;
+	}
+	val = (val - hostclk) & ~0x3fUL;
+
+	mutex_lock(&vcpu->kvm->lock);
+	kvm_for_each_vcpu(i, cpup, vcpu->kvm)
+		cpup->arch.sie_block->epoch = val;
+	mutex_unlock(&vcpu->kvm->lock);
+
+	kvm_s390_set_psw_cc(vcpu, 0);
+	return 0;
+}
+
 static int handle_set_prefix(struct kvm_vcpu *vcpu)
 {
 	u64 operand2;
@@ -465,6 +497,7 @@ out_exception:
 
 static const intercept_handler_t b2_handlers[256] = {
 	[0x02] = handle_stidp,
+	[0x04] = handle_set_clock,
 	[0x10] = handle_set_prefix,
 	[0x11] = handle_store_prefix,
 	[0x12] = handle_store_cpu_address,
-- 
1.8.3.1
