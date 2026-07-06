Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040C4DB572;
	Mon,  6 Jul 2026 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328016; cv=none; b=r9rMBQRaihY+0ZtYcPWPGY0RdvRUGTseqD742jqrVKJSUlYX/hY68YW28oTmkjIQcM0Ijraba/ZaC4L1ClpTuC57RstLnNfj5wPAY/sM14os71WqatXJppXSj1Vc/CQtbn6rdsyjJnkY1d7o7pk78WTOwcpNveS08yhhYdYNLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328016; c=relaxed/simple;
	bh=+2yZi0CIIFp1kYsgHdx2ZiIV17gJjYt8skVQjbvkLo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsAhPaN0eMrufCY56zDCHfnCvXL+DHvGEFClLL2dJOSG91HB5JFmdNGmHoFG3NaROyYVJdFxpP+tAsYlvf4iSkuTCAKlYbxy3gJArCtVqpOIHwXjfSdIMZ19+nO/HAalqBRS+pcBXRFmDS9PueaLKskk6Ez9g44UuvalBOuipKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j+6xs0tb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j+6xs0tb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIAep2303805;
	Mon, 6 Jul 2026 08:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jdfV4gjAQoM6YhGbr
	kpvppHExlPgcIe2wv/vQSF28G4=; b=j+6xs0tbmoYMG3fWUSJ5plN4xNMc/bv9D
	eU9rXfnlqB1UfhjYtmvIaANQW9IO04WCS0xBp1F/RFz/l6lpgcHuxPkg5WoKCffw
	5kDYfHebi1rxJG2ROvIT/Mq1BP+DhcVLbFz7ypUpA0sYhne4LIZoPoBsAg38i1Mb
	l7Wc99xotMAxoFXVT565dA2ogHnCTgOGIBbKNzULPpTUA/PAWZQPa5Pbht+nWE4i
	JGD0qLN1IjFy1Uo9VbcPrdzh8k2HvmKeMZtenb/jzI77vnLG+g+3/O7BBEauvpfo
	lygp3nd40K58BZnBansA+0lcd4d/KciQqyPlsWD7GzQDbBQ0F+Uhw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3gk7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668neG7005794;
	Mon, 6 Jul 2026 08:52:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfvk9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qcAM31720152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 054FA20043;
	Mon,  6 Jul 2026 08:52:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 975BC2004B;
	Mon,  6 Jul 2026 08:52:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:37 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v4 19/27] s390: Introduce Start Arm Execution instruction
Date: Mon,  6 Jul 2026 10:52:19 +0200
Message-ID: <20260706085229.979525-20-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4b6cde cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=fi3W0JNvqw8oYKyNxrkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX9z9HBmQfJxs0
 7OeqoJIVWdDJV/h2nS5Xk/cQsLPn/nTnaNJu5+kY5LnjSzFsN47UXSw0FDHcM5B/NTcC3QeJLA8
 ZTHexrpP8NI5J0sOgPd8xFas+acL0CU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX6HAmUynkhvTS
 79smnv2MV8ug4e9YorZcInyBPK/+qqG72UEAUYyJ0/wmJU0TpsVHT8jgHDhIshWqSZjoj1UePQP
 NfoYCHGyhwEj6AyJ2bamlt/h8NRtEx7Q2qyoTBAfvYkH47zEEzLyYx3cj33L2v4jCZgZtmITYRH
 Rj8n3UI8xExVDW8YLkENbVLrFDUh7J5T6xLw0i4ikj5LX26fSS7r6QhGB3MdWulyuaXVgIXTsA5
 cCPMGws/rj18t5W0fZjf1DWXdPpzcuKailbSt2xqeNc1qQ15KhRkfCw2LBlHXAKngD9Yp/nVi7+
 l0gDvloFv0tSx3XjWsxsMGkoxKY7FUwJHE42zEiwXUBk+J9ZCvJK4ScdwOUVK63GlvSK80tjvZs
 lMOw5zzBUqzJGIFyQ9H+U/3KA/S5EC0OLnYXj2IYQ5edjSrdDFpciRzMtUPMxPrWbS7MImHcpNn
 7gtejTD47iXehaiYqYw==
X-Proofpoint-ORIG-GUID: SkKKRSPGQj86pcqWmEb5tBDU6DmbvGvo
X-Proofpoint-GUID: SkKKRSPGQj86pcqWmEb5tBDU6DmbvGvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

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

Enlighten asm/kvm_host_types.h for the new header variant. The new
header is chosen instead of asm/kvm_host_s390_types.h if KVM_S390_ARM64
is defined.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/asm-prototypes.h       |   1 +
 arch/s390/include/asm/kvm_host_arm64_types.h | 129 +++++++++++++++++++
 arch/s390/include/asm/kvm_host_types.h       |   4 +
 arch/s390/include/asm/sae.h                  |  56 ++++++++
 arch/s390/include/asm/stacktrace.h           |   5 +
 arch/s390/kernel/asm-offsets.c               |   1 +
 arch/s390/kernel/entry.S                     |  25 ++++
 arch/s390/tools/opcodes.txt                  |   3 +
 8 files changed, 224 insertions(+)
 create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
 create mode 100644 arch/s390/include/asm/sae.h

diff --git a/arch/s390/include/asm/asm-prototypes.h b/arch/s390/include/asm/asm-prototypes.h
index d4da4436d02b..faa2afb259a1 100644
--- a/arch/s390/include/asm/asm-prototypes.h
+++ b/arch/s390/include/asm/asm-prototypes.h
@@ -6,6 +6,7 @@
 #include <asm/bug.h>
 #include <asm/fpu.h>
 #include <asm/nospec-branch.h>
+#include <asm/sae.h>
 #include <asm-generic/asm-prototypes.h>
 
 #endif /* _ASM_S390_PROTOTYPES_H */
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
diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_types.h
index e5bdba07cab0..d308739ebcf5 100644
--- a/arch/s390/include/asm/kvm_host_types.h
+++ b/arch/s390/include/asm/kvm_host_types.h
@@ -3,6 +3,10 @@
 #ifndef ASM_KVM_HOST_TYPES_H
 #define ASM_KVM_HOST_TYPES_H
 
+#ifdef KVM_S390_ARM64
+#include <asm/kvm_host_arm64_types.h>
+#else
 #include <asm/kvm_host_s390_types.h>
+#endif /* KVM_S390_ARM64 */
 
 #endif /* ASM_KVM_HOST_TYPES_H */
diff --git a/arch/s390/include/asm/sae.h b/arch/s390/include/asm/sae.h
new file mode 100644
index 000000000000..fe010a1a7729
--- /dev/null
+++ b/arch/s390/include/asm/sae.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_S390_SAE_H
+#define __ASM_S390_SAE_H
+
+#include "linux/linkage.h"
+#include <linux/types.h>
+
+/* defined in arch/s390/kernel/entry.S */
+asmlinkage int __sae64a(phys_addr_t sae_block_phys);
+
+#ifndef __ASSEMBLER__
+#include <linux/io.h>
+#include <asm/kvm_host_arm64_types.h>
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
+ * @save_area: Pointer to SAE save area
+ *
+ * Store the guest system register to the save area.
+ * The values in the guest are not valid anymore..
+ */
+static __always_inline void stiasrm(struct kvm_sae_save_area *save_area)
+{
+	asm volatile(
+		"	.insn	rre,0xb9a70000,%[r1],0\n"
+		: "+m"(*save_area)
+		: [r1] "a"(save_area)
+	);
+}
+
+/**
+ * lasrm() - Load Arm System Register Multiple
+ *
+ * @save_area: Pointer to SAE save area
+ *
+ * Load the system registers from save_area into the guest.
+ */
+static __always_inline void lasrm(struct kvm_sae_save_area *save_area)
+{
+	asm volatile(
+		"	.insn	rre,0xb9a60000,%[r1],0\n"
+		:
+		: "m"(*save_area), [r1] "a"(save_area)
+	);
+}
+
+#endif /* !__ASSEMBLER__ */
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
index f6dd2b67dcee..f9f9c2246074 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -70,6 +70,7 @@ int main(void)
 	OFFSET(__SF_SIE_CONTROL_PHYS, stack_frame, sie_control_block_phys);
 	OFFSET(__SF_SIE_GUEST_ASCE, stack_frame, sie_guest_asce);
 	OFFSET(__SF_SIE_IRQ, stack_frame, sie_irq);
+	OFFSET(__SF_SAE_BEAR, stack_frame, sae_bear);
 	DEFINE(STACK_FRAME_OVERHEAD, sizeof(struct stack_frame));
 	BLANK();
 	OFFSET(__SFUSER_BACKCHAIN, stack_frame_user, back_chain);
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 9572620fcaa6..248bea26921b 100644
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
+	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
+	xgr	%r0,%r0				# clear guest registers to
+	xgr	%r1,%r1				# prevent speculative use
+	xgr	%r3,%r3
+	xgr	%r2,%r2
+	xgr	%r4,%r4
+	xgr	%r5,%r5
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
2.53.0

