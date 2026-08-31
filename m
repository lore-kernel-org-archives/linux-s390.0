Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9650AC32;
	Mon, 31 Aug 2026 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188481; cv=none; b=MGNx7G/eU4YFFm+y2O/1pymkPdcPVDdvLuZTX4OD9afKvlEVt3GMIZAHFsX/z0LwOS36GkBSuvnUoP3WityOBy3LQX5AfyNEJ7yvt2MEgFJU06AuZx2eGz9PaI/HAQGjTkkib5XYC6KpV6co+hllVfWejfhh08pcxesJ1kQmfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188481; c=relaxed/simple;
	bh=bb3aiLd9iScwKLQU/1rLXgiBkzSlFeXt10Owv/lBfoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCvDTOQzTei5l4EmsMbP0hgyokDExGWzA3y8QQQ3cTuFjuHCgpbYUFC/k+y3NvIHGxGZZR+bzoB8I4L0ZsVPgahJgto66a0HO+wVWgoAXcNhE7TlJfIVGESKIwUjXleURHBX/lk36zzxBi0NeljbcRcKVj811YFDLuco99IPeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gwrmK0ZQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gwrmK0ZQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ4AA2530227;
	Mon, 31 Aug 2026 14:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=s9RXi8cWdOuhf99gi
	JpVpGld/e6VeLWZsH8HtH0/9wg=; b=gwrmK0ZQxvY8SA03jkyJBxU+UpeSJGToy
	/G4BEPjvWU3d2r6VokmGSirTWYJaEXrQHVomsAt+ejX4nL/dDmKOdQQ2Td/VJOx6
	iOPTbZqnDAVUoZzXg5Uk92deNdrMYfG+6xq7CwwnVABB8f7GCtZFfKz3DAcyvK8r
	SYlk96sCpPkTuj0orEr1Jgq1kvem16h3fRl///SYQrUkTVnPkQPXCGeraM1C6+5W
	U209eO/HKAnxCQrKf8rQ1XQVu4dPjIIZfqgjKU19pwzkmIVGNTaUz+eTJlYk18gw
	wc2f8h9FnXW6+XVkzHMswBSB7jEji4H20aZUfU2AE0qjGpq8V6gsA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5a1uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfklD017001;
	Mon, 31 Aug 2026 14:55:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h6dpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEthH745482444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F090E2004B;
	Mon, 31 Aug 2026 14:55:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A1BE20043;
	Mon, 31 Aug 2026 14:55:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:42 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
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
Subject: [PATCH v2 11/20] KVM: s390: arm64: Query Available Arm features
Date: Mon, 31 Aug 2026 16:55:26 +0200
Message-ID: <20260831145536.913567-12-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9595f7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=CKwS3Y6PJaTERBR545sA:9
X-Proofpoint-GUID: QvUhSyyf-Pnt7Tauu4D_iiR7pFaImIpl
X-Proofpoint-ORIG-GUID: eCww6_D9fKaWwm_sknPbdAdH4UT_XIXu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXwkSXmNmKXR/A
 JID1B5RW5qPcWU9wbntDS8GlnRNp5/QmrhWWteLNjymKn8gvsAcRDW86rTM6o3MmmhgdAbQrc5L
 xP0TNjYJk0nK3x7csROXXeNSWa9gWQc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX6+flEdlCUjbE
 sdqtxOn3nFslj1VBVK7QAtcNGIe7J+5hvVS9GtcH0ay08ndSXxLw2WyFt8Bhc8O/hf70sUiYXa9
 xP4JQmv0JDuGWUVoM7OwAFbC+9FPi5wmQhMiiTv/+TKnWu26brMxcd/6JrsUiJEG6YmblZayW9h
 pxvh0UuctY8TAWXdhLKPpsTdb38FmDIS6sKUIzfUvAeAK/9DgWSVdCdpPq4A9owvzAgdzvhBq3g
 O6NUQ34UQXNbUR4sEt++ncs3J/AnB411KTIP1osUI5tLH669SGSoNFpVkvnApG2UOAnLUD8G0/M
 pTpVZqkBhxVJOuqkFo2U/SqMB0QcUJXLW2sS/cmScqLmZVGcSX0h70rCPj9xL+4iKIms8zoNxmY
 TzmhnuqK11geLXbjzQ7QNE9pC5srgv3jNNUj7viO8EQQ5Q3neC9ZmBF3q8f7FooDK6oeneC0GdS
 TXlXY7wBXX8pU6gXWdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

QAAF enables s390 hosts to gain information about the support
and handling of various arm features supported by the machine.

Function code 1 provides general information about available formats,
machine defined content of system/id register, and other various
information for running arm guests.

Function code 2 provides a initialised save area.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/aef.h                  |  28 +++++
 arch/s390/include/asm/kvm_host_arm64_types.h | 111 +++++++++++++++++++
 arch/s390/include/asm/sae.h                  |  25 +++++
 arch/s390/kernel/Makefile                    |   2 +-
 arch/s390/kernel/aef.c                       | 101 +++++++++++++++++
 arch/s390/kvm/arm64/Makefile                 |   1 +
 arch/s390/kvm/arm64/arm.c                    |   3 +-
 arch/s390/kvm/arm64/qaaf.c                   |  69 ++++++++++++
 arch/s390/kvm/arm64/qaaf.h                   |  10 ++
 arch/s390/tools/opcodes.txt                  |   1 +
 10 files changed, 349 insertions(+), 2 deletions(-)
 create mode 100644 arch/s390/include/asm/aef.h
 create mode 100644 arch/s390/kernel/aef.c
 create mode 100644 arch/s390/kvm/arm64/qaaf.c
 create mode 100644 arch/s390/kvm/arm64/qaaf.h

diff --git a/arch/s390/include/asm/aef.h b/arch/s390/include/asm/aef.h
new file mode 100644
index 000000000000..2f29e3875d4e
--- /dev/null
+++ b/arch/s390/include/asm/aef.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_S390_AEF_H
+#define _ASM_S390_AEF_H
+
+#include <asm/kvm_host_arm64_types.h>
+
+/**
+ * kvm_init_save_area() - Initialize Guest Save Area
+ * @save_area: Pointer to kvm_sae_save_area structure to initialize
+ *
+ * Context: Must be called before using the save area with lasrm/stiasrm instructions.
+ */
+void kvm_vcpu_init_save_area(struct kvm_sae_save_area *sa);
+struct qaaf_qmc_block *aef_qmc(void);
+
+struct aef_info {
+	unsigned long arm_guest_supp;
+	unsigned long sae_avail;
+	unsigned long ptff_avail;
+	unsigned long supp_state_desc_formats;
+	unsigned long supp_save_area_formats;
+	unsigned long max_num_vcpu;
+};
+
+const struct aef_info *aef_info(void);
+
+#endif /* _ASM_S390_AEF_H */
diff --git a/arch/s390/include/asm/kvm_host_arm64_types.h b/arch/s390/include/asm/kvm_host_arm64_types.h
index 2c922ef478d1..93fd649a26f4 100644
--- a/arch/s390/include/asm/kvm_host_arm64_types.h
+++ b/arch/s390/include/asm/kvm_host_arm64_types.h
@@ -115,4 +115,115 @@ struct kvm_sae_save_area {
 } __packed __aligned(PAGE_SIZE);
 static_assert(sizeof(struct kvm_sae_save_area) == PAGE_SIZE);
 
+#define QAAF_FC_QMC	1
+#define QAAF_FC_GISRSA	2
+
+union qaaf_gr0_gisrsa {
+	struct {
+		u8 _0000[6];
+		u8 saf;
+		u8 : 2;
+		u8 fc : 6;
+	};
+	u64 val;
+};
+
+static_assert(sizeof(union qaaf_gr0_gisrsa) == sizeof(u64));
+
+/* QAAF Query Model Capabilities */
+struct qaaf_qmc_block {
+	u64	_0000;			/* 0x0000 */
+	u8	ssdf;			/* 0x0008 */
+	u8	_0009;			/* 0x0009 */
+	u8	ssaf;			/* 0x000a */
+	u8	_000b[3];		/* 0x000b */
+	u16	maxncpu;		/* 0x000e */
+	u64	regs[0x1fe];		/* 0x0010 */
+} __aligned(PAGE_SIZE);
+static_assert(sizeof(struct qaaf_qmc_block) == PAGE_SIZE);
+
+union qaaf_block {
+	struct qaaf_qmc_block qmc;
+	struct kvm_sae_save_area save_area;
+} __aligned(PAGE_SIZE);
+static_assert(sizeof(union qaaf_block) == PAGE_SIZE);
+
+/*
+ * Keep in sync with mapping from SYS_* to QAAF_* in feature.c!
+ */
+enum {
+	QAAF_REG_MIDR_EL1		= 0x02,
+	/* 0x03 -0x06 reserved */
+	QAAF_REG_MPIDR_EL1		= 0x07,
+	QAAF_REG_REVIDR_EL1		= 0x08,
+	/* 0x09 reserved */
+	QAAF_REG_ID_PFR0_EL1		= 0x0a,
+	QAAF_REG_ID_PFR1_EL1		= 0x0b,
+	QAAF_REG_ID_DFR0_EL1		= 0x0c,
+	QAAF_REG_ID_AFR0_EL1		= 0x0d,
+	QAAF_REG_ID_MMFR0_EL1		= 0x0e,
+	QAAF_REG_ID_MMFR1_EL1		= 0x0f,
+	QAAF_REG_ID_MMFR2_EL1		= 0x10,
+	QAAF_REG_ID_MMFR3_EL1		= 0x11,
+	QAAF_REG_ID_ISAR0_EL1		= 0x12,
+	QAAF_REG_ID_ISAR1_EL1		= 0x13,
+	QAAF_REG_ID_ISAR2_EL1		= 0x14,
+	QAAF_REG_ID_ISAR3_EL1		= 0x15,
+	QAAF_REG_ID_ISAR4_EL1		= 0x16,
+	QAAF_REG_ID_ISAR5_EL1		= 0x17,
+	QAAF_REG_ID_MMFR4_EL1		= 0x18,
+	QAAF_REG_ID_ISAR6_EL1		= 0x19,
+	QAAF_REG_MVFR0_EL1		= 0x1a,
+	QAAF_REG_MVFR1_EL1		= 0x1b,
+	QAAF_REG_MVFR2_EL1		= 0x1c,
+	/* 0x1d reserved */
+	QAAF_REG_ID_PFR2_EL1		= 0x1e,
+	QAAF_REG_ID_DFR1_EL1		= 0x1f,
+	QAAF_REG_ID_MMFR5_EL1		= 0x20,
+	/* 0x21 reserved */
+	QAAF_REG_ID_AA64PFR0_EL1	= 0x22,
+	QAAF_REG_ID_AA64PFR1_EL1	= 0x23,
+	QAAF_REG_ID_AA64PFR2_EL1	= 0x24,
+	/* 0x25 reserved */
+	QAAF_REG_ID_AA64ZFR0_EL1	= 0x26,
+	QAAF_REG_ID_AA64SMFR0_EL1	= 0x27,
+	/* 0x28 reserved */
+	QAAF_REG_ID_AA64FPFR0_EL1	= 0x29,
+	QAAF_REG_ID_AA64DFR0_EL1	= 0x2a,
+	QAAF_REG_ID_AA64DFR1_EL1	= 0x2b,
+	QAAF_REG_ID_AA64DFR2_EL1	= 0x2c,
+	/* 0x2d reserved */
+	QAAF_REG_ID_AA64AFR0_EL1	= 0x2e,
+	QAAF_REG_ID_AA64AFR1_EL1	= 0x2f,
+	/* 0x30,0x31 reserved */
+	QAAF_REG_ID_AA64ISAR0_EL1	= 0x32,
+	QAAF_REG_ID_AA64ISAR1_EL1	= 0x33,
+	QAAF_REG_ID_AA64ISAR2_EL1	= 0x34,
+	QAAF_REG_ID_AA64ISAR3_EL1	= 0x35,
+	/* 0x36-0x39 reserved */
+	QAAF_REG_ID_AA64MMFR0_EL1	= 0x3a,
+	QAAF_REG_ID_AA64MMFR1_EL1	= 0x3b,
+	QAAF_REG_ID_AA64MMFR2_EL1	= 0x3c,
+	QAAF_REG_ID_AA64MMFR3_EL1	= 0x3d,
+	QAAF_REG_ID_AA64MMFR4_EL1	= 0x3e,
+	/* 0x3f-0x41 reserved */
+	QAAF_REG_CNTFRQ_EL0		= 0x42,
+	QAAF_REG_CTR_EL0		= 0x43,
+	QAAF_REG_AIDR_EL1		= 0x44,
+	/* 0x43-0x49 reserved */
+	QAAF_IRPTC			= 0x4a,
+	/* 0x4b reserved */
+	QAAF_REG_ICH_VTR_EL2		= 0x4c,
+	QAAF_GIC_ATTR			= 0x4d,
+	/* 0x4E-0x51 reserved */
+	QAAF_REG_PMMIR_EL1		= 0x52,
+	QAAF_REG_PMCR_EL0		= 0x53,
+	QAAF_REG_PMCEID0_EL0		= 0x54,
+	QAAF_REG_PMCEID1_EL0		= 0x55,
+	/* 0x56-0x1ff reserved */
+	_QAAF_MAX
+};
+
+static_assert(sizeof(struct qaaf_qmc_block) / 8 + 1 >= _QAAF_MAX);
+
 #endif /* ASM_KVM_HOST_ARM64_TYPES_H */
diff --git a/arch/s390/include/asm/sae.h b/arch/s390/include/asm/sae.h
index 6580536544ee..f88d15b8f1e9 100644
--- a/arch/s390/include/asm/sae.h
+++ b/arch/s390/include/asm/sae.h
@@ -111,5 +111,30 @@ static __always_inline void lasrm(struct kvm_sae_save_area *save_area)
 	);
 }
 
+/**
+ * qaaf() - Query Available Arm Features
+ * @gr0: QAAF function code, placed in greg 0
+ * @qaaf_block: Pointer to the page for the output
+ *
+ * Perform QAAF. The result ins written to qaaf_block.
+ */
+static __always_inline int qaaf(u64 gr0, union qaaf_block *qaaf_block)
+{
+	int exception = 1;
+
+	asm volatile(
+		"	lgr	0,%[r0]\n"
+		"	.insn	rre,0xb9ad0000,%[r1],0\n"
+		"0:	lhi	%[exc],0\n"
+		"1:\n"
+		EX_TABLE(0b, 1b)
+		: "=m"(*qaaf_block), [exc] "+d"(exception)
+		: [r1] "a"(qaaf_block), [r0] "d"(gr0)
+		: "r0"
+	);
+
+	return exception;
+}
+
 #endif /* !__ASSEMBLER__ */
 #endif /* __ASM_S390_SAE_H */
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index f84b8fb41331..0f3b9fcd1885 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -46,7 +46,7 @@ obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
 obj-y	+= entry.o reipl.o kdebugfs.o alternative.o skey.o
 obj-y	+= nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
 obj-y	+= smp.o text_amode31.o stacktrace.o abs_lowcore.o facility.o uv.o wti.o
-obj-y	+= diag/
+obj-y	+= diag/ aef.o
 
 always-$(KBUILD_BUILTIN)	+= vmlinux.lds
 
diff --git a/arch/s390/kernel/aef.c b/arch/s390/kernel/aef.c
new file mode 100644
index 000000000000..825e2643a892
--- /dev/null
+++ b/arch/s390/kernel/aef.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "linux/export.h"
+#include <linux/kconfig.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/slab.h>
+
+#include <asm/aef.h>
+#include <asm/boot_data.h>
+#include <asm/sae.h>
+#include <asm/sclp.h>
+#include <asm/sections.h>
+
+static struct qaaf_qmc_block qmc = {};
+static struct kvm_sae_save_area save_area = {};
+static struct aef_info info = {};
+
+/**
+ * kvm_init_save_area() - Initialize Guest Save Area
+ * @save_area: Pointer to kvm_sae_save_area structure to initialize
+ *
+ * Context: Must be called before using the save area with lasrm/stiasrm instructions.
+ */
+void kvm_vcpu_init_save_area(struct kvm_sae_save_area *sa)
+{
+	memcpy(sa, &save_area, sizeof(save_area));
+}
+EXPORT_SYMBOL(kvm_vcpu_init_save_area);
+
+struct qaaf_qmc_block *aef_qmc(void)
+{
+	return &qmc;
+}
+EXPORT_SYMBOL(aef_qmc);
+
+const struct aef_info *aef_info(void)
+{
+	return &info;
+}
+EXPORT_SYMBOL(aef_info);
+
+static int __init aef_init_save_area(void)
+{
+	int ret;
+
+	union qaaf_gr0_gisrsa gr0 = {
+		.fc = QAAF_FC_GISRSA,
+		.saf = SAE_SAVE_AREA_FORMAT_0,
+	};
+
+	ret = qaaf(gr0.val, (union qaaf_block *)&save_area);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int  __init aef_query_info(void)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_KVM_S390_ARM64)) {
+		info.sae_avail = sclp.has_aef;
+		info.ptff_avail = ptff_query(PTFF_QAGTO) &&
+				  ptff_query(PTFF_QAGPT);
+		info.arm_guest_supp = info.sae_avail && info.ptff_avail;
+	}
+	if (!info.sae_avail)
+		return 0;
+
+	ret = qaaf(QAAF_FC_QMC, (union qaaf_block *)&qmc);
+	if (ret)
+		return ret;
+
+	info.supp_state_desc_formats = qmc.ssdf;
+	info.supp_save_area_formats = qmc.ssaf;
+	info.max_num_vcpu = qmc.maxncpu;
+
+	return 0;
+}
+
+static int __init aef_sysfs_init(void)
+{
+	int rc = -ENOMEM;
+
+	if (!IS_ENABLED(CONFIG_KVM_S390_ARM64))
+		return 0;
+
+	rc = aef_query_info();
+	if (rc)
+		return rc;
+
+	rc = aef_init_save_area();
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+arch_initcall(aef_sysfs_init);
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index ae614a62f7b5..577b0653a68e 100644
--- a/arch/s390/kvm/arm64/Makefile
+++ b/arch/s390/kvm/arm64/Makefile
@@ -14,6 +14,7 @@ kvm-arm64-obj := \
 	inject_fault.o \
 	mmio.o \
 	mmu.o \
+	qaaf.o \
 	reset.o \
 
 kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(kvm-y))
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 2740ee3b703e..664fea5cf6b5 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -12,6 +12,7 @@
 #include <linux/bitfield.h>
 
 #include <asm/access-regs.h>
+#include <asm/aef.h>
 
 #include <arm64/kvm_emulate.h>
 #include <arm64/sysreg.h>
@@ -744,7 +745,7 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 
 static int __init kvm_s390_arm64_init(void)
 {
-	if (!sclp.has_aef)
+	if (!aef_info()->arm_guest_supp)
 		return -ENXIO;
 
 	return kvm_init_with_dev(sizeof(struct kvm_vcpu), 0, THIS_MODULE,
diff --git a/arch/s390/kvm/arm64/qaaf.c b/arch/s390/kvm/arm64/qaaf.c
new file mode 100644
index 000000000000..c3124d38afc2
--- /dev/null
+++ b/arch/s390/kvm/arm64/qaaf.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm_host.h>
+#include <asm/aef.h>
+#include "qaaf.h"
+
+#define _qaaf_reg_case(id) case SYS_##id: return aef_qmc()->regs[QAAF_REG_##id]
+
+u64 kvm_qaaf_read_ftr_reg(u32 id)
+{
+	switch (id) {
+	_qaaf_reg_case(MIDR_EL1);
+	_qaaf_reg_case(MPIDR_EL1);
+	_qaaf_reg_case(REVIDR_EL1);
+	_qaaf_reg_case(ID_PFR0_EL1);
+	_qaaf_reg_case(ID_PFR1_EL1);
+	_qaaf_reg_case(ID_DFR0_EL1);
+	_qaaf_reg_case(ID_AFR0_EL1);
+	_qaaf_reg_case(ID_MMFR0_EL1);
+	_qaaf_reg_case(ID_MMFR1_EL1);
+	_qaaf_reg_case(ID_MMFR2_EL1);
+	_qaaf_reg_case(ID_MMFR3_EL1);
+	_qaaf_reg_case(ID_ISAR0_EL1);
+	_qaaf_reg_case(ID_ISAR1_EL1);
+	_qaaf_reg_case(ID_ISAR2_EL1);
+	_qaaf_reg_case(ID_ISAR3_EL1);
+	_qaaf_reg_case(ID_ISAR4_EL1);
+	_qaaf_reg_case(ID_ISAR5_EL1);
+	_qaaf_reg_case(ID_MMFR4_EL1);
+	_qaaf_reg_case(ID_ISAR6_EL1);
+	_qaaf_reg_case(MVFR0_EL1);
+	_qaaf_reg_case(MVFR1_EL1);
+	_qaaf_reg_case(MVFR2_EL1);
+	_qaaf_reg_case(ID_PFR2_EL1);
+	_qaaf_reg_case(ID_DFR1_EL1);
+	_qaaf_reg_case(ID_MMFR5_EL1);
+	_qaaf_reg_case(ID_AA64PFR0_EL1);
+	_qaaf_reg_case(ID_AA64PFR1_EL1);
+	_qaaf_reg_case(ID_AA64PFR2_EL1);
+	_qaaf_reg_case(ID_AA64ZFR0_EL1);
+	_qaaf_reg_case(ID_AA64SMFR0_EL1);
+	_qaaf_reg_case(ID_AA64FPFR0_EL1);
+	_qaaf_reg_case(ID_AA64DFR0_EL1);
+	_qaaf_reg_case(ID_AA64DFR1_EL1);
+	_qaaf_reg_case(ID_AA64DFR2_EL1);
+	_qaaf_reg_case(ID_AA64AFR0_EL1);
+	_qaaf_reg_case(ID_AA64AFR1_EL1);
+	_qaaf_reg_case(ID_AA64ISAR0_EL1);
+	_qaaf_reg_case(ID_AA64ISAR1_EL1);
+	_qaaf_reg_case(ID_AA64ISAR2_EL1);
+	_qaaf_reg_case(ID_AA64ISAR3_EL1);
+	_qaaf_reg_case(ID_AA64MMFR0_EL1);
+	_qaaf_reg_case(ID_AA64MMFR1_EL1);
+	_qaaf_reg_case(ID_AA64MMFR2_EL1);
+	_qaaf_reg_case(ID_AA64MMFR3_EL1);
+	_qaaf_reg_case(ID_AA64MMFR4_EL1);
+	_qaaf_reg_case(CNTFRQ_EL0);
+	_qaaf_reg_case(CTR_EL0);
+	_qaaf_reg_case(AIDR_EL1);
+	_qaaf_reg_case(ICH_VTR_EL2);
+	_qaaf_reg_case(PMMIR_EL1);
+	_qaaf_reg_case(PMCR_EL0);
+	_qaaf_reg_case(PMCEID0_EL0);
+	_qaaf_reg_case(PMCEID1_EL0);
+	default:
+		WARN(true, "Unknown feature register 0x%x\n", id);
+		return 0xbad1234bad;
+	}
+}
diff --git a/arch/s390/kvm/arm64/qaaf.h b/arch/s390/kvm/arm64/qaaf.h
new file mode 100644
index 000000000000..8fed7f795ce0
--- /dev/null
+++ b/arch/s390/kvm/arm64/qaaf.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ARCH_S390_KVM_ARM64_QAAF_H
+#define ARCH_S390_KVM_ARM64_QAAF_H
+
+#include <asm/aef.h>
+
+u64 kvm_qaaf_read_ftr_reg(u32 id);
+
+#endif
diff --git a/arch/s390/tools/opcodes.txt b/arch/s390/tools/opcodes.txt
index 18af14071290..fd5483107961 100644
--- a/arch/s390/tools/opcodes.txt
+++ b/arch/s390/tools/opcodes.txt
@@ -600,6 +600,7 @@ b9a7	stiasrm	RRE_R0
 b9aa	lptea	RRF_RURR2
 b9ab	essa	RRF_U0RR
 b9ac	irbm	RRE_RR
+b9ad	qaaf	RRE_R0
 b9ae	rrbm	RRE_RR
 b9af	pfmf	RRE_RR
 b9b0	cu14	RRF_U0RR
-- 
2.53.0

