From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 19/21] KVM: s390: trace correct values for set prefix and machine checks
Date: Thu, 15 Jan 2015 14:43:32 +0100
Message-ID: <1421329414-76826-20-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

When injecting SIGP set prefix or a machine check, we trace
the values in our per-vcpu local_int data structure instead
of the parameters passed to the function.

Fix this by changing the trace statement to use the correct values.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index eb5fb66..a6cb238 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1049,9 +1049,9 @@ static int __inject_set_prefix(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	struct kvm_s390_prefix_info *prefix = &li->irq.prefix;
 
 	VCPU_EVENT(vcpu, 3, "inject: set prefix to %x (from user)",
-		   prefix->address);
+		   irq->u.prefix.address);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_SIGP_SET_PREFIX,
-				   prefix->address, 0, 2);
+				   irq->u.prefix.address, 0, 2);
 
 	if (!is_vcpu_stopped(vcpu))
 		return -EBUSY;
@@ -1121,9 +1121,9 @@ static int __inject_mchk(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	struct kvm_s390_mchk_info *mchk = &li->irq.mchk;
 
 	VCPU_EVENT(vcpu, 5, "inject: machine check parm64:%llx",
-		   mchk->mcic);
+		   irq->u.mchk.mcic);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_MCHK, 0,
-				   mchk->mcic, 2);
+				   irq->u.mchk.mcic, 2);
 
 	/*
 	 * Because repressible machine checks can be indicated along with
-- 
1.9.3
