Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8A2EC0A2;
	Thu,  2 Apr 2026 04:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103800; cv=none; b=oJFVRnEG3bMFaTYVQ6OwxnBy46fjKdS0wf9iFbol4bAQmlUlizspzFmoHQr6T3KIsjcmbU8mb3lT5lROkFUsnIzQN7GiIH5YjBGWmXCdjJm7PIJLq/7Pcy6Vp5PLoYoF4O8TT84ftia9Yg6ItLaEkIuX3MffZdUdD0bJhWDTSdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103800; c=relaxed/simple;
	bh=Mvq8py788Mh3mfU1nMZB4AH7UlET8EH9TQAvEePsR9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fm2khjcuqJ9z2lvygEsoYz0n5/gznGKkyCr4s1jfEp1EEmTMog4pO9zTOnCjOYSq+o5dFG9OFkXbQpu8/FUXAjvqEJwbMFAkMeYsgBbkME3U+G220XrrZz9VVUHqg6HMCmko9rzkecQWb/W/g0jdNq+ic/ytxiinVVsNd0bV1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cPMtE2Hy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cPMtE2Hy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631GcAQ32736917;
	Thu, 2 Apr 2026 04:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fD1TTBBAaZWpV5o+U
	E2XEa0yqcF+08G1LVCR89fnulE=; b=cPMtE2Hyrp5n4rdS6um4KWFcf/1EXvVSN
	f25I63U8zdMK6KbtVQL/Bldy+dyC4rEE6V9UitXbD+X9bpcuoZwCe4WPLJlRIg7W
	Q+SKluddpE1LnjbLiPH9/bq6S1YsNy3HSwdchHr00tQSlgx+jBaEVPbDR+VU9rcI
	1QnxO7oOUX8FqyCdALTMHQgrsVYUix7zVuNDltnvXjU++dc+gxmrtRooXcSZSBWg
	9MT3ZvRi2bSM3w+5zLfCV2Q8HYdzH55RNonLExz3W6V5IBaAO1A9nTgTVH1Ja6Rv
	UU+tbXiuDFOIKjeXSzYyYCQRX/YOs0Ji3nOpGuDs4OHr+Ndtl7HzA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgtjgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631NdoeG005980;
	Thu, 2 Apr 2026 04:21:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy8q9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LUNq18481482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D60420040;
	Thu,  2 Apr 2026 04:21:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B7802005A;
	Thu,  2 Apr 2026 04:21:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:29 +0000 (GMT)
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
Subject: [PATCH v1 11/27] KVM: arm64: Access elements of vcpu_gp_regs individually
Date: Thu,  2 Apr 2026 06:21:07 +0200
Message-ID: <20260402042125.3948963-12-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfXwnXo7rk54/lj
 ZRJmse7Koyq21A5W4w1YfJLUv2mJQBW6g4/RmH99dTidA+0/TLdu+QrMYCrV7dFcobo5YEONj+4
 EmbsIOENEr6iPrtj7EBaP9vt3FdpEUsPhbPYA6xFY6ooLKWeAoEHJ3LwHETYgNyv4NceMdQfB5C
 3z8tjSB04sflSkM4iKRKZjTCyuKZrkNR+X8SUCpbFsu8v8w03rQS06AMFtSQAwsuRJpXauW1O4T
 YVFmsqLa9GQsBQmIrk7WNW7+vFwyl6RRfWu5N7KMHpIHPpHzMB69pcU8eR2tNdyTyvoBbP2/FIz
 JgRvVMrue9jGIhurseeDEAzmaQX06JDYTiYkKjoTokp7WQ99pZMwz9ntXdnviykT8vcyEpa9fOu
 8fiZAIj25C66SC1VHsX6FAfbGC67FmZpaPXdWYvqWhXa4UAp8WyN8ToCZ4IQlynAjfr98FBkoA1
 TvcRWKyAxamPHSXQ/Xw==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cdeecf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=MeYYmaBpUeygDV1_9ykA:9
X-Proofpoint-GUID: IY5dAn9zvF4cuCpuYfMr0mA_YuRnqvol
X-Proofpoint-ORIG-GUID: IY5dAn9zvF4cuCpuYfMr0mA_YuRnqvol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020034

While for arm64 the members of vcpu_gp_regs are allocated continuous
this is not necessarily true for other architectures implementing ARM.

Let vcpu_gp_regs() no longer return the address of the user_pt_regs in
the vcpu context but the address of the gp-register array field in the
user_pt_reg struct.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_emulate.h       | 9 +++++++--
 arch/arm64/include/asm/kvm_host.h          | 2 +-
 arch/arm64/kvm/hyp/exception.c             | 7 +++++--
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h | 4 ++--
 arch/arm64/kvm/hyp/include/hyp/switch.h    | 6 +++---
 arch/arm64/kvm/reset.c                     | 3 ++-
 include/kvm/arm64/kvm_emulate.h            | 4 ++--
 virt/kvm/arm64/guest.c                     | 6 +++---
 8 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 39fa3a12730c..41eac2b5de14 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -95,12 +95,17 @@ static inline void vcpu_set_vsesr(struct kvm_vcpu *vcpu, u64 vsesr)
 
 static __always_inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcpu)
 {
-	return (unsigned long *)&vcpu_gp_regs(vcpu)->pc;
+	return (unsigned long *)&vcpu->arch.ctxt.regs.pc;
 }
 
 static __always_inline unsigned long *vcpu_cpsr(const struct kvm_vcpu *vcpu)
 {
-	return (unsigned long *)&vcpu_gp_regs(vcpu)->pstate;
+	return (unsigned long *)&vcpu->arch.ctxt.regs.pstate;
+}
+
+static __always_inline unsigned long *vcpu_sp_el0(const struct kvm_vcpu *vcpu)
+{
+	return (unsigned long *)&vcpu->arch.ctxt.regs.sp;
 }
 
 static __always_inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ae9e507f2c7c..7e473b895740 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1050,7 +1050,7 @@ struct kvm_vcpu_arch {
 #define vcpu_clear_on_unsupported_cpu(vcpu)				\
 	vcpu_clear_flag(vcpu, ON_UNSUPPORTED_CPU)
 
-#define vcpu_gp_regs(v)		(&(v)->arch.ctxt.regs)
+#define vcpu_gp_regs(v)		((v)->arch.ctxt.regs.regs)
 
 /*
  * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index bef40ddb16db..82611442a2d1 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -277,6 +277,9 @@ static const u8 return_offsets[8][2] = {
 	[7] = { 4, 4 },		/* FIQ, unused */
 };
 
+#define OFFSETOF_PT_REG(__r) offsetof(struct user_pt_regs, __r)
+#define COMPAT_IDX(__c) ((OFFSETOF_PT_REG(__c) - OFFSETOF_PT_REG(regs[0])) / sizeof(u64))
+
 static void enter_exception32(struct kvm_vcpu *vcpu, u32 mode, u32 vect_offset)
 {
 	unsigned long spsr = *vcpu_cpsr(vcpu);
@@ -292,12 +295,12 @@ static void enter_exception32(struct kvm_vcpu *vcpu, u32 mode, u32 vect_offset)
 	switch(mode) {
 	case PSR_AA32_MODE_ABT:
 		__vcpu_write_spsr_abt(vcpu, host_spsr_to_spsr32(spsr));
-		vcpu_gp_regs(vcpu)->compat_lr_abt = return_address;
+		vcpu_gp_regs(vcpu)[COMPAT_IDX(compat_lr_abt)] = return_address;
 		break;
 
 	case PSR_AA32_MODE_UND:
 		__vcpu_write_spsr_und(vcpu, host_spsr_to_spsr32(spsr));
-		vcpu_gp_regs(vcpu)->compat_lr_und = return_address;
+		vcpu_gp_regs(vcpu)[COMPAT_IDX(compat_lr_und)] = return_address;
 		break;
 	}
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h b/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
index 15e1e5db73e1..4e4cb67824c0 100644
--- a/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
+++ b/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
@@ -20,11 +20,11 @@
 static inline void __kvm_skip_instr(struct kvm_vcpu *vcpu)
 {
 	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
-	vcpu_gp_regs(vcpu)->pstate = read_sysreg_el2(SYS_SPSR);
+	*vcpu_cpsr(vcpu) = read_sysreg_el2(SYS_SPSR);
 
 	kvm_skip_instr(vcpu);
 
-	write_sysreg_el2(vcpu_gp_regs(vcpu)->pstate, SYS_SPSR);
+	write_sysreg_el2(*vcpu_cpsr(vcpu), SYS_SPSR);
 	write_sysreg_el2(*vcpu_pc(vcpu), SYS_ELR);
 }
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 2597e8bda867..79e6e6cc9f81 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -416,7 +416,7 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
 static inline bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
-	arm64_mops_reset_regs(vcpu_gp_regs(vcpu), vcpu->arch.fault.esr_el2);
+	arm64_mops_reset_regs(&vcpu->arch.ctxt.regs, vcpu->arch.fault.esr_el2);
 	write_sysreg_el2(*vcpu_pc(vcpu), SYS_ELR);
 
 	/*
@@ -857,7 +857,7 @@ static inline void synchronize_vcpu_pstate(struct kvm_vcpu *vcpu)
 	/*
 	 * Check for the conditions of Cortex-A510's #2077057. When these occur
 	 * SPSR_EL2 can't be trusted, but isn't needed either as it is
-	 * unchanged from the value in vcpu_gp_regs(vcpu)->pstate.
+	 * unchanged from the value in vcpu_gp_cpsr(vcpu).
 	 * Are we single-stepping the guest, and took a PAC exception from the
 	 * active-not-pending state?
 	 */
@@ -867,7 +867,7 @@ static inline void synchronize_vcpu_pstate(struct kvm_vcpu *vcpu)
 	    ESR_ELx_EC(read_sysreg_el2(SYS_ESR)) == ESR_ELx_EC_PAC)
 		write_sysreg_el2(*vcpu_cpsr(vcpu), SYS_SPSR);
 
-	vcpu->arch.ctxt.regs.pstate = read_sysreg_el2(SYS_SPSR);
+	*vcpu_cpsr(vcpu) = read_sysreg_el2(SYS_SPSR);
 }
 
 /*
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 036bf2dff976..d039f1d7116a 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -219,12 +219,13 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	/* Reset core registers */
 	memset(vcpu_gp_regs(vcpu), 0, sizeof(*vcpu_gp_regs(vcpu)));
+	*vcpu_pc(vcpu) = 0;
 	memset(&vcpu->arch.ctxt.fp_regs, 0, sizeof(vcpu->arch.ctxt.fp_regs));
 	vcpu->arch.ctxt.spsr_abt = 0;
 	vcpu->arch.ctxt.spsr_und = 0;
 	vcpu->arch.ctxt.spsr_irq = 0;
 	vcpu->arch.ctxt.spsr_fiq = 0;
-	vcpu_gp_regs(vcpu)->pstate = pstate;
+	*vcpu_cpsr(vcpu) = pstate;
 
 	/* Reset system registers */
 	kvm_reset_sys_regs(vcpu);
diff --git a/include/kvm/arm64/kvm_emulate.h b/include/kvm/arm64/kvm_emulate.h
index 25322b95af21..0e16d18e53d2 100644
--- a/include/kvm/arm64/kvm_emulate.h
+++ b/include/kvm/arm64/kvm_emulate.h
@@ -77,14 +77,14 @@ static inline void kvm_skip_instr(struct kvm_vcpu *vcpu)
 static __always_inline unsigned long vcpu_get_reg(const struct kvm_vcpu *vcpu,
 						  u8 reg_num)
 {
-	return (reg_num == 31) ? 0 : vcpu_gp_regs(vcpu)->regs[reg_num];
+	return (reg_num == 31) ? 0 : vcpu_gp_regs(vcpu)[reg_num];
 }
 
 static __always_inline void vcpu_set_reg(struct kvm_vcpu *vcpu, u8 reg_num,
 					 unsigned long val)
 {
 	if (reg_num != 31)
-		vcpu_gp_regs(vcpu)->regs[reg_num] = val;
+		vcpu_gp_regs(vcpu)[reg_num] = val;
 }
 
 static inline u32 kvm_vcpu_hvc_get_imm(const struct kvm_vcpu *vcpu)
diff --git a/virt/kvm/arm64/guest.c b/virt/kvm/arm64/guest.c
index 83e33e0143b9..e283a4456df8 100644
--- a/virt/kvm/arm64/guest.c
+++ b/virt/kvm/arm64/guest.c
@@ -81,16 +81,16 @@ static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
 		off -= KVM_REG_ARM_CORE_REG(regs.regs[0]);
 		off /= 2;
-		return &vcpu_gp_regs(vcpu)->regs[off];
+		return &vcpu_gp_regs(vcpu)[off];
 
 	case KVM_REG_ARM_CORE_REG(regs.sp):
-		return &vcpu_gp_regs(vcpu)->sp;
+		return vcpu_sp_el0(vcpu);
 
 	case KVM_REG_ARM_CORE_REG(regs.pc):
 		return vcpu_pc(vcpu);
 
 	case KVM_REG_ARM_CORE_REG(regs.pstate):
-		return &vcpu_gp_regs(vcpu)->pstate;
+		return vcpu_cpsr(vcpu);
 
 	case KVM_REG_ARM_CORE_REG(sp_el1):
 		return __ctxt_sys_reg(&vcpu->arch.ctxt, SP_EL1);
-- 
2.51.0

