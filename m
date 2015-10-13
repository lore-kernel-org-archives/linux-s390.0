From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/10] KVM: s390: drop out early in kvm_s390_has_irq()
Date: Tue, 13 Oct 2015 16:06:03 +0200
Message-ID: <1444745168-21479-6-git-send-email-borntraeger@de.ibm.com>
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

Let's get rid of the local variable and exit directly if we found
any pending interrupt. This is not only faster, but also better
readable.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1260f8c..10a0e8b 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -808,23 +808,21 @@ int kvm_s390_ext_call_pending(struct kvm_vcpu *vcpu)
 
 int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop)
 {
-	int rc;
+	if (deliverable_irqs(vcpu))
+		return 1;
 
-	rc = !!deliverable_irqs(vcpu);
-
-	if (!rc && kvm_cpu_has_pending_timer(vcpu))
-		rc = 1;
+	if (kvm_cpu_has_pending_timer(vcpu))
+		return 1;
 
 	/* external call pending and deliverable */
-	if (!rc && kvm_s390_ext_call_pending(vcpu) &&
+	if (kvm_s390_ext_call_pending(vcpu) &&
 	    !psw_extint_disabled(vcpu) &&
 	    (vcpu->arch.sie_block->gcr[0] & 0x2000ul))
-		rc = 1;
+		return 1;
 
-	if (!rc && !exclude_stop && kvm_s390_is_stop_irq_pending(vcpu))
-		rc = 1;
-
-	return rc;
+	if (!exclude_stop && kvm_s390_is_stop_irq_pending(vcpu))
+		return 1;
+	return 0;
 }
 
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
-- 
2.4.3
