From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 3/8] KVM: s390: limit floating irqs
Date: Thu, 30 Jan 2014 13:53:44 +0100
Message-ID: <1391086429-43935-4-git-send-email-borntraeger@de.ibm.com>
References: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Userspace can flood the kernel with interrupts as of now, so let's
limit the number of pending floating interrupts injected via either
the floating interrupt controller or the KVM_S390_INTERRUPT ioctl.

We can have up to 4*64k pending subchannels + 8 adapter interrupts,
as well as up to ASYNC_PF_PER_VCPU*KVM_MAX_VCPUS pfault done interrupts.
There are also sclp and machine checks. This gives us
(4*65536+8+64*64+1+1) = 266250 interrupts.

Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/include/uapi/asm/kvm.h |  2 +-
 arch/s390/kvm/interrupt.c        | 26 +++++++++++++++++++++-----
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 59635b5..c3c5e10 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -214,6 +214,7 @@ struct kvm_s390_float_interrupt {
 	unsigned long idle_mask[(KVM_MAX_VCPUS + sizeof(long) - 1)
 				/ sizeof(long)];
 	struct kvm_s390_local_interrupt *local_int[KVM_MAX_VCPUS];
+	unsigned int irq_count;
 };
 
 
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 38d5f98..058b178 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -27,7 +27,7 @@
  * sizeof(kvm_s390_irq)*(4*65536+8+64*64+1+1) = 72 * 266250 = 19170000
  * Lets round up to 8192 pages.
  */
-
+#define KVM_S390_MAX_FLOAT_IRQS	266250
 #define KVM_S390_FLIC_MAX_BUFFER	0x2000000
 
 /* for KVM_GET_REGS and KVM_SET_REGS */
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a5f18ba..9c9192b 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -528,6 +528,7 @@ void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 			list_for_each_entry_safe(inti, n, &fi->list, list) {
 				if (__interrupt_is_deliverable(vcpu, inti)) {
 					list_del(&inti->list);
+					fi->irq_count--;
 					deliver = 1;
 					break;
 				}
@@ -583,6 +584,7 @@ void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu)
 				if ((inti->type == KVM_S390_MCHK) &&
 				    __interrupt_is_deliverable(vcpu, inti)) {
 					list_del(&inti->list);
+					fi->irq_count--;
 					deliver = 1;
 					break;
 				}
@@ -650,8 +652,10 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 		inti = iter;
 		break;
 	}
-	if (inti)
+	if (inti) {
 		list_del_init(&inti->list);
+		fi->irq_count--;
+	}
 	if (list_empty(&fi->list))
 		atomic_set(&fi->active, 0);
 	spin_unlock(&fi->lock);
@@ -659,16 +663,22 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 	return inti;
 }
 
-static void __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
+static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 {
 	struct kvm_s390_local_interrupt *li;
 	struct kvm_s390_float_interrupt *fi;
 	struct kvm_s390_interrupt_info *iter;
 	int sigcpu;
+	int rc = 0;
 
 	mutex_lock(&kvm->lock);
 	fi = &kvm->arch.float_int;
 	spin_lock(&fi->lock);
+	if (fi->irq_count >= KVM_S390_MAX_FLOAT_IRQS) {
+		rc = -EINVAL;
+		goto unlock_fi;
+	}
+	fi->irq_count++;
 	if (!is_ioint(inti->type)) {
 		list_add_tail(&inti->list, &fi->list);
 	} else {
@@ -700,8 +710,10 @@ static void __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	if (waitqueue_active(li->wq))
 		wake_up_interruptible(li->wq);
 	spin_unlock_bh(&li->lock);
+unlock_fi:
 	spin_unlock(&fi->lock);
 	mutex_unlock(&kvm->lock);
+	return rc;
 }
 
 int kvm_s390_inject_vm(struct kvm *kvm,
@@ -751,8 +763,7 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 	trace_kvm_s390_inject_vm(s390int->type, s390int->parm, s390int->parm64,
 				 2);
 
-	__inject_vm(kvm, inti);
-	return 0;
+	return __inject_vm(kvm, inti);
 }
 
 int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
@@ -852,6 +863,7 @@ static void clear_floating_interrupts(struct kvm *kvm)
 		list_del(&inti->list);
 		kfree(inti);
 	}
+	fi->irq_count = 0;
 	atomic_set(&fi->active, 0);
 	spin_unlock(&fi->lock);
 	mutex_unlock(&kvm->lock);
@@ -992,7 +1004,11 @@ static int enqueue_floating_irq(struct kvm_device *dev,
 			kfree(inti);
 			return r;
 		}
-		__inject_vm(dev->kvm, inti);
+		r = __inject_vm(dev->kvm, inti);
+		if (r) {
+			kfree(inti);
+			return r;
+		}
 		len -= sizeof(struct kvm_s390_irq);
 		attr->addr += sizeof(struct kvm_s390_irq);
 	}
-- 
1.8.4.2
