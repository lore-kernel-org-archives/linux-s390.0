From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/9] KVM: s390: fix external call injection without sigp interpretation
Date: Mon, 11 May 2015 10:44:29 +0200
Message-ID: <1431333877-28700-2-git-send-email-borntraeger@de.ibm.com>
References: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, v4.0@tuxmaker.boeblingen.de.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Commit ea5f49692575 ("KVM: s390: only one external call may be pending
at a time") introduced a bug on machines that don't have SIGP
interpretation facility installed.
The injection of an external call will now always fail with -EBUSY
(if none is already pending).

This leads to the following symptoms:
- An external call will be injected but with the wrong "src cpu id",
  as this id will not be remembered.
- The target vcpu will not be woken up, therefore the guest will hang if
  it cannot deal with unexpected failures of the SIGP EXTERNAL CALL
  instruction.
- If an external call is already pending, -EBUSY will not be reported.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # v4.0
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9de4726..2836b25 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1061,7 +1061,7 @@ static int __inject_extcall(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	if (sclp_has_sigpif())
 		return __inject_extcall_sigpif(vcpu, src_id);
 
-	if (!test_and_set_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs))
+	if (test_and_set_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs))
 		return -EBUSY;
 	*extcall = irq->u.extcall;
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
-- 
2.3.0
