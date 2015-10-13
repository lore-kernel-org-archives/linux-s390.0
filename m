From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/10] KVM: s390: correctly handle injection of pgm irqs and per events
Date: Tue, 13 Oct 2015 16:06:05 +0200
Message-ID: <1444745168-21479-8-git-send-email-borntraeger@de.ibm.com>
References: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

PER events can always co-exist with other program interrupts.

For now, we always overwrite all program interrupt parameters when
injecting any type of program interrupt.

Let's handle that correctly by only overwriting the relevant portion of
the program interrupt parameters. Therefore we can now inject PER events
and ordinary program interrupts concurrently, resulting in no loss of
program interrupts. This will especially by helpful when manually detecting
PER events later - as both types might be triggered during one SIE exit.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index f603bac..a8be542 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -972,7 +972,26 @@ static int __inject_prog(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
 				   irq->u.pgm.code, 0);
 
-	li->irq.pgm = irq->u.pgm;
+	if (irq->u.pgm.code == PGM_PER) {
+		li->irq.pgm.code |= PGM_PER;
+		/* only modify PER related information */
+		li->irq.pgm.per_address = irq->u.pgm.per_address;
+		li->irq.pgm.per_code = irq->u.pgm.per_code;
+		li->irq.pgm.per_atmid = irq->u.pgm.per_atmid;
+		li->irq.pgm.per_access_id = irq->u.pgm.per_access_id;
+	} else if (!(irq->u.pgm.code & PGM_PER)) {
+		li->irq.pgm.code = (li->irq.pgm.code & PGM_PER) |
+				   irq->u.pgm.code;
+		/* only modify non-PER information */
+		li->irq.pgm.trans_exc_code = irq->u.pgm.trans_exc_code;
+		li->irq.pgm.mon_code = irq->u.pgm.mon_code;
+		li->irq.pgm.data_exc_code = irq->u.pgm.data_exc_code;
+		li->irq.pgm.mon_class_nr = irq->u.pgm.mon_class_nr;
+		li->irq.pgm.exc_access_id = irq->u.pgm.exc_access_id;
+		li->irq.pgm.op_access_id = irq->u.pgm.op_access_id;
+	} else {
+		li->irq.pgm = irq->u.pgm;
+	}
 	set_bit(IRQ_PEND_PROG, &li->pending_irqs);
 	return 0;
 }
-- 
2.4.3
