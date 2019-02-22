From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 22 Feb 2019 11:42:27 +0000
Subject: [GIT PULL 16/18] KVM: s390: fix possible null pointer dereference in pending_irqs()
Message-Id: <1550835749-26436-17-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.ibm.com>

Assure a GISA is in use before accessing the IPM to avoid a
null pointer dereference issue.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reported-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190131085247.13826-16-mimu@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index dc44620..8216286 100644
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
2.7.4
