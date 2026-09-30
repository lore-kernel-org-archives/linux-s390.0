Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5753B32E;
	Wed, 30 Sep 2026 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789729; cv=none; b=SCpx/7eseBkk/I4XIhzVMtT/jeFX9MqfL3gAXqRAlw3E06cMQI8wL+aOQ12ZFXsftQf38v4KnWkzPzGvYUXJHQBtgtSdna0nbBW3sdbSDaV4Ep1O+bxrue4sOUl4wXwEHS/Y1sg9iIlWEijRyqTBV2dcJBbh1mJO8MfEeSAdUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789729; c=relaxed/simple;
	bh=YgaeNj3UNiXZy4ovj8jtu2manOxXzqvKFhgkwAac0sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5SJGv5TBTSxC1wHg0gehk9GDb5tsrL4+ZtOVM7eTmEgTi7UH/goYHv0CLjB6t0bO2h99OqOhNVogRFV27BJrgB5FTmT0cvBKFKhZJkPTpeGg4/KkqOip3KtETFtwnudbyl9fgFN+hzU8pPK6dWMWLJ3wY090TmPUO/lXI54rKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NZHLNG7n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NZHLNG7n"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5QWJ1932696;
	Wed, 30 Sep 2026 17:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WauFYvfEUNT6wRa/UEn6qfdTh8ZfEJU6u2gfHF/Tu
	Dw=; b=NZHLNG7nanBvOV64MQvo/NAc6/BlySQkFHzKqnKtyND/nLCY23G1u9A9S
	gWO8J6b5I85ovUekMUc+DVz1VSzRBiYWfOOzsvp6P2jHvp6flCwaZ0/98tM1v2gT
	4elOtjlORb9goWCAke0WvOTJRLxwAjsHbigRB5I4nenzpqmhD9TBdX9nerf4+Mp+
	qZOa8lhSPR3azCmJ2SKpPho/pnbb2bbFU+HTAkCtVqK703OCDn+UFSdwTjHva0ad
	YjiXo1takDfAz6X80vnFOmdixc3KRq+ncCaXq+SzdO06t+/H8pXwm1fcwKQ8Qcu7
	RjxxY8q1wSJEe5tKFw6uOTz7zCRWQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fedn3g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE34DD3583561;
	Wed, 30 Sep 2026 17:34:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e59rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYjQl50987416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00BDC2004E;
	Wed, 30 Sep 2026 17:34:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89CEB2004D;
	Wed, 30 Sep 2026 17:34:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:41 +0000 (GMT)
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
Subject: [PATCH v9 00/24] KVM: s390: Introduce arm64 KVM
Date: Wed, 30 Sep 2026 19:34:15 +0200
Message-ID: <20260930173441.66762-1-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd483a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0gxAeaR_ok7USUIQk_0A:9 a=I5x9wxi_Tec9_xj1:21 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX9L4leVDHiqC5
 yTx+RStausFZQlquLhcgyYx8XyPbN/f2YXKcdS5oGRB0HhOKQe7YdjTWZcwxaY8zlRS4cbMv0eg
 9Zuoz9pkKAwbTQKh6JsqbH8Gplzud4U=
X-Proofpoint-ORIG-GUID: VA0O4hmt6ANc9lNJEfexHBQLfiSMXn26
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX0s81s8bWkhaW
 id5KDOo3kBxq9afClxM1v2vhmoPoD1pVWKf69LMNmU/XkOPZQibLaJ2mHNZW/UR7VU+yrP71rNU
 0Yyzi+fIRUJ+uQm91lTbd77feoSx0VDG8+V8tYXVPnuyV5RYHhpX/xH9lfp6lenjHRgrmdMF7E+
 BuzrkIi1yDYsuynjl3BhTUR/S/o4L5LdeOWGHDCiZeZNHQUL12UfLbEXa50pYd8WtUeGSP+dVfd
 QBbSA8tTZoCrXgBMJz+lUNt2PuocRqE91vXaMbo9Xaa3ZvAy+S8dH+DQzVvPw1gtpa0H3vV/tsj
 mH8b04hnT85qMFylep0QGbRH6sBZbFk/gofiClz2ljTnwWEbryArPJCA6DHJS6q1MVbke8YKc6p
 JUVK9DYgU5iDhy6vgo/nmZYVndM/DxYLTmmOjuKHbv2pq6CfjzCIdvDKQKOwCWjDBSrxXq6Gukn
 EozAnfmmO5/txJChl7w==
X-Proofpoint-GUID: oABrRASt1ycXCT5y6UHSkXtLtXultMSr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300068

Introduce arm-on-s390. Enable KVM-accelerated ARM CPU virtualisation on s390.

The new KVM functionally depends on KVM/vfio: Use file-based reference
counting for KVM [5] The series itself should apply w/o those.

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
  #ifdef ARM64_S390_COMMON == 1
  <shared code>
  #endif /* ARM64_S390_COMMON  == 1*/
  <arm64 local code>
  
ARM64_S390_COMMON is set to 1 for all arm64 compilation units.

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

0) as prereq [5] 
   Prepare KVM to support two KVM modules in parallel. Clean up KVM
   module symbol exports, making it possible to load two KVM modules
   side by side. 

A) KVM refactoring (patches 1-3):
   Make the KVM device name configurable and allow KVM implementations
   to disable MMIO regardless of CONFIG_KVM_MMIO. Move some more KVM configs to defines
   so that concurrent KVMs can select them at need. 

B) Arm64 header and code sharing preparation (patches 4-11):
   Mark shareable parts with ARM64_S390_COMMON. But first perform minor
   refactoring to ease integration into s390. All the refactoring/cleanup/fix
   patches could be picked separately before the actual share-marker commits (13/14)
   FYI Patch 04 is already picked but not on a Linus-tag yet,

C) a: Small refactoring (12 & 13)
      simplify config space and cleat the way for kvm_arm64
      remove direct access from kvm_arch struct in shared gmap code.

   b: Code sharing infrastructure for s390 (patches 14 & 15):
      Add Makefile and scripts to extract and build arm64 headers and
      code for use by s390.

D) KVM on s390 (patches 16-24):
   Introduce the SAE (Start Arm Execution) instruction as the s390
   mechanism for running arm64 guests. Build up the new kvm-arm64 module
   incrementally.

A, B, and C could be picked individually without requiring the others so they
could go through different trees if required. D obviously requires A-C.

	Steffen
--

Changed from v8[7]:
  - Use #if ARM64_S390_COMMON == 1 for sharing markers to benefit from
    PP complaints in case of an e.g. typo
  - Improved device name selection, streamlined the use of the kvm
    device name
  - Fixed inconsistencies in the device naming patch
  - dropped vfio/kvm prep series and let this series rely on it.
    It is still functionally required to get rid of any double exported
    symbol
  - Remove Pre fault memory from migrated Kconfigs
  - Add r-b/acks from Janosch, Ilya, Mark, and Catalin
  - Fixed multiple minor issues outlined by sashiko (and other AI tools)

  s390:
    - Improve header/code generation (emit diagnostics information)
    - Make header/code generation more robust against bogus sections
    - Use filechk for generating headers
    - Improve integration of kvm_arm64 into the kbuild system
    - Drop the verification of exported symbols for now. They will come
      once this series is merged.
    - Add prefault memory support as native ARM-KVM support is picked.
  
  arm64:
    - Move less header code in preparation patch as some  of the
      previously moved functions are shared in later batches anyways
      (reduces overall churn)

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
  - arm-ons390 and kvm/s390 now hang on the same config Symbol KVM. there is no extra config for arm-on-s390
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
[5] https://lore.kernel.org/all/20260928-vfio-v4-0-e32e226d5932@linux.ibm.com/
[6] https://lore.kernel.org/all/20260831144802.834315-1-seiden@linux.ibm.com/
[7] https://lore.kernel.org/all/20260918133107.1042730-1-seiden@linux.ibm.com/

Hendrik Brueckner (1):
  s390/hwcaps: Report SAE support as hwcap

Steffen Eiden (23):
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
  s390/Kconfig: remove PCI dependency from HAS_IOMEM
  KVM: s390: Use dedicated function for migration mode
  s390/tools: Use arm64 headers
  KVM: s390: Use arm64 code
  s390: Introduce Start Arm Execution instruction
  KVM: s390: arm64: Introduce host definitions
  KVM: s390: Add basic arm64 kvm module
  KVM: s390: arm64: Implement required functions
  KVM: s390: arm64: Implement vm/vcpu create destroy
  KVM: s390: arm64: Implement vCPU IOCTLs
  KVM: s390: arm64: Implement basic page fault handler
  KVM: s390: arm64: Integrate arm on s390

 MAINTAINERS                                  |   1 +
 arch/arm64/Makefile                          |   3 +
 arch/arm64/include/asm/brk-imm.h             |   1 +
 arch/arm64/include/asm/esr.h                 |   5 +-
 arch/arm64/include/asm/kvm_arm.h             |   6 +-
 arch/arm64/include/asm/kvm_emulate.h         |  64 +-
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
 arch/s390/Kconfig                            |   5 +-
 arch/s390/include/arm64/kvm_emulate.h        | 130 ++++
 arch/s390/include/arm64/kvm_nested.h         |  11 +
 arch/s390/include/arm64/ptrace.h             |  11 +
 arch/s390/include/arm64/sysreg.h             |  13 +
 arch/s390/include/asm/asm-prototypes.h       |   1 +
 arch/s390/include/asm/elf.h                  |   2 +
 arch/s390/include/asm/io.h                   |  12 +-
 arch/s390/include/asm/kvm.h                  |   6 +
 arch/s390/include/asm/kvm_host.h             |   4 +
 arch/s390/include/asm/kvm_host_arm64.h       | 209 +++++
 arch/s390/include/asm/kvm_host_arm64_types.h | 124 +++
 arch/s390/include/asm/kvm_host_s390.h        |   5 +
 arch/s390/include/asm/kvm_host_types.h       |   4 +
 arch/s390/include/asm/sae.h                  |  49 ++
 arch/s390/include/asm/sclp.h                 |   5 +-
 arch/s390/include/asm/stacktrace.h           |   5 +
 arch/s390/include/uapi/Kbuild                |   6 +
 arch/s390/kernel/asm-offsets.c               |   1 +
 arch/s390/kernel/entry.S                     |  22 +
 arch/s390/kernel/processor.c                 |   3 +
 arch/s390/kvm/Kconfig                        |  27 +-
 arch/s390/kvm/Makefile                       |   1 +
 arch/s390/kvm/arm64/.gitignore               |   2 +
 arch/s390/kvm/arm64/Makefile                 | 110 +++
 arch/s390/kvm/arm64/Makefile.gen             |  28 +
 arch/s390/kvm/arm64/arm.c                    | 754 +++++++++++++++++++
 arch/s390/kvm/arm64/arm.h                    |  58 ++
 arch/s390/kvm/arm64/copy-arm64c.awk          |  82 ++
 arch/s390/kvm/arm64/guest.c                  | 135 ++++
 arch/s390/kvm/arm64/handle_exit.c            | 161 ++++
 arch/s390/kvm/arm64/handle_exit.h            |   9 +
 arch/s390/kvm/arm64/inject_fault.c           |  21 +
 arch/s390/kvm/arm64/mmio.c                   |  15 +
 arch/s390/kvm/arm64/mmu.c                    | 200 +++++
 arch/s390/kvm/arm64/reset.c                  |  71 ++
 arch/s390/kvm/arm64/trace.h                  | 101 +++
 arch/s390/kvm/gmap/faultin.c                 |   5 +
 arch/s390/kvm/gmap/gmap.c                    |   4 +
 arch/s390/kvm/gmap/kvm_mmu.c                 |   6 +-
 arch/s390/kvm/gmap/trace_gmap.h              |  17 +-
 arch/s390/kvm/s390/Makefile                  |   2 +-
 arch/s390/tools/Makefile                     |   6 +-
 arch/s390/tools/Makefile.arm64h              |  55 ++
 arch/s390/tools/copy-arm64h-full.awk         |  50 ++
 arch/s390/tools/copy-arm64h.awk              |  83 ++
 arch/s390/tools/opcodes.txt                  |   3 +
 arch/x86/include/asm/kvm_host.h              |   3 +
 arch/x86/kvm/Kconfig                         |   4 -
 drivers/s390/char/sclp_early.c               |   1 +
 include/linux/kvm_host.h                     |  24 +-
 include/trace/events/kvm.h                   |   8 +-
 virt/kvm/Kconfig                             |  18 -
 virt/kvm/Makefile.kvm                        |   9 +-
 virt/kvm/async_pf.c                          |   5 +-
 virt/kvm/coalesced_mmio.c                    |   4 +
 virt/kvm/coalesced_mmio.h                    |   2 +-
 virt/kvm/eventfd.c                           |   3 +-
 virt/kvm/kvm_main.c                          |  44 +-
 84 files changed, 2968 insertions(+), 199 deletions(-)
 create mode 100644 arch/s390/include/arm64/kvm_emulate.h
 create mode 100644 arch/s390/include/arm64/kvm_nested.h
 create mode 100644 arch/s390/include/arm64/ptrace.h
 create mode 100644 arch/s390/include/arm64/sysreg.h
 create mode 100644 arch/s390/include/asm/kvm.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
 create mode 100644 arch/s390/include/asm/sae.h
 create mode 100644 arch/s390/include/uapi/Kbuild
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


base-commit: 16096aadaa3d15c11d37bbea750bad0917e8eadf
-- 
2.53.0

