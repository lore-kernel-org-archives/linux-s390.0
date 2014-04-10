From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/3] kvm: s390: Exploiting generic userspace interface for cmma
Date: Thu, 10 Apr 2014 13:16:44 +0200
Message-ID: <1397128604-50161-4-git-send-email-borntraeger@de.ibm.com>
References: <1397128604-50161-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397128604-50161-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

To enable CMMA and to reset its state we use the vm kvm_device ioctls,
encapsulating attributes within the KVM_S390_VM_MEM_CTRL group.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/vm.txt | 18 ++++++++++++++
 arch/s390/include/uapi/asm/kvm.h         |  7 ++++++
 arch/s390/kvm/kvm-s390.c                 | 42 ++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index 4fe1532..ff495f5 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -4,3 +4,21 @@ Generic vm interface
 The interface handles per-vm attributes, such as CMMA status on s390 and is
 similar in way to ONE_REG, but targeting the whole vm instead of one vcpu
 alone. It is available with KVM_CAP_VM_ATTRIBUTES.
+
+Following groups and attributes are supported by this interface:
+
+1. GROUP: KVM_S390_VM_MEM_CTRL
+Architectures: s390
+
+1.1. ATTRIBUTE: KVM_S390_VM_MEM_CTRL
+Parameters: none
+Returns: -EBUSY if already a vcpus is defined, otherwise 0
+
+Enables CMMA for the virtual machine
+
+1.2. ATTRIBUTE: KVM_S390_VM_CLR_CMMA
+Parameteres: none
+Returns: 0
+
+Clear the CMMA status for all guest pages, so any pages the guest marked
+as unused are again used any may not be reclaimed by the host.
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index c003c6a..e35c798 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -54,6 +54,13 @@ struct kvm_s390_io_adapter_req {
 	__u64 addr;
 };
 
+/* kvm attr_group  on vm fd */
+#define KVM_S390_VM_MEM_CTRL		0
+
+/* kvm attributes for mem_ctrl */
+#define KVM_S390_VM_MEM_ENABLE_CMMA	0
+#define KVM_S390_VM_MEM_CLR_CMMA	1
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fc2fe49..2486a11 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -258,11 +258,43 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 	return r;
 }
 
+static int kvm_s390_mem_control(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	int ret;
+	unsigned int idx;
+	switch (attr->attr) {
+	case KVM_S390_VM_MEM_ENABLE_CMMA:
+		ret = -EBUSY;
+		mutex_lock(&kvm->lock);
+		if (atomic_read(&kvm->online_vcpus) == 0) {
+			kvm->arch.use_cmma = 1;
+			ret = 0;
+		}
+		mutex_unlock(&kvm->lock);
+		break;
+	case KVM_S390_VM_MEM_CLR_CMMA:
+		mutex_lock(&kvm->lock);
+		idx = srcu_read_lock(&kvm->srcu);
+		page_table_reset_pgste(kvm->arch.gmap->mm, 0, TASK_SIZE, false);
+		srcu_read_unlock(&kvm->srcu, idx);
+		mutex_unlock(&kvm->lock);
+		ret = 0;
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
 
 	switch (attr->group) {
+	case KVM_S390_VM_MEM_CTRL:
+		ret = kvm_s390_mem_control(kvm, attr);
+		break;
 	default:
 		ret = -ENXIO;
 		break;
@@ -281,6 +313,16 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 	int ret;
 
 	switch (attr->group) {
+	case KVM_S390_VM_MEM_CTRL:
+		switch (attr->attr) {
+		case KVM_S390_VM_MEM_ENABLE_CMMA:
+		case KVM_S390_VM_MEM_CLR_CMMA:
+			ret = 0;
+			break;
+		default:
+			ret = -ENXIO;
+			break;
+		}
 	default:
 		ret = -ENXIO;
 		break;
-- 
1.8.4.2
