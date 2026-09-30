Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6F53163E;
	Wed, 30 Sep 2026 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789723; cv=none; b=Q94nmgODKkqZ0z4LlQ9A0CEdLtJ/jemDSXot2DnCXAt70Z24Na/b9fV/wxJgVc8t6Qx1ZDnSjP3PYCaYMaLTqsQd5bscMaDXm4hc1EwfLnAuM+AsKoQC8f2Es/QdaRyhxW7vAs9ZZ8XYNEdbmTm3mGNPuxU8ScDea6V/998xUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789723; c=relaxed/simple;
	bh=GDtzCh933ADdlCXrQ31//P8i7MDqG3qKDGzDWcE0ql8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfGRvkI6Ah/kHPN+7bbOhEi6quXfV0NoECKJkeMHfCYeuCrQmdyE5yZQ+4n2V4YYN97R75ivSZi6aJ5ur13a8bs1NHE28syXENEfN1ugzTp0Ag+BjVJb0Bi2J2sRHbuxjNxpHqMHxve6EdkpjtJ3KFIVRp2ZgveeHcmIv9oL+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gXviGK+8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gXviGK+8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5RAs1932737;
	Wed, 30 Sep 2026 17:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zHKIF8ilTRbo+cd9m
	J1WyKW/sgUO02JR4P/FapZg+gI=; b=gXviGK+8Y7NhCnLYYUvCJi2pzrQlydAsq
	u6BULy80+yVtrUHQmrMhNg+3FjvlPm6BVwOHX/iRZaCMnmrrqbWPELqMRqrS7lkn
	7gkwk8+XemL9d9MsnAC7CogMacj0XlCX8n6zjCFntEpyVU8sn4gCfIqogIPrP4AT
	5bSGRuZhcm48JGe0TqVg8ySughYizPmbDIfZqJR4TfAri7oq2fQ04TmkgrAhfHAd
	V9kU1R87hIDEpDmzxEoHtNYYxcEGDeyspyLxdRTKHkLjdJn3WVEM17SuQD0z1hG2
	y3LHJ2FdAkL3S/kHzDMMvWDbznscv7bIz8tc31ZrpNJwnlqlRqXyg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fedn3j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE38Ye3576974;
	Wed, 30 Sep 2026 17:34:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23mtmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYjst44892430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50BB420049;
	Wed, 30 Sep 2026 17:34:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE7BA20063;
	Wed, 30 Sep 2026 17:34:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:44 +0000 (GMT)
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
Subject: [PATCH v9 09/24] arm64: Prepare sharing arm64 headers with s390
Date: Wed, 30 Sep 2026 19:34:24 +0200
Message-ID: <20260930173441.66762-10-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173441.66762-1-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd483b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=vrw-LacCoHp_ID4KwbEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX7qjjkE0BCHLs
 DP7hwgCiDjhF+UqVnVVs+UE7TjoDcn6M9TDn1vLdeSk5aEFJB2Kb1T+atNsHY89+grOsPONqgmR
 4c8jldKyZ3J8Tb7YZV6poDw0OhDA9Qs=
X-Proofpoint-ORIG-GUID: oDh_4K56yP-dza-gdLHmlcUQNz1fJanu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX2EfNfAmwAvaW
 YBqGzrvThQldUoNcNZOIWSJubQNLNxLGdSC6wWrrqfzrrTlpkdD5DI1/1AJWr4nZhk6GG6/K/xZ
 505EDCot7fWp9W77UjiKXSuiT1liGDJhBzGG7ECLITJ3efehRYN7t9ElzHBqsxtsTGRKu+/dhbc
 q+/eZ42ANwmKUxSFvf94SA3cvWl2ry37ZVFLA7hDCODBPG0NolLkmktjJTFtFVy70eSQqUGsI+A
 i6jSTj/BlqkkEA9TJQVOxmGlrSKEuw6MVlu/Q/HO+klmh+mBecEoqdO8Qe+KM2Cj57C+M62s5nQ
 JiCjMe4pJfBFNSbK2RiDsSxGlEzMcMMI3qJ1LPA34FTx+vB4DhYZL+8s/dUjlcCIBQCG3UbLQh0
 PRlcXMPTD8hXSOYnB11Kc2mL/Xk9CysJ+NuqEGN6wmCu9QY04KuuxF78kKVC2LA/mO7bZAvWHvl
 oHPcJxCdq4aG2f7pQkw==
X-Proofpoint-GUID: AJETU7nB8bPZ385v0uCBOxz4j9HwJ--F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300068

Prepare the sharing of arm64 headers with s390 by moving definitions
inside headers to reduce the number of shared markers. Clean up includes
to further streamline the sharing of headers.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/esr.h      |   4 +-
 arch/arm64/include/asm/kvm_arm.h  |   5 +-
 arch/arm64/include/asm/kvm_host.h | 102 ++++++++++++++++--------------
 arch/arm64/include/asm/sysreg.h   |   2 +-
 4 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index f816f5d77f1a..da085c83b57e 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -7,7 +7,7 @@
 #ifndef __ASM_ESR_H
 #define __ASM_ESR_H
 
-#include <asm/memory.h>
+#include <asm/brk-imm.h>
 #include <asm/sysreg.h>
 
 #define ESR_ELx_EC_UNKNOWN	UL(0x00)
@@ -435,7 +435,7 @@
 #define ESR_ELx_IT_GCSPOPX		7
 
 #ifndef __ASSEMBLER__
-#include <asm/types.h>
+#include <linux/types.h>
 
 static inline unsigned long esr_brk_comment(unsigned long esr)
 {
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 4bfbd827c5aa..57edd8437200 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -7,10 +7,11 @@
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
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 99c6cb260309..55966decfeb6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -59,6 +59,46 @@
 #define KVM_REQ_MAP_L1_VNCR_EL2		KVM_ARCH_REQ(10)
 #define KVM_REQ_VGIC_PROCESS_UPDATE	KVM_ARCH_REQ(11)
 
+/* Bit indices for kvm_arch::flags */
+enum {
+	/*
+	 * If we encounter a data abort without valid instruction syndrome
+	 * information, report this to user space.  User space can (and
+	 * should) opt in to this feature if KVM_CAP_ARM_NISV_TO_USER is
+	 * supported.
+	 */
+	KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER,
+	/* Memory Tagging Extension enabled for the guest */
+	KVM_ARCH_FLAG_MTE_ENABLED,
+	/* At least one vCPU has ran in the VM */
+	KVM_ARCH_FLAG_HAS_RAN_ONCE,
+	/* The vCPU feature set for the VM is configured */
+	KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED,
+	/* PSCI SYSTEM_SUSPEND enabled for the guest */
+	KVM_ARCH_FLAG_SYSTEM_SUSPEND_ENABLED,
+	/* VM counter offset */
+	KVM_ARCH_FLAG_VM_COUNTER_OFFSET,
+	/* Timer PPIs made immutable */
+	KVM_ARCH_FLAG_TIMER_PPIS_IMMUTABLE,
+	/* Initial ID reg values loaded */
+	KVM_ARCH_FLAG_ID_REGS_INITIALIZED,
+	/* Fine-Grained UNDEF initialised */
+	KVM_ARCH_FLAG_FGU_INITIALIZED,
+	/* SVE exposed to guest */
+	KVM_ARCH_FLAG_GUEST_HAS_SVE,
+	/* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace */
+	KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS,
+	/* Unhandled SEAs are taken to userspace */
+	KVM_ARCH_FLAG_EXIT_SEA,
+};
+
+struct vcpu_reset_state {
+	unsigned long	pc;
+	unsigned long	r0;
+	bool		be;
+	bool		reset;
+};
+
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 				     KVM_DIRTY_LOG_INITIALLY_SET)
 
@@ -341,35 +381,6 @@ struct kvm_arch {
 	/* Protects VM-scoped configuration data */
 	struct mutex config_lock;
 
-	/*
-	 * If we encounter a data abort without valid instruction syndrome
-	 * information, report this to user space.  User space can (and
-	 * should) opt in to this feature if KVM_CAP_ARM_NISV_TO_USER is
-	 * supported.
-	 */
-#define KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER	0
-	/* Memory Tagging Extension enabled for the guest */
-#define KVM_ARCH_FLAG_MTE_ENABLED			1
-	/* At least one vCPU has ran in the VM */
-#define KVM_ARCH_FLAG_HAS_RAN_ONCE			2
-	/* The vCPU feature set for the VM is configured */
-#define KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED		3
-	/* PSCI SYSTEM_SUSPEND enabled for the guest */
-#define KVM_ARCH_FLAG_SYSTEM_SUSPEND_ENABLED		4
-	/* VM counter offset */
-#define KVM_ARCH_FLAG_VM_COUNTER_OFFSET			5
-	/* Timer PPIs made immutable */
-#define KVM_ARCH_FLAG_TIMER_PPIS_IMMUTABLE		6
-	/* Initial ID reg values loaded */
-#define KVM_ARCH_FLAG_ID_REGS_INITIALIZED		7
-	/* Fine-Grained UNDEF initialised */
-#define KVM_ARCH_FLAG_FGU_INITIALIZED			8
-	/* SVE exposed to guest */
-#define KVM_ARCH_FLAG_GUEST_HAS_SVE			9
-	/* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace */
-#define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS		10
-	/* Unhandled SEAs are taken to userspace */
-#define KVM_ARCH_FLAG_EXIT_SEA				11
 	unsigned long flags;
 
 	/* VM-wide vCPU feature set */
@@ -838,13 +849,6 @@ extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
 extern u64 kvm_nvhe_sym(hyp_cpu_logical_map)[NR_CPUS];
 #define hyp_cpu_logical_map CHOOSE_NVHE_SYM(hyp_cpu_logical_map)
 
-struct vcpu_reset_state {
-	unsigned long	pc;
-	unsigned long	r0;
-	bool		be;
-	bool		reset;
-};
-
 struct vncr_tlb;
 
 struct kvm_vcpu_arch {
@@ -1049,6 +1053,11 @@ struct kvm_vcpu_arch {
 /* pKVM VCPU setup completed */
 #define VCPU_PKVM_FINALIZED	__vcpu_single_flag(cflags, BIT(2))
 
+int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature);
+bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
+
+#define kvm_arm_vcpu_sve_finalized(vcpu) vcpu_get_flag(vcpu, VCPU_SVE_FINALIZED)
+
 /* Exception pending */
 #define PENDING_EXCEPTION	__vcpu_single_flag(iflags, BIT(0))
 /*
@@ -1242,14 +1251,6 @@ struct kvm_vcpu_stat {
 	u64 exits;
 };
 
-unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
-int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
-int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
-int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
-
-unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu);
-int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
-
 int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 			      struct kvm_vcpu_events *events);
 
@@ -1328,6 +1329,14 @@ int __init populate_nv_trap_config(void);
 
 void kvm_calculate_traps(struct kvm_vcpu *vcpu);
 
+unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
+int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
+int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+
+unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu);
+int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
+
 /* MMIO helpers */
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
 unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
@@ -1511,11 +1520,6 @@ struct kvm *kvm_arch_alloc_vm(void);
 
 #define vcpu_is_protected(vcpu)		kvm_vm_is_protected((vcpu)->kvm)
 
-int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature);
-bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
-
-#define kvm_arm_vcpu_sve_finalized(vcpu) vcpu_get_flag(vcpu, VCPU_SVE_FINALIZED)
-
 #define kvm_has_mte(kvm)					\
 	(system_supports_mte() &&				\
 	 test_bit(KVM_ARCH_FLAG_MTE_ENABLED, &(kvm)->arch.flags))
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1aa601c95188..ab205f9db94a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1263,6 +1263,6 @@
 		 FIELD_PREP(reg##_##field##_MASK,	\
 			    SYS_FIELD_VALUE(reg, field, val))
 
-#endif
+#endif /* __ASSEMBLER__ */
 
 #endif	/* __ASM_SYSREG_H */
-- 
2.53.0

