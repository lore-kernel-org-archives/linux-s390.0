From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/3] Update linux headers.
Date: Wed, 31 Oct 2012 17:24:46 +0100
Message-ID: <1351700688-42353-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1351700688-42353-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1351700688-42353-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 linux-headers/asm-generic/kvm_para.h |  5 +++
 linux-headers/asm-powerpc/kvm.h      | 59 ++++++++++++++++++++++++++++++++++
 linux-headers/asm-powerpc/kvm_para.h |  7 +++--
 linux-headers/asm-x86/kvm.h          | 17 ++++++++++
 linux-headers/linux/kvm.h            | 61 ++++++++++++++++++++++++++++++------
 5 files changed, 137 insertions(+), 12 deletions(-)
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
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 1bea4d8..b89ae4d 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -221,6 +221,12 @@ struct kvm_sregs {
 
 			__u32 dbsr;	/* KVM_SREGS_E_UPDATE_DBSR */
 			__u32 dbcr[3];
+			/*
+			 * iac/dac registers are 64bit wide, while this API
+			 * interface provides only lower 32 bits on 64 bit
+			 * processors. ONE_REG interface is added for 64bit
+			 * iac/dac registers.
+			 */
 			__u32 iac[4];
 			__u32 dac[2];
 			__u32 dvc[2];
@@ -326,5 +332,58 @@ struct kvm_book3e_206_tlb_params {
 };
 
 #define KVM_REG_PPC_HIOR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x1)
+#define KVM_REG_PPC_IAC1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x2)
+#define KVM_REG_PPC_IAC2	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x3)
+#define KVM_REG_PPC_IAC3	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x4)
+#define KVM_REG_PPC_IAC4	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x5)
+#define KVM_REG_PPC_DAC1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x6)
+#define KVM_REG_PPC_DAC2	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x7)
+#define KVM_REG_PPC_DABR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8)
+#define KVM_REG_PPC_DSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x9)
+#define KVM_REG_PPC_PURR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa)
+#define KVM_REG_PPC_SPURR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xb)
+#define KVM_REG_PPC_DAR		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc)
+#define KVM_REG_PPC_DSISR	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xd)
+#define KVM_REG_PPC_AMR		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xe)
+#define KVM_REG_PPC_UAMOR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xf)
+
+#define KVM_REG_PPC_MMCR0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x10)
+#define KVM_REG_PPC_MMCR1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x11)
+#define KVM_REG_PPC_MMCRA	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x12)
+
+#define KVM_REG_PPC_PMC1	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x18)
+#define KVM_REG_PPC_PMC2	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x19)
+#define KVM_REG_PPC_PMC3	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x1a)
+#define KVM_REG_PPC_PMC4	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x1b)
+#define KVM_REG_PPC_PMC5	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x1c)
+#define KVM_REG_PPC_PMC6	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x1d)
+#define KVM_REG_PPC_PMC7	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x1e)
+#define KVM_REG_PPC_PMC8	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x1f)
+
+/* 32 floating-point registers */
+#define KVM_REG_PPC_FPR0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x20)
+#define KVM_REG_PPC_FPR(n)	(KVM_REG_PPC_FPR0 + (n))
+#define KVM_REG_PPC_FPR31	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x3f)
+
+/* 32 VMX/Altivec vector registers */
+#define KVM_REG_PPC_VR0		(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x40)
+#define KVM_REG_PPC_VR(n)	(KVM_REG_PPC_VR0 + (n))
+#define KVM_REG_PPC_VR31	(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x5f)
+
+/* 32 double-width FP registers for VSX */
+/* High-order halves overlap with FP regs */
+#define KVM_REG_PPC_VSR0	(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x60)
+#define KVM_REG_PPC_VSR(n)	(KVM_REG_PPC_VSR0 + (n))
+#define KVM_REG_PPC_VSR31	(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x7f)
+
+/* FP and vector status/control registers */
+#define KVM_REG_PPC_FPSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x80)
+#define KVM_REG_PPC_VSCR	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0x81)
+
+/* Virtual processor areas */
+/* For SLB & DTL, address in high (first) half, length in low half */
+#define KVM_REG_PPC_VPA_ADDR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x82)
+#define KVM_REG_PPC_VPA_SLB	(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x83)
+#define KVM_REG_PPC_VPA_DTL	(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x84)
 
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/linux-headers/asm-powerpc/kvm_para.h b/linux-headers/asm-powerpc/kvm_para.h
index c047a84..7e64f57 100644
--- a/linux-headers/asm-powerpc/kvm_para.h
+++ b/linux-headers/asm-powerpc/kvm_para.h
@@ -75,9 +75,10 @@ struct kvm_vcpu_arch_shared {
 };
 
 #define KVM_SC_MAGIC_R0		0x4b564d21 /* "KVM!" */
-#define HC_VENDOR_KVM		(42 << 16)
-#define HC_EV_SUCCESS		0
-#define HC_EV_UNIMPLEMENTED	12
+
+#define KVM_HCALL_TOKEN(num)     _EV_HCALL_TOKEN(EV_KVM_VENDOR_ID, num)
+
+#include <asm/epapr_hcalls.h>
 
 #define KVM_FEATURE_MAGIC_PAGE	1
 
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 246617e..a65ec29 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -9,6 +9,22 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+#define DE_VECTOR 0
+#define DB_VECTOR 1
+#define BP_VECTOR 3
+#define OF_VECTOR 4
+#define BR_VECTOR 5
+#define UD_VECTOR 6
+#define NM_VECTOR 7
+#define DF_VECTOR 8
+#define TS_VECTOR 10
+#define NP_VECTOR 11
+#define SS_VECTOR 12
+#define GP_VECTOR 13
+#define PF_VECTOR 14
+#define MF_VECTOR 16
+#define MC_VECTOR 18
+
 /* Select x86 specific features in <linux/kvm.h> */
 #define __KVM_HAVE_PIT
 #define __KVM_HAVE_IOAPIC
@@ -25,6 +41,7 @@
 #define __KVM_HAVE_DEBUGREGS
 #define __KVM_HAVE_XSAVE
 #define __KVM_HAVE_XCRS
+#define __KVM_HAVE_READONLY_MEM
 
 /* Architectural interrupt line count. */
 #define KVM_NR_INTERRUPTS 256
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 4b9e575..84e7abc 100644
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
@@ -163,10 +167,16 @@ struct kvm_pit_config {
 #define KVM_EXIT_OSI              18
 #define KVM_EXIT_PAPR_HCALL	  19
 #define KVM_EXIT_S390_UCONTROL	  20
+#define KVM_EXIT_WATCHDOG         21
+#define KVM_EXIT_S390_TSCH        22
 
 /* For KVM_EXIT_INTERNAL_ERROR */
-#define KVM_INTERNAL_ERROR_EMULATION 1
-#define KVM_INTERNAL_ERROR_SIMUL_EX 2
+/* Emulate instruction failed. */
+#define KVM_INTERNAL_ERROR_EMULATION	1
+/* Encounter unexpected simultaneous exceptions. */
+#define KVM_INTERNAL_ERROR_SIMUL_EX	2
+/* Encounter unexpected vm-exit due to delivery event. */
+#define KVM_INTERNAL_ERROR_DELIVERY_EV	3
 
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
 struct kvm_run {
@@ -276,6 +286,15 @@ struct kvm_run {
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
@@ -473,6 +499,8 @@ struct kvm_ppc_smmu_info {
 	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
 };
 
+#define KVM_PPC_PVINFO_FLAGS_EV_IDLE   (1<<0)
+
 #define KVMIO 0xAE
 
 /* machine type bits, to be used as argument to KVM_CREATE_VM */
@@ -618,6 +646,12 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_PPC_GET_SMMU_INFO 78
 #define KVM_CAP_S390_COW 79
 #define KVM_CAP_PPC_ALLOC_HTAB 80
+#ifdef __KVM_HAVE_READONLY_MEM
+#define KVM_CAP_READONLY_MEM 81
+#endif
+#define KVM_CAP_IRQFD_RESAMPLE 82
+#define KVM_CAP_PPC_BOOKE_WATCHDOG 83
+#define KVM_CAP_S390_CSS_SUPPORT 84
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -683,12 +717,21 @@ struct kvm_xen_hvm_config {
 #endif
 
 #define KVM_IRQFD_FLAG_DEASSIGN (1 << 0)
+/*
+ * Available with KVM_CAP_IRQFD_RESAMPLE
+ *
+ * KVM_IRQFD_FLAG_RESAMPLE indicates resamplefd is valid and specifies
+ * the irqfd to operate in resampling mode for level triggered interrupt
+ * emlation.  See Documentation/virtual/kvm/api.txt.
+ */
+#define KVM_IRQFD_FLAG_RESAMPLE (1 << 1)
 
 struct kvm_irqfd {
 	__u32 fd;
 	__u32 gsi;
 	__u32 flags;
-	__u8  pad[20];
+	__u32 resamplefd;
+	__u8  pad[16];
 };
 
 struct kvm_clock_data {
@@ -831,6 +874,9 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_GET_SMMU_INFO	  _IOR(KVMIO,  0xa6, struct kvm_ppc_smmu_info)
 /* Available with KVM_CAP_PPC_ALLOC_HTAB */
 #define KVM_PPC_ALLOCATE_HTAB	  _IOWR(KVMIO, 0xa7, __u32)
+#define KVM_CREATE_SPAPR_TCE	  _IOW(KVMIO,  0xa8, struct kvm_create_spapr_tce)
+/* Available with KVM_CAP_RMA */
+#define KVM_ALLOCATE_RMA	  _IOR(KVMIO,  0xa9, struct kvm_allocate_rma)
 
 /*
  * ioctls for vcpu fds
@@ -894,9 +940,6 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_XCRS */
 #define KVM_GET_XCRS		  _IOR(KVMIO,  0xa6, struct kvm_xcrs)
 #define KVM_SET_XCRS		  _IOW(KVMIO,  0xa7, struct kvm_xcrs)
-#define KVM_CREATE_SPAPR_TCE	  _IOW(KVMIO,  0xa8, struct kvm_create_spapr_tce)
-/* Available with KVM_CAP_RMA */
-#define KVM_ALLOCATE_RMA	  _IOR(KVMIO,  0xa9, struct kvm_allocate_rma)
 /* Available with KVM_CAP_SW_TLB */
 #define KVM_DIRTY_TLB		  _IOW(KVMIO,  0xaa, struct kvm_dirty_tlb)
 /* Available with KVM_CAP_ONE_REG */
-- 
1.7.12.4
