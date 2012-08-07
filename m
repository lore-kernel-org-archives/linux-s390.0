From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/5] Update headers for upcoming s390 changes.
Date: Tue,  7 Aug 2012 16:52:49 +0200
Message-ID: <1344351173-2716-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1344351173-2716-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1344351173-2716-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 linux-headers/asm-s390/kvm.h      |  2 +-
 linux-headers/asm-s390/kvm_para.h |  2 +-
 linux-headers/linux/kvm.h         | 63 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index bdcbe0f..d25da59 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_KVM_S390_H
 #define __LINUX_KVM_S390_H
 /*
- * asm-s390/kvm.h - KVM s390 specific structures and definitions
+ * KVM s390 specific structures and definitions
  *
  * Copyright IBM Corp. 2008
  *
diff --git a/linux-headers/asm-s390/kvm_para.h b/linux-headers/asm-s390/kvm_para.h
index 8e2dd67..870051f 100644
--- a/linux-headers/asm-s390/kvm_para.h
+++ b/linux-headers/asm-s390/kvm_para.h
@@ -1,5 +1,5 @@
 /*
- * asm-s390/kvm_para.h - definition for paravirtual devices on s390
+ * definition for paravirtual devices on s390
  *
  * Copyright IBM Corp. 2008
  *
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 5a9d4e3..a813a1c 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -163,6 +163,7 @@ struct kvm_pit_config {
 #define KVM_EXIT_OSI              18
 #define KVM_EXIT_PAPR_HCALL	  19
 #define KVM_EXIT_S390_UCONTROL	  20
+#define KVM_EXIT_S390_SCH_IO      21
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 #define KVM_INTERNAL_ERROR_EMULATION 1
@@ -276,6 +277,20 @@ struct kvm_run {
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
@@ -388,10 +403,17 @@ struct kvm_s390_psw {
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
@@ -473,6 +495,39 @@ struct kvm_ppc_smmu_info {
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
 #define KVMIO 0xAE
 
 /* machine type bits, to be used as argument to KVM_CREATE_VM */
@@ -617,6 +672,8 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_SIGNAL_MSI 77
 #define KVM_CAP_PPC_GET_SMMU_INFO 78
 #define KVM_CAP_S390_COW 79
+#define KVM_CAP_PPC_ALLOC_HTAB 80
+#define KVM_CAP_S390_CSS_SUPPORT 81
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -828,6 +885,12 @@ struct kvm_s390_ucas_mapping {
 #define KVM_SIGNAL_MSI            _IOW(KVMIO,  0xa5, struct kvm_msi)
 /* Available with KVM_CAP_PPC_GET_SMMU_INFO */
 #define KVM_PPC_GET_SMMU_INFO	  _IOR(KVMIO,  0xa6, struct kvm_ppc_smmu_info)
+/* Available with KVM_CAP_PPC_ALLOC_HTAB */
+#define KVM_PPC_ALLOCATE_HTAB	  _IOWR(KVMIO, 0xa7, __u32)
+/* Available with KVM_CAP_S390_CSS_SUPPORT */
+#define KVM_S390_CSS_NOTIFY       _IOW(KVMIO, 0xae, struct kvm_css_notify)
+#define KVM_S390_CCW_HOTPLUG      _IOW(KVMIO, 0xab, struct kvm_s390_sch_info)
+#define KVM_S390_CHP_HOTPLUG      _IOW(KVMIO, 0xac, struct kvm_s390_chp_info)
 
 /*
  * ioctls for vcpu fds
-- 
1.7.11.4
