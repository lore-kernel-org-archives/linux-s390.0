Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00F3AEF46;
	Mon,  6 Jul 2026 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328005; cv=none; b=jpL7lpY3h23Hom7fyBs9qv09aEHbNh4H0EjnNbIFhR8Izko5B/OGirASjRMt1kXpYbM/JhNkatg0sVSnRo+HhqgkFJG96igwP0SWXbQYDsWyyWLfuDVPrkHSzAyQ49amh5LuMyr8ei5DYt/Dc5x9ijmEW3RAHLWf1MWxgUBVpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328005; c=relaxed/simple;
	bh=j4NKnTIxRrBCZelty0DjrrURLwpGyN5uFXT44da4dY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYW13ukV3wW4W8yc0L4Nk+w1SPqh1mapPoR3yYqQ3qF2jwCFOapzIFDa96Y6u9m+8TRmW8krxCK3K8zw/vScbYh9BKOSqTOrLjruDwWb6wtj+hfrrtAXOgpR7tx3OUc2ggzb5tR/2jPm46sAqCsBVABJx47NvTQnYwMJ7mwOFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AILkfUhq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AILkfUhq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MJBlM1499251;
	Mon, 6 Jul 2026 08:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=aCLLcPOEdsnwhYEnNQhDR4qOYx68sLlDoV50+3qpq
	Cs=; b=AILkfUhq1TMUGVSfIUboLRInYErQxYZy0uG04rDMuKcVs/QLP+Om0mg9S
	4wz87n7xFS1SKylOpQj7EFIkS0D/lbywIBSghem/sMLO2+3AADQpHVonxL2QZDP+
	6d2NYUR7ss5HD0/sYVFuOGb2oZc5hmMWZo2ySL47/MLvgtNg+Y1Fpv5fJXXRlhHE
	rsUnTDNYscOF60KE3Nczyra35IEkMqSTXNsItIwVQtbhAT3ryFeYxjTvMj9L/meg
	wvp1JzTPBMWAEn3PSFV7RT0d+I+6VfQGhM1jV5r7OF/hx0CTiImtuGxognZt+XBi
	QOm9C48/s/d7t59EZgEVtJJS9LE7Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsh2kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668ncKG023211;
	Mon, 6 Jul 2026 08:52:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvvygx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qU0U42074490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9FB32004B;
	Mon,  6 Jul 2026 08:52:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65CE420043;
	Mon,  6 Jul 2026 08:52:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:29 +0000 (GMT)
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
Subject: [PATCH v4 00/27] KVM: s390: Introduce arm64 KVM
Date: Mon,  6 Jul 2026 10:52:00 +0200
Message-ID: <20260706085229.979525-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c9rpqabV22kXHy2HXvG08J8Nl8lktWbd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX3wLanKMpHM1O
 D72ZiYrMzSoM5NkAHZPZ/bgpkW8ke9AaignU2hmLgn1eVWmTOYkWJUtE1ulAN44mgRnCM5VCU/9
 0SEYsVyJtDfLin4Bb+v2ozcIatZdn14=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4b6cd5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_84NmouirAEMwovvlUcA:9 a=BDwbG3_GOz7xIMYa:21
X-Proofpoint-GUID: c9rpqabV22kXHy2HXvG08J8Nl8lktWbd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX7gIc/fPytBsa
 IQ0m+BlPUpCNbeohwUJbQC8L/x6i+YDTHO/ia356NpVgY/NxD/zMwbfDDZYTpYAeXlSloiKtjP/
 dSBDJXz1MjxxsgDL1k73vEITFW2PINYo8lJQYiPOwvauYexEVJ0kQt/hVw4fmFoNMwZ13q6VVVb
 hTdxTmOkV7YEAUdcZ4sppipHD3r+VyMNR6fj9BBWeDqJb0H5G7+eWROhw/tsMdudvTgSEmWmqwk
 wYW8LTu+l4/HIs7jfc7CJ3LFaArlkZHXqPTs953UwktwJVFeQPxjZKZPy7fvBwhvZ4RV2U80mme
 WJMwxAunjpL67YC141YJsPJgEWwWJFuzRhg6TqMhiKxPLDdFZpyiZG9SK9PTrND+u8/aiO+WxK6
 rYb2gnvdxb6Tnk7QJ0UlcJeb0/6k4dzlbCONbmArIoAeyafHwr4022I9Z/y48uhZTdHmC3rU3Qv
 P45qonrlcy9PnlXH1cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060088

This series is a complete rework of previous versions [1], fundamentally
changing the approach to code and header sharing between s390 and arm64.

For the original, now partially outdated, cover letter, have a look at one of
the previous versions [1].


The new approach does not move arm64 code to a shared location. Instead,
during build time, s390 extracts relevant parts of arm64 definitions and
implementation and uses them locally. This results in minimal changes to
existing arm64 code and headers.

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

Userspace tools requiring KVM/arm64 uapi on s390 must use the vendored
KVM API, as s390 will not ship nor install arm64 KVM uapi headers.

This approach reduces the churn, especially for arm64 while keeping the
maintenance burden low.


Series structure

KVM symbol cleanup and refactoring (patches 1-5):
  Prepare KVM to support two KVM modules in parallel. Clean up KVM module
  symbol exports, making it possible to load two KVM modules side by side.
  Make the KVM device name configurable and remove KVM_MMIO as a config
  option.

Arm64 header and code sharing preparation (patches 6-9):
  Mark shareable parts with ARM64_S390_COMMON. Perform minor refactoring
  to ease integration into s390.

Code sharing infrastructure for s390 (patches 10&11):
  Add Makefile and scripts to extract and build arm64 headers and code for
  use by s390.

KVM/s390 reorganization (patches 12-17):
  Prepare s390 for a second KVM module. Move existing s390 KVM code into
  dedicated s390 and gmap subdirectories to make room for a second KVM
  implementation. Refactor gmap to better integrate with the second KVM
  implementation.

KVM on s390 (patches 18-26):
  Introduce the SAE (Start Arm Execution) instruction as the s390
  mechanism for running arm64 guests. Build up the new kvm-arm64 module
  incrementally.

I hope that this new approach suits arm64 better. I definitely think this way
of doing things is more elegant, has less churn, and less work for us all. 


Some comments:

I want to create a verification tool for you arm guys that mimics the s390 use
of the arm64 code and headers but compiles/works on arm64 as a quick sanity
check for any arm64 developer. I have some general Ideas (A C file including
all the arm code & headers and see if it compiles) about how to do this but no
concrete ideas yet. Pointers/Ideas are highly appreciated

To further harden the extraction of code/headers one could do the following:
  1. Expand all the macros on the header/code 
       a) with -DARM64_S390_COMMON
       b) without -DARM64_S390_COMMON
  2. The diff of a & b should be the stuff s390 needs
  3. Postprocess it a bit (guards and copyight)

But the AWK approach looked more straight forward and simpler.

There is no way around it - In the future Arm64 maintainers should at least
build s390 before sending merge request.


	Steffen


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

Hendrik Brueckner (1):
  s390/hwcaps: Report SAE support as hwcap

Paolo Bonzini (3):
  VFIO: take reference to the KVM module
  KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio
  KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio

Steffen Eiden (23):
  KVM: Make device name configurable
  KVM: Remove KVM_MMIO as config option
  arm64: Use proper include variant
  arm64: Prepare sharing arm64 headers with s390
  KVM: arm64: Prepare sharing arm64 code with s390
  KVM: arm64: Access elements of vcpu_gp_regs individually
  KVM: arm64: Refactor core-reset into a separate function
  s390: Use arm64 headers
  KVM: s390: Use arm64 code
  KVM: s390: Prepare KVM/s390 for a second KVM module
  KVM: s390: Move s390 kvm code into a subdirectory
  KVM: S390: Prepare gmap for a second KVM implementation
  KVM: s390: gmap: Refactor storage key and CMMA code into separate
    files
  KVM: s390: Refactor prefix handling into a separate file
  KVM: s390: Prepare kvm-s390 for a second kvm module
  s390: Introduce Start Arm Execution instruction
  KVM: s390: arm64: Introduce host definitions
  KVM: s390: Add basic arm64 kvm module
  KVM: s390: arm64: Implement required functions
  KVM: s390: arm64: Implement vm/vcpu create destroy.
  KVM: s390: arm64: Implement vCPU IOCTLs
  KVM: s390: arm64: Implement basic page fault handler
  KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild

 arch/arm64/Makefile                           |   2 +
 arch/arm64/include/asm/brk-imm.h              |   1 +
 arch/arm64/include/asm/esr.h                  |   5 +-
 arch/arm64/include/asm/kvm_arm.h              |   6 +-
 arch/arm64/include/asm/kvm_emulate.h          |  32 +-
 arch/arm64/include/asm/kvm_host.h             |  38 +-
 arch/arm64/include/asm/kvm_mmu.h              |   6 +
 arch/arm64/include/asm/ptrace.h               |   9 +
 arch/arm64/include/asm/sysreg.h               |  31 +-
 arch/arm64/kvm/Kconfig                        |   1 -
 arch/arm64/kvm/arm.c                          |   3 +
 arch/arm64/kvm/guest.c                        |  22 +-
 arch/arm64/kvm/handle_exit.c                  |   6 +
 arch/arm64/kvm/hyp/exception.c                |   7 +-
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h    |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |   6 +-
 arch/arm64/kvm/mmio.c                         |  14 +
 arch/arm64/kvm/reset.c                        |  46 +-
 arch/loongarch/include/asm/kvm_host.h         |   2 +
 arch/loongarch/kvm/Kconfig                    |   1 -
 arch/mips/include/asm/kvm_host.h              |   2 +
 arch/mips/kvm/Kconfig                         |   1 -
 arch/powerpc/include/asm/kvm_host.h           |   7 +
 arch/powerpc/kvm/Kconfig                      |   4 -
 arch/riscv/include/asm/kvm_host.h             |   2 +
 arch/riscv/kvm/Kconfig                        |   1 -
 arch/s390/Kconfig                             |   2 +-
 arch/s390/boot/ipl_parm.c                     |   2 +-
 arch/s390/boot/uv.c                           |   2 +-
 arch/s390/configs/debug_defconfig             |   2 +-
 arch/s390/configs/defconfig                   |   3 +-
 arch/s390/include/arm64/kvm_emulate.h         | 135 +++
 arch/s390/include/arm64/kvm_nested.h          |  11 +
 arch/s390/include/asm/Kbuild                  |   3 +
 arch/s390/include/asm/asm-prototypes.h        |   1 +
 arch/s390/include/asm/elf.h                   |   2 +
 arch/s390/include/asm/kvm.h                   |   6 +
 arch/s390/include/asm/kvm_host.h              | 772 +-----------------
 arch/s390/include/asm/kvm_host_arm64.h        | 210 +++++
 arch/s390/include/asm/kvm_host_arm64_types.h  | 129 +++
 .../asm/{kvm_host.h => kvm_host_s390.h}       |  17 +-
 ...kvm_host_types.h => kvm_host_s390_types.h} |   6 +-
 arch/s390/include/asm/kvm_host_types.h        | 351 +-------
 arch/s390/include/asm/sae.h                   |  56 ++
 arch/s390/include/asm/sclp.h                  |   5 +-
 arch/s390/include/asm/stacktrace.h            |   5 +
 arch/s390/kernel/asm-offsets.c                |   1 +
 arch/s390/kernel/early.c                      |   2 +-
 arch/s390/kernel/entry.S                      |  35 +-
 arch/s390/kernel/perf_event.c                 |   2 +-
 arch/s390/kernel/processor.c                  |   3 +
 arch/s390/kvm/Kconfig                         |  37 +-
 arch/s390/kvm/Makefile                        |  12 +-
 arch/s390/kvm/arm64/Kconfig                   |  23 +
 arch/s390/kvm/arm64/Makefile                  |  94 +++
 arch/s390/kvm/arm64/Makefile.gen              |  30 +
 arch/s390/kvm/arm64/arm.c                     | 726 ++++++++++++++++
 arch/s390/kvm/arm64/arm.h                     |  63 ++
 arch/s390/kvm/arm64/copy-arm64c.awk           |  69 ++
 arch/s390/kvm/arm64/guest.c                   | 169 ++++
 arch/s390/kvm/arm64/guest.h                   |  14 +
 arch/s390/kvm/arm64/handle_exit.c             | 143 ++++
 arch/s390/kvm/arm64/handle_exit.h             |   9 +
 arch/s390/kvm/arm64/inject_fault.c            |  21 +
 arch/s390/kvm/arm64/mmio.c                    |  12 +
 arch/s390/kvm/arm64/mmu.c                     | 178 ++++
 arch/s390/kvm/arm64/reset.c                   |  62 ++
 arch/s390/kvm/arm64/reset.h                   |  11 +
 arch/s390/kvm/gmap/Makefile                   |  12 +
 arch/s390/kvm/gmap/cmma.c                     | 313 +++++++
 arch/s390/kvm/gmap/cmma.h                     |  36 +
 arch/s390/kvm/{ => gmap}/dat.c                | 552 +------------
 arch/s390/kvm/{ => gmap}/dat.h                |  20 +-
 arch/s390/kvm/{ => gmap}/faultin.c            |  11 +-
 arch/s390/kvm/{ => gmap}/faultin.h            |   6 +-
 arch/s390/kvm/{ => gmap}/gmap.c               | 114 +--
 arch/s390/kvm/{ => gmap}/gmap.h               |  44 +-
 arch/s390/kvm/gmap/mmu.c                      | 193 +++++
 arch/s390/kvm/gmap/prefix-stubs.c             |  21 +
 arch/s390/kvm/gmap/prefix.c                   |  80 ++
 arch/s390/kvm/gmap/prefix.h                   |  68 ++
 arch/s390/kvm/gmap/sk.c                       | 264 ++++++
 arch/s390/kvm/gmap/sk.h                       |  18 +
 arch/s390/kvm/gmap/trace-gmap.h               |  59 ++
 arch/s390/kvm/{ => s390}/Kconfig              |  27 +-
 arch/s390/kvm/{ => s390}/Makefile             |  10 +-
 arch/s390/kvm/{ => s390}/diag.c               |   2 +-
 arch/s390/kvm/{ => s390}/gaccess.c            |   3 +-
 arch/s390/kvm/{ => s390}/gaccess.h            |   2 +-
 arch/s390/kvm/{ => s390}/guestdbg.c           |   2 +-
 arch/s390/kvm/{ => s390}/intercept.c          |   2 +-
 arch/s390/kvm/{ => s390}/interrupt.c          |   2 +-
 arch/s390/kvm/{ => s390}/pci.c                |   2 +-
 arch/s390/kvm/{ => s390}/pci.h                |   0
 arch/s390/kvm/{ => s390}/priv.c               |   4 +-
 arch/s390/kvm/{ => s390}/pv.c                 |   2 +-
 arch/s390/kvm/{kvm-s390.c => s390/s390.c}     | 146 +---
 arch/s390/kvm/{kvm-s390.h => s390/s390.h}     |  18 +-
 arch/s390/kvm/{ => s390}/sigp.c               |   2 +-
 arch/s390/kvm/{ => s390}/trace-s390.h         |   0
 arch/s390/kvm/{ => s390}/trace.h              |  14 -
 arch/s390/kvm/{ => s390}/vsie.c               |   2 +-
 arch/s390/tools/Makefile                      |   5 +
 arch/s390/tools/Makefile.arm64h               |  58 ++
 arch/s390/tools/copy-arm64h-full.awk          |  43 +
 arch/s390/tools/copy-arm64h.awk               |  71 ++
 arch/s390/tools/opcodes.txt                   |   3 +
 arch/x86/include/asm/kvm_host.h               |   2 +
 arch/x86/kvm/Kconfig                          |   1 -
 arch/x86/kvm/mmu/tdp_mmu.c                    |   2 +-
 arch/x86/kvm/svm/sev.c                        |   2 +-
 arch/x86/kvm/vmx/nested.h                     |   4 +-
 drivers/s390/char/sclp_early.c                |   1 +
 drivers/vfio/device_cdev.c                    |   2 +-
 drivers/vfio/group.c                          |   5 +-
 drivers/vfio/vfio.h                           |  15 +-
 drivers/vfio/vfio_main.c                      |  52 +-
 include/linux/kvm_host.h                      |  17 +-
 include/linux/kvm_types.h                     |  33 +
 include/linux/vfio.h                          |   4 +-
 virt/kvm/Kconfig                              |   3 -
 virt/kvm/Makefile.kvm                         |   3 +-
 virt/kvm/coalesced_mmio.c                     |   3 +
 virt/kvm/coalesced_mmio.h                     |   2 +-
 virt/kvm/kvm_main.c                           |  75 +-
 virt/kvm/vfio.c                               |   4 +-
 126 files changed, 3944 insertions(+), 2212 deletions(-)
 create mode 100644 arch/s390/include/arm64/kvm_emulate.h
 create mode 100644 arch/s390/include/arm64/kvm_nested.h
 create mode 100644 arch/s390/include/asm/kvm.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
 copy arch/s390/include/asm/{kvm_host.h => kvm_host_s390.h} (98%)
 copy arch/s390/include/asm/{kvm_host_types.h => kvm_host_s390_types.h} (98%)
 create mode 100644 arch/s390/include/asm/sae.h
 create mode 100644 arch/s390/kvm/arm64/Kconfig
 create mode 100644 arch/s390/kvm/arm64/Makefile
 create mode 100644 arch/s390/kvm/arm64/Makefile.gen
 create mode 100644 arch/s390/kvm/arm64/arm.c
 create mode 100644 arch/s390/kvm/arm64/arm.h
 create mode 100644 arch/s390/kvm/arm64/copy-arm64c.awk
 create mode 100644 arch/s390/kvm/arm64/guest.c
 create mode 100644 arch/s390/kvm/arm64/guest.h
 create mode 100644 arch/s390/kvm/arm64/handle_exit.c
 create mode 100644 arch/s390/kvm/arm64/handle_exit.h
 create mode 100644 arch/s390/kvm/arm64/inject_fault.c
 create mode 100644 arch/s390/kvm/arm64/mmio.c
 create mode 100644 arch/s390/kvm/arm64/mmu.c
 create mode 100644 arch/s390/kvm/arm64/reset.c
 create mode 100644 arch/s390/kvm/arm64/reset.h
 create mode 100644 arch/s390/kvm/gmap/Makefile
 create mode 100644 arch/s390/kvm/gmap/cmma.c
 create mode 100644 arch/s390/kvm/gmap/cmma.h
 rename arch/s390/kvm/{ => gmap}/dat.c (61%)
 rename arch/s390/kvm/{ => gmap}/dat.h (96%)
 rename arch/s390/kvm/{ => gmap}/faultin.c (96%)
 rename arch/s390/kvm/{ => gmap}/faultin.h (96%)
 rename arch/s390/kvm/{ => gmap}/gmap.c (93%)
 rename arch/s390/kvm/{ => gmap}/gmap.h (94%)
 create mode 100644 arch/s390/kvm/gmap/mmu.c
 create mode 100644 arch/s390/kvm/gmap/prefix-stubs.c
 create mode 100644 arch/s390/kvm/gmap/prefix.c
 create mode 100644 arch/s390/kvm/gmap/prefix.h
 create mode 100644 arch/s390/kvm/gmap/sk.c
 create mode 100644 arch/s390/kvm/gmap/sk.h
 create mode 100644 arch/s390/kvm/gmap/trace-gmap.h
 copy arch/s390/kvm/{ => s390}/Kconfig (61%)
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
 rename arch/s390/kvm/{kvm-s390.c => s390/s390.c} (98%)
 rename arch/s390/kvm/{kvm-s390.h => s390/s390.h} (97%)
 rename arch/s390/kvm/{ => s390}/sigp.c (99%)
 rename arch/s390/kvm/{ => s390}/trace-s390.h (100%)
 rename arch/s390/kvm/{ => s390}/trace.h (97%)
 rename arch/s390/kvm/{ => s390}/vsie.c (99%)
 create mode 100644 arch/s390/tools/Makefile.arm64h
 create mode 100644 arch/s390/tools/copy-arm64h-full.awk
 create mode 100644 arch/s390/tools/copy-arm64h.awk


base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.53.0

