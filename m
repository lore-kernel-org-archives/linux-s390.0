From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 3/5] KVM: s390: In-kernel handling of I/O instructions.
Date: Wed, 31 Oct 2012 17:24:36 +0100
Message-ID: <1351700678-41969-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1351700678-41969-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1351700678-41969-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Explicitely catch all channel I/O related instructions intercepts
in the kernel and set condition code 3 for them.

This paws the way for properly handling these instructions later
on.

Note: This is not architecture compliant (the previous code wasn't
either) since setting cc 3 is not the correct thing to do for some
of these instructions. For Linux guests, however, it still has the
intended effect of stopping css probing.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 19 +++++++++++++---
 arch/s390/kvm/kvm-s390.h  |  1 +
 arch/s390/kvm/priv.c      | 56 +++++++++++++++++++++++++++++++++--------------
 3 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index ec1177f..754dc9e 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -33,8 +33,6 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 	int reg, rc;
 
 	vcpu->stat.instruction_lctlg++;
-	if ((vcpu->arch.sie_block->ipb & 0xff) != 0x2f)
-		return -EOPNOTSUPP;
 
 	useraddr = disp2;
 	if (base2)
@@ -104,6 +102,21 @@ static int handle_lctl(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static intercept_handler_t eb_handlers[256] = {
+	[0x2f] = handle_lctlg,
+	[0x8a] = kvm_s390_handle_priv_eb,
+};
+
+static int handle_eb(struct kvm_vcpu *vcpu)
+{
+	intercept_handler_t handler;
+
+	handler = eb_handlers[vcpu->arch.sie_block->ipb & 0xff];
+	if (handler)
+		return handler(vcpu);
+	return -EOPNOTSUPP;
+}
+
 static intercept_handler_t instruction_handlers[256] = {
 	[0x01] = kvm_s390_handle_01,
 	[0x82] = kvm_s390_handle_lpsw,
@@ -113,7 +126,7 @@ static intercept_handler_t instruction_handlers[256] = {
 	[0xb7] = handle_lctl,
 	[0xb9] = kvm_s390_handle_b9,
 	[0xe5] = kvm_s390_handle_e5,
-	[0xeb] = handle_lctlg,
+	[0xeb] = handle_eb,
 };
 
 static int handle_noop(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index b1e1cb6..7f50229 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -83,6 +83,7 @@ int kvm_s390_handle_e5(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_01(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_b9(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu);
+int kvm_s390_handle_priv_eb(struct kvm_vcpu *vcpu);
 
 /* implemented in sigp.c */
 int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index bf13ce9..2aba96b 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -135,20 +135,9 @@ static int handle_skey(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int handle_stsch(struct kvm_vcpu *vcpu)
+static int handle_io_inst(struct kvm_vcpu *vcpu)
 {
-	vcpu->stat.instruction_stsch++;
-	VCPU_EVENT(vcpu, 4, "%s", "store subchannel - CC3");
-	/* condition code 3 */
-	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
-	vcpu->arch.sie_block->gpsw.mask |= (3 & 3ul) << 44;
-	return 0;
-}
-
-static int handle_chsc(struct kvm_vcpu *vcpu)
-{
-	vcpu->stat.instruction_chsc++;
-	VCPU_EVENT(vcpu, 4, "%s", "channel subsystem call - CC3");
+	VCPU_EVENT(vcpu, 4, "%s", "I/O instruction");
 	/* condition code 3 */
 	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
 	vcpu->arch.sie_block->gpsw.mask |= (3 & 3ul) << 44;
@@ -392,7 +381,7 @@ out_fail:
 	return 0;
 }
 
-static intercept_handler_t priv_handlers[256] = {
+static intercept_handler_t b2_handlers[256] = {
 	[0x02] = handle_stidp,
 	[0x10] = handle_set_prefix,
 	[0x11] = handle_store_prefix,
@@ -400,8 +389,22 @@ static intercept_handler_t priv_handlers[256] = {
 	[0x29] = handle_skey,
 	[0x2a] = handle_skey,
 	[0x2b] = handle_skey,
-	[0x34] = handle_stsch,
-	[0x5f] = handle_chsc,
+	[0x30] = handle_io_inst,
+	[0x31] = handle_io_inst,
+	[0x32] = handle_io_inst,
+	[0x33] = handle_io_inst,
+	[0x34] = handle_io_inst,
+	[0x35] = handle_io_inst,
+	[0x36] = handle_io_inst,
+	[0x37] = handle_io_inst,
+	[0x38] = handle_io_inst,
+	[0x39] = handle_io_inst,
+	[0x3a] = handle_io_inst,
+	[0x3b] = handle_io_inst,
+	[0x3c] = handle_io_inst,
+	[0x5f] = handle_io_inst,
+	[0x74] = handle_io_inst,
+	[0x76] = handle_io_inst,
 	[0x7d] = handle_stsi,
 	[0xb1] = handle_stfl,
 	[0xb2] = handle_lpswe,
@@ -418,7 +421,7 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
 	 * state bit and (a) handle the instruction or (b) send a code 2
 	 * program check.
 	 * Anything else goes to userspace.*/
-	handler = priv_handlers[vcpu->arch.sie_block->ipa & 0x00ff];
+	handler = b2_handlers[vcpu->arch.sie_block->ipa & 0x00ff];
 	if (handler) {
 		if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 			return kvm_s390_inject_program_int(vcpu,
@@ -447,6 +450,7 @@ static int handle_epsw(struct kvm_vcpu *vcpu)
 
 static intercept_handler_t b9_handlers[256] = {
 	[0x8d] = handle_epsw,
+	[0x9c] = handle_io_inst,
 };
 
 int kvm_s390_handle_b9(struct kvm_vcpu *vcpu)
@@ -466,6 +470,24 @@ int kvm_s390_handle_b9(struct kvm_vcpu *vcpu)
 	return -EOPNOTSUPP;
 }
 
+static intercept_handler_t eb_handlers[256] = {
+	[0x8a] = handle_io_inst,
+};
+
+int kvm_s390_handle_priv_eb(struct kvm_vcpu *vcpu)
+{
+	intercept_handler_t handler;
+
+	/* All eb instructions that end up here are privileged. */
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu,
+						   PGM_PRIVILEGED_OPERATION);
+	handler = eb_handlers[vcpu->arch.sie_block->ipb & 0xff];
+	if (handler)
+		return handler(vcpu);
+	return -EOPNOTSUPP;
+}
+
 static int handle_tprot(struct kvm_vcpu *vcpu)
 {
 	int base1 = (vcpu->arch.sie_block->ipb & 0xf0000000) >> 28;
-- 
1.7.12.4
