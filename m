From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 14 Jun 2016 18:56:43 +0000
Subject: [GIT PULL 06/52] KVM: s390: Add sthyi emulation
Message-Id: <201606141857.u5EIsTGS133908@mx0a-001b2d01.pphosted.com>
In-Reply-To: <201606141857.u5EIs1SS051539@mx0a-001b2d01.pphosted.com>
References: <201606141857.u5EIs1SS051539@mx0a-001b2d01.pphosted.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

Store Hypervisor Information is an emulated z/VM instruction that
provides a guest with basic information about the layers it is running
on. This includes information about the cpu configuration of both the
machine and the lpar, as well as their names, machine model and
machine type. This information enables an application to determine the
maximum capacity of CPs and IFLs available to software.

The instruction is available whenever the facility bit 74 is set,
otherwise executing it results in an operation exception.

It is important to check the validity flags in the sections before
using data from any structure member. It is not guaranteed that all
members will be valid on all machines / machine configurations.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/diag.h     |  10 +
 arch/s390/include/asm/kvm_host.h |   2 +
 arch/s390/include/uapi/asm/sie.h |   1 +
 arch/s390/kvm/Makefile           |   2 +-
 arch/s390/kvm/intercept.c        |   4 +
 arch/s390/kvm/kvm-s390.c         |   6 +
 arch/s390/kvm/kvm-s390.h         |   3 +
 arch/s390/kvm/sthyi.c            | 460 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/trace.h            |  20 ++
 9 files changed, 507 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/kvm/sthyi.c

diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index f4000cd..8221199 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -215,6 +215,16 @@ struct diag204_x_phys_cpu {
 	char  reserved3[80];
 } __packed;
 
+struct diag204_x_part_block {
+	struct diag204_x_part_hdr hdr;
+	struct diag204_x_cpu_info cpus[];
+} __packed;
+
+struct diag204_x_phys_block {
+	struct diag204_x_phys_hdr hdr;
+	struct diag204_x_phys_cpu cpus[];
+} __packed;
+
 int diag204(unsigned long subcode, unsigned long size, void *addr);
 int diag224(void *ptr);
 #endif /* _ASM_S390_DIAG_H */
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 093ea14..7233b1c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -154,6 +154,7 @@ struct kvm_s390_sie_block {
 #define LCTL_CR14	0x0002
 	__u16   lctl;			/* 0x0044 */
 	__s16	icpua;			/* 0x0046 */
+#define ICTL_OPEREXC	0x80000000
 #define ICTL_PINT	0x20000000
 #define ICTL_LPSW	0x00400000
 #define ICTL_STCTL	0x00040000
@@ -279,6 +280,7 @@ struct kvm_vcpu_stat {
 	u32 instruction_stfl;
 	u32 instruction_tprot;
 	u32 instruction_essa;
+	u32 instruction_sthyi;
 	u32 instruction_sigp_sense;
 	u32 instruction_sigp_sense_running;
 	u32 instruction_sigp_external_call;
diff --git a/arch/s390/include/uapi/asm/sie.h b/arch/s390/include/uapi/asm/sie.h
index 8fb5d4a..3ac6343 100644
--- a/arch/s390/include/uapi/asm/sie.h
+++ b/arch/s390/include/uapi/asm/sie.h
@@ -140,6 +140,7 @@
 	exit_code_ipa0(0xB2, 0x4c, "TAR"),	\
 	exit_code_ipa0(0xB2, 0x50, "CSP"),	\
 	exit_code_ipa0(0xB2, 0x54, "MVPG"),	\
+	exit_code_ipa0(0xB2, 0x56, "STHYI"),	\
 	exit_code_ipa0(0xB2, 0x58, "BSG"),	\
 	exit_code_ipa0(0xB2, 0x5a, "BSA"),	\
 	exit_code_ipa0(0xB2, 0x5f, "CHSC"),	\
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index d42fa38..82e73e2 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -12,6 +12,6 @@ common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqch
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
 kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o
-kvm-objs += diag.o gaccess.o guestdbg.o
+kvm-objs += diag.o gaccess.o guestdbg.o sthyi.o
 
 obj-$(CONFIG_KVM) += kvm.o
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 09c13db..9359f65 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -355,6 +355,10 @@ static int handle_operexc(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_handle_operexc(vcpu, vcpu->arch.sie_block->ipa,
 				      vcpu->arch.sie_block->ipb);
 
+	if (vcpu->arch.sie_block->ipa == 0xb256 &&
+	    test_kvm_facility(vcpu->kvm, 74))
+		return handle_sthyi(vcpu);
+
 	return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f0addec..1c10254 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -94,6 +94,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "instruction_stsi", VCPU_STAT(instruction_stsi) },
 	{ "instruction_stfl", VCPU_STAT(instruction_stfl) },
 	{ "instruction_tprot", VCPU_STAT(instruction_tprot) },
+	{ "instruction_sthyi", VCPU_STAT(instruction_sthyi) },
 	{ "instruction_sigp_sense", VCPU_STAT(instruction_sigp_sense) },
 	{ "instruction_sigp_sense_running", VCPU_STAT(instruction_sigp_sense_running) },
 	{ "instruction_sigp_external_call", VCPU_STAT(instruction_sigp_external_call) },
@@ -1189,6 +1190,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	memcpy(kvm->arch.model.fac_list, kvm->arch.model.fac_mask,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 
+	set_kvm_facility(kvm->arch.model.fac_mask, 74);
+	set_kvm_facility(kvm->arch.model.fac_list, 74);
+
 	kvm->arch.model.cpuid = kvm_s390_get_initial_cpuid();
 	kvm->arch.model.ibc = sclp.ibc & 0x0fff;
 
@@ -1679,6 +1683,8 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	}
 	vcpu->arch.sie_block->riccbd = (unsigned long) &vcpu->run->s.regs.riccb;
 	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
+	if (test_kvm_facility(vcpu->kvm, 74))
+		vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
 
 	if (vcpu->kvm->arch.use_cmma) {
 		rc = kvm_s390_vcpu_setup_cmma(vcpu);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 8621ab0..c5ec4d3 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -250,6 +250,9 @@ int kvm_s390_handle_eb(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
 
+/* implemented in sthyi.c */
+int handle_sthyi(struct kvm_vcpu *vcpu);
+
 /* implemented in kvm-s390.c */
 void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod);
 long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
diff --git a/arch/s390/kvm/sthyi.c b/arch/s390/kvm/sthyi.c
new file mode 100644
index 0000000..894d562
--- /dev/null
+++ b/arch/s390/kvm/sthyi.c
@@ -0,0 +1,460 @@
+/*
+ * store hypervisor information instruction emulation functions.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Copyright IBM Corp. 2016
+ * Author(s): Janosch Frank <frankja@linux.vnet.ibm.com>
+ */
+#include <linux/kvm_host.h>
+#include <linux/errno.h>
+#include <linux/pagemap.h>
+#include <linux/vmalloc.h>
+
+#include <asm/kvm_host.h>
+#include <asm/asm-offsets.h>
+#include <asm/sclp.h>
+#include <asm/diag.h>
+#include <asm/sysinfo.h>
+#include <asm/ebcdic.h>
+
+#include "kvm-s390.h"
+#include "gaccess.h"
+#include "trace.h"
+
+#define DED_WEIGHT 0xffff
+/*
+ * CP and IFL as EBCDIC strings, SP/0x40 determines the end of string
+ * as they are justified with spaces.
+ */
+#define CP  0xc3d7404040404040UL
+#define IFL 0xc9c6d34040404040UL
+
+enum hdr_flags {
+	HDR_NOT_LPAR   = 0x10,
+	HDR_STACK_INCM = 0x20,
+	HDR_STSI_UNAV  = 0x40,
+	HDR_PERF_UNAV  = 0x80,
+};
+
+enum mac_validity {
+	MAC_NAME_VLD = 0x20,
+	MAC_ID_VLD   = 0x40,
+	MAC_CNT_VLD  = 0x80,
+};
+
+enum par_flag {
+	PAR_MT_EN = 0x80,
+};
+
+enum par_validity {
+	PAR_GRP_VLD  = 0x08,
+	PAR_ID_VLD   = 0x10,
+	PAR_ABS_VLD  = 0x20,
+	PAR_WGHT_VLD = 0x40,
+	PAR_PCNT_VLD  = 0x80,
+};
+
+struct hdr_sctn {
+	u8 infhflg1;
+	u8 infhflg2; /* reserved */
+	u8 infhval1; /* reserved */
+	u8 infhval2; /* reserved */
+	u8 reserved[3];
+	u8 infhygct;
+	u16 infhtotl;
+	u16 infhdln;
+	u16 infmoff;
+	u16 infmlen;
+	u16 infpoff;
+	u16 infplen;
+	u16 infhoff1;
+	u16 infhlen1;
+	u16 infgoff1;
+	u16 infglen1;
+	u16 infhoff2;
+	u16 infhlen2;
+	u16 infgoff2;
+	u16 infglen2;
+	u16 infhoff3;
+	u16 infhlen3;
+	u16 infgoff3;
+	u16 infglen3;
+	u8 reserved2[4];
+} __packed;
+
+struct mac_sctn {
+	u8 infmflg1; /* reserved */
+	u8 infmflg2; /* reserved */
+	u8 infmval1;
+	u8 infmval2; /* reserved */
+	u16 infmscps;
+	u16 infmdcps;
+	u16 infmsifl;
+	u16 infmdifl;
+	char infmname[8];
+	char infmtype[4];
+	char infmmanu[16];
+	char infmseq[16];
+	char infmpman[4];
+	u8 reserved[4];
+} __packed;
+
+struct par_sctn {
+	u8 infpflg1;
+	u8 infpflg2; /* reserved */
+	u8 infpval1;
+	u8 infpval2; /* reserved */
+	u16 infppnum;
+	u16 infpscps;
+	u16 infpdcps;
+	u16 infpsifl;
+	u16 infpdifl;
+	u16 reserved;
+	char infppnam[8];
+	u32 infpwbcp;
+	u32 infpabcp;
+	u32 infpwbif;
+	u32 infpabif;
+	char infplgnm[8];
+	u32 infplgcp;
+	u32 infplgif;
+} __packed;
+
+struct sthyi_sctns {
+	struct hdr_sctn hdr;
+	struct mac_sctn mac;
+	struct par_sctn par;
+} __packed;
+
+struct cpu_inf {
+	u64 lpar_cap;
+	u64 lpar_grp_cap;
+	u64 lpar_weight;
+	u64 all_weight;
+	int cpu_num_ded;
+	int cpu_num_shd;
+};
+
+struct lpar_cpu_inf {
+	struct cpu_inf cp;
+	struct cpu_inf ifl;
+};
+
+static inline u64 cpu_id(u8 ctidx, void *diag224_buf)
+{
+	return *((u64 *)(diag224_buf + (ctidx + 1) * DIAG204_CPU_NAME_LEN));
+}
+
+/*
+ * Scales the cpu capping from the lpar range to the one expected in
+ * sthyi data.
+ *
+ * diag204 reports a cap in hundredths of processor units.
+ * z/VM's range for one core is 0 - 0x10000.
+ */
+static u32 scale_cap(u32 in)
+{
+	return (0x10000 * in) / 100;
+}
+
+static void fill_hdr(struct sthyi_sctns *sctns)
+{
+	sctns->hdr.infhdln = sizeof(sctns->hdr);
+	sctns->hdr.infmoff = sizeof(sctns->hdr);
+	sctns->hdr.infmlen = sizeof(sctns->mac);
+	sctns->hdr.infplen = sizeof(sctns->par);
+	sctns->hdr.infpoff = sctns->hdr.infhdln + sctns->hdr.infmlen;
+	sctns->hdr.infhtotl = sctns->hdr.infpoff + sctns->hdr.infplen;
+}
+
+static void fill_stsi_mac(struct sthyi_sctns *sctns,
+			  struct sysinfo_1_1_1 *sysinfo)
+{
+	if (stsi(sysinfo, 1, 1, 1))
+		return;
+
+	sclp_ocf_cpc_name_copy(sctns->mac.infmname);
+
+	memcpy(sctns->mac.infmtype, sysinfo->type, sizeof(sctns->mac.infmtype));
+	memcpy(sctns->mac.infmmanu, sysinfo->manufacturer, sizeof(sctns->mac.infmmanu));
+	memcpy(sctns->mac.infmpman, sysinfo->plant, sizeof(sctns->mac.infmpman));
+	memcpy(sctns->mac.infmseq, sysinfo->sequence, sizeof(sctns->mac.infmseq));
+
+	sctns->mac.infmval1 |= MAC_ID_VLD | MAC_NAME_VLD;
+}
+
+static void fill_stsi_par(struct sthyi_sctns *sctns,
+			  struct sysinfo_2_2_2 *sysinfo)
+{
+	if (stsi(sysinfo, 2, 2, 2))
+		return;
+
+	sctns->par.infppnum = sysinfo->lpar_number;
+	memcpy(sctns->par.infppnam, sysinfo->name, sizeof(sctns->par.infppnam));
+
+	sctns->par.infpval1 |= PAR_ID_VLD;
+}
+
+static void fill_stsi(struct sthyi_sctns *sctns)
+{
+	void *sysinfo;
+
+	/* Errors are handled through the validity bits in the response. */
+	sysinfo = (void *)__get_free_page(GFP_KERNEL);
+	if (!sysinfo)
+		return;
+
+	fill_stsi_mac(sctns, sysinfo);
+	fill_stsi_par(sctns, sysinfo);
+
+	free_pages((unsigned long)sysinfo, 0);
+}
+
+static void fill_diag_mac(struct sthyi_sctns *sctns,
+			  struct diag204_x_phys_block *block,
+			  void *diag224_buf)
+{
+	int i;
+
+	for (i = 0; i < block->hdr.cpus; i++) {
+		switch (cpu_id(block->cpus[i].ctidx, diag224_buf)) {
+		case CP:
+			if (block->cpus[i].weight == DED_WEIGHT)
+				sctns->mac.infmdcps++;
+			else
+				sctns->mac.infmscps++;
+			break;
+		case IFL:
+			if (block->cpus[i].weight == DED_WEIGHT)
+				sctns->mac.infmdifl++;
+			else
+				sctns->mac.infmsifl++;
+			break;
+		}
+	}
+	sctns->mac.infmval1 |= MAC_CNT_VLD;
+}
+
+/* Returns a pointer to the the next partition block. */
+static struct diag204_x_part_block *lpar_cpu_inf(struct lpar_cpu_inf *part_inf,
+						 bool this_lpar,
+						 void *diag224_buf,
+						 struct diag204_x_part_block *block)
+{
+	int i, capped = 0, weight_cp = 0, weight_ifl = 0;
+	struct cpu_inf *cpu_inf;
+
+	for (i = 0; i < block->hdr.rcpus; i++) {
+		if (!(block->cpus[i].cflag & DIAG204_CPU_ONLINE))
+			continue;
+
+		switch (cpu_id(block->cpus[i].ctidx, diag224_buf)) {
+		case CP:
+			cpu_inf = &part_inf->cp;
+			if (block->cpus[i].cur_weight < DED_WEIGHT)
+				weight_cp |= block->cpus[i].cur_weight;
+			break;
+		case IFL:
+			cpu_inf = &part_inf->ifl;
+			if (block->cpus[i].cur_weight < DED_WEIGHT)
+				weight_ifl |= block->cpus[i].cur_weight;
+			break;
+		default:
+			continue;
+		}
+
+		if (!this_lpar)
+			continue;
+
+		capped |= block->cpus[i].cflag & DIAG204_CPU_CAPPED;
+		cpu_inf->lpar_cap |= block->cpus[i].cpu_type_cap;
+		cpu_inf->lpar_grp_cap |= block->cpus[i].group_cpu_type_cap;
+
+		if (block->cpus[i].weight == DED_WEIGHT)
+			cpu_inf->cpu_num_ded += 1;
+		else
+			cpu_inf->cpu_num_shd += 1;
+	}
+
+	if (this_lpar && capped) {
+		part_inf->cp.lpar_weight = weight_cp;
+		part_inf->ifl.lpar_weight = weight_ifl;
+	}
+	part_inf->cp.all_weight += weight_cp;
+	part_inf->ifl.all_weight += weight_ifl;
+	return (struct diag204_x_part_block *)&block->cpus[i];
+}
+
+static void fill_diag(struct sthyi_sctns *sctns)
+{
+	int i, r, pages;
+	bool this_lpar;
+	void *diag204_buf;
+	void *diag224_buf = NULL;
+	struct diag204_x_info_blk_hdr *ti_hdr;
+	struct diag204_x_part_block *part_block;
+	struct diag204_x_phys_block *phys_block;
+	struct lpar_cpu_inf lpar_inf = {};
+
+	/* Errors are handled through the validity bits in the response. */
+	pages = diag204((unsigned long)DIAG204_SUBC_RSI |
+			(unsigned long)DIAG204_INFO_EXT, 0, NULL);
+	if (pages <= 0)
+		return;
+
+	diag204_buf = vmalloc(PAGE_SIZE * pages);
+	if (!diag204_buf)
+		return;
+
+	r = diag204((unsigned long)DIAG204_SUBC_STIB7 |
+		    (unsigned long)DIAG204_INFO_EXT, pages, diag204_buf);
+	if (r < 0)
+		goto out;
+
+	diag224_buf = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
+	if (!diag224_buf || diag224(diag224_buf))
+		goto out;
+
+	ti_hdr = diag204_buf;
+	part_block = diag204_buf + sizeof(*ti_hdr);
+
+	for (i = 0; i < ti_hdr->npar; i++) {
+		/*
+		 * For the calling lpar we also need to get the cpu
+		 * caps and weights. The time information block header
+		 * specifies the offset to the partition block of the
+		 * caller lpar, so we know when we process its data.
+		 */
+		this_lpar = (void *)part_block - diag204_buf == ti_hdr->this_part;
+		part_block = lpar_cpu_inf(&lpar_inf, this_lpar, diag224_buf,
+					  part_block);
+	}
+
+	phys_block = (struct diag204_x_phys_block *)part_block;
+	part_block = diag204_buf + ti_hdr->this_part;
+	if (part_block->hdr.mtid)
+		sctns->par.infpflg1 = PAR_MT_EN;
+
+	sctns->par.infpval1 |= PAR_GRP_VLD;
+	sctns->par.infplgcp = scale_cap(lpar_inf.cp.lpar_grp_cap);
+	sctns->par.infplgif = scale_cap(lpar_inf.ifl.lpar_grp_cap);
+	memcpy(sctns->par.infplgnm, part_block->hdr.hardware_group_name,
+	       sizeof(sctns->par.infplgnm));
+
+	sctns->par.infpscps = lpar_inf.cp.cpu_num_shd;
+	sctns->par.infpdcps = lpar_inf.cp.cpu_num_ded;
+	sctns->par.infpsifl = lpar_inf.ifl.cpu_num_shd;
+	sctns->par.infpdifl = lpar_inf.ifl.cpu_num_ded;
+	sctns->par.infpval1 |= PAR_PCNT_VLD;
+
+	sctns->par.infpabcp = scale_cap(lpar_inf.cp.lpar_cap);
+	sctns->par.infpabif = scale_cap(lpar_inf.ifl.lpar_cap);
+	sctns->par.infpval1 |= PAR_ABS_VLD;
+
+	/*
+	 * Everything below needs global performance data to be
+	 * meaningful.
+	 */
+	if (!(ti_hdr->flags & DIAG204_LPAR_PHYS_FLG)) {
+		sctns->hdr.infhflg1 |= HDR_PERF_UNAV;
+		goto out;
+	}
+
+	fill_diag_mac(sctns, phys_block, diag224_buf);
+
+	if (lpar_inf.cp.lpar_weight) {
+		sctns->par.infpwbcp = sctns->mac.infmscps * 0x10000 *
+			lpar_inf.cp.lpar_weight / lpar_inf.cp.all_weight;
+	}
+
+	if (lpar_inf.ifl.lpar_weight) {
+		sctns->par.infpwbif = sctns->mac.infmsifl * 0x10000 *
+			lpar_inf.ifl.lpar_weight / lpar_inf.ifl.all_weight;
+	}
+	sctns->par.infpval1 |= PAR_WGHT_VLD;
+
+out:
+	kfree(diag224_buf);
+	vfree(diag204_buf);
+}
+
+static int sthyi(u64 vaddr)
+{
+	register u64 code asm("0") = 0;
+	register u64 addr asm("2") = vaddr;
+	int cc;
+
+	asm volatile(
+		".insn   rre,0xB2560000,%[code],%[addr]\n"
+		"ipm     %[cc]\n"
+		"srl     %[cc],28\n"
+		: [cc] "=d" (cc)
+		: [code] "d" (code), [addr] "a" (addr)
+		: "memory", "cc");
+	return cc;
+}
+
+int handle_sthyi(struct kvm_vcpu *vcpu)
+{
+	int reg1, reg2, r = 0;
+	u64 code, addr, cc = 0;
+	struct sthyi_sctns *sctns = NULL;
+
+	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
+	code = vcpu->run->s.regs.gprs[reg1];
+	addr = vcpu->run->s.regs.gprs[reg2];
+
+	vcpu->stat.instruction_sthyi++;
+	VCPU_EVENT(vcpu, 3, "STHYI: fc: %llu addr: 0x%016llx", code, addr);
+	trace_kvm_s390_handle_sthyi(vcpu, code, addr);
+
+	if (reg1 == reg2 || reg1 & 1 || reg2 & 1 || addr & ~PAGE_MASK)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	if (code & 0xffff) {
+		cc = 3;
+		goto out;
+	}
+
+	/*
+	 * If the page has not yet been faulted in, we want to do that
+	 * now and not after all the expensive calculations.
+	 */
+	r = write_guest(vcpu, addr, reg2, &cc, 1);
+	if (r)
+		return kvm_s390_inject_prog_cond(vcpu, r);
+
+	sctns = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!sctns)
+		return -ENOMEM;
+
+	/*
+	 * If we are a guest, we don't want to emulate an emulated
+	 * instruction. We ask the hypervisor to provide the data.
+	 */
+	if (test_facility(74)) {
+		cc = sthyi((u64)sctns);
+		goto out;
+	}
+
+	fill_hdr(sctns);
+	fill_stsi(sctns);
+	fill_diag(sctns);
+
+out:
+	if (!cc) {
+		r = write_guest(vcpu, addr, reg2, sctns, PAGE_SIZE);
+		if (r) {
+			free_page((unsigned long)sctns);
+			return kvm_s390_inject_prog_cond(vcpu, r);
+		}
+	}
+
+	free_page((unsigned long)sctns);
+	vcpu->run->s.regs.gprs[reg2 + 1] = cc ? 4 : 0;
+	kvm_s390_set_psw_cc(vcpu, cc);
+	return r;
+}
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
index 90d26a6..a429ef9 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -433,6 +433,26 @@ TRACE_EVENT(kvm_s390_handle_operexc,
 					    icpt_insn_codes))
 	);
 
+TRACE_EVENT(kvm_s390_handle_sthyi,
+	    TP_PROTO(VCPU_PROTO_COMMON, u64 code, u64 addr),
+	    TP_ARGS(VCPU_ARGS_COMMON, code, addr),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(u64, code)
+		    __field(u64, addr)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->code = code;
+		    __entry->addr = addr;
+		    ),
+
+	    VCPU_TP_PRINTK("STHYI fc: %llu addr: %016llx",
+			   __entry->code, __entry->addr)
+	);
+
 #endif /* _TRACE_KVM_H */
 
 /* This part must be outside protection */
-- 
2.5.5
