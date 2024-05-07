Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED915DBC0;
	Tue,  7 May 2024 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075043; cv=none; b=UBKZiLt0sWiszE8BSfPoVOr6VTStYR1vpV/DSfGgVAIdMA4Xa4bhJSyjOB3Tubsc57AML0JeRl0PFOJh0XRW9w/3c6VB1yGY5SLU8mlI+RVLKipOuufY+smarjloPVONuPuiTQkGCnPmw4v5+wFmLKsyELlsi2de10dpt4Zkq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075043; c=relaxed/simple;
	bh=wwqp7UKe6JNlolY8AlRZg4ZSpLBJBi9HkqkgXMfQgqI=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=TsT5VDWUDD7y4rZR3Ek561CluCpmKRz5BZGCOasu8iPepY/t36tU0Ea8vx4jKYJOqDGas/p8ja1Uy1xPOx8hAlqR5hYGWh6upBLE4wOIpZyk+YlDs517lXJvAs/bq55/XrETnqROeZiW5Dhvk/it4UAbqR/RK9Vs/+vcUs9Pyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rc2GcalP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rc2GcalP"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4479GHtl030639;
	Tue, 7 May 2024 09:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=at9GNlVX/RQrW9IqThLSBUmcMFW8RXoMOi6y9g8gjr0=;
 b=rc2GcalP8MHNCKLJk17pzUVRg0YPdaYxejH9DMlM2jmA8QscpOFfU4rMoPcd5oE7s4SZ
 jkrLg6QWM+UuGVsgtwg1rkdkPO3JPAktbCCv+0MANR9SriF8f7JPGjhY+MO0tlxuSQxL
 xMeqXtl2TlOqZxs3sMygnfJ/jWGjhT/y6hu9mw8aHAbQ3P/fgXqiNkM6py/f2E1E9WSP
 Xe1FFAGhIZXRzPph3Gn41EDa1zHd0JKyqUgtBbTgUsk7FIu8yIu8HtELMWCSgt5bRDhD
 raEuoHL2eYCkZjXrq9zUNJnUy1/Qz16yLWFGJ75qaoVr9l/lVOVe0SEaYjaEk/YhhY1e mQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyh3e84wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 09:43:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4477PL5I013942;
	Tue, 7 May 2024 09:43:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xx222vxj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 09:43:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4479hqQW55640368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 May 2024 09:43:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB40E20043;
	Tue,  7 May 2024 09:43:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2DC520040;
	Tue,  7 May 2024 09:43:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 May 2024 09:43:52 +0000 (GMT)
Date: Tue, 7 May 2024 11:43:51 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.10 merge window
Message-ID: <Zjn312L7JK2rA8v/@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _dg9ygmX3kCG5Cebsgq0ReArQPjfQH6a
X-Proofpoint-ORIG-GUID: _dg9ygmX3kCG5Cebsgq0ReArQPjfQH6a
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_04,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070065

Hi Linus,

please pull s390 updates for the 6.10 merge window.

These KVM changes were agreed to be pulled via s390 tree with
Christian Borntraeger [1]:

- Add missing virt_to_phys() converter for VSIE facility and crypto
  control blocks

These MM changes were agreed to be pulled via s390 tree with
Andrew Morton [2]:

- userfaultfd can insert shared zeropages into processes running VMs,
  but that is not allowed for s390. Fallback to allocating a fresh
  zeroed anonymous folio and insert that instead

- Re-enable shared zeropages for non-PV and non-skeys KVM guests

I put these to and merged from a separate branch to keep valuable
information provided with the cover letter.

1. https://lore.kernel.org/all/2f046603-ae89-4ad2-95df-8e187501e06d@linux.ibm.com/
2. https://lore.kernel.org/all/20240321151353.68f9a3c9c0b261887e4e5411@linux-foundation.org/#t

Thanks,
Alexander

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.10-1

for you to fetch changes up to 1812dc9c334f98227c65bc9c475f16fb6840a94b:

  Revert "s390: Relocate vmlinux ELF data to virtual address space" (2024-05-05 12:51:44 +0200)

----------------------------------------------------------------
- Store AP Query Configuration Information in a static buffer

- Rework the AP initialization and add missing cleanups to the error path

- Swap IRQ and AP bus/device registration to avoid race conditions

- Export prot_virt_guest symbol

- Introduce AP configuration changes notifier interface to facilitate
  modularization of the AP bus

- Add CONFIG_AP kernel configuration option to allow modularization of
  the AP bus

- Rework CONFIG_ZCRYPT_DEBUG kernel configuration option description and
  dependency and rename it to CONFIG_AP_DEBUG

- Convert sprintf() and snprintf() to sysfs_emit() in CIO code

- Adjust indentation of RELOCS command build step

- Make crypto performance counters upward compatible

- Convert make_page_secure() and gmap_make_secure() to use folio

- Rework channel-utilization-block (CUB) handling in preparation of
  introducing additional CUBs

- Use attribute groups to simplify registration, removal and extension
  of measurement-related channel-path sysfs attributes

- Add a per-channel-path binary "ext_measurement" sysfs attribute that
  provides access to extended channel-path measurement data

- Export measurement data for all channel-measurement-groups (CMG), not
  only for a specific ones. This enables support of new CMG data formats
  in userspace without the need for kernel changes

- Add a per-channel-path sysfs attribute "speed_bps" that provides the
  operating speed in bits per second or 0 if the operating speed is not
  available

- The CIO tracepoint subchannel-type field "st" is incorrectly set to
  the value of subchannel-enabled SCHIB "ena" field. Fix that

- Do not forcefully limit vmemmap starting address to MAX_PHYSMEM_BITS

- Consider the maximum physical address available to a DCSS segment
  (512GB) when memory layout is set up

- Simplify the virtual memory layout setup by reducing the size of
  identity mapping vs vmemmap overlap

- Swap vmalloc and Lowcore/Real Memory Copy areas in virtual memory.
  This will allow to place the kernel image next to kernel modules

- Move everyting KASLR related from <asm/setup.h> to <asm/page.h>

- Put virtual memory layout information into a structure to improve
  code generation

- Currently __kaslr_offset is the kernel offset in both physical and
  virtual memory spaces. Uncouple these offsets to allow uncoupling
  of the addresses spaces

- Currently the identity mapping base address is implicit and is always
  set to zero. Make it explicit by putting into __identity_base persistent
  boot variable and use it in proper context

- Introduce .amode31 section start and end macros AMODE31_START and
  AMODE31_END

- Introduce OS_INFO entries that do not reference any data in memory,
  but rather provide only values

- Store virtual memory layout in OS_INFO. It is read out by makedumpfile,
  crash and other tools

- Store virtual memory layout in VMCORE_INFO. It is read out by crash and
  other tools when /proc/kcore device is used

- Create additional PT_LOAD ELF program header that covers kernel image
  only, so that vmcore tools could locate kernel text and data when virtual
  and physical memory spaces are uncoupled

- Uncouple physical and virtual address spaces

- Map kernel at fixed location when KASLR mode is disabled. The location is
  defined by CONFIG_KERNEL_IMAGE_BASE kernel configuration value.

- Rework deployment of kernel image for both compressed and uncompressed
  variants as defined by CONFIG_KERNEL_UNCOMPRESSED kernel configuration
  value

- Move .vmlinux.relocs section in front of the compressed kernel.
  The interim section rescue step is avoided as result

- Correct modules thunk offset calculation when branch target is more
  than 2GB away

- Kernel modules contain their own set of expoline thunks. Now that the
  kernel modules area is less than 4GB away from kernel expoline thunks,
  make modules use kernel expolines. Also make EXPOLINE_EXTERN the default
  if the compiler supports it

- userfaultfd can insert shared zeropages into processes running VMs,
  but that is not allowed for s390. Fallback to allocating a fresh
  zeroed anonymous folio and insert that instead

- Re-enable shared zeropages for non-PV and non-skeys KVM guests

- Rename hex2bitmap() to ap_hex2bitmap() and export it for external use

- Add ap_config sysfs attribute to provide the means for setting or
  displaying adapters, domains and control domains assigned to a vfio-ap
  mediated device in a single operation

- Make vfio_ap_mdev_link_queue() ignore duplicate link requests

- Add write support to ap_config sysfs attribute to allow atomic update
  a vfio-ap mediated device state

- Document ap_config sysfs attribute

- Function os_info_old_init() is expected to be called only from a regular
  kdump kernel. Enable it to be called from a stand-alone dump kernel

- Address gcc -Warray-bounds warning and fix array size in struct os_info

- s390 does not support SMBIOS, so drop unneeded CONFIG_DMI checks

- Use unwinder instead of __builtin_return_address() with ftrace to
  prevent returning of undefined values

- Sections .hash and .gnu.hash are only created when CONFIG_PIE_BUILD
  kernel is enabled. Drop these for the case CONFIG_PIE_BUILD is disabled

- Compile kernel with -fPIC and link with -no-pie to allow kpatch feature
  always succeed and drop the whole CONFIG_PIE_BUILD option-enabled code

- Add missing virt_to_phys() converter for VSIE facility and crypto
  control blocks

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/os_info: Initialize old os_info in standalone dump kernel

Alexander Gordeev (20):
      s390/boot: Do not force vmemmap to start at MAX_PHYSMEM_BITS
      s390/boot: Consider DCSS segments on memory layout setup
      s390/boot: Reduce size of identity mapping on overlap
      s390/boot: Swap vmalloc and Lowcore/Real Memory Copy areas
      s390/mm: Move KASLR related to <asm/page.h>
      s390/mm: Create virtual memory layout structure
      s390/boot: Uncouple virtual and physical kernel offsets
      s390/boot: Make identity mapping base address explicit
      s390/boot: Make .amode31 section address range explicit
      s390/os_info: Introduce value entries
      s390/os_info: Store virtual memory layout
      s390/vmcoreinfo: Store virtual memory layout
      s390/crash: Use old os_info to create PT_LOAD headers
      s390/mm: Uncouple physical vs virtual address spaces
      s390: Map kernel at fixed location when KASLR is disabled
      s390/boot: Rework deployment of the kernel image
      s390/boot: Do not rescue .vmlinux.relocs section
      s390: Relocate vmlinux ELF data to virtual address space
      Merge branch 'shared-zeropage' into features
      Revert "s390: Relocate vmlinux ELF data to virtual address space"

David Hildenbrand (2):
      mm/userfaultfd: Do not place zeropages when zeropages are disallowed
      s390/mm: Re-enable the shared zeropage for !PV and !skeys KVM guests

Heiko Carstens (1):
      s390: adjust indentation of RELOCS command build step out

Holger Dengler (7):
      s390/ap: use static qci information
      s390/ap: rework ap initialization
      s390/ap: swap IRQ and bus/device registration
      s390/uv: export prot_virt_guest symbol in uv
      s390/chsc: use notifier for AP configuration changes
      s390/ap: modularize ap bus
      s390/ap: rename ap debug configuration option

Jason J. Herne (5):
      s390/ap: Externalize AP bus specific bitmap reading function
      s390/vfio-ap: Add sysfs attr, ap_config, to export mdev state
      s390/vfio-ap: Ignore duplicate link requests in vfio_ap_mdev_link_queue
      s390/vfio-ap: Add write support to sysfs attr ap_config
      docs: Update s390 vfio-ap doc for ap_config sysfs attribute

Jean Delvare (1):
      s390/pci: Drop unneeded reference to CONFIG_DMI

Li Zhijian (1):
      s390/cio: convert sprintf()/snprintf() to sysfs_emit()

Matthew Wilcox (Oracle) (2):
      s390/mm: Convert make_page_secure to use a folio
      s390/mm: Convert gmap_make_secure to use a folio

Nina Schoetterl-Glausch (2):
      KVM: s390: vsie: Use virt_to_phys for facility control block
      KVM: s390: vsie: Use virt_to_phys for crypto control block

Peter Oberparleiter (6):
      s390/cio: rework channel-utilization-block handling
      s390/cio: simplify measurement attribute registration
      s390/cio: export extended channel-path-measurement data
      s390/cio: export measurement data for all CMGs
      s390/cio: export CHPID operating speed
      s390/cio: fix tracepoint subchannel type field

Sumanth Korikkar (2):
      s390: vmlinux.lds.S: Drop .hash and .gnu.hash for !CONFIG_PIE_BUILD
      s390: Compile kernel with -fPIC and link with -no-pie

Sven Schnelle (2):
      s390/os_info: Fix array size in struct os_info
      s390/ftrace: Use unwinder instead of __builtin_return_address()

Thomas Richter (1):
      s390/cpum_cf: make crypto counters upward compatible across machine types

Vasily Gorbik (2):
      s390/nospec: Correct modules thunk offset calculation
      s390/expoline: Make modules use kernel expolines

 Documentation/admin-guide/kernel-parameters.txt |   4 +-
 Documentation/arch/s390/index.rst               |   1 +
 Documentation/arch/s390/mm.rst                  | 111 ++++++++++
 Documentation/arch/s390/vfio-ap.rst             |  32 ++-
 arch/s390/Kconfig                               |  65 ++++--
 arch/s390/Makefile                              |  15 +-
 arch/s390/boot/Makefile                         |   9 +-
 arch/s390/boot/boot.h                           |  14 +-
 arch/s390/boot/decompressor.c                   |  15 +-
 arch/s390/boot/decompressor.h                   |   8 +-
 arch/s390/boot/kaslr.c                          |   2 +-
 arch/s390/boot/pgm_check_info.c                 |   4 +-
 arch/s390/boot/startup.c                        | 263 ++++++++++++------------
 arch/s390/boot/vmem.c                           | 108 +++++-----
 arch/s390/boot/vmlinux.lds.S                    |  28 +--
 arch/s390/include/asm/ap.h                      |  30 ++-
 arch/s390/include/asm/asm-prototypes.h          |   1 +
 arch/s390/include/asm/chsc.h                    |  15 ++
 arch/s390/include/asm/extmem.h                  |   7 +
 arch/s390/include/asm/ftrace.h                  |   8 +-
 arch/s390/include/asm/gmap.h                    |   2 +-
 arch/s390/include/asm/mmu.h                     |   5 +
 arch/s390/include/asm/mmu_context.h             |   1 +
 arch/s390/include/asm/nospec-branch.h           |  20 ++
 arch/s390/include/asm/nospec-insn.h             |  13 +-
 arch/s390/include/asm/os_info.h                 |  29 ++-
 arch/s390/include/asm/page.h                    |  50 ++++-
 arch/s390/include/asm/pgtable.h                 |  22 +-
 arch/s390/include/asm/physmem_info.h            |   4 +-
 arch/s390/include/asm/setup.h                   |  14 --
 arch/s390/kernel/Makefile                       |   2 +
 arch/s390/kernel/crash_dump.c                   |  41 +++-
 arch/s390/kernel/ipl.c                          |   6 +-
 arch/s390/kernel/nospec-branch.c                |   4 +-
 arch/s390/kernel/os_info.c                      |  29 ++-
 arch/s390/kernel/perf_cpum_cf.c                 |   2 +-
 arch/s390/kernel/perf_cpum_cf_events.c          |  11 +-
 arch/s390/kernel/setup.c                        |   6 +-
 arch/s390/kernel/stacktrace.c                   |  19 ++
 arch/s390/kernel/uv.c                           |  51 ++---
 arch/s390/kernel/vmcore_info.c                  |   2 +
 arch/s390/kernel/vmlinux.lds.S                  |  38 +---
 arch/s390/kvm/kvm-s390.c                        |   4 +-
 arch/s390/kvm/vsie.c                            |   5 +-
 arch/s390/lib/Makefile                          |   2 +-
 arch/s390/lib/{expoline => }/expoline.S         |   0
 arch/s390/lib/expoline/Makefile                 |   3 -
 arch/s390/mm/gmap.c                             | 165 +++++++++++----
 arch/s390/mm/vmem.c                             |   5 +-
 arch/s390/pci/pci_sysfs.c                       |   4 -
 arch/s390/tools/relocs.c                        |   2 +-
 drivers/crypto/Kconfig                          |  18 +-
 drivers/s390/char/Makefile                      |   2 +-
 drivers/s390/cio/chp.c                          | 141 +++++++------
 drivers/s390/cio/chp.h                          |   2 +
 drivers/s390/cio/chsc.c                         | 122 ++++++++---
 drivers/s390/cio/chsc.h                         |   5 +
 drivers/s390/cio/css.c                          |  14 +-
 drivers/s390/cio/css.h                          |  13 +-
 drivers/s390/cio/trace.h                        |   2 +-
 drivers/s390/crypto/Makefile                    |   2 +-
 drivers/s390/crypto/ap_bus.c                    | 238 ++++++++++++---------
 drivers/s390/crypto/ap_bus.h                    |  22 ++
 drivers/s390/crypto/ap_queue.c                  |   4 +-
 drivers/s390/crypto/vfio_ap_ops.c               | 224 ++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_private.h           |   6 +-
 mm/userfaultfd.c                                |  35 ++++
 scripts/mod/modpost.c                           |   5 -
 68 files changed, 1453 insertions(+), 703 deletions(-)
 create mode 100644 Documentation/arch/s390/mm.rst
 rename arch/s390/lib/{expoline => }/expoline.S (100%)
 delete mode 100644 arch/s390/lib/expoline/Makefile
