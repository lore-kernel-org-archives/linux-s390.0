Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131D429ACCD;
	Sun, 23 Aug 2026 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787504704; cv=none; b=GSxuAA8Xx07v83HpgoIoIx6DAHcmnYdpb6nysqf6jbSuwmOCCTjaHk2vSlxObCUoXOqIgc1PboK66yQbB4HAyvC2q+r68fYtt0868/lmBlAoq38+JpMhxrwjQJac1gTYMXVJM407mkZgTkmhxpUFZuSrUypGm6hyEBi+VJBt/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787504704; c=relaxed/simple;
	bh=cTGMnpEDoq0RyZ9S16vD3eN96lZjbIb2pBnzNgIzYvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LPRpIbZ54b2Y8pfJdWYnp44zR+pKLiHL907G7LKGt5jDzFnBBOieZPTBayV1wE5Ac2StQzpRb+3Iv9iV2t9Gcz5h30u0naAqvA2y7l1Jd7khX3YTPgFMbq4z32xUFzI0gWf44vgsCxMK4t3KwDmKkc8JyraUExuClzx9S+4yWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fH1aR+nh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fH1aR+nh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NGWT4f3641220;
	Sun, 23 Aug 2026 17:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=xecQvu7AdkBg5WQSdTpq9hz3KdiqVLOx+3HTpVCxaC0=; b=fH1aR+nh
	bL8pE05QI5Qp2MUNMEctu1FSfZd0sy/58iLxVgPTdEeCX7CWZPshu2f2ZKB+mhqJ
	SlMcHTqfMMKBURGim8RTATMa21Lfn47Q0IUNizO6z0rYv2YQ9vFNkIxndJbNWEZX
	lODPMnpRW7gpk/pgKNYCKAXM+44CF1FS7GiobxIzGg1w4OWWgXaaZWUZq/bJmGIe
	NodHMhiiCzSSouOeE1rfWxSvQvNvNoxwBWz9iQdnvQWHOjhnrZfQCo3OkiS9coAx
	HE8UiT73scJDTycagsDLzlTERKS/4SCggguLdvtndpZt+nF3OPaRSKkuk/scRkaY
	IujIt0zBZk8T3w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dww4xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 17:04:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67NGuILP017771;
	Sun, 23 Aug 2026 17:04:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxsu71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 17:04:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67NH4sKM41746780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Aug 2026 17:04:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16A3420043;
	Sun, 23 Aug 2026 17:04:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE03120040;
	Sun, 23 Aug 2026 17:04:53 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 23 Aug 2026 17:04:53 +0000 (GMT)
Date: Sun, 23 Aug 2026 19:04:52 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 7.3 merge window
Message-ID: <ttk8fg4@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDE1NCBTYWx0ZWRfX3vHcKbHkm87z
 8bl/POJgKuNrPbHbHDHt7uoEyi0ZGcAdJn75J1ykdcIMj0llR/HJq3sv5J7bQ0fEQucOPtVaDhW
 J7T0VdkcIZm7clyoCJf7qDrVLCr9ts0=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8b283a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=s8vRDx40V63_ihqGEbwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OTa2jAc8_j10II6jlN8GhpVn3j7piH1Q
X-Proofpoint-GUID: OTa2jAc8_j10II6jlN8GhpVn3j7piH1Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDE1NCBTYWx0ZWRfXxjc8o8FSidC4
 ChAVR6TvwXadp0zUIL5qBQQPTtn33mmIVjEM6dI+KDMR6MefVmjq4LHKnR1iw8UWOd1ufgYDify
 0JuCcLmPiQ80QsFxpss9TsexNrtQmnEdK8g7VRi/nkhB9UHRTv6rv+Fu5mrf++yN/QGI+dGRyEQ
 RD4Y1bnuv/1joUHYVzCbcAdNmgsobmvWJacRaLfCRXKNfXyYIgSsZJMnCfWwBtcm57nYWNriVo4
 3fuSBq0RGXio8mRc5bxJiDJn7w3ow9YCybPSbzyTY5uMSCYtg3QQggj4tO8JeKHwwdF+5n2S4rC
 fYdMYAJ9bdjCclgQU82hf2F46QETLiwGRNcH1jtQjDj+vvSvDTo2OzJMzm13Vb/mMDNymObYqTa
 putj43eFgo7viyilpMWepaM7tI7vYEloIM4JMOFaQeRnSBkJA+KZoxpXfs801DYON/qzGUH03AT
 rQ5hJdIbpx6gXAIh+xQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608230154

Hello Linus,

Please pull s390 changes for 7.3.

The s390 cpuidle driver series adds a new driver under drivers/cpuidle/
and the corresponding MAINTAINERS entry. The driver was reviewed by
Christian Loehle, and the whole series was acked by cpuidle maintainer
Rafael J. Wysocki:

https://lore.kernel.org/all/20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com/

The series also removes now unused generic arch_needs_cpu() hook:

 include/linux/tick.h                   |   3 -
 kernel/time/tick-sched.c               |   7 +-

which was reviewed by Thomas Gleixner:
https://lore.kernel.org/all/87v7br3fs7.ffs@fw13/

Thank you,
Vasily

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.3-1

for you to fetch changes up to 101782f8945a125044347312d74d488c05741c4a:

  s390/percpu: Fix MVIY_PERCPU() with older binutils (2026-08-13 16:56:45 +0200)

----------------------------------------------------------------
s390 updates for 7.3 merge window

- Add a cpuidle driver with polling and enabled wait states using the
  existing CPU idle infrastructure and idle governor to improve latency
  for frequent sleep/wakeup cycles. Remove the obsolete tick delay
  heuristic and generic arch_needs_cpu() hook. Add the corresponding
  driver entry to MAINTAINERS

- Add kCFI support using the generic support provided by Clang

- Enable Clang CONTEXT_ANALYSIS for various architecture code and for
  char, PCI, CIO and virtio drivers. Add required lock annotations,
  exclude unsupported mm helpers and remove conditional PCI locking

- Fix secure storage access exception handling and reintroduce
  DCACHE_WORD_ACCESS previously removed as a workaround

- Fix cpum_cf perf crashes when CPUs are brought online while per-task
  events are active. Allocate and remove per-CPU counter data from CPU
  hotplug callbacks

- Fix a deadlock when an s390dbf debug area is unregistered while one
  of its debugfs files is being written to

- Fix MVIY_PERCPU() with binutils older than 2.39, where an assembler
  macro silently omitted an instruction needed to repair interrupted
  operations after CPU migration

- Remove/replace cond_resched() calls which are no-ops with the supported
  s390 preemption models

- Fix AP queue depth and maximum message length decoding according to
  the architecture. Current hardware is not affected, but future hardware
  could report values which were handled incorrectly

- Reflect the configured CPU state in cpu_enabled_mask so deconfigured
  CPUs are not presented as available for onlining

- Restore the vDSO GNU_EH_FRAME program header which was lost when the
  build switched to direct linker invocation, and mark it read-only

- Add SCLP action qualifiers used by Spyre for card initialization,
  recoverable error and telemetry reporting

- Move KMSAN interrupt flag helpers out of line to fix
  -Wstatic-in-inline build warnings

- Use level-specific page table entry accessors for hugetlb entries and
  ptep_get() when accessing crashed kernel memory in kdump

- Make forced AP bus rescans killable so that a user process blocked
  behind an ongoing scan can still be terminated with SIGKILL

- Rework pkey ioctl error paths to remove duplicated cleanup code and
  avoid freeing error pointers

- Allow the protected guest SWIOTLB buffer to be allocated outside the
  first 2GB. Also enable dynamic SWIOTLB growth and the coherent atomic
  pool fallback to improve I/O behavior when the initial pool is exhausted

- Add program check statistics and spinlock contention tracepoints.
  Increase the lockdep chain capacity to keep lockdep enabled for complex
  code paths such as btrfs

- Simplify IPL, trap and syscall code and remove the obsolete unistd_32.h
  generation entry

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/maccess: Use proper PTE accessors for copying old memory

Christian Borntraeger (1):
      s390/configs: Increase CONFIG_LOCKDEP_CHAINS_BITS

Ciunas Bennett (1):
      s390/spinlock: Add contention tracepoints to lock slowpath

Finn Callies (2):
      s390/ap: Fix queue depth field length
      s390/ap: Fix MAPML computation

Gerald Schaefer (1):
      s390/mm: Use set_pmd() / set_pud() for hugetlb pagetable entries

Harald Freudenberger (2):
      s390/ap: Use mutex_lock_killable() in ap_bus_force_rescan()
      s390/pkey: Rework ioctl functions error paths

Heiko Carstens (29):
      KVM: s390: pv: Use VM_SPARSE area for guest variable storage area
      s390/mm: Add missing mm check to do_secure_storage_access()
      s390/mm: Use lock_mm_and_find_vma() in do_secure_storage_access()
      s390/mm: Fix handling of vmalloc area in do_secure_storage_access()
      s390/mm: Remove folio handling for kernel faults in do_secure_storage_access()
      s390/mm: Use handle_fault_error() in do_secure_storage_access()
      s390/mm: Use goto statement in do_secure_storage_access()
      s390: Add support for DCACHE_WORD_ACCESS (again)
      s390/tools: Pass symbol name to do_relocs()
      s390/tools/relocs: Ignore __kcfi_typeid_ relocations
      s390: Add ftrace_stub_graph
      s390/diag: Generate CFI type information for assembly functions
      s390/bpf: Add kCFI support
      s390/Kconfig: Select ARCH_SUPPORTS_CFI
      KVM: s390: Remove cond_resched() calls
      s390: Remove cond_resched() calls
      s390/cio: Remove cond_resched() calls
      s390/con3215: Add __must_hold() attribute to raw3215_make_room()
      s390/char: Enable CONTEXT_ANALYSIS
      s390/pci: Rework __zpci_event_error() to remove conditional locking
      s390/pci: Rework __zpci_event_availability() to remove conditional locking
      s390/pci: Enable CONTEXT_ANALYSIS
      s390/vfio_ccw: Add __must_hold() attribute to vfio_ccw_sch_quiesce()
      s390/cio: Enable CONTEXT_ANALYSIS
      s390/virtio: Enable CONTEXT_ANALYSIS
      s390/sysinfo: Add context analysis attributes
      s390/mm: Add __context_unsafe() attribute to do_secure_storage_access()
      s390/mm: Add __context_unsafe() attribute to gmap helper functions
      s390: Enable CONTEXT_ANALYSIS for various directories

Ilya Leoshkevich (1):
      s390/irqflags: Add out-of-line definitions of arch_local_irq_*() for KMSAN

Jaehoon Kim (2):
      s390/pv: Enable SWIOTLB_ANY for s390 PV
      s390: Select SWIOTLB_DYNAMIC and DMA_COHERENT_POOL

Jens Remus (2):
      s390/vdso: Pass --eh-frame-hdr to the linker
      s390/vdso: Use symbolic constants for the PHDR permission flags

Karl Mehltretter (1):
      s390/percpu: Fix MVIY_PERCPU() with older binutils

Mete Durlu (8):
      s390/tick: Remove CIF_NOHZ_DELAY flag
      tick: Remove arch_needs_cpu
      s390: Enable TIF_POLLING_NRFLAG
      s390/idle: Introduce cpuidle for s390
      s390/configs: Enable cpuidle driver on s390
      s390/ipl: Use ARRAY_SIZE macro
      s390/ipl: Improve readability
      s390/smp: Reflect (de)configured CPUs to cpu_enabled_mask

Niklas Schnelle (1):
      s390/sclp: Allow SCLP Action Qualifiers for Spyre card status reporting

Peter Oberparleiter (1):
      s390/debug: Fix deadlock during unregister

Peter Zijlstra (1):
      s390/crypto: Replace cond_resched() with msleep(1)

Sven Schnelle (3):
      s390/traps: Add exception statistics
      s390/traps: Remove PIF_GUEST_FAULT
      s390/syscalls: Use define instead of '1' to indicate PER trap

Thomas Huth (1):
      s390/uapi: Remove obsolete unistd_32.h from Kbuild file

Thomas Richter (1):
      s390/cpum_cf: Handle CPU hotplug via prepare/dead callbacks

 MAINTAINERS                            |   8 +
 arch/s390/Kconfig                      |  10 ++
 arch/s390/appldata/Makefile            |   2 +
 arch/s390/configs/debug_defconfig      |   4 +-
 arch/s390/configs/defconfig            |   2 +
 arch/s390/crypto/paes_s390.c           |  44 +----
 arch/s390/crypto/phmac_s390.c          |  25 +--
 arch/s390/hypfs/Makefile               |   2 +
 arch/s390/include/asm/ap.h             |   4 +-
 arch/s390/include/asm/asm-extable.h    |   4 +
 arch/s390/include/asm/cfi.h            |   7 +
 arch/s390/include/asm/hugetlb.h        |   4 +-
 arch/s390/include/asm/irqflags.h       |  20 ++-
 arch/s390/include/asm/percpu.h         |   4 +-
 arch/s390/include/asm/pkey.h           |  16 ++
 arch/s390/include/asm/processor.h      |   4 -
 arch/s390/include/asm/ptrace.h         |   4 +-
 arch/s390/include/asm/sclp.h           |   3 +
 arch/s390/include/asm/thread_info.h    |   1 +
 arch/s390/include/asm/uv.h             |  18 +-
 arch/s390/include/asm/word-at-a-time.h |  22 +++
 arch/s390/include/uapi/asm/Kbuild      |   1 -
 arch/s390/kernel/Makefile              |   3 +
 arch/s390/kernel/debug.c               |  10 +-
 arch/s390/kernel/entry.S               |   9 +-
 arch/s390/kernel/entry.h               |  10 +-
 arch/s390/kernel/idle.c                |   1 -
 arch/s390/kernel/ipl.c                 |  58 ++++---
 arch/s390/kernel/irq.c                 |   4 -
 arch/s390/kernel/irqflags.c            |  28 ++++
 arch/s390/kernel/mcount.S              |   9 +-
 arch/s390/kernel/perf_cpum_cf.c        | 222 ++++++++++++++++---------
 arch/s390/kernel/smp.c                 |   6 +-
 arch/s390/kernel/syscall.c             |   4 +-
 arch/s390/kernel/sysinfo.c             |   2 +
 arch/s390/kernel/text_amode31.S        |  13 +-
 arch/s390/kernel/traps.c               |  45 ++++-
 arch/s390/kernel/uv.c                  |  67 +++++++-
 arch/s390/kernel/vdso/Makefile         |   3 +-
 arch/s390/kernel/vdso/vdso.lds.S       |  11 +-
 arch/s390/kvm/gaccess.c                |   8 +-
 arch/s390/kvm/gmap.c                   |   4 -
 arch/s390/kvm/kvm-s390.c               |   1 -
 arch/s390/kvm/pv.c                     |  17 +-
 arch/s390/kvm/vsie.c                   |   1 -
 arch/s390/lib/Makefile                 |   2 +
 arch/s390/lib/spinlock.c               |   3 +
 arch/s390/mm/Makefile                  |   2 +
 arch/s390/mm/cmm.c                     |   2 -
 arch/s390/mm/extable.c                 |  18 ++
 arch/s390/mm/fault.c                   |  36 ++--
 arch/s390/mm/gmap_helpers.c            |   4 +-
 arch/s390/mm/hugetlbpage.c             |  10 +-
 arch/s390/mm/init.c                    |   2 +-
 arch/s390/mm/maccess.c                 |   2 +-
 arch/s390/mm/pageattr.c                |   5 -
 arch/s390/mm/pgalloc.c                 |   1 -
 arch/s390/net/Makefile                 |   3 +
 arch/s390/net/bpf_jit_comp.c           |  28 +++-
 arch/s390/pci/Makefile                 |   2 +
 arch/s390/pci/pci.c                    |   4 +-
 arch/s390/pci/pci_event.c              | 205 ++++++++++++-----------
 arch/s390/purgatory/Makefile           |   2 +
 arch/s390/tools/relocs.c               | 158 +++++++++++++++++-
 drivers/cpuidle/Kconfig                |   5 +
 drivers/cpuidle/Kconfig.s390           |  11 ++
 drivers/cpuidle/Makefile               |   4 +
 drivers/cpuidle/cpuidle-s390.c         | 115 +++++++++++++
 drivers/s390/char/Makefile             |   2 +
 drivers/s390/char/con3215.c            |   1 +
 drivers/s390/char/sclp_pci.c           |   3 +
 drivers/s390/char/uvdevice.c           |   6 +-
 drivers/s390/cio/Makefile              |   2 +
 drivers/s390/cio/css.c                 |   8 -
 drivers/s390/cio/vfio_ccw_drv.c        |   1 +
 drivers/s390/cio/vfio_ccw_private.h    |   3 +-
 drivers/s390/crypto/ap_bus.c           |   4 +-
 drivers/s390/crypto/ap_bus.h           |   2 +-
 drivers/s390/crypto/ap_card.c          |   2 +-
 drivers/s390/crypto/pkey_api.c         | 290 ++++++++++++++++++---------------
 drivers/s390/virtio/Makefile           |   2 +
 include/linux/tick.h                   |   3 -
 kernel/time/tick-sched.c               |   7 +-
 83 files changed, 1159 insertions(+), 546 deletions(-)
 create mode 100644 arch/s390/include/asm/cfi.h
 create mode 100644 arch/s390/kernel/irqflags.c
 create mode 100644 drivers/cpuidle/Kconfig.s390
 create mode 100644 drivers/cpuidle/cpuidle-s390.c
