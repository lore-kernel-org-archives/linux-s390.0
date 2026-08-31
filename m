Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40753A380E;
	Mon, 31 Aug 2026 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188196; cv=none; b=GABIZvQCnzCRTKoB5ln4DeTHHDtVjtzVcutz01IHoL0AvPogitVkiVU+j16WUHZxl/2xmklJCQu78rhnDW8Opmb4Ti7IHnZOK4by+gDox6Yzo1BqFeEBN03Vbb3nkt7Tu2fxdPGfIiXP88jWjVcZsKirw8KbFHQlC0l6S38HEHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188196; c=relaxed/simple;
	bh=6OuPNSR0O485kjhv8tuHbUW+tqIkeSaKQJPD8WENixQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilxcHfAkbVePrE0AQVTdBL8DoP6QdVNoQ3DzM4E+K2Yqa5DY0Yk6ibHnaRD4ZVnVIcGIsdqRVUTQzQpHd5sJDZBvkBAuMJ0tnLkB7m//IhorQ5kbblVhSEeIoHB1CtWpGFXO4eCna7jrgWiDFI5XEJq9PMZJal9oMYdMGzegmEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mPqHAfke; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mPqHAfke"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZDnJ2583044;
	Mon, 31 Aug 2026 14:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9d9jEi/Hbb2BuwMnF
	JAd6SSW5KH99JtTJehKUtC3l00=; b=mPqHAfkej+n97c2t+W3TsEKMFFrwvynMa
	Ktriu14fHDS7PbN1PCF09lZqPDt5q8tQsStFKtw8I7vSIGgtC8JGQBjX0wA7aYpT
	6S+DDZsUxgAoUJ9fvZRVCYbHbFR3ZqybcitYvPQra5hoqA5VYN83e9KIk8FVgP1o
	dXd+HdZKE9+VF50/o6hkZegHGBskxGxCEHOKVRHEyyQXXZymXTF8q+gxU6u+mPP7
	ElVLY6UUZASt7VSdABcCFeGwuBePZh/pFnrheDHm4YBds+K3bfCWuCd7W515gzBl
	hyIfgvY3Gu6wOAR3A2M4EBTT0/SqevmWto2Qgetkh52D935bM9QjQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t1u9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfjKE000540;
	Mon, 31 Aug 2026 14:55:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg6a9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtdXF46203330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7005C20040;
	Mon, 31 Aug 2026 14:55:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED3492004D;
	Mon, 31 Aug 2026 14:55:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:38 +0000 (GMT)
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
Subject: [PATCH v2 04/20] arm64: Share more arm64 headers with s390
Date: Mon, 31 Aug 2026 16:55:19 +0200
Message-ID: <20260831145536.913567-5-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9595f4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=UQM1QJzDAAAA:8
 a=mvpi5xyKNc9T2wr1NbsA:9 a=Y_cFJIg8yfREFdlijoxh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXzbIjGwlx0FlB
 a0jVScM/SyADz95t70VOvN7dnPM/0UMnWFpOPawPjmD64RNHZzUFFg+2q3S/gpf+wzW5nWDuF/U
 dYkPbU/MdpYGhB29q/hZSgabcJ9wEkE=
X-Proofpoint-ORIG-GUID: 4vsTMWNaq12DDUfVNo-MUlSz_XpmnGqe
X-Proofpoint-GUID: O-UxeX3bRzVKSmK-1g_oh4F7YdFwBxy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXzsSc6wrLl6dw
 Nt7CIU1ekwBHUmLWhm1yJHJV2KEeutcX7AUkISDJ0qhanaeEwOqAgITbtMmXh50FcRwmR0P41hs
 3GJDK3UWG8cd7hw1BTfoTzYxEWVGv1BQnqxoF61Am10bn2pG/pbjQHXgDxnlbVgGOrq8IgKsgXM
 H3cEoYPaTLnzURPrKpO8mAVpo0qN3fRQAA5g7+ieqmGsLy4Jvk9oj1kmfzPMjLz7U/Oh3ZEQzZS
 XqzLOOBJa4L4V7lNx5MyzKGAqxIX9gLqXJl7K28CBecssRJN+j8PZIWckNkV10ekzN2loTQaz4s
 ka70kcKYjtdeLTl1xPwhV2oLKrRXP/c5tippBYRepGakntu5WWDX1zgBYCAhLnIrw2FCxxpX8Uc
 v2dxoRo67v45rgL4e3EdODNSfsBhx2TnDAN1Sy1VkUeRcxLGProOsO4Ate1h4sk2s1yG3hQCF1X
 1GEEYbJBMQfDT5ueBiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

Mark more headers as shared or move definitions to an already shared
location if the context is similar. Most of them are required to
implement system register handling for the host.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/cache.h       |  3 +++
 arch/arm64/include/asm/cputype.h     |  3 +++
 arch/arm64/include/asm/kvm_emulate.h |  5 ++++-
 arch/arm64/include/asm/kvm_host.h    | 18 +++++++++++++-----
 arch/arm64/include/asm/spectre.h     |  7 +++++++
 arch/arm64/kvm/sys_regs.h            |  1 +
 6 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 10a7ffadee3d..f9dbc8143dc9 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -8,6 +8,7 @@
 #define L1_CACHE_SHIFT		(6)
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
+#ifdef ARM64_S390_COMMON
 #define CLIDR_LOUU_SHIFT	27
 #define CLIDR_LOC_SHIFT		24
 #define CLIDR_LOUIS_SHIFT	21
@@ -25,6 +26,8 @@
 /* Ttypen, bits [2(n - 1) + 34 : 2(n - 1) + 33], for n = 1 to 7 */
 #define CLIDR_TTYPE_SHIFT(level)	(2 * ((level) - 1) + CLIDR_EL1_Ttypen_SHIFT)
 
+#endif /* ARM64_S390_COMMON */
+
 /*
  * Memory returned by kmalloc() may be used for DMA, so we must make
  * sure that all such allocations are cache aligned. Otherwise,
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 1fa29616e586..a5fd2b749b3b 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -5,6 +5,7 @@
 #ifndef __ASM_CPUTYPE_H
 #define __ASM_CPUTYPE_H
 
+#ifdef ARM64_S390_COMMON
 #define INVALID_HWID		ULONG_MAX
 
 #define MPIDR_UP_BITMASK	(0x1 << 30)
@@ -259,6 +260,8 @@
 #define MIDR_FUJITSU_ERRATUM_010001_MASK	(~MIDR_CPU_VAR_REV(1, 0))
 #define TCR_CLEAR_FUJITSU_ERRATUM_010001	(TCR_EL1_NFD1 | TCR_EL1_NFD0)
 
+#endif /* ARM64_S390_COMMON */
+
 #ifndef __ASSEMBLER__
 
 #include <asm/sysreg.h>
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 09f04a5686a1..6cd9b244d82e 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -23,6 +23,7 @@
 #include <asm/cputype.h>
 #include <asm/virt.h>
 
+#ifdef ARM64_S390_COMMON
 #define CURRENT_EL_SP_EL0_VECTOR	0x0
 #define CURRENT_EL_SP_ELx_VECTOR	0x200
 #define LOWER_EL_AArch64_VECTOR		0x400
@@ -35,6 +36,8 @@ enum exception_type {
 	except_type_serror	= 0x180,
 };
 
+#endif /* ARM64_S390_COMMON */
+
 #define kvm_exception_type_names		\
 	{ except_type_sync,	"SYNC"   },	\
 	{ except_type_irq,	"IRQ"    },	\
@@ -525,13 +528,13 @@ static __always_inline bool kvm_vcpu_abt_issea(const struct kvm_vcpu *vcpu)
 	}
 }
 
+#ifdef ARM64_S390_COMMON
 static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
 {
 	u64 esr = kvm_vcpu_get_esr(vcpu);
 	return ESR_ELx_SYS64_ISS_RT(esr);
 }
 
-#ifdef ARM64_S390_COMMON
 static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
 {
 	if (kvm_vcpu_abt_iss1tw(vcpu)) {
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f9e90ef9ee4b..2ca5fbc39f15 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -349,6 +349,7 @@ enum fgt_group_id {
 	__NR_FGT_GROUP_IDS__
 };
 
+#ifdef ARM64_S390_COMMON
 struct kvm_vm_id_regs {
 	/*
 	 * Emulated CPU ID registers per VM
@@ -368,6 +369,8 @@ struct kvm_vm_id_regs {
 	u64 ctr_el0;
 };
 
+#endif /* ARM64_S390_COMMON */
+
 struct kvm_arch {
 	struct kvm_s2_mmu mmu;
 
@@ -1240,9 +1243,6 @@ u64 kvm_vcpu_apply_reg_masks(const struct kvm_vcpu *, enum vcpu_sysreg, u64);
 		__v;							\
 	})
 
-u64 vcpu_read_sys_reg(const struct kvm_vcpu *, enum vcpu_sysreg);
-void vcpu_write_sys_reg(struct kvm_vcpu *, u64, enum vcpu_sysreg);
-
 struct kvm_vm_stat {
 	struct kvm_vm_stat_generic generic;
 };
@@ -1322,11 +1322,9 @@ int kvm_handle_cp14_32(struct kvm_vcpu *vcpu);
 int kvm_handle_cp14_64(struct kvm_vcpu *vcpu);
 int kvm_handle_cp15_32(struct kvm_vcpu *vcpu);
 int kvm_handle_cp15_64(struct kvm_vcpu *vcpu);
-int kvm_handle_sys_reg(struct kvm_vcpu *vcpu);
 int kvm_handle_cp10_id(struct kvm_vcpu *vcpu);
 
 void kvm_sys_regs_create_debugfs(struct kvm *kvm);
-void kvm_reset_sys_regs(struct kvm_vcpu *vcpu);
 
 int __init kvm_sys_reg_table_init(void);
 struct sys_reg_desc;
@@ -1337,6 +1335,11 @@ int __init populate_nv_trap_config(void);
 void kvm_calculate_traps(struct kvm_vcpu *vcpu);
 
 #ifdef ARM64_S390_COMMON
+u64 vcpu_read_sys_reg(const struct kvm_vcpu *, enum vcpu_sysreg);
+void vcpu_write_sys_reg(struct kvm_vcpu *, u64, enum vcpu_sysreg);
+int kvm_handle_sys_reg(struct kvm_vcpu *vcpu);
+void kvm_reset_sys_regs(struct kvm_vcpu *vcpu);
+
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
@@ -1538,8 +1541,10 @@ struct kvm *kvm_arch_alloc_vm(void);
 	(system_supports_32bit_el0() &&				\
 	 !static_branch_unlikely(&arm64_mismatched_32bit_el0))
 
+#ifdef ARM64_S390_COMMON
 #define kvm_vm_has_ran_once(kvm)					\
 	(test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &(kvm)->arch.flags))
+#endif /* ARM64_S390_COMMON */
 
 static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
 {
@@ -1567,6 +1572,7 @@ static inline void kvm_hyp_reserve(void) { }
 void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
 bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu);
 
+#ifdef ARM64_S390_COMMON
 static inline u64 *__vm_id_reg(struct kvm_vm_id_regs *id_regs, u32 reg)
 {
 	switch (reg) {
@@ -1640,6 +1646,8 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 	(kvm_cmp_feat(kvm, id, fld, >=, min) &&				\
 	kvm_cmp_feat(kvm, id, fld, <=, max))
 
+#endif /* ARM64_S390_COMMON */
+
 /* Check for a given level of PAuth support */
 #define kvm_has_pauth(k, l)						\
 	({								\
diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 296ae3420bfd..e1c13797ea7c 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -19,6 +19,7 @@
 #include <asm/cpufeature.h>
 #include <asm/virt.h>
 
+#ifdef ARM64_S390_COMMON
 /* Watch out, ordering is important here. */
 enum mitigation_state {
 	SPECTRE_UNAFFECTED,
@@ -26,6 +27,8 @@ enum mitigation_state {
 	SPECTRE_VULNERABLE,
 };
 
+#endif /* ARM64_S390_COMMON */
+
 struct pt_regs;
 struct task_struct;
 
@@ -81,7 +84,9 @@ static __always_inline void arm64_apply_bp_hardening(void)
 		d->fn();
 }
 
+#ifdef ARM64_S390_COMMON
 enum mitigation_state arm64_get_spectre_v2_state(void);
+#endif /* ARM64_S390_COMMON */
 bool has_spectre_v2(const struct arm64_cpu_capabilities *cap, int scope);
 void spectre_v2_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 
@@ -93,7 +98,9 @@ bool has_spectre_v4(const struct arm64_cpu_capabilities *cap, int scope);
 void spectre_v4_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 void spectre_v4_enable_task_mitigation(struct task_struct *tsk);
 
+#ifdef ARM64_S390_COMMON
 enum mitigation_state arm64_get_meltdown_state(void);
+#endif /* ARM64_S390_COMMON */
 
 enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index bd56a45abbf9..44665ef10732 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -7,6 +7,7 @@
  * Copyright (C) 2012 - Virtual Open Systems and Columbia University
  * Authors: Christoffer Dall <c.dall@virtualopensystems.com>
  */
+/* Whole file is shared with s390 */
 
 #ifndef __ARM64_KVM_SYS_REGS_LOCAL_H__
 #define __ARM64_KVM_SYS_REGS_LOCAL_H__
-- 
2.53.0

