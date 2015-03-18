From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/11] KVM: s390: Create ioctl for Getting/Setting guest storage keys
Date: Wed, 18 Mar 2015 12:44:07 +0100
Message-ID: <1426679049-37696-10-git-send-email-borntraeger@de.ibm.com>
References: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

Provide the KVM_S390_GET_SKEYS and KVM_S390_SET_SKEYS ioctl which can be used
to get/set guest storage keys. This functionality is needed for live migration
of s390 guests that use storage keys.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt |  58 ++++++++++++++++++
 arch/s390/kvm/kvm-s390.c          | 123 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |  14 +++++
 3 files changed, 195 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index c1fcb7a..0d7fc66 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2762,6 +2762,64 @@ register number to be used.
 The "reserved" field is meant for future extensions. It is not used by
 KVM with the currently defined set of flags.
 
+4.90 KVM_S390_GET_SKEYS
+
+Capability: KVM_CAP_S390_SKEYS
+Architectures: s390
+Type: vm ioctl
+Parameters: struct kvm_s390_skeys
+Returns: 0 on success, KVM_S390_GET_KEYS_NONE if guest is not using storage
+         keys, negative value on error
+
+This ioctl is used to get guest storage key values on the s390
+architecture. The ioctl takes parameters via the kvm_s390_skeys struct.
+
+struct kvm_s390_skeys {
+	__u64 start_gfn;
+	__u64 count;
+	__u64 skeydata_addr;
+	__u32 flags;
+	__u32 reserved[9];
+};
+
+The start_gfn field is the number of the first guest frame whose storage keys
+you want to get.
+
+The count field is the number of consecutive frames (starting from start_gfn)
+whose storage keys to get. The count field must be at least 1 and the maximum
+allowed value is defined as KVM_S390_SKEYS_ALLOC_MAX. Values outside this range
+will cause the ioctl to return -EINVAL.
+
+The skeydata_addr field is the address to a buffer large enough to hold count
+bytes. This buffer will be filled with storage key data by the ioctl.
+
+4.91 KVM_S390_SET_SKEYS
+
+Capability: KVM_CAP_S390_SKEYS
+Architectures: s390
+Type: vm ioctl
+Parameters: struct kvm_s390_skeys
+Returns: 0 on success, negative value on error
+
+This ioctl is used to set guest storage key values on the s390
+architecture. The ioctl takes parameters via the kvm_s390_skeys struct.
+See section on KVM_S390_GET_SKEYS for struct definition.
+
+The start_gfn field is the number of the first guest frame whose storage keys
+you want to set.
+
+The count field is the number of consecutive frames (starting from start_gfn)
+whose storage keys to get. The count field must be at least 1 and the maximum
+allowed value is defined as KVM_S390_SKEYS_ALLOC_MAX. Values outside this range
+will cause the ioctl to return -EINVAL.
+
+The skeydata_addr field is the address to a buffer containing count bytes of
+storage keys. Each byte in the buffer will be set as the storage key for a
+single frame starting at start_gfn for count frames.
+
+Note: If any architecturally invalid key value is found in the given data then
+the ioctl will return -EINVAL.
+
 5. The kvm_run structure
 ------------------------
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fdfa106..0dc22ba 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -179,6 +179,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MP_STATE:
 	case KVM_CAP_S390_USER_SIGP:
 	case KVM_CAP_S390_USER_STSI:
+	case KVM_CAP_S390_SKEYS:
 		r = 1;
 		break;
 	case KVM_CAP_S390_MEM_OP:
@@ -729,6 +730,108 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 	return ret;
 }
 
+static long kvm_s390_get_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
+{
+	uint8_t *keys;
+	uint64_t hva;
+	unsigned long curkey;
+	int i, r = 0;
+
+	if (args->flags != 0)
+		return -EINVAL;
+
+	/* Is this guest using storage keys? */
+	if (!mm_use_skey(current->mm))
+		return KVM_S390_GET_SKEYS_NONE;
+
+	/* Enforce sane limit on memory allocation */
+	if (args->count < 1 || args->count > KVM_S390_SKEYS_MAX)
+		return -EINVAL;
+
+	keys = kmalloc_array(args->count, sizeof(uint8_t),
+			     GFP_KERNEL | __GFP_NOWARN);
+	if (!keys)
+		keys = vmalloc(sizeof(uint8_t) * args->count);
+	if (!keys)
+		return -ENOMEM;
+
+	for (i = 0; i < args->count; i++) {
+		hva = gfn_to_hva(kvm, args->start_gfn + i);
+		if (kvm_is_error_hva(hva)) {
+			r = -EFAULT;
+			goto out;
+		}
+
+		curkey = get_guest_storage_key(current->mm, hva);
+		if (IS_ERR_VALUE(curkey)) {
+			r = curkey;
+			goto out;
+		}
+		keys[i] = curkey;
+	}
+
+	r = copy_to_user((uint8_t __user *)args->skeydata_addr, keys,
+			 sizeof(uint8_t) * args->count);
+	if (r)
+		r = -EFAULT;
+out:
+	kvfree(keys);
+	return r;
+}
+
+static long kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
+{
+	uint8_t *keys;
+	uint64_t hva;
+	int i, r = 0;
+
+	if (args->flags != 0)
+		return -EINVAL;
+
+	/* Enforce sane limit on memory allocation */
+	if (args->count < 1 || args->count > KVM_S390_SKEYS_MAX)
+		return -EINVAL;
+
+	keys = kmalloc_array(args->count, sizeof(uint8_t),
+			     GFP_KERNEL | __GFP_NOWARN);
+	if (!keys)
+		keys = vmalloc(sizeof(uint8_t) * args->count);
+	if (!keys)
+		return -ENOMEM;
+
+	r = copy_from_user(keys, (uint8_t __user *)args->skeydata_addr,
+			   sizeof(uint8_t) * args->count);
+	if (r) {
+		r = -EFAULT;
+		goto out;
+	}
+
+	/* Enable storage key handling for the guest */
+	s390_enable_skey();
+
+	for (i = 0; i < args->count; i++) {
+		hva = gfn_to_hva(kvm, args->start_gfn + i);
+		if (kvm_is_error_hva(hva)) {
+			r = -EFAULT;
+			goto out;
+		}
+
+		/* Lowest order bit is reserved */
+		if (keys[i] & 0x01) {
+			r = -EINVAL;
+			goto out;
+		}
+
+		r = set_guest_storage_key(current->mm, hva,
+					  (unsigned long)keys[i], 0);
+		if (r)
+			goto out;
+	}
+out:
+	kvfree(keys);
+	return r;
+}
+
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg)
 {
@@ -788,6 +891,26 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = kvm_s390_vm_has_attr(kvm, &attr);
 		break;
 	}
+	case KVM_S390_GET_SKEYS: {
+		struct kvm_s390_skeys args;
+
+		r = -EFAULT;
+		if (copy_from_user(&args, argp,
+				   sizeof(struct kvm_s390_skeys)))
+			break;
+		r = kvm_s390_get_skeys(kvm, &args);
+		break;
+	}
+	case KVM_S390_SET_SKEYS: {
+		struct kvm_s390_skeys args;
+
+		r = -EFAULT;
+		if (copy_from_user(&args, argp,
+				   sizeof(struct kvm_s390_skeys)))
+			break;
+		r = kvm_s390_set_skeys(kvm, &args);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 57445ef..1162ef7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -147,6 +147,16 @@ struct kvm_pit_config {
 
 #define KVM_PIT_SPEAKER_DUMMY     1
 
+struct kvm_s390_skeys {
+	__u64 start_gfn;
+	__u64 count;
+	__u64 skeydata_addr;
+	__u32 flags;
+	__u32 reserved[9];
+};
+#define KVM_S390_GET_SKEYS_NONE   1
+#define KVM_S390_SKEYS_MAX        1048576
+
 #define KVM_EXIT_UNKNOWN          0
 #define KVM_EXIT_EXCEPTION        1
 #define KVM_EXIT_IO               2
@@ -791,6 +801,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_VECTOR_REGISTERS 107
 #define KVM_CAP_S390_MEM_OP 108
 #define KVM_CAP_S390_USER_STSI 109
+#define KVM_CAP_S390_SKEYS 110
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1168,6 +1179,9 @@ struct kvm_s390_ucas_mapping {
 #define KVM_GET_REG_LIST	  _IOWR(KVMIO, 0xb0, struct kvm_reg_list)
 /* Available with KVM_CAP_S390_MEM_OP */
 #define KVM_S390_MEM_OP		  _IOW(KVMIO,  0xb1, struct kvm_s390_mem_op)
+/* Available with KVM_CAP_S390_SKEYS */
+#define KVM_S390_GET_SKEYS      _IOW(KVMIO, 0xb2, struct kvm_s390_skeys)
+#define KVM_S390_SET_SKEYS      _IOW(KVMIO, 0xb3, struct kvm_s390_skeys)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
-- 
2.3.0
