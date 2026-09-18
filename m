Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6DD502778;
	Fri, 18 Sep 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738615; cv=none; b=Xamj1iHNld+c7hnHLiWSn4krcW+S51cAjPDTv7vbOIkRQpzsL/wSt6GTvT6Eef9Pw/a+yvG/L9XN3u+X2XJ+p8jAEGjtl7ZlSHZBQ9LZUAzF5jOBOcx/yWvbn3g4ZSA3RTUXTgIfslGYrPPKmDm3CghkWlsv9oj8A1ukyVnlqas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738615; c=relaxed/simple;
	bh=PwhFqFMAeYeK+MC4/KZZfQxyMfFiJimRkPCte/6WvZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiyK1nd44UbbCHYTkrJzOElQ5M31zy4TeJN0oQCz27Ray8WnLsCZ7Uet10cfW1i3HTYkyvCNL3RgrzPon0tZKTa+uSM3kDgU7wbpW67pIl6EJsFRpizTwsUEwkFOwRVp8arZkzWIJ4KCPODRWNWwB3aF9qtqERQiG8V1GXzfjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gYpzmgqQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gYpzmgqQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1jfO803606;
	Fri, 18 Sep 2026 13:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JE4/GZMkKMUK8RFbS
	+RuHFWgO7/CyR4r6pUgWEewwFQ=; b=gYpzmgqQ7f/biLtZJTivXq8A/tEjngxAi
	Em1fnVXuyHD/XfZUnFeb/NvguyrvYWakpkPXQ7FIkFPA0O3NCHByGVh6JU7FwNRr
	0+pRpypDfjLFKt+4EEIQAo/bTr0eSQ+qF0LwU7uwbrP49jC9hD6zt0D5Cy2PtWFu
	KLELwVCI/ltV8T6TJgWXufDNRGY4lLDz+qRike3p4MnI7DRGnBMaoRNuF9QPwukC
	b8rSIf4MXxpEhAlBf3F3Spll2ZHU+w/wPp60i1lMmkwTCpOIsAkpXYW+Q/+HjHYw
	oW0a2npFu0csU8jbhlmTD57r9zoMk2G1NZpdX+2wCP4EnRIf9Arxg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j814k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNxAf695613;
	Fri, 18 Sep 2026 13:31:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fek7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDVCeh48103896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB1D120040;
	Fri, 18 Sep 2026 13:31:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 827682004D;
	Fri, 18 Sep 2026 13:31:12 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:12 +0000 (GMT)
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
Subject: [PATCH v8 13/29] KVM: arm64: Access elements of vcpu_gp_regs individually
Date: Fri, 18 Sep 2026 15:30:50 +0200
Message-ID: <20260918133107.1042730-14-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918133107.1042730-1-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfXy6IdVay5VOV+
 e3MmoMNok4Gw42Q3Mz7wgwbH4AUC/LCcV7E+W/wi/jlfVc5XCU/IchaapkVrT5t6QabUBRHUqnz
 IsIl8qdS2HMuqyKF9FHnsvlhHeXxwbPhXdfU1s2BDii9nHac1CpDeg8f32BYb0i59w2WVn9xOIj
 M6h4VTOfZ4z0bU26zJ+T2zTQ91qTy/emJi5SP4dikf+7wurppLES1NjneC7AEes7Sevy9VFrI/R
 vdrSbWjbJOHP7s8R99VDLIyjLDME7hSGYZW9Nq04smVUidLs/G6FqODlRZejl+vrqHFd20+ft2D
 6dYxz637Mv097ZA6Y7CV1UVPu63YcoRaZaISTXJihiJzWlj5iG3wV3M7LBjD6BgvaritUlsqiKA
 roYp0+5GmWykJRW4ba+bDwnqZBv6bbrWp9Vj+s4rlLSavA1m5Gvmtxk88drseEz7f/XQN1MEZ+o
 yPxBoV/Dxf03rO1l1yQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX8vdrwBBt9wLD
 K8IQU+qUe5Dj8mpJwhzKVUV+P3hYF+pedTzrspKrGICvl1pyT0tLISonhbnOaEF/BsYw5QzW+Sd
 GIyqYGhb3mmyEOE0SL0Pg+Pwgv2FLSo=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aad3d2c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=2bnsYzwZQeDic6pRC-MA:9
X-Proofpoint-ORIG-GUID: s9eu1dlonEWwz8qODihA8Tu4nnYtV55f
X-Proofpoint-GUID: CyBk7QD1nSKWXwM7b1MZHoOFoswpNzm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180184

While for arm64 the members of vcpu_gp_regs are allocated continuous
this is not necessarily true for other architectures implementing ARM.

Let vcpu_gp_regs() no longer return the address of the user_pt_regs in
the vcpu context but the address of the gp-register array field in the
user_pt_reg struct. Note, this change semantically excludes pc from the
GPRs.

No functional change.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_emulate.h       | 14 ++++++++------
 arch/arm64/include/asm/kvm_host.h          |  2 +-
 arch/arm64/kvm/guest.c                     |  2 +-
 arch/arm64/kvm/hyp/exception.c             |  4 ++--
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h |  4 ++--
 arch/arm64/kvm/hyp/include/hyp/switch.h    |  4 ++--
 6 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index a3c1928bdf74..8603766c1b4d 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -133,12 +133,12 @@ static inline void vcpu_set_vsesr(struct kvm_vcpu *vcpu, u64 vsesr)
 
 static __always_inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcpu)
 {
-	return (unsigned long *)&vcpu_gp_regs(vcpu)->pc;
+	return (unsigned long *)&vcpu->arch.ctxt.regs.pc;
 }
 
 static __always_inline unsigned long *vcpu_cpsr(const struct kvm_vcpu *vcpu)
 {
-	return (unsigned long *)&vcpu_gp_regs(vcpu)->pstate;
+	return (unsigned long *)&vcpu->arch.ctxt.regs.pstate;
 }
 
 static __always_inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
@@ -167,14 +167,14 @@ static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
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
 
 static inline bool vcpu_is_el2_ctxt(const struct kvm_cpu_context *ctxt)
@@ -750,13 +750,15 @@ static inline void kvm_reset_vcpu_core(struct kvm_vcpu *vcpu)
 		pstate = VCPU_RESET_PSTATE_EL1;
 
 	/* Reset core registers */
-	memset(vcpu_gp_regs(vcpu), 0, sizeof(*vcpu_gp_regs(vcpu)));
+	memset(vcpu_gp_regs(vcpu), 0, sizeof(vcpu_gp_regs(vcpu)));
+	*vcpu_pc(vcpu) = 0;
+	vcpu->arch.ctxt.regs.sp = 0;
 	memset(&vcpu->arch.ctxt.fp_regs, 0, sizeof(vcpu->arch.ctxt.fp_regs));
 	vcpu->arch.ctxt.spsr_abt = 0;
 	vcpu->arch.ctxt.spsr_und = 0;
 	vcpu->arch.ctxt.spsr_irq = 0;
 	vcpu->arch.ctxt.spsr_fiq = 0;
-	vcpu_gp_regs(vcpu)->pstate = pstate;
+	*vcpu_cpsr(vcpu) = pstate;
 }
 
 /* PSCI reset handling for a vcpu. */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 9c314d0568b1..fc0037efa0b4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1161,7 +1161,7 @@ struct kvm_vcpu_arch {
 #define vcpu_clear_on_unsupported_cpu(vcpu)				\
 	vcpu_clear_flag(vcpu, ON_UNSUPPORTED_CPU)
 
-#define vcpu_gp_regs(v)		(&(v)->arch.ctxt.regs)
+#define vcpu_gp_regs(v)		((v)->arch.ctxt.regs.regs)
 
 /*
  * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index b01d6622b872..81d850d5a328 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -134,7 +134,7 @@ static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
 		off -= KVM_REG_ARM_CORE_REG(regs.regs[0]);
 		off /= 2;
-		return &vcpu->arch.ctxt.regs.regs[off];
+		return &vcpu_gp_regs(vcpu)[off];
 
 	case KVM_REG_ARM_CORE_REG(regs.sp):
 		return &vcpu->arch.ctxt.regs.sp;
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index 754e2dc1df54..0640c9ccaa3c 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -276,12 +276,12 @@ static void enter_exception32(struct kvm_vcpu *vcpu, u32 mode, u32 vect_offset)
 	switch(mode) {
 	case PSR_AA32_MODE_ABT:
 		__vcpu_write_spsr_abt(vcpu, host_spsr_to_spsr32(spsr));
-		vcpu_gp_regs(vcpu)->compat_lr_abt = return_address;
+		vcpu_gp_regs(vcpu)[__compat_lr_abt] = return_address;
 		break;
 
 	case PSR_AA32_MODE_UND:
 		__vcpu_write_spsr_und(vcpu, host_spsr_to_spsr32(spsr));
-		vcpu_gp_regs(vcpu)->compat_lr_und = return_address;
+		vcpu_gp_regs(vcpu)[__compat_lr_und] = return_address;
 		break;
 	}
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h b/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
index 4fdfeabefeb4..a049983bd5c3 100644
--- a/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
+++ b/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
@@ -33,11 +33,11 @@ static inline void kvm_skip_instr(struct kvm_vcpu *vcpu)
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
index 1ce7130e2549..a2a054fec2e2 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -470,7 +470,7 @@ static inline bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
 	u64 spsr;
 
 	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
-	arm64_mops_reset_regs(vcpu_gp_regs(vcpu), vcpu->arch.fault.esr_el2);
+	arm64_mops_reset_regs(&vcpu->arch.ctxt.regs, vcpu->arch.fault.esr_el2);
 	write_sysreg_el2(*vcpu_pc(vcpu), SYS_ELR);
 
 	/*
@@ -902,7 +902,7 @@ static inline void synchronize_vcpu_pstate(struct kvm_vcpu *vcpu)
 	/*
 	 * Check for the conditions of Cortex-A510's #2077057. When these occur
 	 * SPSR_EL2 can't be trusted, but isn't needed either as it is
-	 * unchanged from the value in vcpu_gp_regs(vcpu)->pstate.
+	 * unchanged from the value in vcpu_cpsr(vcpu).
 	 * Are we single-stepping the guest, and took a PAC exception from the
 	 * active-not-pending state?
 	 */
-- 
2.53.0

