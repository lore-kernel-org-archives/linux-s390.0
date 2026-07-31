Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5B42C4E7;
	Fri, 31 Jul 2026 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503381; cv=none; b=HYWbq3uuWT3crqB7fOK6THd4cwNirVkTrrpl7m+8OLEZth+ixuE1hqdYyXoz+1CjPxIzZMPOwUBrw/YZ1mU071qcdxG6w6nz0Rs7t/Wr1ZRZFs3F+OQQlzgIwQhaiHTpHgVqgiZGHC21i84YioyKS3HWdN6sVMJjE4lSp3J1dMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503381; c=relaxed/simple;
	bh=1W/chHOqQVadHOqUZeI7qs6czBNrT6DbZxvqcU+qpf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDQWai5pPwte7jfcNf+gCcnNjNNegmOh3/MfymMJgEI81ozVp2k8WKjW/B8Phv5fZdUQGiYbRZcnhPhXvsNIq7e06ola1ApRAoRacUhT8dRIYW2Hq65Ne+n0K4ATOXv5fkYzMzL5I8xqFQXuD6kSL2dOeXOVQbdfGpJZp8/0JWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HzloxzMR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HzloxzMR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlisB1670385;
	Fri, 31 Jul 2026 13:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CRKafAl1YCGglDpLB
	BWC3R12VQMpxpT46hTg5kd0Yaw=; b=HzloxzMRlg50TxI4f1wPDrfJeAeNA6iRo
	hmOPwwcSnAmnPypXUJZWQRk/0lZFyuJe2hilFHA76PcBM+ORD4lB6jCbLhpGPGhT
	KKKc19AEQWXUwZdhGguHXekSw3QTaxoLRglWozXIb/Wd4K6CpJscDLAiKZWOMt75
	3jopQHS9lxak42udAln+pXhBEaqFlk9wK4AzF3gQSOjgn2SKEc1oXWUDxsmt7MlV
	e9g9vAY0eblrIhD2xplBqU5yq8lAivpORABNSrYWgWcouSqFlJ00QVtWMMki531S
	nQ0LHKidEXohd5sSS+MM5AoQzs9F9d7R2eeRe4vltrgozgETQGZ6w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjm3vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuQ20021776;
	Fri, 31 Jul 2026 13:09:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwg43f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD98Pd14483870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C73820040;
	Fri, 31 Jul 2026 13:09:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97F9A20043;
	Fri, 31 Jul 2026 13:09:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:07 +0000 (GMT)
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
Subject: [PATCH v5 11/31] arm64: Share arm64 headers with s390
Date: Fri, 31 Jul 2026 15:08:39 +0200
Message-ID: <20260731130902.654679-12-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX7dow1tM7qOqw
 GEThlMmbxHxT8Ti1PeHjMrGbqVTjJkpb0tnFSlhaYSPy1X/YZaE/7E26quFgFIDunzatbKLaAS9
 dHYIGOuF5c1v6qbA61LDZn6zO6lIJ+o=
X-Proofpoint-GUID: uJSoaiyv9d_bp1DO16XGqZJaG87ztMP5
X-Proofpoint-ORIG-GUID: XgXIOgRBgtsEEVArMM-0wUP3l1DCv6iI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXyQjSyuHBt/mX
 8Roi1wkI/G+AxNM45Zzk544EJm13b6LtjnxR7MzNuPZYer2PRHxUeI9a4WYbvGgi1foBg2Vw1Ei
 n3mqqfgubNSSxTeGkQiscu46HXdQyuNRZiamupjqboPR/N8rCbBz0ngGGTjDjj649/GQxgsmemd
 XRWUBQLyNuSnqTezaVGDc7Er8HLQXJaxcF/v5uv5NG0Keef4gjS2O1m1qITZg+G+3045PEJrJA1
 h6ZB8NPChkYKNJW5nK+BNQ8N8+d2NuhHtuJn5tAayWh1bdA/tKcyrHgyO/hxA5OuanityFhPvbR
 uiHE3ncsgJ5IIWQo3zaCYMgntZFYAdaJW5PIqdVxYfH5iliUHBNJXBdNIyhBB1bdPPFksIUTJI1
 rSHTzJWfIpLPwROu4KJ4/jwcPLGiBlefq0OYRyaCd3PAKjUQqbaXuupincvIzhJ4QPB5ISVyKTQ
 wCGBb1m58iN/uR5DfyA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6c9e7b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8
 a=6P2ef70na_-CBmQj_eQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310096

Allow sharing of arm64 headers with s390 by marking the shared regions
or add a comment that the whole file is shared.

The shared regions are marked with:

 #define ARM64_S390_COMMON

 /* insert shared definitions here */

 #endif /* ARM64_S390_COMMON */

The preprocessor symbol ARM64_S390_COMMON is always defined for arm64.
No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/Makefile                  |  2 ++
 arch/arm64/include/asm/brk-imm.h     |  1 +
 arch/arm64/include/asm/esr.h         |  1 +
 arch/arm64/include/asm/kvm_arm.h     |  1 +
 arch/arm64/include/asm/kvm_emulate.h | 15 +++++++++++++++
 arch/arm64/include/asm/kvm_host.h    | 20 ++++++++++++++++++++
 arch/arm64/include/asm/ptrace.h      |  4 ++++
 arch/arm64/include/asm/sysreg.h      | 15 +++++++++++++++
 8 files changed, 59 insertions(+)

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
index a99d8de99961..cc4175176f94 100644
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
index 45b3f98f0c7e..2dac665ccfd1 100644
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
@@ -165,6 +168,7 @@ static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
 	*vcpu_cpsr(vcpu) |= PSR_AA32_T_BIT;
 }
 
+#ifdef ARM64_S390_COMMON
 /*
  * vcpu_get_reg and vcpu_set_reg should always be passed a register number
  * coming from a read of ESR_EL2. Otherwise, it may give the wrong result on
@@ -183,6 +187,8 @@ static __always_inline void vcpu_set_reg(struct kvm_vcpu *vcpu, u8 reg_num,
 		vcpu_gp_regs(vcpu)[reg_num] = val;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static inline bool vcpu_is_el2_ctxt(const struct kvm_cpu_context *ctxt)
 {
 	switch (ctxt->regs.pstate & (PSR_MODE32_BIT | PSR_MODE_MASK)) {
@@ -366,6 +372,7 @@ static inline u64 kvm_vcpu_get_disr(const struct kvm_vcpu *vcpu)
 	return vcpu->arch.fault.disr_el1;
 }
 
+#ifdef ARM64_S390_COMMON
 static inline u32 kvm_vcpu_hvc_get_imm(const struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_xVC_IMM_MASK;
@@ -443,6 +450,8 @@ static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC;
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static inline
 bool kvm_vcpu_trap_is_permission_fault(const struct kvm_vcpu *vcpu)
 {
@@ -483,6 +492,7 @@ static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
 	return ESR_ELx_SYS64_ISS_RT(esr);
 }
 
+#ifdef ARM64_S390_COMMON
 static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
 {
 	if (kvm_vcpu_abt_iss1tw(vcpu)) {
@@ -507,6 +517,8 @@ static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_dabt_iswrite(vcpu);
 }
 
+#endif /* ARM64_S390_COMMON */
+
 static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
 {
 	return __vcpu_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
@@ -542,6 +554,7 @@ static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu)
 	return vcpu_read_sys_reg(vcpu, r) & bit;
 }
 
+#ifdef ARM64_S390_COMMON
 static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
 						    unsigned long data,
 						    unsigned int len)
@@ -617,6 +630,8 @@ static __always_inline void kvm_incr_pc(struct kvm_vcpu *vcpu)
 		vcpu_set_flag((v), e);					\
 	} while (0)
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * Returns a 'sanitised' view of CPTR_EL2, translating from nVHE to the VHE
  * format if E2H isn't set.
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 875fc7c3366b..83fefceed952 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -39,6 +39,7 @@
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
+#ifdef ARM64_S390_COMMON
 #define KVM_VCPU_MAX_FEATURES 9
 #define KVM_VCPU_VALID_FEATURES	(BIT(KVM_VCPU_MAX_FEATURES) - 1)
 
@@ -86,6 +87,8 @@
 /* Unhandled SEAs are taken to userspace */
 #define KVM_ARCH_FLAG_EXIT_SEA				11
 
+#endif /* ARM64_S390_COMMON */
+
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 				     KVM_DIRTY_LOG_INITIALLY_SET)
 
@@ -832,6 +835,8 @@ extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
 extern u64 kvm_nvhe_sym(hyp_cpu_logical_map)[NR_CPUS];
 #define hyp_cpu_logical_map CHOOSE_NVHE_SYM(hyp_cpu_logical_map)
 
+#ifdef ARM64_S390_COMMON
+
 struct vcpu_reset_state {
 	unsigned long	pc;
 	unsigned long	r0;
@@ -839,6 +844,8 @@ struct vcpu_reset_state {
 	bool		reset;
 };
 
+#endif /* ARM64_S390_COMMON */
+
 struct vncr_tlb;
 
 struct kvm_vcpu_arch {
@@ -948,6 +955,7 @@ struct kvm_vcpu_arch {
 	pid_t pid;
 };
 
+#ifdef ARM64_S390_COMMON
 /*
  * Each 'flag' is composed of a comma-separated triplet:
  *
@@ -1099,6 +1107,8 @@ struct kvm_vcpu_arch {
 /* KVM is currently emulating an L2 to L1 exception */
 #define IN_NESTED_EXCEPTION	__vcpu_single_flag(sflags, BIT(9))
 
+#endif /* ARM64_S390_COMMON */
+
 #define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)
 
 #define vcpu_sve_zcr_elx(vcpu)						\
@@ -1240,6 +1250,7 @@ struct kvm_vcpu_stat {
 	u64 exits;
 };
 
+#ifdef ARM64_S390_COMMON
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
@@ -1248,6 +1259,8 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
 
+#endif /* ARM64_S390_COMMON */
+
 int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 			      struct kvm_vcpu_events *events);
 
@@ -1326,6 +1339,7 @@ int __init populate_nv_trap_config(void);
 
 void kvm_calculate_traps(struct kvm_vcpu *vcpu);
 
+#ifdef ARM64_S390_COMMON
 /* MMIO helpers */
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
 unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
@@ -1333,6 +1347,8 @@ unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
 int kvm_handle_mmio_return(struct kvm_vcpu *vcpu);
 int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * Returns true if a Performance Monitoring Interrupt (PMI), a.k.a. perf event,
  * arrived in guest context.  For arm64, any event that arrives while a vCPU is
@@ -1530,11 +1546,15 @@ static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
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
index 6f5b79ee1f3f..bb16a9894a5a 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -28,6 +28,8 @@
 
 #define GIC_PRIO_PSR_I_SET	GICV3_PRIO_PSR_I_SET
 
+#ifdef ARM64_S390_COMMON
+
 /* Additional SPSR bits not exposed in the UABI */
 #define PSR_MODE_THREAD_BIT	(1 << 0)
 #define PSR_IL_BIT		(1 << 20)
@@ -68,6 +70,8 @@
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

