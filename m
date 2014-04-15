From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 30/47] KVM: s390: convert handle lctl[g]()
Date: Tue, 15 Apr 2014 14:00:33 +0200
Message-ID: <1397563250-3089-31-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Convert handle lctl[g]() to new guest access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index bc96972..44ff220 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -755,32 +755,31 @@ int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu)
 {
 	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
 	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
-	u64 useraddr;
 	u32 val = 0;
 	int reg, rc;
+	u64 ga;
 
 	vcpu->stat.instruction_lctl++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	useraddr = kvm_s390_get_base_disp_rs(vcpu);
+	ga = kvm_s390_get_base_disp_rs(vcpu);
 
-	if (useraddr & 3)
+	if (ga & 3)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	VCPU_EVENT(vcpu, 5, "lctl r1:%x, r3:%x, addr:%llx", reg1, reg3,
-		   useraddr);
-	trace_kvm_s390_handle_lctl(vcpu, 0, reg1, reg3, useraddr);
+	VCPU_EVENT(vcpu, 5, "lctl r1:%x, r3:%x, addr:%llx", reg1, reg3, ga);
+	trace_kvm_s390_handle_lctl(vcpu, 0, reg1, reg3, ga);
 
 	reg = reg1;
 	do {
-		rc = get_guest(vcpu, val, (u32 __user *) useraddr);
+		rc = read_guest(vcpu, ga, &val, sizeof(val));
 		if (rc)
-			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+			return kvm_s390_inject_prog_cond(vcpu, rc);
 		vcpu->arch.sie_block->gcr[reg] &= 0xffffffff00000000ul;
 		vcpu->arch.sie_block->gcr[reg] |= val;
-		useraddr += 4;
+		ga += 4;
 		if (reg == reg3)
 			break;
 		reg = (reg + 1) % 16;
@@ -793,7 +792,7 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 {
 	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
 	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
-	u64 useraddr;
+	u64 ga, val;
 	int reg, rc;
 
 	vcpu->stat.instruction_lctlg++;
@@ -801,23 +800,22 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	useraddr = kvm_s390_get_base_disp_rsy(vcpu);
+	ga = kvm_s390_get_base_disp_rsy(vcpu);
 
-	if (useraddr & 7)
+	if (ga & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	reg = reg1;
 
-	VCPU_EVENT(vcpu, 5, "lctlg r1:%x, r3:%x, addr:%llx", reg1, reg3,
-		   useraddr);
-	trace_kvm_s390_handle_lctl(vcpu, 1, reg1, reg3, useraddr);
+	VCPU_EVENT(vcpu, 5, "lctlg r1:%x, r3:%x, addr:%llx", reg1, reg3, ga);
+	trace_kvm_s390_handle_lctl(vcpu, 1, reg1, reg3, ga);
 
 	do {
-		rc = get_guest(vcpu, vcpu->arch.sie_block->gcr[reg],
-			       (u64 __user *) useraddr);
+		rc = read_guest(vcpu, ga, &val, sizeof(val));
 		if (rc)
-			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		useraddr += 8;
+			return kvm_s390_inject_prog_cond(vcpu, rc);
+		vcpu->arch.sie_block->gcr[reg] = val;
+		ga += 8;
 		if (reg == reg3)
 			break;
 		reg = (reg + 1) % 16;
-- 
1.8.4.2
