From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/11] KVM: s390: Add MEMOP ioctls for reading/writing guest memory
Date: Wed, 18 Mar 2015 12:44:05 +0100
Message-ID: <1426679049-37696-8-git-send-email-borntraeger@de.ibm.com>
References: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

On s390, we've got to make sure to hold the IPTE lock while accessing
logical memory. So let's add an ioctl for reading and writing logical
memory to provide this feature for userspace, too.
The maximum transfer size of this call is limited to 64kB to prevent
that the guest can trigger huge copy_from/to_user transfers. QEMU
currently only requests up to one or two pages so far, so 16*4kB seems
to be a reasonable limit here.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 46 ++++++++++++++++++++++++
 arch/s390/kvm/gaccess.c           | 22 ++++++++++++
 arch/s390/kvm/gaccess.h           |  2 ++
 arch/s390/kvm/kvm-s390.c          | 74 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h          | 21 +++++++++++
 5 files changed, 165 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index ee47998e..281179d 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2716,6 +2716,52 @@ The fields in each entry are defined as follows:
    eax, ebx, ecx, edx: the values returned by the cpuid instruction for
          this function/index combination
 
+4.89 KVM_S390_MEM_OP
+
+Capability: KVM_CAP_S390_MEM_OP
+Architectures: s390
+Type: vcpu ioctl
+Parameters: struct kvm_s390_mem_op (in)
+Returns: = 0 on success,
+         < 0 on generic error (e.g. -EFAULT or -ENOMEM),
+         > 0 if an exception occurred while walking the page tables
+
+Read or write data from/to the logical (virtual) memory of a VPCU.
+
+Parameters are specified via the following structure:
+
+struct kvm_s390_mem_op {
+	__u64 gaddr;		/* the guest address */
+	__u64 flags;		/* flags */
+	__u32 size;		/* amount of bytes */
+	__u32 op;		/* type of operation */
+	__u64 buf;		/* buffer in userspace */
+	__u8 ar;		/* the access register number */
+	__u8 reserved[31];	/* should be set to 0 */
+};
+
+The type of operation is specified in the "op" field. It is either
+KVM_S390_MEMOP_LOGICAL_READ for reading from logical memory space or
+KVM_S390_MEMOP_LOGICAL_WRITE for writing to logical memory space. The
+KVM_S390_MEMOP_F_CHECK_ONLY flag can be set in the "flags" field to check
+whether the corresponding memory access would create an access exception
+(without touching the data in the memory at the destination). In case an
+access exception occurred while walking the MMU tables of the guest, the
+ioctl returns a positive error number to indicate the type of exception.
+This exception is also raised directly at the corresponding VCPU if the
+flag KVM_S390_MEMOP_F_INJECT_EXCEPTION is set in the "flags" field.
+
+The start address of the memory region has to be specified in the "gaddr"
+field, and the length of the region in the "size" field. "buf" is the buffer
+supplied by the userspace application where the read data should be written
+to for KVM_S390_MEMOP_LOGICAL_READ, or where the data that should be written
+is stored for a KVM_S390_MEMOP_LOGICAL_WRITE. "buf" is unused and can be NULL
+when KVM_S390_MEMOP_F_CHECK_ONLY is specified. "ar" designates the access
+register number to be used.
+
+The "reserved" field is meant for future extensions. It is not used by
+KVM with the currently defined set of flags.
+
 5. The kvm_run structure
 ------------------------
 
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index ea38d71..a7559f7 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -864,6 +864,28 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
 }
 
 /**
+ * check_gva_range - test a range of guest virtual addresses for accessibility
+ */
+int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
+		    unsigned long length, int is_write)
+{
+	unsigned long gpa;
+	unsigned long currlen;
+	int rc = 0;
+
+	ipte_lock(vcpu);
+	while (length > 0 && !rc) {
+		currlen = min(length, PAGE_SIZE - (gva % PAGE_SIZE));
+		rc = guest_translate_address(vcpu, gva, ar, &gpa, is_write);
+		gva += currlen;
+		length -= currlen;
+	}
+	ipte_unlock(vcpu);
+
+	return rc;
+}
+
+/**
  * kvm_s390_check_low_addr_prot_real - check for low-address protection
  * @gra: Guest real address
  *
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 835e557..ef03726 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -157,6 +157,8 @@ int read_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
 
 int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva,
 			    ar_t ar, unsigned long *gpa, int write);
+int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
+		    unsigned long length, int is_write);
 
 int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 		 unsigned long len, int write);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 610e90a..b7ecef9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -25,6 +25,7 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
+#include <linux/vmalloc.h>
 #include <asm/asm-offsets.h>
 #include <asm/lowcore.h>
 #include <asm/pgtable.h>
@@ -38,6 +39,8 @@
 #include "trace.h"
 #include "trace-s390.h"
 
+#define MEM_OP_MAX_SIZE 65536	/* Maximum transfer size for KVM_S390_MEM_OP */
+
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
 
 struct kvm_stats_debugfs_item debugfs_entries[] = {
@@ -177,6 +180,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_USER_SIGP:
 		r = 1;
 		break;
+	case KVM_CAP_S390_MEM_OP:
+		r = MEM_OP_MAX_SIZE;
+		break;
 	case KVM_CAP_NR_VCPUS:
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
@@ -2185,6 +2191,65 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	return r;
 }
 
+static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
+				  struct kvm_s390_mem_op *mop)
+{
+	void __user *uaddr = (void __user *)mop->buf;
+	void *tmpbuf = NULL;
+	int r, srcu_idx;
+	const u64 supported_flags = KVM_S390_MEMOP_F_INJECT_EXCEPTION
+				    | KVM_S390_MEMOP_F_CHECK_ONLY;
+
+	if (mop->flags & ~supported_flags)
+		return -EINVAL;
+
+	if (mop->size > MEM_OP_MAX_SIZE)
+		return -E2BIG;
+
+	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
+		tmpbuf = vmalloc(mop->size);
+		if (!tmpbuf)
+			return -ENOMEM;
+	}
+
+	srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+
+	switch (mop->op) {
+	case KVM_S390_MEMOP_LOGICAL_READ:
+		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
+			r = check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size, false);
+			break;
+		}
+		r = read_guest(vcpu, mop->gaddr, mop->ar, tmpbuf, mop->size);
+		if (r == 0) {
+			if (copy_to_user(uaddr, tmpbuf, mop->size))
+				r = -EFAULT;
+		}
+		break;
+	case KVM_S390_MEMOP_LOGICAL_WRITE:
+		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
+			r = check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size, true);
+			break;
+		}
+		if (copy_from_user(tmpbuf, uaddr, mop->size)) {
+			r = -EFAULT;
+			break;
+		}
+		r = write_guest(vcpu, mop->gaddr, mop->ar, tmpbuf, mop->size);
+		break;
+	default:
+		r = -EINVAL;
+	}
+
+	srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
+
+	if (r > 0 && (mop->flags & KVM_S390_MEMOP_F_INJECT_EXCEPTION) != 0)
+		kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
+
+	vfree(tmpbuf);
+	return r;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
@@ -2284,6 +2349,15 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
 		break;
 	}
+	case KVM_S390_MEM_OP: {
+		struct kvm_s390_mem_op mem_op;
+
+		if (copy_from_user(&mem_op, argp, sizeof(mem_op)) == 0)
+			r = kvm_s390_guest_mem_op(vcpu, &mem_op);
+		else
+			r = -EFAULT;
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 82634a4..0e16f2c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -365,6 +365,24 @@ struct kvm_translation {
 	__u8  pad[5];
 };
 
+/* for KVM_S390_MEM_OP */
+struct kvm_s390_mem_op {
+	/* in */
+	__u64 gaddr;		/* the guest address */
+	__u64 flags;		/* flags */
+	__u32 size;		/* amount of bytes */
+	__u32 op;		/* type of operation */
+	__u64 buf;		/* buffer in userspace */
+	__u8 ar;		/* the access register number */
+	__u8 reserved[31];	/* should be set to 0 */
+};
+/* types for kvm_s390_mem_op->op */
+#define KVM_S390_MEMOP_LOGICAL_READ	0
+#define KVM_S390_MEMOP_LOGICAL_WRITE	1
+/* flags for kvm_s390_mem_op->flags */
+#define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
+#define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
+
 /* for KVM_INTERRUPT */
 struct kvm_interrupt {
 	/* in */
@@ -761,6 +779,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_CHECK_EXTENSION_VM 105
 #define KVM_CAP_S390_USER_SIGP 106
 #define KVM_CAP_S390_VECTOR_REGISTERS 107
+#define KVM_CAP_S390_MEM_OP 108
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1136,6 +1155,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_ARM_VCPU_INIT	  _IOW(KVMIO,  0xae, struct kvm_vcpu_init)
 #define KVM_ARM_PREFERRED_TARGET  _IOR(KVMIO,  0xaf, struct kvm_vcpu_init)
 #define KVM_GET_REG_LIST	  _IOWR(KVMIO, 0xb0, struct kvm_reg_list)
+/* Available with KVM_CAP_S390_MEM_OP */
+#define KVM_S390_MEM_OP		  _IOW(KVMIO,  0xb1, struct kvm_s390_mem_op)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
-- 
2.3.0
