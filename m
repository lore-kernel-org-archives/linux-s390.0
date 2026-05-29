Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5D3CAA48;
	Fri, 29 May 2026 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069902; cv=none; b=Pg9Yhf821hrl5Lz/9B1ek7KQaMkq5e0Of25e3BfQVWUpw0AAbioVguWJ4usP7tWJVlNJ6xQQYjibWM7YZsNBXKaemeNQPKXEb79187Y+oAi5kNNZxL7xS5vf3AjDbD8G/SPMg2OUsfSK3LUY47zRRTz+2oj6K5oSqpnZkVV4O9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069902; c=relaxed/simple;
	bh=40NIWmMj2j6AGMPIbuxbbM5mjS1ir4gNinf6bImqr0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ngr5Izr6nHVBlNryiiYbpDmZwRaz0mGquGW1CZOp0Eks7tzro+LkZhtkoKCVkeDYyq2EmM2O/Dx4gqK0mrebJD7a+x68/WMjTRML7vNF2l934KikelZ9R2g7U8Cv2bCzbPBtm1uqUF/9mQHexkVz+bqA0JZ8pgx68G3xUEa9Wa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=keQFv8vX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="keQFv8vX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TF8fEm1468200;
	Fri, 29 May 2026 15:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Bf8wYY6+8Y31meDLbgxcsA6FsCRN
	+H/RhNcSY77mq+0=; b=keQFv8vXc0P8d6mLs4NSNKn8x6A9bt59VzfUZhcXwVHg
	TW5tjydCK9zCKjgIEnDI9Ha8EJ3mTkhsZpuNKbYLdVblJiKpZ8XccEMlap2ZGwRK
	UZQdc39qiOOFDQgSyPE/TTHpBQi6/D8tm4mvws5T+0HQkOcmPWEqkVx9w1Y1sH4K
	PEK6MrqYM7yuhSru4tjHxknK9wYC3E3Vt9CnrLv0Mx58IW7S1iqJzu9MUeVDdMyI
	eodoDnPFcX/ggsBBsUOpCNzHTJKQiiCffQ5XJv9+lZ+V88hM/Sgm6Egb3E+02f5M
	2Fbn37xMzFLs7CA1aA/nDZKw3Qj7g6QIPKz2uWw3iQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886mb23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFd6BW018489;
	Fri, 29 May 2026 15:50:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc0fa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:50:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFoopp49348986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:50:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC06320043;
	Fri, 29 May 2026 15:50:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C2802004D;
	Fri, 29 May 2026 15:50:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:50:50 +0000 (GMT)
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
Subject: [PATCH v3 00/27] KVM: s390: Introduce arm64 KVM
Date: Fri, 29 May 2026 17:50:14 +0200
Message-ID: <20260529155050.2902245-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UJ3iVsT4YqUocbMXBkWTzF0T383qKg3_
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a19b5e4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ZYH-ZMYxzGqoZnFbl_wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX8KRRJL9ZV4jp
 YYPJp9QyuOGFFxhy8JYmPOdTMTLrFTMjIYL2dGYC6i8j2YQFibMfLt91rQwHgHPp91Ne6KgQkse
 9dMSYCOiyq+O2ACmrPbtfnqXelI8F/WjLcbCW7zJPSe+fhd2cw243NVPIlAT63ybMkukHDlDKaG
 r8ezO2jGyZ46+PVoPqIQ/+THsnS5fuxzRkECBqjGDKefd++zM5Zr5nksL9zqFx9bhYc8ykDMA0b
 r3AFj19PxLGuTd0DGEEHcVQFP8QpDpSAa9oOOLJ23L4mBpsrxuAQ2GXiRcITWhCiRq2gJNcUAWc
 ws/qbMYN/GhETFIPtJo1PbGdoGFqso39vXz2FcXV025bVqqOcbnxr/fmuEHB9y7OSWfIjJ/IGhZ
 U/5CLYNfNQzDUJjnUjUkniTVVRYPpPg6YYNYyNSXI8jKcL9RU8YEUX2UCta63ZQRy3AbRGidLqd
 s34E21krxf68amuYhNA==
X-Proofpoint-ORIG-GUID: UJ3iVsT4YqUocbMXBkWTzF0T383qKg3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

By introducing a novel virtualization acceleration for the ARM architecture on
s390 architecture, we aim to expand the platform's software ecosystem. This
initial patch series lays the groundwork by enabling KVM-accelerated ARM CPU
virtualization on s390. To achieve this, a common KVM layer between s390 and
arm64 is introduced (see below for more details). Design considerations of
arm64 on the s390 Architecture The s390 virtualization architecture is extended
with a set of new instructions dedicated to supporting ARM-based virtual
machines. The s390 KVM host acts as EL2 (hypervisor) for a EL1/EL0
(OS/application) arm64 guest. To achieve this, the new Start-Arm-Execution
(SAE) instruction enables accelerated execution of arm64 VMs.  Additional new
s390 instructions are introduced to query available arm64 features, used to
populate the arm64 ID register contents, as well as, new s390 instructions to
save/restore various arm64 registers in the VM context.

Summary of changes to arm64 KVM

UAPI / KAPI changes

The arm64 KVM UAPI headers are relocated to include/uapi/arch/arm64/,
allowing non‑arm64 hosts (such as s390) to use the arm64 KVM userspace API.
Likewise, the arm64 KVM kernel‑internal headers are relocated to
include/kvm/arm64/, and several arm64 asm headers are relocated to
include/arch/arm64/asm for architecture‑independent consumption.

Refactoring of arm64 headers and shared arm64 KVM functionality

To avoid code duplication, sharing logic between arm64/kvm and s390/kvm/arm64
is maximized while refactoring noise was minimized. IOCTL (arch) entry points
are deliberately kept separate for arm64 and arm64 on s390. This ensures full
control over execution paths for each KVM implementation. The arm64 sysreg
definitions and pstate/SPSR constants are extracted from their native headers
into dedicated, shareable files (sysreg-defs.h, pstate.h). This enables
other architectures to access sysreg name‑to‑ID mappings and pstate definitions
without relying on arm64‑specific, non‑shareable headers.

A new virt/kvm/arm64/ source directory is introduced to hold shared Arm64 KVM
implementation code, including guest register handling, exit handling,
general‑register reset logic, and IPA size/shift
calculations. Several functions are also refactored to improve portability for
non‑arm64 KVM implementations. 

Maintainership considerations

Introducing a shared arm64 KVM code base for both native arm64 and s390
implementations may have subtle implications for each architecture,
depending on the context and the contributor’s expertise. We therefore
recognize the importance of clear maintainership guidelines and
well-defined review processes to ensure the stability and correctness of
both implementations. We welcome community feedback on how best to
structure maintainership and the review workflow, and we are open to
suggestions for effective coordination between the arm64 and s390
maintainer teams.

UAPI design

The arm64 KVM UAPI headers are relocated from arch/arm64/include/uapi/
to the new include/uapi/arch/arm64/ directory, and generic KVM definitions are
split into include/uapi/linux/kvm-generic.h for use across all architectures.
To maintain ABI compatibility, type aliases are introduced; they resolve to
native arm64 types on arm64 and to equivalent inline struct definitions on
foreign hosts. The build system installs the headers in their original location
on arm64, while conditionally exporting them to the new location for s390.

KAPI design

The include/arch/arm64/asm/ directory is introduced to host arm64 asm headers
that are independent of the host CPU. On native arm64 systems, this path is
added with the highest precedence so that existing <asm/header.h> includes
continue to work without modification. Foreign architectures can opt in by
adding this path to their include search, enabling them to use these
architecture‑agnostic headers.

The KVM‑related headers are moved to include/kvm/arm64/, decoupling them from
the arm64 architecture directory. The design convention is that
architecture‑specific headers under <arch>/include/asm/ include from this
shared location, allowing non‑arm64 hosts to consume the arm64 KVM
infrastructure without duplicating code.

Series structure

KVM symbol cleanup:
	Three preparatory patches clean up KVM module symbol exports, making it
	possible to load two KVM modules side by side.

Arm64 header and code sharing:
	Selected arm64 UAPI, asm, and KVM kernel headers are
	refactored into architecture-agnostic include paths, and shared arm64 KVM code
	is relocated accordingly. This enables non-arm64 hosts to use the arm64 KVM
	infrastructure without duplication. 

s390 & KVM reorganization:
	The existing s390 KVM code is moved into a dedicated s390 subdirectory
	to make room for a second KVM implementation alongside it. The KVM
	core is extended to support a configurable device name (needed for two
	KVM devices on one architecture) Arm64

KVM on s390:
	The SAE (Start Arm Execution) instruction is introduced as the
	s390 mechanism for running Arm64 guests, and a new kvm-arm64 module is
	built up incrementally.

Upcoming patch series will introduce system-register handling, interrupt
support, hypercalls, and additional features such as PMU.

We appreciate your feedback and review.

The Linux on s390 team

since v2 [2]:
	- removed the already picked MAINTAINER patch
	- arm64
		- inverted the direction how arm uapi is generated. Now,
		  foreign architectures are copying arch/arm64/asm/kvm.h to the
		  dedicated generated uapi location location instead of vice
		  versa. Arm64 keeps its UAPI header local but they are
		  annotated with a
		  GENERATED in the guard
	- s390
		- improve inline asm in sae.h
		- load & restore fpu & vx regs


since v1 [1]:
	- moved mispositioned kvm_supports_32bit_el0 from shared to s390 (thanks Marc)
	- various small issues fixed (non exhaustive)
		- un-move macros creating arm instructions from sysreg-defs.h back to sysreg.h
		- reset sp register
		- use 'a' inline asm modifier for address registers in stiasrm and lasrm
		- clear x2 after SAE exit
		- fix unnecessary recompilations of the kvm-arm64 module
	- Add Steffen to KVM/arm64 reviewer
	- Rebased onto & included Paolos latest vfio series

[1] https://lore.kernel.org/linux-s390/20260402042125.3948963-1-seiden@linux.ibm.com/
[2] https://lore.kernel.org/linux-s390/20260428155622.1361364-1-seiden@linux.ibm.com/

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

Steffen Eiden (20):
  uapi: KVM: Provide arm64 UAPI for other host architectures
  arm64: Provide arm64 API for non-native architectures
  KVM: arm64: Provide arm64 KVM API for non-native architectures
  KVM: arm64: Share kvm_emulate definitions
  KVM: arm64: Make some arm64 KVM code shareable
  KVM: arm64: Access elements of vcpu_gp_regs individually
  KVM: arm64: Extract & share ipa size shift calculation
  KVM: s390: Move s390 kvm code into a subdirectory
  KVM: S390: Refactor gmap
  KVM: Make device name configurable
  KVM: Remove KVM_MMIO as config option
  KVM: s390: Prepare kvm-s390 for a second kvm module
  s390: Introduce Start Arm Execution instruction
  KVM: s390: arm64: Introduce host definitions
  KVM: s390: Add basic arm64 kvm module
  KVM: s390: arm64: Implement required functions
  KVM: s390: arm64: Implement vm/vcpu create destroy.
  KVM: s390: arm64: Implement vCPU IOCTLs
  KVM: s390: arm64: Implement basic page fault handler
  KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild

 MAINTAINERS                                   |    5 +
 Makefile                                      |    1 +
 arch/arm64/Makefile                           |    2 +
 arch/arm64/include/asm/Kbuild                 |    2 +-
 arch/arm64/include/asm/el2_setup.h            |    2 +-
 arch/arm64/include/asm/hardirq.h              |    2 +-
 arch/arm64/include/asm/kvm_emulate.h          |  245 +--
 arch/arm64/include/asm/kvm_host.h             |  200 +-
 arch/arm64/include/asm/kvm_mmu.h              |   41 +-
 arch/arm64/include/asm/ptrace.h               |   34 +-
 arch/arm64/include/asm/sysreg.h               |  967 +---------
 arch/arm64/include/uapi/asm/kvm.h             |   28 +-
 arch/arm64/include/uapi/asm/pstate.h          |   53 +
 arch/arm64/include/uapi/asm/ptrace.h          |   49 +-
 arch/arm64/include/uapi/asm/sve_context.h     |    4 +-
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
 arch/arm64/kvm/mmu.c                          |   21 +-
 arch/arm64/kvm/nested.c                       |    2 +-
 arch/arm64/kvm/reset.c                        |   34 +-
 arch/arm64/kvm/sys_regs.c                     |    2 +-
 arch/arm64/kvm/trace_arm.h                    |   25 -
 arch/arm64/kvm/vgic/vgic-its.c                |    2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c            |    2 +-
 arch/arm64/kvm/vgic/vgic-v3-nested.c          |    2 +-
 arch/arm64/tools/Makefile                     |   10 +-
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
 arch/s390/Makefile                            |    2 +
 arch/s390/boot/ipl_parm.c                     |    2 +-
 arch/s390/boot/uv.c                           |    2 +-
 arch/s390/configs/debug_defconfig             |    2 +-
 arch/s390/configs/defconfig                   |    3 +-
 arch/s390/include/asm/Kbuild                  |    3 +
 arch/s390/include/asm/asm-prototypes.h        |    1 +
 arch/s390/include/asm/elf.h                   |    2 +
 arch/s390/include/asm/kvm.h                   |    6 +
 arch/s390/include/asm/kvm_emulate.h           |  131 ++
 arch/s390/include/asm/kvm_host.h              |  749 +-------
 arch/s390/include/asm/kvm_host_arm64.h        |  212 +++
 arch/s390/include/asm/kvm_host_arm64_types.h  |  129 ++
 .../asm/{kvm_host.h => kvm_host_s390.h}       |   19 +-
 ...kvm_host_types.h => kvm_host_s390_types.h} |    0
 arch/s390/include/asm/kvm_mmu.h               |   12 +
 arch/s390/include/asm/kvm_nested.h            |   13 +
 arch/s390/include/asm/sae.h                   |   56 +
 arch/s390/include/asm/sclp.h                  |    5 +-
 arch/s390/include/asm/stacktrace.h            |    5 +
 arch/s390/kernel/asm-offsets.c                |    3 +-
 arch/s390/kernel/early.c                      |    2 +-
 arch/s390/kernel/entry.S                      |   35 +-
 arch/s390/kernel/perf_event.c                 |    2 +-
 arch/s390/kernel/processor.c                  |    3 +
 arch/s390/kvm/Kconfig                         |   36 +-
 arch/s390/kvm/Makefile                        |   12 +-
 arch/s390/kvm/arm64/Kconfig                   |   22 +
 arch/s390/kvm/arm64/Makefile                  |  108 ++
 arch/s390/kvm/arm64/arm.c                     |  708 +++++++
 arch/s390/kvm/arm64/arm.h                     |   61 +
 arch/s390/kvm/arm64/guest.c                   |  162 ++
 arch/s390/kvm/arm64/guest.h                   |   15 +
 arch/s390/kvm/arm64/handle_exit.c             |   52 +
 arch/s390/kvm/arm64/inject_fault.c            |   21 +
 arch/s390/kvm/arm64/mmu.c                     |  178 ++
 arch/s390/kvm/arm64/reset.c                   |   57 +
 arch/s390/kvm/arm64/reset.h                   |   11 +
 arch/s390/kvm/gmap/Makefile                   |    5 +
 arch/s390/kvm/{ => gmap}/dat.c                |    0
 arch/s390/kvm/{ => gmap}/dat.h                |    6 +-
 arch/s390/kvm/{ => gmap}/faultin.c            |   11 +-
 arch/s390/kvm/{ => gmap}/faultin.h            |    6 +-
 arch/s390/kvm/{ => gmap}/gmap.c               |   13 +-
 arch/s390/kvm/{ => gmap}/gmap.h               |   17 +-
 arch/s390/kvm/gmap/mmu.c                      |  147 ++
 arch/s390/kvm/gmap/trace-gmap.h               |   59 +
 arch/s390/kvm/{ => s390}/Kconfig              |   27 +-
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
 arch/s390/kvm/{kvm-s390.c => s390/s390.c}     |  118 +-
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
 .../arch/arm64}/asm/brk-imm.h                 |    6 +-
 .../include => include/arch/arm64}/asm/esr.h  |   62 +-
 include/arch/arm64/asm/pstate.h               |   46 +
 .../arch/arm64/asm/sysreg-defs.h              |  355 +---
 include/kvm/arm64/guest.h                     |   13 +
 include/kvm/arm64/handle_exit.h               |   14 +
 .../asm => include/kvm/arm64}/kvm_arm.h       |    5 +-
 include/kvm/arm64/kvm_emulate.h               |  268 +++
 include/kvm/arm64/kvm_host.h                  |  197 ++
 include/kvm/arm64/kvm_mmu.h                   |   47 +
 include/kvm/arm64/reset.h                     |    8 +
 include/linux/kvm_host.h                      |   17 +-
 include/linux/kvm_types.h                     |   30 +
 include/linux/vfio.h                          |    4 +-
 include/uapi/Kbuild                           |    4 +
 include/uapi/arch/arm64/asm/Kbuild            |    6 +
 include/uapi/arch/arm64/linux/kvm.h           |    8 +
 include/uapi/linux/{kvm.h => kvm-generic.h}   |   11 +-
 include/uapi/linux/kvm.h                      | 1660 +----------------
 scripts/Makefile.asm-headers                  |   13 +-
 usr/include/Makefile                          |    1 +
 virt/kvm/Kconfig                              |    3 -
 virt/kvm/Makefile.kvm                         |    3 +-
 virt/kvm/arm64/Makefile.kvm                   |   13 +
 virt/kvm/arm64/arm.c                          |   75 +
 virt/kvm/arm64/guest.c                        |  302 +++
 virt/kvm/arm64/handle_exit.c                  |   54 +
 {arch/arm64/kvm => virt/kvm/arm64}/mmio.c     |    1 +
 virt/kvm/arm64/reset.c                        |   43 +
 virt/kvm/arm64/trace.h                        |   42 +
 virt/kvm/coalesced_mmio.c                     |    3 +
 virt/kvm/coalesced_mmio.h                     |    2 +-
 virt/kvm/kvm_main.c                           |   63 +-
 virt/kvm/vfio.c                               |    4 +-
 161 files changed, 3925 insertions(+), 5139 deletions(-)
 create mode 100644 arch/arm64/include/uapi/asm/pstate.h
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
 rename arch/s390/kvm/{ => gmap}/gmap.h (95%)
 create mode 100644 arch/s390/kvm/gmap/mmu.c
 create mode 100644 arch/s390/kvm/gmap/trace-gmap.h
 copy arch/s390/kvm/{ => s390}/Kconfig (60%)
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
 rename {arch/arm64/include => include/arch/arm64}/asm/brk-imm.h (92%)
 rename {arch/arm64/include => include/arch/arm64}/asm/esr.h (88%)
 create mode 100644 include/arch/arm64/asm/pstate.h
 copy arch/arm64/include/asm/sysreg.h => include/arch/arm64/asm/sysreg-defs.h (79%)
 create mode 100644 include/kvm/arm64/guest.h
 create mode 100644 include/kvm/arm64/handle_exit.h
 rename {arch/arm64/include/asm => include/kvm/arm64}/kvm_arm.h (99%)
 create mode 100644 include/kvm/arm64/kvm_emulate.h
 create mode 100644 include/kvm/arm64/kvm_host.h
 create mode 100644 include/kvm/arm64/kvm_mmu.h
 create mode 100644 include/kvm/arm64/reset.h
 create mode 100644 include/uapi/arch/arm64/asm/Kbuild
 create mode 100644 include/uapi/arch/arm64/linux/kvm.h
 copy include/uapi/linux/{kvm.h => kvm-generic.h} (99%)
 create mode 100644 virt/kvm/arm64/Makefile.kvm
 create mode 100644 virt/kvm/arm64/arm.c
 create mode 100644 virt/kvm/arm64/guest.c
 create mode 100644 virt/kvm/arm64/handle_exit.c
 rename {arch/arm64/kvm => virt/kvm/arm64}/mmio.c (99%)
 create mode 100644 virt/kvm/arm64/reset.c
 create mode 100644 virt/kvm/arm64/trace.h


base-commit: 8fde5d1d47f69db6082dfa34500c27f8485389a5
-- 
2.53.0

