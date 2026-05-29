Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B673FD973;
	Fri, 29 May 2026 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069925; cv=none; b=DKpX49HU9XfQFETYOiRSgk0bu+B0rOy6a+cv9+vHxPb6aKFaQAdtqVNloZfqLx2ZrSgd0aLBcHnnsWdY3GD1LUPknJYBahFxzgBe/sqmzs1AMXF+S8RLop9xb3Le77oI5W0rdYnlKAUQzsYyXdQpF41W3Rl4utgNm7wGhhQ/luw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069925; c=relaxed/simple;
	bh=C7XnC611ofLndvfCSiC+fbh0LKBi0YuOBsbOba6tNN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAvRAEl/T1ds7LSy9w3jF+StIQcorq28SsRCC9rNyWHMtQHM/24MBhTdYsm62h6gJAWk9rUL15LoPVWGim+C2a8ZNYCFM0W5OxyBqPeQPsejgxJsaEsl49L5dLfCXEdQ1Dr/KNSSJEf/eF8Tjjxm5HQaIXO73jvXCHrjW51QWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JYr9nqBh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JYr9nqBh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFg2Hg2776549;
	Fri, 29 May 2026 15:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kiW8sL
	1ftqpWdFqFkw028gq2paxPC8gFIVcvkHwNvyc=; b=JYr9nqBhGZsqUUxKlAkD+O
	MQIF31i23jfAuFF2oUEk01q1FyGrvEwPeqK+gCaS9lIo1lu4uYMHEpl1uNZDVYBw
	Dgufo2v1nvVVu0GEUZBNRDqBc3WFgj5qQLgkiTTOaAlCItwenzFSUIQsJRr/n01j
	Oxe760eMUbM+5bw5AElKMbt+JUJQIbn9zBBnRgDcJw+6PCe+OhzZGwmxVmPapjWL
	YBD13r7YTGgSkfxTiF11Ptmrh5cQ+TSz/Edw0Rd/mfPjV/7la2rnRguihNkw72uj
	ioxfvtiVQuCdOsVaTW1fq0ettwVQ/fb0ge6cGpujdY4LeZWJVyZI0+sgRA6VkXNA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889kw03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFd6Zm022963;
	Fri, 29 May 2026 15:51:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc8euu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TForjU29950424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:50:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7089220043;
	Fri, 29 May 2026 15:50:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1348E2004D;
	Fri, 29 May 2026 15:50:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:50:53 +0000 (GMT)
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
Subject: [PATCH v3 07/27] KVM: arm64: Provide arm64 KVM API for non-native architectures
Date: Fri, 29 May 2026 17:50:21 +0200
Message-ID: <20260529155050.2902245-8-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155050.2902245-1-seiden@linux.ibm.com>
References: <20260529155050.2902245-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ThQodedgL26P2mSR9dx3iDn7Fu8GD-kS
X-Proofpoint-GUID: ThQodedgL26P2mSR9dx3iDn7Fu8GD-kS
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a19b5e6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ToiqtPC-Cde57ptAIbMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX1l+lASkPZuCE
 kzgh4NG/7NuLIQmRM+Mz0cYd2EKzV02zZGl+D9yYrAR3JdHAF78VgZbC3nlHQuZn1C7VJM1QzCj
 AjxMVt6xOJgsMiDjqEs3GgKT6vQs+CqXlzaDmzfEsUpk1vf9j3m7bS0PLcE5Xsy4bMuV92cYHgf
 lA65GY+41WHbre1xWL9eFfLfjVidMvKk9Fx1bzB3YeoNWf+iMaGkapKnRg9D960k1NDCl+uBYwh
 6jmHEx7XQ7lVs7oYKugLFKuwCsFcudwiHpxW6PYpoqJVuxq3ELbEYVb18w1cndUegBfZdhOH1Wd
 X6U3N915NCJaO5pvjEPzz65BBlK8RJIR+OcF0PcPKwBrl/tVt+5AbFsbuevTIj5q3AWdxzvANcp
 s1XGSQXGFBVmYzgzBrUgEWnSPvcAktgILdHxdhPa2veC9oyaT8UJh5vAzmpjkOI4f77O+oS8job
 iK4VoseQfKQW6Ex2tGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

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
index f1903e4f0dcf..311fcfde9b11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14077,6 +14077,7 @@ F:	Documentation/virt/kvm/arm/
 F:	Documentation/virt/kvm/devices/arm*
 F:	arch/arm64/include/asm/kvm*
 F:	arch/arm64/include/uapi/asm/kvm*
+F:	include/kvm/arm64/
 F:	include/uapi/arch/arm64/asm/kvm*
 F:	arch/arm64/kvm/
 F:	include/kvm/arm_*
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 587507a9980e..33ef4f196380 100644
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
index 65eead8362e0..549e9a6aa12c 100644
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
 
@@ -338,35 +325,7 @@ struct kvm_arch {
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
@@ -848,13 +807,6 @@ extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
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
@@ -1059,41 +1011,6 @@ struct kvm_vcpu_arch {
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
@@ -1254,7 +1171,6 @@ struct kvm_vcpu_stat {
 };
 
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
-int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 
@@ -1338,13 +1254,6 @@ int __init populate_nv_trap_config(void);
 
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
@@ -1519,8 +1428,6 @@ struct kvm *kvm_arch_alloc_vm(void);
 
 #define kvm_vm_is_protected(kvm)	(is_protected_kvm_enabled() && (kvm)->arch.pkvm.is_protected)
 
-#define vcpu_is_protected(vcpu)		kvm_vm_is_protected((vcpu)->kvm)
-
 int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature);
 bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 01e9c72d6aa7..2a01cd89734e 100644
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
index 634ddc904244..607ac05fcb7b 100644
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
index 9453321ef8c6..04a4ef1c7f06 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -34,7 +34,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/virt.h>
-#include <asm/kvm_arm.h>
+#include <kvm/arm64/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
@@ -52,6 +52,8 @@
 
 #include <linux/irqchip/arm-gic-v5.h>
 
+#include <kvm/arm64/guest.h>
+
 #include "sys_regs.h"
 
 static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
@@ -1541,7 +1543,7 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 	return -EINVAL;
 }
 
-static unsigned long system_supported_vcpu_features(void)
+unsigned long system_supported_vcpu_features(void)
 {
 	unsigned long features = KVM_VCPU_VALID_FEATURES;
 
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index f4d7b12045e8..4ba906568c38 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -13,7 +13,7 @@
 #include <asm/arm_pmuv3.h>
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
index f337770ec459..aef2b2540bc0 100644
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
index 89cb553be1e5..e9f603c3de37 100644
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
index 4da9281312eb..f683eb18c4ec 100644
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
index 883b6c1008fb..5321911f19e0 100644
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
index 148fc3400ea8..2434bcc2d50d 100644
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
index 1d7e5d560af4..d20575e5da44 100644
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
index 5913a20d8301..daeb0ffa0471 100644
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
2.53.0

