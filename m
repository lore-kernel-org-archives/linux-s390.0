From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 04/12] Update linux headers.
Date: Thu, 17 Jan 2013 15:23:49 +0100
Message-ID: <1358432637-42512-5-git-send-email-cornelia.huck@de.ibm.com>
References: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Base is kvm-next as of 2013/01/16.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 linux-headers/asm-generic/kvm_para.h |  4 ++++
 linux-headers/asm-powerpc/kvm_para.h |  2 +-
 linux-headers/linux/kvm.h            | 21 +++++++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 linux-headers/asm-generic/kvm_para.h

diff --git a/linux-headers/asm-generic/kvm_para.h b/linux-headers/asm-generic/kvm_para.h
new file mode 100644
index 0000000..486f0af
--- /dev/null
+++ b/linux-headers/asm-generic/kvm_para.h
@@ -0,0 +1,4 @@
+/*
+ * There isn't anything here, but the file must not be empty or patch
+ * will delete it.
+ */
diff --git a/linux-headers/asm-powerpc/kvm_para.h b/linux-headers/asm-powerpc/kvm_para.h
index 7e64f57..484bcaa 100644
--- a/linux-headers/asm-powerpc/kvm_para.h
+++ b/linux-headers/asm-powerpc/kvm_para.h
@@ -78,7 +78,7 @@ struct kvm_vcpu_arch_shared {
 
 #define KVM_HCALL_TOKEN(num)     _EV_HCALL_TOKEN(EV_KVM_VENDOR_ID, num)
 
-#include <asm/epapr_hcalls.h>
+#include <uapi/asm/epapr_hcalls.h>
 
 #define KVM_FEATURE_MAGIC_PAGE	1
 
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index bfdbf4d..2602437 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -168,6 +168,7 @@ struct kvm_pit_config {
 #define KVM_EXIT_PAPR_HCALL	  19
 #define KVM_EXIT_S390_UCONTROL	  20
 #define KVM_EXIT_WATCHDOG         21
+#define KVM_EXIT_S390_TSCH        22
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -285,6 +286,15 @@ struct kvm_run {
 			__u64 ret;
 			__u64 args[9];
 		} papr_hcall;
+		/* KVM_EXIT_S390_TSCH */
+		struct {
+			__u16 subchannel_id;
+			__u16 subchannel_nr;
+			__u32 io_int_parm;
+			__u32 io_int_word;
+			__u32 ipb;
+			__u8 dequeued;
+		} s390_tsch;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -397,10 +407,20 @@ struct kvm_s390_psw {
 #define KVM_S390_PROGRAM_INT		0xfffe0001u
 #define KVM_S390_SIGP_SET_PREFIX	0xfffe0002u
 #define KVM_S390_RESTART		0xfffe0003u
+#define KVM_S390_MCHK			0xfffe1000u
 #define KVM_S390_INT_VIRTIO		0xffff2603u
 #define KVM_S390_INT_SERVICE		0xffff2401u
 #define KVM_S390_INT_EMERGENCY		0xffff1201u
 #define KVM_S390_INT_EXTERNAL_CALL	0xffff1202u
+/* Anything below 0xfffe0000u is taken by INT_IO */
+#define KVM_S390_INT_IO(ai,cssid,ssid,schid)   \
+	(((schid)) |			       \
+	 ((ssid) << 16) |		       \
+	 ((cssid) << 18) |		       \
+	 ((ai) << 26))
+#define KVM_S390_INT_IO_MIN		0x00000000u
+#define KVM_S390_INT_IO_MAX		0xfffdffffu
+
 
 struct kvm_s390_interrupt {
 	__u32 type;
@@ -635,6 +655,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_IRQFD_RESAMPLE 82
 #define KVM_CAP_PPC_BOOKE_WATCHDOG 83
 #define KVM_CAP_PPC_HTAB_FD 84
+#define KVM_CAP_S390_CSS_SUPPORT 85
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.7.12.4
