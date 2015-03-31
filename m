From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL diff] diff to previous pull request
Date: Tue, 31 Mar 2015 21:36:35 +0200
Message-ID: <1427830595-12641-2-git-send-email-borntraeger@de.ibm.com>
References: <1427830595-12641-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1427830595-12641-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

- change "__user u8" to u8 "__user"
- avoid unnecessary casts
- use capability numbers 113 and 114

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index ee2dfdc..9de4726 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1613,7 +1613,7 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 	spin_unlock(&fi->lock);
 };
 
-static int get_all_floating_irqs(struct kvm *kvm, __user __u8 *usrbuf, __u64 len)
+static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 {
 	struct kvm_s390_interrupt_info *inti;
 	struct kvm_s390_float_interrupt *fi;
@@ -1677,9 +1677,7 @@ static int get_all_floating_irqs(struct kvm *kvm, __user __u8 *usrbuf, __u64 len
 out:
 	spin_unlock(&fi->lock);
 	if (!ret && n > 0) {
-		if (copy_to_user((void __user *) usrbuf,
-				 (void *) buf,
-				 sizeof(struct kvm_s390_irq) * n))
+		if (copy_to_user(usrbuf, buf, sizeof(struct kvm_s390_irq) * n))
 			ret = -EFAULT;
 	}
 	vfree(buf);
@@ -1693,7 +1691,7 @@ static int flic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 
 	switch (attr->group) {
 	case KVM_DEV_FLIC_GET_ALL_IRQS:
-		r = get_all_floating_irqs(dev->kvm, (__user u8 *) attr->addr,
+		r = get_all_floating_irqs(dev->kvm, (u8 __user *) attr->addr,
 					  attr->attr);
 		break;
 	default:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 7437ce9..c045c72 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -809,8 +809,8 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_MEM_OP 108
 #define KVM_CAP_S390_USER_STSI 109
 #define KVM_CAP_S390_SKEYS 110
-#define KVM_CAP_S390_INJECT_IRQ 111
-#define KVM_CAP_S390_IRQ_STATE 112
+#define KVM_CAP_S390_INJECT_IRQ 113
+#define KVM_CAP_S390_IRQ_STATE 114
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
