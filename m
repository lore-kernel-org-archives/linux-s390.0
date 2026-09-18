Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42C51477D;
	Fri, 18 Sep 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738366; cv=none; b=qoLWyH+IFvO1foUXWRJ/7Nj4tX4UbsnlSwIZMv1BWc2bbQFL5hNm+vzhPJEORJ1O1Mx6EQKd4xAXKaCjJYqtcbdXCiZ7hdlqI33oDYwCKyKRUQb21hLJHelPoFKzKV3vrDmtq3WWgr4Cpy3MppIEcZGj5ubwHcYQ67wJcTuQ94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738366; c=relaxed/simple;
	bh=HR5edIySJTkJlH8V/TugMFZTnVEJDG5OrL6WugG3PVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGat6kEEzRHLriTZLA11k5ick711BjDUab7DMvnAMDLztDvJpoMTTX/KvoeCPOeqj1Q/0nbByyCA87qAmCvsQnvHUo/VzP5QA/gXYnXH8KpX7+JFlpdPAsUGe/yD7ze8AqmavfnpVQGaqCfvHtPzpY5WrA24rpvsjzXxZfvupRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=capNOPzO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="capNOPzO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1aJ2803415;
	Fri, 18 Sep 2026 13:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PJerFyzkPWj2kC6tD
	p4sQaXJPJbZR893tvs3BZgfH2o=; b=capNOPzOD1E02x62atzFqiR3/2KEAwZ4z
	4J0OEtBf2Sx0U/ybBG7MMUrtfxerwhQxaKgcpb5/3WyWyaBJzYwCkQjhY0FmOdXC
	fuIcUybcKzaa0Hmr1vDNEXz4361a4yzVnCN8WvdZLG1njSwrVc/QUHi5vmuU0Sg9
	0tzLaI4pmrqPQaP5igbLhy4Z1WFqAuEBOHoEtkFqUoNPORH7yuYNmbBd79dfu/HB
	0x0Hg4Vz30jOEPm1450FWodqYI6EXQtVAmePY4VzTU19E1zhCfZbQvqBvw9tcRn8
	E8JorFMhQS+CQXbG78kljqdSlQvYiNEdbUxzWT3OpeAeit95DIIVA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j813s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNtoF695598;
	Fri, 18 Sep 2026 13:31:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fek77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDVBB146072144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72E8320040;
	Fri, 18 Sep 2026 13:31:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C13C20049;
	Fri, 18 Sep 2026 13:31:11 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:11 +0000 (GMT)
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
Subject: [PATCH v8 09/29] KVM: Replace CONFIG_KVM_MMIO with KVM_NO_MMIO
Date: Fri, 18 Sep 2026 15:30:46 +0200
Message-ID: <20260918133107.1042730-10-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918133107.1042730-1-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX5W8eSHV56JqQ
 zxat/vZ8FLwoy1goBNurPRN9EJ59PsyrOOkWUumHTYDzkfZR+XAoS8Y823MGgNA4S2jAmffWnHt
 iwnbgXhiJ3NdGxM55EyMZDmhsHd29HxUpqR0ApeGhKmNUCIloMWAAwUjCgqNFvgn6r2huURbYxF
 cJHDAri4Uy8Abu7+2v7i1qG2LDBo9si10764Cr/f4NpE+snRN/NB68RHDlkvV5kcGIzkU84yrg/
 H0OYKsLt564IJX107rvHNzwHHfEXiHS/v4PunYXwTASbgKUwkQ/Vep6nRaAUF5KaQen52fJwKRf
 B6wXBqBCqcmBZI7MOBiPSlLVxIJWlHuPxzmk+g9gMZgJvPVuGnCm4VLi/jE/BlOBlc3iblJ9k94
 WbXjOEmnW5bP5cMVPINitbihnuSHZOkP3UE0TJEJ6Bav/WBGSgWoilTTMEwaYHuDcvuRE+ZS+ML
 B34JwO6+OO2TcHYwbPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX+wTm/+QPjKgk
 rlnuE55E97Rq1z9h1NEp8QWVqC6kWaXT4F1VkbJAVSIvy1HC3NEQIaSdRRadmT1/8n/ybj7hrBb
 7I+D1j+VtAZQk0P+XvBMCz0bFy2nN+k=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aad3d28 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=b18d5-NrEheKXPzz568A:9 a=ysjONUepx5X5FVbz:21
X-Proofpoint-ORIG-GUID: ivCGvatQpcaSTNAG3aLlm7accMHLCFra
X-Proofpoint-GUID: NFuGtSrDvcWlTIxdbTmNh1uMz78N_e67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180184

Defining KVM_MMIO is not flexible enough for multi-KVM systems where one
KVM implements MMIO but others do not. Therefore, remove KVM_MMIO from
the config space and use the macro KVM_NO_MMIO instead.
Define KVM_NO_MMIO for KVM/s390 and for selected KVM/powerpc
configurations.

coalesced_mmio.c is now always compiled&linked. However, for
architectures/configurations defining KVM_NO_MMIO this effectively
collapses to an empty object with no mmio code.

No functional changes.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/Kconfig                | 1 -
 arch/loongarch/kvm/Kconfig            | 1 -
 arch/mips/kvm/Kconfig                 | 1 -
 arch/powerpc/include/asm/kvm_host.h   | 7 +++++++
 arch/powerpc/kvm/Kconfig              | 4 ----
 arch/riscv/kvm/Kconfig                | 1 -
 arch/s390/include/asm/kvm_host_s390.h | 2 ++
 arch/x86/kvm/Kconfig                  | 1 -
 include/linux/kvm_host.h              | 2 +-
 virt/kvm/Kconfig                      | 3 ---
 virt/kvm/Makefile.kvm                 | 4 ++--
 virt/kvm/coalesced_mmio.c             | 4 ++++
 virt/kvm/coalesced_mmio.h             | 2 +-
 virt/kvm/kvm_main.c                   | 8 ++++----
 14 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 7329124deb2f..8475f32ad9e6 100644
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
diff --git a/arch/loongarch/kvm/Kconfig b/arch/loongarch/kvm/Kconfig
index a427429a2b05..fd387326d2f2 100644
--- a/arch/loongarch/kvm/Kconfig
+++ b/arch/loongarch/kvm/Kconfig
@@ -26,7 +26,6 @@ config KVM
 	select KVM_COMMON
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
-	select KVM_MMIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index c24b872afbcb..849ce7c7c4df 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -22,7 +22,6 @@ config KVM
 	select EXPORT_UASM
 	select KVM_COMMON
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
-	select KVM_MMIO
 	select KVM_GENERIC_HARDWARE_ENABLING
 	help
 	  Support for hosting Guest kernels.
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ad7c34e9b227..620f163d65a9 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -29,6 +29,13 @@
 
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
 
+#if !defined(CONFIG_KVM_BOOK3S_32_HANDLER) && \
+	!defined(CONFIG_KVM_BOOK3S_PR_POSSIBLE) && \
+	!defined(CONFIG_KVM_E500V2) && \
+	!defined(CONFIG_KVM_E500MC)
+#define KVM_NO_MMIO
+#endif
+
 #define KVM_MAX_VCPUS		NR_CPUS
 #define KVM_MAX_VCORES		NR_CPUS
 
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 1fae2de8fa68..cacc22e34afd 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -30,7 +30,6 @@ config KVM_BOOK3S_HANDLER
 config KVM_BOOK3S_32_HANDLER
 	bool
 	select KVM_BOOK3S_HANDLER
-	select KVM_MMIO
 
 config KVM_BOOK3S_64_HANDLER
 	bool
@@ -38,7 +37,6 @@ config KVM_BOOK3S_64_HANDLER
 
 config KVM_BOOK3S_PR_POSSIBLE
 	bool
-	select KVM_MMIO
 
 config KVM_BOOK3S_HV_POSSIBLE
 	bool
@@ -201,7 +199,6 @@ config KVM_E500V2
 	depends on PPC_E500 && !PPC_E500MC
 	depends on !CONTEXT_TRACKING_USER
 	select KVM
-	select KVM_MMIO
 	help
 	  Support running unmodified E500 guest kernels in virtual machines on
 	  E500v2 host processors.
@@ -216,7 +213,6 @@ config KVM_E500MC
 	depends on PPC_E500MC
 	depends on !CONTEXT_TRACKING_USER
 	select KVM
-	select KVM_MMIO
 	select KVM_BOOKE_HV
 	help
 	  Support running unmodified E500MC/E5500/E6500 guest kernels in
diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index 3cb4f8037300..2e3c4e6c1cd7 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -26,7 +26,6 @@ config KVM
 	select KVM_COMMON
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
-	select KVM_MMIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 5fd7f49d7c0d..451346f32008 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -40,6 +40,8 @@
 
 #define KVM_S390_MANAGES_S390_GUEST 1
 
+#define KVM_NO_MMIO
+
 /*
  * These seem to be used for allocating ->chip in the routing table, which we
  * don't use. 1 is as small as we can get to reduce the needed memory. If we
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index fa20f64d6a2f..82b6c91e763b 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -31,7 +31,6 @@ config KVM_X86
 	select VHOST_TASK
 	select KVM_ASYNC_PF
 	select USER_RETURN_NOTIFIER
-	select KVM_MMIO
 	select SCHED_INFO
 	select PERF_EVENTS
 	select GUEST_PERF_EVENTS
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b7bd20fc9e34..7ebc9aaaec2d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -846,7 +846,7 @@ struct kvm {
 	struct kvm_vm_stat stat;
 	struct kvm_arch arch;
 	refcount_t users_count;
-#ifdef CONFIG_KVM_MMIO
+#ifndef KVM_NO_MMIO
 	struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
 	spinlock_t ring_lock;
 	struct list_head coalesced_zones;
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 008b110ebdb7..69b47cb6526c 100644
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
index ee66d460c494..9a3b05a01c62 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -10,9 +10,9 @@ KVM_DEV_MINOR ?= KVM_MINOR
 
 ccflags-y +=-DKVM_DEV_NAME=$(KVM_DEV_NAME) -DKVM_DEV_MINOR=$(KVM_DEV_MINOR)
 
-kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
+kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o \
+	 $(KVM)/coalesced_mmio.o
 kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
-kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
 kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
 kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
 kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 6b1d90161099..d6cae6855237 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -15,6 +15,8 @@
 #include <linux/slab.h>
 #include <linux/kvm.h>
 
+#ifndef KVM_NO_MMIO
+
 #include "coalesced_mmio.h"
 
 static inline struct kvm_coalesced_mmio_dev *to_mmio(struct kvm_io_device *dev)
@@ -188,3 +190,5 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
 	 */
 	return 0;
 }
+
+#endif /* !KVM_NO_MMIO */
diff --git a/virt/kvm/coalesced_mmio.h b/virt/kvm/coalesced_mmio.h
index 36f84264ed25..bcaa34fce1e8 100644
--- a/virt/kvm/coalesced_mmio.h
+++ b/virt/kvm/coalesced_mmio.h
@@ -11,7 +11,7 @@
  *
  */
 
-#ifdef CONFIG_KVM_MMIO
+#ifndef KVM_NO_MMIO
 
 #include <linux/list.h>
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a7ce1f22b3de..32b8aad8fa2b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4061,7 +4061,7 @@ static vm_fault_t kvm_vcpu_fault(struct vm_fault *vmf)
 	else if (vmf->pgoff == KVM_PIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->arch.pio_data);
 #endif
-#ifdef CONFIG_KVM_MMIO
+#ifndef KVM_NO_MMIO
 	else if (vmf->pgoff == KVM_COALESCED_MMIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->kvm->coalesced_mmio_ring);
 #endif
@@ -4902,7 +4902,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_HALT_POLL:
 		return 1;
-#ifdef CONFIG_KVM_MMIO
+#ifndef KVM_NO_MMIO
 	case KVM_CAP_COALESCED_MMIO:
 		return KVM_COALESCED_MMIO_PAGE_OFFSET;
 	case KVM_CAP_COALESCED_PIO:
@@ -5243,7 +5243,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif
-#ifdef CONFIG_KVM_MMIO
+#ifndef KVM_NO_MMIO
 	case KVM_REGISTER_COALESCED_MMIO: {
 		struct kvm_coalesced_mmio_zone zone;
 
@@ -5578,7 +5578,7 @@ static long kvm_dev_ioctl(struct file *filp,
 #ifdef CONFIG_X86
 		r += PAGE_SIZE;    /* pio data page */
 #endif
-#ifdef CONFIG_KVM_MMIO
+#ifndef KVM_NO_MMIO
 		r += PAGE_SIZE;    /* coalesced mmio ring page */
 #endif
 		break;
-- 
2.53.0

