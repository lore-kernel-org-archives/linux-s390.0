From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 04/21] KVM: s390: Allow userspace to limit guest memory size
Date: Thu, 15 Jan 2015 14:43:17 +0100
Message-ID: <1421329414-76826-5-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

With commit c6c956b80bdf ("KVM: s390/mm: support gmap page tables with less
than 5 levels") we are able to define a limit for the guest memory size.

As we round up the guest size in respect to the levels of page tables
we get to guest limits of: 2048 MB, 4096 GB, 8192 TB and 16384 PB.
We currently limit the guest size to 16 TB, which means we end up
creating a page table structure supporting guest sizes up to 8192 TB.

This patch introduces an interface that allows userspace to tune
this limit. This may bring performance improvements for small guests.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/vm.txt | 14 +++++++
 arch/s390/include/uapi/asm/kvm.h         |  1 +
 arch/s390/kvm/kvm-s390.c                 | 65 ++++++++++++++++++++++++++++++--
 3 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index d426fc8..c3b17c6 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -24,3 +24,17 @@ Returns: 0
 
 Clear the CMMA status for all guest pages, so any pages the guest marked
 as unused are again used any may not be reclaimed by the host.
+
+1.3. ATTRIBUTE KVM_S390_VM_MEM_LIMIT_SIZE
+Parameters: in attr->addr the address for the new limit of guest memory
+Returns: -EFAULT if the given address is not accessible
+         -EINVAL if the virtual machine is of type UCONTROL
+         -E2BIG if the given guest memory is to big for that machine
+         -EBUSY if a vcpu is already defined
+         -ENOMEM if not enough memory is available for a new shadow guest mapping
+          0 otherwise
+
+Allows userspace to query the actual limit and set a new limit for
+the maximum guest memory size. The limit will be rounded up to
+2048 MB, 4096 GB, 8192 TB respectively, as this limit is governed by
+the number of page table levels.
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 48eda3a..9c01159 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -61,6 +61,7 @@ struct kvm_s390_io_adapter_req {
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
 #define KVM_S390_VM_MEM_CLR_CMMA	1
+#define KVM_S390_VM_MEM_LIMIT_SIZE	2
 
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 529f7905..14cdf1c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -261,7 +261,24 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 	return r;
 }
 
-static int kvm_s390_mem_control(struct kvm *kvm, struct kvm_device_attr *attr)
+static int kvm_s390_get_mem_control(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	int ret;
+
+	switch (attr->attr) {
+	case KVM_S390_VM_MEM_LIMIT_SIZE:
+		ret = 0;
+		if (put_user(kvm->arch.gmap->asce_end, (u64 __user *)attr->addr))
+			ret = -EFAULT;
+		break;
+	default:
+		ret = -ENXIO;
+		break;
+	}
+	return ret;
+}
+
+static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	int ret;
 	unsigned int idx;
@@ -283,6 +300,36 @@ static int kvm_s390_mem_control(struct kvm *kvm, struct kvm_device_attr *attr)
 		mutex_unlock(&kvm->lock);
 		ret = 0;
 		break;
+	case KVM_S390_VM_MEM_LIMIT_SIZE: {
+		unsigned long new_limit;
+
+		if (kvm_is_ucontrol(kvm))
+			return -EINVAL;
+
+		if (get_user(new_limit, (u64 __user *)attr->addr))
+			return -EFAULT;
+
+		if (new_limit > kvm->arch.gmap->asce_end)
+			return -E2BIG;
+
+		ret = -EBUSY;
+		mutex_lock(&kvm->lock);
+		if (atomic_read(&kvm->online_vcpus) == 0) {
+			/* gmap_alloc will round the limit up */
+			struct gmap *new = gmap_alloc(current->mm, new_limit);
+
+			if (!new) {
+				ret = -ENOMEM;
+			} else {
+				gmap_free(kvm->arch.gmap);
+				new->private = kvm;
+				kvm->arch.gmap = new;
+				ret = 0;
+			}
+		}
+		mutex_unlock(&kvm->lock);
+		break;
+	}
 	default:
 		ret = -ENXIO;
 		break;
@@ -296,7 +343,7 @@ static int kvm_s390_vm_set_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 
 	switch (attr->group) {
 	case KVM_S390_VM_MEM_CTRL:
-		ret = kvm_s390_mem_control(kvm, attr);
+		ret = kvm_s390_set_mem_control(kvm, attr);
 		break;
 	default:
 		ret = -ENXIO;
@@ -308,7 +355,18 @@ static int kvm_s390_vm_set_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 
 static int kvm_s390_vm_get_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 {
-	return -ENXIO;
+	int ret;
+
+	switch (attr->group) {
+	case KVM_S390_VM_MEM_CTRL:
+		ret = kvm_s390_get_mem_control(kvm, attr);
+		break;
+	default:
+		ret = -ENXIO;
+		break;
+	}
+
+	return ret;
 }
 
 static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
@@ -320,6 +378,7 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 		switch (attr->attr) {
 		case KVM_S390_VM_MEM_ENABLE_CMMA:
 		case KVM_S390_VM_MEM_CLR_CMMA:
+		case KVM_S390_VM_MEM_LIMIT_SIZE:
 			ret = 0;
 			break;
 		default:
-- 
1.9.3
