Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5144CACA;
	Tue, 28 Apr 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392364; cv=none; b=VWoEgozrbNW8e0nf1dBrWcbMHt3LHeE5VVAdiu6V+hV5Ma3+FjsLLWZtAhGRBWF31JQNLzQTMe0QIDF12iylwP4K73KvelliocbNRvx5AFyKiXIbMaRh2jXFNlNy7hOtijiStcDv075ZECUypnliFb5mVi/obisC5XgdwuD7UVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392364; c=relaxed/simple;
	bh=Lg84P6WX7WikjKSmAWOSyc4s4+OgW0xFlJXZrRJro9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVdkoULexGL+JmfiJ/O/k+OeM0cNQWnkm1GE6d7oGz/M7vGNwlRkTjbsfiz+TXHPu1QPSjHoLokgnCQfaaBMVq+v7JmMBag3kzldKVihyAlvzE4H4HCniGIOKb3BB5lTc7m44J+trqnW+I2Xxv4CUnmnTmnBhQGy8JhGkJPSm0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lCWuA1DJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lCWuA1DJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S8J12g3499801;
	Tue, 28 Apr 2026 16:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bKdCZerzHV/o2sihq
	acITT6K5c6M8fOM4XNG7XWjN1g=; b=lCWuA1DJSIIUrISWI5Hup1NoTmHslGHH0
	ljj8XIBBN+BPhpOS4pPyZmgO4bLas0TcAmB95DnxFox7QrKV1ZFf4CzfnYhgfMml
	5xH+wsNtgK4CIJTm4hPW0bayIEmElZxTFt0sbSKSxJ9QP60gRPuhY/F+a4yEN/eW
	QE/9TyCMG0HzBS6osOaba84fFmm8qjPXyNcLic2DMm5ZqXvXOuBone+hQ2x8lVO3
	UmdwLL2sZIf7YRP2cOVl66bI2N3fdeU67oU0XzBX8hwfO9ugxkCcMmJMLcCh2j8l
	jY61DXg7LImGjs3J8oZO2YBMzYoCdEfFJGJBM5NZnabm2v0ZfTbJA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44pgq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrq7h015577;
	Tue, 28 Apr 2026 16:05:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avthcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SG5Vjg31588766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 16:05:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 146CC20040;
	Tue, 28 Apr 2026 16:05:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE8942004B;
	Tue, 28 Apr 2026 16:05:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 16:05:30 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
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
Subject: [RFC PATCH v2 09/28] KVM: arm64: Share kvm_emulate definitions
Date: Tue, 28 Apr 2026 18:05:06 +0200
Message-ID: <20260428160527.1378085-10-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428160527.1378085-1-seiden@linux.ibm.com>
References: <20260428160527.1378085-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PUX0MOpLOStnC33HNspU5RFXAUkWPejG
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0dad0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HWX1mkjk11RNJ6LnsRgA:9
X-Proofpoint-GUID: PUX0MOpLOStnC33HNspU5RFXAUkWPejG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX0GJTzmRqsexR
 aOHKPHe8kQ+E+Xh7l7fWB4FZ8eKvr07AxIt2ipFgXlTzCjSpaJh0d3mr7sfzLevEf/00n8qvSV+
 BCkEMz7tiTVJWrWF/9E+81l9yYwvUgTuPuf6iM1Qshd3AxTrHF7uSUTyo6BdbR8UhSycjiHOGRM
 1Xahnclb1Drbg7ixZDG6jziQrJk7fmVaqSUB6YU2hKF8YEQ4p286WNup71bUMvTEbWZqyW2w37G
 Hfn2ypidUPH2YpwcrwIZPaykN09uFQ/di2opmLdAz9MZMN3DuZU3Y0CU2zVcFugiMItHNv8zJIW
 AdAhdQBLsCU02xUSYO/72UnGmAYo9Ea5OsCFW2gPW1DNjt2hNGkKwKT7mVrqy6BhXfG6kzhWNEH
 5M05koa9Utw7fTdgLC8FUmWoHDpGG5fPxo3DDKP/AMPgyCtEu+KMxeu+utot8UXDyj6x6SdWQGK
 //dgmUjV/hp4LGNHbzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

Move functions and definitions useful for emulating arm64 instructions
to include/kvm/arm64.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_emulate.h       | 235 +-----------------
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h |  13 -
 include/kvm/arm64/kvm_emulate.h            | 268 +++++++++++++++++++++
 3 files changed, 269 insertions(+), 247 deletions(-)
 create mode 100644 include/kvm/arm64/kvm_emulate.h

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 822f6077b107..39fa3a12730c 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -23,18 +23,7 @@
 #include <asm/virt.h>
 
 #include <kvm/arm64/kvm_arm.h>
-
-#define CURRENT_EL_SP_EL0_VECTOR	0x0
-#define CURRENT_EL_SP_ELx_VECTOR	0x200
-#define LOWER_EL_AArch64_VECTOR		0x400
-#define LOWER_EL_AArch32_VECTOR		0x600
-
-enum exception_type {
-	except_type_sync	= 0,
-	except_type_irq		= 0x80,
-	except_type_fiq		= 0x100,
-	except_type_serror	= 0x180,
-};
+#include <kvm/arm64/kvm_emulate.h>
 
 #define kvm_exception_type_names		\
 	{ except_type_sync,	"SYNC"   },	\
@@ -45,36 +34,8 @@ enum exception_type {
 bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
 void kvm_skip_instr32(struct kvm_vcpu *vcpu);
 
-void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr);
-int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr);
-int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr);
 int kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, u64 addr);
-void kvm_inject_size_fault(struct kvm_vcpu *vcpu);
-
-static inline int kvm_inject_sea_dabt(struct kvm_vcpu *vcpu, u64 addr)
-{
-	return kvm_inject_sea(vcpu, false, addr);
-}
-
-static inline int kvm_inject_sea_iabt(struct kvm_vcpu *vcpu, u64 addr)
-{
-	return kvm_inject_sea(vcpu, true, addr);
-}
-
-static inline int kvm_inject_serror(struct kvm_vcpu *vcpu)
-{
-	/*
-	 * ESR_ELx.ISV (later renamed to IDS) indicates whether or not
-	 * ESR_ELx.ISS contains IMPLEMENTATION DEFINED syndrome information.
-	 *
-	 * Set the bit when injecting an SError w/o an ESR to indicate ISS
-	 * does not follow the architected format.
-	 */
-	return kvm_inject_serror_esr(vcpu, ESR_ELx_ISV);
-}
-
-void kvm_vcpu_wfi(struct kvm_vcpu *vcpu);
 
 void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu);
 int kvm_inject_nested_sync(struct kvm_vcpu *vcpu, u64 esr_el2);
@@ -160,24 +121,6 @@ static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
 	*vcpu_cpsr(vcpu) |= PSR_AA32_T_BIT;
 }
 
-/*
- * vcpu_get_reg and vcpu_set_reg should always be passed a register number
- * coming from a read of ESR_EL2. Otherwise, it may give the wrong result on
- * AArch32 with banked registers.
- */
-static __always_inline unsigned long vcpu_get_reg(const struct kvm_vcpu *vcpu,
-					 u8 reg_num)
-{
-	return (reg_num == 31) ? 0 : vcpu_gp_regs(vcpu)->regs[reg_num];
-}
-
-static __always_inline void vcpu_set_reg(struct kvm_vcpu *vcpu, u8 reg_num,
-				unsigned long val)
-{
-	if (reg_num != 31)
-		vcpu_gp_regs(vcpu)->regs[reg_num] = val;
-}
-
 static inline bool vcpu_is_el2_ctxt(const struct kvm_cpu_context *ctxt)
 {
 	switch (ctxt->regs.pstate & (PSR_MODE32_BIT | PSR_MODE_MASK)) {
@@ -361,82 +304,11 @@ static inline u64 kvm_vcpu_get_disr(const struct kvm_vcpu *vcpu)
 	return vcpu->arch.fault.disr_el1;
 }
 
-static inline u32 kvm_vcpu_hvc_get_imm(const struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_xVC_IMM_MASK;
-}
-
-static __always_inline bool kvm_vcpu_dabt_isvalid(const struct kvm_vcpu *vcpu)
-{
-	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_ISV);
-}
-
 static inline unsigned long kvm_vcpu_dabt_iss_nisv_sanitized(const struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_get_esr(vcpu) & (ESR_ELx_CM | ESR_ELx_WNR | ESR_ELx_FSC);
 }
 
-static inline bool kvm_vcpu_dabt_issext(const struct kvm_vcpu *vcpu)
-{
-	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_SSE);
-}
-
-static inline bool kvm_vcpu_dabt_issf(const struct kvm_vcpu *vcpu)
-{
-	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_SF);
-}
-
-static __always_inline int kvm_vcpu_dabt_get_rd(const struct kvm_vcpu *vcpu)
-{
-	return (kvm_vcpu_get_esr(vcpu) & ESR_ELx_SRT_MASK) >> ESR_ELx_SRT_SHIFT;
-}
-
-static __always_inline bool kvm_vcpu_abt_iss1tw(const struct kvm_vcpu *vcpu)
-{
-	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_S1PTW);
-}
-
-/* Always check for S1PTW *before* using this. */
-static __always_inline bool kvm_vcpu_dabt_iswrite(const struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_WNR;
-}
-
-static inline bool kvm_vcpu_dabt_is_cm(const struct kvm_vcpu *vcpu)
-{
-	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_CM);
-}
-
-static __always_inline unsigned int kvm_vcpu_dabt_get_as(const struct kvm_vcpu *vcpu)
-{
-	return 1 << ((kvm_vcpu_get_esr(vcpu) & ESR_ELx_SAS) >> ESR_ELx_SAS_SHIFT);
-}
-
-/* This one is not specific to Data Abort */
-static __always_inline bool kvm_vcpu_trap_il_is32bit(const struct kvm_vcpu *vcpu)
-{
-	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_IL);
-}
-
-static __always_inline u8 kvm_vcpu_trap_get_class(const struct kvm_vcpu *vcpu)
-{
-	return ESR_ELx_EC(kvm_vcpu_get_esr(vcpu));
-}
-
-static inline bool kvm_vcpu_trap_is_iabt(const struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_IABT_LOW;
-}
-
-static inline bool kvm_vcpu_trap_is_exec_fault(const struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_trap_is_iabt(vcpu) && !kvm_vcpu_abt_iss1tw(vcpu);
-}
-
-static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
-{
-	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC;
-}
 
 static inline
 bool kvm_vcpu_trap_is_permission_fault(const struct kvm_vcpu *vcpu)
@@ -472,36 +344,6 @@ static __always_inline bool kvm_vcpu_abt_issea(const struct kvm_vcpu *vcpu)
 	}
 }
 
-static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
-{
-	u64 esr = kvm_vcpu_get_esr(vcpu);
-	return ESR_ELx_SYS64_ISS_RT(esr);
-}
-
-static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
-{
-	if (kvm_vcpu_abt_iss1tw(vcpu)) {
-		/*
-		 * Only a permission fault on a S1PTW should be
-		 * considered as a write. Otherwise, page tables baked
-		 * in a read-only memslot will result in an exception
-		 * being delivered in the guest.
-		 *
-		 * The drawback is that we end-up faulting twice if the
-		 * guest is using any of HW AF/DB: a translation fault
-		 * to map the page containing the PT (read only at
-		 * first), then a permission fault to allow the flags
-		 * to be set.
-		 */
-		return kvm_vcpu_trap_is_permission_fault(vcpu);
-	}
-
-	if (kvm_vcpu_trap_is_iabt(vcpu))
-		return false;
-
-	return kvm_vcpu_dabt_iswrite(vcpu);
-}
-
 static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
 {
 	return __vcpu_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
@@ -537,81 +379,6 @@ static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu)
 	return vcpu_read_sys_reg(vcpu, r) & bit;
 }
 
-static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
-						    unsigned long data,
-						    unsigned int len)
-{
-	if (kvm_vcpu_is_be(vcpu)) {
-		switch (len) {
-		case 1:
-			return data & 0xff;
-		case 2:
-			return be16_to_cpu(data & 0xffff);
-		case 4:
-			return be32_to_cpu(data & 0xffffffff);
-		default:
-			return be64_to_cpu(data);
-		}
-	} else {
-		switch (len) {
-		case 1:
-			return data & 0xff;
-		case 2:
-			return le16_to_cpu(data & 0xffff);
-		case 4:
-			return le32_to_cpu(data & 0xffffffff);
-		default:
-			return le64_to_cpu(data);
-		}
-	}
-
-	return data;		/* Leave LE untouched */
-}
-
-static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
-						    unsigned long data,
-						    unsigned int len)
-{
-	if (kvm_vcpu_is_be(vcpu)) {
-		switch (len) {
-		case 1:
-			return data & 0xff;
-		case 2:
-			return cpu_to_be16(data & 0xffff);
-		case 4:
-			return cpu_to_be32(data & 0xffffffff);
-		default:
-			return cpu_to_be64(data);
-		}
-	} else {
-		switch (len) {
-		case 1:
-			return data & 0xff;
-		case 2:
-			return cpu_to_le16(data & 0xffff);
-		case 4:
-			return cpu_to_le32(data & 0xffffffff);
-		default:
-			return cpu_to_le64(data);
-		}
-	}
-
-	return data;		/* Leave LE untouched */
-}
-
-static __always_inline void kvm_incr_pc(struct kvm_vcpu *vcpu)
-{
-	WARN_ON(vcpu_get_flag(vcpu, PENDING_EXCEPTION));
-	vcpu_set_flag(vcpu, INCREMENT_PC);
-}
-
-#define kvm_pend_exception(v, e)					\
-	do {								\
-		WARN_ON(vcpu_get_flag((v), INCREMENT_PC));		\
-		vcpu_set_flag((v), PENDING_EXCEPTION);			\
-		vcpu_set_flag((v), e);					\
-	} while (0)
-
 /*
  * Returns a 'sanitised' view of CPTR_EL2, translating from nVHE to the VHE
  * format if E2H isn't set.
diff --git a/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h b/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
index 4fdfeabefeb4..15e1e5db73e1 100644
--- a/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
+++ b/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
@@ -13,19 +13,6 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_host.h>
 
-static inline void kvm_skip_instr(struct kvm_vcpu *vcpu)
-{
-	if (vcpu_mode_is_32bit(vcpu)) {
-		kvm_skip_instr32(vcpu);
-	} else {
-		*vcpu_pc(vcpu) += 4;
-		*vcpu_cpsr(vcpu) &= ~PSR_BTYPE_MASK;
-	}
-
-	/* advance the singlestep state machine */
-	*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
-}
-
 /*
  * Skip an instruction which has been emulated at hyp while most guest sysregs
  * are live.
diff --git a/include/kvm/arm64/kvm_emulate.h b/include/kvm/arm64/kvm_emulate.h
new file mode 100644
index 000000000000..25322b95af21
--- /dev/null
+++ b/include/kvm/arm64/kvm_emulate.h
@@ -0,0 +1,268 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef KVM_ARM64_KVM_EMULATE_H
+#define KVM_ARM64_KVM_EMULATE_H
+
+#include <asm/esr.h>
+#include <asm/pstate.h>
+#include <asm/sysreg-defs.h>
+
+static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu);
+static __always_inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcpu);
+static __always_inline unsigned long *vcpu_cpsr(const struct kvm_vcpu *vcpu);
+static inline bool kvm_vcpu_trap_is_permission_fault(const struct kvm_vcpu *vcpu);
+static u64 kvm_vcpu_get_esr(const struct kvm_vcpu *vcpu);
+static __always_inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu);
+
+#define CURRENT_EL_SP_EL0_VECTOR	0x0
+#define CURRENT_EL_SP_ELx_VECTOR	0x200
+#define LOWER_EL_AArch64_VECTOR		0x400
+#define LOWER_EL_AArch32_VECTOR		0x600
+
+enum exception_type {
+	except_type_sync	= 0,
+	except_type_irq		= 0x80,
+	except_type_fiq		= 0x100,
+	except_type_serror	= 0x180,
+};
+
+void kvm_skip_instr32(struct kvm_vcpu *vcpu);
+
+void kvm_inject_undefined(struct kvm_vcpu *vcpu);
+int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr);
+int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr);
+void kvm_inject_size_fault(struct kvm_vcpu *vcpu);
+
+static inline int kvm_inject_sea_dabt(struct kvm_vcpu *vcpu, u64 addr)
+{
+	return kvm_inject_sea(vcpu, false, addr);
+}
+
+static inline int kvm_inject_sea_iabt(struct kvm_vcpu *vcpu, u64 addr)
+{
+	return kvm_inject_sea(vcpu, true, addr);
+}
+
+static inline int kvm_inject_serror(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * ESR_ELx.ISV (later renamed to IDS) indicates whether or not
+	 * ESR_ELx.ISS contains IMPLEMENTATION DEFINED syndrome information.
+	 *
+	 * Set the bit when injecting an SError w/o an ESR to indicate ISS
+	 * does not follow the architected format.
+	 */
+	return kvm_inject_serror_esr(vcpu, ESR_ELx_ISV);
+}
+
+void kvm_vcpu_wfi(struct kvm_vcpu *vcpu);
+
+static inline void kvm_skip_instr(struct kvm_vcpu *vcpu)
+{
+	if (vcpu_mode_is_32bit(vcpu)) {
+		kvm_skip_instr32(vcpu);
+	} else {
+		*vcpu_pc(vcpu) += 4;
+		*vcpu_cpsr(vcpu) &= ~SPSR64_BTYPE_MASK;
+	}
+
+	/* advance the singlestep state machine */
+	*vcpu_cpsr(vcpu) &= ~SPSR_SS;
+}
+
+/*
+ * vcpu_get_reg and vcpu_set_reg should always be passed a register number
+ * coming from a read of ESR_EL2. Otherwise, it may give the wrong result on
+ * AArch32 with banked registers.
+ */
+static __always_inline unsigned long vcpu_get_reg(const struct kvm_vcpu *vcpu,
+						  u8 reg_num)
+{
+	return (reg_num == 31) ? 0 : vcpu_gp_regs(vcpu)->regs[reg_num];
+}
+
+static __always_inline void vcpu_set_reg(struct kvm_vcpu *vcpu, u8 reg_num,
+					 unsigned long val)
+{
+	if (reg_num != 31)
+		vcpu_gp_regs(vcpu)->regs[reg_num] = val;
+}
+
+static inline u32 kvm_vcpu_hvc_get_imm(const struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_xVC_IMM_MASK;
+}
+
+static __always_inline bool kvm_vcpu_dabt_isvalid(const struct kvm_vcpu *vcpu)
+{
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_ISV);
+}
+
+static inline bool kvm_vcpu_dabt_issext(const struct kvm_vcpu *vcpu)
+{
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_SSE);
+}
+
+static inline bool kvm_vcpu_dabt_issf(const struct kvm_vcpu *vcpu)
+{
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_SF);
+}
+
+static __always_inline int kvm_vcpu_dabt_get_rd(const struct kvm_vcpu *vcpu)
+{
+	return (kvm_vcpu_get_esr(vcpu) & ESR_ELx_SRT_MASK) >> ESR_ELx_SRT_SHIFT;
+}
+
+static __always_inline bool kvm_vcpu_abt_iss1tw(const struct kvm_vcpu *vcpu)
+{
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_S1PTW);
+}
+
+/* Always check for S1PTW *before* using this. */
+static __always_inline bool kvm_vcpu_dabt_iswrite(const struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_WNR;
+}
+
+static inline bool kvm_vcpu_dabt_is_cm(const struct kvm_vcpu *vcpu)
+{
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_CM);
+}
+
+static __always_inline unsigned int kvm_vcpu_dabt_get_as(const struct kvm_vcpu *vcpu)
+{
+	return 1 << ((kvm_vcpu_get_esr(vcpu) & ESR_ELx_SAS) >> ESR_ELx_SAS_SHIFT);
+}
+
+/* This one is not specific to Data Abort */
+static __always_inline bool kvm_vcpu_trap_il_is32bit(const struct kvm_vcpu *vcpu)
+{
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_IL);
+}
+
+static __always_inline u8 kvm_vcpu_trap_get_class(const struct kvm_vcpu *vcpu)
+{
+	return ESR_ELx_EC(kvm_vcpu_get_esr(vcpu));
+}
+
+static inline bool kvm_vcpu_trap_is_iabt(const struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_IABT_LOW;
+}
+
+static inline bool kvm_vcpu_trap_is_exec_fault(const struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_trap_is_iabt(vcpu) && !kvm_vcpu_abt_iss1tw(vcpu);
+}
+
+static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
+{
+	u64 esr = kvm_vcpu_get_esr(vcpu);
+
+	return ESR_ELx_SYS64_ISS_RT(esr);
+}
+
+static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC;
+}
+
+static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vcpu_abt_iss1tw(vcpu)) {
+		/*
+		 * Only a permission fault on a S1PTW should be
+		 * considered as a write. Otherwise, page tables baked
+		 * in a read-only memslot will result in an exception
+		 * being delivered in the guest.
+		 *
+		 * The drawback is that we end-up faulting twice if the
+		 * guest is using any of HW AF/DB: a translation fault
+		 * to map the page containing the PT (read only at
+		 * first), then a permission fault to allow the flags
+		 * to be set.
+		 */
+		return kvm_vcpu_trap_is_permission_fault(vcpu);
+	}
+
+	if (kvm_vcpu_trap_is_iabt(vcpu))
+		return false;
+
+	return kvm_vcpu_dabt_iswrite(vcpu);
+}
+
+static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
+						    unsigned long data,
+						    unsigned int len)
+{
+	if (kvm_vcpu_is_be(vcpu)) {
+		switch (len) {
+		case 1:
+			return data & 0xff;
+		case 2:
+			return be16_to_cpu(data & 0xffff);
+		case 4:
+			return be32_to_cpu(data & 0xffffffff);
+		default:
+			return be64_to_cpu(data);
+		}
+	} else {
+		switch (len) {
+		case 1:
+			return data & 0xff;
+		case 2:
+			return le16_to_cpu(data & 0xffff);
+		case 4:
+			return le32_to_cpu(data & 0xffffffff);
+		default:
+			return le64_to_cpu(data);
+		}
+	}
+
+	return data;		/* Leave LE untouched */
+}
+
+static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
+						    unsigned long data,
+						    unsigned int len)
+{
+	if (kvm_vcpu_is_be(vcpu)) {
+		switch (len) {
+		case 1:
+			return data & 0xff;
+		case 2:
+			return cpu_to_be16(data & 0xffff);
+		case 4:
+			return cpu_to_be32(data & 0xffffffff);
+		default:
+			return cpu_to_be64(data);
+		}
+	} else {
+		switch (len) {
+		case 1:
+			return data & 0xff;
+		case 2:
+			return cpu_to_le16(data & 0xffff);
+		case 4:
+			return cpu_to_le32(data & 0xffffffff);
+		default:
+			return cpu_to_le64(data);
+		}
+	}
+
+	return data;		/* Leave LE untouched */
+}
+
+static __always_inline void kvm_incr_pc(struct kvm_vcpu *vcpu)
+{
+	WARN_ON(vcpu_get_flag(vcpu, PENDING_EXCEPTION));
+	vcpu_set_flag(vcpu, INCREMENT_PC);
+}
+
+#define kvm_pend_exception(v, e)					\
+	do {								\
+		WARN_ON(vcpu_get_flag((v), INCREMENT_PC));		\
+		vcpu_set_flag((v), PENDING_EXCEPTION);			\
+		vcpu_set_flag((v), e);					\
+	} while (0)
+
+#endif /* KVM_ARM64_KVM_EMULATE_H */
-- 
2.51.0

