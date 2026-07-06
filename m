Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A314534B4;
	Mon,  6 Jul 2026 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327994; cv=none; b=u11ZugYSuJIp5xaa9fKoLawxaV2fYFVbtfRTtwVcqomXxFGf+1Kl3m6IYmbFzMfGKvR3GTAbJyp36X2aiEiYX7RfDxN4uKcGKl4caWOqxO97fCIkFeeAaWzA/Qhcy7Zv7SHK23is1qEABtSSdQGlhsaIjU/4VYHljgO52rdCKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327994; c=relaxed/simple;
	bh=qZ5xMbKfSNtfmX+oP+Ql2/t5/cY9A7ak3nV0vDFhx4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeCKdKrKpam22JOiwMXRoAwr8o4czIYF7lX1xQUzW5jd35cUU4JWCDP0hCOJoR0B6aQ/rfhYAdLDZNkasee58+U1bK0u0aGTvwktWs5aLb7yUaD43DYb8dscautuLK0ZarsIAtlRNBkF2cQdgJAtkBU3Hya6OGHcuAaLor+sA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jBW3zovj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jBW3zovj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIEBQ2197657;
	Mon, 6 Jul 2026 08:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/yQcyuyBh62+1Y5+J
	buLtGzzWfP1m9RxL1C5ZBt5Iss=; b=jBW3zovjB5Yx3lCL03rc7IJkN97R2teoi
	cZQrh5JUe4b9C6oRY6hQgJaud2sALzybIbbyq8H7+YLre2yIG3+65f7cGAC1cNOR
	BWiAdHf0Uqr5EEBOrINj93uKS4QNtPyfpOHDx21fkkRZfKDUqA815Wa5FdjWlqCW
	VFz3v/KlMwDK9iJ1sCUjTVWldFIyvg9mlqhJN50ma22gPZo1no/9IdVIViG+jFvk
	sHlpASrxYNYWrD8I8FJCa7KcGsYlWgRJkwiXxKK3tQiu0+RsNmrCJSDvPyS31shC
	j2pCLygmM6SFQqowD2lyASTqhwOp7hewP+/peYKc9wf7q5KSeHRZQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4ghev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nis7009869;
	Mon, 6 Jul 2026 08:52:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpw1b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qWNo43778368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02A5720040;
	Mon,  6 Jul 2026 08:52:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94EBC2004D;
	Mon,  6 Jul 2026 08:52:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:31 +0000 (GMT)
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
Subject: [PATCH v4 05/27] KVM: Remove KVM_MMIO as config option
Date: Mon,  6 Jul 2026 10:52:05 +0200
Message-ID: <20260706085229.979525-6-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: 8iEipEAP3wSdDWjSj84-FUWrSIdS08Y4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXwXJ4RNdWsuGK
 DifjcyZzHlHkqUKrXT1PoGEHBvtWBMmZ3xuGDjSLnxIGn/on0Gx4OYldyS19L+fDrLgtTdHYI9L
 6fwz1F7hSbcTYuwc5uKqODTxGq4wW4FooECdwiectdaGWkPF0kyrLbfTC815AboukK0mlrMazLt
 XEDntZ/YNm4pehuBZna1E71ZAFh86YBfPNyQBOHUeI/bpR6Cx1Ff/FXKIUUwRwqzIjEmkPgThT7
 foQhrzlJf0TQoywi+ShLhlo7j3m+DsJNj25WNYLsUYoPus5zeeG7hmcsnyuHag6RfnurYdBbVoU
 R80g224K8qw5DHF31dvnIe0MsBVhlKmPeB6p28kWU7kZkwT37RoTItbOgKGRrY3M0nMmBtSGwY+
 l/qTZZpZjgwvm0uIAzc8ktm4MeB6H5u4zlV2wND3umWAf8XeupNcNzDJFLb93y+5jq045OSoyfN
 5udY4vehYavPHPx5RIg==
X-Proofpoint-ORIG-GUID: 8iEipEAP3wSdDWjSj84-FUWrSIdS08Y4
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b6cd7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=8UI0e4M0uH3UOGHAWE8A:9
 a=9IkURH4LAGRwoN1D:21
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXyqSv1k4SrddO
 PYBTeyOWeEIjjoR29o6QuPz+9Xgpylx9udoFQmkPH/n45Leq+LMur2AD6MtDGbjJej3UF+nK9ZI
 vd9Ea8e/AWfZVSu8LYJLFu6hUKzVZcY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

Defining KVM_MMIO is not flexible enough for multi-KVM systems with
different Kconfig options regarding KVM_MMIO. Therefore, remove KVM_MMIO
from the config space and use the macro HAVE_KVM_MMIO instead.

Suggested-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_host.h     | 2 ++
 arch/arm64/kvm/Kconfig                | 1 -
 arch/loongarch/include/asm/kvm_host.h | 2 ++
 arch/loongarch/kvm/Kconfig            | 1 -
 arch/mips/include/asm/kvm_host.h      | 2 ++
 arch/mips/kvm/Kconfig                 | 1 -
 arch/powerpc/include/asm/kvm_host.h   | 7 +++++++
 arch/powerpc/kvm/Kconfig              | 4 ----
 arch/riscv/include/asm/kvm_host.h     | 2 ++
 arch/riscv/kvm/Kconfig                | 1 -
 arch/x86/include/asm/kvm_host.h       | 2 ++
 arch/x86/kvm/Kconfig                  | 1 -
 include/linux/kvm_host.h              | 2 +-
 virt/kvm/Kconfig                      | 3 ---
 virt/kvm/Makefile.kvm                 | 3 +--
 virt/kvm/coalesced_mmio.c             | 3 +++
 virt/kvm/coalesced_mmio.h             | 2 +-
 virt/kvm/kvm_main.c                   | 8 ++++----
 18 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index bae2c4f92ef5..245bda0fb571 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -33,6 +33,8 @@
 
 #define KVM_HALT_POLL_NS_DEFAULT 500000
 
+#define HAVE_KVM_MMIO
+
 #include <kvm/arm_vgic.h>
 #include <kvm/arm_arch_timer.h>
 #include <kvm/arm_pmu.h>
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 449154f9a485..dd138b730217 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -22,7 +22,6 @@ menuconfig KVM
 	select KVM_COMMON
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
-	select KVM_MMIO
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select VIRT_XFER_TO_GUEST_WORK
 	select KVM_VFIO
diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 23cfbecebbd7..47003a85b35a 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -27,6 +27,8 @@
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
 
+#define HAVE_KVM_MMIO
+
 /* Loongarch KVM register ids */
 #define KVM_GET_IOC_CSR_IDX(id)		((id & KVM_CSR_IDX_MASK) >> LOONGARCH_REG_SHIFT)
 #define KVM_GET_IOC_CPUCFG_IDX(id)	((id & KVM_CPUCFG_IDX_MASK) >> LOONGARCH_REG_SHIFT)
diff --git a/arch/loongarch/kvm/Kconfig b/arch/loongarch/kvm/Kconfig
index 15da2d88c0c1..f03872ba0ba8 100644
--- a/arch/loongarch/kvm/Kconfig
+++ b/arch/loongarch/kvm/Kconfig
@@ -28,7 +28,6 @@ config KVM
 	select KVM_COMMON
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
-	select KVM_MMIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index c14b10821817..e3cb7c8c9461 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -26,6 +26,8 @@
 
 #include <kvm/iodev.h>
 
+#define HAVE_KVM_MMIO
+
 /* MIPS KVM register ids */
 #define MIPS_CP0_32(_R, _S)					\
 	(KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U32 | (8 * (_R) + (_S)))
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index b1b9a1d67758..c65596fdf54f 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -22,7 +22,6 @@ config KVM
 	select EXPORT_UASM
 	select KVM_COMMON
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
-	select KVM_MMIO
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select HAVE_KVM_READONLY_MEM
 	help
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2d139c807577..92d14438e31b 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -29,6 +29,13 @@
 
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
 
+#if defined(CONFIG_KVM_BOOK3S_32_HANDLER) || \
+	defined(CONFIG_KVM_BOOK3S_PR_POSSIBLE) || \
+	defined(CONFIG_KVM_E500V2) || \
+	defined(CONFIG_KVM_E500MC)
+#define HAVE_KVM_MMIO
+#endif
+
 #define KVM_MAX_VCPUS		NR_CPUS
 #define KVM_MAX_VCORES		NR_CPUS
 
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 9a0d1c1aca6c..d97a4a51ec55 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -29,7 +29,6 @@ config KVM_BOOK3S_HANDLER
 config KVM_BOOK3S_32_HANDLER
 	bool
 	select KVM_BOOK3S_HANDLER
-	select KVM_MMIO
 
 config KVM_BOOK3S_64_HANDLER
 	bool
@@ -37,7 +36,6 @@ config KVM_BOOK3S_64_HANDLER
 
 config KVM_BOOK3S_PR_POSSIBLE
 	bool
-	select KVM_MMIO
 
 config KVM_BOOK3S_HV_POSSIBLE
 	bool
@@ -200,7 +198,6 @@ config KVM_E500V2
 	depends on PPC_E500 && !PPC_E500MC
 	depends on !CONTEXT_TRACKING_USER
 	select KVM
-	select KVM_MMIO
 	help
 	  Support running unmodified E500 guest kernels in virtual machines on
 	  E500v2 host processors.
@@ -215,7 +212,6 @@ config KVM_E500MC
 	depends on PPC_E500MC
 	depends on !CONTEXT_TRACKING_USER
 	select KVM
-	select KVM_MMIO
 	select KVM_BOOKE_HV
 	help
 	  Support running unmodified E500MC/E5500/E6500 guest kernels in
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 60017ceec9d2..38333a01e5bb 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -26,6 +26,8 @@
 #include <asm/kvm_vcpu_timer.h>
 #include <asm/kvm_vcpu_pmu.h>
 
+#define HAVE_KVM_MMIO
+
 #define KVM_MAX_VCPUS			1024
 
 #define KVM_HALT_POLL_NS_DEFAULT	500000
diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index ec2cee0a39e0..3aea8d4939d2 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -28,7 +28,6 @@ config KVM
 	select KVM_COMMON
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
-	select KVM_MMIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5f6c1ce9673b..69a374e48fe7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -46,6 +46,8 @@
 
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
 
+#define HAVE_KVM_MMIO
+
 /*
  * CONFIG_KVM_MAX_NR_VCPUS is defined iff CONFIG_KVM!=n, provide a dummy max if
  * KVM is disabled (arbitrarily use the default from CONFIG_KVM_MAX_NR_VCPUS).
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 801bf9e520db..da5d9fa8a11c 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -32,7 +32,6 @@ config KVM_X86
 	select VHOST_TASK
 	select KVM_ASYNC_PF
 	select USER_RETURN_NOTIFIER
-	select KVM_MMIO
 	select SCHED_INFO
 	select PERF_EVENTS
 	select GUEST_PERF_EVENTS
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index aa573e2530f7..f179a9230e30 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -834,7 +834,7 @@ struct kvm {
 	struct list_head ioeventfds;
 	struct kvm_vm_stat stat;
 	struct kvm_arch arch;
-#ifdef CONFIG_KVM_MMIO
+#ifdef HAVE_KVM_MMIO
 	struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
 	spinlock_t ring_lock;
 	struct list_head coalesced_zones;
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 794976b88c6f..c4a983e41765 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -40,9 +40,6 @@ config NEED_KVM_DIRTY_RING_WITH_BITMAP
 	bool
 	depends on HAVE_KVM_DIRTY_RING
 
-config KVM_MMIO
-       bool
-
 config KVM_ASYNC_PF
        bool
 
diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index d047d4cf58c9..3c27c18b49a0 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -5,9 +5,8 @@
 
 KVM ?= ../../../virt/kvm
 
-kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
+kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o $(KVM)/coalesced_mmio.o
 kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
-kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
 kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
 kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
 kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 6b1d90161099..070eba3c6534 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -12,6 +12,8 @@
 #include <kvm/iodev.h>
 
 #include <linux/kvm_host.h>
+
+#ifdef HAVE_KVM_MMIO
 #include <linux/slab.h>
 #include <linux/kvm.h>
 
@@ -188,3 +190,4 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
 	 */
 	return 0;
 }
+#endif /* ifdef HAVE_KVM_MMIO */
diff --git a/virt/kvm/coalesced_mmio.h b/virt/kvm/coalesced_mmio.h
index 36f84264ed25..a8430d41945b 100644
--- a/virt/kvm/coalesced_mmio.h
+++ b/virt/kvm/coalesced_mmio.h
@@ -11,7 +11,7 @@
  *
  */
 
-#ifdef CONFIG_KVM_MMIO
+#ifdef HAVE_KVM_MMIO
 
 #include <linux/list.h>
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dcad33cc2f25..6ac79d80e7ec 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4035,7 +4035,7 @@ static vm_fault_t kvm_vcpu_fault(struct vm_fault *vmf)
 	else if (vmf->pgoff == KVM_PIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->arch.pio_data);
 #endif
-#ifdef CONFIG_KVM_MMIO
+#ifdef HAVE_KVM_MMIO
 	else if (vmf->pgoff == KVM_COALESCED_MMIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->kvm->coalesced_mmio_ring);
 #endif
@@ -4861,7 +4861,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_HALT_POLL:
 		return 1;
-#ifdef CONFIG_KVM_MMIO
+#ifdef HAVE_KVM_MMIO
 	case KVM_CAP_COALESCED_MMIO:
 		return KVM_COALESCED_MMIO_PAGE_OFFSET;
 	case KVM_CAP_COALESCED_PIO:
@@ -5202,7 +5202,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif
-#ifdef CONFIG_KVM_MMIO
+#ifdef HAVE_KVM_MMIO
 	case KVM_REGISTER_COALESCED_MMIO: {
 		struct kvm_coalesced_mmio_zone zone;
 
@@ -5524,7 +5524,7 @@ static long kvm_dev_ioctl(struct file *filp,
 #ifdef CONFIG_X86
 		r += PAGE_SIZE;    /* pio data page */
 #endif
-#ifdef CONFIG_KVM_MMIO
+#ifdef HAVE_KVM_MMIO
 		r += PAGE_SIZE;    /* coalesced mmio ring page */
 #endif
 		break;
-- 
2.53.0

