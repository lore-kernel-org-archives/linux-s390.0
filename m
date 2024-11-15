Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C351D514B;
	Fri, 15 Nov 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684666; cv=none; b=KJ504uMhbmc18eHBB+wBuwYyjZSmpjPA5r38iNAfLkHVBM77JWfqQ/+vZT2sU8efcuMl+Awe8O71yv3YT5FRLoMJhNMX5PfXF48dMqMkfIU6Xwog0qKSx6Z0OOal6QPWRKSMk3QedW4O8M7GxN+ghVksLSmMFu5xoamhNIF6OIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684666; c=relaxed/simple;
	bh=KqH5A+tzjC6DsTYdijLkxjPp6kCFIZ6QODi7WrdPSDY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OrIeXGIYSeJy/M0SWAoMGlWsfvQPFOW88Slk67sfbmWfH/BFlyWg319OT0o40oMOgpEEzDEyuj7MvbaqGFRvLB18QnDBHuV4Tasl1IbEX78VdQy/VrFTCzn1f5PyH0NxscnAc8zjdGvasbfiPUf/6DboAhGBGS6iOijAdpo+jZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dI43WLmM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dI43WLmM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAYbVJ003587;
	Fri, 15 Nov 2024 15:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=Kpo0N3OnAMEtJdv6MGXgGRf78u7Ur4AYWZJcA/ivYNU=; b=dI43WLmM
	W57mD/LKRYf4iNJCkgfLKHgLvdmAVMz+oLQLEHJZAVMTDcDj68bq7j4bacT8VMEY
	p4NPbKd4MCDPoK66zFJbuhDy/BtOxLSiLpyyo/yq3B87yHRcLdFhIU5zoFtdHD19
	ikgqEVAOOEGl1z8sZn8x0lNOjzTG7xyh64h4HA8YS2/swceFlFBaZZWosVp5jFPM
	RHpzTdSV1Fcmn+D3h+Euh39UI+GtqS0jP84hq8+u64Y49s3VjitzZijNABgNGz2i
	Vpol0gLfSh/LjzUjAHesOS24IqHyQEiNc9weGJspp2JjAIKxbagjCO8vniJMnb+z
	TQvl2zT39DiFJw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuy1kwbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 15:31:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFFJIf7029724;
	Fri, 15 Nov 2024 15:31:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjmu1h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 15:31:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AFFUuHp57082158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 15:30:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57DE220043;
	Fri, 15 Nov 2024 15:30:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB00920040;
	Fri, 15 Nov 2024 15:30:55 +0000 (GMT)
Received: from osiris (unknown [9.171.66.118])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Nov 2024 15:30:55 +0000 (GMT)
Date: Fri, 15 Nov 2024 16:30:54 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.13 merge window
Message-ID: <20241115153054.27184-B-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _gqryx_O8byABLEqbYyJJdjDGLiu3xEz
X-Proofpoint-GUID: _gqryx_O8byABLEqbYyJJdjDGLiu3xEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxlogscore=981 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150128

Hi Linus,

please pull s390 updates for the 6.13 merge window.

Thanks,
Heiko

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.13-1

for you to fetch changes up to e200565d434b66e5b2bfc3b143b66b8ca29666ad:

  s390/cio/ioasm: Convert to use flag output macros (2024-11-13 14:31:34 +0100)

----------------------------------------------------------------
s390 updates for 6.13 merge window

- Add firmware sysfs interface which allows user space to retrieve the dump
  area size of the machine

- Add 'measurement_chars_full' CHPID sysfs attribute to make the complete
  associated Channel-Measurements Characteristics Block available

- Add virtio-mem support

- Move gmap aka KVM page fault handling from the main fault handler to KVM
  code. This is the first step to make s390 KVM page fault handling similar
  to other architectures. With this first step the main fault handler does
  not have any special handling anymore, and therefore convert it to
  support LOCK_MM_AND_FIND_VMA

- With gcc 14 s390 support for flag output operand support for inline
  assemblies was added. This allows for several optimizations

  - Provide a cmpxchg inline assembly which makes use of this, and provide
    all variants of arch_try_cmpxchg() so that the compiler can generate
    slightly better code

  - Convert a few cmpxchg() loops to try_cmpxchg() loops

  - Similar to x86 add a CC_OUT() helper macro (and other macros), and
    convert all inline assemblies to make use of them, so that depending on
    compiler version better code can be generated

- List installed host-key hashes in sysfs if the machine supports the Query
  Ultravisor Keys UVC

- Add 'Retrieve Secret' ioctl which allows user space in protected
  execution guests to retrieve previously stored secrets from the
  Ultravisor

- Add pkey-uv module which supports the conversion of Ultravisor
  retrievable secrets to protected keys

- Extend the existing paes cipher to exploit the full AES-XTS hardware
  acceleration introduced with message-security assist extension 10

- Convert hopefully all sysfs show functions to use sysfs_emit() so that
  the constant flow of such patches stop

- For PCI devices make use of the newly added Topology ID attribute to
  enable whole card multi-function support despite the change to PCHID per
  port. Additionally improve the overall robustness and usability of
  the multifunction support

- Various other small improvements, fixes, and cleanups

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/dump: Add firmware sysfs attribute for dump area size

Antonia Jonas (1):
      s390/cpum_cf: Correct typo CYLCE

Claudio Imbrenda (10):
      s390/entry: Remove __GMAP_ASCE and use _PIF_GUEST_FAULT again
      s390/kvm: Remove kvm_arch_fault_in_page()
      s390/mm/gmap: Refactor gmap_fault() and add support for pfault
      s390/mm/gmap: Fix __gmap_fault() return code
      s390/mm/fault: Handle guest-related program interrupts in KVM
      s390/kvm: Stop using gmap_{en,dis}able()
      s390/mm/gmap: Remove gmap_{en,dis}able()
      s390: Remove gmap pointer from lowcore
      s390/kvm: Initialize uninitialized flags variable
      s390/kvm: Mask extra bits from program interrupt code

David Hildenbrand (8):
      s390/kdump: Provide is_kdump_kernel() implementation
      Documentation: s390-diag.rst: Make diag500 a generic KVM hypercall
      Documentation: s390-diag.rst: Document diag500(STORAGE LIMIT) subfunction
      s390/physmem_info: Query diag500(STORAGE LIMIT) to support QEMU/KVM memory devices
      virtio-mem: s390 support
      lib/Kconfig.debug: Default STRICT_DEVMEM to "y" on s390
      s390/sparsemem: Reduce section size to 128 MiB
      s390/sparsemem: Provide memory_add_physaddr_to_nid() with CONFIG_NUMA

Gerd Bayer (2):
      s390/pci: Switch over to sysfs_emit
      s390/facilities: Fix warning about shadow of global variable

Halil Pasic (1):
      s390/virtio_ccw: Fix dma_parm pointer not set up

Harald Freudenberger (7):
      s390/zcrypt: Cleanup include zcrypt_api.h
      s390/pkey: Simplify protected key length calculation code
      s390/pkey: Rework pkey verify for protected keys
      s390/pkey: Fix checkpatch findings in pkey header file
      s390/pkey: Build module name array selectively based on kernel config options
      s390/pkey: Add new pkey handler module pkey-uv
      MAINTAINERS: Update and add s390 crypto related entries

Heiko Carstens (46):
      s390: Fix various typos
      s390/pageattr: Implement missing kernel_page_present()
      s390/mm: Simplify get_fault_type()
      s390/mm: Get rid of fault type switch statements
      s390/mm: Convert to LOCK_MM_AND_FIND_VMA
      s390/mm: Cleanup fault error handling
      Merge branch 'virtio-mem' into features
      s390/configs: Enable CONFIG_VIRTIO_MEM
      s390/sparsemem: Provide phys_to_target_node() with CONFIG_NUMA
      s390/uvdevice: Fix and slightly improve kernel-doc comment
      s390/con3270: Use NULL instead of 0 for pointers
      s390/cmpxchg: Convert one and two byte case inline assemblies to C
      s390/cmpxchg: Provide arch_try_cmpxchg()
      s390/cmpxchg: Implement arch_xchg() with arch_try_cmpxchg()
      s390/cmpxchg: Provide arch_cmpxchg128_local()
      s390/cmpxchg: Provide arch_try_cmpxchg128()
      s390/atomic: Convert arch_atomic_xchg() to C function
      s390/cmpxchg: Use arch_cmpxchg() instead of __atomic_cmpxchg()
      s390/atomic: Provide arch_atomic_try_cmpxchg()
      s390/preempt: Use arch_try_cmpxchg() instead of __atomic_cmpxchg()
      s390/locking: Use arch_try_cmpxchg() instead of __atomic_cmpxchg_bool()
      s390/atomic: Remove __atomic_cmpxchg() variants
      s390/perf_cpum_sf: Convert to use try_cmpxchg128()
      s390/perf_cpum_cf: Convert to use local64_try_cmpxchg()
      s390/asm: Helper macros for flag output operand handling
      s390/sthyi: Convert to use flag output macros
      s390/pageattr: Convert to use flag output macros
      s390/time: Convert to use flag output macros
      s390/topology: Convert to use flag output macros
      s390/cpcmd: Convert to use flag output macros
      s390/cpu_mf: Convert to use flag output macros
      s390/mm: Convert to use flag output macros
      s390/pai: Convert to use flag output macros
      s390/uv: Convert to use flag output macros
      s390/smp: Convert to use flag output macros
      s390/irq: Convert to use flag output macros
      s390/diag: Convert to use flag output macros
      s390/string: Convert to use flag output macros
      s390/extmem: Convert to use flag output macros
      s390/kvm: Convert to use flag output macros
      s390/pci: Convert to use flag output macros
      s390/boot/physmem: Convert to use flag output macros
      s390/dasd: Convert to use flag output macros
      s390/sclp: Convert to use flag output macros
      s390/cio/qdio: Convert to use flag output macros
      s390/cio/ioasm: Convert to use flag output macros

Holger Dengler (7):
      s390/pkey: Tolerate larger key blobs
      s390/crypto: Convert to reverse x-mas tree, rename ret to rc
      s390/crypto: Use module-local structures for protected keys
      s390/crypto: Generalize parameters for key conversion
      s390/crypto: Introduce function for tokenize clearkeys
      s390/crypto: Postpone the key split to key conversion
      s390/crypto: Add hardware acceleration for full AES-XTS mode

Julian Vetter (1):
      s390/pci: Align prototypes of zpci IO memcpy functions

Masahiro Yamada (3):
      s390/syscalls: Avoid creation of arch/arch/ directory
      s390/syscalls: Remove unnecessary argument of filechk_syshdr
      s390/syscalls: Convert filechk to if_changed

Mete Durlu (22):
      s390/topology: Switch over to sysfs_emit()
      s390/time: Switch over to sysfs_emit()
      s390/smp: Switch over to sysfs_emit()
      s390/perf_event: Switch over to sysfs_emit()
      s390/nospec: Switch over to sysfs_emit()
      s390/ipl: Switch over to sysfs_emit()
      s390/crypto: Switch over to sysfs_emit()
      scsi: zfcp: Switch over to sysfs_emit()
      s390/cio/chp: Switch over to sysfs_emit()
      s390/cio/device: Switch over to sysfs_emit()
      s390/cio/cmf: Switch over to sysfs_emit()
      s390/cio/ccwgroup: Switch over to sysfs_emit()
      s390/cio/css: Switch over to sysfs_emit()
      s390/cio/scm: Switch over to sysfs_emit()
      s390/dcssblk: Switch over to sysfs_emit()
      s390/tape: Switch over to sysfs_emit()
      s390/vmlogrdr: Switch over to sysfs_emit()
      s390/sclp_ocf: Switch over to sysfs_emit()
      s390/sclp_cpi: Switch over to sysfs_emit()
      s390/vmur: Switch over to sysfs_emit()
      s390/vfio-ap: Switch over to sysfs_emit()
      s390/netiucv: Switch over to sysfs_emit()

Niklas Schnelle (6):
      s390/pci: Sort PCI functions prior to creating virtual busses
      s390/pci: Use topology ID for multi-function devices
      s390/pci: Ignore RID for isolated VFs
      s390/sclp: Allow user-space to provide PCI reports for optical modules
      s390/pci: Expose FIDPARM attribute in sysfs
      s390/pci: Add header guards and includes to internal headers

Peter Oberparleiter (1):
      s390/cio: Externalize full CMG characteristics

Shen Lichuan (1):
      s390/cio: Correct some typos in comments

Steffen Eiden (8):
      s390/uv: Refactor uv-sysfs creation
      s390/uv: Provide host-key hashes in sysfs
      s390/uv: Use a constant for more-data rc
      s390/uv: Retrieve UV secrets support
      s390/uvdevice: Add Retrieve Secret IOCTL
      s390/uvdevice: Increase indent in IOCTL definitions
      s390/uv: Retrieve UV secrets sysfs support
      s390/uvdevice: Support longer secret lists

Thomas Richter (8):
      s390/cpum_sf: Set bit PMU_F_ENABLED enabled after lpp() invocation
      s390/cpum_sf: Do not re-enable event after deletion
      s390/cpum_sf: Consistently use goto out for function exit
      s390/cpum_sf: Use sf_buffer_available()
      s390/cpum_sf: Fix format string in pr_err()
      s390/cpum_sf: Handle CPU hotplug remove during sampling
      s390/cpum_sf: Rework call to sf_disable()
      s390/cpum_sf: Fix and protect memory allocation of SDBs with mutex

Vineeth Vijayan (1):
      s390/cio: Do not unregister the subchannel based on DNV

 Documentation/virt/kvm/s390/s390-diag.rst |  35 ++-
 MAINTAINERS                               |  26 +-
 arch/s390/Kconfig                         |   8 +
 arch/s390/boot/physmem_info.c             |  85 ++++--
 arch/s390/boot/startup.c                  |   9 +-
 arch/s390/boot/uv.c                       |   7 +-
 arch/s390/configs/debug_defconfig         |   2 +
 arch/s390/configs/defconfig               |   2 +
 arch/s390/crypto/paes_s390.c              | 415 +++++++++++++++++++++---------
 arch/s390/crypto/prng.c                   |  14 +-
 arch/s390/include/asm/asm.h               |  51 ++++
 arch/s390/include/asm/atomic.h            |  28 +-
 arch/s390/include/asm/atomic_ops.h        |  75 ------
 arch/s390/include/asm/cmpxchg.h           | 386 +++++++++++++++------------
 arch/s390/include/asm/cpacf.h             |   2 +
 arch/s390/include/asm/cpu_mf.h            |  57 ++--
 arch/s390/include/asm/facility.h          |  18 +-
 arch/s390/include/asm/gmap.h              |   3 -
 arch/s390/include/asm/kexec.h             |   3 +
 arch/s390/include/asm/kvm_host.h          |   5 +-
 arch/s390/include/asm/lowcore.h           |   3 +-
 arch/s390/include/asm/page.h              |  12 +-
 arch/s390/include/asm/pai.h               |  10 +-
 arch/s390/include/asm/pci.h               |  15 +-
 arch/s390/include/asm/pci_clp.h           |  13 +-
 arch/s390/include/asm/pci_io.h            |   6 +-
 arch/s390/include/asm/physmem_info.h      |   3 +
 arch/s390/include/asm/preempt.h           |   9 +-
 arch/s390/include/asm/processor.h         |   5 +-
 arch/s390/include/asm/ptrace.h            |   2 +
 arch/s390/include/asm/set_memory.h        |   1 +
 arch/s390/include/asm/sigp.h              |  11 +-
 arch/s390/include/asm/sparsemem.h         |  18 +-
 arch/s390/include/asm/spinlock.h          |  13 +-
 arch/s390/include/asm/timex.h             |  32 +--
 arch/s390/include/asm/uv.h                | 176 ++++++++++++-
 arch/s390/include/uapi/asm/dasd.h         |   2 +-
 arch/s390/include/uapi/asm/pkey.h         |  38 ++-
 arch/s390/include/uapi/asm/uvdevice.h     |  32 ++-
 arch/s390/kernel/asm-offsets.c            |   3 -
 arch/s390/kernel/cpcmd.c                  |  10 +-
 arch/s390/kernel/crash_dump.c             |  11 +
 arch/s390/kernel/debug.c                  |  18 +-
 arch/s390/kernel/diag.c                   |  12 +-
 arch/s390/kernel/entry.S                  |  44 +---
 arch/s390/kernel/ipl.c                    |  84 +++---
 arch/s390/kernel/irq.c                    |  11 +-
 arch/s390/kernel/nospec-sysfs.c           |  10 +-
 arch/s390/kernel/os_info.c                |   2 +-
 arch/s390/kernel/perf_cpum_cf.c           |  14 +-
 arch/s390/kernel/perf_cpum_sf.c           |  84 +++---
 arch/s390/kernel/perf_event.c             |   2 +-
 arch/s390/kernel/smp.c                    |  20 +-
 arch/s390/kernel/sthyi.c                  |  10 +-
 arch/s390/kernel/syscalls/Makefile        |  27 +-
 arch/s390/kernel/time.c                   |  30 +--
 arch/s390/kernel/topology.c               |  29 ++-
 arch/s390/kernel/traps.c                  |  24 +-
 arch/s390/kernel/uv.c                     | 256 +++++++++++++++++-
 arch/s390/kvm/intercept.c                 |   4 +-
 arch/s390/kvm/kvm-s390.c                  | 158 ++++++++----
 arch/s390/kvm/kvm-s390.h                  |   8 +-
 arch/s390/kvm/pci.c                       |   2 +-
 arch/s390/kvm/vsie.c                      |  19 +-
 arch/s390/lib/spinlock.c                  |  12 +-
 arch/s390/lib/string.c                    |  10 +-
 arch/s390/mm/extmem.c                     |  14 +-
 arch/s390/mm/fault.c                      | 207 +++------------
 arch/s390/mm/gmap.c                       | 167 +++++++-----
 arch/s390/mm/pageattr.c                   |  16 ++
 arch/s390/mm/pgtable.c                    |   2 +-
 arch/s390/pci/pci.c                       |  69 ++++-
 arch/s390/pci/pci_bus.c                   |  48 ++--
 arch/s390/pci/pci_bus.h                   |   5 +
 arch/s390/pci/pci_clp.c                   |  46 ++--
 arch/s390/pci/pci_event.c                 |  13 +-
 arch/s390/pci/pci_insn.c                  | 106 ++++----
 arch/s390/pci/pci_iov.h                   |   2 +
 arch/s390/pci/pci_mmio.c                  |  90 ++++---
 arch/s390/pci/pci_sysfs.c                 |   6 +-
 arch/s390/purgatory/head.S                |   2 +-
 drivers/crypto/Kconfig                    |  21 ++
 drivers/s390/block/dasd_diag.c            |  15 +-
 drivers/s390/block/dcssblk.c              |  18 +-
 drivers/s390/char/con3270.c               |   4 +-
 drivers/s390/char/sclp.h                  |  18 +-
 drivers/s390/char/sclp_cpi_sys.c          |   8 +-
 drivers/s390/char/sclp_ocf.c              |   4 +-
 drivers/s390/char/sclp_pci.c              |   2 +
 drivers/s390/char/tape_core.c             |  16 +-
 drivers/s390/char/uvdevice.c              | 153 ++++++++---
 drivers/s390/char/vmlogrdr.c              |   4 +-
 drivers/s390/char/vmur.c                  |   2 +-
 drivers/s390/cio/ccwgroup.c               |   2 +-
 drivers/s390/cio/chp.c                    |  31 ++-
 drivers/s390/cio/chp.h                    |   1 +
 drivers/s390/cio/chsc.c                   |  31 +--
 drivers/s390/cio/chsc.h                   |  16 ++
 drivers/s390/cio/cio.c                    |   6 +-
 drivers/s390/cio/cio.h                    |   2 +-
 drivers/s390/cio/cmf.c                    |  15 +-
 drivers/s390/cio/css.c                    |   6 +-
 drivers/s390/cio/device.c                 |  40 ++-
 drivers/s390/cio/ioasm.c                  | 107 ++++----
 drivers/s390/cio/qdio_main.c              |  28 +-
 drivers/s390/cio/scm.c                    |   2 +-
 drivers/s390/crypto/Makefile              |   4 +
 drivers/s390/crypto/pkey_base.c           |  14 +-
 drivers/s390/crypto/pkey_base.h           |  36 +++
 drivers/s390/crypto/pkey_cca.c            |   5 +-
 drivers/s390/crypto/pkey_ep11.c           |   1 -
 drivers/s390/crypto/pkey_pckmo.c          | 249 ++++++------------
 drivers/s390/crypto/pkey_sysfs.c          |   1 -
 drivers/s390/crypto/pkey_uv.c             | 284 ++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c         |  45 +---
 drivers/s390/crypto/zcrypt_ccamisc.h      |   1 +
 drivers/s390/net/netiucv.c                |  24 +-
 drivers/s390/scsi/zfcp_sysfs.c            |  82 +++---
 drivers/s390/virtio/virtio_ccw.c          |   4 +
 drivers/virtio/Kconfig                    |  12 +-
 lib/Kconfig.debug                         |   2 +-
 121 files changed, 2969 insertions(+), 1686 deletions(-)
 create mode 100644 arch/s390/include/asm/asm.h
 create mode 100644 drivers/s390/crypto/pkey_uv.c
