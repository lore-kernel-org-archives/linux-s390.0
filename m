Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD8471423;
	Wed, 12 Aug 2026 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549043; cv=none; b=HcOTZR6jxeIqftfatPPexqUaWtH2D1aXhdvdlyBTYgsDuQsRCu0QdFJRdqL+9OE4CfaDDRWG/QIt4rmeg0vRE+ZOJFP5k9Ijz6N+RUel60oHSrVGE4luhkveZJM6kkShagN+VqHQmYyYFkqjdtmMBMoeqcQNRLN3G3DsT4B2sQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549043; c=relaxed/simple;
	bh=mNDJLL+X7x5IXUz2PRNbPQpBACZpu5XpiBijF6Zcx+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CT9na467wcfMvqYxlYjRR5MfMQLfRBXRXjNnzXV5DZBXmGzQuQYUzZK4IJgSNGjSuXOptwZuDSvEz5hyV0wYMxBj/3RUaM1Xb3IkgRAsHItQUOvNgm80xr2txE/V1b+vID9MutCBXCFT+oFDL3ao1NEBBMu4ydLwsDtn67rnCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jfwd6iqX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jfwd6iqX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE2P7i2587089;
	Wed, 12 Aug 2026 15:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=O/4/U7qdF3Wp8JP24zlPeBIfZ9sQGl88XGEYi9ItW
	1Q=; b=Jfwd6iqXYU/8D7EPMvbatTGCmuf+1VIsmEOeG0gkZyr2yrbVm+Xrrwjmh
	wjgdcC191eRRaVAXCpcJNbHQg6yrHpP8mF5y4MJvI1Yd79IN+BgBPk0bitxB3o/0
	JYK9WuNapupm9lJklDfSNIKc1pPJfQame6DefRufD6jeMYtsKIIzLrLyIXmxkiJJ
	aqNLCPbG7B9diYRehDr5CoGFB9bxM/o/03MExvOm2X6rHeu6A59xg/yTAXyzMeZ7
	0lufl+8T5HwY+RC09IqymSIGpC7kUxEDmw89YiZodgpjHAn6aNPhMW/Sg2B+KSPT
	X8c3HdicyGWOZ6v9p4dJmmVKPM4fA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23usfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQLfT023705;
	Wed, 12 Aug 2026 15:36:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gejfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFaWbX35717602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60A3320049;
	Wed, 12 Aug 2026 15:36:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8FE82004B;
	Wed, 12 Aug 2026 15:36:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:31 +0000 (GMT)
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
Subject: [PATCH v6 00/33] KVM: s390: Introduce arm64 KVM
Date: Wed, 12 Aug 2026 17:35:56 +0200
Message-ID: <20260812153631.3376090-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c9306 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ItC9PRHstqwZeWF_CHMA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX4tcH5FT6+UC/
 6jCsF0N0BHzUEC6gpluIM3EonmpsxyRZIK8kHSahh2BOUynK9UhY0qHYS8fQni/BmlOBcF7p7LX
 XwhHRVU5DUluTJ0QucEX3pyJlyBrXUPB/u+6C6swGxmOtWuCqVoJuPrxf+xf91CoSXuG6hNX7lh
 l/Vm3UWO8npd0qK1KtaWysKzSjh0egeLAUmst/gk+w0S8KEr8vr+Cd/HnllOftKjSquUGj2ROm3
 R2mv4i95oRFisozgFla0NpgiQYyObCQnK/DDFHJUI2CrqfyNxAzhEyuAmgYtLkk6RtNXBeG6eqO
 DTvUed3knmm5h92Ky+YC0wDlOblWmqmc/lKmBtBb3yyzSF1gYnrENKRHFsf4wUr8g02RsU/eqJt
 rqI+bUlSYfArofc8cwEyzZaIAhNKJEVtdttXoDUPyXGch471BQoEmE9k7zufOr/VVgjoGhedO6H
 cXb4CcmcsDCvFW4aXjw==
X-Proofpoint-ORIG-GUID: 38o5_mDCZXTBhqEGLOGhHbTue4DJvgdw
X-Proofpoint-GUID: 1Q3hi4Lze_vi-1Op_L9nJEflCY2uqNoQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfXyUScVktCmUC3
 RpOchKgV32zs1qwR1LHTc6Kv8UyI975RABZkRKTb9bmly6QvyXS90j1RNWeIRI59lZ8fYnzfnwQ
 YIIH5OekfyD8jQOkHAb66J+FX4RPdk4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126

Introduce arm-on-s390. Enable KVM-accelerated ARM CPU virtualisation on s390.

For the original, now partially outdated, cover letter, have a look at versions
one to three [1].

To share arm64 code with arm-on-s390 KVM, s390 extracts relevant parts of arm64
definitions and implementation and uses them locally. This results in minimal
changes to existing arm64 code and headers.

To enable s390 to selectively extract relevant definitions while skipping
architecture-specific code (e.g., arm64 assembly), a shared marker is
introduced. The ARM64_S390_COMMON macro marks regions of arm64 code that
are shared with s390:

  in arch/arm64/kvm/<code>.c

  <arm64 local code>
  #ifdef ARM64_S390_COMMON
  <shared code>
  #endif /* ARM64_S390_COMMON */
  <arm64 local code>
  
ARM64_S390_COMMON is defined for all arm64 compilation units.

During the s390 build, an allow-list of arm64 headers is extracted into
arch/s390/include/generated/arm64/. If a header contains at least one
shared region, only those regions are copied along with the include guard.
If no shared region is found, s390 uses the full header, which is copied
in its entirety. In such cases, a comment is added at the top of the
header to notify arm64 developers that the file is shared with s390 and
changes may impact s390.

For C files, the process is similar. Selected KVM/arm64 C files are
partially extracted into arch/s390/kvm/arm64/generated/code.inc. The s390
arm64 KVM implementation includes these snippets to reuse arm64 code
without changing linkage.

Userspace tools requiring KVM/arm64 uapi on s390 must use a vendored KVM API,
as s390 will not ship nor install arm64 KVM uapi headers.

This approach reduces the churn, especially for arm64 while keeping the
maintenance burden low.


Series structure

A) KVM symbol cleanup and refactoring (patches 1-3):
   Prepare KVM to support two KVM modules in parallel. Clean up KVM module
   symbol exports, making it possible to load two KVM modules side by side.
   Make the KVM device name configurable and allow KVM implementations to
   disable MMIO regardless of CONFIG_KVM_MMIO.

B) Arm64 header and code sharing preparation (patches 4-11): Mark shareable
   parts with ARM64_S390_COMMON. But first perform minor refactoring to ease
   integration into s390. All the refactoring/cleanup/fix patches could be
   picked before the actual share-marker commits (10/11)

C) KVM/s390 reorganization (patches 12-22):
   Prepare s390 for a second KVM module. Move existing s390 KVM code into
   dedicated s390 and gmap subdirectories to make room for a second KVM
   implementation. Refactor gmap to better integrate with the second KVM
   implementation. GMAP hides a few features only required when managing s390
   guests: Storage keys, CMMA, and prefix handling. Those are guarded behind an
   #if KVM_S390_MANAGES_S390_GUEST. Only features which implementation would
   break kvm-arm64 code are guarded. I leave the non-breaking stuff (like
   shadow-gmaps or ucontrol) for the LTO.

D) Code sharing infrastructure for s390 (patches 23 & 24):
   Add Makefile and scripts to extract and build arm64 headers and code for
   use by s390.

E) KVM on s390 (patches 25-33):
   Introduce the SAE (Start Arm Execution) instruction as the s390
   mechanism for running arm64 guests. Build up the new kvm-arm64 module
   incrementally.

A, B, C and D could be picked individually without requiring the others so they
could go through different trees if required. E obviously requires A-D.

Based on next-20260811.

	Steffen

Changes from v5 [3]:
   - fix multiple rcu and use after free issues in vfio
   - multiple smaller mostly cosmetic improvements
arm64:
   - fixed regression in compat enum & cleaned up
   - fixed SPSR_ELx definitions
   - removed reset_core_reg extracting which is now is already done (thanks Fuad)
   - renamed and moved register access function to vcpu_<foo> to kvm_emulate.h
     they are now at the same position and naming scheme like the preexisting ones
   - fix resetting reserved field in fpsimd

s390:
   - gmap: Guard and not move s390-guest only gmap-code
   - split refactoring into more patches to ease review
   - fixed minor bugs in header/code shared code generation
   - Kconfig reorganization: 
      - removed KVM_S390, the KVM for s390 guests keeps using by CONFIG_KVM
      - KVM_ARM64 now depends on KVM 
      - KVM is selectable (as it was before this series)
      - All (s390) KVM configs are in arch/s390/kvm/Kconfig

Changes from v4 [2]:
- do not remove CONFIG_KVM_MMIO but let KVM/s390 opt out of MMIO
- use kstrdup_const for copying the kvm-device name
- use file based vfio tracking instead of inlining struct kvm refcounting
arm64: 
    - reorganized arm64 code share & refactoring - first refactoring then sharing
    - add arm64 refactoring to reduce shared regions
    - shared a bit more function (definitions) to reduce no of shared regions
      (which would be shared in later series anyways)
    - add patch to generate SPSR sysreg definitions
    - add patch which defines an enum for the arm32 compat registers
s390:
    - fix arm64 header generation wiring
    - awk scripts are more robust and error out if an end marker is missing
    - postfix combined headers with -gen instead of -part
    - removed pre-fault-memory implementation
    - implemented system supported feature sanitisation
    - removed some unnecessary functions
    - moved prefix, cmma, and storage key code from gmap to kvm/s390
    - properly reset vxregs

Changes from v3

- Complete rework of the code sharing approach
- Introduced ARM64_S390_COMMON marker for selective extraction
- Build-time extraction instead of development-time sharing
- Minimal impact on arm64 codebase
- Improved gmap refactoring and integration

[1] Previous versions: 
 v1 https://lore.kernel.org/all/20260402042125.3948963-1-seiden@linux.ibm.com/
 v2 https://lore.kernel.org/all/20260428155622.1361364-1-seiden@linux.ibm.com/
 v3 https://lore.kernel.org/all/20260529155050.2902245-1-seiden@linux.ibm.com/

[2] https://lore.kernel.org/all/20260706085229.979525-1-seiden@linux.ibm.com/
[3] https://lore.kernel.org/all/20260731130902.654679-1-seiden@linux.ibm.com/ 

Hendrik Brueckner (1):
  s390/hwcaps: Report SAE support as hwcap

Steffen Eiden (32):
  vfio: Use file-based reference counting for KVM
  KVM: Make device name configurable
  KVM: Allow KVM implementations to switch off MMIO independent of
    Kconfig
  arm64: Use proper include variant
  arm64: ptrace: Use constants for compat register numbers
  arm64: sysreg: Convert SPSR_ELx to automatic register generation
  KVM: arm64: Access elements of vcpu_gp_regs individually
  KVM: arm64: Use accessor functions for core regs
  arm64: Prepare sharing arm64 headers with s390
  arm64: Share arm64 headers with s390
  KVM: arm64: Share arm64 code with s390
  KVM: s390: Extract gmap tracing to a separate header
  KVM: s390: Prepare include guards for a new location
  KVM: s390: Rename kvm-s390.{c,h} to s390.{c,h}
  KVM: s390: Move kvm_host definitions to kvm_host_s390
  KVM: s390: Move s390 kvm code into a subdirectory
  KVM: s390: Move PGM code definitions to asm/kvm_host.h
  KVM: s390: Prepare gmap for a second KVM implementation
  KVM: s390: gmap: Make storage keys optional
  KVM: s390: gmap: Make CMMA optional
  KVM: s390: gmap: Make prefix handling optional
  KVM: s390: Prepare KVM/s390 for a second KVM module
  s390: Use arm64 headers
  KVM: s390: Use arm64 code
  s390: Introduce Start Arm Execution instruction
  KVM: s390: arm64: Introduce host definitions
  KVM: s390: Add basic arm64 kvm module
  KVM: s390: arm64: Implement required functions
  KVM: s390: arm64: Implement vm/vcpu create destroy.
  KVM: s390: arm64: Implement vCPU IOCTLs
  KVM: s390: arm64: Implement basic page fault handler
  KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild

 MAINTAINERS                                   |   2 +-
 arch/arm64/Makefile                           |   2 +
 arch/arm64/include/asm/brk-imm.h              |   1 +
 arch/arm64/include/asm/esr.h                  |   5 +-
 arch/arm64/include/asm/kvm_arm.h              |   6 +-
 arch/arm64/include/asm/kvm_emulate.h          |  69 +-
 arch/arm64/include/asm/kvm_host.h             |  81 +-
 arch/arm64/include/asm/ptrace.h               |  64 +-
 arch/arm64/include/asm/sysreg.h               |  22 +-
 arch/arm64/kvm/arm.c                          |   3 +
 arch/arm64/kvm/guest.c                        |  22 +-
 arch/arm64/kvm/handle_exit.c                  |   6 +
 arch/arm64/kvm/hyp/exception.c                |   4 +-
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h    |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |   4 +-
 arch/arm64/kvm/mmio.c                         |   2 +
 arch/arm64/tools/sysreg                       |  48 ++
 arch/s390/configs/debug_defconfig             |   1 +
 arch/s390/configs/defconfig                   |   1 +
 arch/s390/include/arm64/kvm_emulate.h         | 130 +++
 arch/s390/include/arm64/kvm_nested.h          |  11 +
 arch/s390/include/arm64/ptrace.h              |  11 +
 arch/s390/include/arm64/sysreg.h              |  13 +
 arch/s390/include/asm/Kbuild                  |   3 +
 arch/s390/include/asm/asm-prototypes.h        |   1 +
 arch/s390/include/asm/elf.h                   |   2 +
 arch/s390/include/asm/kvm.h                   |   6 +
 arch/s390/include/asm/kvm_host.h              | 730 +----------------
 arch/s390/include/asm/kvm_host_arm64.h        | 220 ++++++
 arch/s390/include/asm/kvm_host_arm64_types.h  | 118 +++
 .../asm/{kvm_host.h => kvm_host_s390.h}       |  66 +-
 ...kvm_host_types.h => kvm_host_s390_types.h} |   6 +-
 arch/s390/include/asm/kvm_host_types.h        | 353 +--------
 arch/s390/include/asm/sae.h                   |  57 ++
 arch/s390/include/asm/sclp.h                  |   5 +-
 arch/s390/include/asm/stacktrace.h            |   5 +
 arch/s390/kernel/asm-offsets.c                |   1 +
 arch/s390/kernel/entry.S                      |  22 +
 arch/s390/kernel/processor.c                  |   3 +
 arch/s390/kvm/Kconfig                         |  29 +
 arch/s390/kvm/Makefile                        |  12 +-
 arch/s390/kvm/arm64/.gitignore                |   2 +
 arch/s390/kvm/arm64/Makefile                  |  91 +++
 arch/s390/kvm/arm64/Makefile.gen              |  29 +
 arch/s390/kvm/arm64/arm.c                     | 746 ++++++++++++++++++
 arch/s390/kvm/arm64/arm.h                     |  63 ++
 arch/s390/kvm/arm64/copy-arm64c.awk           |  72 ++
 arch/s390/kvm/arm64/guest.c                   | 135 ++++
 arch/s390/kvm/arm64/handle_exit.c             | 131 +++
 arch/s390/kvm/arm64/handle_exit.h             |   9 +
 arch/s390/kvm/arm64/inject_fault.c            |  21 +
 arch/s390/kvm/arm64/mmio.c                    |  15 +
 arch/s390/kvm/arm64/mmu.c                     | 177 +++++
 arch/s390/kvm/arm64/reset.c                   |  73 ++
 arch/s390/kvm/arm64/reset.h                   |  11 +
 arch/s390/kvm/arm64/trace.h                   |  42 +
 arch/s390/kvm/gmap/Makefile                   |   5 +
 arch/s390/kvm/{ => gmap}/dat.c                |   4 +
 arch/s390/kvm/{ => gmap}/dat.h                |  21 +-
 arch/s390/kvm/{ => gmap}/faultin.c            |   8 +-
 arch/s390/kvm/{ => gmap}/faultin.h            |   6 +-
 arch/s390/kvm/{ => gmap}/gmap.c               |  23 +-
 arch/s390/kvm/{ => gmap}/gmap.h               |  25 +-
 arch/s390/kvm/gmap/kvm_mmu.c                  | 137 ++++
 arch/s390/kvm/gmap/kvm_mmu.h                  |  18 +
 arch/s390/kvm/gmap/trace_gmap.h               |  64 ++
 arch/s390/kvm/s390/Makefile                   |  14 +
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
 arch/s390/kvm/{kvm-s390.c => s390/s390.c}     | 136 +---
 arch/s390/kvm/{kvm-s390.h => s390/s390.h}     |  10 +-
 arch/s390/kvm/{ => s390}/sigp.c               |   2 +-
 arch/s390/kvm/{ => s390}/trace-s390.h         |   0
 arch/s390/kvm/{ => s390}/trace.h              |  14 -
 arch/s390/kvm/{ => s390}/vsie.c               |   2 +-
 arch/s390/tools/Makefile                      |   9 +-
 arch/s390/tools/Makefile.arm64h               |  57 ++
 arch/s390/tools/copy-arm64h-full.awk          |  47 ++
 arch/s390/tools/copy-arm64h.awk               |  72 ++
 arch/s390/tools/opcodes.txt                   |   3 +
 arch/x86/include/asm/kvm_page_track.h         |   8 +-
 arch/x86/kvm/Makefile                         |   3 -
 arch/x86/kvm/mmu/page_track.c                 |  16 +-
 drivers/s390/char/sclp_early.c                |   1 +
 drivers/s390/crypto/vfio_ap_ops.c             |  30 +-
 drivers/s390/crypto/vfio_ap_private.h         |   1 +
 drivers/vfio/device_cdev.c                    |   2 +-
 drivers/vfio/group.c                          |   4 +-
 drivers/vfio/pci/vfio_pci_zdev.c              |   7 +-
 drivers/vfio/vfio.h                           |  10 +-
 drivers/vfio/vfio_main.c                      |  52 +-
 include/linux/kvm_host.h                      |  11 +-
 include/linux/vfio.h                          |   5 +-
 virt/kvm/async_pf.c                           |  13 +-
 virt/kvm/async_pf.h                           |   4 +-
 virt/kvm/coalesced_mmio.c                     |   4 +
 virt/kvm/coalesced_mmio.h                     |   2 +-
 virt/kvm/kvm_main.c                           |  73 +-
 virt/kvm/vfio.c                               |   8 +-
 107 files changed, 3241 insertions(+), 1476 deletions(-)
 create mode 100644 arch/s390/include/arm64/kvm_emulate.h
 create mode 100644 arch/s390/include/arm64/kvm_nested.h
 create mode 100644 arch/s390/include/arm64/ptrace.h
 create mode 100644 arch/s390/include/arm64/sysreg.h
 create mode 100644 arch/s390/include/asm/kvm.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
 copy arch/s390/include/asm/{kvm_host.h => kvm_host_s390.h} (90%)
 copy arch/s390/include/asm/{kvm_host_types.h => kvm_host_s390_types.h} (98%)
 create mode 100644 arch/s390/include/asm/sae.h
 create mode 100644 arch/s390/kvm/arm64/.gitignore
 create mode 100644 arch/s390/kvm/arm64/Makefile
 create mode 100644 arch/s390/kvm/arm64/Makefile.gen
 create mode 100644 arch/s390/kvm/arm64/arm.c
 create mode 100644 arch/s390/kvm/arm64/arm.h
 create mode 100644 arch/s390/kvm/arm64/copy-arm64c.awk
 create mode 100644 arch/s390/kvm/arm64/guest.c
 create mode 100644 arch/s390/kvm/arm64/handle_exit.c
 create mode 100644 arch/s390/kvm/arm64/handle_exit.h
 create mode 100644 arch/s390/kvm/arm64/inject_fault.c
 create mode 100644 arch/s390/kvm/arm64/mmio.c
 create mode 100644 arch/s390/kvm/arm64/mmu.c
 create mode 100644 arch/s390/kvm/arm64/reset.c
 create mode 100644 arch/s390/kvm/arm64/reset.h
 create mode 100644 arch/s390/kvm/arm64/trace.h
 create mode 100644 arch/s390/kvm/gmap/Makefile
 rename arch/s390/kvm/{ => gmap}/dat.c (99%)
 rename arch/s390/kvm/{ => gmap}/dat.h (98%)
 rename arch/s390/kvm/{ => gmap}/faultin.c (96%)
 rename arch/s390/kvm/{ => gmap}/faultin.h (96%)
 rename arch/s390/kvm/{ => gmap}/gmap.c (99%)
 rename arch/s390/kvm/{ => gmap}/gmap.h (96%)
 create mode 100644 arch/s390/kvm/gmap/kvm_mmu.c
 create mode 100644 arch/s390/kvm/gmap/kvm_mmu.h
 create mode 100644 arch/s390/kvm/gmap/trace_gmap.h
 create mode 100644 arch/s390/kvm/s390/Makefile
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
 rename arch/s390/kvm/{kvm-s390.c => s390/s390.c} (98%)
 rename arch/s390/kvm/{kvm-s390.h => s390/s390.h} (98%)
 rename arch/s390/kvm/{ => s390}/sigp.c (99%)
 rename arch/s390/kvm/{ => s390}/trace-s390.h (100%)
 rename arch/s390/kvm/{ => s390}/trace.h (97%)
 rename arch/s390/kvm/{ => s390}/vsie.c (99%)
 create mode 100644 arch/s390/tools/Makefile.arm64h
 create mode 100644 arch/s390/tools/copy-arm64h-full.awk
 create mode 100644 arch/s390/tools/copy-arm64h.awk


base-commit: 5e6de6a2b522f659defacb1551d0465ba6ce13cf
-- 
2.53.0

