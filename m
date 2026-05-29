Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FD4402B82;
	Fri, 29 May 2026 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070205; cv=none; b=pgngsnvwSAVmsZrIzEOU1czOImyHhM/MezcNf7MMbnVdLxCz8oMvHQ+SXN6G3Bv+ydOoH/n9v9pgprLSvbnaq9jtNUEplxqAKOyq5Ff0j0cmr2HleupyaTBnJF3owRdpBaIwrd1S60aTXTa61F+asCtuF0JlZJKXfJMTHkBm5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070205; c=relaxed/simple;
	bh=2ivqFMlHIwtpqNyQCSR2gQAjjtAvPTwhTxp/oDtimZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAJzzteJc34zsFQv77dxcbG4r0Dl06uWeWAAfcVNxC8N7fqHX5d/cmRcq/B4ExIqAoOncLrS7wNDNB23l/DoxGtAefacxCS2YDAjwJm2b21ECeEkvhTtzywWJ8FFxTdQPtCUgB6/0D/XQBycYZEiTLc85nnl84yzQsZj3BJAvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i6RMln5/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i6RMln5/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFEloI1687341;
	Fri, 29 May 2026 15:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e3M5oeXK8/HvvH8AI
	JsdSiaYNNCDui2bO7UvB9DCeHA=; b=i6RMln5/jJlE9sRYdUs19yeO3qgElHN75
	w1OYoFfHfGoHKbqwXGHgxcRg7zGPauhY5bO7zvnJWXSnSjk83Kc2KFDrfYLcRnJq
	LTbZERCSq0zDuiueEEBqMNFrhgaRGIbISlU3KCr2eCVVMHqcza9PVP7RfK9+d4Xl
	90p6xPYL6zeGLIcd27eYB1NdK5iQk7vIWwEDUivFo0UpifnchKNysEGphyclpb9u
	PRCZ6Ta6FKyky8lzqEdhG0oJbC3ULQ+YkRi5x0pfn7SxG8o6sziuIdEYUP8Z+w4E
	8QTN+b7M4KRyGQvq8WbnaCm6/jwYZ0O6Ba2AgmCzTIE/xBT1nZEHA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884mh72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs6O9016985;
	Fri, 29 May 2026 15:56:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgjpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu8Kp30212444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40F1B20040;
	Fri, 29 May 2026 15:56:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6FFB2004D;
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
Subject: [PATCH v1 16/26] KVM: s390: arm64: Add sysreg related functions and definitions
Date: Fri, 29 May 2026 17:55:49 +0200
Message-ID: <20260529155601.2927240-17-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19b71f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=MsWRDpXVTiI-Ka77MfMA:9
X-Proofpoint-ORIG-GUID: 59SpjLFTUJAUYtbHRDBRyeo-pxmJMK2j
X-Proofpoint-GUID: 59SpjLFTUJAUYtbHRDBRyeo-pxmJMK2j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfXxHpZFV9dBMdY
 maZ4wn1wka7bBZQJPfQGGkbJ+DdOlFxGM5Q8fB8ATc430t4I2iLPXu7w0nqbnG5xtNNVb1UWlAt
 B7W1FnC51ffdKIzio9Ejid7scvtLtfOes//jH2NU63b8rd5WXNW6nrNYr6gR+B6X0NR/Fp+Jvqg
 awXd6NKhIe+R8u1B1/5uC0HzyiQk/p0XRm4ED1TsRHhedo+8vQIcTJZPSTC5J0E8eZGhL/Reepr
 JsAntrgqoFy8XUw88bDx2S9D5uMUTRVSj8xcG9O35p4MfMCZkemBEXkCafIE94OypLjDezgCfFD
 F3+B79bWhV3Oj63VS9fjghDNUJgBI81BhxNW4X5kTNc5rSUXQvm2eZGQgmTYjq0HeEnMo9cQWQi
 D3huPyi/X4TUH++KGY9NmDl3ZhfMWRuM3aCUbsw6sMBa1GUEa7R2mANkgtB1KyIIxLvAlfau8UM
 L+cJAriTG89JsQQm/lA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

Add guest sysreg access macros in asm/kvm_host_arm64.h using
easr()/sasr()-based helpers for sysregs that map to the SAE save area.

Also add the guest-visible sysreg enum and per-vCPU/per-VM storage for
state that is not directly covered by the save area, such as CLIDR_EL1,
CSSELR_EL1, MPIDR_EL1, and VM-wide ID register state.

This lays out the header-side definitions needed to ensure compilation
success during for the share-code-patches and later sysreg handling
during vCPU setup and runtime.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h | 165 +++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 8c3214c5b004..d6d9e3ad7a8e 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -44,10 +44,19 @@ struct kvm_vcpu_arch {
 	struct kvm_sae_save_area save_area;
 	struct kvm_cpu_context ctxt;
 
+	/* Guest system registers not part of save area or ID registers */
+	u64 sys_reg_clidr_el1;
+	u64 sys_reg_csselr_el1;
+	/* Per-vcpu CCSIDR override or NULL */
+	u32 *ccsidr;
+
 	u32 host_acrs[NUM_ACRS];
 
 	/* Hypervisor Configuration Register */
 	u64 hcr_elz;
+	u64 hcrx_elz;
+
+	u64 mpidr;
 
 	/* Configuration flags, set once and for all before the vcpu can run */
 	u8 cflags;
@@ -209,4 +218,160 @@ static inline void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)
 
 #define kvm_supports_32bit_el0() false
 
+#define vcpu_read_sys_reg(_v, _r) 0xbad1234bad
+#define vcpu_write_sys_reg(_v, _p, _r) ((void)0)
+
+#define __vcpu_sys_reg(__vcpu, __reg) \
+	vcpu_read_sys_reg(__vcpu, __reg)
+
+#define __vcpu_assign_sys_reg(__vcpu, __reg, __val) \
+	vcpu_write_sys_reg(__vcpu, __val, __reg)
+
+/* Read, modify and write system register
+ *
+ */
+#define _vcpu_rmw_sys_reg(C, V, OP, R) \
+({ \
+	u64 __val = vcpu_read_sys_reg(C, R); \
+	__val OP V; \
+	vcpu_write_sys_reg(C, __val, R); \
+})
+
+/**
+ * _vcpu_read_sys_reg() - read a guest sysreg with easr
+ * - R - sysreg id; must be readable by easr; must be compile time constant
+ *
+ *   if SYSREGS_ON_CPU: proceed with flags = 0
+ *   otherwise:         proceed with either
+ *                         read:  flags = EASR_FLAG_SA
+ *                         write: flags = SASR_FLAG_INITIALIZED
+ *
+ */
+#define _vcpu_read_sys_reg(C, R) \
+	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
+		BUG_ON(vcpu_is_loaded(C) && smp_processor_id() != (C)->cpu); \
+		(vcpu_is_loaded(C)) \
+			? __vcpu_read_sr((C), (R), 0) \
+			: __vcpu_read_sr((C), (R), EASR_FLAG_SA); })
+
+/**
+ * _vcpu_write_sys_reg() - write a guest sysreg with sasr
+ * - R - sysreg id; must be readable by sasr; must be compile time constant
+
+ *   if SYSREGS_ON_CPU: proceed with flags = 0
+ *   otherwise:         proceed with either
+ *                         read:  flags = EASR_FLAG_SA
+ *                         write: flags = SASR_FLAG_INITIALIZED
+ */
+#define _vcpu_write_sys_reg(C, V, R) \
+	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
+		BUG_ON(vcpu_is_loaded(C) && smp_processor_id() != (C)->cpu); \
+		(vcpu_is_loaded(C)) \
+			? __vcpu_write_sr((C), (V), (R), 0) \
+			: __vcpu_write_sr((C), (V), (R), SASR_FLAG_INITIALIZED); })
+
+/* Forward to easr / sasr
+ * assert that F and R are constant
+ */
+#define __vcpu_read_sr(C, R, F) \
+	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
+		BUILD_BUG_ON(!__builtin_constant_p((F))); \
+		easr((R), &(C)->arch.save_area, (F)); })
+
+#define __vcpu_write_sr(C, V, R, F) \
+	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
+		BUILD_BUG_ON(!__builtin_constant_p((F))); \
+		sasr((R), (V), &(C)->arch.save_area, (F)); })
+
+#define SR_GROUP(NAME, ...)	\
+	__##NAME##_BEGIN__,	\
+	__VA_ARGS__		\
+	__##NAME##_END__
+
+/** enum vcpu_sysreg - available guest sysregs
+ *
+ * Contains all arm64 guest-syregs supported by s390.
+ */
+enum vcpu_sysreg {
+	__INVALID_SYSREG__, /* 0 is reserved as an invalid value */
+
+	/* EL 0,1 Register from state description in order of appearance */
+	SR_GROUP(STATE_DESC,
+	CNTP_CTL_EL0,
+	CNTV_CTL_EL0,
+	CONTEXTIDR_EL1,
+	SP_EL1,
+	),
+
+	/* EL 0,1 Register requiring special handling. */
+	SR_GROUP(SPECIAL,
+	CSSELR_EL1,
+	CLIDR_EL1,
+	MPIDR_EL1,
+	),
+
+	/* EL 0,1 register from save area in order of appearance */
+	SR_GROUP(SAVE_AREA,
+	ACTLR_EL1,
+	AFSR0_EL1,
+	AFSR1_EL1,
+	CNTFRQ_EL0,
+	CNTP_CVAL_EL0,
+	CNTV_CVAL_EL0,
+	DISR_EL1,
+	MIDR_EL1,
+	OSLSR_EL1,
+	PAR_EL1,
+	OSLAR_EL1,
+	SCTLR_EL1,
+	CPACR_EL1,
+	VBAR_EL1,
+	SPSR_EL1,
+	ELR_EL1,
+	ESR_EL1,
+	TCR_EL1,
+	MAIR_EL1,
+	TTBR0_EL1,
+	TTBR1_EL1,
+	FAR_EL1,
+	TPIDR_EL0,
+	TPIDR_EL1,
+	TPIDRRO_EL0,
+	CNTKCTL_EL1,
+	ZCR_EL1,
+	SCXTNUM_EL0,
+	SCXTNUM_EL1,
+	APIBKEYLO_EL1,
+	APIBKEYHI_EL1,
+	APIAKEYLO_EL1,
+	APIAKEYHI_EL1,
+	APGAKEYLO_EL1,
+	APGAKEYHI_EL1,
+	APDBKEYLO_EL1,
+	APDBKEYHI_EL1,
+	APDAKEYLO_EL1,
+	APDAKEYHI_EL1,
+	MDSCR_EL1,
+	),
+
+	NR_SYS_REGS /* Nothing after this line! */
+};
+
+void vcpu_write_host_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg);
+u64 vcpu_read_host_sys_reg(const struct kvm_vcpu *vcpu, int reg);
+
+#define kvm_debug_handle_oslar(_v, _val) /* debug not implemented yet*/
+
+static inline u8 kvm_arm_pmu_get_pmuver_limit(void)
+{
+	return 0;
+}
+
+int __init kvm_sys_reg_table_init(void);
+
+static inline u64 kvm_sanitised_host_ftr_reg(u32 id)
+{
+	return 0xbad1234bad;
+}
+
 #endif /* ASM_KVM_HOST_ARM64_H */
-- 
2.53.0

