Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785C3603D8;
	Mon, 31 Aug 2026 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188014; cv=none; b=BVaUGYPi2mfH4C+sYwTc9b64OSAhC8m7PeIQku1Ns14D9CUdMFK7A+vwWFDSBRcyWb20oBJ5tN33LItg1QEQ/fJaGszACY8ZkzKJpfpm7gea9hmpSyPfReWjSTjQZyl3QwzdkIYhdOB52UroVTx4wQSQ5eo2D1zJR7eoIw9uYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188014; c=relaxed/simple;
	bh=xuszOJjItc1HZMFu1xGbLa3afP99/D1Cgki/3qGLiGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izcYALcoMRgTv7Krhg3kiU1BxxeLOU3Rdk5+9EzLMtXr2nS4eOK8IOgfly91JhxECLKjVKYO7S7snmuQqe2x32MT1HZSU+RBzBvVhfQGo6yXWu92HXaFH8cWTu7IzIJXpYvpTxYrs6938Eb+zcsUQ5IfziD9yM8987SQq7lZyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nu74pWgk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nu74pWgk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZEuf2414993;
	Mon, 31 Aug 2026 14:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GzfG6OHacUUS+/3v3
	s120WahVcAG8XJRKZTCvo15A34=; b=Nu74pWgklyyHwNL1OyQnKa6Gt0QW2hR6l
	IO+8HHB9VWk/vvceBbvXGjzrKrqDQWa9JkrT89Sfpz+Uhga8MSBn04Np6cQ+KNTa
	fHDgpZMEyi0hmfb862rr4Euqm/eOkc54tFgZntee3KVjkx/AbMwXH8NVpM98pn5Q
	qeBsSIxilIc/HkTMatrcUSGOiggItWlzs0Q8Fh6VHUgYpcfrD9//54KzrYYQlomu
	pDUz6oJQGRIUZjNxEMsVL4oNacrojw2DzPZ3/Xxv7KeoQCjQZc2hE1kavHn5k091
	2A7tnKJJ4zKt0auiRYWz8K1xxrKqMsJTPAXsZ9OuC0qM8yLbN6y4Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhj4rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfj29016988;
	Mon, 31 Aug 2026 14:48:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h6cjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEm7Qj39190792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:48:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8BD62004B;
	Mon, 31 Aug 2026 14:48:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F0202005A;
	Mon, 31 Aug 2026 14:48:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:48:07 +0000 (GMT)
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v7 10/23] arm64: Share arm64 headers with s390
Date: Mon, 31 Aug 2026 16:47:47 +0200
Message-ID: <20260831144802.834315-11-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831144802.834315-1-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ERopwA1YF0xGs7xKgKFIO14XMMCMgeip
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX7FbnQMdLKS1a
 dbvKxabxMB8BwTa3oyG2L7YqBB/5V9cak7Hbw4hJSoMZuNTTFLLJjzqUv7WQBaQ7rfskeF5Je7l
 bUQJ+PTYlDmBG7CAtQwmtWb6gaFENdgTEjriSaXXMJXM5Pmw7fUF5KQu8x+lV3bdwCQXC8FfDJ7
 NYCsiPS2meEWP5VrgjBroZWsjXAzVeF8CYMhKBtys/VDZJMf70t+BYLn1dRJJ5rrHjL8G4BUAiz
 bz2a1vNxSMtEF5r+CF9O6sVh1u5FJbQ+70IHnYQlFYu7pEbEszZLr65IOgeafB1UJ8L+2P/MDt4
 ygNf66biKWJBYcuEQ8HdnXZHrWYFO+Vy8BuIrkBGlvQyd0AInXig1gAe5rAeCrNzdiZH5klrSTl
 LLtt22CXCoeoYyRxRURLqy5hBYAv/UdWD+e/DgmeFx67m4SPyVT/Y5kFk1EiOo6+4WDiyJ6tioL
 9LhM9skOjicXbABvWxA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a95942d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8
 a=EmdgIBuBJ6aLKJQMbmsA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX66hc3Jv1S95X
 ls3//Vod78CRIhPSwRX8mz1KARtAtkrBHanTYGcycBNEwk+9waoDSXGIKaYBxYbKnuU6khvC6Gy
 nSsrSuD9dCySqYIJwiNDU96BuVm8y10=
X-Proofpoint-ORIG-GUID: -6D8BOHyqU9hK1QvXDyCmFEuG_amZZMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Allow sharing of arm64 headers with s390 by marking the shared regions
or add a comment that the whole file is shared.

The shared regions are marked with:

 #ifdef ARM64_S390_COMMON

 /* insert shared definitions here */

 #endif /* ARM64_S390_COMMON */

The preprocessor symbol ARM64_S390_COMMON is always defined for arm64.
s390 later will generate its own view of arm64 headers based on the
content inside the ifdef/endif block.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/Makefile                  |  5 +++++
 arch/arm64/include/asm/brk-imm.h     |  1 +
 arch/arm64/include/asm/esr.h         |  1 +
 arch/arm64/include/asm/kvm_arm.h     |  1 +
 arch/arm64/include/asm/kvm_emulate.h | 18 ++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h    | 13 +++++++++++++
 arch/arm64/include/asm/ptrace.h      |  4 ++++
 arch/arm64/include/asm/sysreg.h      | 15 +++++++++++++++
 8 files changed, 58 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6b005c8fef70..12cbad460258 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -45,6 +45,11 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU) \
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
 
+# Enable all code shared to s390
+KBUILD_CFLAGS	+= -DARM64_S390_COMMON
+KBUILD_AFLAGS	+= -DARM64_S390_COMMON
+KBUILD_CPPFLAGS	+= -DARM64_S390_COMMON
+
 ifeq ($(call rustc-min-version, 108500),y)
 KBUILD_RUSTFLAGS += --target=aarch64-unknown-none-softfloat
 else
diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
index beb42c62b6ac..dd2d153dc0d8 100644
--- a/arch/arm64/include/asm/brk-imm.h
+++ b/arch/arm64/include/asm/brk-imm.h
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2012 ARM Ltd.
  */
+/* Whole file is shared with s390 */
 
 #ifndef __ASM_BRK_IMM_H
 #define __ASM_BRK_IMM_H
diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index da085c83b57e..2cb73bde7346 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -3,6 +3,7 @@
  * Copyright (C) 2013 - ARM Ltd
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
+/* Whole file is shared with s390 */
 
 #ifndef __ASM_ESR_H
 #define __ASM_ESR_H
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 57edd8437200..678f0daed445 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -3,6 +3,7 @@
  * Copyright (C) 2012,2013 - ARM Ltd
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
+/* Whole file is shared with s390 */
 
 #ifndef __ARM64_KVM_ARM_H__
 #define __ARM64_KVM_ARM_H__
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index a34a9417ff4d..09f04a5686a1 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -47,6 +47,7 @@ void kvm_skip_instr32(struct kvm_vcpu *vcpu);
 int kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, u64 addr);
 int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr);
 
+#ifdef ARM64_S390_COMMON
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr);
 int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr);
@@ -62,6 +63,8 @@ static inline int kvm_inject_sea_iabt(struct kvm_vcpu *vcpu, u64 addr)
 	return kvm_inject_sea(vcpu, true, addr);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static inline int kvm_inject_serror(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -185,6 +188,7 @@ static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
 	*vcpu_cpsr(vcpu) |= PSR_AA32_T_BIT;
 }
 
+#ifdef ARM64_S390_COMMON
 /*
  * vcpu_get_reg and vcpu_set_reg should always be passed a register number
  * coming from a read of ESR_EL2. Otherwise, it may give the wrong result on
@@ -203,6 +207,8 @@ static __always_inline void vcpu_set_reg(struct kvm_vcpu *vcpu, u8 reg_num,
 		vcpu_gp_regs(vcpu)[reg_num] = val;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static inline bool vcpu_is_el2_ctxt(const struct kvm_cpu_context *ctxt)
 {
 	switch (ctxt->regs.pstate & (PSR_MODE32_BIT | PSR_MODE_MASK)) {
@@ -405,6 +411,7 @@ static inline u64 kvm_vcpu_get_disr(const struct kvm_vcpu *vcpu)
 	return vcpu->arch.fault.disr_el1;
 }
 
+#ifdef ARM64_S390_COMMON
 static inline u32 kvm_vcpu_hvc_get_imm(const struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_xVC_IMM_MASK;
@@ -482,6 +489,8 @@ static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static inline
 bool kvm_vcpu_trap_is_permission_fault(const struct kvm_vcpu *vcpu)
 {
@@ -522,6 +531,7 @@ static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
 	return ESR_ELx_SYS64_ISS_RT(esr);
 }
 
+#ifdef ARM64_S390_COMMON
 static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
 {
 	if (kvm_vcpu_abt_iss1tw(vcpu)) {
@@ -546,6 +556,8 @@ static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_dabt_iswrite(vcpu);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
 {
 	return __vcpu_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
@@ -587,6 +599,7 @@ static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu)
 	return vcpu_read_sys_reg(vcpu, r) & bit;
 }
 
+#ifdef ARM64_S390_COMMON
 static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
 						    unsigned long data,
 						    unsigned int len)
@@ -662,6 +675,8 @@ static __always_inline void kvm_incr_pc(struct kvm_vcpu *vcpu)
 		vcpu_set_flag((v), e);					\
 	} while (0)
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * Returns a 'sanitised' view of CPTR_EL2, translating from nVHE to the VHE
  * format if E2H isn't set.
@@ -768,6 +783,7 @@ static inline void kvm_reset_fpsimd(struct kvm_vcpu *vcpu)
 	memset(&vcpu->arch.ctxt.fp_regs, 0, sizeof(vcpu->arch.ctxt.fp_regs));
 }
 
+#ifdef ARM64_S390_COMMON
 /* Reset a vcpu's core registers. */
 static inline void kvm_reset_vcpu_core(struct kvm_vcpu *vcpu)
 {
@@ -792,6 +808,8 @@ static inline void kvm_reset_vcpu_core(struct kvm_vcpu *vcpu)
 	*vcpu_cpsr(vcpu) = pstate;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 /* PSCI reset handling for a vcpu. */
 static inline void kvm_reset_vcpu_psci(struct kvm_vcpu *vcpu,
 				       struct vcpu_reset_state *reset_state)
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5261c21a437c..a8ddce3921b8 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -39,6 +39,7 @@
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
+#ifdef ARM64_S390_COMMON
 #define KVM_VCPU_MAX_FEATURES 10
 #define KVM_VCPU_VALID_FEATURES	(BIT(KVM_VCPU_MAX_FEATURES) - 1)
 
@@ -96,6 +97,8 @@ struct vcpu_reset_state {
 	bool		reset;
 };
 
+#endif /* ARM64_S390_COMMON */
+
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 				     KVM_DIRTY_LOG_INITIALLY_SET)
 
@@ -955,6 +958,7 @@ struct kvm_vcpu_arch {
 	pid_t pid;
 };
 
+#ifdef ARM64_S390_COMMON
 /*
  * Each 'flag' is composed of a comma-separated triplet:
  *
@@ -1113,6 +1117,8 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 /* KVM is currently emulating an L2 to L1 exception */
 #define IN_NESTED_EXCEPTION	__vcpu_single_flag(sflags, BIT(9))
 
+#endif /* ARM64_S390_COMMON */
+
 #define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)
 
 #define vcpu_sve_zcr_elx(vcpu)						\
@@ -1326,6 +1332,7 @@ int __init populate_nv_trap_config(void);
 
 void kvm_calculate_traps(struct kvm_vcpu *vcpu);
 
+#ifdef ARM64_S390_COMMON
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
@@ -1341,6 +1348,8 @@ unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
 int kvm_handle_mmio_return(struct kvm_vcpu *vcpu);
 int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * Returns true if a Performance Monitoring Interrupt (PMI), a.k.a. perf event,
  * arrived in guest context.  For arm64, any event that arrives while a vCPU is
@@ -1533,11 +1542,15 @@ static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
 	return test_bit(feature, ka->vcpu_features);
 }
 
+#ifdef ARM64_S390_COMMON
+
 #define kvm_vcpu_has_feature(k, f)	__vcpu_has_feature(&(k)->arch, (f))
 #define vcpu_has_feature(v, f)	__vcpu_has_feature(&(v)->kvm->arch, (f))
 
 #define kvm_vcpu_initialized(v) vcpu_get_flag(v, VCPU_INITIALIZED)
 
+#endif /* ARM64_S390_COMMON */
+
 int kvm_trng_call(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM
 extern phys_addr_t hyp_mem_base;
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 49a83a0636b9..05c1307fa62f 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -26,6 +26,8 @@
 
 #define GIC_PRIO_PSR_I_SET	GICV3_PRIO_PSR_I_SET
 
+#ifdef ARM64_S390_COMMON
+
 /* Additional SPSR bits not exposed in the UABI */
 #define PSR_MODE_THREAD_BIT	(1 << 0)
 #define PSR_IL_BIT		(1 << 20)
@@ -66,6 +68,8 @@
 #define PSR_AA32_IT_MASK	0x0600fc00	/* If-Then execution state mask */
 #define PSR_AA32_GE_MASK	0x000f0000
 
+#endif /* ARM64_S390_COMMON */
+
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define PSR_AA32_ENDSTATE	PSR_AA32_E_BIT
 #else
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index ab205f9db94a..1c5c4df260be 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -16,6 +16,8 @@
 
 #include <asm/gpr-num.h>
 
+#ifdef ARM64_S390_COMMON
+
 /*
  * ARMv8 ARM reserves the following encoding for system registers:
  * (Ref: ARMv8 ARM, Section: "System instruction class encoding overview",
@@ -50,6 +52,8 @@
 #define sys_reg_CRm(id)	(((id) >> CRm_shift) & CRm_mask)
 #define sys_reg_Op2(id)	(((id) >> Op2_shift) & Op2_mask)
 
+#endif /* ARM64_S390_COMMON */
+
 #ifndef CONFIG_BROKEN_GAS_INST
 
 #ifdef __ASSEMBLER__
@@ -123,6 +127,8 @@
 #define GSB_SYS_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 0, 31)
 #define GSB_ACK_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 1, 31)
 
+#ifdef ARM64_S390_COMMON
+
 /* Data cache zero operations */
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
 #define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
@@ -832,6 +838,8 @@
 #define SCTLR_ELx_A	 (BIT(1))
 #define SCTLR_ELx_M	 (BIT(0))
 
+#endif /* ARM64_S390_COMMON */
+
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define ENDIAN_SET_EL2		SCTLR_ELx_EE
 #else
@@ -866,6 +874,7 @@
 	 SCTLR_EL1_LSMAOE | SCTLR_EL1_nTLSMD | SCTLR_EL1_EIS   | \
 	 SCTLR_EL1_TSCXT  | SCTLR_EL1_EOS)
 
+#ifdef ARM64_S390_COMMON
 /* MAIR_ELx memory attributes (used by Linux) */
 #define MAIR_ATTR_DEVICE_nGnRnE		UL(0x00)
 #define MAIR_ATTR_DEVICE_nGnRE		UL(0x04)
@@ -1102,6 +1111,8 @@
 #define GICV5_GICR_CDNMIA_TYPE_MASK	GENMASK_ULL(31, 29)
 #define GICV5_GICR_CDNMIA_ID_MASK	GENMASK_ULL(23, 0)
 
+#endif /* ARM64_S390_COMMON */
+
 #define gicr_insn(insn)			read_sysreg_s(GICV5_OP_GICR_##insn)
 #define gic_insn(v, insn)		write_sysreg_s(v, GICV5_OP_GIC_##insn)
 
@@ -1251,6 +1262,8 @@
 	par;								\
 })
 
+#ifdef ARM64_S390_COMMON
+
 #define SYS_FIELD_VALUE(reg, field, val)	reg##_##field##_##val
 
 #define SYS_FIELD_GET(reg, field, val)		\
@@ -1263,6 +1276,8 @@
 		 FIELD_PREP(reg##_##field##_MASK,	\
 			    SYS_FIELD_VALUE(reg, field, val))
 
+#endif /* ARM64_S390_COMMON */
+
 #endif /* __ASSEMBLER__ */
 
 #endif	/* __ASM_SYSREG_H */
-- 
2.53.0

