Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325C38A713;
	Thu,  2 Apr 2026 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103781; cv=none; b=OYKMbYoZvaxGGVFjf9pFk1ke0we3Gm/kpJDDrRvR2ZzaRUE65/333kRe2P3Aevr4wwum5Q+l3dxuCrEmwk431CRUnp+EkQS2x155vX5WcQKm+R3X+KYoQdPqaFMfqbDAv2EHA8tXi0Ik+bIqwikQlrEb2oOMkYxamUBypsgX38s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103781; c=relaxed/simple;
	bh=KysFQQgqNgmdpn1bxcom5tPB3p0WzC8G1KFW61K86fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQNzWHfKgucbV3ScqBfyKkTowO/TUaAXjx+xrOr9jB6hhX1TGSRxkbbzVbTcAQzzYeKznJzly4pSJ/s/3vyhaG0awiZ8qJs21goMa9rWjUeLmVdl5v6WdZtCxkf63Wf/2pk4X+6rs92FJbwaHgO696uICFLKC2UEHKhvjUo2eyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P+i7b5vG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P+i7b5vG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631L0rK8142146;
	Thu, 2 Apr 2026 04:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bbpdgFKhOy0jX28qi
	Hj1HfR3sCt4hn5VqIh/P7MdEyU=; b=P+i7b5vG/0zPZn80syqCgjqS3r+dJWOu5
	wPSQlwBUUPehhqKxZyLMtu1owDvinTOjlbFFp8arfnJVVAPeRJF+ACSI4SptJ2nt
	I6dtDal8LIeQnO19wMHgViMxr1SUs2sb+jhrWlxIkV2zD437ZcUW113umI5w2/gY
	pcjxedSsYMrH61Jbbl5/P/U52j8LDwOfphuURqL8IuW2+3k69q6hMAwSJIX3rA07
	xArCp4zKOEBDqOhYOaP6bMiiQOjFurTNxQzEsvGH3qyO3wuq60L+12Z476gWkTkw
	bPZNpgyzB8iHsNd0kV3FIzDfvi62AQngyneN37TyNXlmEYoBgnBkA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgtjgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631No9OG006362;
	Thu, 2 Apr 2026 04:21:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy8q9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LXtn52167148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E99920043;
	Thu,  2 Apr 2026 04:21:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E18232004B;
	Thu,  2 Apr 2026 04:21:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:32 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH v1 19/27] s390: Introduce Start Arm Execution instruction
Date: Thu,  2 Apr 2026 06:21:15 +0200
Message-ID: <20260402042125.3948963-20-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402042125.3948963-1-seiden@linux.ibm.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfX6QBpsIYLBTUy
 w8u5wyrwj8hP2U6gnJEqUNa507hG2kZfp6+ARMGNZ0okVmqQ/NeHKZ3Yz3xkeCgoeDbx2W3zxcf
 2qKmB3mXR3nciNzVbURtA0DRfdeyZ4330hBMvyS/S78CrBWVBpvXFA7V7uCEIEy4O1Nd5+sj7zV
 3OfdlYqea3iSwCjY9ICeu7VbZWNVK1m/szpSxHh/dMys9+F2GEYMFh5ShbqpTafCCs5eHuUn725
 m1g9tod43h30Ym2qi2i54K4MXqN+yDeAMmMoVMl2LsO9wxcdKtVQqOYH5xxy0ul8gOg4rahB38T
 2Qf5+oAZrZ9adk6z9Ziejgl/gybVUnwZwHexwEvwhSpBh7ES6fyf+WcQRq4Cy72HceXALqv28kk
 JYaB1S3Ga5z3YwYtTzoijDejV9OUnVEEyTQFdJOOUbIaaHU0RoHgKzxoCPEXp/c6b+XrzcQu8TH
 ZwZSjsv6vNRJvxviYag==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cdeed1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=D7HF9d94yUUfLUezzdoA:9
X-Proofpoint-GUID: WX_DjL4x7RbjX6oF14eRWgcufezHU9sT
X-Proofpoint-ORIG-GUID: WX_DjL4x7RbjX6oF14eRWgcufezHU9sT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020034

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
 arch/s390/include/asm/kvm_host_arm64_types.h | 128 +++++++++++++++++++
 arch/s390/include/asm/sae.h                  |  39 ++++++
 arch/s390/include/asm/stacktrace.h           |   5 +
 arch/s390/kernel/asm-offsets.c               |   1 +
 arch/s390/kernel/entry.S                     |  24 ++++
 arch/s390/tools/opcodes.txt                  |   3 +
 7 files changed, 201 insertions(+)
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
index 000000000000..9cbc9a88f515
--- /dev/null
+++ b/arch/s390/include/asm/kvm_host_arm64_types.h
@@ -0,0 +1,128 @@
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
+	u64	_0190[13];		/* 0x0190 */
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
+#define SEA_VIR_IRPTC		0x0a
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
+			gva_t	esr_elz;		/* 0x0400 */
+			u64	_0408[2];		/* 0x0408 */
+			u64	far_elz;		/* 0x0418 */
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
+#define SAE_SAS_VALID		BIT_ULL(0)
+	u16	sas;		/* 0x0006 */
+	u64	sdo;		/* 0x0008 */
+	u64	_0010[2];	/* 0x0010 */
+	u64	regs[507];	/* 0x0020 */
+} __packed __aligned(PAGE_SIZE);
+static_assert(sizeof(struct kvm_sae_save_area) == PAGE_SIZE);
+
+#endif /* ASM_KVM_HOST_ARM64_TYPES_H */
diff --git a/arch/s390/include/asm/sae.h b/arch/s390/include/asm/sae.h
new file mode 100644
index 000000000000..d7be5ebb25d5
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
+		     : [r1] "d"(save_area));
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
+		      [r1] "d" (save_area)
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
index ac8d75a209fa..fc5f1dd77e6c 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -244,6 +244,30 @@ EXPORT_SYMBOL(__sie64a)
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

