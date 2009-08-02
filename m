From: Roel Kluin <roel.kluin@gmail.com>
Date: Sun, 02 Aug 2009 14:08:32 +0000
Subject: [PATCH] KVM: Read buffer overflow
Message-Id: <4A759DE0.8000207@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Check whether index is within bounds before testing the element.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 3667883..0ef81d6 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -169,7 +169,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 			     unsigned long *reg)
 {
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
-	struct kvm_s390_local_interrupt *li;
+	struct kvm_s390_local_interrupt *li = NULL;
 	struct kvm_s390_interrupt_info *inti;
 	int rc;
 	u8 tmp;
@@ -189,9 +189,10 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 		return 2; /* busy */
 
 	spin_lock(&fi->lock);
-	li = fi->local_int[cpu_addr];
+	if (cpu_addr < KVM_MAX_VCPUS)
+		li = fi->local_int[cpu_addr];
 
-	if ((cpu_addr >= KVM_MAX_VCPUS) || (li == NULL)) {
+	if (li == NULL) {
 		rc = 1; /* incorrect state */
 		*reg &= SIGP_STAT_INCORRECT_STATE;
 		kfree(inti);
