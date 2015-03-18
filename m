From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/11] KVM: s390: introduce post handlers for STSI
Date: Wed, 18 Mar 2015 12:44:06 +0100
Message-ID: <1426679049-37696-9-git-send-email-borntraeger@de.ibm.com>
References: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>

The Store System Information (STSI) instruction currently collects all
information it relays to the caller in the kernel. Some information,
however, is only available in user space. An example of this is the
guest name: The kernel always sets "KVMGuest", but user space knows the
actual guest name.

This patch introduces a new exit, KVM_EXIT_S390_STSI, guarded by a
capability that can be enabled by user space if it wants to be able to
insert such data. User space will be provided with the target buffer
and the requested STSI function code.

Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 28 ++++++++++++++++++++++++++++
 arch/s390/include/asm/kvm_host.h  |  1 +
 arch/s390/kvm/kvm-s390.c          |  5 +++++
 arch/s390/kvm/priv.c              | 17 ++++++++++++++++-
 include/uapi/linux/kvm.h          | 11 +++++++++++
 5 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 281179d..c1fcb7a 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3304,3 +3304,31 @@ Returns: 0 on success, negative value on error
 Allows use of the vector registers introduced with z13 processor, and
 provides for the synchronization between host and user space.  Will
 return -EINVAL if the machine does not support vectors.
+
+7.4 KVM_CAP_S390_USER_STSI
+
+Architectures: s390
+Parameters: none
+
+This capability allows post-handlers for the STSI instruction. After
+initial handling in the kernel, KVM exits to user space with
+KVM_EXIT_S390_STSI to allow user space to insert further data.
+
+Before exiting to userspace, kvm handlers should fill in s390_stsi field of
+vcpu->run:
+struct {
+	__u64 addr;
+	__u8 ar;
+	__u8 reserved;
+	__u8 fc;
+	__u8 sel1;
+	__u16 sel2;
+} s390_stsi;
+
+@addr - guest address of STSI SYSIB
+@fc   - function code
+@sel1 - selector 1
+@sel2 - selector 2
+@ar   - access register number
+
+KVM handlers should exit to userspace with rc = -EREMOTE.
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 347a333..2356a8c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -565,6 +565,7 @@ struct kvm_arch{
 	int use_vectors;
 	int user_cpu_state_ctrl;
 	int user_sigp;
+	int user_stsi;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 	wait_queue_head_t ipte_wq;
 	int ipte_lock_count;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b7ecef9..fdfa106 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -178,6 +178,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_VM_ATTRIBUTES:
 	case KVM_CAP_MP_STATE:
 	case KVM_CAP_S390_USER_SIGP:
+	case KVM_CAP_S390_USER_STSI:
 		r = 1;
 		break;
 	case KVM_CAP_S390_MEM_OP:
@@ -280,6 +281,10 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		kvm->arch.use_vectors = MACHINE_HAS_VX;
 		r = MACHINE_HAS_VX ? 0 : -EINVAL;
 		break;
+	case KVM_CAP_S390_USER_STSI:
+		kvm->arch.user_stsi = 1;
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index f4fe02e..5e4658d 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -496,6 +496,17 @@ static void handle_stsi_3_2_2(struct kvm_vcpu *vcpu, struct sysinfo_3_2_2 *mem)
 	ASCEBC(mem->vm[0].cpi, 16);
 }
 
+static void insert_stsi_usr_data(struct kvm_vcpu *vcpu, u64 addr, ar_t ar,
+				 u8 fc, u8 sel1, u16 sel2)
+{
+	vcpu->run->exit_reason = KVM_EXIT_S390_STSI;
+	vcpu->run->s390_stsi.addr = addr;
+	vcpu->run->s390_stsi.ar = ar;
+	vcpu->run->s390_stsi.fc = fc;
+	vcpu->run->s390_stsi.sel1 = sel1;
+	vcpu->run->s390_stsi.sel2 = sel2;
+}
+
 static int handle_stsi(struct kvm_vcpu *vcpu)
 {
 	int fc = (vcpu->run->s.regs.gprs[0] & 0xf0000000) >> 28;
@@ -556,11 +567,15 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 		rc = kvm_s390_inject_prog_cond(vcpu, rc);
 		goto out;
 	}
+	if (vcpu->kvm->arch.user_stsi) {
+		insert_stsi_usr_data(vcpu, operand2, ar, fc, sel1, sel2);
+		rc = -EREMOTE;
+	}
 	trace_kvm_s390_handle_stsi(vcpu, fc, sel1, sel2, operand2);
 	free_page(mem);
 	kvm_s390_set_psw_cc(vcpu, 0);
 	vcpu->run->s.regs.gprs[0] = 0;
-	return 0;
+	return rc;
 out_no_data:
 	kvm_s390_set_psw_cc(vcpu, 3);
 out:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 0e16f2c..57445ef 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -172,6 +172,7 @@ struct kvm_pit_config {
 #define KVM_EXIT_S390_TSCH        22
 #define KVM_EXIT_EPR              23
 #define KVM_EXIT_SYSTEM_EVENT     24
+#define KVM_EXIT_S390_STSI        25
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -309,6 +310,15 @@ struct kvm_run {
 			__u32 type;
 			__u64 flags;
 		} system_event;
+		/* KVM_EXIT_S390_STSI */
+		struct {
+			__u64 addr;
+			__u8 ar;
+			__u8 reserved;
+			__u8 fc;
+			__u8 sel1;
+			__u16 sel2;
+		} s390_stsi;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -780,6 +790,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_USER_SIGP 106
 #define KVM_CAP_S390_VECTOR_REGISTERS 107
 #define KVM_CAP_S390_MEM_OP 108
+#define KVM_CAP_S390_USER_STSI 109
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.3.0
