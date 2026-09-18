Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88524F30C5;
	Fri, 18 Sep 2026 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738311; cv=none; b=ufu3TtnsYy6eKsUKUNDJ4ZfYRjefWach3/sd4GQTJ11qc5b4Nr1w/txLG0/KK6tQz6Z085MW0qNjS6sXnO6XEadSMT3aoTSYQHdK/u5kJrRxSFV5ZXcclmWzvNksyUa5UTJ3cNQWvZViiK7D6nwy1TV0R6dPqtDt42YdpPkieBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738311; c=relaxed/simple;
	bh=E1aw1/+3gXxO6A/Pc2goZfnqgt62rSiTT1g6E9fLk28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEUBgfdI9UohY7ZFRRN5ome6zEPzEhg8RgJ7JRmkPrN66id1CAQ7uo8TgLnrefLLVcvEVzIcq2jpLITNarcBz+EgskszBriSATpoXHNPybqU76glgI2BOOHVBjIUDQwepVI2sisTrdIhsI53beh5JSSR11OxbZqRdide1Kkq2Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gxyAYbW/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gxyAYbW/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1Qls946053;
	Fri, 18 Sep 2026 13:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QA7KxcUt4ujJ8qlwrAOyIIYtPQeg6PXQGNixAXMgh
	14=; b=gxyAYbW/v9azkgA0ZESwvIRO8qpbpxEf2S9mDnjUvCci+/OyocwrzQRsn
	InVFUeH8uU4hKk0lONGelG61CjGIGKZu2xR5oK/RiX13o/oABckDhxtRWULG4fRU
	2jnWqz78uRm9oDOr9EsnrPWgyokt8JCwlWOMGHrBSkAGX3SBMnceviEcFuODO4dt
	BDpN9WOOFL69EoAg1qxjRGRB+r3qCqq1/KFRTw/n1hwJxmt+r8Ko1ARYnGzFCFZM
	43DKFbkMGREIumhv8e7vsRaCUuhF17JBvmaeSpqOXgnCfJPUj16Kf0wn/6CTHFBV
	HAxgjaRilIWg4Cf71IFd1q4BZudIA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx848a5k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNxWw739495;
	Fri, 18 Sep 2026 13:31:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q88tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDV81D51904916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3197D20049;
	Fri, 18 Sep 2026 13:31:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD5D720040;
	Fri, 18 Sep 2026 13:31:07 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:07 +0000 (GMT)
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
Subject: [PATCH v8 00/29] KVM: s390: Introduce arm64 KVM
Date: Fri, 18 Sep 2026 15:30:37 +0200
Message-ID: <20260918133107.1042730-1-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX4JHutzNRlDjJ
 5PfBI6NsaPKX5VQWjEVdfc1uxewjyjSOE+8acOnVOzohkzD10etbASK8IUrjcie0N+uT0QVPhxa
 F4wPZU8UaXmifGwo4ULSQ7JYcNi1ghPGe8Yp64th0JUc8SpvjcTMix320a1JiRTuwYx3p+3kmif
 UD5mfeem+e4sJTr7nWDOYPFIJqEz/8bE4iLxfTsaWSBC4GuSm3bcJbQJgIubvD2VFsGJt+Mplh5
 zFrBm4Z0UYPYZlrwb4U8viNU12G26jAnLivK1HxoPCIZHLAM9fpcw5zu3sf4MIe+eHadWSQH7KE
 kpxyiEOXVv9Z1qRx/leiHNULE9q4qcTBh1QQwBoHt4VKpR3IWYpCa4OdNP0axKvhWfn5lD6VyVe
 VIZG6XXlqcwbVk3RamcHxxgU+ypN3lPSTUhX4TivGlx0rvHUSria2scxvnSBuzwApUfIgEtKL2e
 QeKQZYPWXXMGLu7PYGw==
X-Proofpoint-ORIG-GUID: dMfcqqbSFLzWsCjBp8-syWL4AAtjkyPs
X-Proofpoint-GUID: p5oBbqzmrNsI38GWg601SF5JuvczMfBl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX3GtlvU9MNT4T
 76mViBuExjMdR7ZZqRssYTLL1Y3unyguf+4Y3eKNPha8osBdmE+QJeYAeYO+9A8JUz/ZZ7ydyXB
 gMK8FpqHabjAC8QjvVa5rUBZvXff5+A=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aad3d25 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=J1s6lPNx0iNPQzGZlDgA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180184

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

A) KVM symbol cleanup and refactoring (patches 1-9):
   Prepare KVM to support two KVM modules in parallel (spin-off: [5]). Clean up
   KVM module symbol exports, making it possible to load two KVM modules side
   by side. Make the KVM device name configurable and allow KVM implementations
   to disable MMIO regardless of CONFIG_KVM_MMIO. Move some more KVM configs to defines
   so that concurrent KVMs can select them at need. 

B) Arm64 header and code sharing preparation (patches 10-17):
   Mark shareable parts with ARM64_S390_COMMON. But first perform minor
   refactoring to ease integration into s390. All the refactoring/cleanup/fix
   patches could be picked separately before the actual share-marker commits (16/17)

C) Code sharing infrastructure for s390 (patches 18 & 19):
   Add Makefile and scripts to extract and build arm64 headers and code for
   use by s390.

D) KVM on s390 (patches 20-29):
   Introduce the SAE (Start Arm Execution) instruction as the s390
   mechanism for running arm64 guests. Build up the new kvm-arm64 module
   incrementally. Verify that only selected symbols are exported, so there 
   is no duplication for exported symbols.

A, B, and C could be picked individually without requiring the others so they
could go through different trees if required. D obviously requires A-C.

	Steffen

Changes from v7 [6]:
  - KVM_DEV_NAME` and `KVM_DEV_MINOR` are now set at compile time
  - fix tracing so it uses KVM_DEV_NAME as tracing base
  - convert Kconfig options to defines where applicable remove now unnecessary stubs
  - convert KVM_MMIO Kconfig to KVM_NO_MMIO define 
  - rework KVM file based rc and export symbol handling
       - add an arch tagged opt-in helper function to convert the file handle into kvm
         if needed by e.g. vfio
  	-split the one patch into 5
		1) introduce file_to_kvm_<arch> helper
		2) add file backpointer in kvm
		3) refactor x86 sev to use the new helper
		4) refactor kvm+vfio to use file rc
		5) only internally export the kvm_get/put symbols
  - share x86's export symbol verification with all architectures that want it

s390:
  - arm-ons390 and kvm/s390 now hang on the same config Symbol KVM. therw is no extra config for arm-on-s390
  - handle_exit.c` is no longer in the shared ARM64 C-files list; the s390 tree
    provides its own local `handle_exit.c` until enough infrastructure on s390
    side is there to share the complete architectural exit handling
  - rename module from kvm-arm64 to kvm_arm64 to simplify handling all around the code
  - rename *_elz fields to *_el2
  - use 32bit field and accessor for fpcr and fpsr to satisfy 32bit UAPI
  - verify the set of exported symbols like x86
  
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
[6] https://lore.kernel.org/all/20260831144802.834315-1-seiden@linux.ibm.com/

Hendrik Brueckner (1):
  s390/hwcaps: Report SAE support as hwcap

Steffen Eiden (28):
  KVM: Introduce file_to_kvm_<arch>() infrastructure
  KVM: Add file back-pointer to struct kvm
  KVM: x86: Use file_to_kvm_x86() in SEV
  KVM/vfio: Use file-based reference counting for KVM
  KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM modules
  KVM: Move export symbol check macros to Makefile.kvm
  KVM: Make device name configurable
  KVM: Move architecture capability Kconfigs to header defines
  KVM: Replace CONFIG_KVM_MMIO with KVM_NO_MMIO
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
  s390: Introduce Start Arm Execution instruction
  KVM: s390: arm64: Introduce host definitions
  KVM: s390: Add basic arm64 kvm module
  KVM: s390: arm64: Implement required functions
  KVM: s390: arm64: Implement vm/vcpu create destroy.
  KVM: s390: arm64: Implement vCPU IOCTLs
  KVM: s390: arm64: Implement basic page fault handler
  KVM: s390: arm64: Integrate arm on s390
  KVM: s390: Enforce no unexpected external symbol exports in s390 KVM

 MAINTAINERS                                  |   1 +
 arch/arm64/Makefile                          |   5 +
 arch/arm64/include/asm/brk-imm.h             |   1 +
 arch/arm64/include/asm/esr.h                 |   5 +-
 arch/arm64/include/asm/kvm_arm.h             |   6 +-
 arch/arm64/include/asm/kvm_emulate.h         |  69 +-
 arch/arm64/include/asm/kvm_host.h            | 120 +--
 arch/arm64/include/asm/ptrace.h              |  64 +-
 arch/arm64/include/asm/sysreg.h              |  22 +-
 arch/arm64/kvm/Kconfig                       |   4 -
 arch/arm64/kvm/arm.c                         |   3 +
 arch/arm64/kvm/guest.c                       |  22 +-
 arch/arm64/kvm/hyp/exception.c               |   4 +-
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h   |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h      |   4 +-
 arch/arm64/kvm/mmio.c                        |   2 +
 arch/arm64/tools/sysreg                      |  51 ++
 arch/loongarch/include/asm/kvm_host.h        |   2 +
 arch/loongarch/kvm/Kconfig                   |   3 -
 arch/mips/include/asm/kvm_host.h             |   1 +
 arch/mips/kvm/Kconfig                        |   2 -
 arch/powerpc/include/asm/kvm_host.h          |  10 +
 arch/powerpc/kvm/Kconfig                     |   5 -
 arch/riscv/include/asm/kvm_host.h            |   2 +
 arch/riscv/kvm/Kconfig                       |   3 -
 arch/s390/include/arm64/kvm_emulate.h        | 130 ++++
 arch/s390/include/arm64/kvm_nested.h         |  11 +
 arch/s390/include/arm64/ptrace.h             |  11 +
 arch/s390/include/arm64/sysreg.h             |  13 +
 arch/s390/include/asm/Kbuild                 |   1 +
 arch/s390/include/asm/asm-prototypes.h       |   1 +
 arch/s390/include/asm/elf.h                  |   2 +
 arch/s390/include/asm/kvm.h                  |   6 +
 arch/s390/include/asm/kvm_host.h             |   9 +
 arch/s390/include/asm/kvm_host_arm64.h       | 212 ++++++
 arch/s390/include/asm/kvm_host_arm64_types.h | 124 ++++
 arch/s390/include/asm/kvm_host_s390.h        |   8 +
 arch/s390/include/asm/kvm_host_types.h       |   4 +
 arch/s390/include/asm/sae.h                  |  58 ++
 arch/s390/include/asm/sclp.h                 |   5 +-
 arch/s390/include/asm/stacktrace.h           |   5 +
 arch/s390/kernel/asm-offsets.c               |   1 +
 arch/s390/kernel/entry.S                     |  22 +
 arch/s390/kernel/processor.c                 |   3 +
 arch/s390/kvm/Kconfig                        |  31 +-
 arch/s390/kvm/Makefile                       |   2 +
 arch/s390/kvm/arm64/.gitignore               |   2 +
 arch/s390/kvm/arm64/Makefile                 | 107 +++
 arch/s390/kvm/arm64/Makefile.gen             |  26 +
 arch/s390/kvm/arm64/arm.c                    | 740 +++++++++++++++++++
 arch/s390/kvm/arm64/arm.h                    |  58 ++
 arch/s390/kvm/arm64/copy-arm64c.awk          |  72 ++
 arch/s390/kvm/arm64/guest.c                  | 135 ++++
 arch/s390/kvm/arm64/handle_exit.c            | 162 ++++
 arch/s390/kvm/arm64/handle_exit.h            |   9 +
 arch/s390/kvm/arm64/inject_fault.c           |  21 +
 arch/s390/kvm/arm64/mmio.c                   |  15 +
 arch/s390/kvm/arm64/mmu.c                    | 180 +++++
 arch/s390/kvm/arm64/reset.c                  |  71 ++
 arch/s390/kvm/arm64/trace.h                  |  68 ++
 arch/s390/kvm/gmap/faultin.c                 |   5 +
 arch/s390/kvm/gmap/gmap.c                    |   4 +
 arch/s390/kvm/gmap/kvm_mmu.c                 |   4 +
 arch/s390/kvm/gmap/trace_gmap.h              |  17 +-
 arch/s390/kvm/s390/Makefile                  |  18 +-
 arch/s390/kvm/s390/pv.c                      |   1 -
 arch/s390/tools/Makefile                     |   9 +-
 arch/s390/tools/Makefile.arm64h              |  56 ++
 arch/s390/tools/copy-arm64h-full.awk         |  47 ++
 arch/s390/tools/copy-arm64h.awk              |  71 ++
 arch/s390/tools/opcodes.txt                  |   3 +
 arch/x86/include/asm/kvm_host.h              |   6 +
 arch/x86/include/asm/kvm_page_track.h        |   8 +-
 arch/x86/kvm/Kconfig                         |   5 -
 arch/x86/kvm/Makefile                        |  51 +-
 arch/x86/kvm/mmu/page_track.c                |  22 +-
 arch/x86/kvm/svm/sev.c                       |   8 +-
 drivers/s390/char/sclp_early.c               |   1 +
 drivers/s390/crypto/vfio_ap_ops.c            |  20 +-
 drivers/vfio/group.c                         |  11 +-
 drivers/vfio/pci/vfio_pci_zdev.c             |   8 +-
 drivers/vfio/vfio.h                          |  12 +-
 drivers/vfio/vfio_main.c                     |  57 +-
 include/linux/kvm_host.h                     |  43 +-
 include/linux/vfio.h                         |   5 +-
 include/trace/events/kvm.h                   |   8 +-
 virt/kvm/Kconfig                             |  23 +-
 virt/kvm/Makefile.kvm                        |  42 +-
 virt/kvm/coalesced_mmio.c                    |   4 +
 virt/kvm/coalesced_mmio.h                    |   2 +-
 virt/kvm/kvm_main.c                          |  47 +-
 virt/kvm/vfio.c                              |  13 +-
 92 files changed, 3063 insertions(+), 308 deletions(-)
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


base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.53.0

