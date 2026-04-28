Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C21441029;
	Tue, 28 Apr 2026 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392142; cv=none; b=QI4kwTKddZAS8gu2Ql9tOgFKq+pM/CzGLtj1IYNer7rbIF5nJco/skqw2ZaeMavJLI7ryh+qlTKJJgHDSKrN5N5x2LavPtE+lpQWeawntjx7+yAamKugbR3BX4+MTm4Y87tYDoI8Xv/wECo+AC2WoUtBQXHjVMcjmqQc5y1Tdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392142; c=relaxed/simple;
	bh=bdauZ4JJiRcdZyL0iYuiaJAqrs9VmlqfMyzICQW2j0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPQ/O8KxoR1MljA7l5X5lceTPF/WgraLf+Ad31/fl3eZG94etUMj8fCo+OAhLZVcwujgfigaeB1YE0neLYcnmKnNa8mQO9AgPlVQfTmhQONLQd655WTdrDMlUOhIp/5udgo4mHwg2ADd2RV51W+kfCSMqJLfIL5Ta7Gon5j8CaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c8OPByf6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c8OPByf6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6lGrS2931477;
	Tue, 28 Apr 2026 15:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nl4CNb
	6MJbTqyaTVC3EZO6BynAp5f0PyVDV5PtY8CZw=; b=c8OPByf6ZDCbFw3upI5FKt
	K5NQ/dmYKrWG+QRJAOjipxoeH9qpQRi9xbem7v0lUJrSJcAx+0ch32p7oS9zZOFn
	6rZ5cwFZVSwieaTMq+0bafdOZJzTWNAMff9He0/XbIPGIjkdBiJ6XkdDjC3Pi4HP
	+IyGKxpq9b1fvl5Z1BpKJ9fWnaBdMxebF6QV/8xO9Lcts8avvCckFmtSLJgoDSp5
	ScVqMB9X0aWqCr02q3ZQRwLT9t3Y5rXzR/V+5Nl9T4UMwzEBMrL5Qlu4Bel2Lgsv
	D1hPDWYmB2smXznvQpX0kXbVWzEeWQwKJXpSn/6hr180WpcNVkKyNB0h15G1q+Eg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44pfag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrnUG006517;
	Tue, 28 Apr 2026 15:56:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqagy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuPUx12255608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD39120043;
	Tue, 28 Apr 2026 15:56:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7176A20040;
	Tue, 28 Apr 2026 15:56:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:25 +0000 (GMT)
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
Subject: [PATCH v2 07/28] KVM: arm64: Provide arm64 KVM API for non-native architectures
Date: Tue, 28 Apr 2026 17:55:59 +0200
Message-ID: <20260428155622.1361364-8-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428155622.1361364-1-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ltbvLZrbT7Gxm66ckgvUG7O1LwuMRVAc
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0d8ae cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ToiqtPC-Cde57ptAIbMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ltbvLZrbT7Gxm66ckgvUG7O1LwuMRVAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX6psF0UyhrTm4
 XIabAQTwG8GAThkkZbvvCvMmOc+dN2pov/IGblKdEsJIhRzQ8mEnU5sBhqv1FR7VLl+/yvULkMG
 U9P2I1GxzOwJ0m9vKPoziqyA+L0z3Yr0uFdCnpGGN0jdrJagMwiS4MIjU4xAsVW5wEjkb17Tiex
 jgea6tkCn/qrtzYBv74TQs69szBer33ujVdDqb6b7qie3asNl6qQFqpdvRdX8gWxYZK7iC3UvnN
 OHWUpYZl0MQuLHdfNeLRNB7b+SZUVvzeE5atfGs7FwxrPDEEAokRhHCK4AXcqCbrIgMvoWX/YLu
 Kxbeno5foZmEYrH6zO+wbFOplwRrwscvz14HQTc6qqnbi7WcieH2vUkEQ+cY35i2Imnz8j36f1X
 mFB4b1+kMH3obFUSnisPZoBcHwDORUpGgJPuooDnHPOQbQ9NT6eLn48jxh51y1ssm4DB1iwza13
 syInpezxsGlkOw7fcyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

The KVM‑related headers are moved to include/kvm/arm64/, decoupling them from
the arm64 architecture directory. The design convention is that
architecture‑specific headers under <arch>/include/asm/ include from this
shared location, allowing non‑native hosts to consume the arm64 KVM
infrastructure without duplicating code.

This refactoring enables non-native hosts to include and utilize arm64
KVM infrastructure without duplicating code or creating architecture
specific dependencies.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 MAINTAINERS                                   |   1 +
 arch/arm64/include/asm/el2_setup.h            |   2 +-
 arch/arm64/include/asm/hardirq.h              |   2 +-
 arch/arm64/include/asm/kvm_emulate.h          |   3 +-
 arch/arm64/include/asm/kvm_host.h             |  99 +----------------
 arch/arm64/include/asm/kvm_mmu.h              |  41 +------
 arch/arm64/kernel/head.S                      |   2 +-
 arch/arm64/kernel/hyp-stub.S                  |   2 +-
 arch/arm64/kvm/arm.c                          |   6 +-
 arch/arm64/kvm/debug.c                        |   2 +-
 arch/arm64/kvm/guest.c                        |   2 +
 arch/arm64/kvm/hyp/entry.S                    |   2 +-
 arch/arm64/kvm/hyp/hyp-entry.S                |   2 +-
 arch/arm64/kvm/hyp/nvhe/host.S                |   2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S            |   2 +-
 arch/arm64/kvm/mmu.c                          |   2 +-
 arch/arm64/kvm/nested.c                       |   2 +-
 arch/arm64/kvm/reset.c                        |   2 +-
 arch/arm64/kvm/sys_regs.c                     |   2 +-
 arch/arm64/kvm/vgic/vgic-its.c                |   2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c            |   2 +-
 arch/arm64/kvm/vgic/vgic-v3-nested.c          |   2 +-
 include/kvm/arm64/guest.h                     |  10 ++
 .../asm => include/kvm/arm64}/kvm_arm.h       |   5 +-
 include/kvm/arm64/kvm_host.h                  | 105 ++++++++++++++++++
 include/kvm/arm64/kvm_mmu.h                   |  47 ++++++++
 26 files changed, 195 insertions(+), 156 deletions(-)
 create mode 100644 include/kvm/arm64/guest.h
 rename {arch/arm64/include/asm => include/kvm/arm64}/kvm_arm.h (99%)
 create mode 100644 include/kvm/arm64/kvm_host.h
 create mode 100644 include/kvm/arm64/kvm_mmu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b58399be11f7..66a19aaca9f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14004,6 +14004,7 @@ F:	Documentation/virt/kvm/arm/
 F:	Documentation/virt/kvm/devices/arm*
 F:	arch/arm64/include/asm/kvm*
 F:	arch/arm64/include/uapi/asm/kvm*
+F:	include/kvm/arm64/
 F:	include/uapi/arch/arm64/asm/kvm*
 F:	arch/arm64/kvm/
 F:	include/kvm/arm_*
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 85f4c1615472..dfe3e85759f6 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -11,7 +11,7 @@
 #error Assembly-only header
 #endif
 
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/ptrace.h>
 #include <asm/sysreg.h>
 #include <linux/irqchip/arm-gic-v3.h>
diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 77d6b8c63d4e..0eceb8ab6abb 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -10,7 +10,7 @@
 #include <linux/threads.h>
 #include <asm/barrier.h>
 #include <asm/irq.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/sysreg.h>
 
 #define ack_bad_irq ack_bad_irq
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 5bf3d7e1d92c..822f6077b107 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -16,13 +16,14 @@
 
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
-#include <asm/kvm_arm.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_nested.h>
 #include <asm/ptrace.h>
 #include <asm/cputype.h>
 #include <asm/virt.h>
 
+#include <kvm/arm64/kvm_arm.h>
+
 #define CURRENT_EL_SP_EL0_VECTOR	0x0
 #define CURRENT_EL_SP_ELx_VECTOR	0x200
 #define LOWER_EL_AArch64_VECTOR		0x400
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 70cb9cfd760a..ae9e507f2c7c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -37,25 +37,12 @@
 #include <kvm/arm_arch_timer.h>
 #include <kvm/arm_pmu.h>
 
+#include <kvm/arm64/kvm_host.h>
+
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
-#define KVM_VCPU_MAX_FEATURES 9
 #define KVM_VCPU_VALID_FEATURES	(BIT(KVM_VCPU_MAX_FEATURES) - 1)
 
-#define KVM_REQ_SLEEP \
-	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
-#define KVM_REQ_IRQ_PENDING		KVM_ARCH_REQ(1)
-#define KVM_REQ_VCPU_RESET		KVM_ARCH_REQ(2)
-#define KVM_REQ_RECORD_STEAL		KVM_ARCH_REQ(3)
-#define KVM_REQ_RELOAD_GICv4		KVM_ARCH_REQ(4)
-#define KVM_REQ_RELOAD_PMU		KVM_ARCH_REQ(5)
-#define KVM_REQ_SUSPEND			KVM_ARCH_REQ(6)
-#define KVM_REQ_RESYNC_PMU_EL0		KVM_ARCH_REQ(7)
-#define KVM_REQ_NESTED_S2_UNMAP		KVM_ARCH_REQ(8)
-#define KVM_REQ_GUEST_HYP_IRQ_PENDING	KVM_ARCH_REQ(9)
-#define KVM_REQ_MAP_L1_VNCR_EL2		KVM_ARCH_REQ(10)
-#define KVM_REQ_VGIC_PROCESS_UPDATE	KVM_ARCH_REQ(11)
-
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 				     KVM_DIRTY_LOG_INITIALLY_SET)
 
@@ -324,35 +311,7 @@ struct kvm_arch {
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
+	/* VM-wide vCPU feature set */
 	unsigned long flags;
 
 	/* VM-wide vCPU feature set */
@@ -812,13 +771,6 @@ extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
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
@@ -1020,41 +972,6 @@ struct kvm_vcpu_arch {
 /* pKVM VCPU setup completed */
 #define VCPU_PKVM_FINALIZED	__vcpu_single_flag(cflags, BIT(2))
 
-/* Exception pending */
-#define PENDING_EXCEPTION	__vcpu_single_flag(iflags, BIT(0))
-/*
- * PC increment. Overlaps with EXCEPT_MASK on purpose so that it can't
- * be set together with an exception...
- */
-#define INCREMENT_PC		__vcpu_single_flag(iflags, BIT(1))
-/* Target EL/MODE (not a single flag, but let's abuse the macro) */
-#define EXCEPT_MASK		__vcpu_single_flag(iflags, GENMASK(3, 1))
-
-/* Helpers to encode exceptions with minimum fuss */
-#define __EXCEPT_MASK_VAL	unpack_vcpu_flag(EXCEPT_MASK)
-#define __EXCEPT_SHIFT		__builtin_ctzl(__EXCEPT_MASK_VAL)
-#define __vcpu_except_flags(_f)	iflags, (_f << __EXCEPT_SHIFT), __EXCEPT_MASK_VAL
-
-/*
- * When PENDING_EXCEPTION is set, EXCEPT_MASK can take the following
- * values:
- *
- * For AArch32 EL1:
- */
-#define EXCEPT_AA32_UND		__vcpu_except_flags(0)
-#define EXCEPT_AA32_IABT	__vcpu_except_flags(1)
-#define EXCEPT_AA32_DABT	__vcpu_except_flags(2)
-/* For AArch64: */
-#define EXCEPT_AA64_EL1_SYNC	__vcpu_except_flags(0)
-#define EXCEPT_AA64_EL1_IRQ	__vcpu_except_flags(1)
-#define EXCEPT_AA64_EL1_FIQ	__vcpu_except_flags(2)
-#define EXCEPT_AA64_EL1_SERR	__vcpu_except_flags(3)
-/* For AArch64 with NV: */
-#define EXCEPT_AA64_EL2_SYNC	__vcpu_except_flags(4)
-#define EXCEPT_AA64_EL2_IRQ	__vcpu_except_flags(5)
-#define EXCEPT_AA64_EL2_FIQ	__vcpu_except_flags(6)
-#define EXCEPT_AA64_EL2_SERR	__vcpu_except_flags(7)
-
 /* Physical CPU not in supported_cpus */
 #define ON_UNSUPPORTED_CPU	__vcpu_single_flag(sflags, BIT(0))
 /* WFIT instruction trapped */
@@ -1215,7 +1132,6 @@ struct kvm_vcpu_stat {
 };
 
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
-int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 
@@ -1299,13 +1215,6 @@ int __init populate_nv_trap_config(void);
 
 void kvm_calculate_traps(struct kvm_vcpu *vcpu);
 
-/* MMIO helpers */
-void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
-unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
-
-int kvm_handle_mmio_return(struct kvm_vcpu *vcpu);
-int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
-
 /*
  * Returns true if a Performance Monitoring Interrupt (PMI), a.k.a. perf event,
  * arrived in guest context.  For arm64, any event that arrives while a vCPU is
@@ -1480,8 +1389,6 @@ struct kvm *kvm_arch_alloc_vm(void);
 
 #define kvm_vm_is_protected(kvm)	(is_protected_kvm_enabled() && (kvm)->arch.pkvm.is_protected)
 
-#define vcpu_is_protected(vcpu)		kvm_vm_is_protected((vcpu)->kvm)
-
 int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature);
 bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index d968aca0461a..6a990aa63622 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -100,6 +100,8 @@ alternative_cb_end
 #include <asm/kvm_host.h>
 #include <asm/kvm_nested.h>
 
+#include <kvm/arm64/kvm_mmu.h>
+
 void kvm_update_va_mask(struct alt_instr *alt,
 			__le32 *origptr, __le32 *updptr, int nr_inst);
 void kvm_compute_layout(void);
@@ -142,12 +144,6 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 
 extern u32 __hyp_va_bits;
 
-/*
- * We currently support using a VM-specified IPA size. For backward
- * compatibility, the default IPA size is fixed to 40bits.
- */
-#define KVM_PHYS_SHIFT	(40)
-
 #define kvm_phys_shift(mmu)		VTCR_EL2_IPA((mmu)->vtcr)
 #define kvm_phys_size(mmu)		(_AC(1, ULL) << kvm_phys_shift(mmu))
 #define kvm_phys_mask(mmu)		(kvm_phys_size(mmu) - _AC(1, ULL))
@@ -161,9 +157,6 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
 int __create_hyp_mappings(unsigned long start, unsigned long size,
 			  unsigned long phys, enum kvm_pgtable_prot prot);
 int hyp_alloc_private_va_range(size_t size, unsigned long *haddr);
-int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
-			   void __iomem **kaddr,
-			   void __iomem **haddr);
 int create_hyp_exec_mappings(phys_addr_t phys_addr, size_t size,
 			     void **haddr);
 int create_hyp_stack(phys_addr_t phys_addr, unsigned long *haddr);
@@ -178,8 +171,6 @@ void stage2_unmap_vm(struct kvm *kvm);
 int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigned long type);
 void kvm_uninit_stage2_mmu(struct kvm *kvm);
 void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu);
-int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
-			  phys_addr_t pa, unsigned long size, bool writable);
 
 int kvm_handle_guest_sea(struct kvm_vcpu *vcpu);
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu);
@@ -267,34 +258,6 @@ static inline unsigned int kvm_get_vmid_bits(void)
 
 	return get_vmid_bits(reg);
 }
-
-/*
- * We are not in the kvm->srcu critical section most of the time, so we take
- * the SRCU read lock here. Since we copy the data from the user page, we
- * can immediately drop the lock again.
- */
-static inline int kvm_read_guest_lock(struct kvm *kvm,
-				      gpa_t gpa, void *data, unsigned long len)
-{
-	int srcu_idx = srcu_read_lock(&kvm->srcu);
-	int ret = kvm_read_guest(kvm, gpa, data, len);
-
-	srcu_read_unlock(&kvm->srcu, srcu_idx);
-
-	return ret;
-}
-
-static inline int kvm_write_guest_lock(struct kvm *kvm, gpa_t gpa,
-				       const void *data, unsigned long len)
-{
-	int srcu_idx = srcu_read_lock(&kvm->srcu);
-	int ret = kvm_write_guest(kvm, gpa, data, len);
-
-	srcu_read_unlock(&kvm->srcu, srcu_idx);
-
-	return ret;
-}
-
 #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
 
 /*
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 87a822e5c4ca..853952be8021 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -25,7 +25,7 @@
 #include <asm/elf.h>
 #include <asm/image.h>
 #include <asm/kernel-pgtable.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/page.h>
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 085bc9972f6b..bf3a541fc076 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -11,7 +11,7 @@
 
 #include <asm/assembler.h>
 #include <asm/el2_setup.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/ptrace.h>
 #include <asm/virt.h>
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 410ffd41fd73..47630730260f 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -32,7 +32,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/virt.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
@@ -46,6 +46,8 @@
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_psci.h>
 
+#include <kvm/arm64/guest.h>
+
 #include "sys_regs.h"
 
 static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
@@ -1489,7 +1491,7 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 	return -EINVAL;
 }
 
-static unsigned long system_supported_vcpu_features(void)
+unsigned long system_supported_vcpu_features(void)
 {
 	unsigned long features = KVM_VCPU_VALID_FEATURES;
 
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 3ad6b7c6e4ba..349fea6e3e51 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -12,7 +12,7 @@
 
 #include <asm/debug-monitors.h>
 #include <asm/kvm_asm.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_emulate.h>
 
 static int cpu_has_spe(u64 dfr0)
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 332c453b87cf..557c380ffa37 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -27,6 +27,8 @@
 #include <asm/kvm_nested.h>
 #include <asm/sigcontext.h>
 
+#include <kvm/arm64/guest.h>
+
 #include "trace.h"
 
 const struct kvm_stats_desc kvm_vm_stats_desc[] = {
diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 11a10d8f5beb..b1694f738208 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -10,7 +10,7 @@
 #include <asm/assembler.h>
 #include <asm/fpsimdmacros.h>
 #include <asm/kvm.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_mte.h>
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 03f97d71984c..dfec4e6e5d62 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -10,7 +10,7 @@
 #include <asm/alternative.h>
 #include <asm/assembler.h>
 #include <asm/cpufeature.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/mmu.h>
 #include <asm/spectre.h>
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index eef15b374abb..3f5093387f5a 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -7,7 +7,7 @@
 #include <linux/linkage.h>
 
 #include <asm/assembler.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_ptrauth.h>
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 0d42eedc7167..8677f4da7a2f 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -11,7 +11,7 @@
 #include <asm/alternative.h>
 #include <asm/assembler.h>
 #include <asm/el2_setup.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/pgtable-hwdef.h>
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 17d64a1e11e5..e19ff77b3cd5 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -14,7 +14,7 @@
 #include <asm/acpi.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_pgtable.h>
 #include <asm/kvm_pkvm.h>
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 2c43097248b2..1a3bd7bf6bf4 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -9,7 +9,7 @@
 #include <linux/kvm_host.h>
 
 #include <asm/fixmap.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nested.h>
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index b963fd975aac..036bf2dff976 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -23,7 +23,7 @@
 #include <asm/cputype.h>
 #include <asm/fpsimd.h>
 #include <asm/ptrace.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1b4cacb6e918..a7564ee0fd15 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -24,7 +24,7 @@
 #include <asm/cputype.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 2ea9f1c7ebcd..076877db9243 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -17,7 +17,7 @@
 #include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/kvm_emulate.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_mmu.h>
 
 #include "vgic.h"
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 89edb84d1ac6..009e52a16c25 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -12,7 +12,7 @@
 #include <kvm/arm_vgic.h>
 
 #include <asm/kvm_emulate.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_mmu.h>
 
 #include "vgic.h"
diff --git a/arch/arm64/kvm/vgic/vgic-v3-nested.c b/arch/arm64/kvm/vgic/vgic-v3-nested.c
index 5c69fa615823..a2070a637f51 100644
--- a/arch/arm64/kvm/vgic/vgic-v3-nested.c
+++ b/arch/arm64/kvm/vgic/vgic-v3-nested.c
@@ -9,7 +9,7 @@
 
 #include <kvm/arm_vgic.h>
 
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_nested.h>
 
diff --git a/include/kvm/arm64/guest.h b/include/kvm/arm64/guest.h
new file mode 100644
index 000000000000..fa67d992e8fd
--- /dev/null
+++ b/include/kvm/arm64/guest.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __KVM_ARM64_GUEST_H__
+#define __KVM_ARM64_GUEST_H__
+
+/* Implemented by virt/kvm/arm64/guest.c */
+unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
+int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
+
+#endif /* __KVM_ARM64_GUEST_H__ */
diff --git a/arch/arm64/include/asm/kvm_arm.h b/include/kvm/arm64/kvm_arm.h
similarity index 99%
rename from arch/arm64/include/asm/kvm_arm.h
rename to include/kvm/arm64/kvm_arm.h
index 3f9233b5a130..b9c45e4dad72 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/include/kvm/arm64/kvm_arm.h
@@ -8,8 +8,9 @@
 #define __ARM64_KVM_ARM_H__
 
 #include <asm/esr.h>
-#include <asm/memory.h>
-#include <asm/sysreg.h>
+#include <linux/const.h>
+#include <linux/bits.h>
+#include <asm/sysreg-defs.h>
 #include <asm/types.h>
 
 /*
diff --git a/include/kvm/arm64/kvm_host.h b/include/kvm/arm64/kvm_host.h
new file mode 100644
index 000000000000..ef4f4d44ac39
--- /dev/null
+++ b/include/kvm/arm64/kvm_host.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __KVM_ARM64_KVM_HOST_H
+#define __KVM_ARM64_KVM_HOST_H
+
+#include <linux/types.h>
+
+#define KVM_VCPU_MAX_FEATURES 9
+
+#define KVM_REQ_SLEEP \
+	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+#define KVM_REQ_IRQ_PENDING		KVM_ARCH_REQ(1)
+#define KVM_REQ_VCPU_RESET		KVM_ARCH_REQ(2)
+#define KVM_REQ_RECORD_STEAL		KVM_ARCH_REQ(3)
+#define KVM_REQ_RELOAD_GICv4		KVM_ARCH_REQ(4)
+#define KVM_REQ_RELOAD_PMU		KVM_ARCH_REQ(5)
+#define KVM_REQ_SUSPEND			KVM_ARCH_REQ(6)
+#define KVM_REQ_RESYNC_PMU_EL0		KVM_ARCH_REQ(7)
+#define KVM_REQ_NESTED_S2_UNMAP		KVM_ARCH_REQ(8)
+#define KVM_REQ_GUEST_HYP_IRQ_PENDING	KVM_ARCH_REQ(9)
+#define KVM_REQ_MAP_L1_VNCR_EL2		KVM_ARCH_REQ(10)
+#define KVM_REQ_VGIC_PROCESS_UPDATE	KVM_ARCH_REQ(11)
+
+struct vcpu_reset_state {
+	unsigned long	pc;
+	unsigned long	r0;
+	bool		be;
+	bool		reset;
+};
+
+/* MMIO helpers */
+void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
+unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
+
+int kvm_handle_mmio_return(struct kvm_vcpu *vcpu);
+int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
+
+/* Exception pending */
+#define PENDING_EXCEPTION	__vcpu_single_flag(iflags, BIT(0))
+/*
+ * PC increment. Overlaps with EXCEPT_MASK on purpose so that it can't
+ * be set together with an exception...
+ */
+#define INCREMENT_PC		__vcpu_single_flag(iflags, BIT(1))
+/* Target EL/MODE (not a single flag, but let's abuse the macro) */
+#define EXCEPT_MASK		__vcpu_single_flag(iflags, GENMASK(3, 1))
+
+/* Helpers to encode exceptions with minimum fuss */
+#define __EXCEPT_MASK_VAL	unpack_vcpu_flag(EXCEPT_MASK)
+#define __EXCEPT_SHIFT		__builtin_ctzl(__EXCEPT_MASK_VAL)
+#define __vcpu_except_flags(_f)	iflags, (_f << __EXCEPT_SHIFT), __EXCEPT_MASK_VAL
+
+/*
+ * When PENDING_EXCEPTION is set, EXCEPT_MASK can take the following
+ * values:
+ *
+ * For AArch32 EL1:
+ */
+#define EXCEPT_AA32_UND		__vcpu_except_flags(0)
+#define EXCEPT_AA32_IABT	__vcpu_except_flags(1)
+#define EXCEPT_AA32_DABT	__vcpu_except_flags(2)
+/* For AArch64: */
+#define EXCEPT_AA64_EL1_SYNC	__vcpu_except_flags(0)
+#define EXCEPT_AA64_EL1_IRQ	__vcpu_except_flags(1)
+#define EXCEPT_AA64_EL1_FIQ	__vcpu_except_flags(2)
+#define EXCEPT_AA64_EL1_SERR	__vcpu_except_flags(3)
+/* For AArch64 with NV: */
+#define EXCEPT_AA64_EL2_SYNC	__vcpu_except_flags(4)
+#define EXCEPT_AA64_EL2_IRQ	__vcpu_except_flags(5)
+#define EXCEPT_AA64_EL2_FIQ	__vcpu_except_flags(6)
+#define EXCEPT_AA64_EL2_SERR	__vcpu_except_flags(7)
+
+#define vcpu_is_protected(vcpu)		kvm_vm_is_protected((vcpu)->kvm)
+
+/*
+ * If we encounter a data abort without valid instruction syndrome
+ * information, report this to user space.  User space can (and
+ * should) opt in to this feature if KVM_CAP_ARM_NISV_TO_USER is
+ * supported.
+ */
+#define KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER	0
+/* Memory Tagging Extension enabled for the guest */
+#define KVM_ARCH_FLAG_MTE_ENABLED			1
+/* At least one vCPU has ran in the VM */
+#define KVM_ARCH_FLAG_HAS_RAN_ONCE			2
+/* The vCPU feature set for the VM is configured */
+#define KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED		3
+/* PSCI SYSTEM_SUSPEND enabled for the guest */
+#define KVM_ARCH_FLAG_SYSTEM_SUSPEND_ENABLED		4
+/* VM counter offset */
+#define KVM_ARCH_FLAG_VM_COUNTER_OFFSET			5
+/* Timer PPIs made immutable */
+#define KVM_ARCH_FLAG_TIMER_PPIS_IMMUTABLE		6
+/* Initial ID reg values loaded */
+#define KVM_ARCH_FLAG_ID_REGS_INITIALIZED		7
+/* Fine-Grained UNDEF initialised */
+#define KVM_ARCH_FLAG_FGU_INITIALIZED			8
+/* SVE exposed to guest */
+#define KVM_ARCH_FLAG_GUEST_HAS_SVE			9
+/* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace */
+#define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS		10
+/* Unhandled SEAs are taken to userspace */
+#define KVM_ARCH_FLAG_EXIT_SEA				11
+
+#endif /* __KVM_ARM64_KVM_HOST_H */
diff --git a/include/kvm/arm64/kvm_mmu.h b/include/kvm/arm64/kvm_mmu.h
new file mode 100644
index 000000000000..91607105eaf6
--- /dev/null
+++ b/include/kvm/arm64/kvm_mmu.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef KVM_ARM64_KVM_MMU_H__
+#define KVM_ARM64_KVM_MMU_H__
+
+/*
+ * We currently support using a VM-specified IPA size. For backward
+ * compatibility, the default IPA size is fixed to 40bits.
+ */
+#define KVM_PHYS_SHIFT	(40)
+
+/*
+ * We are not in the kvm->srcu critical section most of the time, so we take
+ * the SRCU read lock here. Since we copy the data from the user page, we
+ * can immediately drop the lock again.
+ */
+static inline int kvm_read_guest_lock(struct kvm *kvm,
+				      gpa_t gpa, void *data, unsigned long len)
+{
+	int srcu_idx = srcu_read_lock(&kvm->srcu);
+	int ret = kvm_read_guest(kvm, gpa, data, len);
+
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+
+	return ret;
+}
+
+static inline int kvm_write_guest_lock(struct kvm *kvm, gpa_t gpa,
+				       const void *data, unsigned long len)
+{
+	int srcu_idx = srcu_read_lock(&kvm->srcu);
+	int ret = kvm_write_guest(kvm, gpa, data, len);
+
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+
+	return ret;
+}
+
+/* Implemented by each architecture */
+int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
+			  phys_addr_t pa, unsigned long size, bool writable);
+
+int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
+			   void __iomem **kaddr,
+			   void __iomem **haddr);
+
+#endif /* KVM_ARM64_KVM_MMU_H__ */
-- 
2.51.0

