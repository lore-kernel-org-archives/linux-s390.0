From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [PATCH 3/3] s390/mm: Enable gmap huge pmd support
Date: Thu, 15 Feb 2018 16:43:22 +0100
Message-ID: <1518709402-91101-4-git-send-email-frankja@linux.vnet.ibm.com>
References: <28551222-18a6-4566-0b7a-acc366c860c3@redhat.com>
 <1518709402-91101-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518709402-91101-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Now that we have everything in place, let's allow huge (1m) pmds for
gmap linking, effectively allowing hugetlbfs backed guests. Transparent
huge pages and 2g huge pages are *not* supported through this change.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 Documentation/virtual/kvm/api.txt   | 12 ++++++++++++
 arch/s390/include/asm/mmu.h         |  2 ++
 arch/s390/include/asm/mmu_context.h |  1 +
 arch/s390/kvm/kvm-s390.c            | 17 ++++++++++++++++-
 arch/s390/mm/gmap.c                 |  8 +++++---
 include/uapi/linux/kvm.h            |  1 +
 6 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 792fa87..edf248a 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4270,6 +4270,18 @@ enables QEMU to build error log and branch to guest kernel registered
 machine check handling routine. Without this capability KVM will
 branch to guests' 0x200 interrupt vector.
 
+7.13 KVM_CAP_S390_HPAGE
+
+Architectures: s390
+Parameters: none
+
+With this capability the KVM support for memory backing with 1m pages
+through hugetlbfs can be enabled. This will disable cmm, cmma, pfmfi
+and the storage key interpretation.
+
+While it is generally possible to create and start a huge page backed
+VM without this capability, the VM will not be functional.
+
 8. Other capabilities.
 ----------------------
 
diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index db35c41a..5ab9452 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -24,6 +24,8 @@ typedef struct {
 	unsigned int use_skey:1;
 	/* The mmu context uses CMMA. */
 	unsigned int use_cmma:1;
+	/* The gmap associated with this context uses huge pages. */
+	unsigned int use_gmap_hpage:1;
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(name)						   \
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 65154ea..79f2159 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -32,6 +32,7 @@ static inline int init_new_context(struct task_struct *tsk,
 	mm->context.has_pgste = 0;
 	mm->context.use_skey = 0;
 	mm->context.use_cmma = 0;
+	mm->context.use_gmap_hpage = 0;
 #endif
 	switch (mm->context.asce_limit) {
 	case _REGION2_SIZE:
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ddf3599..8ea7025 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -406,6 +406,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_CMMA_MIGRATION:
 	case KVM_CAP_S390_AIS:
 	case KVM_CAP_S390_AIS_MIGRATION:
+	case KVM_CAP_S390_HPAGE:
 		r = 1;
 		break;
 	case KVM_CAP_S390_MEM_OP:
@@ -604,6 +605,19 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_GS %s",
 			 r ? "(not available)" : "(success)");
 		break;
+	case KVM_CAP_S390_HPAGE:
+		mutex_lock(&kvm->lock);
+		if (kvm->created_vcpus) {
+			r = -EBUSY;
+		}
+		kvm->mm->context.use_gmap_hpage = 1;
+		/* They would complicate matters too much. */
+		kvm->arch.has_skf = 0;
+		kvm->arch.has_cmma = 0;
+		kvm->arch.has_pfmfi = 0;
+		mutex_unlock(&kvm->lock);
+		VM_EVENT(kvm, 3, "%s", "ENABLE: KVM_CAP_S390_HPAGE");
+		break;
 	case KVM_CAP_S390_USER_STSI:
 		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_USER_STSI");
 		kvm->arch.user_stsi = 1;
@@ -655,7 +669,8 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		VM_EVENT(kvm, 3, "%s", "ENABLE: CMMA support");
 		mutex_lock(&kvm->lock);
 		if (!kvm->created_vcpus) {
-			kvm->arch.has_cmma = 1;
+			if (!kvm->mm->context.use_gmap_hpage)
+				kvm->arch.has_cmma = 1;
 			/* Not compatible with cmma. */
 			kvm->arch.has_pfmfi = 0;
 			ret = 0;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 2cafcba..6937853 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2,8 +2,10 @@
 /*
  *  KVM guest address space mapping code
  *
- *    Copyright IBM Corp. 2007, 2016
+ *    Copyright IBM Corp. 2007, 2016, 2017
  *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *		 David Hildenbrand <david@redhat.com>
+ *		 Janosch Frank <frankja@linux.vnet.ibm.com>
  */
 
 #include <linux/kernel.h>
@@ -595,8 +597,8 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 		return -EFAULT;
 	pmd = pmd_offset(pud, vmaddr);
 	VM_BUG_ON(pmd_none(*pmd));
-	/* large pmds cannot yet be handled */
-	if (pmd_large(*pmd))
+	/* Are we allowed to use huge pages? */
+	if (pmd_large(*pmd) && !gmap->mm->context.use_gmap_hpage)
 		return -EFAULT;
 	/* Link gmap segment table entry location to page table. */
 	rc = radix_tree_preload(GFP_KERNEL);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 0fb5ef9..4e397d7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -934,6 +934,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_AIS_MIGRATION 150
 #define KVM_CAP_PPC_GET_CPU_CHAR 151
 #define KVM_CAP_S390_BPB 152
+#define KVM_CAP_S390_HPAGE 153
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4
