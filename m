From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 6/7] KVM: s390: Reworked LCTL and LCTLG instructions
Date: Thu, 20 Jun 2013 17:22:04 +0200
Message-ID: <1371741725-53624-7-git-send-email-cornelia.huck@de.ibm.com>
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

LCTL and LCTLG are also privileged instructions, thus there is no need for
treating them separately from the other instructions in priv.c. So this
patch moves these two instructions to priv.c, adds a check for supervisor
state and simplifies the "handle_eb" instruction decoding by merging the
two eb_handlers jump tables from intercept.c and priv.c into one table only.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 85 ++---------------------------------------------
 arch/s390/kvm/kvm-s390.h  |  3 +-
 arch/s390/kvm/priv.c      | 78 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 85 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index f0b8be0..5ee56e5 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -22,87 +22,6 @@
 #include "trace.h"
 #include "trace-s390.h"
 
-static int handle_lctlg(struct kvm_vcpu *vcpu)
-{
-	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
-	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
-	u64 useraddr;
-	int reg, rc;
-
-	vcpu->stat.instruction_lctlg++;
-
-	useraddr = kvm_s390_get_base_disp_rsy(vcpu);
-
-	if (useraddr & 7)
-		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-
-	reg = reg1;
-
-	VCPU_EVENT(vcpu, 5, "lctlg r1:%x, r3:%x, addr:%llx", reg1, reg3,
-		   useraddr);
-	trace_kvm_s390_handle_lctl(vcpu, 1, reg1, reg3, useraddr);
-
-	do {
-		rc = get_guest(vcpu, vcpu->arch.sie_block->gcr[reg],
-			       (u64 __user *) useraddr);
-		if (rc)
-			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		useraddr += 8;
-		if (reg == reg3)
-			break;
-		reg = (reg + 1) % 16;
-	} while (1);
-	return 0;
-}
-
-static int handle_lctl(struct kvm_vcpu *vcpu)
-{
-	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
-	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
-	u64 useraddr;
-	u32 val = 0;
-	int reg, rc;
-
-	vcpu->stat.instruction_lctl++;
-
-	useraddr = kvm_s390_get_base_disp_rs(vcpu);
-
-	if (useraddr & 3)
-		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-
-	VCPU_EVENT(vcpu, 5, "lctl r1:%x, r3:%x, addr:%llx", reg1, reg3,
-		   useraddr);
-	trace_kvm_s390_handle_lctl(vcpu, 0, reg1, reg3, useraddr);
-
-	reg = reg1;
-	do {
-		rc = get_guest(vcpu, val, (u32 __user *) useraddr);
-		if (rc)
-			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		vcpu->arch.sie_block->gcr[reg] &= 0xffffffff00000000ul;
-		vcpu->arch.sie_block->gcr[reg] |= val;
-		useraddr += 4;
-		if (reg == reg3)
-			break;
-		reg = (reg + 1) % 16;
-	} while (1);
-	return 0;
-}
-
-static const intercept_handler_t eb_handlers[256] = {
-	[0x2f] = handle_lctlg,
-	[0x8a] = kvm_s390_handle_priv_eb,
-};
-
-static int handle_eb(struct kvm_vcpu *vcpu)
-{
-	intercept_handler_t handler;
-
-	handler = eb_handlers[vcpu->arch.sie_block->ipb & 0xff];
-	if (handler)
-		return handler(vcpu);
-	return -EOPNOTSUPP;
-}
 
 static const intercept_handler_t instruction_handlers[256] = {
 	[0x01] = kvm_s390_handle_01,
@@ -110,10 +29,10 @@ static const intercept_handler_t instruction_handlers[256] = {
 	[0x83] = kvm_s390_handle_diag,
 	[0xae] = kvm_s390_handle_sigp,
 	[0xb2] = kvm_s390_handle_b2,
-	[0xb7] = handle_lctl,
+	[0xb7] = kvm_s390_handle_lctl,
 	[0xb9] = kvm_s390_handle_b9,
 	[0xe5] = kvm_s390_handle_e5,
-	[0xeb] = handle_eb,
+	[0xeb] = kvm_s390_handle_eb,
 };
 
 static int handle_noop(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 15795b8..028ca9f 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -132,7 +132,8 @@ int kvm_s390_handle_e5(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_01(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_b9(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu);
-int kvm_s390_handle_priv_eb(struct kvm_vcpu *vcpu);
+int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu);
+int kvm_s390_handle_eb(struct kvm_vcpu *vcpu);
 
 /* implemented in sigp.c */
 int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 4b8fb6c..c7603f5 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -590,11 +590,87 @@ int kvm_s390_handle_b9(struct kvm_vcpu *vcpu)
 	return -EOPNOTSUPP;
 }
 
+int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu)
+{
+	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
+	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
+	u64 useraddr;
+	u32 val = 0;
+	int reg, rc;
+
+	vcpu->stat.instruction_lctl++;
+
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
+	useraddr = kvm_s390_get_base_disp_rs(vcpu);
+
+	if (useraddr & 3)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	VCPU_EVENT(vcpu, 5, "lctl r1:%x, r3:%x, addr:%llx", reg1, reg3,
+		   useraddr);
+	trace_kvm_s390_handle_lctl(vcpu, 0, reg1, reg3, useraddr);
+
+	reg = reg1;
+	do {
+		rc = get_guest(vcpu, val, (u32 __user *) useraddr);
+		if (rc)
+			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		vcpu->arch.sie_block->gcr[reg] &= 0xffffffff00000000ul;
+		vcpu->arch.sie_block->gcr[reg] |= val;
+		useraddr += 4;
+		if (reg == reg3)
+			break;
+		reg = (reg + 1) % 16;
+	} while (1);
+
+	return 0;
+}
+
+static int handle_lctlg(struct kvm_vcpu *vcpu)
+{
+	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
+	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
+	u64 useraddr;
+	int reg, rc;
+
+	vcpu->stat.instruction_lctlg++;
+
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
+	useraddr = kvm_s390_get_base_disp_rsy(vcpu);
+
+	if (useraddr & 7)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	reg = reg1;
+
+	VCPU_EVENT(vcpu, 5, "lctlg r1:%x, r3:%x, addr:%llx", reg1, reg3,
+		   useraddr);
+	trace_kvm_s390_handle_lctl(vcpu, 1, reg1, reg3, useraddr);
+
+	do {
+		rc = get_guest(vcpu, vcpu->arch.sie_block->gcr[reg],
+			       (u64 __user *) useraddr);
+		if (rc)
+			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		useraddr += 8;
+		if (reg == reg3)
+			break;
+		reg = (reg + 1) % 16;
+	} while (1);
+
+	return 0;
+}
+
 static const intercept_handler_t eb_handlers[256] = {
+	[0x2f] = handle_lctlg,
 	[0x8a] = handle_io_inst,
 };
 
-int kvm_s390_handle_priv_eb(struct kvm_vcpu *vcpu)
+int kvm_s390_handle_eb(struct kvm_vcpu *vcpu)
 {
 	intercept_handler_t handler;
 
-- 
1.8.2.2
