Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBF42B744;
	Tue, 28 Apr 2026 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392130; cv=none; b=gx7m85Y2+gQrshaAaxhjqFujwoEKCeNWFjLCDUG6OCvqh8OOo8cQ39XNKKlerlRR+Lceq9pKQZUgHMfmIO7edAu84csh2hWE4PZN9PLYzvV22x8CWt8SejetULG61OyjSoKX9RK5mx0vj3eFPTR++8P3CEmrEmRDnYWwfAhd9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392130; c=relaxed/simple;
	bh=jQdJmui9nrcOc+FL+BKZWqKPHThXTh5HBoL4OvTiSd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jw0TCERUYMXr8JyXIQU5p0txKf5eN3HSerl60yLpdkjZmm/3u/foVl5qtgz9kEhah/vlSkhRKEAb/jxqkNV1kHmbfIXLcVQzMhS25khJrI/BESPD74kpcibL0eLwshc9s4OzDnM6wNcnvXJhZ6jneNaIY9k7J38rzBezazDDQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZYUjloV7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZYUjloV7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S366sN2955054;
	Tue, 28 Apr 2026 15:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=L8CnUNDrGMp1xY/yx
	S5kk21F6gj7N3z8YJ+0XTizWdk=; b=ZYUjloV7rZQrHniq6fZeY8ewMkIG1SUVM
	e6XUtY9yySk4FUxv0LxQWrudn350uxlxsqGMpKIPUOTqKqlSU/IHaYaHihst8Vxe
	WmOP6tA5lpDF+hltFLoRri2aDqIJge91Onhk7sqozyV3SeSMvvRgWnyxJMow78ua
	I23rJ/wQJdE0nsRswDguaDPTCn51IdAHyajLc5wDOojGTAPkhz68otWwiEcFOP+z
	sSQ09VxoBU8La7xUaTbypw+xSYc1zlTtDbZLfIpybxorihEqNKdh6ccHjmfLmymW
	5A8Y1A7gns54vV58qmpIjvit0c1cQeKRbtph8ps8Af1FHONqraZ+A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44pfaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrqc0032245;
	Tue, 28 Apr 2026 15:56:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9eha9x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuUB062456176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A69820040;
	Tue, 28 Apr 2026 15:56:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4949F2004F;
	Tue, 28 Apr 2026 15:56:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:30 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 20/28] s390: Introduce Start Arm Execution instruction
Date: Tue, 28 Apr 2026 17:56:12 +0200
Message-ID: <20260428155622.1361364-21-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428155622.1361364-1-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2Nx9N83skqJDMt7W8_V-ZQNcdo7qswtQ
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0d8b3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=D7HF9d94yUUfLUezzdoA:9
X-Proofpoint-GUID: 2Nx9N83skqJDMt7W8_V-ZQNcdo7qswtQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX5sL8x9uVO/pM
 kg90eL/5gH3LuboWPgkFbKkHXhwI0HBxbvXo8ZcHqdOa4b964XtRKM2n+ZLJNarTjhe/fAF1yBi
 spWnAQ9yCRwMsyZFMkude2xGHBDazKNmX4wRdkmM9ddIaNzoAvsHOMMt9+CDOaQnaZ4+ABhlGcB
 efxxKpyZ56+J+T8moIDCJdH9v0yAxnwTWMJuq2Ch/gYkrytUnlT5GbhHOy8BGQcGUPI4kNhT0wT
 IvzPe+oXGt5kyZIbQqUs/e4Tdx6s/xarnWCkZou32tA8VZ/EGDF042duXqJY0Tyk2vrUQqFTLrO
 YvJ+s7YUukVLTsNwJIBLvFyaYnigDEs/qSgp5riPHglmMicTWetrwTi8hURZ7stRlGloRXBnB5b
 pMldmHoSODvcCpunCJgVr40W/wRTDrZG8isOQh2SMJlODwR6uyQIkwAAlbzT/3EMm3BexhSp9/O
 uyssS4gyWurr9gebCtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

The Start Arm Execution (SAE) instruction is the centerpiece for
executing arm64 (KVM) guests on s390. Its purpose is, similar to SIE, to
enable accelerated execution of arm64 virtual machines. SAE expects the
physical address of a control block as the only argument.

The host is responsible to save & restore
 - GPRs 0-13
 - access register 0-15
 - breaking event register (BEAR)
 - vector/floating point registers
between SAE executions to guarantee host consistency.

GPRs and BEAR are save and restores in the asm functions. The other
register are handled in within C code. Access registers are handled in a
later patch and SVEs will be handled when they are introduced in a
future series. Most arm64 registers are handled by a satellite block
called save_area. Some registers, frequently used by hypervisors, are
placed into the SAE control block itself.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/asm-prototypes.h       |   1 +
 arch/s390/include/asm/kvm_host_arm64_types.h | 129 +++++++++++++++++++
 arch/s390/include/asm/sae.h                  |  39 ++++++
 arch/s390/include/asm/stacktrace.h           |   5 +
 arch/s390/kernel/asm-offsets.c               |   1 +
 arch/s390/kernel/entry.S                     |  25 ++++
 arch/s390/tools/opcodes.txt                  |   3 +
 7 files changed, 203 insertions(+)
 create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
 create mode 100644 arch/s390/include/asm/sae.h

diff --git a/arch/s390/include/asm/asm-prototypes.h b/arch/s390/include/asm/asm-prototypes.h
index 7bd1801cf241..2bf4b52f4d2d 100644
--- a/arch/s390/include/asm/asm-prototypes.h
+++ b/arch/s390/include/asm/asm-prototypes.h
@@ -6,6 +6,7 @@
 #include <asm/bug.h>
 #include <asm/fpu.h>
 #include <asm/nospec-branch.h>
+#include <asm/sae.h>
 #include <asm-generic/asm-prototypes.h>
 
 __int128_t __ashlti3(__int128_t a, int b);
diff --git a/arch/s390/include/asm/kvm_host_arm64_types.h b/arch/s390/include/asm/kvm_host_arm64_types.h
new file mode 100644
index 000000000000..3882d5462a05
--- /dev/null
+++ b/arch/s390/include/asm/kvm_host_arm64_types.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ASM_KVM_HOST_ARM64_TYPES_H
+#define ASM_KVM_HOST_ARM64_TYPES_H
+
+#include <linux/types.h>
+#include <linux/kvm_types.h>
+#include <linux/compiler_attributes.h>
+#include <asm/page.h>
+#include <asm/fault.h>
+
+struct kvm_sae_block {
+	u64	_0000[16];		/* 0x0000 */
+#define SAE_ICPTR_SPURIOUS			0x00
+#define SAE_ICPTR_VALIDITY			0x01
+#define SAE_ICPTR_HOST_ACCESS_EXCEPTION		0x02
+#define SAE_ICPTR_SYNCHRONOUS_EXCEPTION		0x03
+#define SAE_ICPTR_TIMER				0x04
+#define SAE_ICPTR_PE_INTERCOMM			0x05
+#define SAE_ICPTR_GUEST_ADDRESS_SIZE		0x06
+#define SAE_ICPTR_STOP				0x07
+#define SAE_ICPTR_SYSTEM_REGISTER		0x08
+#define SAE_ICPTR_PMU				0x09
+#define SAE_ICPTR_MAINTENANCE			0x0a
+	u8	icptr;			/* 0x0080 */
+	u8	_0081[7];		/* 0x0081 */
+	u64	scad;			/* 0x0088 */
+	u64	_0090[16];		/* 0x00b0 */
+	u32	cntp_ctl;		/* 0x0110 */
+	u32	cntv_ctl;		/* 0x0114 */
+	u8	irq_ctl;		/* 0x0118 */
+	u8	_0119[7];		/* 0x0119 */
+	struct {
+		u64	ich_hcr_el2;	/* 0x0120 */
+		u64	ich_vmcr_el2;	/* 0x0128 */
+		u64	ich_ap0r0_el2;	/* 0x0130 */
+		u64	ich_ap1r0_el2;	/* 0x0138 */
+		u64	_0140[2];	/* 0x0140 */
+		u64	ich_lrn_el2[4];	/* 0x0150 */
+		u64	_0170[4];	/* 0x0170 */
+	} ic_regs;
+	u64	_0190[12];		/* 0x0190 */
+	u64	contextidr_el1;		/* 0x01f0 */
+	u32	wip;			/* 0x01f8 */
+	u32	_01fc;			/* 0x01fc */
+#define SAE_SD_FORMAT_0                 0x00
+	u8	sdf;			/* 0x0200  */
+	u8	_0201[7];		/* 0x0201  */
+	u64	mso;			/* 0x0208  */
+	u64	msl;			/* 0x0210  */
+	u64	hbasce;			/* 0x0218  */
+	u64	_0220;			/* 0x0220  */
+	u64	gpto;			/* 0x0228  */
+	u64	ic;			/* 0x0230  */
+	u64	ec;			/* 0x0238  */
+	u64	save_area;		/* 0x0240  */
+	u64	_0248[7];		/* 0x0248  */
+	u8	_0280[6];		/* 0x0280  */
+	u16	lrcpua;			/* 0x0286  */
+	u64	pstate;			/* 0x0288  */
+	u64	pc;			/* 0x0290  */
+	u64	sp_el0;			/* 0x0298  */
+	u64	sp_el1;			/* 0x02a0  */
+	u64	_02a8;			/* 0x02a8  */
+	u64	fpcr;			/* 0x02b0  */
+	u64	fpsr;			/* 0x02b8  */
+	u16	sve_pregs[16];		/* 0x02c0  */
+	u16	sve_ffr;		/* 0x02e0  */
+	u8	_02e2[6];		/* 0x02e2  */
+	u64	_02e8[3];		/* 0x02e8  */
+
+	u64	gpr[31];		/* 0x0300  */
+	u64	_03f8;			/* 0x03f8  */
+
+	union {
+		u64	icptd[8];		/* 0x0400 */
+		/* validity-interception reason; icptr 0x01 */
+#define SAE_VIR_UNKNOWN		0x00
+#define SAE_VIR_UNSUPP_FORMAT	0x01
+#define SAE_VIR_MSO_BOUNDS	0x02
+#define SAE_VIR_MSLA		0x03
+#define SAE_VIR_MGPAS		0x04
+#define SAE_VIR_INVAL_SYSREG	0x05
+#define SAE_VIR_HOST_CONTROL	0x06
+#define SAE_VIR_SCA		0x07
+#define SAE_VIR_MSO_ALIGN	0x08
+#define SAE_VIR_HLC		0x09
+#define SAE_VIR_IRPTC		0x0a
+		u16 vir;			/* 0x0400 */
+		/* host access interception details; icptr 0x02 */
+		struct {
+			u64		esr_elz;	/* 0x0400 */
+			u8		_0408[6];	/* 0x0408 */
+			u16		pic;		/* 0x040e */
+			union teid	teid;		/* 0x0410 */
+			gva_t		far_elz;	/* 0x0418 */
+			gva_t		vaddr;		/* 0x0420 */
+			u64		suppl;		/* 0x0428 */
+			u8		gltl;		/* 0x0430 */
+			u8		_0431[7];	/* 0x0431 */
+			u64		_0438;		/* 0x0438 */
+		} hai;
+		/* exception-interception details; icptr 0x03 */
+		struct {
+			u64	esr_elz;		/* 0x0400 */
+			u64	_0408[2];		/* 0x0408 */
+			gva_t	far_elz;		/* 0x0418 */
+		} trap;
+		/* timer-interception reason; icptr 0x04 */
+#define SAE_IR_TIMER_ID_VIRT		BIT(6)
+#define SAE_IR_TIMER_ID_PHYS		BIT(7)
+		u8	tir;			/* 0x0400 */
+	};
+	u64	_0440[376];			/* 0x0440 */
+} __packed __aligned(PAGE_SIZE);
+static_assert(sizeof(struct kvm_sae_block) == PAGE_SIZE);
+
+struct kvm_sae_save_area {
+#define SAE_SAVE_AREA_FORMAT_0	0x00
+	u8	saf;		/* 0x0000 */
+	u8	_0001[5];	/* 0x0001 */
+#define SAE_SAS_VALID		BIT(0)
+	u16	sas;		/* 0x0006 */
+	u64	sdo;		/* 0x0008 */
+	u64	_0010[2];	/* 0x0010 */
+	u64	regs[508];	/* 0x0020 */
+} __packed __aligned(PAGE_SIZE);
+static_assert(sizeof(struct kvm_sae_save_area) == PAGE_SIZE);
+
+#endif /* ASM_KVM_HOST_ARM64_TYPES_H */
diff --git a/arch/s390/include/asm/sae.h b/arch/s390/include/asm/sae.h
new file mode 100644
index 000000000000..26f690f71217
--- /dev/null
+++ b/arch/s390/include/asm/sae.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_S390_SAE_H
+#define __ASM_S390_SAE_H
+
+/* defined in arch/s390/kernel/entry.S */
+int __sae64a(phys_addr_t sae_block_phys);
+
+/**
+ * __sae64a() - Start Arm Execution
+ */
+static inline void sae64a(struct kvm_sae_block *sae_block)
+{
+	__sae64a(virt_to_phys(sae_block));
+}
+
+/**
+ * stiasrm() - STore and Invalidate Arm System Register Multiple
+ */
+static __always_inline void stiasrm(struct kvm_sae_save_area *save_area)
+{
+	asm volatile(".insn	rre,0xb9a70000,%[r1],0\n"
+		     : "=m"(*save_area)
+		     : [r1] "a"(save_area));
+}
+
+/**
+ * lasrm() - Load Arm System Register Multiple
+ *
+ */
+static __always_inline void lasrm(struct kvm_sae_save_area *save_area)
+{
+	asm volatile(".insn	rre,0xb9a60000,%[r1],0\n"
+		     :
+		     : "m" (*save_area),
+		      [r1] "a" (save_area)
+	);
+}
+
+#endif /* __ASM_S390_SAE_H */
diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index ac3606c3babe..2d332d7c8145 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -59,6 +59,7 @@ static inline bool on_stack(struct stack_info *info,
 struct stack_frame {
 	union {
 		unsigned long empty[9];
+		/* SIE stack frame */
 		struct {
 			unsigned long sie_control_block;
 			unsigned long sie_savearea;
@@ -68,6 +69,10 @@ struct stack_frame {
 			unsigned long sie_guest_asce;
 			unsigned long sie_irq;
 		};
+		/* SAE stack frame */
+		struct {
+			unsigned long sae_bear;
+		};
 	};
 	unsigned long gprs[10];
 	unsigned long back_chain;
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 8619adf91cdb..8ef992734bf8 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -68,6 +68,7 @@ int main(void)
 	OFFSET(__SF_SIE_CONTROL_PHYS, stack_frame, sie_control_block_phys);
 	OFFSET(__SF_SIE_GUEST_ASCE, stack_frame, sie_guest_asce);
 	OFFSET(__SF_SIE_IRQ, stack_frame, sie_irq);
+	OFFSET(__SF_SAE_BEAR, stack_frame, sae_bear);
 	DEFINE(STACK_FRAME_OVERHEAD, sizeof(struct stack_frame));
 	BLANK();
 	OFFSET(__SFUSER_BACKCHAIN, stack_frame_user, back_chain);
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index cd4fbdec67a7..d44e5cc05e6e 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -244,6 +244,31 @@ EXPORT_SYMBOL(__sie64a)
 EXPORT_SYMBOL(sie_exit)
 #endif
 
+#if IS_ENABLED(CONFIG_KVM_ARM64)
+/*
+ * __sae64a calling convention:
+ * %r2 pointer to sae control block physical address
+ */
+SYM_FUNC_START(__sae64a)
+	stmg	%r6,%r14,__SF_GPRS(%r15)	# store kernel registers
+	STBEAR	__SF_SAE_BEAR(%r15)		# save breaking event address register
+	.insn	rre,0xb9a50000,%r2,0		# Start Arm Execution
+# Let the next instruction be NOP to avoid triggering a machine check
+# and handling it in a guest as result of the instruction execution.
+	nopr	7
+	LBEAR	__SF_SAE_BEAR(%r15)		# restore breaking event address register
+	xgr	%r0,%r0				# clear guest registers to
+	xgr	%r1,%r1				# prevent speculative use
+	xgr	%r3,%r3
+	xgr	%r2,%r2
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
+	BR_EX	%r14
+SYM_FUNC_END(__sae64a)
+EXPORT_SYMBOL(__sae64a)
+#endif
+
 /*
  * SVC interrupt handler routine. System calls are synchronous events and
  * are entered with interrupts disabled.
diff --git a/arch/s390/tools/opcodes.txt b/arch/s390/tools/opcodes.txt
index def2659f6602..0e4773c94af0 100644
--- a/arch/s390/tools/opcodes.txt
+++ b/arch/s390/tools/opcodes.txt
@@ -594,6 +594,9 @@ b9a0	clp	RRF_U0RR
 b9a1	tpei	RRE_RR
 b9a2	ptf	RRE_R0
 b9a4	uvc	RRF_URR
+b9a5	sae	RRE_R0
+b9a6	lasrm	RRE_R0
+b9a7	stiasrm	RRE_R0
 b9aa	lptea	RRF_RURR2
 b9ab	essa	RRF_U0RR
 b9ac	irbm	RRE_RR
-- 
2.51.0

