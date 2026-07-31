Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C959C437878;
	Fri, 31 Jul 2026 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503392; cv=none; b=WPRUnZbcRDOlC9zJJyTvBw+udGKnxC7oIFB3+aly8oBoQDVdq/1aFEQ5FSP5OTaSa0EvzuAV6e5/f/O9rigG49wroThHpXrGSaG7LToMFBdD53O2XYwgYGC9M2sTncrGs1E/hao5FCrmVWFpMd82KOF0flenKcNFz/UFOl3rLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503392; c=relaxed/simple;
	bh=iMexrA5Kb59QNGGH617MljeUhGQY5mqGD9WgJ2sP0Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpZ22MneBegjGy40dj6VBrATeB/NcWzGYY9kjNpQaIwzfn8Pm+rluTn1Ci9ijhwjXHpVY0TmSBSw8pd5Ax5FJrt8gvbJiaAK5N5nEId5WM6bKotzlaRv+QkhP8XsjtXskPDtaX2s1i3wnx7h5QT3ciSXvTn605LF7H9Kq7Dila4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HZjZnvDq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HZjZnvDq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlgD94072746;
	Fri, 31 Jul 2026 13:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EB744O2esC+l2WBO/
	aKRIzFssTb90gPpXLvNk5GwHM4=; b=HZjZnvDqvdkmdfonCSTfvCq1/GHE1jYRF
	Luyfz45YEW7sdxjPknBKUBU4sig77PdQUPemtMshdZIyybwnaOT1feNYwNfTYUvb
	VCMWWgfqWHjTSrUnerwZ/VbjG00wfQLKB/6rtBzBASN+fNFZuqjno080c3P5lRYJ
	xDdBJIvnjff5KIeM5fS8rye6ONoVbInu6rCcyJfYqrZYnWoavDAz05bFk5T79jbx
	bVUdSirR1LmS1/i575kUmjSS5olDzBz7r8GtNTSMuu++DuogWYQ84fTEyUqoaRFL
	ny3H1VOVpqPw2LASIpnxZF8mMNz4XgfcEDlN/vGKbamw6ol1w1X/A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw2ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuL1Q026432;
	Fri, 31 Jul 2026 13:09:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhqw7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD992845547844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDC4E20040;
	Fri, 31 Jul 2026 13:09:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B48220043;
	Fri, 31 Jul 2026 13:09:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:08 +0000 (GMT)
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
Subject: [PATCH v5 13/31] KVM: s390: Prepare moving KVM/s390 to arch/s390/kvm/s390
Date: Fri, 31 Jul 2026 15:08:41 +0200
Message-ID: <20260731130902.654679-14-seiden@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 9UvrrbbNj6FHbo6oclT5WdqLt39VnBx-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXwHbol/DxlkzS
 UMjlTHwcA2gpVYG+wLYm0HsX6aTW0ja5yvZHX+ghqrWqYFurq5KVF+X0O5dGfzls8j8xGIuWeVk
 dVhaYQ/BQYd4QKuwB4rl2L/d2o0rTsH/fU87Vmd4roQfLFcsCNsW77xyOco0ty5ARputZkmjass
 CWFtBplbT3FQCFY7eJw6Lq0pMlIoIEd5w0htmQpPmlH+Cfd+zAlhxJyOOW3/xCg5hfQQ6SJuOFO
 EZrPMbUmfQXW/IJ6HYCEHigF5WuyiOgHyKNRCnrAusQlkAp8DaA8jKDZmKPaXNhYLEsQbivjs1I
 Ouz1igMtqBYNVdpJFw4JJBr7a3GF3ymQoyYIHf+4l4IUCum2If7ELIVPMNF1SqW4TvRNZmkeSGF
 WrIdNnBk+Q7c4z6crY6QYn6WmcMEYa1/xN7IYqTfmYLrqTtZnBZA9t9nekiGkSwAbpaxWCoQXCV
 ezxdWfkGRMcUr4ZZcZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX0A8+PjNWPZlB
 5g/SFxFQmTE/n4ckuGI3ZzK2e9jrKtXN8dsfhE/b8lW1x/a+8h5QylygU75JIaE6ssOROOVUbnr
 nYu0suZkuvZWYZk4q/SJmkzSvnXtN5g=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9e80 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=UdqBhROR4sx79BYIaikA:9
X-Proofpoint-GUID: PlFpoo9i57pZx0JwMT41cYd2p-Ele3Mf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Lay the groundwork for moving the native KVM/s390 to s390/kvm/s390 to
allow for a second KVM module. Move all the kvm_host definitions to
_s390 postfixed headers. Prepare local header include guards for a new
location. Move gamp related tracing into a separate file. While at it,
rename the main KVM/s390 files from s390-kvm.{c,h} to just s390.{c,h} to
match the naming scheme of other architectures. Cleanup the KVM/s390
makefile.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h              | 779 +-----------------
 .../asm/{kvm_host.h => kvm_host_s390.h}       |   6 +-
 ...kvm_host_types.h => kvm_host_s390_types.h} |   6 +-
 arch/s390/include/asm/kvm_host_types.h        | 347 +-------
 arch/s390/kvm/Kconfig                         |   4 +-
 arch/s390/kvm/Makefile                        |   4 +-
 arch/s390/kvm/dat.h                           |   6 +-
 arch/s390/kvm/diag.c                          |   2 +-
 arch/s390/kvm/faultin.c                       |   3 +-
 arch/s390/kvm/faultin.h                       |   6 +-
 arch/s390/kvm/gaccess.c                       |   2 +-
 arch/s390/kvm/gaccess.h                       |   2 +-
 arch/s390/kvm/gmap.c                          |   2 +-
 arch/s390/kvm/gmap.h                          |   6 +-
 arch/s390/kvm/guestdbg.c                      |   2 +-
 arch/s390/kvm/intercept.c                     |   2 +-
 arch/s390/kvm/interrupt.c                     |   2 +-
 arch/s390/kvm/pci.c                           |   2 +-
 arch/s390/kvm/priv.c                          |   2 +-
 arch/s390/kvm/pv.c                            |   2 +-
 arch/s390/kvm/{kvm-s390.c => s390.c}          |   2 +-
 arch/s390/kvm/{kvm-s390.h => s390.h}          |   2 +-
 arch/s390/kvm/sigp.c                          |   2 +-
 arch/s390/kvm/trace-gmap.h                    |  46 ++
 arch/s390/kvm/trace.h                         |  14 -
 arch/s390/kvm/vsie.c                          |   2 +-
 26 files changed, 87 insertions(+), 1168 deletions(-)
 copy arch/s390/include/asm/{kvm_host.h => kvm_host_s390.h} (99%)
 copy arch/s390/include/asm/{kvm_host_types.h => kvm_host_s390_types.h} (98%)
 rename arch/s390/kvm/{kvm-s390.c => s390.c} (99%)
 rename arch/s390/kvm/{kvm-s390.h => s390.h} (99%)
 create mode 100644 arch/s390/kvm/trace-gmap.h

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c172f9b212d1..e76ceee11ef5 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -1,783 +1,8 @@
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
-	spinlock_t ais_lock;
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
-	u64 io_390_adapter_map;
-	u64 io_390_adapter_unmap;
-	u64 io_390_inatomic;
-	u64 io_flic_inject_airq;
-	u64 io_set_adapter_int;
-	u64 io_390_inatomic_no_inject;
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
-	/*
-	 * True if the page is long-term pinned. False if long-term pinning
-	 * failed and this entry exists only to preserve MAP/UNMAP symmetry.
-	 */
-	bool pinned;
-};
-
-struct s390_io_adapter {
-	unsigned int id;
-	int isc;
-	bool maskable;
-	bool masked;
-	bool swap;
-	bool suppressible;
-	spinlock_t maps_lock;
-	struct list_head maps;
-	unsigned int nr_maps;
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
-#define S390_ARCH_FAC_FORMAT_2 2
-struct kvm_s390_flcb2 {
-	union {
-		struct {
-			u8 reserved0[7];
-			u8 length;
-		};
-		u64 header_val;
-	};
-	u64 facilities[S390_ARCH_FAC_LIST_SIZE_U64];
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
-	int allow_vsie_esamode;
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
 
-#endif
+#endif /* ASM_KVM_HOST_H */
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host_s390.h
similarity index 99%
copy from arch/s390/include/asm/kvm_host.h
copy to arch/s390/include/asm/kvm_host_s390.h
index c172f9b212d1..3c592e4bb883 100644
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
@@ -780,4 +780,4 @@ struct zpci_kvm_hook {
 
 extern struct zpci_kvm_hook zpci_kvm_hook;
 
-#endif
+#endif /* ASM_KVM_HOST_S390_H */
diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_s390_types.h
similarity index 98%
copy from arch/s390/include/asm/kvm_host_types.h
copy to arch/s390/include/asm/kvm_host_s390_types.h
index 3f50942bdfe6..5cf746095bfd 100644
--- a/arch/s390/include/asm/kvm_host_types.h
+++ b/arch/s390/include/asm/kvm_host_s390_types.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#ifndef _ASM_KVM_HOST_TYPES_H
-#define _ASM_KVM_HOST_TYPES_H
+#ifndef _ASM_KVM_HOST_S390_TYPES_H
+#define _ASM_KVM_HOST_S390_TYPES_H
 
 #include <linux/atomic.h>
 #include <linux/types.h>
@@ -344,4 +344,4 @@ struct sie_page {
 	__u8 reserved700[2304];		/* 0x0700 */
 };
 
-#endif /* _ASM_KVM_HOST_TYPES_H */
+#endif /* _ASM_KVM_HOST_S390_TYPES_H */
diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_types.h
index 3f50942bdfe6..e5bdba07cab0 100644
--- a/arch/s390/include/asm/kvm_host_types.h
+++ b/arch/s390/include/asm/kvm_host_types.h
@@ -1,347 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#ifndef _ASM_KVM_HOST_TYPES_H
-#define _ASM_KVM_HOST_TYPES_H
+#ifndef ASM_KVM_HOST_TYPES_H
+#define ASM_KVM_HOST_TYPES_H
 
-#include <linux/atomic.h>
-#include <linux/types.h>
+#include <asm/kvm_host_s390_types.h>
 
-#define KVM_S390_BSCA_CPU_SLOTS 64
-#define KVM_S390_ESCA_CPU_SLOTS 248
-
-#define SIGP_CTRL_C		0x80
-#define SIGP_CTRL_SCN_MASK	0x3f
-
-union bsca_sigp_ctrl {
-	__u8 value;
-	struct {
-		__u8 c : 1;
-		__u8 r : 1;
-		__u8 scn : 6;
-	};
-};
-
-union esca_sigp_ctrl {
-	__u16 value;
-	struct {
-		__u8 c : 1;
-		__u8 reserved: 7;
-		__u8 scn;
-	};
-};
-
-struct esca_entry {
-	union esca_sigp_ctrl sigp_ctrl;
-	__u16	reserved1[3];
-	__u64	sda;
-	__u64	reserved2[6];
-};
-
-struct bsca_entry {
-	__u8	reserved0;
-	union bsca_sigp_ctrl	sigp_ctrl;
-	__u16	reserved[3];
-	__u64	sda;
-	__u64	reserved2[2];
-};
-
-union ipte_control {
-	unsigned long val;
-	struct {
-		unsigned long k  : 1;
-		unsigned long kh : 31;
-		unsigned long kg : 32;
-	};
-};
-
-/*
- * Utility is defined as two bytes but having it four bytes wide
- * generates more efficient code. Since the following bytes are
- * reserved this makes no functional difference.
- */
-union sca_utility {
-	__u32 val;
-	struct {
-		__u32 mtcr : 1;
-		__u32	   : 31;
-	};
-};
-
-struct bsca_block {
-	union ipte_control ipte_control;
-	__u64	reserved[5];
-	__u64	mcn;
-	union sca_utility utility;
-	__u8	reserved2[4];
-	struct bsca_entry cpu[KVM_S390_BSCA_CPU_SLOTS];
-};
-
-struct esca_block {
-	union ipte_control ipte_control;
-	__u64	reserved1[6];
-	union sca_utility utility;
-	__u8	reserved2[4];
-	__u64	mcn[4];
-	__u64	reserved3[20];
-	struct esca_entry cpu[KVM_S390_ESCA_CPU_SLOTS];
-};
-
-/*
- * This struct is used to store some machine check info from lowcore
- * for machine checks that happen while the guest is running.
- * This info in host's lowcore might be overwritten by a second machine
- * check from host when host is in the machine check's high-level handling.
- * The size is 24 bytes.
- */
-struct mcck_volatile_info {
-	__u64 mcic;
-	__u64 failing_storage_address;
-	__u32 ext_damage_code;
-	__u32 reserved;
-};
-
-#define CR0_INITIAL_MASK (CR0_UNUSED_56 | CR0_INTERRUPT_KEY_SUBMASK | \
-			  CR0_MEASUREMENT_ALERT_SUBMASK)
-#define CR14_INITIAL_MASK (CR14_UNUSED_32 | CR14_UNUSED_33 | \
-			   CR14_EXTERNAL_DAMAGE_SUBMASK)
-
-#define SIDAD_SIZE_MASK		0xff
-#define sida_addr(sie_block) phys_to_virt((sie_block)->sidad & PAGE_MASK)
-#define sida_size(sie_block) \
-	((((sie_block)->sidad & SIDAD_SIZE_MASK) + 1) * PAGE_SIZE)
-
-#define CPUSTAT_STOPPED    0x80000000
-#define CPUSTAT_WAIT	   0x10000000
-#define CPUSTAT_ECALL_PEND 0x08000000
-#define CPUSTAT_STOP_INT   0x04000000
-#define CPUSTAT_IO_INT	   0x02000000
-#define CPUSTAT_EXT_INT    0x01000000
-#define CPUSTAT_RUNNING    0x00800000
-#define CPUSTAT_RETAINED   0x00400000
-#define CPUSTAT_TIMING_SUB 0x00020000
-#define CPUSTAT_SIE_SUB    0x00010000
-#define CPUSTAT_RRF	   0x00008000
-#define CPUSTAT_SLSV	   0x00004000
-#define CPUSTAT_SLSR	   0x00002000
-#define CPUSTAT_ZARCH	   0x00000800
-#define CPUSTAT_MCDS	   0x00000100
-#define CPUSTAT_KSS	   0x00000200
-#define CPUSTAT_SM	   0x00000080
-#define CPUSTAT_IBS	   0x00000040
-#define CPUSTAT_GED2	   0x00000010
-#define CPUSTAT_G	   0x00000008
-#define CPUSTAT_GED	   0x00000004
-#define CPUSTAT_J	   0x00000002
-#define CPUSTAT_P	   0x00000001
-
-struct kvm_s390_sie_block {
-	atomic_t cpuflags;		/* 0x0000 */
-	__u32 : 1;			/* 0x0004 */
-	__u32 prefix : 19;
-	__u32 ibc : 12;
-	__u8	reserved08[4];		/* 0x0008 */
-#define PROG_IN_SIE (1<<0)
-	__u32	prog0c;			/* 0x000c */
-	union {
-		__u8	reserved10[16];		/* 0x0010 */
-		struct {
-			__u64	pv_handle_cpu;
-			__u64	pv_handle_config;
-		};
-	};
-#define PROG_BLOCK_SIE	(1<<0)
-#define PROG_REQUEST	(1<<1)
-	atomic_t prog20;		/* 0x0020 */
-	__u8	reserved24[4];		/* 0x0024 */
-	__u64	cputm;			/* 0x0028 */
-	__u64	ckc;			/* 0x0030 */
-	__u64	epoch;			/* 0x0038 */
-	__u32	svcc;			/* 0x0040 */
-#define LCTL_CR0	0x8000
-#define LCTL_CR6	0x0200
-#define LCTL_CR9	0x0040
-#define LCTL_CR10	0x0020
-#define LCTL_CR11	0x0010
-#define LCTL_CR14	0x0002
-	__u16	lctl;			/* 0x0044 */
-	__s16	icpua;			/* 0x0046 */
-#define ICTL_OPEREXC	0x80000000
-#define ICTL_PINT	0x20000000
-#define ICTL_LPSW	0x00400000
-#define ICTL_STCTL	0x00040000
-#define ICTL_ISKE	0x00004000
-#define ICTL_SSKE	0x00002000
-#define ICTL_RRBE	0x00001000
-#define ICTL_TPROT	0x00000200
-	__u32	ictl;			/* 0x0048 */
-#define ECA_CEI		0x80000000
-#define ECA_IB		0x40000000
-#define ECA_SIGPI	0x10000000
-#define ECA_MVPGI	0x01000000
-#define ECA_AIV		0x00200000
-#define ECA_VX		0x00020000
-#define ECA_PROTEXCI	0x00002000
-#define ECA_APIE	0x00000008
-#define ECA_SII		0x00000001
-	__u32	eca;			/* 0x004c */
-#define ICPT_INST	0x04
-#define ICPT_PROGI	0x08
-#define ICPT_INSTPROGI	0x0C
-#define ICPT_EXTREQ	0x10
-#define ICPT_EXTINT	0x14
-#define ICPT_IOREQ	0x18
-#define ICPT_WAIT	0x1c
-#define ICPT_VALIDITY	0x20
-#define ICPT_STOP	0x28
-#define ICPT_OPEREXC	0x2C
-#define ICPT_PARTEXEC	0x38
-#define ICPT_IOINST	0x40
-#define ICPT_KSS	0x5c
-#define ICPT_MCHKREQ	0x60
-#define ICPT_INT_ENABLE	0x64
-#define ICPT_PV_INSTR	0x68
-#define ICPT_PV_NOTIFY	0x6c
-#define ICPT_PV_PREF	0x70
-	__u8	icptcode;		/* 0x0050 */
-	__u8	icptstatus;		/* 0x0051 */
-	__u16	ihcpu;			/* 0x0052 */
-	__u8	reserved54;		/* 0x0054 */
-#define IICTL_CODE_NONE		 0x00
-#define IICTL_CODE_MCHK		 0x01
-#define IICTL_CODE_EXT		 0x02
-#define IICTL_CODE_IO		 0x03
-#define IICTL_CODE_RESTART	 0x04
-#define IICTL_CODE_SPECIFICATION 0x10
-#define IICTL_CODE_OPERAND	 0x11
-	__u8	iictl;			/* 0x0055 */
-	__u16	ipa;			/* 0x0056 */
-	__u32	ipb;			/* 0x0058 */
-	__u32	scaoh;			/* 0x005c */
-#define FPF_BPBC	0x20
-	__u8	fpf;			/* 0x0060 */
-#define ECB_GS		0x40
-#define ECB_TE		0x10
-#define ECB_SPECI	0x08
-#define ECB_SRSI	0x04
-#define ECB_HOSTPROTINT	0x02
-#define ECB_PTF		0x01
-	__u8	ecb;			/* 0x0061 */
-#define ECB2_CMMA	0x80
-#define ECB2_IEP	0x20
-#define ECB2_PFMFI	0x08
-#define ECB2_ESCA	0x04
-#define ECB2_ZPCI_LSI	0x02
-	__u8	ecb2;			/* 0x0062 */
-#define ECB3_AISI	0x20
-#define ECB3_AISII	0x10
-#define ECB3_DEA 0x08
-#define ECB3_AES 0x04
-#define ECB3_RI  0x01
-	__u8	ecb3;			/* 0x0063 */
-#define ESCA_SCAOL_MASK ~0x3fU
-	__u32	scaol;			/* 0x0064 */
-	__u8	sdf;			/* 0x0068 */
-	__u8	epdx;			/* 0x0069 */
-	__u8	cpnc;			/* 0x006a */
-	__u8	reserved6b;		/* 0x006b */
-	__u32	todpr;			/* 0x006c */
-#define GISA_FORMAT1 0x00000001
-	__u32	gd;			/* 0x0070 */
-	__u8	reserved74[12];		/* 0x0074 */
-	__u64	mso;			/* 0x0080 */
-	__u64	msl;			/* 0x0088 */
-	psw_t	gpsw;			/* 0x0090 */
-	__u64	gg14;			/* 0x00a0 */
-	__u64	gg15;			/* 0x00a8 */
-	__u8	reservedb0[8];		/* 0x00b0 */
-#define HPID_KVM	0x4
-#define HPID_VSIE	0x5
-	__u8	hpid;			/* 0x00b8 */
-	__u8	reservedb9[7];		/* 0x00b9 */
-	union {
-		struct {
-			__u32	eiparams;	/* 0x00c0 */
-			__u16	extcpuaddr;	/* 0x00c4 */
-			__u16	eic;		/* 0x00c6 */
-		};
-		__u64	mcic;			/* 0x00c0 */
-	} __packed;
-	__u32	reservedc8;		/* 0x00c8 */
-	union {
-		struct {
-			__u16	pgmilc;		/* 0x00cc */
-			__u16	iprcc;		/* 0x00ce */
-		};
-		__u32	edc;			/* 0x00cc */
-	} __packed;
-	union {
-		struct {
-			__u32	dxc;		/* 0x00d0 */
-			__u16	mcn;		/* 0x00d4 */
-			__u8	perc;		/* 0x00d6 */
-			__u8	peratmid;	/* 0x00d7 */
-		};
-		__u64	faddr;			/* 0x00d0 */
-	} __packed;
-	__u64	peraddr;		/* 0x00d8 */
-	__u8	eai;			/* 0x00e0 */
-	__u8	peraid;			/* 0x00e1 */
-	__u8	oai;			/* 0x00e2 */
-	__u8	armid;			/* 0x00e3 */
-	__u8	reservede4[4];		/* 0x00e4 */
-	union {
-		__u64	tecmc;		/* 0x00e8 */
-		struct {
-			__u16	subchannel_id;	/* 0x00e8 */
-			__u16	subchannel_nr;	/* 0x00ea */
-			__u32	io_int_parm;	/* 0x00ec */
-			__u32	io_int_word;	/* 0x00f0 */
-		};
-	} __packed;
-	__u8	reservedf4[8];		/* 0x00f4 */
-#define CRYCB_FORMAT_MASK 0x00000003
-#define CRYCB_FORMAT0 0x00000000
-#define CRYCB_FORMAT1 0x00000001
-#define CRYCB_FORMAT2 0x00000003
-	__u32	crycbd;			/* 0x00fc */
-	__u64	gcr[16];		/* 0x0100 */
-	union {
-		__u64	gbea;		/* 0x0180 */
-		__u64	sidad;
-	};
-	__u8	reserved188[8];		/* 0x0188 */
-	__u64	sdnxo;			/* 0x0190 */
-	__u8	reserved198[8];		/* 0x0198 */
-	__u32	fac;			/* 0x01a0 */
-	__u8	reserved1a4[20];	/* 0x01a4 */
-	__u64	cbrlo;			/* 0x01b8 */
-	__u8	reserved1c0[8];		/* 0x01c0 */
-#define ECD_HOSTREGMGMT	0x20000000
-#define ECD_MEF		0x08000000
-#define ECD_ETOKENF	0x02000000
-#define ECD_ECC		0x00200000
-#define ECD_HMAC	0x00004000
-	__u32	ecd;			/* 0x01c8 */
-	__u8	reserved1cc[18];	/* 0x01cc */
-	__u64	pp;			/* 0x01de */
-	__u8	reserved1e6[2];		/* 0x01e6 */
-	__u64	itdba;			/* 0x01e8 */
-	__u64	riccbd;			/* 0x01f0 */
-	__u64	gvrd;			/* 0x01f8 */
-} __packed __aligned(512);
-
-struct kvm_s390_itdb {
-	__u8	data[256];
-};
-
-struct sie_page {
-	struct kvm_s390_sie_block sie_block;
-	struct mcck_volatile_info mcck_info;	/* 0x0200 */
-	__u8 reserved218[360];		/* 0x0218 */
-	__u64 pv_grregs[16];		/* 0x0380 */
-	__u8 reserved400[512];		/* 0x0400 */
-	struct kvm_s390_itdb itdb;	/* 0x0600 */
-	__u8 reserved700[2304];		/* 0x0700 */
-};
-
-#endif /* _ASM_KVM_HOST_TYPES_H */
+#endif /* ASM_KVM_HOST_TYPES_H */
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 8d3ee17a1bcb..e9d2ca797907 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -18,7 +18,7 @@ if VIRTUALIZATION
 
 config KVM
 	def_tristate y
-	prompt "Kernel-based Virtual Machine (KVM) support"
+	prompt "Kernel-based Virtual Machine (KVM) support (s390)"
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_ASYNC_PF
 	select KVM_ASYNC_PF_SYNC
@@ -32,7 +32,7 @@ config KVM
 	select KVM_MMU_LOCKLESS_AGING
 	select KVM_GENERIC_PRE_FAULT_MEMORY
 	help
-	  Support hosting paravirtualized guest machines using the SIE
+	  Support hosting paravirtualized s390 guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
 	  on any 64bit machine.
 
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index dac9d53b23d8..961de97b8e80 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -5,9 +5,9 @@
 
 include $(srctree)/virt/kvm/Makefile.kvm
 
-ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
+ccflags-y := -I$(src)
 
-kvm-y += kvm-s390.o intercept.o interrupt.o priv.o sigp.o
+kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
 kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
 kvm-y += dat.o gmap.o faultin.o
 
diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index fad605305e05..711ae2f96107 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -6,8 +6,8 @@
  *    Author(s): Claudio Imbrenda <imbrenda@linux.ibm.com>
  */
 
-#ifndef __KVM_S390_DAT_H
-#define __KVM_S390_DAT_H
+#ifndef ARCH_KVM_GMAP_DAT_H
+#define ARCH_KVM_GMAP_DAT_H
 
 #include <linux/radix-tree.h>
 #include <linux/refcount.h>
@@ -975,4 +975,4 @@ static inline bool crste_is_ucas(union crste crste)
 	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl == 1 && crste.h.fc == 0;
 }
 
-#endif /* __KVM_S390_DAT_H */
+#endif /* ARCH_KVM_GMAP_DAT_H */
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index d89d1c381522..700d9b7b68bc 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -12,7 +12,7 @@
 #include <linux/kvm_host.h>
 #include <asm/gmap_helpers.h>
 #include <asm/virtio-ccw.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "trace.h"
 #include "trace-s390.h"
 #include "gaccess.h"
diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index fee80047bd94..740415d494de 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -9,10 +9,11 @@
 #include <linux/kvm_host.h>
 
 #include "gmap.h"
-#include "trace.h"
 #include "faultin.h"
 
 bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu);
+#define CREATE_TRACE_POINTS
+#include "trace-gmap.h"
 
 /*
  * kvm_s390_faultin_gfn() - handle a dat fault.
diff --git a/arch/s390/kvm/faultin.h b/arch/s390/kvm/faultin.h
index f86176d2769c..f343b6fb6f16 100644
--- a/arch/s390/kvm/faultin.h
+++ b/arch/s390/kvm/faultin.h
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
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 36102b2727fb..2a4b2525329a 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -17,7 +17,7 @@
 #include <asm/access-regs.h>
 #include <asm/fault.h>
 #include <asm/dat-bits.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "dat.h"
 #include "gmap.h"
 #include "gaccess.h"
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index b5385cec60f4..ef922b3b4990 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -14,7 +14,7 @@
 #include <linux/kvm_host.h>
 #include <linux/uaccess.h>
 #include <linux/ptrace.h>
-#include "kvm-s390.h"
+#include "s390.h"
 
 /**
  * kvm_s390_real_to_abs - convert guest real address to guest absolute address
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 8abb4f55b306..9ae55a1d6f09 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -21,7 +21,7 @@
 
 #include "dat.h"
 #include "gmap.h"
-#include "kvm-s390.h"
+#include "s390.h"
 #include "faultin.h"
 
 static inline bool kvm_s390_is_in_sie(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 39938d363ec9..c54c35e47d6d 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -7,8 +7,8 @@
  *               Claudio Imbrenda <imbrenda@linux.ibm.com>
  */
 
-#ifndef ARCH_KVM_S390_GMAP_H
-#define ARCH_KVM_S390_GMAP_H
+#ifndef ARCH_KVM_GMAP_GMAP_H
+#define ARCH_KVM_GMAP_GMAP_H
 
 #include "dat.h"
 
@@ -330,4 +330,4 @@ static inline bool gmap_is_shadow_valid(struct gmap *sg, union asce asce, int ed
 	return sg->guest_asce.val == asce.val && sg->edat_level == edat_level;
 }
 
-#endif /* ARCH_KVM_S390_GMAP_H */
+#endif /* ARCH_KVM_GMAP_GMAP_H */
diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 69835e1d4f20..c880ebbdef2f 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -8,7 +8,7 @@
  */
 #include <linux/kvm_host.h>
 #include <linux/errno.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 
 /*
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 1980df61ef30..ca1205dfac8b 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -17,7 +17,7 @@
 #include <asm/sysinfo.h>
 #include <asm/uv.h>
 
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 #include "trace.h"
 #include "trace-s390.h"
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 7514d9e2403c..cdbbfca211b1 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -29,7 +29,7 @@
 #include <asm/nmi.h>
 #include <asm/airq.h>
 #include <asm/tpi.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 #include "trace-s390.h"
 #include "pci.h"
diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 50f5ec79600e..82892e1e03d9 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -14,7 +14,7 @@
 #include <asm/pci_io.h>
 #include <asm/sclp.h>
 #include "pci.h"
-#include "kvm-s390.h"
+#include "s390.h"
 
 struct zpci_aift *aift;
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ad0ddc433a73..21479f0a5e5a 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -26,7 +26,7 @@
 #include <asm/ap.h>
 #include <asm/gmap_helpers.h>
 #include "gaccess.h"
-#include "kvm-s390.h"
+#include "s390.h"
 #include "trace.h"
 #include "gmap.h"
 
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 1beacc841ca8..f6e03e9d371a 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -18,7 +18,7 @@
 #include <linux/sched/mm.h>
 #include <linux/mmu_notifier.h>
 #include <asm/gmap_helpers.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "dat.h"
 #include "gaccess.h"
 #include "gmap.h"
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/s390.c
similarity index 99%
rename from arch/s390/kvm/kvm-s390.c
rename to arch/s390/kvm/s390.c
index 150b5dd2170e..f1962cf61cc1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/s390.c
@@ -50,7 +50,7 @@
 #include <asm/fpu.h>
 #include <asm/ap.h>
 #include <asm/uv.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 #include "gmap.h"
 #include "faultin.h"
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/s390.h
similarity index 99%
rename from arch/s390/kvm/kvm-s390.h
rename to arch/s390/kvm/s390.h
index 6d2842fb71a3..e144ca2e6d5e 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/s390.h
@@ -452,7 +452,7 @@ void kvm_s390_vsie_destroy(struct kvm *kvm);
 int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
 
-/* implemented in kvm-s390.c */
+/* implemented in s390.c */
 int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clock *gtod);
 int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
 int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 55c34cb35428..131b3371ef4f 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -14,7 +14,7 @@
 #include <linux/slab.h>
 #include <asm/sigp.h>
 #include "gaccess.h"
-#include "kvm-s390.h"
+#include "s390.h"
 #include "trace.h"
 
 static int __sigp_sense(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
diff --git a/arch/s390/kvm/trace-gmap.h b/arch/s390/kvm/trace-gmap.h
new file mode 100644
index 000000000000..c139b4ef75f6
--- /dev/null
+++ b/arch/s390/kvm/trace-gmap.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(GMAP_TRACE_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define GMAP_TRACE_KVM_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace-gmap
+
+#define __KVM_FIELDS \
+	__field(unsigned long, pswmask) \
+	__field(unsigned long, pswaddr)
+#define __KVM_ASSIGN ({\
+	__entry->pswmask = vcpu->arch.sie_block->gpsw.mask; \
+	__entry->pswaddr = vcpu->arch.sie_block->gpsw.addr; \
+	})
+#define __KVM_PRINT \
+	__entry->pswmask,\
+	__entry->pswaddr
+
+TRACE_EVENT(kvm_s390_major_guest_pfault,
+	    TP_PROTO(struct kvm_vcpu *vcpu),
+	    TP_ARGS(vcpu),
+
+	    TP_STRUCT__entry(
+		__field(int, id)
+		__KVM_FIELDS
+		),
+
+	    TP_fast_assign(
+		__entry->id = vcpu->vcpu_id;
+		__KVM_ASSIGN
+		),
+	    TP_printk("%02d[%016lx-%016lx]: major fault, maybe applicable for pfault",
+		__entry->id,
+		__KVM_PRINT
+		)
+	    );
+
+#endif /* GMAP_TRACE_KVM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
index aa419eb6a0c8..97774fe09a85 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -45,20 +45,6 @@ TRACE_EVENT(kvm_s390_skey_related_inst,
 	    VCPU_TP_PRINTK("%s", "storage key related instruction")
 	);
 
-TRACE_EVENT(kvm_s390_major_guest_pfault,
-	    TP_PROTO(VCPU_PROTO_COMMON),
-	    TP_ARGS(VCPU_ARGS_COMMON),
-
-	    TP_STRUCT__entry(
-		    VCPU_FIELD_COMMON
-		    ),
-
-	    TP_fast_assign(
-		    VCPU_ASSIGN_COMMON
-		    ),
-	    VCPU_TP_PRINTK("%s", "major fault, maybe applicable for pfault")
-	);
-
 TRACE_EVENT(kvm_s390_pfault_init,
 	    TP_PROTO(VCPU_PROTO_COMMON, long pfault_token),
 	    TP_ARGS(VCPU_ARGS_COMMON, pfault_token),
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index eea24562e7db..c4a03b310fea 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -23,7 +23,7 @@
 #include <asm/nmi.h>
 #include <asm/dis.h>
 #include <asm/facility.h>
-#include "kvm-s390.h"
+#include "s390.h"
 #include "gaccess.h"
 #include "gmap.h"
 
-- 
2.53.0

