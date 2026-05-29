Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3090F352001;
	Fri, 29 May 2026 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069891; cv=none; b=ebUFankZh0DAEvqbRsSguiKrC2GtgfnnWo2wF0cuDQMEpfzuAQDyQu8K4O+9p0uKwirj0jUt/mm4Q7ZjQy84OHwW18epPCP2NDLAuVyMyf+e0hz3tovI6/98R33f0uuqX2xM7cDA9CAOEtTfwxwRgzTcfsi6mTs8bqr4LnBWnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069891; c=relaxed/simple;
	bh=RdP/oDEFQ3mVy+/dVq0igY6FEA6FJz6a5rN2eaPMZMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHPEpXGo08Tux0LWMD8f9CMZWd/Kn8x/dsnPL6FNQLITEZHeftT2xLi4IFOHVIO2maACHh61Y8tyhvMPdfcZpMRictAE2u/VnW5R/5AL3CrMhpAB3Fw5/NFXUC6QwTf2tvLc+GC2dFWGFJl/AdOJhGW6t16Yr3q3+Als2zcqm4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B1KEl0eH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B1KEl0eH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TEwn2S3217825;
	Fri, 29 May 2026 15:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RZIkPhTZC2oMvi9+f
	6VWxmXpDnP265bNgFIDE0JDsY8=; b=B1KEl0eHyn4rWzYe4Osr8YTHWQ3S8/drU
	aYdU7vDu5sq7CVDDf2nHfBdBvb+J8mb13yLIJzXAShgpqRLEXrpMasS9B5dMjsnQ
	cobSuFeE1uXlRKxerV73wsvHLJzCXgOUcfGbCWNb4ZGxSnx4cEDmltGpQ+CS8OyK
	UFFD/ymfI1PBnFAxy1/QIntC5jgCYg9x5WhAwzYRGLtCTQTXwv+Q3i2LeG+2YHF8
	2HjnLVwWehu9ldQbDq/5+BgTrBUp5+btUu93wWg8yELg0sCY6PlPcFTZOT7XKDs4
	7xkLv8acQC9ouKrHyZ6zoUqEtb6Hk+SCu9CeUP8cAAZWHNc8HSdKg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bkw4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFd6Ix022954;
	Fri, 29 May 2026 15:51:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc8eum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFottI50987368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:50:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E926520063;
	Fri, 29 May 2026 15:50:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98E152004D;
	Fri, 29 May 2026 15:50:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:50:54 +0000 (GMT)
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
Subject: [PATCH v3 11/27] KVM: arm64: Access elements of vcpu_gp_regs individually
Date: Fri, 29 May 2026 17:50:25 +0200
Message-ID: <20260529155050.2902245-12-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155050.2902245-1-seiden@linux.ibm.com>
References: <20260529155050.2902245-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX0N/+APJ3ImSN
 oxsg/IKpcm7kx2IsOmb0vfMGyG1f42SZPYeaO7hcROnyuu6fV3s/PFFBtZgb5zDUcVM6L8XdSkJ
 nqaVXlwE3KqfU6SAP0AZlui4YWjfrBAyG30xMcHupw6tL/LsxhsJ604BZ5H5XM74N35SZPksXvJ
 eRJ0zGaHw5DoUrSMMqUl1irELCFNFBj8xrZCzMi9QQ/hnT6mcWEcfrJV75s5AT2hKQi0+CTd+hs
 kV3JU6Q++xlMD70Vpn3+irwJPBLy8jsgByBeuMqw+baB8ooidw9fIMslygnfeR16iTqLoVaYFAT
 jvjB4H4OHRjte6rgiFF6bFwiOKg/ZaNonywFw8JnT8hC436n3Mczap64kF4r5b+cp+bntH2JiAn
 3DCpGchSCko4Lgb973tjag6ZhdjW50gM/1jD64m4AEGnXiQLX5mcK48RAdM2cmIJz76aJ5U86jn
 o8nnPPU8uG5e5XbuWjw==
X-Proofpoint-ORIG-GUID: hkQFqjs7xmUrZWW7OU3orVOR3xFiA1NG
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a19b5e5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=MeYYmaBpUeygDV1_9ykA:9
X-Proofpoint-GUID: hkQFqjs7xmUrZWW7OU3orVOR3xFiA1NG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

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
 arch/arm64/kvm/reset.c                     | 6 ++++--
 include/kvm/arm64/kvm_emulate.h            | 4 ++--
 virt/kvm/arm64/guest.c                     | 6 +++---
 8 files changed, 27 insertions(+), 17 deletions(-)

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
index 549e9a6aa12c..6af4f5b39f41 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1089,7 +1089,7 @@ struct kvm_vcpu_arch {
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
index bf0eb5e43427..29f638e4a55f 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -447,7 +447,7 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
 static inline bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
-	arm64_mops_reset_regs(vcpu_gp_regs(vcpu), vcpu->arch.fault.esr_el2);
+	arm64_mops_reset_regs(&vcpu->arch.ctxt.regs, vcpu->arch.fault.esr_el2);
 	write_sysreg_el2(*vcpu_pc(vcpu), SYS_ELR);
 
 	/*
@@ -888,7 +888,7 @@ static inline void synchronize_vcpu_pstate(struct kvm_vcpu *vcpu)
 	/*
 	 * Check for the conditions of Cortex-A510's #2077057. When these occur
 	 * SPSR_EL2 can't be trusted, but isn't needed either as it is
-	 * unchanged from the value in vcpu_gp_regs(vcpu)->pstate.
+	 * unchanged from the value in vcpu_cpsr(vcpu).
 	 * Are we single-stepping the guest, and took a PAC exception from the
 	 * active-not-pending state?
 	 */
@@ -898,7 +898,7 @@ static inline void synchronize_vcpu_pstate(struct kvm_vcpu *vcpu)
 	    ESR_ELx_EC(read_sysreg_el2(SYS_ESR)) == ESR_ELx_EC_PAC)
 		write_sysreg_el2(*vcpu_cpsr(vcpu), SYS_SPSR);
 
-	vcpu->arch.ctxt.regs.pstate = read_sysreg_el2(SYS_SPSR);
+	*vcpu_cpsr(vcpu) = read_sysreg_el2(SYS_SPSR);
 }
 
 /*
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 036bf2dff976..e952dec01d74 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -218,13 +218,15 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 		pstate = VCPU_RESET_PSTATE_EL1;
 
 	/* Reset core registers */
-	memset(vcpu_gp_regs(vcpu), 0, sizeof(*vcpu_gp_regs(vcpu)));
+	memset(vcpu_gp_regs(vcpu), 0, sizeof(vcpu_gp_regs(vcpu)));
+	*vcpu_pc(vcpu) = 0;
+	*vcpu_sp_el0(vcpu) = 0;
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
2.53.0

