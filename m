From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 8/8] KVM: s390: migrate vcpu interrupt state
Date: Tue, 31 Mar 2015 15:02:03 +0200
Message-ID: <1427806923-21910-9-git-send-email-borntraeger@de.ibm.com>
References: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

This patch adds support to migrate vcpu interrupts. Two new vcpu ioctls
are added which get/set the complete status of pending interrupts in one
go. The ioctls are marked as available with the new capability
KVM_CAP_S390_IRQ_STATE.

We can not use a ONEREG, as the number of pending local interrupts is not
constant and depends on the number of CPUs.

To retrieve the interrupt state we add an ioctl KVM_S390_GET_IRQ_STATE.
Its input parameter is a pointer to a struct kvm_s390_irq_state which
has a buffer and length.  For all currently pending interrupts, we copy
a struct kvm_s390_irq into the buffer and pass it to userspace.

To store interrupt state into a buffer provided by userspace, we add an
ioctl KVM_S390_SET_IRQ_STATE. It passes a struct kvm_s390_irq_state into
the kernel and injects all interrupts contained in the buffer.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt |  61 +++++++++++++++++
 arch/s390/kvm/interrupt.c         | 140 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c          |  36 ++++++++++
 arch/s390/kvm/kvm-s390.h          |   4 ++
 include/uapi/linux/kvm.h          |  11 +++
 5 files changed, 252 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index a7c651d..18fb763 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2875,6 +2875,67 @@ KVM_S390_MCHK - machine check interrupt; parameters in .mchk
 
 Note that the vcpu ioctl is asynchronous to vcpu execution.
 
+4.94 KVM_S390_GET_IRQ_STATE
+
+Capability: KVM_CAP_S390_IRQ_STATE
+Architectures: s390
+Type: vcpu ioctl
+Parameters: struct kvm_s390_irq_state (out)
+Returns: >= number of bytes copied into buffer,
+         -EINVAL if buffer size is 0,
+         -ENOBUFS if buffer size is too small to fit all pending interrupts,
+         -EFAULT if the buffer address was invalid
+
+This ioctl allows userspace to retrieve the complete state of all currently
+pending interrupts in a single buffer. Use cases include migration
+and introspection. The parameter structure contains the address of a
+userspace buffer and its length:
+
+struct kvm_s390_irq_state {
+	__u64 buf;
+	__u32 flags;
+	__u32 len;
+	__u32 reserved[4];
+};
+
+Userspace passes in the above struct and for each pending interrupt a
+struct kvm_s390_irq is copied to the provided buffer.
+
+If -ENOBUFS is returned the buffer provided was too small and userspace
+may retry with a bigger buffer.
+
+4.95 KVM_S390_SET_IRQ_STATE
+
+Capability: KVM_CAP_S390_IRQ_STATE
+Architectures: s390
+Type: vcpu ioctl
+Parameters: struct kvm_s390_irq_state (in)
+Returns: 0 on success,
+         -EFAULT if the buffer address was invalid,
+         -EINVAL for an invalid buffer length (see below),
+         -EBUSY if there were already interrupts pending,
+         errors occurring when actually injecting the
+          interrupt. See KVM_S390_IRQ.
+
+This ioctl allows userspace to set the complete state of all cpu-local
+interrupts currently pending for the vcpu. It is intended for restoring
+interrupt state after a migration. The input parameter is a userspace buffer
+containing a struct kvm_s390_irq_state:
+
+struct kvm_s390_irq_state {
+	__u64 buf;
+	__u32 len;
+	__u32 pad;
+};
+
+The userspace memory referenced by buf contains a struct kvm_s390_irq
+for each interrupt to be injected into the guest.
+If one of the interrupts could not be injected for some reason the
+ioctl aborts.
+
+len must be a multiple of sizeof(struct kvm_s390_irq). It must be > 0
+and it must not exceed (max_vcpus + 32) * sizeof(struct kvm_s390_irq),
+which is the maximum number of possibly pending cpu-local interrupts.
 
 5. The kvm_run structure
 ------------------------
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2f78f1a..ee2dfdc 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2125,3 +2125,143 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
 {
 	return -EINVAL;
 }
+
+int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, void __user *irqstate, int len)
+{
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_irq *buf;
+	int r = 0;
+	int n;
+
+	buf = vmalloc(len);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user((void *) buf, irqstate, len)) {
+		r = -EFAULT;
+		goto out_free;
+	}
+
+	/*
+	 * Don't allow setting the interrupt state
+	 * when there are already interrupts pending
+	 */
+	spin_lock(&li->lock);
+	if (li->pending_irqs) {
+		r = -EBUSY;
+		goto out_unlock;
+	}
+
+	for (n = 0; n < len / sizeof(*buf); n++) {
+		r = do_inject_vcpu(vcpu, &buf[n]);
+		if (r)
+			break;
+	}
+
+out_unlock:
+	spin_unlock(&li->lock);
+out_free:
+	vfree(buf);
+
+	return r;
+}
+
+static void store_local_irq(struct kvm_s390_local_interrupt *li,
+			    struct kvm_s390_irq *irq,
+			    unsigned long irq_type)
+{
+	switch (irq_type) {
+	case IRQ_PEND_MCHK_EX:
+	case IRQ_PEND_MCHK_REP:
+		irq->type = KVM_S390_MCHK;
+		irq->u.mchk = li->irq.mchk;
+		break;
+	case IRQ_PEND_PROG:
+		irq->type = KVM_S390_PROGRAM_INT;
+		irq->u.pgm = li->irq.pgm;
+		break;
+	case IRQ_PEND_PFAULT_INIT:
+		irq->type = KVM_S390_INT_PFAULT_INIT;
+		irq->u.ext = li->irq.ext;
+		break;
+	case IRQ_PEND_EXT_EXTERNAL:
+		irq->type = KVM_S390_INT_EXTERNAL_CALL;
+		irq->u.extcall = li->irq.extcall;
+		break;
+	case IRQ_PEND_EXT_CLOCK_COMP:
+		irq->type = KVM_S390_INT_CLOCK_COMP;
+		break;
+	case IRQ_PEND_EXT_CPU_TIMER:
+		irq->type = KVM_S390_INT_CPU_TIMER;
+		break;
+	case IRQ_PEND_SIGP_STOP:
+		irq->type = KVM_S390_SIGP_STOP;
+		irq->u.stop = li->irq.stop;
+		break;
+	case IRQ_PEND_RESTART:
+		irq->type = KVM_S390_RESTART;
+		break;
+	case IRQ_PEND_SET_PREFIX:
+		irq->type = KVM_S390_SIGP_SET_PREFIX;
+		irq->u.prefix = li->irq.prefix;
+		break;
+	}
+}
+
+int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
+{
+	uint8_t sigp_ctrl = vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sigp_ctrl;
+	unsigned long sigp_emerg_pending[BITS_TO_LONGS(KVM_MAX_VCPUS)];
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	unsigned long pending_irqs;
+	struct kvm_s390_irq irq;
+	unsigned long irq_type;
+	int cpuaddr;
+	int n = 0;
+
+	spin_lock(&li->lock);
+	pending_irqs = li->pending_irqs;
+	memcpy(&sigp_emerg_pending, &li->sigp_emerg_pending,
+	       sizeof(sigp_emerg_pending));
+	spin_unlock(&li->lock);
+
+	for_each_set_bit(irq_type, &pending_irqs, IRQ_PEND_COUNT) {
+		memset(&irq, 0, sizeof(irq));
+		if (irq_type == IRQ_PEND_EXT_EMERGENCY)
+			continue;
+		if (n + sizeof(irq) > len)
+			return -ENOBUFS;
+		store_local_irq(&vcpu->arch.local_int, &irq, irq_type);
+		if (copy_to_user(&buf[n], &irq, sizeof(irq)))
+			return -EFAULT;
+		n += sizeof(irq);
+	}
+
+	if (test_bit(IRQ_PEND_EXT_EMERGENCY, &pending_irqs)) {
+		for_each_set_bit(cpuaddr, sigp_emerg_pending, KVM_MAX_VCPUS) {
+			memset(&irq, 0, sizeof(irq));
+			if (n + sizeof(irq) > len)
+				return -ENOBUFS;
+			irq.type = KVM_S390_INT_EMERGENCY;
+			irq.u.emerg.code = cpuaddr;
+			if (copy_to_user(&buf[n], &irq, sizeof(irq)))
+				return -EFAULT;
+			n += sizeof(irq);
+		}
+	}
+
+	if ((sigp_ctrl & SIGP_CTRL_C) &&
+	    (atomic_read(&vcpu->arch.sie_block->cpuflags) &
+	     CPUSTAT_ECALL_PEND)) {
+		if (n + sizeof(irq) > len)
+			return -ENOBUFS;
+		memset(&irq, 0, sizeof(irq));
+		irq.type = KVM_S390_INT_EXTERNAL_CALL;
+		irq.u.extcall.code = sigp_ctrl & SIGP_CTRL_SCN_MASK;
+		if (copy_to_user(&buf[n], &irq, sizeof(irq)))
+			return -EFAULT;
+		n += sizeof(irq);
+	}
+
+	return n;
+}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8bc25d4..3040b14 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -41,6 +41,9 @@
 #include "trace-s390.h"
 
 #define MEM_OP_MAX_SIZE 65536	/* Maximum transfer size for KVM_S390_MEM_OP */
+#define LOCAL_IRQS 32
+#define VCPU_IRQS_MAX_BUF (sizeof(struct kvm_s390_irq) * \
+			   (KVM_MAX_VCPUS + LOCAL_IRQS))
 
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
 
@@ -181,6 +184,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_USER_SIGP:
 	case KVM_CAP_S390_USER_STSI:
 	case KVM_CAP_S390_SKEYS:
+	case KVM_CAP_S390_IRQ_STATE:
 		r = 1;
 		break;
 	case KVM_CAP_S390_MEM_OP:
@@ -2500,6 +2504,38 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			r = -EFAULT;
 		break;
 	}
+	case KVM_S390_SET_IRQ_STATE: {
+		struct kvm_s390_irq_state irq_state;
+
+		r = -EFAULT;
+		if (copy_from_user(&irq_state, argp, sizeof(irq_state)))
+			break;
+		if (irq_state.len > VCPU_IRQS_MAX_BUF ||
+		    irq_state.len == 0 ||
+		    irq_state.len % sizeof(struct kvm_s390_irq) > 0) {
+			r = -EINVAL;
+			break;
+		}
+		r = kvm_s390_set_irq_state(vcpu,
+					   (void __user *) irq_state.buf,
+					   irq_state.len);
+		break;
+	}
+	case KVM_S390_GET_IRQ_STATE: {
+		struct kvm_s390_irq_state irq_state;
+
+		r = -EFAULT;
+		if (copy_from_user(&irq_state, argp, sizeof(irq_state)))
+			break;
+		if (irq_state.len == 0) {
+			r = -EINVAL;
+			break;
+		}
+		r = kvm_s390_get_irq_state(vcpu,
+					   (__u8 __user *)  irq_state.buf,
+					   irq_state.len);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 343644a..ca108b9 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -272,6 +272,10 @@ int kvm_s390_ext_call_pending(struct kvm_vcpu *vcpu);
 extern struct kvm_device_ops kvm_flic_ops;
 int kvm_s390_is_stop_irq_pending(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_stop_irq(struct kvm_vcpu *vcpu);
+int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu,
+			   void __user *buf, int len);
+int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu,
+			   __u8 __user *buf, int len);
 
 /* implemented in guestdbg.c */
 void kvm_s390_backup_guest_per_regs(struct kvm_vcpu *vcpu);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e61f49a..7437ce9 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -558,6 +558,13 @@ struct kvm_s390_irq {
 	} u;
 };
 
+struct kvm_s390_irq_state {
+	__u64 buf;
+	__u32 flags;
+	__u32 len;
+	__u32 reserved[4];
+};
+
 /* for KVM_SET_GUEST_DEBUG */
 
 #define KVM_GUESTDBG_ENABLE		0x00000001
@@ -803,6 +810,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_USER_STSI 109
 #define KVM_CAP_S390_SKEYS 110
 #define KVM_CAP_S390_INJECT_IRQ 111
+#define KVM_CAP_S390_IRQ_STATE 112
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1185,6 +1193,9 @@ struct kvm_s390_ucas_mapping {
 #define KVM_S390_SET_SKEYS      _IOW(KVMIO, 0xb3, struct kvm_s390_skeys)
 /* Available with KVM_CAP_S390_INJECT_IRQ */
 #define KVM_S390_IRQ              _IOW(KVMIO,  0xb4, struct kvm_s390_irq)
+/* Available with KVM_CAP_S390_IRQ_STATE */
+#define KVM_S390_SET_IRQ_STATE	  _IOW(KVMIO, 0xb5, struct kvm_s390_irq_state)
+#define KVM_S390_GET_IRQ_STATE	  _IOW(KVMIO, 0xb6, struct kvm_s390_irq_state)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
-- 
2.3.0
