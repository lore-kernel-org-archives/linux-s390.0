From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 7/8] KVM: s390: refactor vcpu injection function
Date: Tue, 31 Mar 2015 15:02:02 +0200
Message-ID: <1427806923-21910-8-git-send-email-borntraeger@de.ibm.com>
References: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Let's provide a version of kvm_s390_inject_vcpu() that
does not acquire the local-interrupt lock and skips
waking up the vcpu.
To be used in a later patch for vcpu-local interrupt migration,
where we are already holding the lock.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index bc13194..2f78f1a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1514,12 +1514,10 @@ void kvm_s390_clear_stop_irq(struct kvm_vcpu *vcpu)
 	spin_unlock(&li->lock);
 }
 
-int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
+static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
-	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	int rc;
 
-	spin_lock(&li->lock);
 	switch (irq->type) {
 	case KVM_S390_PROGRAM_INT:
 		VCPU_EVENT(vcpu, 3, "inject: program check %d (from user)",
@@ -1559,6 +1557,17 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	default:
 		rc = -EINVAL;
 	}
+
+	return rc;
+}
+
+int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
+{
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	int rc;
+
+	spin_lock(&li->lock);
+	rc = do_inject_vcpu(vcpu, irq);
 	spin_unlock(&li->lock);
 	if (!rc)
 		kvm_s390_vcpu_wakeup(vcpu);
-- 
2.3.0
