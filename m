From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2 1/5] Update headers for upcoming s390 changes.
Date: Tue,  4 Sep 2012 17:13:49 +0200
Message-ID: <1346771633-53081-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---

Changes v1->v2:
- update to latest kvm interface changes

---
 linux-headers/asm-generic/kvm_para.h |  5 +++
 linux-headers/asm-x86/kvm.h          |  1 +
 linux-headers/linux/kvm.h            | 80 ++++++++++++++++++++++++++++++++++--
 3 files changed, 83 insertions(+), 3 deletions(-)
 create mode 100644 linux-headers/asm-generic/kvm_para.h

diff --git a/linux-headers/asm-generic/kvm_para.h b/linux-headers/asm-generic/kvm_para.h
new file mode 100644
index 0000000..63df88b
--- /dev/null
+++ b/linux-headers/asm-generic/kvm_para.h
@@ -0,0 +1,5 @@
+#ifndef _ASM_GENERIC_KVM_PARA_H
+#define _ASM_GENERIC_KVM_PARA_H
+
+
+#endif
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 246617e..521bf25 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -25,6 +25,7 @@
 #define __KVM_HAVE_DEBUGREGS
 #define __KVM_HAVE_XSAVE
 #define __KVM_HAVE_XCRS
+#define __KVM_HAVE_READONLY_MEM
 
 /* Architectural interrupt line count. */
 #define KVM_NR_INTERRUPTS 256
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 4b9e575..1e87d71 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -101,9 +101,13 @@ struct kvm_userspace_memory_region {
 	__u64 userspace_addr; /* start of the userspace allocated memory */
 };
 
-/* for kvm_memory_region::flags */
-#define KVM_MEM_LOG_DIRTY_PAGES  1UL
-#define KVM_MEMSLOT_INVALID      (1UL << 1)
+/*
+ * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
+ * other bits are reserved for kvm internal use which are defined in
+ * include/linux/kvm_host.h.
+ */
+#define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
+#define KVM_MEM_READONLY	(1UL << 1)
 
 /* for KVM_IRQ_LINE */
 struct kvm_irq_level {
@@ -163,6 +167,7 @@ struct kvm_pit_config {
 #define KVM_EXIT_OSI              18
 #define KVM_EXIT_PAPR_HCALL	  19
 #define KVM_EXIT_S390_UCONTROL	  20
+#define KVM_EXIT_S390_SCH_IO      21
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 #define KVM_INTERNAL_ERROR_EMULATION 1
@@ -276,6 +281,20 @@ struct kvm_run {
 			__u64 ret;
 			__u64 args[9];
 		} papr_hcall;
+		/* KVM_EXIT_S390_SCH_IO */
+		struct {
+			__u32 sch_id;
+#define SCH_DO_CSCH 0
+#define SCH_DO_HSCH 1
+#define SCH_DO_SSCH 2
+#define SCH_DO_RSCH 3
+#define SCH_DO_XSCH 4
+			__u8 func;
+			__u8 pad;
+			__u64 orb;
+			__u32 scsw[3];
+			__u32 pmcw[7];
+		} s390_sch_io;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -388,10 +407,17 @@ struct kvm_s390_psw {
 #define KVM_S390_PROGRAM_INT		0xfffe0001u
 #define KVM_S390_SIGP_SET_PREFIX	0xfffe0002u
 #define KVM_S390_RESTART		0xfffe0003u
+#define KVM_S390_MCHK			0xfffe1000u
 #define KVM_S390_INT_VIRTIO		0xffff2603u
 #define KVM_S390_INT_SERVICE		0xffff2401u
 #define KVM_S390_INT_EMERGENCY		0xffff1201u
 #define KVM_S390_INT_EXTERNAL_CALL	0xffff1202u
+#define KVM_S390_INT_IO(ai,cssid,ssid,schid)   \
+	(((schid)) |			       \
+	 ((ssid) << 16) |		       \
+	 ((cssid) << 18) |		       \
+	 ((ai) << 26))
+
 
 struct kvm_s390_interrupt {
 	__u32 type;
@@ -473,6 +499,45 @@ struct kvm_ppc_smmu_info {
 	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
 };
 
+/* for KVM_S390_CSS_NOTIFY */
+struct kvm_css_notify {
+	__u8 cssid;
+	__u8 ssid;
+	__u16 schid;
+	__u32 scsw[3];
+	__u32 pmcw[7];
+	__u8 sense_data[32];
+	__u8 unsolicited;
+	__u8 func;
+};
+
+/* for KVM_S390_CCW_HOTPLUG */
+struct kvm_s390_sch_info {
+	__u8 cssid;
+	__u8 ssid;
+	__u16 schid;
+	__u16 devno;
+	__u32 schib[12];
+	int hotplugged;
+	int add;
+	int virtual;
+};
+
+/* for KVM_S390_CHP_HOTPLUG */
+struct kvm_s390_chp_info {
+	__u8 cssid;
+	__u8 chpid;
+	__u8 type;
+	int add;
+	int virtual;
+};
+
+/* for KVM_S390_ADD_CSS */
+struct kvm_s390_css_info {
+	__u8 cssid;
+	__u8 default_image;
+};
+
 #define KVMIO 0xAE
 
 /* machine type bits, to be used as argument to KVM_CREATE_VM */
@@ -618,6 +683,10 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_PPC_GET_SMMU_INFO 78
 #define KVM_CAP_S390_COW 79
 #define KVM_CAP_PPC_ALLOC_HTAB 80
+#ifdef __KVM_HAVE_READONLY_MEM
+#define KVM_CAP_READONLY_MEM 81
+#endif
+#define KVM_CAP_S390_CSS_SUPPORT 82
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -831,6 +900,11 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_GET_SMMU_INFO	  _IOR(KVMIO,  0xa6, struct kvm_ppc_smmu_info)
 /* Available with KVM_CAP_PPC_ALLOC_HTAB */
 #define KVM_PPC_ALLOCATE_HTAB	  _IOWR(KVMIO, 0xa7, __u32)
+/* Available with KVM_CAP_S390_CSS_SUPPORT */
+#define KVM_S390_CSS_NOTIFY       _IOW(KVMIO, 0xae, struct kvm_css_notify)
+#define KVM_S390_CCW_HOTPLUG      _IOW(KVMIO, 0xab, struct kvm_s390_sch_info)
+#define KVM_S390_CHP_HOTPLUG      _IOW(KVMIO, 0xac, struct kvm_s390_chp_info)
+#define KVM_S390_ADD_CSS          _IOW(KVMIO, 0xad, struct kvm_s390_css_info)
 
 /*
  * ioctls for vcpu fds
-- 
1.7.11.5
