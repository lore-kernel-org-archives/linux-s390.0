Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7A44E037;
	Tue, 28 Apr 2026 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392369; cv=none; b=sm8gd0dKiHXsjD2g3tUvqrUCXZGSdOFf0h0vCHrCtcHLIipylxtGVfUUemuLOFhrAXJfbWKwYHTYbboSXoFFsACzh3hAfD1B72JWlPt7xDaVU8eeLECaRHuiqhi16UFw42kqZKeJAEgGcEUAwklOTjppZjB2kV6Q04gcUG47VeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392369; c=relaxed/simple;
	bh=+TEIi82VT2aQJAyrptqto1W1wxG9TfOQYbA0YuZeSq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=odfrc2TUJmmsOQ/qpcTMZCccRv4hC4W243DDNqgOeXNcoTj5w/4/PDbhRrAXyr6tib81NbwXK3Ik8i95NUXCwaZTFiG8jF1/EmR6MYkL+0AJQIJLzq7mGDscBExBM0pF6JIUh1HRpQS8yneZng60QkRjwjzi7BR5E4KYsiVJ1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J5xphU26; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J5xphU26"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S8aibO3558379;
	Tue, 28 Apr 2026 16:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ixmz96td0o8kYJDeqUzFaGIP06yz
	LnzSCHh3+zOyyI8=; b=J5xphU26Le7nmj3jmhhHsyI4keSBePNdvZcj8y04dqs/
	Vu8ao9iWVrh3XpuowMo0f7BQ785P9iR5gUliAUdJTDH8WYlBg+TQNy6t2m1MphW2
	qOs5uVQUtOvZTTRoW2dyhf3TIzngKQKIN4/byTvKsE/91TcEgwM6es2VpiupjLCq
	mIURQfwvGxp54AYuM9OOKpmkm7lkwSkSNZ6SdaOHIpBDknGceTIjO2qhmZtiNnNV
	QGLiPySNlNXmVd6gA2Qv0fmmA1QdyQnNRpTrU+WPtFAeDxkWVqLCmo3625xi8gIw
	EJX/U3e3F2ww68iK0/yu/cyyu1aTvUWgS2SgDasRXA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44pgpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrq6m001945;
	Tue, 28 Apr 2026 16:05:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5ga9ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SG5R7749021246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 16:05:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB0152004B;
	Tue, 28 Apr 2026 16:05:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BC7320040;
	Tue, 28 Apr 2026 16:05:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 16:05:27 +0000 (GMT)
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
Subject: [RFC PATCH v2 00/28] KVM: s390: Introduce arm64 KVM - using symlinks
Date: Tue, 28 Apr 2026 18:04:57 +0200
Message-ID: <20260428160527.1378085-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _k_e1EFXCh5PugmhUtP8LSK7iZ02ozQa
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0dacd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=UgY_9lrrsBdwoOJ0i9gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _k_e1EFXCh5PugmhUtP8LSK7iZ02ozQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX0DchNp1VdgtV
 gkpzIKX3SsN64NbXfY/8TRUuJTN/Y7ZcL2o+ghv6eQmAiHrnPkpUd0+MNWhXinAj13VPOtZDGYv
 ORyUZ0PQeSvM4k1EuxARfnR9HYI4uldC3YQ217vWTW2QrKnAFnMNpGk8RrD1mxWzoKiIHx608zC
 A6dEZqmLCeR3XqRjgyui7khac9nkR8KxF6BAA8s11sm2gvlYB8rogP1RRBn3RB0funGKx8mkrCm
 uYs9EpR3u8mx9hCAVlcZFE+zNWp2Wi1KMcMHB+qH+V8wqcCvZIxUs5QcPm57VMGtZ9KNPu9kRF7
 yaWK7hancRVBGWW2Ab2mFznPvt8YGBKEbGb3ymjRD5capfDtLctWK4YVgMDvZVCvSqbmOe0+uuq
 3dfhOSMSFQ3/hJMV2xX/Hjd2QLUyv6ZtBGumpW0sxTKgR45377pe7ntMR5UwOvP7xS8tvwUjsYm
 BtBiriIHbKqrth92Fcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

Hi all, 

This is a variant of 

[PATCH v2 00/28] KVM: s390: Introduce arm64 KVM
Message-ID: 20260428155622.1361364-1-seiden@linux.ibm.com

using symlinks for the arm headers instead of moving them. Thank you Andreas!
Beside that, it is the same series.

The (range-)diff to the 'original' series is:

b is this series.

4:  9b7e04e2b41e !  4:  49571c6bc977 arm64: Provide arm64 UAPI for other host architectures
     a => b | 121 ++++++++++++++---------------------------------------------------
     1 file changed, 26 insertions(+), 95 deletions(-)
 5:  ec761405f6b8 =  5:  2f264e59cf30 arm64: Extract sysreg definitions
 6:  204d98beea66 !  6:  85ad00827e9a arm64: Provide arm64 API for non-native architectures
     a => b | 169 +++++++++++++++++++++++++++++++++++------------------------------
     1 file changed, 92 insertions(+), 77 deletions(-)
 7:  01a6ef0ec29b !  7:  4e8fa04aabfa KVM: arm64: Provide arm64 KVM API for non-native architectures
     a => b | 49 +++++++++++++++++++++++++++----------------------
     1 file changed, 27 insertions(+), 22 deletions(-)
 8:  4dc45327c239 !  8:  08fd8c972984 arm64: Extract pstate definitions from ptrace
     a => b | 222 ++++++++++++++++++++++++++++++++---------------------------------
     1 file changed, 110 insertions(+), 112 deletions(-)
 9:  ff405f180fb5 =  9:  dc86db4b65c6 KVM: arm64: Share kvm_emulate definitions
10:  eface4a46adc ! 10:  b7543c130090 KVM: arm64: Make some arm64 KVM code shareable
     a => b | 31 ++++++++++++++++++-------------
     1 file changed, 18 insertions(+), 13 deletions(-)


What do you think about that?

	Steffen

since v1:
	- use symlinks for arm headers
	- moved mispositioned kvm_supports_32bit_el0 from shared to s390 (thanks Marc)
	- various small issues fixed (non exhaustive)
		- un-move macros creating arm instructions from sysreg-defs.h back to sysreg.h
		- reset sp register
		- use 'a' inline asm modifier for address registers in stiasrm and lasrm
		- clear x2 after SAE exit
		- fix unnecessary recompilations of the kvm-arm64 module

Hendrik Brueckner (1):
  s390/hwcaps: Report SAE support as hwcap

Nina Schoetterl-Glausch (3):
  arm64: Extract sysreg definitions
  arm64: Extract pstate definitions from ptrace
  KVM: arm64: Share reset general register code

Paolo Bonzini (3):
  VFIO: take reference to the KVM module
  KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio
  KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio

Steffen Eiden (21):
  arm64: Provide arm64 UAPI for s390 host architecture
  arm64: Provide arm64 API for non-native architectures
  KVM: arm64: Provide arm64 KVM API for non-native architectures
  KVM: arm64: Share kvm_emulate definitions
  KVM: arm64: Make some arm64 KVM code shareable
  KVM: arm64: Access elements of vcpu_gp_regs individually
  KVM: arm64: Extract & share ipa size shift calculation
  KVM: s390: arm64: Implement required functions
  MAINTAINERS: Add Steffen as reviewer for KVM/arm64
  KVM: s390: Move s390 kvm code into a subdirectory
  KVM: S390: Refactor gmap
  KVM: Make device name configurable
  KVM: Remove KVM_MMIO as config option
  KVM: s390: Prepare kvm-s390 for a second kvm module
  s390: Introduce Start Arm Execution instruction
  KVM: s390: arm64: Introduce host definitions
  KVM: s390: Add basic arm64 kvm module
  KVM: s390: arm64: Implement vm/vcpu create destroy.
  KVM: s390: arm64: Implement vCPU IOCTLs
  KVM: s390: arm64: Implement basic page fault handler
  KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild

 MAINTAINERS                                   |    5 +
 arch/arm64/Makefile                           |    2 +
 arch/arm64/include/asm/Kbuild                 |    2 +-
 arch/arm64/include/asm/brk-imm.h              |    6 +-
 arch/arm64/include/asm/el2_setup.h            |    2 +-
 arch/arm64/include/asm/esr.h                  |   62 +-
 arch/arm64/include/asm/hardirq.h              |    2 +-
 arch/arm64/include/asm/kvm_arm.h              |    5 +-
 arch/arm64/include/asm/kvm_emulate.h          |  245 +--
 arch/arm64/include/asm/kvm_host.h             |  200 +-
 arch/arm64/include/asm/kvm_mmu.h              |   41 +-
 arch/arm64/include/asm/ptrace.h               |   34 +-
 .../include/asm/{sysreg.h => sysreg-defs.h}   |  351 +---
 arch/arm64/include/asm/sysreg.h               |  960 +---------
 arch/arm64/include/uapi/asm/kvm.h             |   24 +-
 arch/arm64/include/uapi/asm/pstate.h          |   53 +
 arch/arm64/include/uapi/asm/ptrace.h          |   49 +-
 arch/arm64/include/uapi/linux/kvm.h           |    8 +
 arch/arm64/kernel/head.S                      |    2 +-
 arch/arm64/kernel/hyp-stub.S                  |    2 +-
 arch/arm64/kernel/traps.c                     |   53 -
 arch/arm64/kvm/Kconfig                        |    1 -
 arch/arm64/kvm/Makefile                       |    5 +-
 arch/arm64/kvm/arm.c                          |   54 +-
 arch/arm64/kvm/debug.c                        |    2 +-
 arch/arm64/kvm/guest.c                        |  294 +--
 arch/arm64/kvm/handle_exit.c                  |   52 +-
 arch/arm64/kvm/hyp/entry.S                    |    2 +-
 arch/arm64/kvm/hyp/exception.c                |    7 +-
 arch/arm64/kvm/hyp/hyp-entry.S                |    2 +-
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h    |   17 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |    6 +-
 arch/arm64/kvm/hyp/nvhe/host.S                |    2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S            |    2 +-
 arch/arm64/kvm/mmio.c                         |    1 +
 arch/arm64/kvm/mmu.c                          |   21 +-
 arch/arm64/kvm/nested.c                       |    2 +-
 arch/arm64/kvm/reset.c                        |   34 +-
 arch/arm64/kvm/sys_regs.c                     |    2 +-
 arch/arm64/kvm/trace_arm.h                    |   25 -
 arch/arm64/kvm/vgic/vgic-its.c                |    2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c            |    2 +-
 arch/arm64/kvm/vgic/vgic-v3-nested.c          |    2 +-
 arch/arm64/tools/Makefile                     |   14 +-
 arch/arm64/tools/Makefile.sysreg              |   12 +
 arch/arm64/tools/gen-sysreg.awk               |    6 +-
 arch/loongarch/include/asm/kvm_host.h         |    2 +
 arch/loongarch/kvm/Kconfig                    |    1 -
 arch/mips/include/asm/kvm_host.h              |    2 +
 arch/mips/kvm/Kconfig                         |    1 -
 arch/powerpc/include/asm/kvm_host.h           |    7 +
 arch/powerpc/kvm/Kconfig                      |    4 -
 arch/riscv/include/asm/kvm_host.h             |    2 +
 arch/riscv/kvm/Kconfig                        |    1 -
 arch/s390/Kconfig                             |    2 +-
 arch/s390/boot/ipl_parm.c                     |    2 +-
 arch/s390/boot/uv.c                           |    2 +-
 arch/s390/configs/debug_defconfig             |    2 +-
 arch/s390/configs/defconfig                   |    3 +-
 arch/s390/include/asm/Kbuild                  |    3 +
 arch/s390/include/asm/asm-prototypes.h        |    1 +
 arch/s390/include/asm/elf.h                   |    2 +
 arch/s390/include/asm/kvm.h                   |    6 +
 arch/s390/include/asm/kvm_emulate.h           |  135 ++
 arch/s390/include/asm/kvm_host.h              |  748 +-------
 arch/s390/include/asm/kvm_host_arm64.h        |  202 ++
 arch/s390/include/asm/kvm_host_arm64_types.h  |  129 ++
 .../asm/{kvm_host.h => kvm_host_s390.h}       |   19 +-
 ...kvm_host_types.h => kvm_host_s390_types.h} |    0
 arch/s390/include/asm/kvm_mmu.h               |   12 +
 arch/s390/include/asm/kvm_nested.h            |   13 +
 arch/s390/include/asm/sae.h                   |   39 +
 arch/s390/include/asm/sclp.h                  |    5 +-
 arch/s390/include/asm/stacktrace.h            |    5 +
 arch/s390/include/uapi/arch/arm64/asm/kvm.h   |    1 +
 .../s390/include/uapi/arch/arm64/asm/pstate.h |    1 +
 .../include/uapi/arch/arm64/asm/sve_context.h |    1 +
 arch/s390/include/uapi/arch/arm64/linux/kvm.h |    1 +
 arch/s390/kernel/asm-offsets.c                |    3 +-
 arch/s390/kernel/early.c                      |    2 +-
 arch/s390/kernel/entry.S                      |   35 +-
 arch/s390/kernel/perf_event.c                 |    2 +-
 arch/s390/kernel/processor.c                  |    3 +
 arch/s390/kvm/Kconfig                         |   36 +-
 arch/s390/kvm/Makefile                        |   12 +-
 arch/s390/kvm/arm64/Kconfig                   |   21 +
 arch/s390/kvm/arm64/Makefile                  |  108 ++
 arch/s390/kvm/arm64/arm.c                     |  698 +++++++
 arch/s390/kvm/arm64/arm.h                     |   61 +
 arch/s390/kvm/arm64/guest.c                   |  162 ++
 arch/s390/kvm/arm64/guest.h                   |   15 +
 arch/s390/kvm/arm64/handle_exit.c             |   52 +
 arch/s390/kvm/arm64/inject_fault.c            |   21 +
 arch/s390/kvm/arm64/mmu.c                     |  178 ++
 arch/s390/kvm/arm64/reset.c                   |   45 +
 arch/s390/kvm/arm64/reset.h                   |   11 +
 arch/s390/kvm/gmap/Makefile                   |    5 +
 arch/s390/kvm/{ => gmap}/dat.c                |    0
 arch/s390/kvm/{ => gmap}/dat.h                |    6 +-
 arch/s390/kvm/{ => gmap}/faultin.c            |   11 +-
 arch/s390/kvm/{ => gmap}/faultin.h            |    6 +-
 arch/s390/kvm/{ => gmap}/gmap.c               |   13 +-
 arch/s390/kvm/{ => gmap}/gmap.h               |   17 +-
 arch/s390/kvm/gmap/mmu.c                      |  154 ++
 arch/s390/kvm/gmap/trace-gmap.h               |   59 +
 arch/s390/kvm/{ => s390}/Kconfig              |   26 +-
 arch/s390/kvm/{ => s390}/Makefile             |   10 +-
 arch/s390/kvm/{ => s390}/diag.c               |    2 +-
 arch/s390/kvm/{ => s390}/gaccess.c            |    2 +-
 arch/s390/kvm/{ => s390}/gaccess.h            |    2 +-
 arch/s390/kvm/{ => s390}/guestdbg.c           |    2 +-
 arch/s390/kvm/{ => s390}/intercept.c          |    2 +-
 arch/s390/kvm/{ => s390}/interrupt.c          |    2 +-
 arch/s390/kvm/{ => s390}/pci.c                |    2 +-
 arch/s390/kvm/{ => s390}/pci.h                |    0
 arch/s390/kvm/{ => s390}/priv.c               |    2 +-
 arch/s390/kvm/{ => s390}/pv.c                 |    2 +-
 arch/s390/kvm/{kvm-s390.c => s390/s390.c}     |  126 +-
 arch/s390/kvm/{kvm-s390.h => s390/s390.h}     |   18 +-
 arch/s390/kvm/{ => s390}/sigp.c               |    2 +-
 arch/s390/kvm/{ => s390}/trace-s390.h         |    0
 arch/s390/kvm/{ => s390}/trace.h              |   14 -
 arch/s390/kvm/{ => s390}/vsie.c               |    2 +-
 arch/s390/tools/Makefile                      |    2 +
 arch/s390/tools/opcodes.txt                   |    3 +
 arch/x86/include/asm/kvm_host.h               |    2 +
 arch/x86/kvm/Kconfig                          |    1 -
 arch/x86/kvm/mmu/tdp_mmu.c                    |    2 +-
 arch/x86/kvm/vmx/nested.h                     |    4 +-
 drivers/s390/char/sclp_early.c                |    1 +
 drivers/vfio/device_cdev.c                    |    2 +-
 drivers/vfio/group.c                          |    5 +-
 drivers/vfio/vfio.h                           |   15 +-
 drivers/vfio/vfio_main.c                      |   51 +-
 include/arch/arm64/asm/brk-imm.h              |    1 +
 include/arch/arm64/asm/esr.h                  |    1 +
 include/arch/arm64/asm/pstate.h               |   46 +
 include/arch/arm64/asm/sysreg-defs.h          |    1 +
 include/kvm/arm64/guest.h                     |   13 +
 include/kvm/arm64/handle_exit.h               |   14 +
 include/kvm/arm64/kvm_arm.h                   |    1 +
 include/kvm/arm64/kvm_emulate.h               |  268 +++
 include/kvm/arm64/kvm_host.h                  |  197 ++
 include/kvm/arm64/kvm_mmu.h                   |   47 +
 include/kvm/arm64/reset.h                     |    8 +
 include/linux/kvm_host.h                      |   17 +-
 include/linux/kvm_types.h                     |   30 +
 include/linux/vfio.h                          |    4 +-
 include/uapi/linux/{kvm.h => kvm-generic.h}   |   11 +-
 include/uapi/linux/kvm.h                      | 1649 +----------------
 usr/include/Makefile                          |    1 +
 virt/kvm/Kconfig                              |    3 -
 virt/kvm/Makefile.kvm                         |    3 +-
 virt/kvm/arm64/Makefile.kvm                   |   13 +
 virt/kvm/arm64/arm.c                          |   75 +
 virt/kvm/arm64/guest.c                        |  302 +++
 virt/kvm/arm64/handle_exit.c                  |   54 +
 virt/kvm/arm64/mmio.c                         |    1 +
 virt/kvm/arm64/reset.c                        |   43 +
 virt/kvm/arm64/trace.h                        |   42 +
 virt/kvm/coalesced_mmio.c                     |    3 +
 virt/kvm/coalesced_mmio.h                     |    2 +-
 virt/kvm/kvm_main.c                           |   63 +-
 virt/kvm/vfio.c                               |    4 +-
 164 files changed, 3865 insertions(+), 5123 deletions(-)
 copy arch/arm64/include/asm/{sysreg.h => sysreg-defs.h} (79%)
 create mode 100644 arch/arm64/include/uapi/asm/pstate.h
 create mode 100644 arch/arm64/include/uapi/linux/kvm.h
 create mode 100644 arch/arm64/tools/Makefile.sysreg
 create mode 100644 arch/s390/include/asm/kvm.h
 create mode 100644 arch/s390/include/asm/kvm_emulate.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64.h
 create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
 copy arch/s390/include/asm/{kvm_host.h => kvm_host_s390.h} (98%)
 rename arch/s390/include/asm/{kvm_host_types.h => kvm_host_s390_types.h} (100%)
 create mode 100644 arch/s390/include/asm/kvm_mmu.h
 create mode 100644 arch/s390/include/asm/kvm_nested.h
 create mode 100644 arch/s390/include/asm/sae.h
 create mode 120000 arch/s390/include/uapi/arch/arm64/asm/kvm.h
 create mode 120000 arch/s390/include/uapi/arch/arm64/asm/pstate.h
 create mode 120000 arch/s390/include/uapi/arch/arm64/asm/sve_context.h
 create mode 120000 arch/s390/include/uapi/arch/arm64/linux/kvm.h
 create mode 100644 arch/s390/kvm/arm64/Kconfig
 create mode 100644 arch/s390/kvm/arm64/Makefile
 create mode 100644 arch/s390/kvm/arm64/arm.c
 create mode 100644 arch/s390/kvm/arm64/arm.h
 create mode 100644 arch/s390/kvm/arm64/guest.c
 create mode 100644 arch/s390/kvm/arm64/guest.h
 create mode 100644 arch/s390/kvm/arm64/handle_exit.c
 create mode 100644 arch/s390/kvm/arm64/inject_fault.c
 create mode 100644 arch/s390/kvm/arm64/mmu.c
 create mode 100644 arch/s390/kvm/arm64/reset.c
 create mode 100644 arch/s390/kvm/arm64/reset.h
 create mode 100644 arch/s390/kvm/gmap/Makefile
 rename arch/s390/kvm/{ => gmap}/dat.c (100%)
 rename arch/s390/kvm/{ => gmap}/dat.h (99%)
 rename arch/s390/kvm/{ => gmap}/faultin.c (96%)
 rename arch/s390/kvm/{ => gmap}/faultin.h (96%)
 rename arch/s390/kvm/{ => gmap}/gmap.c (99%)
 rename arch/s390/kvm/{ => gmap}/gmap.h (93%)
 create mode 100644 arch/s390/kvm/gmap/mmu.c
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
 create mode 120000 include/arch/arm64/asm/brk-imm.h
 create mode 120000 include/arch/arm64/asm/esr.h
 create mode 100644 include/arch/arm64/asm/pstate.h
 create mode 120000 include/arch/arm64/asm/sysreg-defs.h
 create mode 100644 include/kvm/arm64/guest.h
 create mode 100644 include/kvm/arm64/handle_exit.h
 create mode 120000 include/kvm/arm64/kvm_arm.h
 create mode 100644 include/kvm/arm64/kvm_emulate.h
 create mode 100644 include/kvm/arm64/kvm_host.h
 create mode 100644 include/kvm/arm64/kvm_mmu.h
 create mode 100644 include/kvm/arm64/reset.h
 copy include/uapi/linux/{kvm.h => kvm-generic.h} (99%)
 create mode 100644 virt/kvm/arm64/Makefile.kvm
 create mode 100644 virt/kvm/arm64/arm.c
 create mode 100644 virt/kvm/arm64/guest.c
 create mode 100644 virt/kvm/arm64/handle_exit.c
 create mode 120000 virt/kvm/arm64/mmio.c
 create mode 100644 virt/kvm/arm64/reset.c
 create mode 100644 virt/kvm/arm64/trace.h


base-commit: 7f87a5ea75f011d2c9bc8ac0167e5e2d1adb1594
-- 
2.51.0

