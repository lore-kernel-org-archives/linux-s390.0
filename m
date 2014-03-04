From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 4/8] KVM: s390: Fixed CC of SIGP SET_PREFIX handler
Date: Tue,  4 Mar 2014 12:27:14 +0100
Message-ID: <1393932438-58848-5-git-send-email-borntraeger@de.ibm.com>
References: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

When SIGP SET_PREFIX is called with an illegal CPU id, it must return
the condition code 3 ("not operational") instead of 1. Also fixed the
order in which the checks are done - CC3 has a higher priority than CC1.
And while we're at it, this patch also get rid of the floating interrupt
lock here by using kvm_get_vcpu() to get the local_int struct of the
destination CPU.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/sigp.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index fe9442d..466eefa 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -249,12 +249,18 @@ static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter)
 static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 			     u64 *reg)
 {
-	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
-	struct kvm_s390_local_interrupt *li = NULL;
+	struct kvm_s390_local_interrupt *li;
+	struct kvm_vcpu *dst_vcpu = NULL;
 	struct kvm_s390_interrupt_info *inti;
 	int rc;
 	u8 tmp;
 
+	if (cpu_addr < KVM_MAX_VCPUS)
+		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
+	if (!dst_vcpu)
+		return SIGP_CC_NOT_OPERATIONAL;
+	li = &dst_vcpu->arch.local_int;
+
 	/* make sure that the new value is valid memory */
 	address = address & 0x7fffe000u;
 	if (copy_from_guest_absolute(vcpu, &tmp, address, 1) ||
@@ -268,18 +274,6 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 	if (!inti)
 		return SIGP_CC_BUSY;
 
-	spin_lock(&fi->lock);
-	if (cpu_addr < KVM_MAX_VCPUS)
-		li = fi->local_int[cpu_addr];
-
-	if (li == NULL) {
-		*reg &= 0xffffffff00000000UL;
-		*reg |= SIGP_STATUS_INCORRECT_STATE;
-		rc = SIGP_CC_STATUS_STORED;
-		kfree(inti);
-		goto out_fi;
-	}
-
 	spin_lock_bh(&li->lock);
 	/* cpu must be in stopped state */
 	if (!(atomic_read(li->cpuflags) & CPUSTAT_STOPPED)) {
@@ -302,8 +296,6 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 	VCPU_EVENT(vcpu, 4, "set prefix of cpu %02x to %x", cpu_addr, address);
 out_li:
 	spin_unlock_bh(&li->lock);
-out_fi:
-	spin_unlock(&fi->lock);
 	return rc;
 }
 
-- 
1.8.4.2
