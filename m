Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12B374E7A;
	Thu,  2 Apr 2026 04:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103737; cv=none; b=W2l7L7Pgcmc2sCmCBkLM7LFCITQQknrCIvuP4Y7VrVCYnTMY4zaMhMo+Apt91z/nj8DeHB9nKKID6nSgxqFoM8f9zJ4B4GLuqfwfzFkFWW2R/hXwOwjgDPZXNOc+YUoEqrUGxIiS/mSGmPG0n16H4bSs45oM/wE2/ukyCjcTefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103737; c=relaxed/simple;
	bh=ddMHSUfBTK0KXVtypvo0RHL9v5ekCkwPgsehoIFaBm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1tGR795GoFXgQ9DYZo3wog5VzDkfK2W/F6xuTDrVQkZA5YAv9JWim0OtnCu5NfhfNNZpSsTt3qm6lIjWzPSYZ/LNQRSSC5Hd6le9SNZ5bM4Rg4TsjRwVPOiGtWiDJT+zF7PPu7urxfAxjQ+72bPxgE+YlEsEYlqpvLIc/Nvaq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ob2vFlFt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ob2vFlFt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M53qK015098;
	Thu, 2 Apr 2026 04:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0Hbru0WwSxaucT6O7
	EBXw/N8MIolR6UQlKZzwHt+fSM=; b=ob2vFlFtNapLAZt9By42h+D2lCk/iFVc6
	nmaILo/52yOb571MYiRMZ4cONjsB9FmlEiWbXT2G5JceTd8gyBf1ee5QCsbNIugc
	lpKY0vzu+DnQV2RWJJaH+SB+9aBHlgD/fJvPUkfaSNzzOKvkAYmW1V/0XJrLkduw
	+m/UkA+26GyAqEA6p+B+8/A/k3tL/gNE9iqGSC4wE4a+QikWA5yAfMPZtLrpjRDg
	ZUfv+LWdHA9TQrjFcrNQSrPP6APNuxjmauYHi78OpoPiU8NCE7ydGV38XHtV8jrR
	IH9eUP+tH63+ma9HUvw4FoO2yH0m+XG5LgY17BZmNyNFDEYaSu0lA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3b7dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63201aX7022197;
	Thu, 2 Apr 2026 04:21:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan8kb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LUbh24576326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 053D02004E;
	Thu,  2 Apr 2026 04:21:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A2A32004B;
	Thu,  2 Apr 2026 04:21:29 +0000 (GMT)
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
Subject: [PATCH v1 10/27] KVM: arm64: Make some arm64 KVM code shareable
Date: Thu,  2 Apr 2026 06:21:06 +0200
Message-ID: <20260402042125.3948963-11-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: dPT5MW4jYTqn7iLOLq6NMjZT1SnkGr6d
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cdeecf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=vbCobAosysR5EIkJmscA:9
X-Proofpoint-ORIG-GUID: dPT5MW4jYTqn7iLOLq6NMjZT1SnkGr6d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfXxe1huZBTsN6d
 fPdo4cJgvBqiiKOtI+bvWkgDG9Uowr9bnXYVU6at37gx4VPTQtXfqXOdYD1ZOQCNrxoObQSuJyE
 wGjlBG8En7EFR0fZzD2pXHMblF8x53Z30IWn1xg/PnnIQfkI8uMFWmZvhom5wJ/qeUQX9zJHMmM
 l1q0T1XSgHSlAFhDsqJfL//L28gzsJDZxPz7MO4c4QMD7X/ao2IKaYKpK/djYd2GX3svQIChK47
 32WX5jqMMHjyEOmjKlV5piikh7bhB1TXKhOfww88O25CTrm6//ssklRDTEWznq3z57IhqacoeSd
 ubxKNlFh8xZgx5f+7L2eEBswIzr/ASnq7wGSZ6hXZilTFj63HaBI5QNw0ZAvu+2HEEj44sMIizr
 7QbVg3QeGEoLkX8xYaPHKJid/ngntIA/xqgMR8NBPh6qrvqiTtMxPV130bjaHrPnEreThFRTrb0
 hLH/jy9/nSYPf7MzyJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020034

Support sharing architecture-agnostic KVM-arm64 code between different
architectures. Introduce a new directory virt/kvm/arm64 which holds
arm64-KVM code that can be used by multiple architectures implementing
the arm64-KVM API.

Additionally, to improve portability slightly modify core_reg_addr to
use functions instead of direct field accesses.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 MAINTAINERS                               |   1 +
 arch/arm64/kvm/Makefile                   |   5 +-
 arch/arm64/kvm/arm.c                      |  48 ----
 arch/arm64/kvm/guest.c                    | 292 ---------------------
 arch/arm64/kvm/handle_exit.c              |  52 +---
 arch/arm64/kvm/trace_arm.h                |  25 --
 include/kvm/arm64/guest.h                 |   5 +-
 include/kvm/arm64/handle_exit.h           |  14 +
 include/kvm/arm64/kvm_host.h              |   9 +
 virt/kvm/arm64/Makefile.kvm               |  12 +
 virt/kvm/arm64/arm.c                      |  54 ++++
 virt/kvm/arm64/guest.c                    | 302 ++++++++++++++++++++++
 virt/kvm/arm64/handle_exit.c              |  54 ++++
 {arch/arm64/kvm => virt/kvm/arm64}/mmio.c |   1 +
 virt/kvm/arm64/trace.h                    |  42 +++
 15 files changed, 500 insertions(+), 416 deletions(-)
 create mode 100644 include/kvm/arm64/handle_exit.h
 create mode 100644 virt/kvm/arm64/Makefile.kvm
 create mode 100644 virt/kvm/arm64/arm.c
 create mode 100644 virt/kvm/arm64/guest.c
 create mode 100644 virt/kvm/arm64/handle_exit.c
 rename {arch/arm64/kvm => virt/kvm/arm64}/mmio.c (99%)
 create mode 100644 virt/kvm/arm64/trace.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 075463117c2b..bac2ba07c916 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13998,6 +13998,7 @@ F:	arch/arm64/include/uapi/asm/kvm*
 F:	include/kvm/arm64/
 F:	include/uapi/arch/arm64/asm/kvm*
 F:	arch/arm64/kvm/
+F:	virt/kvm/arm64/
 F:	include/kvm/arm_*
 F:	tools/testing/selftests/kvm/*/arm64/
 F:	tools/testing/selftests/kvm/arm64/
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 3ebc0570345c..94ea6f0546b0 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -6,6 +6,7 @@
 ccflags-y += -I $(src)
 
 include $(srctree)/virt/kvm/Makefile.kvm
+include $(srctree)/virt/kvm/arm64/Makefile.kvm
 
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(CONFIG_KVM) += hyp/
@@ -13,7 +14,7 @@ obj-$(CONFIG_KVM) += hyp/
 CFLAGS_sys_regs.o += -Wno-override-init
 CFLAGS_handle_exit.o += -Wno-override-init
 
-kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
+kvm-y += arm.o mmu.o psci.o hypercalls.o pvtime.o \
 	 inject_fault.o va_layout.o handle_exit.o config.o \
 	 guest.o debug.o reset.o sys_regs.o stacktrace.o \
 	 vgic-sys-reg-v3.o fpsimd.o pkvm.o \
@@ -26,6 +27,8 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o vgic/vgic-v3-nested.o \
 	 vgic/vgic-v5.o
 
+kvm-y += $(shared-arm64-obj)
+
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
 kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 47630730260f..41f2e5c1b953 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1515,54 +1515,6 @@ unsigned long system_supported_vcpu_features(void)
 	return features;
 }
 
-static int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
-					const struct kvm_vcpu_init *init)
-{
-	unsigned long features = init->features[0];
-	int i;
-
-	if (features & ~KVM_VCPU_VALID_FEATURES)
-		return -ENOENT;
-
-	for (i = 1; i < ARRAY_SIZE(init->features); i++) {
-		if (init->features[i])
-			return -ENOENT;
-	}
-
-	if (features & ~system_supported_vcpu_features())
-		return -EINVAL;
-
-	/*
-	 * For now make sure that both address/generic pointer authentication
-	 * features are requested by the userspace together.
-	 */
-	if (test_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, &features) !=
-	    test_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, &features))
-		return -EINVAL;
-
-	if (!test_bit(KVM_ARM_VCPU_EL1_32BIT, &features))
-		return 0;
-
-	/* MTE is incompatible with AArch32 */
-	if (kvm_has_mte(vcpu->kvm))
-		return -EINVAL;
-
-	/* NV is incompatible with AArch32 */
-	if (test_bit(KVM_ARM_VCPU_HAS_EL2, &features))
-		return -EINVAL;
-
-	return 0;
-}
-
-static bool kvm_vcpu_init_changed(struct kvm_vcpu *vcpu,
-				  const struct kvm_vcpu_init *init)
-{
-	unsigned long features = init->features[0];
-
-	return !bitmap_equal(vcpu->kvm->arch.vcpu_features, &features,
-			     KVM_VCPU_MAX_FEATURES);
-}
-
 static int kvm_setup_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 557c380ffa37..161840c357e0 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -64,250 +64,6 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
-static bool core_reg_offset_is_vreg(u64 off)
-{
-	return off >= KVM_REG_ARM_CORE_REG(fp_regs.vregs) &&
-		off < KVM_REG_ARM_CORE_REG(fp_regs.fpsr);
-}
-
-static u64 core_reg_offset_from_id(u64 id)
-{
-	return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
-}
-
-static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
-{
-	int size;
-
-	switch (off) {
-	case KVM_REG_ARM_CORE_REG(regs.regs[0]) ...
-	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
-	case KVM_REG_ARM_CORE_REG(regs.sp):
-	case KVM_REG_ARM_CORE_REG(regs.pc):
-	case KVM_REG_ARM_CORE_REG(regs.pstate):
-	case KVM_REG_ARM_CORE_REG(sp_el1):
-	case KVM_REG_ARM_CORE_REG(elr_el1):
-	case KVM_REG_ARM_CORE_REG(spsr[0]) ...
-	     KVM_REG_ARM_CORE_REG(spsr[KVM_NR_SPSR - 1]):
-		size = sizeof(__u64);
-		break;
-
-	case KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]) ...
-	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
-		size = sizeof(__uint128_t);
-		break;
-
-	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
-	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
-		size = sizeof(__u32);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	if (!IS_ALIGNED(off, size / sizeof(__u32)))
-		return -EINVAL;
-
-	/*
-	 * The KVM_REG_ARM64_SVE regs must be used instead of
-	 * KVM_REG_ARM_CORE for accessing the FPSIMD V-registers on
-	 * SVE-enabled vcpus:
-	 */
-	if (vcpu_has_sve(vcpu) && core_reg_offset_is_vreg(off))
-		return -EINVAL;
-
-	return size;
-}
-
-static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
-{
-	u64 off = core_reg_offset_from_id(reg->id);
-	int size = core_reg_size_from_offset(vcpu, off);
-
-	if (size < 0)
-		return NULL;
-
-	if (KVM_REG_SIZE(reg->id) != size)
-		return NULL;
-
-	switch (off) {
-	case KVM_REG_ARM_CORE_REG(regs.regs[0]) ...
-	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
-		off -= KVM_REG_ARM_CORE_REG(regs.regs[0]);
-		off /= 2;
-		return &vcpu->arch.ctxt.regs.regs[off];
-
-	case KVM_REG_ARM_CORE_REG(regs.sp):
-		return &vcpu->arch.ctxt.regs.sp;
-
-	case KVM_REG_ARM_CORE_REG(regs.pc):
-		return &vcpu->arch.ctxt.regs.pc;
-
-	case KVM_REG_ARM_CORE_REG(regs.pstate):
-		return &vcpu->arch.ctxt.regs.pstate;
-
-	case KVM_REG_ARM_CORE_REG(sp_el1):
-		return __ctxt_sys_reg(&vcpu->arch.ctxt, SP_EL1);
-
-	case KVM_REG_ARM_CORE_REG(elr_el1):
-		return __ctxt_sys_reg(&vcpu->arch.ctxt, ELR_EL1);
-
-	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_EL1]):
-		return __ctxt_sys_reg(&vcpu->arch.ctxt, SPSR_EL1);
-
-	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_ABT]):
-		return &vcpu->arch.ctxt.spsr_abt;
-
-	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_UND]):
-		return &vcpu->arch.ctxt.spsr_und;
-
-	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_IRQ]):
-		return &vcpu->arch.ctxt.spsr_irq;
-
-	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_FIQ]):
-		return &vcpu->arch.ctxt.spsr_fiq;
-
-	case KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]) ...
-	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
-		off -= KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]);
-		off /= 4;
-		return &vcpu->arch.ctxt.fp_regs.vregs[off];
-
-	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
-		return &vcpu->arch.ctxt.fp_regs.fpsr;
-
-	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
-		return &vcpu->arch.ctxt.fp_regs.fpcr;
-
-	default:
-		return NULL;
-	}
-}
-
-static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
-{
-	/*
-	 * Because the kvm_regs structure is a mix of 32, 64 and
-	 * 128bit fields, we index it as if it was a 32bit
-	 * array. Hence below, nr_regs is the number of entries, and
-	 * off the index in the "array".
-	 */
-	__u32 __user *uaddr = (__u32 __user *)(unsigned long)reg->addr;
-	int nr_regs = sizeof(struct kvm_regs) / sizeof(__u32);
-	void *addr;
-	u32 off;
-
-	/* Our ID is an index into the kvm_regs struct. */
-	off = core_reg_offset_from_id(reg->id);
-	if (off >= nr_regs ||
-	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
-		return -ENOENT;
-
-	addr = core_reg_addr(vcpu, reg);
-	if (!addr)
-		return -EINVAL;
-
-	if (copy_to_user(uaddr, addr, KVM_REG_SIZE(reg->id)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
-{
-	__u32 __user *uaddr = (__u32 __user *)(unsigned long)reg->addr;
-	int nr_regs = sizeof(struct kvm_regs) / sizeof(__u32);
-	__uint128_t tmp;
-	void *valp = &tmp, *addr;
-	u64 off;
-	int err = 0;
-
-	/* Our ID is an index into the kvm_regs struct. */
-	off = core_reg_offset_from_id(reg->id);
-	if (off >= nr_regs ||
-	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
-		return -ENOENT;
-
-	addr = core_reg_addr(vcpu, reg);
-	if (!addr)
-		return -EINVAL;
-
-	if (KVM_REG_SIZE(reg->id) > sizeof(tmp))
-		return -EINVAL;
-
-	if (copy_from_user(valp, uaddr, KVM_REG_SIZE(reg->id))) {
-		err = -EFAULT;
-		goto out;
-	}
-
-	if (off == KVM_REG_ARM_CORE_REG(regs.pstate)) {
-		u64 mode = (*(u64 *)valp) & PSR_AA32_MODE_MASK;
-		switch (mode) {
-		case PSR_AA32_MODE_USR:
-			if (!kvm_supports_32bit_el0())
-				return -EINVAL;
-			break;
-		case PSR_AA32_MODE_FIQ:
-		case PSR_AA32_MODE_IRQ:
-		case PSR_AA32_MODE_SVC:
-		case PSR_AA32_MODE_ABT:
-		case PSR_AA32_MODE_UND:
-		case PSR_AA32_MODE_SYS:
-			if (!vcpu_el1_is_32bit(vcpu))
-				return -EINVAL;
-			break;
-		case PSR_MODE_EL2h:
-		case PSR_MODE_EL2t:
-			if (!vcpu_has_nv(vcpu))
-				return -EINVAL;
-			fallthrough;
-		case PSR_MODE_EL0t:
-		case PSR_MODE_EL1t:
-		case PSR_MODE_EL1h:
-			if (vcpu_el1_is_32bit(vcpu))
-				return -EINVAL;
-			break;
-		default:
-			err = -EINVAL;
-			goto out;
-		}
-	}
-
-	memcpy(addr, valp, KVM_REG_SIZE(reg->id));
-
-	if (*vcpu_cpsr(vcpu) & PSR_MODE32_BIT) {
-		int i, nr_reg;
-
-		switch (*vcpu_cpsr(vcpu) & PSR_AA32_MODE_MASK) {
-		/*
-		 * Either we are dealing with user mode, and only the
-		 * first 15 registers (+ PC) must be narrowed to 32bit.
-		 * AArch32 r0-r14 conveniently map to AArch64 x0-x14.
-		 */
-		case PSR_AA32_MODE_USR:
-		case PSR_AA32_MODE_SYS:
-			nr_reg = 15;
-			break;
-
-		/*
-		 * Otherwise, this is a privileged mode, and *all* the
-		 * registers must be narrowed to 32bit.
-		 */
-		default:
-			nr_reg = 31;
-			break;
-		}
-
-		for (i = 0; i < nr_reg; i++)
-			vcpu_set_reg(vcpu, i, (u32)vcpu_get_reg(vcpu, i));
-
-		*vcpu_pc(vcpu) = (u32)*vcpu_pc(vcpu);
-	}
-out:
-	return err;
-}
-
 #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
 #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
 #define vq_present(vqs, vq) (!!((vqs)[vq_word(vq)] & vq_mask(vq)))
@@ -545,54 +301,6 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	return -EINVAL;
 }
 
-static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
-				 u64 __user *uindices)
-{
-	unsigned int i;
-	int n = 0;
-
-	for (i = 0; i < sizeof(struct kvm_regs) / sizeof(__u32); i++) {
-		u64 reg = KVM_REG_ARM64 | KVM_REG_ARM_CORE | i;
-		int size = core_reg_size_from_offset(vcpu, i);
-
-		if (size < 0)
-			continue;
-
-		switch (size) {
-		case sizeof(__u32):
-			reg |= KVM_REG_SIZE_U32;
-			break;
-
-		case sizeof(__u64):
-			reg |= KVM_REG_SIZE_U64;
-			break;
-
-		case sizeof(__uint128_t):
-			reg |= KVM_REG_SIZE_U128;
-			break;
-
-		default:
-			WARN_ON(1);
-			continue;
-		}
-
-		if (uindices) {
-			if (put_user(reg, uindices))
-				return -EFAULT;
-			uindices++;
-		}
-
-		n++;
-	}
-
-	return n;
-}
-
-static unsigned long num_core_regs(const struct kvm_vcpu *vcpu)
-{
-	return copy_core_reg_indices(vcpu, NULL);
-}
-
 static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
 {
 	const unsigned int slices = vcpu_sve_slices(vcpu);
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index cc7d5d1709cb..fc92f6ade8a4 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -24,11 +24,11 @@
 
 #include <kvm/arm_hypercalls.h>
 
+#include <kvm/arm64/handle_exit.h>
+
 #define CREATE_TRACE_POINTS
 #include "trace_handle_exit.h"
 
-typedef int (*exit_handle_fn)(struct kvm_vcpu *);
-
 static void kvm_handle_guest_serror(struct kvm_vcpu *vcpu, u64 esr)
 {
 	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(NULL, esr))
@@ -213,17 +213,6 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
-{
-	u64 esr = kvm_vcpu_get_esr(vcpu);
-
-	kvm_pr_unimpl("Unknown exception class: esr: %#016llx -- %s\n",
-		      esr, esr_get_class_string(esr));
-
-	kvm_inject_undefined(vcpu);
-	return 1;
-}
-
 /*
  * Guest access to SVE registers should be routed to this handler only
  * when the system doesn't support SVE.
@@ -373,7 +362,7 @@ static int handle_other(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static exit_handle_fn arm_exit_handlers[] = {
+exit_handle_fn arm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
 	[ESR_ELx_EC_WFx]	= kvm_handle_wfx,
 	[ESR_ELx_EC_CP15_32]	= kvm_handle_cp15_32,
@@ -404,41 +393,6 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_GCS]	= kvm_handle_gcs,
 };
 
-static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
-{
-	u64 esr = kvm_vcpu_get_esr(vcpu);
-	u8 esr_ec = ESR_ELx_EC(esr);
-
-	return arm_exit_handlers[esr_ec];
-}
-
-/*
- * We may be single-stepping an emulated instruction. If the emulation
- * has been completed in the kernel, we can return to userspace with a
- * KVM_EXIT_DEBUG, otherwise userspace needs to complete its
- * emulation first.
- */
-static int handle_trap_exceptions(struct kvm_vcpu *vcpu)
-{
-	int handled;
-
-	/*
-	 * See ARM ARM B1.14.1: "Hyp traps on instructions
-	 * that fail their condition code check"
-	 */
-	if (!kvm_condition_valid(vcpu)) {
-		kvm_incr_pc(vcpu);
-		handled = 1;
-	} else {
-		exit_handle_fn exit_handler;
-
-		exit_handler = kvm_get_exit_handler(vcpu);
-		handled = exit_handler(vcpu);
-	}
-
-	return handled;
-}
-
 /*
  * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
  * proper exit to userspace.
diff --git a/arch/arm64/kvm/trace_arm.h b/arch/arm64/kvm/trace_arm.h
index 9c60f6465c78..40c656937136 100644
--- a/arch/arm64/kvm/trace_arm.h
+++ b/arch/arm64/kvm/trace_arm.h
@@ -136,31 +136,6 @@ TRACE_EVENT(kvm_mmio_emulate,
 		  __entry->vcpu_pc, __entry->instr, __entry->cpsr)
 );
 
-TRACE_EVENT(kvm_mmio_nisv,
-	TP_PROTO(unsigned long vcpu_pc, unsigned long esr,
-		 unsigned long far, unsigned long ipa),
-	TP_ARGS(vcpu_pc, esr, far, ipa),
-
-	TP_STRUCT__entry(
-		__field(	unsigned long,	vcpu_pc		)
-		__field(	unsigned long,	esr		)
-		__field(	unsigned long,	far		)
-		__field(	unsigned long,	ipa		)
-	),
-
-	TP_fast_assign(
-		__entry->vcpu_pc		= vcpu_pc;
-		__entry->esr			= esr;
-		__entry->far			= far;
-		__entry->ipa			= ipa;
-	),
-
-	TP_printk("ipa %#016lx, esr %#016lx, far %#016lx, pc %#016lx",
-		  __entry->ipa, __entry->esr,
-		  __entry->far, __entry->vcpu_pc)
-);
-
-
 TRACE_EVENT(kvm_set_way_flush,
 	    TP_PROTO(unsigned long vcpu_pc, bool cache),
 	    TP_ARGS(vcpu_pc, cache),
diff --git a/include/kvm/arm64/guest.h b/include/kvm/arm64/guest.h
index fa67d992e8fd..ac042ed71157 100644
--- a/include/kvm/arm64/guest.h
+++ b/include/kvm/arm64/guest.h
@@ -4,7 +4,10 @@
 #define __KVM_ARM64_GUEST_H__
 
 /* Implemented by virt/kvm/arm64/guest.c */
-unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
+int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+int copy_core_reg_indices(const struct kvm_vcpu *vcpu, u64 __user *uindices);
+unsigned long num_core_regs(const struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM64_GUEST_H__ */
diff --git a/include/kvm/arm64/handle_exit.h b/include/kvm/arm64/handle_exit.h
new file mode 100644
index 000000000000..ef253e1f2cb3
--- /dev/null
+++ b/include/kvm/arm64/handle_exit.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef KVM_ARM64_HANDLE_EXIT_H
+#define KVM_ARM64_HANDLE_EXIT_H
+
+#include <linux/kvm_host.h>
+
+typedef int (*exit_handle_fn)(struct kvm_vcpu *);
+extern exit_handle_fn arm_exit_handlers[255];
+
+int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu);
+exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu);
+int handle_trap_exceptions(struct kvm_vcpu *vcpu);
+
+#endif /* KVM_ARM64_HANDLE_EXIT_H */
diff --git a/include/kvm/arm64/kvm_host.h b/include/kvm/arm64/kvm_host.h
index 3a434f47497b..21117e4fd546 100644
--- a/include/kvm/arm64/kvm_host.h
+++ b/include/kvm/arm64/kvm_host.h
@@ -28,6 +28,12 @@ struct vcpu_reset_state {
 	bool		reset;
 };
 
+/* Implemented in virt/kvm/arm64/arm.c */
+int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
+				 const struct kvm_vcpu_init *init);
+bool kvm_vcpu_init_changed(struct kvm_vcpu *vcpu,
+			   const struct kvm_vcpu_init *init);
+
 /* MMIO helpers */
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
 unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
@@ -75,6 +81,9 @@ static inline bool kvm_supports_32bit_el0(void)
 	return false;
 }
 
+/* Implemented in architecture specific code */
+unsigned long system_supported_vcpu_features(void);
+
 #define vcpu_is_protected(vcpu)		kvm_vm_is_protected((vcpu)->kvm)
 
 /*
diff --git a/virt/kvm/arm64/Makefile.kvm b/virt/kvm/arm64/Makefile.kvm
new file mode 100644
index 000000000000..ac969bf1c016
--- /dev/null
+++ b/virt/kvm/arm64/Makefile.kvm
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Kernel-based Virtual Machine modules for arm64 guests
+#
+KVM_ARM64 ?= $(KVM)/arm64
+
+shared-arm64-obj := \
+	$(KVM_ARM64)/arm.o \
+	$(KVM_ARM64)/guest.o \
+	$(KVM_ARM64)/handle_exit.o \
+	$(KVM_ARM64)/mmio.o \
+
diff --git a/virt/kvm/arm64/arm.c b/virt/kvm/arm64/arm.c
new file mode 100644
index 000000000000..b47adef65e5f
--- /dev/null
+++ b/virt/kvm/arm64/arm.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/preempt.h>
+#include <linux/kvm_host.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_mmu.h>
+
+int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
+				 const struct kvm_vcpu_init *init)
+{
+	unsigned long features = init->features[0];
+	int i;
+
+	if (features & ~KVM_VCPU_VALID_FEATURES)
+		return -ENOENT;
+
+	for (i = 1; i < ARRAY_SIZE(init->features); i++) {
+		if (init->features[i])
+			return -ENOENT;
+	}
+
+	if (features & ~system_supported_vcpu_features())
+		return -EINVAL;
+
+	/*
+	 * For now make sure that both address/generic pointer authentication
+	 * features are requested by the userspace together.
+	 */
+	if (test_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, &features) !=
+	    test_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, &features))
+		return -EINVAL;
+
+	if (!test_bit(KVM_ARM_VCPU_EL1_32BIT, &features))
+		return 0;
+
+	/* MTE is incompatible with AArch32 */
+	if (kvm_has_mte(vcpu->kvm))
+		return -EINVAL;
+
+	/* NV is incompatible with AArch32 */
+	if (test_bit(KVM_ARM_VCPU_HAS_EL2, &features))
+		return -EINVAL;
+
+	return 0;
+}
+
+bool kvm_vcpu_init_changed(struct kvm_vcpu *vcpu,
+			   const struct kvm_vcpu_init *init)
+{
+	unsigned long features = init->features[0];
+
+	return !bitmap_equal(vcpu->kvm->arch.vcpu_features, &features,
+			     KVM_VCPU_MAX_FEATURES);
+}
diff --git a/virt/kvm/arm64/guest.c b/virt/kvm/arm64/guest.c
new file mode 100644
index 000000000000..83e33e0143b9
--- /dev/null
+++ b/virt/kvm/arm64/guest.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm_host.h>
+#include <linux/kvm.h>
+#include <asm/pstate.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_nested.h>
+#include <asm/sigcontext.h>
+
+#include <kvm/arm64/guest.h>
+
+static bool core_reg_offset_is_vreg(u64 off)
+{
+	return off >= KVM_REG_ARM_CORE_REG(fp_regs.vregs) &&
+		off < KVM_REG_ARM_CORE_REG(fp_regs.fpsr);
+}
+
+static u64 core_reg_offset_from_id(u64 id)
+{
+	return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
+}
+
+static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
+{
+	int size;
+
+	switch (off) {
+	case KVM_REG_ARM_CORE_REG(regs.regs[0]) ...
+	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
+	case KVM_REG_ARM_CORE_REG(regs.sp):
+	case KVM_REG_ARM_CORE_REG(regs.pc):
+	case KVM_REG_ARM_CORE_REG(regs.pstate):
+	case KVM_REG_ARM_CORE_REG(sp_el1):
+	case KVM_REG_ARM_CORE_REG(elr_el1):
+	case KVM_REG_ARM_CORE_REG(spsr[0]) ...
+	     KVM_REG_ARM_CORE_REG(spsr[KVM_NR_SPSR - 1]):
+		size = sizeof(__u64);
+		break;
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]) ...
+	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
+		size = sizeof(__uint128_t);
+		break;
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
+	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
+		size = sizeof(__u32);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (!IS_ALIGNED(off, size / sizeof(__u32)))
+		return -EINVAL;
+
+	/*
+	 * The KVM_REG_ARM64_SVE regs must be used instead of
+	 * KVM_REG_ARM_CORE for accessing the FPSIMD V-registers on
+	 * SVE-enabled vcpus:
+	 */
+	if (vcpu_has_sve(vcpu) && core_reg_offset_is_vreg(off))
+		return -EINVAL;
+
+	return size;
+}
+
+static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	u64 off = core_reg_offset_from_id(reg->id);
+	int size = core_reg_size_from_offset(vcpu, off);
+
+	if (size < 0)
+		return NULL;
+
+	if (KVM_REG_SIZE(reg->id) != size)
+		return NULL;
+
+	switch (off) {
+	case KVM_REG_ARM_CORE_REG(regs.regs[0]) ...
+	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
+		off -= KVM_REG_ARM_CORE_REG(regs.regs[0]);
+		off /= 2;
+		return &vcpu_gp_regs(vcpu)->regs[off];
+
+	case KVM_REG_ARM_CORE_REG(regs.sp):
+		return &vcpu_gp_regs(vcpu)->sp;
+
+	case KVM_REG_ARM_CORE_REG(regs.pc):
+		return vcpu_pc(vcpu);
+
+	case KVM_REG_ARM_CORE_REG(regs.pstate):
+		return &vcpu_gp_regs(vcpu)->pstate;
+
+	case KVM_REG_ARM_CORE_REG(sp_el1):
+		return __ctxt_sys_reg(&vcpu->arch.ctxt, SP_EL1);
+
+	case KVM_REG_ARM_CORE_REG(elr_el1):
+		return __ctxt_sys_reg(&vcpu->arch.ctxt, ELR_EL1);
+
+	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_EL1]):
+		return __ctxt_sys_reg(&vcpu->arch.ctxt, SPSR_EL1);
+
+	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_ABT]):
+		return &vcpu->arch.ctxt.spsr_abt;
+
+	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_UND]):
+		return &vcpu->arch.ctxt.spsr_und;
+
+	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_IRQ]):
+		return &vcpu->arch.ctxt.spsr_irq;
+
+	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_FIQ]):
+		return &vcpu->arch.ctxt.spsr_fiq;
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]) ...
+	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
+		off -= KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]);
+		off /= 4;
+		return &vcpu->arch.ctxt.fp_regs.vregs[off];
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
+		return &vcpu->arch.ctxt.fp_regs.fpsr;
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
+		return &vcpu->arch.ctxt.fp_regs.fpcr;
+
+	default:
+		return NULL;
+	}
+}
+
+int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	/*
+	 * Because the kvm_regs structure is a mix of 32, 64 and
+	 * 128bit fields, we index it as if it was a 32bit
+	 * array. Hence below, nr_regs is the number of entries, and
+	 * off the index in the "array".
+	 */
+	__u32 __user *uaddr = (__u32 __user *)(unsigned long)reg->addr;
+	int nr_regs = sizeof(struct kvm_regs) / sizeof(__u32);
+	void *addr;
+	u32 off;
+
+	/* Our ID is an index into the kvm_regs struct. */
+	off = core_reg_offset_from_id(reg->id);
+	if (off >= nr_regs ||
+	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
+		return -ENOENT;
+
+	addr = core_reg_addr(vcpu, reg);
+	if (!addr)
+		return -EINVAL;
+
+	if (copy_to_user(uaddr, addr, KVM_REG_SIZE(reg->id)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	__u32 __user *uaddr = (__u32 __user *)(unsigned long)reg->addr;
+	int nr_regs = sizeof(struct kvm_regs) / sizeof(__u32);
+	__uint128_t tmp;
+	void *valp = &tmp, *addr;
+	u64 off;
+	int err = 0;
+
+	/* Our ID is an index into the kvm_regs struct. */
+	off = core_reg_offset_from_id(reg->id);
+	if (off >= nr_regs ||
+	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
+		return -ENOENT;
+
+	addr = core_reg_addr(vcpu, reg);
+	if (!addr)
+		return -EINVAL;
+
+	if (KVM_REG_SIZE(reg->id) > sizeof(tmp))
+		return -EINVAL;
+
+	if (copy_from_user(valp, uaddr, KVM_REG_SIZE(reg->id))) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	if (off == KVM_REG_ARM_CORE_REG(regs.pstate)) {
+		u64 mode = (*(u64 *)valp) & PSR_AA32_MODE_MASK;
+
+		switch (mode) {
+		case PSR_AA32_MODE_USR:
+			if (!kvm_supports_32bit_el0())
+				return -EINVAL;
+			break;
+		case PSR_AA32_MODE_FIQ:
+		case PSR_AA32_MODE_IRQ:
+		case PSR_AA32_MODE_SVC:
+		case PSR_AA32_MODE_ABT:
+		case PSR_AA32_MODE_UND:
+		case PSR_AA32_MODE_SYS:
+			if (!vcpu_el1_is_32bit(vcpu))
+				return -EINVAL;
+			break;
+		case PSR_MODE_EL2h:
+		case PSR_MODE_EL2t:
+			if (!vcpu_has_nv(vcpu))
+				return -EINVAL;
+			fallthrough;
+		case PSR_MODE_EL0t:
+		case PSR_MODE_EL1t:
+		case PSR_MODE_EL1h:
+			if (vcpu_el1_is_32bit(vcpu))
+				return -EINVAL;
+			break;
+		default:
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	memcpy(addr, valp, KVM_REG_SIZE(reg->id));
+
+	if (*vcpu_cpsr(vcpu) & PSR_MODE32_BIT) {
+		int i, nr_reg;
+
+		switch (*vcpu_cpsr(vcpu) & PSR_AA32_MODE_MASK) {
+		/*
+		 * Either we are dealing with user mode, and only the
+		 * first 15 registers (+ PC) must be narrowed to 32bit.
+		 * AArch32 r0-r14 conveniently map to AArch64 x0-x14.
+		 */
+		case PSR_AA32_MODE_USR:
+		case PSR_AA32_MODE_SYS:
+			nr_reg = 15;
+			break;
+
+		/*
+		 * Otherwise, this is a privileged mode, and *all* the
+		 * registers must be narrowed to 32bit.
+		 */
+		default:
+			nr_reg = 31;
+			break;
+		}
+
+		for (i = 0; i < nr_reg; i++)
+			vcpu_set_reg(vcpu, i, (u32)vcpu_get_reg(vcpu, i));
+
+		*vcpu_pc(vcpu) = (u32)*vcpu_pc(vcpu);
+	}
+out:
+	return err;
+}
+
+int copy_core_reg_indices(const struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	unsigned int i;
+	int n = 0;
+
+	for (i = 0; i < sizeof(struct kvm_regs) / sizeof(__u32); i++) {
+		u64 reg = KVM_REG_ARM64 | KVM_REG_ARM_CORE | i;
+		int size = core_reg_size_from_offset(vcpu, i);
+
+		if (size < 0)
+			continue;
+
+		switch (size) {
+		case sizeof(__u32):
+			reg |= KVM_REG_SIZE_U32;
+			break;
+
+		case sizeof(__u64):
+			reg |= KVM_REG_SIZE_U64;
+			break;
+
+		case sizeof(__uint128_t):
+			reg |= KVM_REG_SIZE_U128;
+			break;
+
+		default:
+			WARN_ON(1);
+			continue;
+		}
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+
+		n++;
+	}
+
+	return n;
+}
+
+unsigned long num_core_regs(const struct kvm_vcpu *vcpu)
+{
+	return copy_core_reg_indices(vcpu, NULL);
+}
diff --git a/virt/kvm/arm64/handle_exit.c b/virt/kvm/arm64/handle_exit.c
new file mode 100644
index 000000000000..7c2eff026d08
--- /dev/null
+++ b/virt/kvm/arm64/handle_exit.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm_host.h>
+
+#include <asm/esr.h>
+#include <asm/kvm_emulate.h>
+
+#include <kvm/arm64/handle_exit.h>
+
+int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
+{
+	u64 esr = kvm_vcpu_get_esr(vcpu);
+
+	kvm_pr_unimpl("Unknown exception class: esr: %#016llx -- %s\n",
+		      esr, esr_get_class_string(esr));
+
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
+{
+	u64 esr = kvm_vcpu_get_esr(vcpu);
+	u8 esr_ec = ESR_ELx_EC(esr);
+
+	return arm_exit_handlers[esr_ec];
+}
+
+/*
+ * We may be single-stepping an emulated instruction. If the emulation
+ * has been completed in the kernel, we can return to userspace with a
+ * KVM_EXIT_DEBUG, otherwise userspace needs to complete its
+ * emulation first.
+ */
+int handle_trap_exceptions(struct kvm_vcpu *vcpu)
+{
+	int handled;
+
+	/*
+	 * See ARM ARM B1.14.1: "Hyp traps on instructions
+	 * that fail their condition code check"
+	 */
+	if (!kvm_condition_valid(vcpu)) {
+		kvm_incr_pc(vcpu);
+		handled = 1;
+	} else {
+		exit_handle_fn exit_handler;
+
+		exit_handler = kvm_get_exit_handler(vcpu);
+		handled = exit_handler(vcpu);
+	}
+
+	return handled;
+}
diff --git a/arch/arm64/kvm/mmio.c b/virt/kvm/arm64/mmio.c
similarity index 99%
rename from arch/arm64/kvm/mmio.c
rename to virt/kvm/arm64/mmio.c
index e2285ed8c91d..438a554ec1ed 100644
--- a/arch/arm64/kvm/mmio.c
+++ b/virt/kvm/arm64/mmio.c
@@ -8,6 +8,7 @@
 #include <asm/kvm_emulate.h>
 #include <trace/events/kvm.h>
 
+#define CREATE_TRACE_POINTS
 #include "trace.h"
 
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data)
diff --git a/virt/kvm/arm64/trace.h b/virt/kvm/arm64/trace.h
new file mode 100644
index 000000000000..0814000b7749
--- /dev/null
+++ b/virt/kvm/arm64/trace.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#if !defined(__KVM_ARM64_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
+#define __KVM_ARM64_TRACE_H__
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../virt/kvm/arm64
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(kvm_mmio_nisv,
+	TP_PROTO(unsigned long vcpu_pc, unsigned long esr,
+		 unsigned long far, unsigned long ipa),
+	TP_ARGS(vcpu_pc, esr, far, ipa),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	vcpu_pc		)
+		__field(	unsigned long,	esr		)
+		__field(	unsigned long,	far		)
+		__field(	unsigned long,	ipa		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc		= vcpu_pc;
+		__entry->esr			= esr;
+		__entry->far			= far;
+		__entry->ipa			= ipa;
+	),
+
+	TP_printk("ipa %#016lx, esr %#016lx, far %#016lx, pc %#016lx",
+		  __entry->ipa, __entry->esr,
+		  __entry->far, __entry->vcpu_pc)
+);
+
+#endif /* __KVM_ARM64_TRACE_H__ */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.51.0

