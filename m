From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 16/16] KVM: s390: log capability enablement and vm attribute changes
Date: Wed, 29 Jul 2015 11:06:06 +0200
Message-ID: <1438160766-108179-17-git-send-email-borntraeger@de.ibm.com>
References: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Depending on user space, some capabilities and vm attributes are
enabled at runtime. Let's log those events and while we're at it,
log querying the vm attributes as well.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7621036..924b1ae 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -299,10 +299,12 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 
 	switch (cap->cap) {
 	case KVM_CAP_S390_IRQCHIP:
+		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_IRQCHIP");
 		kvm->arch.use_irqchip = 1;
 		r = 0;
 		break;
 	case KVM_CAP_S390_USER_SIGP:
+		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_USER_SIGP");
 		kvm->arch.user_sigp = 1;
 		r = 0;
 		break;
@@ -313,8 +315,11 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 			r = 0;
 		} else
 			r = -EINVAL;
+		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_VECTOR_REGISTERS %s",
+			 r ? "(not available)" : "(success)");
 		break;
 	case KVM_CAP_S390_USER_STSI:
+		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_USER_STSI");
 		kvm->arch.user_stsi = 1;
 		r = 0;
 		break;
@@ -332,6 +337,8 @@ static int kvm_s390_get_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 	switch (attr->attr) {
 	case KVM_S390_VM_MEM_LIMIT_SIZE:
 		ret = 0;
+		VM_EVENT(kvm, 3, "QUERY: max guest memory: %lu bytes",
+			 kvm->arch.gmap->asce_end);
 		if (put_user(kvm->arch.gmap->asce_end, (u64 __user *)attr->addr))
 			ret = -EFAULT;
 		break;
@@ -354,6 +361,7 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 			break;
 
 		ret = -EBUSY;
+		VM_EVENT(kvm, 3, "%s", "ENABLE: CMMA support");
 		mutex_lock(&kvm->lock);
 		if (atomic_read(&kvm->online_vcpus) == 0) {
 			kvm->arch.use_cmma = 1;
@@ -366,6 +374,7 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (!kvm->arch.use_cmma)
 			break;
 
+		VM_EVENT(kvm, 3, "%s", "RESET: CMMA states");
 		mutex_lock(&kvm->lock);
 		idx = srcu_read_lock(&kvm->srcu);
 		s390_reset_cmma(kvm->arch.gmap->mm);
@@ -401,6 +410,7 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 			}
 		}
 		mutex_unlock(&kvm->lock);
+		VM_EVENT(kvm, 3, "SET: max guest memory: %lu bytes", new_limit);
 		break;
 	}
 	default:
@@ -427,22 +437,26 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 			kvm->arch.crypto.crycb->aes_wrapping_key_mask,
 			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
 		kvm->arch.crypto.aes_kw = 1;
+		VM_EVENT(kvm, 3, "%s", "ENABLE: AES keywrapping support");
 		break;
 	case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
 		get_random_bytes(
 			kvm->arch.crypto.crycb->dea_wrapping_key_mask,
 			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
 		kvm->arch.crypto.dea_kw = 1;
+		VM_EVENT(kvm, 3, "%s", "ENABLE: DEA keywrapping support");
 		break;
 	case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
 		kvm->arch.crypto.aes_kw = 0;
 		memset(kvm->arch.crypto.crycb->aes_wrapping_key_mask, 0,
 			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
+		VM_EVENT(kvm, 3, "%s", "DISABLE: AES keywrapping support");
 		break;
 	case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
 		kvm->arch.crypto.dea_kw = 0;
 		memset(kvm->arch.crypto.crycb->dea_wrapping_key_mask, 0,
 			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
+		VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
 		break;
 	default:
 		mutex_unlock(&kvm->lock);
@@ -467,6 +481,7 @@ static int kvm_s390_set_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
 
 	if (gtod_high != 0)
 		return -EINVAL;
+	VM_EVENT(kvm, 3, "SET: TOD extension: 0x%x\n", gtod_high);
 
 	return 0;
 }
@@ -492,6 +507,7 @@ static int kvm_s390_set_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 		cur_vcpu->arch.sie_block->epoch = kvm->arch.epoch;
 	kvm_s390_vcpu_unblock_all(kvm);
 	mutex_unlock(&kvm->lock);
+	VM_EVENT(kvm, 3, "SET: TOD base: 0x%llx\n", gtod);
 	return 0;
 }
 
@@ -523,6 +539,7 @@ static int kvm_s390_get_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
 	if (copy_to_user((void __user *)attr->addr, &gtod_high,
 					 sizeof(gtod_high)))
 		return -EFAULT;
+	VM_EVENT(kvm, 3, "QUERY: TOD extension: 0x%x\n", gtod_high);
 
 	return 0;
 }
@@ -539,6 +556,7 @@ static int kvm_s390_get_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 	gtod = host_tod + kvm->arch.epoch;
 	if (copy_to_user((void __user *)attr->addr, &gtod, sizeof(gtod)))
 		return -EFAULT;
+	VM_EVENT(kvm, 3, "QUERY: TOD base: 0x%llx\n", gtod);
 
 	return 0;
 }
@@ -2360,6 +2378,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	case KVM_CAP_S390_CSS_SUPPORT:
 		if (!vcpu->kvm->arch.css_support) {
 			vcpu->kvm->arch.css_support = 1;
+			VM_EVENT(vcpu->kvm, 3, "%s", "ENABLE: CSS support");
 			trace_kvm_s390_enable_css(vcpu->kvm);
 		}
 		r = 0;
-- 
2.3.0
