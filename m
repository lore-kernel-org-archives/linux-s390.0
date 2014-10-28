From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 8/9] KVM: s390: sigp: inject emergency calls in a separate function
Date: Tue, 28 Oct 2014 20:39:58 +0100
Message-ID: <1414525199-53989-9-git-send-email-borntraeger@de.ibm.com>
References: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

In preparation for further code changes, this patch moves the injection of
emergency calls into a separate function and uses it for the processing of
SIGP EMERGENCY CALL and SIGP CONDITIONAL EMERGENCY CALL.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/sigp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 9ee63e4..1b330d4 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -46,7 +46,8 @@ static int __sigp_sense(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
 	return rc;
 }
 
-static int __sigp_emergency(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu)
+static int __inject_sigp_emergency(struct kvm_vcpu *vcpu,
+				    struct kvm_vcpu *dst_vcpu)
 {
 	struct kvm_s390_interrupt s390int = {
 		.type = KVM_S390_INT_EMERGENCY,
@@ -62,6 +63,11 @@ static int __sigp_emergency(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu)
 	return rc ? rc : SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
+static int __sigp_emergency(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu)
+{
+	return __inject_sigp_emergency(vcpu, dst_vcpu);
+}
+
 static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu,
 					struct kvm_vcpu *dst_vcpu,
 					u16 asn, u64 *reg)
@@ -76,12 +82,12 @@ static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu,
 	p_asn = dst_vcpu->arch.sie_block->gcr[4] & 0xffff;  /* Primary ASN */
 	s_asn = dst_vcpu->arch.sie_block->gcr[3] & 0xffff;  /* Secondary ASN */
 
-	/* Deliver the emergency signal? */
+	/* Inject the emergency signal? */
 	if (!(flags & CPUSTAT_STOPPED)
 	    || (psw->mask & psw_int_mask) != psw_int_mask
 	    || ((flags & CPUSTAT_WAIT) && psw->addr != 0)
 	    || (!(flags & CPUSTAT_WAIT) && (asn == p_asn || asn == s_asn))) {
-		return __sigp_emergency(vcpu, dst_vcpu);
+		return __inject_sigp_emergency(vcpu, dst_vcpu);
 	} else {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INCORRECT_STATE;
-- 
1.9.3
