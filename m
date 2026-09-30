Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8B5218B1;
	Wed, 30 Sep 2026 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789714; cv=none; b=NyyTPPDGAhh1uAq1Ct4N/dTeQowIH1dysccqfrUhQLTYa9PoHnbUo3rWNLFlmH2CF2xKClqsNJWMdzOMp5kkMOyw6zNsApO0h/uzrEu9DhUUYkrJhue75rox1wrcOH+CR/Pr5eS4/SnDdem+JAV9cU6jDoBanbVC+4B4gvLj4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789714; c=relaxed/simple;
	bh=PIexe2PnQF562NHGLaTvYNxdLtgGmaImXurYvUZlFQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUa67RU1hgT8v93MEMOd2JBA4xe5Yiz4JzWN6UfAAhFotphYBzCNCCR/Vu5d/LEm8KjOjBrYtIXquYDCqgjBIJkupq6l09fGvvsyWnNH1WVsHyfSASBPKZj8QttLZS3IXT4vXptszKsRYWw/IMH3qIJOQMLzBFBdbCaEMote8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oIzKBUx+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oIzKBUx+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5peB3167026;
	Wed, 30 Sep 2026 17:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=44r0A2CFOq6JReY/4
	GE3p0OlkUobo8w/rH33MZTpyE4=; b=oIzKBUx+/C6n3YeuPOuswmZiH9INESDvW
	Kh2VTS0+EXoEh2xwhDjUJ8w1fjc7SFyMSRYlA6QVH61bM5ppCs6AQ7io44J6m394
	sfdtpPmc4bZzi9/dvDRQvz59rzr/tLD3sDE7hk+0hL3wBQUlk+vDKP/sScGIeMAw
	TBGYnnmR+PNNwREk9315fnmES9mJF5/ekFM3TUukxwr8Z3Gq6K3xyHzkAT+xD59B
	ZL/itI1lgRktVO9xp+NUJhaD1nG9gp68dUXZeudRmXLdIm9KF8OWNw9W16j/6BdX
	elVqHlPKJOjSnqH1M2OwrFKIvFy4JNPog92cqUt1yGu9bYCWT1+VA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptdj5r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE37Pi2287765;
	Wed, 30 Sep 2026 17:34:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pbmjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYhW143254192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D0D92005A;
	Wed, 30 Sep 2026 17:34:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C87012004F;
	Wed, 30 Sep 2026 17:34:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:42 +0000 (GMT)
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
Subject: [PATCH v9 03/24] KVM: Replace CONFIG_KVM_MMIO with KVM_NO_MMIO
Date: Wed, 30 Sep 2026 19:34:18 +0200
Message-ID: <20260930173441.66762-4-seiden@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: DkpQcTAuSRigzjaCigPS11A0Y5C91PzQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX/i1/oh13B8zy
 1moRJaL9eLdHIetC5SHRBMcL5ouXSkZ1zLAldJW4HTVD7UW8eacpbSHp4nBBtBCGb+ZLiHHv0Rs
 xKyK2VGChW6or/3P0+dgDWFwYnGrLmKr98Sk1AjOnKdh3ZTrc2qZ765uMJwBq5ahEs8z5eWzqlt
 GKmCOCG3ZJ66+MpCWJ4TvqoiZ5rZFTxFSYZR4+RsuV5sOjQz2SjdpYRJpCbm7X8uW9vImNJh8Kh
 U+UU4bknwHjYsjHSNwce7Twz9CTWFHQH0wVN2oyoipecLBJyaZrukSi4Gk6pGnurm4ZqotnJeRU
 AZ09VouLoOtb3M/obfeHoZCvwKiUL6XLkqjFNWipWK4dRiNHWaemMhQUKEFoFI0+YlK9sZV1KhS
 PPGxCucxb5nVaVvKFOEIQGFajFhzWDYd/o8gj1FiDTKlSGCrzBG5aI6O5kk82oYAh6kkmnd925V
 orUMFtKaYSHWKyseRpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfXxhlbq1O1Svhe
 ge8pfFrmjU25z2F17S5d6FPIHaHDvYyejo8epKV7I/KemnaWvdW6LmDzuyHp/p95ru4bvbGg6dq
 /dpDPlz8QGA9aCUzqJBs12c3wGCrGek=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abd4838 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=b18d5-NrEheKXPzz568A:9 a=ysjONUepx5X5FVbz:21
X-Proofpoint-GUID: XfmX1e97HGxy-j7eR66lVM6lE0aZRDCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300068

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
index bd42c84b8b16..a653b2a73303 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -39,6 +39,8 @@
 
 #define KVM_S390_MANAGES_S390_GUEST 1
 
+#define KVM_NO_MMIO
+
 /*
  * These seem to be used for allocating ->chip in the routing table, which we
  * don't use. 1 is as small as we can get to reduce the needed memory. If we
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 294684b217bb..42e79c3c87ff 100644
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
index a0e9cc55a6a4..acdde26c739d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -847,7 +847,7 @@ struct kvm {
 	struct kvm_vm_stat stat;
 	struct kvm_arch arch;
 	refcount_t users_count;
-#ifdef CONFIG_KVM_MMIO
+#ifndef KVM_NO_MMIO
 	struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
 	spinlock_t ring_lock;
 	struct list_head coalesced_zones;
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index f3d7f66746c8..24d7dfceb828 100644
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
index b39f7b2a5f6e..ec7da5942354 100644
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
index cd2d752816ab..7fe3a3cdc84f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4086,7 +4086,7 @@ static vm_fault_t kvm_vcpu_fault(struct vm_fault *vmf)
 	else if (vmf->pgoff == KVM_PIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->arch.pio_data);
 #endif
-#ifdef CONFIG_KVM_MMIO
+#ifndef KVM_NO_MMIO
 	else if (vmf->pgoff == KVM_COALESCED_MMIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->kvm->coalesced_mmio_ring);
 #endif
@@ -4927,7 +4927,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_HALT_POLL:
 		return 1;
-#ifdef CONFIG_KVM_MMIO
+#ifndef KVM_NO_MMIO
 	case KVM_CAP_COALESCED_MMIO:
 		return KVM_COALESCED_MMIO_PAGE_OFFSET;
 	case KVM_CAP_COALESCED_PIO:
@@ -5268,7 +5268,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif
-#ifdef CONFIG_KVM_MMIO
+#ifndef KVM_NO_MMIO
 	case KVM_REGISTER_COALESCED_MMIO: {
 		struct kvm_coalesced_mmio_zone zone;
 
@@ -5597,7 +5597,7 @@ static long kvm_dev_ioctl(struct file *filp,
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

