Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF147A0A1;
	Tue, 28 Apr 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391869; cv=none; b=B2X8HF6ScHYw6Kb+DHzB7HGu4RCL8D/8qv0ODA8X4K77SR37MR1qMnS9v5XvRcGeoXkAVWpFhzP8eRSH1DJh5ZHTOPVhhkGjxZeIYd6qoFanBKJ97ZlveMPjZQ2/iwOOH8cBbeU7jqZeuKE3ffr+tJEP+L+WFGpEgdAisHTT5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391869; c=relaxed/simple;
	bh=tJQEO9//bGoIE8S3LLitoSMn92ig66cjjdOtQHcGxdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WclkQiYDZikJEjafdC+Zv4H2kgMpC5M2wDkPaZqA+J/xD9qsJiowMAON2a/DoTgQ+NnLUVZQNqIbRZ2L2mPKu2Ns/4Ao5fpMe9+Kao5HGtdBDTo1EX79VOH7MTtyhYgKI9A/aRKd74g7FDdY6M0BqHclGr7krY9rEFXvy1hODec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UXMZBKd1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UXMZBKd1"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SE5m0q1914783;
	Tue, 28 Apr 2026 15:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J5crHa2cOO/rg/897
	S9XrevIgzqSLyRsFhTY0f+k9r0=; b=UXMZBKd19QrJJs06UdU1G00u0OpQi8ZDr
	Yzk+Mu+PU9vQKFnSObT1VagU4H2rI+ECg+UY0cM8QPufh74fFEwiEHT/e+IEdv/M
	JZSufpuTMKgq5wo1kSPhdq0QxVTQXMbAKDmPnUEWDOC6FsXwf0sD+3Z9v/eWy1c+
	DfJBL422rOoCi8/3v8qW6WP0xFp0YiDFAX5ho1+hSwVxK6H7HJCsZ1H5Oh5g0v4d
	hEaWjlkeeu1/82EsNZzHT8ABPdfYaZVARuFCHktMvLby4fik0qUNcT/BWAWQV20l
	xf82mJGypXf3pWWsPN7JiwNLe6p6a1eFSF4q9dWQDpZ0OmfvRXjKw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb56c8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrplq027791;
	Tue, 28 Apr 2026 15:56:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamya553-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuSbp33685848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C895820040;
	Tue, 28 Apr 2026 15:56:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E5062004E;
	Tue, 28 Apr 2026 15:56:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:28 +0000 (GMT)
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
Subject: [PATCH v2 15/28] KVM: s390: Move s390 kvm code into a subdirectory
Date: Tue, 28 Apr 2026 17:56:07 +0200
Message-ID: <20260428155622.1361364-16-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428155622.1361364-1-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f0d8b2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=UdqBhROR4sx79BYIaikA:9
 a=uPtMy1UvANEdZBlQ:21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfXy99LQdK+cbK6
 AozKSSzSR1R9mmB+xwTCI6UFue/MbhCHZXL8FMc7UsWiW+PAhqD5mofTqL0HfjbzzJo9jAokWEc
 RMphLhjggN20RARlydxrKeWm1lKv2dtYEoKo+RLONZo6peH2UnaANuhiPXmjhzw909YhaRlpIno
 iapxQ/rsQzi1QkuHG+KwilTV7p7rs6X4UqTx4k5hlJm1qPu7JI9icHqcEjUEyeQC0bx2wrLxw/k
 zAghyaEVNtJuMO5Pl6MzRAcq1y1AvmmoYaLnnRIDQCZDlPMeAUReJJUoumT86LEPR35E1auKfuQ
 OpT92Vg9mwaOYpfdHOlSbzwmUbjeIJqJCOeHbYvpuZIiJxhOmvr3hR32Jffsu0Nr7JuyzMD8cpq
 +DnP7PO8Kep8HX8+vAhAzsj+u8qyFOd4nhziNA5u9tw64jGxHPRnJj1AK093RGmnABhaIqgeJNG
 5leBjgshW4MSrhRovvw==
X-Proofpoint-GUID: GwVlk7yNQqLPrN5BZjUUw7JDAqyloAb1
X-Proofpoint-ORIG-GUID: GwVlk7yNQqLPrN5BZjUUw7JDAqyloAb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

Move all the code required to run s390 KVM guests on s390 to a s390
subdirectory. Move gmap related code into a gmap directory to share gmap
code between KVM implementations. Additionally, prepare the build system
and s390-kvm headers for a second KVM implementation.

While at it, rename the main s390-kvm file from s390-kvm.{c,h} to
just s390.{c,h} to match the naming scheme of other architectures.

The module name stays kvm.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/Kconfig                             |   2 +-
 arch/s390/boot/ipl_parm.c                     |   2 +-
 arch/s390/boot/uv.c                           |   2 +-
 arch/s390/configs/debug_defconfig             |   2 +-
 arch/s390/configs/defconfig                   |   2 +-
 arch/s390/include/asm/kvm_host.h              | 750 +-----------------
 .../asm/{kvm_host.h => kvm_host_s390.h}       |   8 +-
 ...kvm_host_types.h => kvm_host_s390_types.h} |   0
 arch/s390/kernel/asm-offsets.c                |   2 +-
 arch/s390/kernel/early.c                      |   2 +-
 arch/s390/kernel/entry.S                      |  10 +-
 arch/s390/kernel/perf_event.c                 |   2 +-
 arch/s390/kvm/Kconfig                         |  35 +-
 arch/s390/kvm/Makefile                        |  11 +-
 arch/s390/kvm/gmap/Makefile                   |   5 +
 arch/s390/kvm/{ => gmap}/dat.c                |   0
 arch/s390/kvm/{ => gmap}/dat.h                |   6 +-
 arch/s390/kvm/{ => gmap}/faultin.c            |   0
 arch/s390/kvm/{ => gmap}/faultin.h            |   6 +-
 arch/s390/kvm/{ => gmap}/gmap.c               |   2 +-
 arch/s390/kvm/{ => gmap}/gmap.h               |   6 +-
 arch/s390/kvm/{ => s390}/Kconfig              |  25 +-
 arch/s390/kvm/{ => s390}/Makefile             |  10 +-
 arch/s390/kvm/{ => s390}/diag.c               |   2 +-
 arch/s390/kvm/{ => s390}/gaccess.c            |   2 +-
 arch/s390/kvm/{ => s390}/gaccess.h            |   2 +-
 arch/s390/kvm/{ => s390}/guestdbg.c           |   2 +-
 arch/s390/kvm/{ => s390}/intercept.c          |   2 +-
 arch/s390/kvm/{ => s390}/interrupt.c          |   2 +-
 arch/s390/kvm/{ => s390}/pci.c                |   2 +-
 arch/s390/kvm/{ => s390}/pci.h                |   0
 arch/s390/kvm/{ => s390}/priv.c               |   2 +-
 arch/s390/kvm/{ => s390}/pv.c                 |   2 +-
 arch/s390/kvm/{kvm-s390.c => s390/s390.c}     |   2 +-
 arch/s390/kvm/{kvm-s390.h => s390/s390.h}     |   2 +-
 arch/s390/kvm/{ => s390}/sigp.c               |   2 +-
 arch/s390/kvm/{ => s390}/trace-s390.h         |   0
 arch/s390/kvm/{ => s390}/trace.h              |   0
 arch/s390/kvm/{ => s390}/vsie.c               |   2 +-
 include/linux/kvm_host.h                      |   2 +-
 40 files changed, 62 insertions(+), 856 deletions(-)
 copy arch/s390/include/asm/{kvm_host.h => kvm_host_s390.h} (99%)
 rename arch/s390/include/asm/{kvm_host_types.h => kvm_host_s390_types.h} (100%)
 create mode 100644 arch/s390/kvm/gmap/Makefile
 rename arch/s390/kvm/{ => gmap}/dat.c (100%)
 rename arch/s390/kvm/{ => gmap}/dat.h (99%)
 rename arch/s390/kvm/{ => gmap}/faultin.c (100%)
 rename arch/s390/kvm/{ => gmap}/faultin.h (96%)
 rename arch/s390/kvm/{ => gmap}/gmap.c (99%)
 rename arch/s390/kvm/{ => gmap}/gmap.h (98%)
 copy arch/s390/kvm/{ => s390}/Kconfig (62%)
 copy arch/s390/kvm/{ => s390}/Makefile (53%)
 rename arch/s390/kvm/{ => s390}/diag.c (99%)
 rename arch/s390/kvm/{ => s390}/gaccess.c (99%)
 rename arch/s390/kvm/{ => s390}/gaccess.h (99%)
 rename arch/s390/kvm/{ => s390}/guestdbg.c (99%)
 rename arch/s390/kvm/{ => s390}/intercept.c (99%)
 rename arch/s390/kvm/{ => s390}/interrupt.c (99%)
 rename arch/s390/kvm/{ => s390}/pci.c (99%)
 rename arch/s390/kvm/{ => s390}/pci.h (100%)
 rename arch/s390/kvm/{ => s390}/priv.c (99%)
 rename arch/s390/kvm/{ => s390}/pv.c (99%)
 rename arch/s390/kvm/{kvm-s390.c => s390/s390.c} (99%)
 rename arch/s390/kvm/{kvm-s390.h => s390/s390.h} (99%)
 rename arch/s390/kvm/{ => s390}/sigp.c (99%)
 rename arch/s390/kvm/{ => s390}/trace-s390.h (100%)
 rename arch/s390/kvm/{ => s390}/trace.h (100%)
 rename arch/s390/kvm/{ => s390}/vsie.c (99%)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index edc927d9e85a..2248bf3da5df 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -837,7 +837,7 @@ config VFIO_CCW
 config VFIO_AP
 	def_tristate n
 	prompt "VFIO support for AP devices"
-	depends on KVM
+	depends on KVM_S390
 	depends on VFIO
 	depends on AP
 	select VFIO_MDEV
diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 6bc950b92be7..b8906ba7e5e8 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -300,7 +300,7 @@ void parse_boot_command_line(void)
 			stack_protector_debug = 1;
 #endif
 
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 		if (!strcmp(param, "prot_virt")) {
 			rc = kstrtobool(val, &enabled);
 			if (!rc && enabled)
diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
index 4568e8f81dac..f7b68bdcedc1 100644
--- a/arch/s390/boot/uv.c
+++ b/arch/s390/boot/uv.c
@@ -26,7 +26,7 @@ void uv_query_info(void)
 	if (uv_call(0, (uint64_t)&uvcb) && uvcb.header.rc != UVC_RC_MORE_DATA)
 		return;
 
-	if (IS_ENABLED(CONFIG_KVM)) {
+	if (IS_ENABLED(CONFIG_KVM_S390)) {
 		memcpy(uv_info.inst_calls_list, uvcb.inst_calls_list, sizeof(uv_info.inst_calls_list));
 		uv_info.uv_base_stor_len = uvcb.uv_base_stor_len;
 		uv_info.guest_base_stor_len = uvcb.conf_base_phys_stor_len;
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 98fd0a2f51c6..abea37384c77 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -59,7 +59,7 @@ CONFIG_VFIO_AP=m
 CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_S390_HYPFS_FS=y
-CONFIG_KVM=m
+CONFIG_KVM_S390=m
 CONFIG_KVM_S390_UCONTROL=y
 CONFIG_S390_UNWIND_SELFTEST=m
 CONFIG_S390_KPROBES_SANITY_TEST=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 0f4cedcab3ce..bbbb4d0df9dd 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -57,7 +57,7 @@ CONFIG_VFIO_AP=m
 CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_S390_HYPFS_FS=y
-CONFIG_KVM=m
+CONFIG_KVM_S390=m
 CONFIG_S390_UNWIND_SELFTEST=m
 CONFIG_S390_KPROBES_SANITY_TEST=m
 CONFIG_S390_MODULES_SANITY_TEST=m
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 3039c88daa63..6ff643ac0d15 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -1,756 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * definition for kernel virtual machines on s390
- *
- * Copyright IBM Corp. 2008, 2018
- *
- *    Author(s): Carsten Otte <cotte@de.ibm.com>
- */
-
 
 #ifndef ASM_KVM_HOST_H
 #define ASM_KVM_HOST_H
 
-#include <linux/types.h>
-#include <linux/hrtimer.h>
-#include <linux/interrupt.h>
-#include <linux/kvm_types.h>
-#include <linux/kvm.h>
-#include <linux/seqlock.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/mmu_notifier.h>
-#include <asm/kvm_host_types.h>
-#include <asm/debug.h>
-#include <asm/cpu.h>
-#include <asm/fpu.h>
-#include <asm/isc.h>
-#include <asm/guarded_storage.h>
-
-#define KVM_HAVE_MMU_RWLOCK
-#define KVM_MAX_VCPUS 255
-
-#define KVM_INTERNAL_MEM_SLOTS 1
-
-/*
- * These seem to be used for allocating ->chip in the routing table, which we
- * don't use. 1 is as small as we can get to reduce the needed memory. If we
- * need to look at ->chip later on, we'll need to revisit this.
- */
-#define KVM_NR_IRQCHIPS 1
-#define KVM_IRQCHIP_NUM_PINS 1
-#define KVM_HALT_POLL_NS_DEFAULT 50000
-
-/* s390-specific vcpu->requests bit members */
-#define KVM_REQ_ENABLE_IBS	KVM_ARCH_REQ(0)
-#define KVM_REQ_DISABLE_IBS	KVM_ARCH_REQ(1)
-#define KVM_REQ_ICPT_OPEREXC	KVM_ARCH_REQ(2)
-#define KVM_REQ_START_MIGRATION KVM_ARCH_REQ(3)
-#define KVM_REQ_STOP_MIGRATION  KVM_ARCH_REQ(4)
-#define KVM_REQ_VSIE_RESTART	KVM_ARCH_REQ(5)
-#define KVM_REQ_REFRESH_GUEST_PREFIX	\
-	KVM_ARCH_REQ_FLAGS(6, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
-
-struct kvm_vcpu_stat {
-	struct kvm_vcpu_stat_generic generic;
-	u64 exit_userspace;
-	u64 exit_null;
-	u64 exit_external_request;
-	u64 exit_io_request;
-	u64 exit_external_interrupt;
-	u64 exit_stop_request;
-	u64 exit_validity;
-	u64 exit_instruction;
-	u64 exit_pei;
-	u64 halt_no_poll_steal;
-	u64 instruction_lctl;
-	u64 instruction_lctlg;
-	u64 instruction_stctl;
-	u64 instruction_stctg;
-	u64 exit_program_interruption;
-	u64 exit_instr_and_program;
-	u64 exit_operation_exception;
-	u64 deliver_ckc;
-	u64 deliver_cputm;
-	u64 deliver_external_call;
-	u64 deliver_emergency_signal;
-	u64 deliver_service_signal;
-	u64 deliver_virtio;
-	u64 deliver_stop_signal;
-	u64 deliver_prefix_signal;
-	u64 deliver_restart_signal;
-	u64 deliver_program;
-	u64 deliver_io;
-	u64 deliver_machine_check;
-	u64 exit_wait_state;
-	u64 inject_ckc;
-	u64 inject_cputm;
-	u64 inject_external_call;
-	u64 inject_emergency_signal;
-	u64 inject_mchk;
-	u64 inject_pfault_init;
-	u64 inject_program;
-	u64 inject_restart;
-	u64 inject_set_prefix;
-	u64 inject_stop_signal;
-	u64 instruction_epsw;
-	u64 instruction_gs;
-	u64 instruction_io_other;
-	u64 instruction_lpsw;
-	u64 instruction_lpswe;
-	u64 instruction_lpswey;
-	u64 instruction_pfmf;
-	u64 instruction_ptff;
-	u64 instruction_sck;
-	u64 instruction_sckpf;
-	u64 instruction_stidp;
-	u64 instruction_spx;
-	u64 instruction_stpx;
-	u64 instruction_stap;
-	u64 instruction_iske;
-	u64 instruction_ri;
-	u64 instruction_rrbe;
-	u64 instruction_sske;
-	u64 instruction_ipte_interlock;
-	u64 instruction_stsi;
-	u64 instruction_stfl;
-	u64 instruction_tb;
-	u64 instruction_tpi;
-	u64 instruction_tprot;
-	u64 instruction_tsch;
-	u64 instruction_sie;
-	u64 instruction_essa;
-	u64 instruction_sthyi;
-	u64 instruction_sigp_sense;
-	u64 instruction_sigp_sense_running;
-	u64 instruction_sigp_external_call;
-	u64 instruction_sigp_emergency;
-	u64 instruction_sigp_cond_emergency;
-	u64 instruction_sigp_start;
-	u64 instruction_sigp_stop;
-	u64 instruction_sigp_stop_store_status;
-	u64 instruction_sigp_store_status;
-	u64 instruction_sigp_store_adtl_status;
-	u64 instruction_sigp_arch;
-	u64 instruction_sigp_prefix;
-	u64 instruction_sigp_restart;
-	u64 instruction_sigp_init_cpu_reset;
-	u64 instruction_sigp_cpu_reset;
-	u64 instruction_sigp_unknown;
-	u64 instruction_diagnose_10;
-	u64 instruction_diagnose_44;
-	u64 instruction_diagnose_9c;
-	u64 diag_9c_ignored;
-	u64 diag_9c_forward;
-	u64 instruction_diagnose_258;
-	u64 instruction_diagnose_308;
-	u64 instruction_diagnose_500;
-	u64 instruction_diagnose_other;
-	u64 pfault_sync;
-	u64 signal_exits;
-};
-
-#define PGM_OPERATION			0x01
-#define PGM_PRIVILEGED_OP		0x02
-#define PGM_EXECUTE			0x03
-#define PGM_PROTECTION			0x04
-#define PGM_ADDRESSING			0x05
-#define PGM_SPECIFICATION		0x06
-#define PGM_DATA			0x07
-#define PGM_FIXED_POINT_OVERFLOW	0x08
-#define PGM_FIXED_POINT_DIVIDE		0x09
-#define PGM_DECIMAL_OVERFLOW		0x0a
-#define PGM_DECIMAL_DIVIDE		0x0b
-#define PGM_HFP_EXPONENT_OVERFLOW	0x0c
-#define PGM_HFP_EXPONENT_UNDERFLOW	0x0d
-#define PGM_HFP_SIGNIFICANCE		0x0e
-#define PGM_HFP_DIVIDE			0x0f
-#define PGM_SEGMENT_TRANSLATION		0x10
-#define PGM_PAGE_TRANSLATION		0x11
-#define PGM_TRANSLATION_SPEC		0x12
-#define PGM_SPECIAL_OPERATION		0x13
-#define PGM_OPERAND			0x15
-#define PGM_TRACE_TABEL			0x16
-#define PGM_VECTOR_PROCESSING		0x1b
-#define PGM_SPACE_SWITCH		0x1c
-#define PGM_HFP_SQUARE_ROOT		0x1d
-#define PGM_PC_TRANSLATION_SPEC		0x1f
-#define PGM_AFX_TRANSLATION		0x20
-#define PGM_ASX_TRANSLATION		0x21
-#define PGM_LX_TRANSLATION		0x22
-#define PGM_EX_TRANSLATION		0x23
-#define PGM_PRIMARY_AUTHORITY		0x24
-#define PGM_SECONDARY_AUTHORITY		0x25
-#define PGM_LFX_TRANSLATION		0x26
-#define PGM_LSX_TRANSLATION		0x27
-#define PGM_ALET_SPECIFICATION		0x28
-#define PGM_ALEN_TRANSLATION		0x29
-#define PGM_ALE_SEQUENCE		0x2a
-#define PGM_ASTE_VALIDITY		0x2b
-#define PGM_ASTE_SEQUENCE		0x2c
-#define PGM_EXTENDED_AUTHORITY		0x2d
-#define PGM_LSTE_SEQUENCE		0x2e
-#define PGM_ASTE_INSTANCE		0x2f
-#define PGM_STACK_FULL			0x30
-#define PGM_STACK_EMPTY			0x31
-#define PGM_STACK_SPECIFICATION		0x32
-#define PGM_STACK_TYPE			0x33
-#define PGM_STACK_OPERATION		0x34
-#define PGM_ASCE_TYPE			0x38
-#define PGM_REGION_FIRST_TRANS		0x39
-#define PGM_REGION_SECOND_TRANS		0x3a
-#define PGM_REGION_THIRD_TRANS		0x3b
-#define PGM_SECURE_STORAGE_ACCESS	0x3d
-#define PGM_NON_SECURE_STORAGE_ACCESS	0x3e
-#define PGM_SECURE_STORAGE_VIOLATION	0x3f
-#define PGM_MONITOR			0x40
-#define PGM_PER				0x80
-#define PGM_CRYPTO_OPERATION		0x119
-
-/* irq types in ascend order of priorities */
-enum irq_types {
-	IRQ_PEND_SET_PREFIX = 0,
-	IRQ_PEND_RESTART,
-	IRQ_PEND_SIGP_STOP,
-	IRQ_PEND_IO_ISC_7,
-	IRQ_PEND_IO_ISC_6,
-	IRQ_PEND_IO_ISC_5,
-	IRQ_PEND_IO_ISC_4,
-	IRQ_PEND_IO_ISC_3,
-	IRQ_PEND_IO_ISC_2,
-	IRQ_PEND_IO_ISC_1,
-	IRQ_PEND_IO_ISC_0,
-	IRQ_PEND_VIRTIO,
-	IRQ_PEND_PFAULT_DONE,
-	IRQ_PEND_PFAULT_INIT,
-	IRQ_PEND_EXT_HOST,
-	IRQ_PEND_EXT_SERVICE,
-	IRQ_PEND_EXT_SERVICE_EV,
-	IRQ_PEND_EXT_TIMING,
-	IRQ_PEND_EXT_CPU_TIMER,
-	IRQ_PEND_EXT_CLOCK_COMP,
-	IRQ_PEND_EXT_EXTERNAL,
-	IRQ_PEND_EXT_EMERGENCY,
-	IRQ_PEND_EXT_MALFUNC,
-	IRQ_PEND_EXT_IRQ_KEY,
-	IRQ_PEND_MCHK_REP,
-	IRQ_PEND_PROG,
-	IRQ_PEND_SVC,
-	IRQ_PEND_MCHK_EX,
-	IRQ_PEND_COUNT
-};
-
-/* We have 2M for virtio device descriptor pages. Smallest amount of
- * memory per page is 24 bytes (1 queue), so (2048*1024) / 24 = 87381
- */
-#define KVM_S390_MAX_VIRTIO_IRQS 87381
-
-/*
- * Repressible (non-floating) machine check interrupts
- * subclass bits in MCIC
- */
-#define MCHK_EXTD_BIT 58
-#define MCHK_DEGR_BIT 56
-#define MCHK_WARN_BIT 55
-#define MCHK_REP_MASK ((1UL << MCHK_DEGR_BIT) | \
-		       (1UL << MCHK_EXTD_BIT) | \
-		       (1UL << MCHK_WARN_BIT))
-
-/* Exigent machine check interrupts subclass bits in MCIC */
-#define MCHK_SD_BIT 63
-#define MCHK_PD_BIT 62
-#define MCHK_EX_MASK ((1UL << MCHK_SD_BIT) | (1UL << MCHK_PD_BIT))
-
-#define IRQ_PEND_EXT_MASK ((1UL << IRQ_PEND_EXT_IRQ_KEY)    | \
-			   (1UL << IRQ_PEND_EXT_CLOCK_COMP) | \
-			   (1UL << IRQ_PEND_EXT_CPU_TIMER)  | \
-			   (1UL << IRQ_PEND_EXT_MALFUNC)    | \
-			   (1UL << IRQ_PEND_EXT_EMERGENCY)  | \
-			   (1UL << IRQ_PEND_EXT_EXTERNAL)   | \
-			   (1UL << IRQ_PEND_EXT_TIMING)     | \
-			   (1UL << IRQ_PEND_EXT_HOST)       | \
-			   (1UL << IRQ_PEND_EXT_SERVICE)    | \
-			   (1UL << IRQ_PEND_EXT_SERVICE_EV) | \
-			   (1UL << IRQ_PEND_VIRTIO)         | \
-			   (1UL << IRQ_PEND_PFAULT_INIT)    | \
-			   (1UL << IRQ_PEND_PFAULT_DONE))
-
-#define IRQ_PEND_IO_MASK ((1UL << IRQ_PEND_IO_ISC_0) | \
-			  (1UL << IRQ_PEND_IO_ISC_1) | \
-			  (1UL << IRQ_PEND_IO_ISC_2) | \
-			  (1UL << IRQ_PEND_IO_ISC_3) | \
-			  (1UL << IRQ_PEND_IO_ISC_4) | \
-			  (1UL << IRQ_PEND_IO_ISC_5) | \
-			  (1UL << IRQ_PEND_IO_ISC_6) | \
-			  (1UL << IRQ_PEND_IO_ISC_7))
-
-#define IRQ_PEND_MCHK_MASK ((1UL << IRQ_PEND_MCHK_REP) | \
-			    (1UL << IRQ_PEND_MCHK_EX))
-
-#define IRQ_PEND_EXT_II_MASK ((1UL << IRQ_PEND_EXT_CPU_TIMER)  | \
-			      (1UL << IRQ_PEND_EXT_CLOCK_COMP) | \
-			      (1UL << IRQ_PEND_EXT_EMERGENCY)  | \
-			      (1UL << IRQ_PEND_EXT_EXTERNAL)   | \
-			      (1UL << IRQ_PEND_EXT_SERVICE)    | \
-			      (1UL << IRQ_PEND_EXT_SERVICE_EV))
-
-struct kvm_s390_interrupt_info {
-	struct list_head list;
-	u64	type;
-	union {
-		struct kvm_s390_io_info io;
-		struct kvm_s390_ext_info ext;
-		struct kvm_s390_pgm_info pgm;
-		struct kvm_s390_emerg_info emerg;
-		struct kvm_s390_extcall_info extcall;
-		struct kvm_s390_prefix_info prefix;
-		struct kvm_s390_stop_info stop;
-		struct kvm_s390_mchk_info mchk;
-	};
-};
-
-struct kvm_s390_irq_payload {
-	struct kvm_s390_io_info io;
-	struct kvm_s390_ext_info ext;
-	struct kvm_s390_pgm_info pgm;
-	struct kvm_s390_emerg_info emerg;
-	struct kvm_s390_extcall_info extcall;
-	struct kvm_s390_prefix_info prefix;
-	struct kvm_s390_stop_info stop;
-	struct kvm_s390_mchk_info mchk;
-};
-
-struct kvm_s390_local_interrupt {
-	spinlock_t lock;
-	DECLARE_BITMAP(sigp_emerg_pending, KVM_MAX_VCPUS);
-	struct kvm_s390_irq_payload irq;
-	unsigned long pending_irqs;
-};
-
-#define FIRQ_LIST_IO_ISC_0 0
-#define FIRQ_LIST_IO_ISC_1 1
-#define FIRQ_LIST_IO_ISC_2 2
-#define FIRQ_LIST_IO_ISC_3 3
-#define FIRQ_LIST_IO_ISC_4 4
-#define FIRQ_LIST_IO_ISC_5 5
-#define FIRQ_LIST_IO_ISC_6 6
-#define FIRQ_LIST_IO_ISC_7 7
-#define FIRQ_LIST_PFAULT   8
-#define FIRQ_LIST_VIRTIO   9
-#define FIRQ_LIST_COUNT   10
-#define FIRQ_CNTR_IO       0
-#define FIRQ_CNTR_SERVICE  1
-#define FIRQ_CNTR_VIRTIO   2
-#define FIRQ_CNTR_PFAULT   3
-#define FIRQ_MAX_COUNT     4
-
-/* mask the AIS mode for a given ISC */
-#define AIS_MODE_MASK(isc) (0x80 >> isc)
-
-#define KVM_S390_AIS_MODE_ALL    0
-#define KVM_S390_AIS_MODE_SINGLE 1
-
-struct kvm_s390_float_interrupt {
-	unsigned long pending_irqs;
-	unsigned long masked_irqs;
-	spinlock_t lock;
-	struct list_head lists[FIRQ_LIST_COUNT];
-	int counters[FIRQ_MAX_COUNT];
-	struct kvm_s390_mchk_info mchk;
-	struct kvm_s390_ext_info srv_signal;
-	int last_sleep_cpu;
-	struct mutex ais_lock;
-	u8 simm;
-	u8 nimm;
-};
-
-struct kvm_hw_wp_info_arch {
-	unsigned long addr;
-	unsigned long phys_addr;
-	int len;
-	char *old_data;
-};
-
-struct kvm_hw_bp_info_arch {
-	unsigned long addr;
-	int len;
-};
-
-/*
- * Only the upper 16 bits of kvm_guest_debug->control are arch specific.
- * Further KVM_GUESTDBG flags which an be used from userspace can be found in
- * arch/s390/include/uapi/asm/kvm.h
- */
-#define KVM_GUESTDBG_EXIT_PENDING 0x10000000
-
-#define guestdbg_enabled(vcpu) \
-		(vcpu->guest_debug & KVM_GUESTDBG_ENABLE)
-#define guestdbg_sstep_enabled(vcpu) \
-		(vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
-#define guestdbg_hw_bp_enabled(vcpu) \
-		(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
-#define guestdbg_exit_pending(vcpu) (guestdbg_enabled(vcpu) && \
-		(vcpu->guest_debug & KVM_GUESTDBG_EXIT_PENDING))
-
-#define KVM_GUESTDBG_VALID_MASK \
-		(KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP |\
-		KVM_GUESTDBG_USE_HW_BP | KVM_GUESTDBG_EXIT_PENDING)
-
-struct kvm_guestdbg_info_arch {
-	unsigned long cr0;
-	unsigned long cr9;
-	unsigned long cr10;
-	unsigned long cr11;
-	struct kvm_hw_bp_info_arch *hw_bp_info;
-	struct kvm_hw_wp_info_arch *hw_wp_info;
-	int nr_hw_bp;
-	int nr_hw_wp;
-	unsigned long last_bp;
-};
-
-struct kvm_s390_pv_vcpu {
-	u64 handle;
-	unsigned long stor_base;
-};
-
-struct kvm_vcpu_arch {
-	struct kvm_s390_sie_block *sie_block;
-	/* if vsie is active, currently executed shadow sie control block */
-	struct kvm_s390_sie_block *vsie_block;
-	unsigned int      host_acrs[NUM_ACRS];
-	struct gs_cb      *host_gscb;
-	struct kvm_s390_local_interrupt local_int;
-	struct hrtimer    ckc_timer;
-	struct kvm_s390_pgm_info pgm;
-	struct gmap *gmap;
-	struct kvm_guestdbg_info_arch guestdbg;
-	unsigned long pfault_token;
-	unsigned long pfault_select;
-	unsigned long pfault_compare;
-	bool cputm_enabled;
-	/*
-	 * The seqcount protects updates to cputm_start and sie_block.cputm,
-	 * this way we can have non-blocking reads with consistent values.
-	 * Only the owning VCPU thread (vcpu->cpu) is allowed to change these
-	 * values and to start/stop/enable/disable cpu timer accounting.
-	 */
-	seqcount_t cputm_seqcount;
-	__u64 cputm_start;
-	bool gs_enabled;
-	bool skey_enabled;
-	/* Indicator if the access registers have been loaded from guest */
-	bool acrs_loaded;
-	struct kvm_s390_pv_vcpu pv;
-	union diag318_info diag318_info;
-	struct kvm_s390_mmu_cache *mc;
-};
-
-struct kvm_vm_stat {
-	struct kvm_vm_stat_generic generic;
-	u64 inject_io;
-	u64 inject_float_mchk;
-	u64 inject_pfault_done;
-	u64 inject_service_signal;
-	u64 inject_virtio;
-	u64 aen_forward;
-	u64 gmap_shadow_create;
-	u64 gmap_shadow_reuse;
-	u64 gmap_shadow_r1_entry;
-	u64 gmap_shadow_r2_entry;
-	u64 gmap_shadow_r3_entry;
-	u64 gmap_shadow_sg_entry;
-	u64 gmap_shadow_pg_entry;
-};
-
-struct kvm_arch_memory_slot {
-};
-
-struct s390_map_info {
-	struct list_head list;
-	__u64 guest_addr;
-	__u64 addr;
-	struct page *page;
-};
-
-struct s390_io_adapter {
-	unsigned int id;
-	int isc;
-	bool maskable;
-	bool masked;
-	bool swap;
-	bool suppressible;
-};
-
-#define MAX_S390_IO_ADAPTERS ((MAX_ISC + 1) * 8)
-#define MAX_S390_ADAPTER_MAPS 256
-
-/* maximum size of facilities and facility mask is 2k bytes */
-#define S390_ARCH_FAC_LIST_SIZE_BYTE (1<<11)
-#define S390_ARCH_FAC_LIST_SIZE_U64 \
-	(S390_ARCH_FAC_LIST_SIZE_BYTE / sizeof(u64))
-#define S390_ARCH_FAC_MASK_SIZE_BYTE S390_ARCH_FAC_LIST_SIZE_BYTE
-#define S390_ARCH_FAC_MASK_SIZE_U64 \
-	(S390_ARCH_FAC_MASK_SIZE_BYTE / sizeof(u64))
-
-struct kvm_s390_cpu_model {
-	/* facility mask supported by kvm & hosting machine */
-	__u64 fac_mask[S390_ARCH_FAC_MASK_SIZE_U64];
-	struct kvm_s390_vm_cpu_subfunc subfuncs;
-	/* facility list requested by guest (in dma page) */
-	__u64 *fac_list;
-	u64 cpuid;
-	unsigned short ibc;
-	/* subset of available UV-features for pv-guests enabled by user space */
-	struct kvm_s390_vm_cpu_uv_feat uv_feat_guest;
-};
-
-typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
-
-struct kvm_s390_crypto {
-	struct kvm_s390_crypto_cb *crycb;
-	struct rw_semaphore pqap_hook_rwsem;
-	crypto_hook *pqap_hook;
-	__u32 crycbd;
-	__u8 aes_kw;
-	__u8 dea_kw;
-	__u8 apie;
-};
-
-#define APCB0_MASK_SIZE 1
-struct kvm_s390_apcb0 {
-	__u64 apm[APCB0_MASK_SIZE];		/* 0x0000 */
-	__u64 aqm[APCB0_MASK_SIZE];		/* 0x0008 */
-	__u64 adm[APCB0_MASK_SIZE];		/* 0x0010 */
-	__u64 reserved18;			/* 0x0018 */
-};
-
-#define APCB1_MASK_SIZE 4
-struct kvm_s390_apcb1 {
-	__u64 apm[APCB1_MASK_SIZE];		/* 0x0000 */
-	__u64 aqm[APCB1_MASK_SIZE];		/* 0x0020 */
-	__u64 adm[APCB1_MASK_SIZE];		/* 0x0040 */
-	__u64 reserved60[4];			/* 0x0060 */
-};
-
-struct kvm_s390_crypto_cb {
-	struct kvm_s390_apcb0 apcb0;		/* 0x0000 */
-	__u8   reserved20[0x0048 - 0x0020];	/* 0x0020 */
-	__u8   dea_wrapping_key_mask[24];	/* 0x0048 */
-	__u8   aes_wrapping_key_mask[32];	/* 0x0060 */
-	struct kvm_s390_apcb1 apcb1;		/* 0x0080 */
-};
-
-struct kvm_s390_gisa {
-	union {
-		struct { /* common to all formats */
-			u32 next_alert;
-			u8  ipm;
-			u8  reserved01[2];
-			u8  iam;
-		};
-		struct { /* format 0 */
-			u32 next_alert;
-			u8  ipm;
-			u8  reserved01;
-			u8  : 6;
-			u8  g : 1;
-			u8  c : 1;
-			u8  iam;
-			u8  reserved02[4];
-			u32 airq_count;
-		} g0;
-		struct { /* format 1 */
-			u32 next_alert;
-			u8  ipm;
-			u8  simm;
-			u8  nimm;
-			u8  iam;
-			u8  aism[8];
-			u8  : 6;
-			u8  g : 1;
-			u8  c : 1;
-			u8  reserved03[11];
-			u32 airq_count;
-		} g1;
-		struct {
-			u64 word[4];
-		} u64;
-	};
-};
-
-struct kvm_s390_gib {
-	u32 alert_list_origin;
-	u32 reserved01;
-	u8:5;
-	u8  nisc:3;
-	u8  reserved03[3];
-	u32 reserved04[5];
-};
-
-/*
- * sie_page2 has to be allocated as DMA because fac_list, crycb and
- * gisa need 31bit addresses in the sie control block.
- */
-struct sie_page2 {
-	__u64 fac_list[S390_ARCH_FAC_LIST_SIZE_U64];	/* 0x0000 */
-	struct kvm_s390_crypto_cb crycb;		/* 0x0800 */
-	struct kvm_s390_gisa gisa;			/* 0x0900 */
-	struct kvm *kvm;				/* 0x0920 */
-	u8 reserved928[0x1000 - 0x928];			/* 0x0928 */
-};
-
-struct vsie_page;
-
-struct kvm_s390_vsie {
-	struct mutex mutex;
-	struct radix_tree_root addr_to_page;
-	int page_count;
-	int next;
-	struct vsie_page *pages[KVM_MAX_VCPUS];
-};
-
-struct kvm_s390_gisa_iam {
-	u8 mask;
-	spinlock_t ref_lock;
-	u32 ref_count[MAX_ISC + 1];
-};
-
-struct kvm_s390_gisa_interrupt {
-	struct kvm_s390_gisa *origin;
-	struct kvm_s390_gisa_iam alert;
-	struct hrtimer timer;
-	u64 expires;
-	DECLARE_BITMAP(kicked_mask, KVM_MAX_VCPUS);
-};
-
-struct kvm_s390_pv {
-	u64 handle;
-	u64 guest_len;
-	unsigned long stor_base;
-	void *stor_var;
-	bool dumping;
-	void *set_aside;
-	struct list_head need_cleanup;
-	struct mmu_notifier mmu_notifier;
-	/* Protects against concurrent import-like operations */
-	struct mutex import_lock;
-};
-
-struct kvm_s390_mmu_cache;
-
-struct kvm_arch {
-	struct esca_block *sca;
-	debug_info_t *dbf;
-	struct kvm_s390_float_interrupt float_int;
-	struct kvm_device *flic;
-	struct gmap *gmap;
-	unsigned long mem_limit;
-	int css_support;
-	int use_irqchip;
-	int use_cmma;
-	int use_pfmfi;
-	int use_skf;
-	int use_zpci_interp;
-	int user_cpu_state_ctrl;
-	int user_sigp;
-	int user_stsi;
-	int user_instr0;
-	int user_operexec;
-	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
-	wait_queue_head_t ipte_wq;
-	int ipte_lock_count;
-	struct mutex ipte_mutex;
-	spinlock_t start_stop_lock;
-	struct sie_page2 *sie_page2;
-	struct kvm_s390_cpu_model model;
-	struct kvm_s390_crypto crypto;
-	struct kvm_s390_vsie vsie;
-	u8 epdx;
-	u64 epoch;
-	int migration_mode;
-	atomic64_t cmma_dirty_pages;
-	/* subset of available cpu features enabled by user space */
-	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
-	/* indexed by vcpu_idx */
-	DECLARE_BITMAP(idle_mask, KVM_MAX_VCPUS);
-	struct kvm_s390_gisa_interrupt gisa_int;
-	struct kvm_s390_pv pv;
-	struct list_head kzdev_list;
-	spinlock_t kzdev_list_lock;
-	struct kvm_s390_mmu_cache *mc;
-};
-
-#define KVM_HVA_ERR_BAD		(-1UL)
-#define KVM_HVA_ERR_RO_BAD	(-2UL)
-
-static inline bool kvm_is_error_hva(unsigned long addr)
-{
-	return IS_ERR_VALUE(addr);
-}
-
-#define ASYNC_PF_PER_VCPU	64
-struct kvm_arch_async_pf {
-	unsigned long pfault_token;
-};
-
-bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu);
-
-void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
-			       struct kvm_async_pf *work);
-
-bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
-				     struct kvm_async_pf *work);
-
-void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
-				 struct kvm_async_pf *work);
-
-static inline void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu) {}
-
-void kvm_arch_crypto_clear_masks(struct kvm *kvm);
-void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
-			       unsigned long *aqm, unsigned long *adm);
-
-#define SIE64_RETURN_NORMAL	0
-#define SIE64_RETURN_MCCK	1
-
-int __sie64a(phys_addr_t sie_block_phys, struct kvm_s390_sie_block *sie_block, u64 *rsa,
-	     unsigned long gasce);
-
-static inline int sie64a(struct kvm_s390_sie_block *sie_block, u64 *rsa, unsigned long gasce)
-{
-	return __sie64a(virt_to_phys(sie_block), sie_block, rsa, gasce);
-}
-
-extern char sie_exit;
-
-bool kvm_s390_pv_is_protected(struct kvm *kvm);
-bool kvm_s390_pv_cpu_is_protected(struct kvm_vcpu *vcpu);
-
-extern int kvm_s390_enter_exit_sie(struct kvm_s390_sie_block *scb,
-				   u64 *gprs, unsigned long gasce);
-
-extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
-extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
-
-bool kvm_s390_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa);
-
-static inline void kvm_arch_free_memslot(struct kvm *kvm,
-					 struct kvm_memory_slot *slot) {}
-static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
-static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
-static inline void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
-		struct kvm_memory_slot *slot) {}
-static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
-static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
-
-#define __KVM_HAVE_ARCH_VM_FREE
-void kvm_arch_free_vm(struct kvm *kvm);
-
-struct zpci_kvm_hook {
-	int (*kvm_register)(void *opaque, struct kvm *kvm);
-	void (*kvm_unregister)(void *opaque);
-};
-
-extern struct zpci_kvm_hook zpci_kvm_hook;
+#include <asm/kvm_host_s390.h>
 
 #endif
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host_s390.h
similarity index 99%
copy from arch/s390/include/asm/kvm_host.h
copy to arch/s390/include/asm/kvm_host_s390.h
index 3039c88daa63..2d62a8ff8008 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -8,8 +8,8 @@
  */
 
 
-#ifndef ASM_KVM_HOST_H
-#define ASM_KVM_HOST_H
+#ifndef ASM_KVM_HOST_S390_H
+#define ASM_KVM_HOST_S390_H
 
 #include <linux/types.h>
 #include <linux/hrtimer.h>
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/mmu_notifier.h>
-#include <asm/kvm_host_types.h>
+#include <asm/kvm_host_s390_types.h>
 #include <asm/debug.h>
 #include <asm/cpu.h>
 #include <asm/fpu.h>
@@ -753,4 +753,4 @@ struct zpci_kvm_hook {
 
 extern struct zpci_kvm_hook zpci_kvm_hook;
 
-#endif
+#endif /* ASM_KVM_HOST_S390_H */
diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_s390_types.h
similarity index 100%
rename from arch/s390/include/asm/kvm_host_types.h
rename to arch/s390/include/asm/kvm_host_s390_types.h
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index fbd26f3e9f96..8619adf91cdb 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -11,7 +11,7 @@
 #include <linux/purgatory.h>
 #include <linux/pgtable.h>
 #include <linux/ftrace_regs.h>
-#include <asm/kvm_host_types.h>
+#include <asm/kvm_host_s390_types.h>
 #include <asm/stacktrace.h>
 #include <asm/ptrace.h>
 
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index b27239c03d79..464f8918d447 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -57,7 +57,7 @@ decompressor_handled_param(cmma);
 decompressor_handled_param(relocate_lowcore);
 decompressor_handled_param(bootdebug);
 __decompressor_handled_param(debug_alternative, debug-alternative);
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 decompressor_handled_param(prot_virt);
 #endif
 
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index bb806d1ddae0..cd4fbdec67a7 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -113,7 +113,7 @@ _LPP_OFFSET	= __LC_LPP
 		    "jnz .+8; .insn rrf,0xb2e80000,0,0,13,0", ALT_SPEC(82)
 	.endm
 
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 	.macro SIEEXIT sie_control,lowcore
 	lg	%r9,\sie_control			# get control block pointer
 	ni	__SIE_PROG0C+3(%r9),0xfe		# no longer in SIE
@@ -184,7 +184,7 @@ EXPORT_SYMBOL(__WARN_trap)
 
 #endif /* CONFIG_BUG && CONFIG_CC_HAS_ASM_IMMEDIATE_STRINGS */
 
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 /*
  * __sie64a calling convention:
  * %r2 pointer to sie control block phys
@@ -315,7 +315,7 @@ SYM_CODE_START(pgm_check_handler)
 	xgr	%r10,%r10
 	tmhh	%r8,0x0001		# coming from user space?
 	jo	3f			# -> fault in user space
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 	lg	%r11,__LC_CURRENT(%r13)
 	tm	__TI_sie(%r11),0xff
 	jz	1f
@@ -386,7 +386,7 @@ SYM_CODE_START(\name)
 	lmg	%r8,%r9,\lc_old_psw(%r13)
 	tmhh	%r8,0x0001			# interrupting from user ?
 	jnz	1f
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 	lg	%r10,__LC_CURRENT(%r13)
 	tm	__TI_sie(%r10),0xff
 	jz	0f
@@ -465,7 +465,7 @@ SYM_CODE_START(mcck_int_handler)
 	jnz	.Lmcck_user
 	TSTMSK	__LC_MCCK_CODE(%r13),MCCK_CODE_PSW_IA_VALID
 	jno	.Lmcck_panic
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 	lg	%r10,__LC_CURRENT(%r13)
 	tm	__TI_sie(%r10),0xff
 	jz	.Lmcck_user
diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index 606750bae508..6441746b8e72 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -37,7 +37,7 @@ static bool is_in_guest(struct pt_regs *regs)
 {
 	if (user_mode(regs))
 		return false;
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 	return instruction_pointer(regs) == (unsigned long) &sie_exit;
 #else
 	return false;
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 5b835bc6a194..f8d4a9a38dae 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -17,39 +17,8 @@ menuconfig VIRTUALIZATION
 if VIRTUALIZATION
 
 config KVM
-	def_tristate y
-	prompt "Kernel-based Virtual Machine (KVM) support"
-	select HAVE_KVM_CPU_RELAX_INTERCEPT
-	select KVM_ASYNC_PF
-	select KVM_ASYNC_PF_SYNC
-	select KVM_COMMON
-	select HAVE_KVM_IRQCHIP
-	select HAVE_KVM_IRQ_ROUTING
-	select HAVE_KVM_INVALID_WAKEUPS
-	select HAVE_KVM_NO_POLL
-	select KVM_VFIO
-	select VIRT_XFER_TO_GUEST_WORK
-	select KVM_MMU_LOCKLESS_AGING
-	help
-	  Support hosting paravirtualized guest machines using the SIE
-	  virtualization capability on the mainframe. This should work
-	  on any 64bit machine.
-
-	  This module provides access to the hardware capabilities through
-	  a character device node named /dev/kvm.
-
-	  To compile this as a module, choose M here: the module
-	  will be called kvm.
-
-	  If unsure, say N.
-
-config KVM_S390_UCONTROL
-	bool "Userspace controlled virtual machines"
-	depends on KVM
-	help
-	  Allow CAP_SYS_ADMIN users to create KVM virtual machines that are
-	  controlled by userspace.
+	tristate
 
-	  If unsure, say N.
+source "arch/s390/kvm/s390/Kconfig"
 
 endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index dac9d53b23d8..c43d7dffca13 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -3,13 +3,4 @@
 #
 # Copyright IBM Corp. 2008
 
-include $(srctree)/virt/kvm/Makefile.kvm
-
-ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
-
-kvm-y += kvm-s390.o intercept.o interrupt.o priv.o sigp.o
-kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
-kvm-y += dat.o gmap.o faultin.o
-
-kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
-obj-$(CONFIG_KVM) += kvm.o
+obj-$(CONFIG_KVM_S390) += s390/
diff --git a/arch/s390/kvm/gmap/Makefile b/arch/s390/kvm/gmap/Makefile
new file mode 100644
index 000000000000..21967ed88877
--- /dev/null
+++ b/arch/s390/kvm/gmap/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+GMAP ?= ../gmap
+
+kvm-y += $(GMAP)/dat.o $(GMAP)/gmap.o $(GMAP)/faultin.o
diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/gmap/dat.c
similarity index 100%
rename from arch/s390/kvm/dat.c
rename to arch/s390/kvm/gmap/dat.c
diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/gmap/dat.h
similarity index 99%
rename from arch/s390/kvm/dat.h
rename to arch/s390/kvm/gmap/dat.h
index 874cc962e196..5ef08967312c 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -6,8 +6,8 @@
  *    Author(s): Claudio Imbrenda <imbrenda@linux.ibm.com>
  */
 
-#ifndef __KVM_S390_DAT_H
-#define __KVM_S390_DAT_H
+#ifndef ARCH_KVM_GMAP_DAT_H
+#define ARCH_KVM_GMAP_DAT_H
 
 #include <linux/radix-tree.h>
 #include <linux/refcount.h>
@@ -968,4 +968,4 @@ static inline bool crste_is_ucas(union crste crste)
 	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl == 1 && crste.h.fc == 0;
 }
 
-#endif /* __KVM_S390_DAT_H */
+#endif /* ARCH_KVM_GMAP_DAT_H */
diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/gmap/faultin.c
similarity index 100%
rename from arch/s390/kvm/faultin.c
rename to arch/s390/kvm/gmap/faultin.c
diff --git a/arch/s390/kvm/faultin.h b/arch/s390/kvm/gmap/faultin.h
similarity index 96%
rename from arch/s390/kvm/faultin.h
rename to arch/s390/kvm/gmap/faultin.h
index f86176d2769c..f343b6fb6f16 100644
--- a/arch/s390/kvm/faultin.h
+++ b/arch/s390/kvm/gmap/faultin.h
@@ -6,8 +6,8 @@
  *    Author(s): Claudio Imbrenda <imbrenda@linux.ibm.com>
  */
 
-#ifndef __KVM_S390_FAULTIN_H
-#define __KVM_S390_FAULTIN_H
+#ifndef ARCH_KVM_GMAP_FAULTIN_H
+#define ARCH_KVM_GMAP_FAULTIN_H
 
 #include <linux/kvm_host.h>
 
@@ -89,4 +89,4 @@ static inline int kvm_s390_get_guest_pages(struct kvm *kvm, struct guest_fault *
 #define kvm_s390_array_needs_retry_safe(kvm, seq, array) \
 	kvm_s390_multiple_faults_need_retry(kvm, seq, array, ARRAY_SIZE(array), false)
 
-#endif /* __KVM_S390_FAULTIN_H */
+#endif /* ARCH_KVM_GMAP_FAULTIN_H */
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap/gmap.c
similarity index 99%
rename from arch/s390/kvm/gmap.c
rename to arch/s390/kvm/gmap/gmap.c
index 645c32c767d2..6fa76658f64c 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -21,7 +21,7 @@
 
 #include "dat.h"
 #include "gmap.h"
-#include "kvm-s390.h"
+#include "s390.h"
 #include "faultin.h"
 
 static inline bool kvm_s390_is_in_sie(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap/gmap.h
similarity index 98%
rename from arch/s390/kvm/gmap.h
rename to arch/s390/kvm/gmap/gmap.h
index 579399ef5480..238487554c18 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -7,8 +7,8 @@
  *               Claudio Imbrenda <imbrenda@linux.ibm.com>
  */
 
-#ifndef ARCH_KVM_S390_GMAP_H
-#define ARCH_KVM_S390_GMAP_H
+#ifndef ARCH_KVM_GMAP_GMAP_H
+#define ARCH_KVM_GMAP_GMAP_H
 
 #include "dat.h"
 
@@ -250,4 +250,4 @@ static inline bool gmap_is_shadow_valid(struct gmap *sg, union asce asce, int ed
 	return sg->guest_asce.val == asce.val && sg->edat_level == edat_level;
 }
 
-#endif /* ARCH_KVM_S390_GMAP_H */
+#endif /* ARCH_KVM_GMAP_GMAP_H */
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/s390/Kconfig
similarity index 62%
copy from arch/s390/kvm/Kconfig
copy to arch/s390/kvm/s390/Kconfig
index 5b835bc6a194..f9853e61fd58 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/s390/Kconfig
@@ -1,24 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# KVM configuration
+# KVM_S390 configuration
 #
 source "virt/kvm/Kconfig"
 
-menuconfig VIRTUALIZATION
-	def_bool y
-	prompt "KVM"
-	help
-	  Say Y here to get to see options for using your Linux host to run other
-	  operating systems inside virtual machines (guests).
-	  This option alone does not add any kernel code.
-
-	  If you say N, all options in this submenu will be skipped and disabled.
-
-if VIRTUALIZATION
-
-config KVM
+config KVM_S390
 	def_tristate y
-	prompt "Kernel-based Virtual Machine (KVM) support"
+	prompt "Kernel-based Virtual Machine (KVM) support (s390)"
+	select KVM
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_ASYNC_PF
 	select KVM_ASYNC_PF_SYNC
@@ -31,7 +20,7 @@ config KVM
 	select VIRT_XFER_TO_GUEST_WORK
 	select KVM_MMU_LOCKLESS_AGING
 	help
-	  Support hosting paravirtualized guest machines using the SIE
+	  Support hosting paravirtualized s390 guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
 	  on any 64bit machine.
 
@@ -45,11 +34,9 @@ config KVM
 
 config KVM_S390_UCONTROL
 	bool "Userspace controlled virtual machines"
-	depends on KVM
+	depends on KVM_S390
 	help
 	  Allow CAP_SYS_ADMIN users to create KVM virtual machines that are
 	  controlled by userspace.
 
 	  If unsure, say N.
-
-endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/s390/Makefile
similarity index 53%
copy from arch/s390/kvm/Makefile
copy to arch/s390/kvm/s390/Makefile
index dac9d53b23d8..51aee874b36f 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/s390/Makefile
@@ -3,13 +3,15 @@
 #
 # Copyright IBM Corp. 2008
 
+KVM := ../../../../virt/kvm
 include $(srctree)/virt/kvm/Makefile.kvm
+include $(srctree)/arch/s390/kvm/gmap/Makefile
 
-ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
+ccflags-y := -I$(src) -I$(srctree)/arch/s390/kvm/gmap
 
-kvm-y += kvm-s390.o intercept.o interrupt.o priv.o sigp.o
+kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
 kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
-kvm-y += dat.o gmap.o faultin.o
 
 kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
-obj-$(CONFIG_KVM) += kvm.o
+
+obj-$(CONFIG_KVM_S390) += kvm.o
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/s390/diag.c
similarity index 99%
rename from arch/s390/kvm/diag.c
rename to arch/s390/kvm/s390/diag.c
index d89d1c381522..700d9b7b68bc 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/s390/diag.c
@@ -12,7 +12,7 @@
 #include <linux/kvm_host.h>
 #include <asm/gmap_helpers.h>
 #include <asm/virtio-ccw.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "trace.h"
 #include "trace-s390.h"
 #include "gaccess.h"
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/s390/gaccess.c
similarity index 99%
rename from arch/s390/kvm/gaccess.c
rename to arch/s390/kvm/s390/gaccess.c
index 53a8550e7102..a226a891c783 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/s390/gaccess.c
@@ -17,7 +17,7 @@
 #include <asm/access-regs.h>
 #include <asm/fault.h>
 #include <asm/dat-bits.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "dat.h"
 #include "gmap.h"
 #include "gaccess.h"
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/s390/gaccess.h
similarity index 99%
rename from arch/s390/kvm/gaccess.h
rename to arch/s390/kvm/s390/gaccess.h
index b5385cec60f4..ef922b3b4990 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/s390/gaccess.h
@@ -14,7 +14,7 @@
 #include <linux/kvm_host.h>
 #include <linux/uaccess.h>
 #include <linux/ptrace.h>
-#include "kvm-s390.h"
+#include "s390.h"
 
 /**
  * kvm_s390_real_to_abs - convert guest real address to guest absolute address
diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/s390/guestdbg.c
similarity index 99%
rename from arch/s390/kvm/guestdbg.c
rename to arch/s390/kvm/s390/guestdbg.c
index 69835e1d4f20..c880ebbdef2f 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/s390/guestdbg.c
@@ -8,7 +8,7 @@
  */
 #include <linux/kvm_host.h>
 #include <linux/errno.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 
 /*
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/s390/intercept.c
similarity index 99%
rename from arch/s390/kvm/intercept.c
rename to arch/s390/kvm/s390/intercept.c
index 39aff324203e..9b897328e4b9 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/s390/intercept.c
@@ -17,7 +17,7 @@
 #include <asm/sysinfo.h>
 #include <asm/uv.h>
 
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 #include "trace.h"
 #include "trace-s390.h"
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/s390/interrupt.c
similarity index 99%
rename from arch/s390/kvm/interrupt.c
rename to arch/s390/kvm/s390/interrupt.c
index 7cb8ce833b62..04a4db24fc75 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/s390/interrupt.c
@@ -29,7 +29,7 @@
 #include <asm/nmi.h>
 #include <asm/airq.h>
 #include <asm/tpi.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 #include "trace-s390.h"
 #include "pci.h"
diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/s390/pci.c
similarity index 99%
rename from arch/s390/kvm/pci.c
rename to arch/s390/kvm/s390/pci.c
index 86d93e8dddae..83180897bf37 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/s390/pci.c
@@ -14,7 +14,7 @@
 #include <asm/pci_io.h>
 #include <asm/sclp.h>
 #include "pci.h"
-#include "kvm-s390.h"
+#include "s390.h"
 
 struct zpci_aift *aift;
 
diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/s390/pci.h
similarity index 100%
rename from arch/s390/kvm/pci.h
rename to arch/s390/kvm/s390/pci.h
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/s390/priv.c
similarity index 99%
rename from arch/s390/kvm/priv.c
rename to arch/s390/kvm/s390/priv.c
index a3250ad83a8e..123f9e56da96 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/s390/priv.c
@@ -26,7 +26,7 @@
 #include <asm/ap.h>
 #include <asm/gmap_helpers.h>
 #include "gaccess.h"
-#include "kvm-s390.h"
+#include "s390.h"
 #include "trace.h"
 #include "gmap.h"
 
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/s390/pv.c
similarity index 99%
rename from arch/s390/kvm/pv.c
rename to arch/s390/kvm/s390/pv.c
index c2dafd812a3b..1bddc9aeb1a9 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/s390/pv.c
@@ -17,7 +17,7 @@
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
 #include <linux/mmu_notifier.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "dat.h"
 #include "gaccess.h"
 #include "gmap.h"
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/s390/s390.c
similarity index 99%
rename from arch/s390/kvm/kvm-s390.c
rename to arch/s390/kvm/s390/s390.c
index d7838334a338..5bc23ebe7ee5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -50,7 +50,7 @@
 #include <asm/fpu.h>
 #include <asm/ap.h>
 #include <asm/uv.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 #include "gmap.h"
 #include "faultin.h"
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/s390/s390.h
similarity index 99%
rename from arch/s390/kvm/kvm-s390.h
rename to arch/s390/kvm/s390/s390.h
index bf1d7798c1af..ad1aeec40cae 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/s390/s390.h
@@ -448,7 +448,7 @@ void kvm_s390_vsie_destroy(struct kvm *kvm);
 int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
 
-/* implemented in kvm-s390.c */
+/* implemented in s390.c */
 int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clock *gtod);
 int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
 int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/s390/sigp.c
similarity index 99%
rename from arch/s390/kvm/sigp.c
rename to arch/s390/kvm/s390/sigp.c
index 55c34cb35428..131b3371ef4f 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/s390/sigp.c
@@ -14,7 +14,7 @@
 #include <linux/slab.h>
 #include <asm/sigp.h>
 #include "gaccess.h"
-#include "kvm-s390.h"
+#include "s390.h"
 #include "trace.h"
 
 static int __sigp_sense(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/s390/trace-s390.h
similarity index 100%
rename from arch/s390/kvm/trace-s390.h
rename to arch/s390/kvm/s390/trace-s390.h
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/s390/trace.h
similarity index 100%
rename from arch/s390/kvm/trace.h
rename to arch/s390/kvm/s390/trace.h
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/s390/vsie.c
similarity index 99%
rename from arch/s390/kvm/vsie.c
rename to arch/s390/kvm/s390/vsie.c
index 72895dddc39a..0cd25beeadc6 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -20,7 +20,7 @@
 #include <asm/nmi.h>
 #include <asm/dis.h>
 #include <asm/facility.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 #include "gmap.h"
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ca06f9bda028..6a74dceb1f9a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1528,7 +1528,7 @@ void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
 
-#ifndef CONFIG_S390
+#ifndef CONFIG_KVM_S390
 void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait);
 
 static inline void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
-- 
2.51.0

