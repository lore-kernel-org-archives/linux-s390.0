From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 6/8] KVM: s390: add ioctl to inject local interrupts
Date: Tue, 31 Mar 2015 15:02:01 +0200
Message-ID: <1427806923-21910-7-git-send-email-borntraeger@de.ibm.com>
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

We have introduced struct kvm_s390_irq a while ago which allows to
inject all kinds of interrupts as defined in the Principles of
Operation.
Add ioctl to inject interrupts with the extended struct kvm_s390_irq

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 56 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c          | 10 +++++++
 include/uapi/linux/kvm.h          |  3 +++
 virt/kvm/kvm_main.c               |  2 +-
 4 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 0d7fc66..a7c651d 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2820,6 +2820,62 @@ single frame starting at start_gfn for count frames.
 Note: If any architecturally invalid key value is found in the given data then
 the ioctl will return -EINVAL.
 
+4.92 KVM_S390_IRQ
+
+Capability: KVM_CAP_S390_INJECT_IRQ
+Architectures: s390
+Type: vcpu ioctl
+Parameters: struct kvm_s390_irq (in)
+Returns: 0 on success, -1 on error
+Errors:
+  EINVAL: interrupt type is invalid
+          type is KVM_S390_SIGP_STOP and flag parameter is invalid value
+          type is KVM_S390_INT_EXTERNAL_CALL and code is bigger
+            than the maximum of VCPUs
+  EBUSY:  type is KVM_S390_SIGP_SET_PREFIX and vcpu is not stopped
+          type is KVM_S390_SIGP_STOP and a stop irq is already pending
+          type is KVM_S390_INT_EXTERNAL_CALL and an external call interrupt
+            is already pending
+
+Allows to inject an interrupt to the guest.
+
+Using struct kvm_s390_irq as a parameter allows
+to inject additional payload which is not
+possible via KVM_S390_INTERRUPT.
+
+Interrupt parameters are passed via kvm_s390_irq:
+
+struct kvm_s390_irq {
+	__u64 type;
+	union {
+		struct kvm_s390_io_info io;
+		struct kvm_s390_ext_info ext;
+		struct kvm_s390_pgm_info pgm;
+		struct kvm_s390_emerg_info emerg;
+		struct kvm_s390_extcall_info extcall;
+		struct kvm_s390_prefix_info prefix;
+		struct kvm_s390_stop_info stop;
+		struct kvm_s390_mchk_info mchk;
+		char reserved[64];
+	} u;
+};
+
+type can be one of the following:
+
+KVM_S390_SIGP_STOP - sigp stop; parameter in .stop
+KVM_S390_PROGRAM_INT - program check; parameters in .pgm
+KVM_S390_SIGP_SET_PREFIX - sigp set prefix; parameters in .prefix
+KVM_S390_RESTART - restart; no parameters
+KVM_S390_INT_CLOCK_COMP - clock comparator interrupt; no parameters
+KVM_S390_INT_CPU_TIMER - CPU timer interrupt; no parameters
+KVM_S390_INT_EMERGENCY - sigp emergency; parameters in .emerg
+KVM_S390_INT_EXTERNAL_CALL - sigp external call; parameters in .extcall
+KVM_S390_MCHK - machine check interrupt; parameters in .mchk
+
+
+Note that the vcpu ioctl is asynchronous to vcpu execution.
+
+
 5. The kvm_run structure
 ------------------------
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index dbc9ca3..8bc25d4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -177,6 +177,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_IRQCHIP:
 	case KVM_CAP_VM_ATTRIBUTES:
 	case KVM_CAP_MP_STATE:
+	case KVM_CAP_S390_INJECT_IRQ:
 	case KVM_CAP_S390_USER_SIGP:
 	case KVM_CAP_S390_USER_STSI:
 	case KVM_CAP_S390_SKEYS:
@@ -2391,6 +2392,15 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	long r;
 
 	switch (ioctl) {
+	case KVM_S390_IRQ: {
+		struct kvm_s390_irq s390irq;
+
+		r = -EFAULT;
+		if (copy_from_user(&s390irq, argp, sizeof(s390irq)))
+			break;
+		r = kvm_s390_inject_vcpu(vcpu, &s390irq);
+		break;
+	}
 	case KVM_S390_INTERRUPT: {
 		struct kvm_s390_interrupt s390int;
 		struct kvm_s390_irq s390irq;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 1162ef7..e61f49a 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -802,6 +802,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_MEM_OP 108
 #define KVM_CAP_S390_USER_STSI 109
 #define KVM_CAP_S390_SKEYS 110
+#define KVM_CAP_S390_INJECT_IRQ 111
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1182,6 +1183,8 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_S390_SKEYS */
 #define KVM_S390_GET_SKEYS      _IOW(KVMIO, 0xb2, struct kvm_s390_skeys)
 #define KVM_S390_SET_SKEYS      _IOW(KVMIO, 0xb3, struct kvm_s390_skeys)
+/* Available with KVM_CAP_S390_INJECT_IRQ */
+#define KVM_S390_IRQ              _IOW(KVMIO,  0xb4, struct kvm_s390_irq)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a109370..34310a8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2118,7 +2118,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 	 * Special cases: vcpu ioctls that are asynchronous to vcpu execution,
 	 * so vcpu_load() would break it.
 	 */
-	if (ioctl == KVM_S390_INTERRUPT || ioctl == KVM_INTERRUPT)
+	if (ioctl == KVM_S390_INTERRUPT || ioctl == KVM_S390_IRQ || ioctl == KVM_INTERRUPT)
 		return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
 #endif
 
-- 
2.3.0
