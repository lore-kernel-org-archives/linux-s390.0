From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/20] KVM: s390: reinjection of irqs can fail in the tpi handler
Date: Fri,  6 Mar 2015 14:16:40 +0100
Message-ID: <1425647812-61838-9-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <dahi@linux.vnet.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, 3.16+@tuxmaker.boeblingen.de.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

The reinjection of an I/O interrupt can fail if the list is at the limit
and between the dequeue and the reinjection, another I/O interrupt is
injected (e.g. if user space floods kvm with I/O interrupts).

This patch avoids this memory leak and returns -EFAULT in this special
case. This error is not recoverable, so let's fail hard. This can later
be avoided by not dequeuing the interrupt but working directly on the
locked list.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # 3.16+
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 4 ++--
 arch/s390/kvm/kvm-s390.h  | 4 ++--
 arch/s390/kvm/priv.c      | 5 ++++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 073b5f3..e7a46e8 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1332,10 +1332,10 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 	return rc;
 }
 
-void kvm_s390_reinject_io_int(struct kvm *kvm,
+int kvm_s390_reinject_io_int(struct kvm *kvm,
 			      struct kvm_s390_interrupt_info *inti)
 {
-	__inject_vm(kvm, inti);
+	return __inject_vm(kvm, inti);
 }
 
 int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index c34109a..6995a30 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -151,8 +151,8 @@ int __must_check kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 int __must_check kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code);
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 						    u64 cr6, u64 schid);
-void kvm_s390_reinject_io_int(struct kvm *kvm,
-			      struct kvm_s390_interrupt_info *inti);
+int kvm_s390_reinject_io_int(struct kvm *kvm,
+			     struct kvm_s390_interrupt_info *inti);
 int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked);
 
 /* implemented in intercept.c */
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index be7138e..b982fbc 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -279,7 +279,10 @@ reinject_interrupt:
 	 * instruction is suppressed from the guest's view: reinject the
 	 * interrupt.
 	 */
-	kvm_s390_reinject_io_int(vcpu->kvm, inti);
+	if (kvm_s390_reinject_io_int(vcpu->kvm, inti)) {
+		kfree(inti);
+		rc = -EFAULT;
+	}
 	/* don't set the cc, a pgm irq was injected or we drop to user space */
 	return rc ? -EFAULT : 0;
 }
-- 
2.3.0
