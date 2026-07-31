Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC1403AE1;
	Fri, 31 Jul 2026 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503377; cv=none; b=F811mQt9VFs8av+wPVJEcfNshtMTc67YwGtHbLGe15Q0EsMUSZNjh2vT4E0YQWOXM76fGQMOyzVtfPvKJcYs6idx0rubuXNPffQicGdZ6do308KhE5lwTKfzg4D3uTJgcO7YJNbJe+c1U+I5rD2D1yvVe23yiBsdyKu2FoX1Ywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503377; c=relaxed/simple;
	bh=gohNc1/6wCgQv5sQPP6/rkA3MNa/Ga9NzpFnw2T+EeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Du3F3bmgcfKlqPR1ROWdxlfQbil1cWxHrx4YOCm3hlfj4VJaE7pSWJfCnbsawlqSj3VKP0Ixd8caNwAq6Khhiwctq3O6T59z9HGkljNg3s9jZrTF4aoGURQNF/Y5TIUMS0zGGb8kJKHPa7DZJapjrQSwPcOvl7k44FlaOKn+eaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fjs/rtue; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fjs/rtue"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlcwG4072623;
	Fri, 31 Jul 2026 13:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=iGZQyTfQCtA4vgAI4wdcUkW2n9EQiE6GoTj73F5e6
	k0=; b=fjs/rtueBGpKKseyqJVIc9wVHgz6292DtiX4YsstUTZ/JnmlWWWpwxUYO
	bEA16Wxs9IXa/EGwA4NkHmMdBM50Q/YEPOYq+1ijA64wjHIt9xoQXJ/yxDKRlOgQ
	9iLfVE232g0aAgRw0O14jhaWXuBAvXVkkCVXfz4BeNhi7C5rEFzZ79NC6T5yvYS7
	HPgXqWNfNT9iQgkpqnRiA3iKNiKI0qXU9n1pjwwIDqF4Hi747rfiAQD6NrDUHuXU
	rQqiDZHBtZ7GKsDX6r4wc7UlbLesSF2iKMGihidmoRqPntRCHWZuvIHpsVdg1WPi
	8TlXcl9RFqAmVLt7viFFsUw0oP65A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw2ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCQEdD026825;
	Fri, 31 Jul 2026 13:09:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqtbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD93Lv30474686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 344C120040;
	Fri, 31 Jul 2026 13:09:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADA132004D;
	Fri, 31 Jul 2026 13:09:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:02 +0000 (GMT)
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
Subject: [PATCH v5 00/31] KVM: s390: Introduce arm64 KVM
Date: Fri, 31 Jul 2026 15:08:28 +0200
Message-ID: <20260731130902.654679-1-seiden@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: qUtT0oBvyHlQCbu7L-CIXDvzn_S8vDKZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX1Ryc8pD5ZTZl
 0IgMSjd60M/ah+qtwMNEAyL9shDsy8kXDUfrtTuBeD6nlX4d4PAEDlYa4F09pqFtPMSNri4TQsx
 qH8QrHlJ+OPGlR9w8USS63v1zk+RobTNuX3SaX5dIy/sE+lWb1trdmm9BtfwKu19BcDIWNanV6q
 G/OLWdEG4t4qaGGYe7qkZ56cGf0Chz7VOV/AD6lFzCf9FH1Fq0Na4emX36oUH9ovks5Kqq03Rwi
 6LxvKZeDGIRpHCjag1Boxf/txoO02bN06IOdhWwdXqbruUDbO/p82rR/O5LA4gzcUT08nwc3Q2n
 6nOPVg4T+tiudmnPolS/atUVXx8UmGTiJhQEFIQ5pvUxTunNoU7QLy2FyOYEVmcZ2tYhujDdJgo
 nhvXzvlwh6mT1MRsyiQ8p4xT4lvSc5jS27mbUs8FDK3TvxFuK2lIGuFUi9IsNE7XnwZSx/6q0Iy
 xamXw6tdAH8GeYwMrfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX2Y/KCjH5zLJN
 GqwzB58WRQ1kDBXAOM9FBlwTVPu+vNIuA9hrXfpFEBB10wUZQzNaJ9FPKTFs+EIob/BonG9I8NG
 BUu1eUNGDEouBLgHhd1xau59JRt5umY=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9e78 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_84NmouirAEMwovvlUcA:9 a=Zr1Jdahoogi_HG0H:21 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: qjfJcKI5Nod9OsE77-UClyD4bfN7NpZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

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
  Make the KVM device name configurable and remove KVM_MMIO as a config
  option.

B) Arm64 header and code sharing preparation (patches 4-12):
  Mark shareable parts with ARM64_S390_COMMON. Perform minor refactoring
  to ease integration into s390.

C) KVM/s390 reorganization (patches 13-20):
  Prepare s390 for a second KVM module. Move existing s390 KVM code into
  dedicated s390 and gmap subdirectories to make room for a second KVM
  implementation. Refactor gmap to better integrate with the second KVM
  implementation.

D) Code sharing infrastructure for s390 (patches 21 & 22):
  Add Makefile and scripts to extract and build arm64 headers and code for
  use by s390.

E) KVM on s390 (patches 23-32):
  Introduce the SAE (Start Arm Execution) instruction as the s390
  mechanism for running arm64 guests. Build up the new kvm-arm64 module
  incrementally.

I hope that this new approach suits arm64 better. I definitely think this way
of doing things is more elegant, has less churn, and less work for us all.
A, B, C and D could be picked without the others so they could go through
different trees if required. E requires A-D to be picked before.


Some comments:

I want to create a verification tool for you arm guys that mimics the s390 use
of the arm64 code and headers but compiles/works on arm64 as a quick sanity
check for any arm64 developer. I have some general ideas (A C-file including
all the arm code & headers and see if it compiles) about how to do this but no
concrete ideas yet. Pointers/Ideas are highly appreciated

To further harden the extraction of code/headers one could do the following:
  1. Expand all the macros on the header/code 
       a) with -DARM64_S390_COMMON
       b) without -DARM64_S390_COMMON
  2. The diff of a & b should be the stuff s390 needs
  3. Postprocess it a bit (guards and copyight)

But the AWK approach looked more straight forward and simpler.

I think that there is no way around it: In the future arm64 maintainers should
at least build s390 before sending merge request.

	Steffen

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

Hendrik Brueckner (1):
  s390/hwcaps: Report SAE support as hwcap

Steffen Eiden (30):
  vfio: Use file-based reference counting for KVM
  KVM: Make device name configurable
  KVM: Allow KVM implementations to switch off MMIO independent of
    Kconfig
  arm64: Use proper include variant
  arm64: ptrace: Use constants for compat register numbers
  arm64/sysreg: Convert SPSR_ELx to automatic register generation
  KVM: arm64: Access elements of vcpu_gp_regs individually
  KVM: arm64: Use accessor functions for gprs during reset
  KVM: arm64: Refactor core-reset into a separate function
  arm64: Prepare sharing arm64 headers with s390
  arm64: Share arm64 headers with s390
  KVM: arm64: Share arm64 code with s390
  KVM: s390: Prepare moving KVM/s390 to arch/s390/kvm/s390
  KVM: s390: Move s390 kvm code into a subdirectory
  KVM: s390: Guard KVM/s390 behind CONFIG_KVM_S390
  KVM: s390: Move PGM code definitions to asm/kvm_host.h
  KVM: s390: Prepare gmap for a second KVM implementation
  KVM: s390: gmap: Move storage key and CMMA code to kvm/s390
  KVM: s390: gmap: Move prefix handling to kvm/s390
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
 arch/arm64/include/asm/kvm_emulate.h          |  33 +-
 arch/arm64/include/asm/kvm_host.h             |  87 +-
 arch/arm64/include/asm/ptrace.h               |  64 +-
 arch/arm64/include/asm/sysreg.h               |  22 +-
 arch/arm64/kvm/arm.c                          |   3 +
 arch/arm64/kvm/guest.c                        |  22 +-
 arch/arm64/kvm/handle_exit.c                  |   6 +
 arch/arm64/kvm/hyp/exception.c                |   4 +-
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h    |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |   4 +-
 arch/arm64/kvm/mmio.c                         |   2 +
 arch/arm64/kvm/reset.c                        |  46 +-
 arch/arm64/tools/sysreg                       |  72 ++
 arch/s390/Kconfig                             |   2 +-
 arch/s390/boot/ipl_parm.c                     |   2 +-
 arch/s390/boot/uv.c                           |   2 +-
 arch/s390/configs/debug_defconfig             |   2 +-
 arch/s390/configs/defconfig                   |   3 +-
 arch/s390/include/arm64/kvm_emulate.h         | 102 +++
 arch/s390/include/arm64/kvm_nested.h          |  11 +
 arch/s390/include/arm64/ptrace.h              |  11 +
 arch/s390/include/arm64/sysreg.h              |  13 +
 arch/s390/include/asm/Kbuild                  |   3 +
 arch/s390/include/asm/asm-prototypes.h        |   1 +
 arch/s390/include/asm/elf.h                   |   2 +
 arch/s390/include/asm/kvm.h                   |   6 +
 arch/s390/include/asm/kvm_host.h              | 729 +----------------
 arch/s390/include/asm/kvm_host_arm64.h        | 224 ++++++
 arch/s390/include/asm/kvm_host_arm64_types.h  | 118 +++
 .../asm/{kvm_host.h => kvm_host_s390.h}       |  66 +-
 ...kvm_host_types.h => kvm_host_s390_types.h} |   6 +-
 arch/s390/include/asm/kvm_host_types.h        | 351 +--------
 arch/s390/include/asm/sae.h                   |  56 ++
 arch/s390/include/asm/sclp.h                  |   5 +-
 arch/s390/include/asm/stacktrace.h            |   5 +
 arch/s390/kernel/asm-offsets.c                |   1 +
 arch/s390/kernel/early.c                      |   2 +-
 arch/s390/kernel/entry.S                      |  32 +-
 arch/s390/kernel/perf_event.c                 |   2 +-
 arch/s390/kernel/processor.c                  |   3 +
 arch/s390/kvm/Kconfig                         |  37 +-
 arch/s390/kvm/Makefile                        |  12 +-
 arch/s390/kvm/arm64/.gitignore                |   2 +
 arch/s390/kvm/arm64/Kconfig                   |  22 +
 arch/s390/kvm/arm64/Makefile                  |  91 +++
 arch/s390/kvm/arm64/Makefile.gen              |  30 +
 arch/s390/kvm/arm64/arm.c                     | 744 ++++++++++++++++++
 arch/s390/kvm/arm64/arm.h                     |  58 ++
 arch/s390/kvm/arm64/copy-arm64c.awk           |  70 ++
 arch/s390/kvm/arm64/guest.c                   | 135 ++++
 arch/s390/kvm/arm64/handle_exit.c             | 131 +++
 arch/s390/kvm/arm64/handle_exit.h             |   9 +
 arch/s390/kvm/arm64/inject_fault.c            |  21 +
 arch/s390/kvm/arm64/mmio.c                    |  15 +
 arch/s390/kvm/arm64/mmu.c                     | 177 +++++
 arch/s390/kvm/arm64/reset.c                   |  77 ++
 arch/s390/kvm/arm64/reset.h                   |  11 +
 arch/s390/kvm/arm64/trace.h                   |  67 ++
 arch/s390/kvm/gmap/Makefile                   |   5 +
 arch/s390/kvm/{ => gmap}/dat.c                | 548 -------------
 arch/s390/kvm/{ => gmap}/dat.h                |  14 +-
 arch/s390/kvm/{ => gmap}/faultin.c            |   8 +-
 arch/s390/kvm/{ => gmap}/faultin.h            |   6 +-
 arch/s390/kvm/{ => gmap}/gmap.c               | 111 +--
 arch/s390/kvm/{ => gmap}/gmap.h               |  29 +-
 arch/s390/kvm/gmap/kvm_mmu.c                  | 135 ++++
 arch/s390/kvm/gmap/kvm_mmu.h                  |  18 +
 arch/s390/kvm/gmap/prefix.h                   |  39 +
 arch/s390/kvm/gmap/trace-gmap.h               |  59 ++
 arch/s390/kvm/{ => s390}/Kconfig              |  27 +-
 arch/s390/kvm/s390/Makefile                   |  15 +
 arch/s390/kvm/s390/dat.c                      | 554 +++++++++++++
 arch/s390/kvm/{ => s390}/diag.c               |   2 +-
 arch/s390/kvm/{ => s390}/gaccess.c            |   2 +-
 arch/s390/kvm/{ => s390}/gaccess.h            |   2 +-
 arch/s390/kvm/s390/gmap.c                     | 113 +++
 arch/s390/kvm/{ => s390}/guestdbg.c           |   2 +-
 arch/s390/kvm/{ => s390}/intercept.c          |   2 +-
 arch/s390/kvm/{ => s390}/interrupt.c          |   2 +-
 arch/s390/kvm/{ => s390}/pci.c                |   2 +-
 arch/s390/kvm/{ => s390}/pci.h                |   0
 arch/s390/kvm/{ => s390}/priv.c               |   2 +-
 arch/s390/kvm/{ => s390}/pv.c                 |   2 +-
 arch/s390/kvm/{kvm-s390.c => s390/s390.c}     | 121 +--
 arch/s390/kvm/{kvm-s390.h => s390/s390.h}     |  36 +-
 arch/s390/kvm/{ => s390}/sigp.c               |   2 +-
 arch/s390/kvm/{ => s390}/trace-s390.h         |   0
 arch/s390/kvm/{ => s390}/trace.h              |  14 -
 arch/s390/kvm/{ => s390}/vsie.c               |   2 +-
 arch/s390/tools/Makefile                      |  10 +-
 arch/s390/tools/Makefile.arm64h               |  57 ++
 arch/s390/tools/copy-arm64h-full.awk          |  47 ++
 arch/s390/tools/copy-arm64h.awk               |  72 ++
 arch/s390/tools/opcodes.txt                   |   3 +
 arch/x86/include/asm/kvm_page_track.h         |   8 +-
 arch/x86/kvm/Makefile                         |   3 -
 arch/x86/kvm/mmu/page_track.c                 |  16 +-
 drivers/s390/char/sclp_early.c                |   1 +
 drivers/s390/crypto/vfio_ap_ops.c             |  24 +-
 drivers/vfio/group.c                          |   2 +-
 drivers/vfio/pci/vfio_pci_zdev.c              |   7 +-
 drivers/vfio/vfio.h                           |  10 +-
 drivers/vfio/vfio_main.c                      |  49 +-
 include/linux/kvm_host.h                      |   8 +-
 include/linux/vfio.h                          |   4 +-
 virt/kvm/coalesced_mmio.c                     |   4 +
 virt/kvm/coalesced_mmio.h                     |   2 +-
 virt/kvm/kvm_main.c                           |  69 +-
 virt/kvm/vfio.c                               |   8 +-
 114 files changed, 3917 insertions(+), 2215 deletions(-)
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
 create mode 100644 arch/s390/kvm/arm64/Kconfig
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
 rename arch/s390/kvm/{ => gmap}/dat.c (61%)
 rename arch/s390/kvm/{ => gmap}/dat.h (97%)
 rename arch/s390/kvm/{ => gmap}/faultin.c (96%)
 rename arch/s390/kvm/{ => gmap}/faultin.h (96%)
 rename arch/s390/kvm/{ => gmap}/gmap.c (93%)
 rename arch/s390/kvm/{ => gmap}/gmap.h (94%)
 create mode 100644 arch/s390/kvm/gmap/kvm_mmu.c
 create mode 100644 arch/s390/kvm/gmap/kvm_mmu.h
 create mode 100644 arch/s390/kvm/gmap/prefix.h
 create mode 100644 arch/s390/kvm/gmap/trace-gmap.h
 copy arch/s390/kvm/{ => s390}/Kconfig (61%)
 create mode 100644 arch/s390/kvm/s390/Makefile
 create mode 100644 arch/s390/kvm/s390/dat.c
 rename arch/s390/kvm/{ => s390}/diag.c (99%)
 rename arch/s390/kvm/{ => s390}/gaccess.c (99%)
 rename arch/s390/kvm/{ => s390}/gaccess.h (99%)
 create mode 100644 arch/s390/kvm/s390/gmap.c
 rename arch/s390/kvm/{ => s390}/guestdbg.c (99%)
 rename arch/s390/kvm/{ => s390}/intercept.c (99%)
 rename arch/s390/kvm/{ => s390}/interrupt.c (99%)
 rename arch/s390/kvm/{ => s390}/pci.c (99%)
 rename arch/s390/kvm/{ => s390}/pci.h (100%)
 rename arch/s390/kvm/{ => s390}/priv.c (99%)
 rename arch/s390/kvm/{ => s390}/pv.c (99%)
 rename arch/s390/kvm/{kvm-s390.c => s390/s390.c} (98%)
 rename arch/s390/kvm/{kvm-s390.h => s390/s390.h} (94%)
 rename arch/s390/kvm/{ => s390}/sigp.c (99%)
 rename arch/s390/kvm/{ => s390}/trace-s390.h (100%)
 rename arch/s390/kvm/{ => s390}/trace.h (97%)
 rename arch/s390/kvm/{ => s390}/vsie.c (99%)
 create mode 100644 arch/s390/tools/Makefile.arm64h
 create mode 100644 arch/s390/tools/copy-arm64h-full.awk
 create mode 100644 arch/s390/tools/copy-arm64h.awk


base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
-- 
2.53.0

