From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/11] KVM: s390: allow injecting all kinds of machine checks
Date: Fri, 28 Nov 2014 14:25:39 +0100
Message-ID: <1417181139-25623-12-git-send-email-borntraeger@de.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Allow to specify CR14, logout area, external damage code
and failed storage address.

Since more then one machine check can be indicated to the guest at
a time we need to combine all indication bits with already pending
requests.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1aa7f28..b3d4409 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1063,11 +1063,19 @@ static int __inject_mchk(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 				   mchk->mcic, 2);
 
 	/*
-	 * Combine mcic with previously injected machine checks and
-	 * indicate them all together as described in the Principles
-	 * of Operation, Chapter 11, Interruption action
+	 * Because repressible machine checks can be indicated along with
+	 * exigent machine checks (PoP, Chapter 11, Interruption action)
+	 * we need to combine cr14, mcic and external damage code.
+	 * Failing storage address and the logout area should not be or'ed
+	 * together, we just indicate the last occurrence of the corresponding
+	 * machine check
 	 */
+	mchk->cr14 |= irq->u.mchk.cr14;
 	mchk->mcic |= irq->u.mchk.mcic;
+	mchk->ext_damage_code |= irq->u.mchk.ext_damage_code;
+	mchk->failing_storage_address = irq->u.mchk.failing_storage_address;
+	memcpy(&mchk->fixed_logout, &irq->u.mchk.fixed_logout,
+	       sizeof(mchk->fixed_logout));
 	if (mchk->mcic & MCHK_EX_MASK)
 		set_bit(IRQ_PEND_MCHK_EX, &li->pending_irqs);
 	else if (mchk->mcic & MCHK_REP_MASK)
-- 
1.9.3
