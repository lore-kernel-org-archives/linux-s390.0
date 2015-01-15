From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 16/21] KVM: s390: no need to hold the kvm->mutex for floating interrupts
Date: Thu, 15 Jan 2015 14:43:29 +0100
Message-ID: <1421329414-76826-17-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The kvm mutex was (probably) used to protect against cpu hotplug.
The current code no longer needs to protect against that, as we only
rely on CPU data structures that are guaranteed to be available
if we can access the CPU. (e.g. vcpu_create will put the cpu
in the array AFTER the cpu is ready).

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
---
 arch/s390/kvm/interrupt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 0ad1f75..8ebae29 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1182,7 +1182,6 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 
 	if ((!schid && !cr6) || (schid && cr6))
 		return NULL;
-	mutex_lock(&kvm->lock);
 	fi = &kvm->arch.float_int;
 	spin_lock(&fi->lock);
 	inti = NULL;
@@ -1210,7 +1209,6 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 	if (list_empty(&fi->list))
 		atomic_set(&fi->active, 0);
 	spin_unlock(&fi->lock);
-	mutex_unlock(&kvm->lock);
 	return inti;
 }
 
@@ -1223,7 +1221,6 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	int sigcpu;
 	int rc = 0;
 
-	mutex_lock(&kvm->lock);
 	fi = &kvm->arch.float_int;
 	spin_lock(&fi->lock);
 	if (fi->irq_count >= KVM_S390_MAX_FLOAT_IRQS) {
@@ -1274,7 +1271,6 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	kvm_s390_vcpu_wakeup(kvm_get_vcpu(kvm, sigcpu));
 unlock_fi:
 	spin_unlock(&fi->lock);
-	mutex_unlock(&kvm->lock);
 	return rc;
 }
 
@@ -1444,7 +1440,6 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 	struct kvm_s390_float_interrupt *fi;
 	struct kvm_s390_interrupt_info	*n, *inti = NULL;
 
-	mutex_lock(&kvm->lock);
 	fi = &kvm->arch.float_int;
 	spin_lock(&fi->lock);
 	list_for_each_entry_safe(inti, n, &fi->list, list) {
@@ -1454,7 +1449,6 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 	fi->irq_count = 0;
 	atomic_set(&fi->active, 0);
 	spin_unlock(&fi->lock);
-	mutex_unlock(&kvm->lock);
 }
 
 static inline int copy_irq_to_user(struct kvm_s390_interrupt_info *inti,
@@ -1494,7 +1488,6 @@ static int get_all_floating_irqs(struct kvm *kvm, __u8 *buf, __u64 len)
 	int ret = 0;
 	int n = 0;
 
-	mutex_lock(&kvm->lock);
 	fi = &kvm->arch.float_int;
 	spin_lock(&fi->lock);
 
@@ -1513,7 +1506,6 @@ static int get_all_floating_irqs(struct kvm *kvm, __u8 *buf, __u64 len)
 	}
 
 	spin_unlock(&fi->lock);
-	mutex_unlock(&kvm->lock);
 
 	return ret < 0 ? ret : n;
 }
-- 
1.9.3
