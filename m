From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/7] KVM: s390: Decoding helper functions.
Date: Thu, 20 Dec 2012 15:32:07 +0100
Message-ID: <1356013932-23775-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1356013932-23775-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1356013932-23775-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Introduce helper functions for decoding the various base/displacement
instruction formats.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 21 ++++++---------------
 arch/s390/kvm/kvm-s390.h  | 37 +++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/priv.c      | 42 +++++++++++-------------------------------
 arch/s390/kvm/sigp.c      |  6 +-----
 4 files changed, 55 insertions(+), 51 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 0c08b3f..df6c0ad 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -26,9 +26,6 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 {
 	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
 	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
-	int base2 = vcpu->arch.sie_block->ipb >> 28;
-	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16) +
-			((vcpu->arch.sie_block->ipb & 0xff00) << 4);
 	u64 useraddr;
 	int reg, rc;
 
@@ -36,17 +33,15 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 	if ((vcpu->arch.sie_block->ipb & 0xff) != 0x2f)
 		return -EOPNOTSUPP;
 
-	useraddr = disp2;
-	if (base2)
-		useraddr += vcpu->run->s.regs.gprs[base2];
+	useraddr = kvm_s390_get_base_disp_rsy(vcpu);
 
 	if (useraddr & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	reg = reg1;
 
-	VCPU_EVENT(vcpu, 5, "lctlg r1:%x, r3:%x,b2:%x,d2:%x", reg1, reg3, base2,
-		   disp2);
+	VCPU_EVENT(vcpu, 5, "lctlg r1:%x, r3:%x, addr:%llx", reg1, reg3,
+		   useraddr);
 	trace_kvm_s390_handle_lctl(vcpu, 1, reg1, reg3, useraddr);
 
 	do {
@@ -68,23 +63,19 @@ static int handle_lctl(struct kvm_vcpu *vcpu)
 {
 	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
 	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
-	int base2 = vcpu->arch.sie_block->ipb >> 28;
-	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
 	u64 useraddr;
 	u32 val = 0;
 	int reg, rc;
 
 	vcpu->stat.instruction_lctl++;
 
-	useraddr = disp2;
-	if (base2)
-		useraddr += vcpu->run->s.regs.gprs[base2];
+	useraddr = kvm_s390_get_base_disp_rs(vcpu);
 
 	if (useraddr & 3)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	VCPU_EVENT(vcpu, 5, "lctl r1:%x, r3:%x,b2:%x,d2:%x", reg1, reg3, base2,
-		   disp2);
+	VCPU_EVENT(vcpu, 5, "lctl r1:%x, r3:%x, addr:%llx", reg1, reg3,
+		   useraddr);
 	trace_kvm_s390_handle_lctl(vcpu, 0, reg1, reg3, useraddr);
 
 	reg = reg1;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index d75bc5e..dccc024 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -65,6 +65,43 @@ static inline void kvm_s390_set_prefix(struct kvm_vcpu *vcpu, u32 prefix)
 	vcpu->arch.sie_block->ihcpu  = 0xffff;
 }
 
+static inline u64 kvm_s390_get_base_disp_s(struct kvm_vcpu *vcpu)
+{
+	int base2 = vcpu->arch.sie_block->ipb >> 28;
+	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
+
+	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
+}
+
+static inline void kvm_s390_get_base_disp_sse(struct kvm_vcpu *vcpu,
+					      u64 *address1, u64 *address2)
+{
+	int base1 = (vcpu->arch.sie_block->ipb & 0xf0000000) >> 28;
+	int disp1 = (vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16;
+	int base2 = (vcpu->arch.sie_block->ipb & 0xf000) >> 12;
+	int disp2 = vcpu->arch.sie_block->ipb & 0x0fff;
+
+	*address1 = (base1 ? vcpu->run->s.regs.gprs[base1] : 0) + disp1;
+	*address2 = (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
+}
+
+static inline u64 kvm_s390_get_base_disp_rsy(struct kvm_vcpu *vcpu)
+{
+	int base2 = vcpu->arch.sie_block->ipb >> 28;
+	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16) +
+			((vcpu->arch.sie_block->ipb & 0xff00) << 4);
+
+	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
+}
+
+static inline u64 kvm_s390_get_base_disp_rs(struct kvm_vcpu *vcpu)
+{
+	int base2 = vcpu->arch.sie_block->ipb >> 28;
+	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
+
+	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
+}
+
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
 void kvm_s390_tasklet(unsigned long parm);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 1aeb933..d715842 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -24,17 +24,13 @@
 
 static int handle_set_prefix(struct kvm_vcpu *vcpu)
 {
-	int base2 = vcpu->arch.sie_block->ipb >> 28;
-	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
 	u64 operand2;
 	u32 address = 0;
 	u8 tmp;
 
 	vcpu->stat.instruction_spx++;
 
-	operand2 = disp2;
-	if (base2)
-		operand2 += vcpu->run->s.regs.gprs[base2];
+	operand2 = kvm_s390_get_base_disp_s(vcpu);
 
 	/* must be word boundary */
 	if (operand2 & 3) {
@@ -67,15 +63,12 @@ out:
 
 static int handle_store_prefix(struct kvm_vcpu *vcpu)
 {
-	int base2 = vcpu->arch.sie_block->ipb >> 28;
-	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
 	u64 operand2;
 	u32 address;
 
 	vcpu->stat.instruction_stpx++;
-	operand2 = disp2;
-	if (base2)
-		operand2 += vcpu->run->s.regs.gprs[base2];
+
+	operand2 = kvm_s390_get_base_disp_s(vcpu);
 
 	/* must be word boundary */
 	if (operand2 & 3) {
@@ -100,15 +93,12 @@ out:
 
 static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 {
-	int base2 = vcpu->arch.sie_block->ipb >> 28;
-	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
 	u64 useraddr;
 	int rc;
 
 	vcpu->stat.instruction_stap++;
-	useraddr = disp2;
-	if (base2)
-		useraddr += vcpu->run->s.regs.gprs[base2];
+
+	useraddr = kvm_s390_get_base_disp_s(vcpu);
 
 	if (useraddr & 1) {
 		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -178,15 +168,12 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 
 static int handle_stidp(struct kvm_vcpu *vcpu)
 {
-	int base2 = vcpu->arch.sie_block->ipb >> 28;
-	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
 	u64 operand2;
 	int rc;
 
 	vcpu->stat.instruction_stidp++;
-	operand2 = disp2;
-	if (base2)
-		operand2 += vcpu->run->s.regs.gprs[base2];
+
+	operand2 = kvm_s390_get_base_disp_s(vcpu);
 
 	if (operand2 & 7) {
 		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -240,17 +227,13 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	int fc = (vcpu->run->s.regs.gprs[0] & 0xf0000000) >> 28;
 	int sel1 = vcpu->run->s.regs.gprs[0] & 0xff;
 	int sel2 = vcpu->run->s.regs.gprs[1] & 0xffff;
-	int base2 = vcpu->arch.sie_block->ipb >> 28;
-	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
 	u64 operand2;
 	unsigned long mem;
 
 	vcpu->stat.instruction_stsi++;
 	VCPU_EVENT(vcpu, 4, "stsi: fc: %x sel1: %x sel2: %x", fc, sel1, sel2);
 
-	operand2 = disp2;
-	if (base2)
-		operand2 += vcpu->run->s.regs.gprs[base2];
+	operand2 = kvm_s390_get_base_disp_s(vcpu);
 
 	if (operand2 & 0xfff && fc > 0)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -335,17 +318,14 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
 
 static int handle_tprot(struct kvm_vcpu *vcpu)
 {
-	int base1 = (vcpu->arch.sie_block->ipb & 0xf0000000) >> 28;
-	int disp1 = (vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16;
-	int base2 = (vcpu->arch.sie_block->ipb & 0xf000) >> 12;
-	int disp2 = vcpu->arch.sie_block->ipb & 0x0fff;
-	u64 address1 = disp1 + base1 ? vcpu->run->s.regs.gprs[base1] : 0;
-	u64 address2 = disp2 + base2 ? vcpu->run->s.regs.gprs[base2] : 0;
+	u64 address1, address2;
 	struct vm_area_struct *vma;
 	unsigned long user_address;
 
 	vcpu->stat.instruction_tprot++;
 
+	kvm_s390_get_base_disp_sse(vcpu, &address1, &address2);
+
 	/* we only handle the Linux memory detection case:
 	 * access key == 0
 	 * guest DAT == off
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 566ddf6..461e841 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -324,8 +324,6 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 {
 	int r1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
 	int r3 = vcpu->arch.sie_block->ipa & 0x000f;
-	int base2 = vcpu->arch.sie_block->ipb >> 28;
-	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
 	u32 parameter;
 	u16 cpu_addr = vcpu->run->s.regs.gprs[r3];
 	u8 order_code;
@@ -336,9 +334,7 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu,
 						   PGM_PRIVILEGED_OPERATION);
 
-	order_code = disp2;
-	if (base2)
-		order_code += vcpu->run->s.regs.gprs[base2];
+	order_code = kvm_s390_get_base_disp_rs(vcpu);
 
 	if (r1 % 2)
 		parameter = vcpu->run->s.regs.gprs[r1];
-- 
1.7.12.4
