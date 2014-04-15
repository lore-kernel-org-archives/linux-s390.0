From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 21/47] KVM: s390: convert __sigp_set_prefix()/handle_set_prefix()
Date: Tue, 15 Apr 2014 14:00:24 +0200
Message-ID: <1397563250-3089-22-git-send-email-borntraeger@de.ibm.com>
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

Convert __sigp_set_prefix() and handle_set_prefix() to new guest
access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 20 ++++++++++++--------
 arch/s390/kvm/sigp.c | 12 +++++++-----
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 7066fc5..dd6ad84 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -65,8 +65,8 @@ static int handle_set_clock(struct kvm_vcpu *vcpu)
 static int handle_set_prefix(struct kvm_vcpu *vcpu)
 {
 	u64 operand2;
-	u32 address = 0;
-	u8 tmp;
+	u32 address;
+	int rc;
 
 	vcpu->stat.instruction_spx++;
 
@@ -80,14 +80,18 @@ static int handle_set_prefix(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	/* get the value */
-	if (get_guest(vcpu, address, (u32 __user *) operand2))
-		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	rc = read_guest(vcpu, operand2, &address, sizeof(address));
+	if (rc)
+		return kvm_s390_inject_prog_cond(vcpu, rc);
 
-	address = address & 0x7fffe000u;
+	address &= 0x7fffe000u;
 
-	/* make sure that the new value is valid memory */
-	if (copy_from_guest_absolute(vcpu, &tmp, address, 1) ||
-	   (copy_from_guest_absolute(vcpu, &tmp, address + PAGE_SIZE, 1)))
+	/*
+	 * Make sure the new value is valid memory. We only need to check the
+	 * first page, since address is 8k aligned and memory pieces are always
+	 * at least 1MB aligned and have at least a size of 1MB.
+	 */
+	if (kvm_is_error_gpa(vcpu->kvm, address))
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 	kvm_s390_set_prefix(vcpu, address);
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 26caeb5..c0b99e0 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -235,7 +235,6 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 	struct kvm_vcpu *dst_vcpu = NULL;
 	struct kvm_s390_interrupt_info *inti;
 	int rc;
-	u8 tmp;
 
 	if (cpu_addr < KVM_MAX_VCPUS)
 		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
@@ -243,10 +242,13 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 		return SIGP_CC_NOT_OPERATIONAL;
 	li = &dst_vcpu->arch.local_int;
 
-	/* make sure that the new value is valid memory */
-	address = address & 0x7fffe000u;
-	if (copy_from_guest_absolute(vcpu, &tmp, address, 1) ||
-	   copy_from_guest_absolute(vcpu, &tmp, address + PAGE_SIZE, 1)) {
+	/*
+	 * Make sure the new value is valid memory. We only need to check the
+	 * first page, since address is 8k aligned and memory pieces are always
+	 * at least 1MB aligned and have at least a size of 1MB.
+	 */
+	address &= 0x7fffe000u;
+	if (kvm_is_error_gpa(vcpu->kvm, address)) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INVALID_PARAMETER;
 		return SIGP_CC_STATUS_STORED;
-- 
1.8.4.2
