Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71E429CD7;
	Fri, 31 Jul 2026 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503379; cv=none; b=GOBF33bOtgz2dqMR9ZnexjqyUY6yNm/QZJlA+KStK9ivznqv7qjnkfVaX20txMmEpJaLG7t8J8Um2lxrhL2i4IRobPVGbI7RqHppwITALiGOvXEazvh8cj8G9NaYKL6+9Gxs//DNi7OnzZeWZLy9zEBH5QJA5TVRp6bqk12nZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503379; c=relaxed/simple;
	bh=aeo2wApd+x8gpgXJYqHavG5qdPfAkooWU7ZK+sY/xv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSvFIJ6Bc2Q4WfVzhQhIADBwkuQUoDijZf53j1DjMsPaGJDX9iIuV64OJvuJRVHf5doW6mbLOcU0Z5u4bFh8ikoIlTUrSxnblJflefCEKlh9t1OPez8c9ObGQuqW2lS1P4fKB60MQanVrtlUIM3Z/p/ygDyCwxGURYBjuGwF+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CRc3lcUZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CRc3lcUZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBm1Xq4073015;
	Fri, 31 Jul 2026 13:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jkfOij6lz6C1BXqgF
	fxHnThsvpcJBEfqQj9SCtiulu8=; b=CRc3lcUZZHFEr3ii2TOnWZHtWZ2Hwu7oz
	mJfayQUcFQgAzTrJScvlrfqGy/BUSwXgV1BlU64d8QFULE9kk4VFawRKQ9HuADe1
	HFMcnBEIe4hfNdw3QxqQNmW+TUz+MYt5mOg+oT+mAsg+zFou6ejfNPrY1/MHsB15
	HN5GjqOxAqVRfs44bk0tGLhcpHJ42NgG2cH0FqPq/Wl0tBTMvfn4/WWKbf9YvgPf
	oC76RZLB9qBWZKTwBCj2Opyh13AOGbtmcnFp7a2uzjr6CUxsnLbgW6ELy5szF+r0
	5UHwY4Myd2SHv4n4+W9/MkLdEcHVFoJugxEWDyN3ByuV6ckG51KIg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw2n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuMcs012670;
	Fri, 31 Jul 2026 13:09:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkg07x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD96gx42926470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F56520040;
	Fri, 31 Jul 2026 13:09:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF46D2004B;
	Fri, 31 Jul 2026 13:09:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:05 +0000 (GMT)
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
Subject: [PATCH v5 07/31] KVM: arm64: Access elements of vcpu_gp_regs individually
Date: Fri, 31 Jul 2026 15:08:35 +0200
Message-ID: <20260731130902.654679-8-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Y0IFm64B4MSYgLgMgy5REkWBQIx2a0W-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX1AP9b492oSU9
 pJtPxrj4koGhYaHQ00Qwn2YYfVBfopAI0E5BQoHxuGlYpwsTLFDtPivTiYcAnzWuXNCackjlifT
 llYMhlPY3Tm2Kp492VQcIL4xdH7wIxHgyXEt8sAxdFpLflvCZmZhDsTDLiTcIC/OhyOoN3uYW4j
 cszg6Sc/z872KNvkD3MXE6rkWawybI3f81JbA0hoFnnSyUt5flJMekL3kPA+8nK703uM55HIGTw
 ACWF6GX+LCwdXTT2797uB1kzEx6j0uZ/fKb33vzDCg16ElK/J+7vthUQs/WOLiHQnBbEenwNZGQ
 6/c3ghF+JC/ISlPs9vqladHida+MvHpf6QrKTZB/VAd6031JA4NwKqNAkUFzZJoTxhKxLZ4Gtzz
 S4wtFoH4WMPseVIhLb3yAUn58lQMk+L2K/w9fqTcMWSvHACVdgGooh3FidGz7PVroa30vW9D5Sc
 VCnfLQCPZmr+pTDTU5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXxUXi41x3Pec3
 7ipdz3j0xnlRGHStnATg1SMtQGX4H2cVneK1vGCDHD6fNmqK8+AxqgtmJwBBLxhR8+MX3KcRqBE
 sq0AlYLY6goBmLUcPuxk3ZoEBTWPtOs=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9e7b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=u9TCuROiSGUiZ2HIOOsA:9
X-Proofpoint-GUID: T2PHQVFGXqHBcEOgizWcBx3pKTc0kniu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

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
 arch/arm64/include/asm/kvm_emulate.h       | 8 ++++----
 arch/arm64/include/asm/kvm_host.h          | 2 +-
 arch/arm64/kvm/hyp/exception.c             | 4 ++--
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h | 4 ++--
 arch/arm64/kvm/hyp/include/hyp/switch.h    | 4 ++--
 arch/arm64/kvm/reset.c                     | 6 ++++--
 6 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 5bf3d7e1d92c..c5b30d334e79 100644
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
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index bae2c4f92ef5..1094a5997fc2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1152,7 +1152,7 @@ struct kvm_vcpu_arch {
 #define vcpu_clear_on_unsupported_cpu(vcpu)				\
 	vcpu_clear_flag(vcpu, ON_UNSUPPORTED_CPU)
 
-#define vcpu_gp_regs(v)		(&(v)->arch.ctxt.regs)
+#define vcpu_gp_regs(v)		((v)->arch.ctxt.regs.regs)
 
 /*
  * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index bef40ddb16db..9e63c4aebb29 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -292,12 +292,12 @@ static void enter_exception32(struct kvm_vcpu *vcpu, u32 mode, u32 vect_offset)
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
index 4bf624a49591..fc1fdc99d82c 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -451,7 +451,7 @@ static inline bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
 	u64 spsr;
 
 	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
-	arm64_mops_reset_regs(vcpu_gp_regs(vcpu), vcpu->arch.fault.esr_el2);
+	arm64_mops_reset_regs(&vcpu->arch.ctxt.regs, vcpu->arch.fault.esr_el2);
 	write_sysreg_el2(*vcpu_pc(vcpu), SYS_ELR);
 
 	/*
@@ -896,7 +896,7 @@ static inline void synchronize_vcpu_pstate(struct kvm_vcpu *vcpu)
 	/*
 	 * Check for the conditions of Cortex-A510's #2077057. When these occur
 	 * SPSR_EL2 can't be trusted, but isn't needed either as it is
-	 * unchanged from the value in vcpu_gp_regs(vcpu)->pstate.
+	 * unchanged from the value in vcpu_cpsr(vcpu).
 	 * Are we single-stepping the guest, and took a PAC exception from the
 	 * active-not-pending state?
 	 */
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index b963fd975aac..be829fa6f130 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -218,13 +218,15 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
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
 
 	/* Reset system registers */
 	kvm_reset_sys_regs(vcpu);
-- 
2.53.0

