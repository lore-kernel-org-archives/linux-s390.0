Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD234DA541;
	Mon,  6 Jul 2026 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328005; cv=none; b=WUjQJSpNS9BHKZWHnwme3xdf6t9smnHdSrzXJ0YeYp6k0Y0JqKmuweMgofAOWBIXoN1NJf9bAdkGpkC7slRFs0hPS9vE4n749aTNmTJAr83r/9+JVBkncA3kkUcpGNgao0O3JWQ1VdWGCfoAWfQR3QryIZpehxIAJTbpJ+bCshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328005; c=relaxed/simple;
	bh=+x7GjxKYrGbJDMEpHSumPrFMjG6q6KmR9HJt7MjSZJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ielWPpEeTavjqwDzj5ZO8JOftWz04QhU7aBMkGiEC3eTL5gxjJLMpXxWcw+10b1L3OEVG7UkBR8/H9359sPKg7OlqSNneipfvSn3v3rYVwzUF+fL8mJL5T+Na0Og4JADjrbiLOSuy3u2zuKoUn7EmrAd1S+E/g7KQBfFU6+uq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OPhdossJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OPhdossJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIvY82428809;
	Mon, 6 Jul 2026 08:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FfuGLIdfn03lbG+Rv
	T26C9rerJA1mIvU+6OF4zBBWgY=; b=OPhdossJEWsfQOdHiCuBLplQbdOABRp6+
	nTQxbJlCFUzJ3U0OmyE8vlOWImSTRfn4PzFUUkmRGB2j5GIknZGHY04lyUNGIlan
	t/wxgumHvAUO2uEvwnx4FKDv7sLxDP52vHqJ/zteP+8FsWiHZlq+Feur+i1I/Kzu
	xlHpxSwa+vVWUSGuSYalS72XghQ2gIuY6y356t5Cd/ioIyBlR3MJvpSQwg4h7VJ6
	LlLjjdFb97sTV1oZAXWXxTNcOeVYv/areDDssQ0Vbynba5+9Hhje2pYSkHYku3ue
	vQrAU1Fo1s9X+79R4R5q3NEK79Q2ytOfJ9KLipkDlsbcdROUVNIBg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqgfqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nbau009549;
	Mon, 6 Jul 2026 08:52:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpw1b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qW0L43647428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D515120043;
	Mon,  6 Jul 2026 08:52:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 693DC2004D;
	Mon,  6 Jul 2026 08:52:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:32 +0000 (GMT)
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
Subject: [PATCH v4 07/27] arm64: Prepare sharing arm64 headers with s390
Date: Mon,  6 Jul 2026 10:52:07 +0200
Message-ID: <20260706085229.979525-8-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX3Og40w3EXpew
 wcHCKhylZ+HbJgFTxrPBmK8+eJo8DmhAJ0KcdZEC3eP07WxRAvm1jwFL6OCDehurTw+MQ6i42cb
 blgI23C4Be44eAPofOAOXHAPWTRt9KI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXyiOJyJbqFUU0
 FZxjAGLu1FfOujYt+bI5NWtRkA8Yf3Xro0Wp8SMZB08KadEvTePxB/P5ntBaM9n6M0CuO5kgj9U
 BJmhvCbIVdv9pCz+vAdKPCjgBjMZ2BmpAABOeBnnWI7Tn/CpeBujkLBpUlSO4GfUc58toFitlxJ
 pQg6l5dQ9TP/28v4SNqRT85iHC0pihmaxZ4XYyJBj0jGZwB3SPHe+5YSaifGzq8GPJ5K2juMEfm
 x42lArpL0emmCLc87iHQzp+qbNdMdGA12ekxsyzdbmvFMD/GPCYsmrOdDWZI3YnYsfVXvhK3XPI
 Prl1Zc4H/PIWM9df0mYqK44vpsl43sb6dakBY5jwp2RYH7c3SC5h7IEpZ5RyUlvqT3vH5lQJVKd
 7eWhKb14Ld5caHl1RizIwM1GaBVGlKMLKzlIrzKW2OfHqdsE17yAkphisC/a7TLFCoe+gL/G8FO
 FVW4noyKMnM6iRod3Pw==
X-Proofpoint-GUID: zv96r9Xb8W1EPJhp4i2pkpwIrk1glks8
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4b6cd8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8
 a=jW-2y7uZZx9RLxiv-xkA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: zv96r9Xb8W1EPJhp4i2pkpwIrk1glks8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

Prepare the sharing of arm64 headers with s390 by marking the shared
regions or add a comment that the whole file is shared.
The regions are marked with:

 #define ARM64_S390_COMMON

 /* insert shared definitions here */

 #endif /* ARM64_S390_COMMON */

The preprocessor symbol ARM64_S390_COMMON is always defined for arm64.
Reduce the include scope where possible and beneficial for s390.
No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/Makefile                  |  2 ++
 arch/arm64/include/asm/brk-imm.h     |  1 +
 arch/arm64/include/asm/esr.h         |  5 +++--
 arch/arm64/include/asm/kvm_arm.h     |  6 ++++--
 arch/arm64/include/asm/kvm_emulate.h | 19 ++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h    | 28 +++++++++++++++++++++++++++
 arch/arm64/include/asm/kvm_mmu.h     |  6 ++++++
 arch/arm64/include/asm/ptrace.h      |  9 +++++++++
 arch/arm64/include/asm/sysreg.h      | 29 +++++++++++++++++++++++++---
 9 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6b005c8fef70..1cd7cd94a855 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -43,7 +43,9 @@ CC_FLAGS_NO_FPU	:= -mgeneral-regs-only
 KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU) \
 		   $(compat_vdso) $(cc_has_k_constraint)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
+KBUILD_CFLAGS	+= -DARM64_S390_COMMON
 KBUILD_AFLAGS	+= $(compat_vdso)
+KBUILD_AFLAGS	+= -DARM64_S390_COMMON
 
 ifeq ($(call rustc-min-version, 108500),y)
 KBUILD_RUSTFLAGS += --target=aarch64-unknown-none-softfloat
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
index 81c17320a588..e25b742b09ac 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -3,11 +3,12 @@
  * Copyright (C) 2013 - ARM Ltd
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
+/* Whole file is shared with s390 */
 
 #ifndef __ASM_ESR_H
 #define __ASM_ESR_H
 
-#include <asm/memory.h>
+#include <asm/brk-imm.h>
 #include <asm/sysreg.h>
 
 #define ESR_ELx_EC_UNKNOWN	UL(0x00)
@@ -435,7 +436,7 @@
 #define ESR_ELx_IT_GCSPOPX		7
 
 #ifndef __ASSEMBLER__
-#include <asm/types.h>
+#include <linux/types.h>
 
 static inline unsigned long esr_brk_comment(unsigned long esr)
 {
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 3f9233b5a130..cc4175176f94 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -3,14 +3,16 @@
  * Copyright (C) 2012,2013 - ARM Ltd
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
+/* Whole file is shared with s390 */
 
 #ifndef __ARM64_KVM_ARM_H__
 #define __ARM64_KVM_ARM_H__
 
+#include <linux/const.h>
+#include <linux/bits.h>
+#include <linux/types.h>
 #include <asm/esr.h>
-#include <asm/memory.h>
 #include <asm/sysreg.h>
-#include <asm/types.h>
 
 /*
  * Because I'm terribly lazy and that repainting the whole of the KVM
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 5bf3d7e1d92c..a1c92d2436ae 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -44,13 +44,18 @@ enum exception_type {
 bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
 void kvm_skip_instr32(struct kvm_vcpu *vcpu);
 
+#ifdef ARM64_S390_COMMON
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
+#endif /* ARM64_S390_COMMON */
 void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr);
 int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr);
+#ifdef ARM64_S390_COMMON
 int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr);
+#endif /* ARM64_S390_COMMON */
 int kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, u64 addr);
 void kvm_inject_size_fault(struct kvm_vcpu *vcpu);
 
+#ifdef ARM64_S390_COMMON
 static inline int kvm_inject_sea_dabt(struct kvm_vcpu *vcpu, u64 addr)
 {
 	return kvm_inject_sea(vcpu, false, addr);
@@ -61,6 +66,8 @@ static inline int kvm_inject_sea_iabt(struct kvm_vcpu *vcpu, u64 addr)
 	return kvm_inject_sea(vcpu, true, addr);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static inline int kvm_inject_serror(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -159,6 +166,7 @@ static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
 	*vcpu_cpsr(vcpu) |= PSR_AA32_T_BIT;
 }
 
+#ifdef ARM64_S390_COMMON
 /*
  * vcpu_get_reg and vcpu_set_reg should always be passed a register number
  * coming from a read of ESR_EL2. Otherwise, it may give the wrong result on
@@ -177,6 +185,8 @@ static __always_inline void vcpu_set_reg(struct kvm_vcpu *vcpu, u8 reg_num,
 		vcpu_gp_regs(vcpu)->regs[reg_num] = val;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static inline bool vcpu_is_el2_ctxt(const struct kvm_cpu_context *ctxt)
 {
 	switch (ctxt->regs.pstate & (PSR_MODE32_BIT | PSR_MODE_MASK)) {
@@ -360,6 +370,7 @@ static inline u64 kvm_vcpu_get_disr(const struct kvm_vcpu *vcpu)
 	return vcpu->arch.fault.disr_el1;
 }
 
+#ifdef ARM64_S390_COMMON
 static inline u32 kvm_vcpu_hvc_get_imm(const struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_xVC_IMM_MASK;
@@ -437,6 +448,8 @@ static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static inline
 bool kvm_vcpu_trap_is_permission_fault(const struct kvm_vcpu *vcpu)
 {
@@ -477,6 +490,7 @@ static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
 	return ESR_ELx_SYS64_ISS_RT(esr);
 }
 
+#ifdef ARM64_S390_COMMON
 static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
 {
 	if (kvm_vcpu_abt_iss1tw(vcpu)) {
@@ -501,6 +515,8 @@ static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_dabt_iswrite(vcpu);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
 {
 	return __vcpu_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
@@ -536,6 +552,7 @@ static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu)
 	return vcpu_read_sys_reg(vcpu, r) & bit;
 }
 
+#ifdef ARM64_S390_COMMON
 static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
 						    unsigned long data,
 						    unsigned int len)
@@ -611,6 +628,8 @@ static __always_inline void kvm_incr_pc(struct kvm_vcpu *vcpu)
 		vcpu_set_flag((v), e);					\
 	} while (0)
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * Returns a 'sanitised' view of CPTR_EL2, translating from nVHE to the VHE
  * format if E2H isn't set.
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 245bda0fb571..ae9f76378218 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -41,6 +41,7 @@
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
+#ifdef ARM64_S390_COMMON
 #define KVM_VCPU_MAX_FEATURES 9
 #define KVM_VCPU_VALID_FEATURES	(BIT(KVM_VCPU_MAX_FEATURES) - 1)
 
@@ -58,6 +59,8 @@
 #define KVM_REQ_MAP_L1_VNCR_EL2		KVM_ARCH_REQ(10)
 #define KVM_REQ_VGIC_PROCESS_UPDATE	KVM_ARCH_REQ(11)
 
+#endif /* ARM64_S390_COMMON */
+
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 				     KVM_DIRTY_LOG_INITIALLY_SET)
 
@@ -340,6 +343,7 @@ struct kvm_arch {
 	/* Protects VM-scoped configuration data */
 	struct mutex config_lock;
 
+#ifdef ARM64_S390_COMMON
 	/*
 	 * If we encounter a data abort without valid instruction syndrome
 	 * information, report this to user space.  User space can (and
@@ -369,6 +373,8 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS		10
 	/* Unhandled SEAs are taken to userspace */
 #define KVM_ARCH_FLAG_EXIT_SEA				11
+
+#endif /* ARM64_S390_COMMON */
 	unsigned long flags;
 
 	/* VM-wide vCPU feature set */
@@ -833,6 +839,8 @@ extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
 extern u64 kvm_nvhe_sym(hyp_cpu_logical_map)[NR_CPUS];
 #define hyp_cpu_logical_map CHOOSE_NVHE_SYM(hyp_cpu_logical_map)
 
+#ifdef ARM64_S390_COMMON
+
 struct vcpu_reset_state {
 	unsigned long	pc;
 	unsigned long	r0;
@@ -840,6 +848,8 @@ struct vcpu_reset_state {
 	bool		reset;
 };
 
+#endif /* ARM64_S390_COMMON */
+
 struct vncr_tlb;
 
 struct kvm_vcpu_arch {
@@ -949,6 +959,7 @@ struct kvm_vcpu_arch {
 	pid_t pid;
 };
 
+#ifdef ARM64_S390_COMMON
 /*
  * Each 'flag' is composed of a comma-separated triplet:
  *
@@ -982,6 +993,8 @@ struct kvm_vcpu_arch {
 		READ_ONCE(v->arch.flagset) & (m);		\
 	})
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * Note that the set/clear accessors must be preempt-safe in order to
  * avoid nesting them with load/put which also manipulate flags...
@@ -995,6 +1008,7 @@ struct kvm_vcpu_arch {
 #define __vcpu_flags_preempt_enable()	preempt_enable()
 #endif
 
+#ifdef ARM64_S390_COMMON
 #define __vcpu_set_flag(v, flagset, f, m)			\
 	do {							\
 		typeof(v->arch.flagset) *fset;			\
@@ -1079,6 +1093,8 @@ struct kvm_vcpu_arch {
 #define EXCEPT_AA64_EL2_FIQ	__vcpu_except_flags(6)
 #define EXCEPT_AA64_EL2_SERR	__vcpu_except_flags(7)
 
+#endif /* ARM64_S390_COMMON */
+
 /* Physical CPU not in supported_cpus */
 #define ON_UNSUPPORTED_CPU	__vcpu_single_flag(sflags, BIT(0))
 /* WFIT instruction trapped */
@@ -1236,7 +1252,10 @@ struct kvm_vcpu_stat {
 };
 
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
+#ifdef ARM64_S390_COMMON
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
+
+#endif /* ARM64_S390_COMMON */
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 
@@ -1321,6 +1340,7 @@ int __init populate_nv_trap_config(void);
 
 void kvm_calculate_traps(struct kvm_vcpu *vcpu);
 
+#ifdef ARM64_S390_COMMON
 /* MMIO helpers */
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
 unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
@@ -1328,6 +1348,8 @@ unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
 int kvm_handle_mmio_return(struct kvm_vcpu *vcpu);
 int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * Returns true if a Performance Monitoring Interrupt (PMI), a.k.a. perf event,
  * arrived in guest context.  For arm64, any event that arrives while a vCPU is
@@ -1502,8 +1524,11 @@ struct kvm *kvm_arch_alloc_vm(void);
 
 #define kvm_vm_is_protected(kvm)	(is_protected_kvm_enabled() && (kvm)->arch.pkvm.is_protected)
 
+#ifdef ARM64_S390_COMMON
 #define vcpu_is_protected(vcpu)		kvm_vm_is_protected((vcpu)->kvm)
 
+#endif /* ARM64_S390_COMMON */
+
 int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature);
 bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 
@@ -1528,8 +1553,11 @@ static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
 #define kvm_vcpu_has_feature(k, f)	__vcpu_has_feature(&(k)->arch, (f))
 #define vcpu_has_feature(v, f)	__vcpu_has_feature(&(v)->kvm->arch, (f))
 
+#ifdef ARM64_S390_COMMON
 #define kvm_vcpu_initialized(v) vcpu_get_flag(v, VCPU_INITIALIZED)
 
+#endif /* ARM64_S390_COMMON */
+
 int kvm_trng_call(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM
 extern phys_addr_t hyp_mem_base;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 6eae7e7e2a68..b782cae771fe 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -142,12 +142,15 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 
 extern u32 __hyp_va_bits;
 
+#ifdef ARM64_S390_COMMON
 /*
  * We currently support using a VM-specified IPA size. For backward
  * compatibility, the default IPA size is fixed to 40bits.
  */
 #define KVM_PHYS_SHIFT	(40)
 
+#endif /* ARM64_S390_COMMON */
+
 #define kvm_phys_shift(mmu)		VTCR_EL2_IPA((mmu)->vtcr)
 #define kvm_phys_size(mmu)		(_AC(1, ULL) << kvm_phys_shift(mmu))
 #define kvm_phys_mask(mmu)		(kvm_phys_size(mmu) - _AC(1, ULL))
@@ -178,9 +181,12 @@ void stage2_unmap_vm(struct kvm *kvm);
 int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigned long type);
 void kvm_uninit_stage2_mmu(struct kvm *kvm);
 void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu);
+#ifdef ARM64_S390_COMMON
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 			  phys_addr_t pa, unsigned long size, bool writable);
 
+#endif /* ARM64_S390_COMMON */
+
 int kvm_handle_guest_sea(struct kvm_vcpu *vcpu);
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 39582511ad72..6eb122eb5fa6 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -10,8 +10,13 @@
 
 #include <asm/cpufeature.h>
 
+#ifdef ARM64_S390_COMMON
+#include <asm/sysreg.h>
+
 #include <uapi/asm/ptrace.h>
 
+#endif /* ARM64_S390_COMMON */
+
 /* Current Exception Level values, as contained in CurrentEL */
 #define CurrentEL_EL1		(1 << 2)
 #define CurrentEL_EL2		(2 << 2)
@@ -28,6 +33,8 @@
 
 #define GIC_PRIO_PSR_I_SET	GICV3_PRIO_PSR_I_SET
 
+#ifdef ARM64_S390_COMMON
+
 /* Additional SPSR bits not exposed in the UABI */
 #define PSR_MODE_THREAD_BIT	(1 << 0)
 #define PSR_IL_BIT		(1 << 20)
@@ -68,6 +75,8 @@
 #define PSR_AA32_IT_MASK	0x0600fc00	/* If-Then execution state mask */
 #define PSR_AA32_GE_MASK	0x000f0000
 
+#endif /* ARM64_S390_COMMON */
+
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define PSR_AA32_ENDSTATE	PSR_AA32_E_BIT
 #else
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4bfdac9401bd..58912a6b6fcd 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -9,13 +9,17 @@
 #ifndef __ASM_SYSREG_H
 #define __ASM_SYSREG_H
 
+#ifdef ARM64_S390_COMMON
 #include <linux/bits.h>
+#endif /* ARM64_S390_COMMON */
 #include <linux/stringify.h>
 #include <linux/kasan-tags.h>
 #include <linux/kconfig.h>
 
 #include <asm/gpr-num.h>
 
+#ifdef ARM64_S390_COMMON
+
 /*
  * ARMv8 ARM reserves the following encoding for system registers:
  * (Ref: ARMv8 ARM, Section: "System instruction class encoding overview",
@@ -50,6 +54,8 @@
 #define sys_reg_CRm(id)	(((id) >> CRm_shift) & CRm_mask)
 #define sys_reg_Op2(id)	(((id) >> Op2_shift) & Op2_mask)
 
+#endif /* ARM64_S390_COMMON */
+
 #ifndef CONFIG_BROKEN_GAS_INST
 
 #ifdef __ASSEMBLER__
@@ -79,6 +85,8 @@
 
 #endif	/* CONFIG_BROKEN_GAS_INST */
 
+#ifdef ARM64_S390_COMMON
+
 /*
  * Instructions for modifying PSTATE fields.
  * As per Arm ARM for v8-A, Section "C.5.1.3 op0 == 0b00, architectural hints,
@@ -91,8 +99,6 @@
  */
 #define pstate_field(op1, op2)		((op1) << Op1_shift | (op2) << Op2_shift)
 #define PSTATE_Imm_shift		CRm_shift
-#define ENCODE_PSTATE(x, r)		(0xd500401f | PSTATE_ ## r | ((!!x) << PSTATE_Imm_shift))
-#define SET_PSTATE(x, r)		__emit_inst(ENCODE_PSTATE(x, r))
 
 #define PSTATE_PAN			pstate_field(0, 4)
 #define PSTATE_UAO			pstate_field(0, 3)
@@ -100,6 +106,11 @@
 #define PSTATE_DIT			pstate_field(3, 2)
 #define PSTATE_TCO			pstate_field(3, 4)
 
+#endif /* ARM64_S390_COMMON */
+
+#define ENCODE_PSTATE(x, r)		(0xd500401f | PSTATE_ ## r | ((!!x) << PSTATE_Imm_shift))
+#define SET_PSTATE(x, r)		__emit_inst(ENCODE_PSTATE(x, r))
+
 #define SET_PSTATE_PAN(x)		SET_PSTATE((x), PAN)
 #define SET_PSTATE_UAO(x)		SET_PSTATE((x), UAO)
 #define SET_PSTATE_SSBS(x)		SET_PSTATE((x), SSBS)
@@ -123,6 +134,8 @@
 #define GSB_SYS_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 0, 31)
 #define GSB_ACK_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 1, 31)
 
+#ifdef ARM64_S390_COMMON
+
 /* Data cache zero operations */
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
 #define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
@@ -835,6 +848,8 @@
 #define SCTLR_ELx_A	 (BIT(1))
 #define SCTLR_ELx_M	 (BIT(0))
 
+#endif /* ARM64_S390_COMMON */
+
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define ENDIAN_SET_EL2		SCTLR_ELx_EE
 #else
@@ -869,6 +884,8 @@
 	 SCTLR_EL1_LSMAOE | SCTLR_EL1_nTLSMD | SCTLR_EL1_EIS   | \
 	 SCTLR_EL1_TSCXT  | SCTLR_EL1_EOS)
 
+#ifdef ARM64_S390_COMMON
+
 /* MAIR_ELx memory attributes (used by Linux) */
 #define MAIR_ATTR_DEVICE_nGnRnE		UL(0x00)
 #define MAIR_ATTR_DEVICE_nGnRE		UL(0x04)
@@ -1105,6 +1122,8 @@
 #define GICV5_GICR_CDNMIA_TYPE_MASK	GENMASK_ULL(31, 29)
 #define GICV5_GICR_CDNMIA_ID_MASK	GENMASK_ULL(23, 0)
 
+#endif /* ARM64_S390_COMMON */
+
 #define gicr_insn(insn)			read_sysreg_s(GICV5_OP_GICR_##insn)
 #define gic_insn(v, insn)		write_sysreg_s(v, GICV5_OP_GIC_##insn)
 
@@ -1254,6 +1273,8 @@
 	par;								\
 })
 
+#ifdef ARM64_S390_COMMON
+
 #define SYS_FIELD_VALUE(reg, field, val)	reg##_##field##_##val
 
 #define SYS_FIELD_GET(reg, field, val)		\
@@ -1266,6 +1287,8 @@
 		 FIELD_PREP(reg##_##field##_MASK,	\
 			    SYS_FIELD_VALUE(reg, field, val))
 
-#endif
+#endif /* ARM64_S390_COMMON */
+
+#endif /* __ASSEMBLER__ */
 
 #endif	/* __ASM_SYSREG_H */
-- 
2.53.0

