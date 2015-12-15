From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/4] KVM: s390: fix mismatch between user and in-kernel guest limit
Date: Tue, 15 Dec 2015 20:23:45 +0100
Message-ID: <1450207426-17222-4-git-send-email-borntraeger@de.ibm.com>
References: <1450207426-17222-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1450207426-17222-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

While the userspace interface requests the maximum size the gmap code
expects to get a maximum address.

This error resulted in bigger page tables than necessary for some guest
sizes, e.g. a 2GB guest used 3 levels instead of 2.

At the same time we introduce KVM_S390_NO_MEM_LIMIT, which allows in a
bright future that a guest spans the complete 64 bit address space.

We also switch to TASK_MAX_SIZE for the initial memory size, this is a
cosmetic change as the previous size also resulted in a 4 level pagetable
creation.

Reported-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/vm.txt |  3 ++-
 arch/s390/include/asm/kvm_host.h         |  1 +
 arch/s390/include/uapi/asm/kvm.h         |  2 ++
 arch/s390/kvm/kvm-s390.c                 | 25 ++++++++++++++++++++-----
 arch/s390/mm/pgtable.c                   |  4 ++--
 5 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index 2d09d1e..f083a16 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -37,7 +37,8 @@ Returns: -EFAULT if the given address is not accessible
 Allows userspace to query the actual limit and set a new limit for
 the maximum guest memory size. The limit will be rounded up to
 2048 MB, 4096 GB, 8192 TB respectively, as this limit is governed by
-the number of page table levels.
+the number of page table levels. In the case that there is no limit we will set
+the limit to KVM_S390_NO_MEM_LIMIT (U64_MAX).
 
 2. GROUP: KVM_S390_VM_CPU_MODEL
 Architectures: s390
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 12e9291..c831441 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -627,6 +627,7 @@ struct kvm_arch{
 	struct kvm_s390_float_interrupt float_int;
 	struct kvm_device *flic;
 	struct gmap *gmap;
+	unsigned long mem_limit;
 	int css_support;
 	int use_irqchip;
 	int use_cmma;
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index ef1a5fc..d2aea31 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -66,6 +66,8 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_MEM_CLR_CMMA	1
 #define KVM_S390_VM_MEM_LIMIT_SIZE	2
 
+#define KVM_S390_NO_MEM_LIMIT		U64_MAX
+
 /* kvm attributes for KVM_S390_VM_TOD */
 #define KVM_S390_VM_TOD_LOW		0
 #define KVM_S390_VM_TOD_HIGH		1
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c14845c..8aa5e55 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -378,8 +378,8 @@ static int kvm_s390_get_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 	case KVM_S390_VM_MEM_LIMIT_SIZE:
 		ret = 0;
 		VM_EVENT(kvm, 3, "QUERY: max guest memory: %lu bytes",
-			 kvm->arch.gmap->asce_end);
-		if (put_user(kvm->arch.gmap->asce_end, (u64 __user *)attr->addr))
+			 kvm->arch.mem_limit);
+		if (put_user(kvm->arch.mem_limit, (u64 __user *)attr->addr))
 			ret = -EFAULT;
 		break;
 	default:
@@ -431,9 +431,17 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (get_user(new_limit, (u64 __user *)attr->addr))
 			return -EFAULT;
 
-		if (new_limit > kvm->arch.gmap->asce_end)
+		if (kvm->arch.mem_limit != KVM_S390_NO_MEM_LIMIT &&
+		    new_limit > kvm->arch.mem_limit)
 			return -E2BIG;
 
+		if (!new_limit)
+			return -EINVAL;
+
+		/* gmap_alloc takes last usable address */
+		if (new_limit != KVM_S390_NO_MEM_LIMIT)
+			new_limit -= 1;
+
 		ret = -EBUSY;
 		mutex_lock(&kvm->lock);
 		if (atomic_read(&kvm->online_vcpus) == 0) {
@@ -450,7 +458,9 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 			}
 		}
 		mutex_unlock(&kvm->lock);
-		VM_EVENT(kvm, 3, "SET: max guest memory: %lu bytes", new_limit);
+		VM_EVENT(kvm, 3, "SET: max guest address: %lu", new_limit);
+		VM_EVENT(kvm, 3, "New guest asce: 0x%pK",
+			 (void *) kvm->arch.gmap->asce);
 		break;
 	}
 	default:
@@ -1172,8 +1182,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	if (type & KVM_VM_S390_UCONTROL) {
 		kvm->arch.gmap = NULL;
+		kvm->arch.mem_limit = KVM_S390_NO_MEM_LIMIT;
 	} else {
-		kvm->arch.gmap = gmap_alloc(current->mm, (1UL << 44) - 1);
+		kvm->arch.mem_limit = TASK_MAX_SIZE;
+		kvm->arch.gmap = gmap_alloc(current->mm, kvm->arch.mem_limit - 1);
 		if (!kvm->arch.gmap)
 			goto out_err;
 		kvm->arch.gmap->private = kvm;
@@ -2829,6 +2841,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	if (mem->memory_size & 0xffffful)
 		return -EINVAL;
 
+	if (mem->guest_phys_addr + mem->memory_size > kvm->arch.mem_limit)
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 54ef3bc..63b0398 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -133,7 +133,7 @@ void crst_table_downgrade(struct mm_struct *mm, unsigned long limit)
 /**
  * gmap_alloc - allocate a guest address space
  * @mm: pointer to the parent mm_struct
- * @limit: maximum size of the gmap address space
+ * @limit: maximum address of the gmap address space
  *
  * Returns a guest address space structure.
  */
@@ -402,7 +402,7 @@ int gmap_map_segment(struct gmap *gmap, unsigned long from,
 	if ((from | to | len) & (PMD_SIZE - 1))
 		return -EINVAL;
 	if (len == 0 || from + len < from || to + len < to ||
-	    from + len > TASK_MAX_SIZE || to + len > gmap->asce_end)
+	    from + len - 1 > TASK_MAX_SIZE || to + len - 1 > gmap->asce_end)
 		return -EINVAL;
 
 	flush = 0;
-- 
2.3.0
