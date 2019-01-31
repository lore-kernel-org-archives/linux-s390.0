From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v7 15/15] KVM: s390: fix possible null pointer dereference in pending_irqs()
Date: Thu, 31 Jan 2019 09:52:46 +0100
Message-ID: <20190131085247.13826-16-mimu@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131085247.13826-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Assure a GISA is in use before accessing the IPM to avoid a
null pointer dereference issue.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reported-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index d322400ca587..660ec87b6e60 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -329,9 +329,13 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
 
 static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
 {
-	return pending_irqs_no_gisa(vcpu) |
-		gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<
-			IRQ_PEND_IO_ISC_7;
+	struct kvm_s390_gisa_interrupt *gi = &vcpu->kvm->arch.gisa_int;
+	unsigned long pending_mask;
+
+	pending_mask = pending_irqs_no_gisa(vcpu);
+	if (gi->origin)
+		pending_mask |= gisa_get_ipm(gi->origin) << IRQ_PEND_IO_ISC_7;
+	return pending_mask;
 }
 
 static inline int isc_to_irq_type(unsigned long isc)
-- 
2.13.4
