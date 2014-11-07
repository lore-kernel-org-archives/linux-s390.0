From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/4] KVM: s390: fix handling of lctl[g]/stctl[g]
Date: Fri,  7 Nov 2014 12:45:15 +0100
Message-ID: <1415360716-9670-4-git-send-email-borntraeger@de.ibm.com>
References: <1415360716-9670-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1415360716-9670-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

According to the architecture all instructions are suppressing if memory
access is prohibited due to DAT protection, unless stated otherwise for
an instruction.
The lctl[g]/stctl[g] implementations handled this incorrectly since
control register handling was done piecemeal, which means they had
terminating instead of suppressing semantics.
This patch fixes this.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 68 +++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9c565b6..9bde32f 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -762,8 +762,8 @@ int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu)
 {
 	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
 	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
-	u32 val = 0;
-	int reg, rc;
+	int reg, rc, nr_regs;
+	u32 ctl_array[16];
 	u64 ga;
 
 	vcpu->stat.instruction_lctl++;
@@ -779,14 +779,15 @@ int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu)
 	VCPU_EVENT(vcpu, 5, "lctl r1:%x, r3:%x, addr:%llx", reg1, reg3, ga);
 	trace_kvm_s390_handle_lctl(vcpu, 0, reg1, reg3, ga);
 
+	nr_regs = ((reg3 - reg1) & 0xf) + 1;
+	rc = read_guest(vcpu, ga, ctl_array, nr_regs * sizeof(u32));
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
 	reg = reg1;
+	nr_regs = 0;
 	do {
-		rc = read_guest(vcpu, ga, &val, sizeof(val));
-		if (rc)
-			return kvm_s390_inject_prog_cond(vcpu, rc);
 		vcpu->arch.sie_block->gcr[reg] &= 0xffffffff00000000ul;
-		vcpu->arch.sie_block->gcr[reg] |= val;
-		ga += 4;
+		vcpu->arch.sie_block->gcr[reg] |= ctl_array[nr_regs++];
 		if (reg == reg3)
 			break;
 		reg = (reg + 1) % 16;
@@ -799,9 +800,9 @@ int kvm_s390_handle_stctl(struct kvm_vcpu *vcpu)
 {
 	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
 	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
+	int reg, rc, nr_regs;
+	u32 ctl_array[16];
 	u64 ga;
-	u32 val;
-	int reg, rc;
 
 	vcpu->stat.instruction_stctl++;
 
@@ -817,26 +818,24 @@ int kvm_s390_handle_stctl(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_handle_stctl(vcpu, 0, reg1, reg3, ga);
 
 	reg = reg1;
+	nr_regs = 0;
 	do {
-		val = vcpu->arch.sie_block->gcr[reg] &  0x00000000fffffffful;
-		rc = write_guest(vcpu, ga, &val, sizeof(val));
-		if (rc)
-			return kvm_s390_inject_prog_cond(vcpu, rc);
-		ga += 4;
+		ctl_array[nr_regs++] = vcpu->arch.sie_block->gcr[reg];
 		if (reg == reg3)
 			break;
 		reg = (reg + 1) % 16;
 	} while (1);
-
-	return 0;
+	rc = write_guest(vcpu, ga, ctl_array, nr_regs * sizeof(u32));
+	return rc ? kvm_s390_inject_prog_cond(vcpu, rc) : 0;
 }
 
 static int handle_lctlg(struct kvm_vcpu *vcpu)
 {
 	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
 	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
-	u64 ga, val;
-	int reg, rc;
+	int reg, rc, nr_regs;
+	u64 ctl_array[16];
+	u64 ga;
 
 	vcpu->stat.instruction_lctlg++;
 
@@ -848,17 +847,17 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 	if (ga & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	reg = reg1;
-
 	VCPU_EVENT(vcpu, 5, "lctlg r1:%x, r3:%x, addr:%llx", reg1, reg3, ga);
 	trace_kvm_s390_handle_lctl(vcpu, 1, reg1, reg3, ga);
 
+	nr_regs = ((reg3 - reg1) & 0xf) + 1;
+	rc = read_guest(vcpu, ga, ctl_array, nr_regs * sizeof(u64));
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
+	reg = reg1;
+	nr_regs = 0;
 	do {
-		rc = read_guest(vcpu, ga, &val, sizeof(val));
-		if (rc)
-			return kvm_s390_inject_prog_cond(vcpu, rc);
-		vcpu->arch.sie_block->gcr[reg] = val;
-		ga += 8;
+		vcpu->arch.sie_block->gcr[reg] = ctl_array[nr_regs++];
 		if (reg == reg3)
 			break;
 		reg = (reg + 1) % 16;
@@ -871,8 +870,9 @@ static int handle_stctg(struct kvm_vcpu *vcpu)
 {
 	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
 	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
-	u64 ga, val;
-	int reg, rc;
+	int reg, rc, nr_regs;
+	u64 ctl_array[16];
+	u64 ga;
 
 	vcpu->stat.instruction_stctg++;
 
@@ -884,23 +884,19 @@ static int handle_stctg(struct kvm_vcpu *vcpu)
 	if (ga & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	reg = reg1;
-
 	VCPU_EVENT(vcpu, 5, "stctg r1:%x, r3:%x, addr:%llx", reg1, reg3, ga);
 	trace_kvm_s390_handle_stctl(vcpu, 1, reg1, reg3, ga);
 
+	reg = reg1;
+	nr_regs = 0;
 	do {
-		val = vcpu->arch.sie_block->gcr[reg];
-		rc = write_guest(vcpu, ga, &val, sizeof(val));
-		if (rc)
-			return kvm_s390_inject_prog_cond(vcpu, rc);
-		ga += 8;
+		ctl_array[nr_regs++] = vcpu->arch.sie_block->gcr[reg];
 		if (reg == reg3)
 			break;
 		reg = (reg + 1) % 16;
 	} while (1);
-
-	return 0;
+	rc = write_guest(vcpu, ga, ctl_array, nr_regs * sizeof(u64));
+	return rc ? kvm_s390_inject_prog_cond(vcpu, rc) : 0;
 }
 
 static const intercept_handler_t eb_handlers[256] = {
-- 
1.9.3
