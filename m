Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B53F0A99;
	Fri, 29 May 2026 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070497; cv=none; b=e3B5YAwMw2G/p8bFWnFesPh/avLg5S6ptfAf4Hn2/HKIFuq5DSwoKBrRo2RKhzuJFNNMuBmCUoZsnAH1Nf1LZG+FGubRG036OMYl0zdniCHXMRVvUPQlwB72jIj+OAkEqrVS6fvC2rwQookfYe9XVGWneRt4B/eWmjxxBgEA1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070497; c=relaxed/simple;
	bh=BUzPlyqZ+pCOIzcOrqzch+Yiqb3DVpTAJdRTlrJ/f8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLmFo7ddO4NcgbS18Lgz6qCJDaUQ7j1qrWzIU2MtdRfWraae21RismfGb5653pp0gxCHOeqcuc2qA0vx46XHRbgCHanXUxhA9vh+Mwy8oNcXcBvd0n4P/a7U6W7rMkoaTneB712gODkYv5YvutsiDJTqtZk/83QAQewHhNYwheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f3P5V3HD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f3P5V3HD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFpqUf1684655;
	Fri, 29 May 2026 15:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nZmkXK6RhtIK2VMR3
	5jlDZhLRNQF6Fzob0wRyeJApKE=; b=f3P5V3HDDWbD8YOo37yqTZgPwMeHBfyBk
	bkbXxPHB7QJkIrrh+3IpMJaBDQVulMbtKO2lXaLuBtCBVkxbrRT4ph2Hx4Sk0Tv4
	v+qzpHnWZUF7pbVg/deiMxcnzrIZhhB9UpX3SkBQn1sAXzZSFJz1Uy2bh+fJFmp8
	rpweYI79ZyEZesqVeMsgXbleuvIVUSPCXCf/887nU20HNreZaiJJfbfYedWe1syz
	Wny3OSTKChksKCzCu3krHD9GzkpRPPNj5FjBOQUTXZvo8drx3eiRmpP2MF1ikt0H
	g3VwrAQH+xePQObYvwf7Qq1uNH6dh+f1D8AiFRGiYN2q7WFBtnrvA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884mh79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs8E1027824;
	Fri, 29 May 2026 15:56:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc8jn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu7md50004436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82D7720040;
	Fri, 29 May 2026 15:56:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25E252004D;
	Fri, 29 May 2026 15:56:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:07 +0000 (GMT)
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
Subject: [PATCH v1 14/26] s390: Introduce Query Available Arm features
Date: Fri, 29 May 2026 17:55:47 +0200
Message-ID: <20260529155601.2927240-15-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155601.2927240-1-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19b720 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=NGOT3fJOeBrWVEuXvOwA:9
X-Proofpoint-ORIG-GUID: jzBUttBrMfErQZAvtecOHuga00WuxSdG
X-Proofpoint-GUID: jzBUttBrMfErQZAvtecOHuga00WuxSdG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX5TlCfP8BYm0D
 Yv+5UkhhFObBpmGBqaURexhgYjVtr1f9moA+q0LcdHuUlnD0zu5neiTCRRO7cfO71HIu4gMt2QP
 5CQqU+OgXvlg2awgv8uiHrnHl2mLplpJtphiDj2O5NXeQTAbMaf/8vPg3oNg65UbqGJaZgHpHA9
 xtZb3WSLT5+Ttu+YOZdSBvbHoLCc3ITakDZBamcmcUlL0c7pTxnwr+k/Ki3DOdDImkw7FPcFkc3
 /bmD6cKf0VQ83Sz8frSaKsnjrea59T9CCuxlLDVQeg/Hj8+35red0BsZxksIFOaPGDMk2pws8ga
 aRaYxbK6JV8vvnSpLFSHryISeBecRfFrZUD3uFehQmZSvsyGZx4kuTL1b5xwwnKua+9j5ln4TF5
 6BfIOH9/bcSSvFgxiO3e9yJsGWTDcdwHh92ko7wLtXbVhS8X8VLcaBlYVdfeh5hNxbyZ/qHChHt
 UP8RGhuPWR4UwDlfAXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

QAAF enables s390 hosts to gain information about the support
and handling of various arm features supported by the machine.

Function code 1 provides general information about available formats,
machine defined content of system/id register, and other various
information for running arm guests.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64_types.h | 96 ++++++++++++++++++++
 arch/s390/include/asm/sae.h                  | 28 ++++++
 arch/s390/tools/opcodes.txt                  |  1 +
 3 files changed, 125 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host_arm64_types.h b/arch/s390/include/asm/kvm_host_arm64_types.h
index 3882d5462a05..16f7018a1714 100644
--- a/arch/s390/include/asm/kvm_host_arm64_types.h
+++ b/arch/s390/include/asm/kvm_host_arm64_types.h
@@ -126,4 +126,100 @@ struct kvm_sae_save_area {
 } __packed __aligned(PAGE_SIZE);
 static_assert(sizeof(struct kvm_sae_save_area) == PAGE_SIZE);
 
+#define QAAF_FC_QMC	1
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
+	/* 0x44-0x49 reserved */
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
index 1d9a16b91b23..f6f79443d6ce 100644
--- a/arch/s390/include/asm/sae.h
+++ b/arch/s390/include/asm/sae.h
@@ -110,5 +110,33 @@ static __always_inline void lasrm(struct kvm_sae_save_area *save_area)
 	);
 }
 
+/**
+ * qaaf() - Query Available Arm Features
+ * @gr0: QAAF function code, placed in greg 0
+ * @qaaf_block: Pointer to the page for the output
+ *
+ * Perform QAAF. The result ins written to qaaf_block.
+ */
+static __always_inline void qaaf(u64 gr0, union qaaf_block *qaaf_block)
+{
+	asm volatile(
+		"	lgr	0,%[r0]\n"
+		"	.insn	rre,0xb9ad0000,%[r1],0"
+		: "=m"(*qaaf_block)
+		: [r1] "a"(qaaf_block), [r0] "d"(gr0)
+		: "r0"
+	);
+}
+
+/**
+ * qaaf_qmc() - Query Available Arm Features for Model Capabilities
+ * @qmc: Pointer to qaaf_qmc_block structure to receive model capabilities
+ *
+ */
+static __always_inline void qaaf_qmc(struct qaaf_qmc_block *qmc)
+{
+	qaaf(QAAF_FC_QMC, (union qaaf_block *)qmc);
+}
+
 #endif /* !__ASSEMBLER__ */
 #endif /* __ASM_S390_SAE_H */
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

