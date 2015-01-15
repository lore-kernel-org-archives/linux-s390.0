From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 20/21] KVM: s390: Provide guest TOD Clock Get/Set Controls
Date: Thu, 15 Jan 2015 14:43:33 +0100
Message-ID: <1421329414-76826-21-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

Provide controls for setting/getting the guest TOD clock based on the VM
attribute interface.

Provide TOD and TOD_HIGH vm attributes on s390 for managing guest Time Of
Day clock value.

TOD_HIGH is presently always set to 0. In the future it will contain a high
order expansion of the tod clock value after it overflows the 64-bits of
the TOD.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   1 +
 arch/s390/include/uapi/asm/kvm.h |   5 ++
 arch/s390/kvm/kvm-s390.c         | 128 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a2dcd0e..8e22aa0 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -528,6 +528,7 @@ struct kvm_arch{
 	struct mutex ipte_mutex;
 	spinlock_t start_stop_lock;
 	struct kvm_s390_crypto crypto;
+	u64 epoch;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index ac3000d..6c2efec 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -57,12 +57,17 @@ struct kvm_s390_io_adapter_req {
 
 /* kvm attr_group  on vm fd */
 #define KVM_S390_VM_MEM_CTRL		0
+#define KVM_S390_VM_TOD			1
 
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
 #define KVM_S390_VM_MEM_CLR_CMMA	1
 #define KVM_S390_VM_MEM_LIMIT_SIZE	2
 
+/* kvm attributes for KVM_S390_VM_TOD */
+#define KVM_S390_VM_TOD_LOW		0
+#define KVM_S390_VM_TOD_HIGH		1
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3677b8c..9cf899e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -342,6 +342,113 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 	return ret;
 }
 
+static int kvm_s390_set_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	u8 gtod_high;
+
+	if (copy_from_user(&gtod_high, (void __user *)attr->addr,
+					   sizeof(gtod_high)))
+		return -EFAULT;
+
+	if (gtod_high != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int kvm_s390_set_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	struct kvm_vcpu *cur_vcpu;
+	unsigned int vcpu_idx;
+	u64 host_tod, gtod;
+	int r;
+
+	if (copy_from_user(&gtod, (void __user *)attr->addr, sizeof(gtod)))
+		return -EFAULT;
+
+	r = store_tod_clock(&host_tod);
+	if (r)
+		return r;
+
+	mutex_lock(&kvm->lock);
+	kvm->arch.epoch = gtod - host_tod;
+	kvm_for_each_vcpu(vcpu_idx, cur_vcpu, kvm) {
+		cur_vcpu->arch.sie_block->epoch = kvm->arch.epoch;
+		exit_sie(cur_vcpu);
+	}
+	mutex_unlock(&kvm->lock);
+	return 0;
+}
+
+static int kvm_s390_set_tod(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	int ret;
+
+	if (attr->flags)
+		return -EINVAL;
+
+	switch (attr->attr) {
+	case KVM_S390_VM_TOD_HIGH:
+		ret = kvm_s390_set_tod_high(kvm, attr);
+		break;
+	case KVM_S390_VM_TOD_LOW:
+		ret = kvm_s390_set_tod_low(kvm, attr);
+		break;
+	default:
+		ret = -ENXIO;
+		break;
+	}
+	return ret;
+}
+
+static int kvm_s390_get_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	u8 gtod_high = 0;
+
+	if (copy_to_user((void __user *)attr->addr, &gtod_high,
+					 sizeof(gtod_high)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int kvm_s390_get_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	u64 host_tod, gtod;
+	int r;
+
+	r = store_tod_clock(&host_tod);
+	if (r)
+		return r;
+
+	gtod = host_tod + kvm->arch.epoch;
+	if (copy_to_user((void __user *)attr->addr, &gtod, sizeof(gtod)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int kvm_s390_get_tod(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	int ret;
+
+	if (attr->flags)
+		return -EINVAL;
+
+	switch (attr->attr) {
+	case KVM_S390_VM_TOD_HIGH:
+		ret = kvm_s390_get_tod_high(kvm, attr);
+		break;
+	case KVM_S390_VM_TOD_LOW:
+		ret = kvm_s390_get_tod_low(kvm, attr);
+		break;
+	default:
+		ret = -ENXIO;
+		break;
+	}
+	return ret;
+}
+
 static int kvm_s390_vm_set_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	int ret;
@@ -350,6 +457,9 @@ static int kvm_s390_vm_set_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_MEM_CTRL:
 		ret = kvm_s390_set_mem_control(kvm, attr);
 		break;
+	case KVM_S390_VM_TOD:
+		ret = kvm_s390_set_tod(kvm, attr);
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -366,6 +476,9 @@ static int kvm_s390_vm_get_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_MEM_CTRL:
 		ret = kvm_s390_get_mem_control(kvm, attr);
 		break;
+	case KVM_S390_VM_TOD:
+		ret = kvm_s390_get_tod(kvm, attr);
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -391,6 +504,17 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 			break;
 		}
 		break;
+	case KVM_S390_VM_TOD:
+		switch (attr->attr) {
+		case KVM_S390_VM_TOD_LOW:
+		case KVM_S390_VM_TOD_HIGH:
+			ret = 0;
+			break;
+		default:
+			ret = -ENXIO;
+			break;
+		}
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -541,6 +665,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.css_support = 0;
 	kvm->arch.use_irqchip = 0;
+	kvm->arch.epoch = 0;
 
 	spin_lock_init(&kvm->arch.start_stop_lock);
 
@@ -686,6 +811,9 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
+	mutex_lock(&vcpu->kvm->lock);
+	vcpu->arch.sie_block->epoch = vcpu->kvm->arch.epoch;
+	mutex_unlock(&vcpu->kvm->lock);
 	if (!kvm_is_ucontrol(vcpu->kvm))
 		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
 }
-- 
1.9.3
