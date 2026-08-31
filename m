Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFAC373C1D;
	Mon, 31 Aug 2026 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187713; cv=none; b=S8wEjd1xXyT2Trj955B8rWJJ4zj+mYjqLJYUcOzwG/Danx7FeqDOF7gaz7QG3VTUJlQF7ybfjdsadkEMvqRmu/bmtbs1LLZZr+qXw3Kmu/pVpWdJYSZYOs8Q85t5Bx9401bey7RXD0xwHLAWJqBNZ81XxNNJ0/ea3aylX6LgZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187713; c=relaxed/simple;
	bh=Zlamo5jTSDNSTMKMRYlkoYOFLUW9ihFB4d8eYL46sdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhsWl5A7csniRsn+nOd67QqlggzKj3qmRcVJlKLG5JghYssyaxM+RCWbtygwFRttzg746ZaBc2ZAMpiIOxUxbmo7O8xsaOk+d5qf6yI+aGBtBgUjH/p3xL0AMY8BfBUHK8aCxtLIGgAgYInBrD1aZCvF/XM3SymiF7g07H+LlKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i5/1ne8e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i5/1ne8e"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZHDO2415081;
	Mon, 31 Aug 2026 14:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bK4cC7PFca5ELQn8KExT5fn8C0VsWwCGEoqG6aI9O
	58=; b=i5/1ne8e9eok7hw33xmOnEnKaGwLYueiJwMM46TUdpKFIA+G+OuTfac9q
	hdNOrNAZVvAZs/Xj20mFagIOGfSBifG3Qc4vZ0bJsTn+Arf1TJcDYMx1ibLEavUY
	5AwuYVFbbelwrChQrzmkcGKn/FJA3TedzXWdw01jFIiwHJ4/r16YVCEQH8BHZDR+
	MoSidbenx5ZXjkLOqt3n40Qe+I/5yRPSWkxNZhININS5LAuV8U7Re58/FCxXWLpD
	uiN9C0YhHnh7exNRJ/MuPv79ihNwEyAXpyxJ2YRgx5iFpTUwGFelx6Fru510CNEL
	Fa8z58InGHA9vR0NEeJJROjvVI84g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhj4qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfgYq016996;
	Mon, 31 Aug 2026 14:48:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vxhgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEm35S33423774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:48:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 297442004B;
	Mon, 31 Aug 2026 14:48:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9DE820043;
	Mon, 31 Aug 2026 14:48:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:48:02 +0000 (GMT)
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
Subject: [PATCH v7 00/23] KVM: s390: Introduce arm64 KVM
Date: Mon, 31 Aug 2026 16:47:37 +0200
Message-ID: <20260831144802.834315-1-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: U9iJH5GpMZBhyDvSZcQOu3zNqpv-EbEi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX2FdZg+mmmiW8
 1snSfJnACyLd5gKBb7kWThHNPzwNLVG3DGiuS95hqW4+GRei3HzpArUI2SeLlKGvasW1x+PjuQG
 2OibgMEINbr++bxNoFXJ3kgxzmH3Tih/91+HrJbMsGQfb6guU9VVt9FuzVLVA6NClH5D9970HWe
 5jICdm7o/trAZEn6HH/v5SS14JUEjTO+Aak5hkb5YvGB9Kekys25bDjv06e+jlNGdbWeoh9+5CP
 8WiYz6dFHcmW2Bc/McOXXCWyX3DRibqkhtUobzz+0iOBFcesNu8smghmxjI+RA0L78AC+TDg4Ba
 VAYKMnjzpbCFnfb1eWzMELxW+PWytFxuzUJIarHTehVIGoNfllCwGkSo6Rj/jsTz0nEgoICgWEk
 LT9YfcIPLOSlLrfR2MBznOtJHC/rNK4WEd1OTw9spwOFuXh9Ssnz7YldhvnTzw+YivPbRBeO2Hs
 YjC49iL9ETpAst4NYhw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a959428 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=vZ1yADyhxQgHX5qgNpMA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXxrVmN6qQC9cN
 qGOnwMP+wbYlgofqW/paHEm1i926paylyw1LBguIDBc0RVbcShvrSnVOq3nE5Gm+PWtx4uumXQr
 KBoVXBxFw3XO19TmZTm3X03U+hzR9sc=
X-Proofpoint-ORIG-GUID: HlFFv_tgqKYXt2H3wDLZie587wPR3J42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

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

The goal is to share as much functionality as possible.

Userspace tools requiring KVM/arm64 uapi on s390 must use a vendored KVM API,
as s390 will not ship nor install arm64 KVM uapi headers.

This approach reduces the churn, especially for arm64 while keeping the
maintenance burden low.


Series structure

A) KVM symbol cleanup and refactoring (patches 1-3):
   Prepare KVM to support two KVM modules in parallel (spin-off: [5]). Clean up
   KVM module symbol exports, making it possible to load two KVM modules side
   by side. Make the KVM device name configurable and allow KVM implementations
   to disable MMIO regardless of CONFIG_KVM_MMIO.

B) Arm64 header and code sharing preparation (patches 4-11): Mark shareable
   parts with ARM64_S390_COMMON. But first perform minor refactoring to ease
   integration into s390. All the refactoring/cleanup/fix patches could be
   picked before the actual share-marker commits (10/11)

C) Code sharing infrastructure for s390 (patches 12 & 13):
   Add Makefile and scripts to extract and build arm64 headers and code for
   use by s390.

D) KVM on s390 (patches 14-23):
   Introduce the SAE (Start Arm Execution) instruction as the s390
   mechanism for running arm64 guests. Build up the new kvm-arm64 module
   incrementally.

A, B, and C could be picked individually without requiring the others so they
could go through different trees if required. D obviously requires A-C.

Based on v7.3-rc1.


	Steffen

Changes from v6 [4]:
  - Fix vfio <-> kvm keepalive
  - add Reviewed-bys and ACKs
arm64:
  - fix SPSR_ELx description
  - use kvm_arch_flag_bits enum instead of multiple defines
  - minor requested changes
s390:
  - fix various smaller issues
  - removed picked s390 refactoring patches (thanks Christian)

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
[4] https://lore.kernel.org/all/20260812153631.3376090-1-seiden@linux.ibm.com/
[5] https://lore.kernel.org/all/20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com

Hendrik Brueckner (1):
  s390/hwcaps: Report SAE support as hwcap

Steffen Eiden (22):
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
  s390/tools: Use arm64 headers
  KVM: s390: Use arm64 code
  KVM: s390: Prepare KVM/s390 for a second KVM module
  s390: Introduce Start Arm Execution instruction
  KVM: s390: arm64: Introduce host definitions
  KVM: s390: Add basic arm64 kvm module
  KVM: s390: arm64: Implement required functions
  KVM: s390: arm64: Implement vm/vcpu create destroy.
  KVM: s390: arm64: Implement vCPU IOCTLs
  KVM: s390: arm64: Implement basic page fault handler
  KVM: s390: arm64: Add KVM_S390_ARM64 Kconfig and Makefile

 MAINTAINERS                                  |   1 +
 arch/arm64/Makefile                          |   5 +
 arch/arm64/include/asm/brk-imm.h             |   1 +
 arch/arm64/include/asm/esr.h                 |   5 +-
 arch/arm64/include/asm/kvm_arm.h             |   6 +-
 arch/arm64/include/asm/kvm_emulate.h         |  69 +-
 arch/arm64/include/asm/kvm_host.h            | 117 +--
 arch/arm64/include/asm/ptrace.h              |  64 +-
 arch/arm64/include/asm/sysreg.h              |  22 +-
 arch/arm64/kvm/arm.c                         |   3 +
 arch/arm64/kvm/guest.c                       |  22 +-
 arch/arm64/kvm/handle_exit.c                 |   6 +
 arch/arm64/kvm/hyp/exception.c               |   4 +-
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h   |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h      |   4 +-
 arch/arm64/kvm/mmio.c                        |   2 +
 arch/arm64/tools/sysreg                      |  51 ++
 arch/s390/configs/debug_defconfig            |   1 +
 arch/s390/configs/defconfig                  |   1 +
 arch/s390/include/arm64/kvm_emulate.h        | 130 ++++
 arch/s390/include/arm64/kvm_nested.h         |  11 +
 arch/s390/include/arm64/ptrace.h             |  11 +
 arch/s390/include/arm64/sysreg.h             |  13 +
 arch/s390/include/asm/Kbuild                 |   3 +
 arch/s390/include/asm/asm-prototypes.h       |   1 +
 arch/s390/include/asm/elf.h                  |   2 +
 arch/s390/include/asm/kvm.h                  |   6 +
 arch/s390/include/asm/kvm_host.h             |   9 +
 arch/s390/include/asm/kvm_host_arm64.h       | 211 ++++++
 arch/s390/include/asm/kvm_host_arm64_types.h | 118 +++
 arch/s390/include/asm/kvm_host_s390.h        |   1 +
 arch/s390/include/asm/kvm_host_types.h       |   4 +
 arch/s390/include/asm/sae.h                  |  57 ++
 arch/s390/include/asm/sclp.h                 |   5 +-
 arch/s390/include/asm/stacktrace.h           |   5 +
 arch/s390/kernel/asm-offsets.c               |   1 +
 arch/s390/kernel/entry.S                     |  22 +
 arch/s390/kernel/processor.c                 |   3 +
 arch/s390/kvm/Kconfig                        |  29 +
 arch/s390/kvm/Makefile                       |   1 +
 arch/s390/kvm/arm64/.gitignore               |   2 +
 arch/s390/kvm/arm64/Makefile                 |  91 +++
 arch/s390/kvm/arm64/Makefile.gen             |  27 +
 arch/s390/kvm/arm64/arm.c                    | 758 +++++++++++++++++++
 arch/s390/kvm/arm64/arm.h                    |  61 ++
 arch/s390/kvm/arm64/copy-arm64c.awk          |  72 ++
 arch/s390/kvm/arm64/guest.c                  | 135 ++++
 arch/s390/kvm/arm64/handle_exit.c            | 131 ++++
 arch/s390/kvm/arm64/handle_exit.h            |   9 +
 arch/s390/kvm/arm64/inject_fault.c           |  21 +
 arch/s390/kvm/arm64/mmio.c                   |  15 +
 arch/s390/kvm/arm64/mmu.c                    | 177 +++++
 arch/s390/kvm/arm64/reset.c                  |  71 ++
 arch/s390/kvm/arm64/trace.h                  |  42 +
 arch/s390/kvm/gmap/faultin.c                 |   5 +
 arch/s390/kvm/gmap/gmap.c                    |   4 +
 arch/s390/kvm/gmap/kvm_mmu.c                 |   4 +
 arch/s390/kvm/gmap/trace_gmap.h              |  17 +
 arch/s390/kvm/s390/s390.c                    |   8 +
 arch/s390/tools/Makefile                     |   9 +-
 arch/s390/tools/Makefile.arm64h              |  56 ++
 arch/s390/tools/copy-arm64h-full.awk         |  47 ++
 arch/s390/tools/copy-arm64h.awk              |  72 ++
 arch/s390/tools/opcodes.txt                  |   3 +
 arch/x86/include/asm/kvm_page_track.h        |   8 +-
 arch/x86/kvm/Makefile                        |   5 +-
 arch/x86/kvm/mmu/page_track.c                |  20 +-
 drivers/s390/char/sclp_early.c               |   1 +
 drivers/s390/crypto/vfio_ap_ops.c            |  20 +-
 drivers/vfio/group.c                         |  11 +-
 drivers/vfio/pci/vfio_pci_zdev.c             |   8 +-
 drivers/vfio/vfio.h                          |  10 +-
 drivers/vfio/vfio_main.c                     |  57 +-
 include/linux/kvm_host.h                     |  12 +-
 include/linux/vfio.h                         |   5 +-
 virt/kvm/async_pf.c                          |  13 +-
 virt/kvm/async_pf.h                          |   4 +-
 virt/kvm/coalesced_mmio.c                    |   4 +
 virt/kvm/coalesced_mmio.h                    |   2 +-
 virt/kvm/kvm_main.c                          |  70 +-
 virt/kvm/vfio.c                              |  13 +-
 81 files changed, 2930 insertions(+), 201 deletions(-)
 create mode 100644 arch/s390/include/arm64/kvm_emulate.h
 create mode 100644 arch/s390/include/arm64/kvm_nested.h
 create mode 100644 arch/s390/include/arm64/ptrace.h
 create mode 100644 arch/s390/include/arm64/sysreg.h
 create mode 100644 arch/s390/include/asm/kvm.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
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
 create mode 100644 arch/s390/kvm/arm64/trace.h
 create mode 100644 arch/s390/tools/Makefile.arm64h
 create mode 100644 arch/s390/tools/copy-arm64h-full.awk
 create mode 100644 arch/s390/tools/copy-arm64h.awk


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0

