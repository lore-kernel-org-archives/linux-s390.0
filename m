Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgDDNTL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 4 Apr 2020 09:19:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 034D495J089372
        for <linux-s390@vger.kernel.org>; Sat, 4 Apr 2020 09:19:11 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 306mjb6p08-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 04 Apr 2020 09:19:11 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 4 Apr 2020 14:18:49 +0100
Date: Sat, 4 Apr 2020 15:19:04 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.7 merge window
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01586006344-ext-2743@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.7. There are some common code changes to
remove s390 specific power management callbacks. Agreed by Rafael:
http://lkml.kernel.org/r/CAJZ5v0jiz-YmULR+T3k38=WYkx83F=JAmNpc3r7=+N398FQOkQ@mail.gmail.com

Thank you,
Vasily

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.7-1

for you to fetch changes up to 1058c163dc31b3335c9cf7c4fa42ccf87be73017:

  s390/mm: cleanup init_new_context() callback (2020-03-28 12:46:12 +0100)

----------------------------------------------------------------
s390 updates for the 5.7 merge window

- Update maintainers. Niklas Schnelle takes over zpci and Vineeth Vijayan
  common io code.

- Extend cpuinfo to include topology information.

- Add new extended counters for IBM z15 and sampling buffer allocation
  rework in perf code.

- Add control over zeroing out memory during system restart.

- CCA protected key block version 2 support and other fixes/improvements
  in crypto code.

- Convert to new fallthrough; annotations.

- Replace zero-length arrays with flexible-arrays.

- QDIO debugfs and other small improvements.

- Drop 2-level paging support optimization for compat tasks. Varios
  mm cleanups.

- Remove broken and unused hibernate / power management support.

- Remove fake numa support which does not bring any benefits.

- Exclude offline CPUs from CPU topology masks to be more consistent
  with other architectures.

- Prevent last branching instruction address leaking to userspace.

- Other small various fixes and improvements all over the code.

----------------------------------------------------------------
Alexander Gordeev (14):
      s390/mm: cleanup phys_to_pfn() and friends
      s390/cpuinfo: add system topology information
      s390/mm: optimize page table upgrade routine
      s390/cpuinfo: show processor physical address
      s390/numa: remove redundant cpus_with_topology variable
      s390/topology: remove offline CPUs from CPU topology masks
      s390/cpuinfo: show number of online cores
      s390/cpuinfo: show number of online CPUs within a package
      s390/cpuinfo: fix wrong output when CPU0 is offline
      s390/cpuinfo: do not skip info for CPUs without MHz feature
      s390/mm: cleanup arch_get_unmapped_area() and friends
      s390/mm: remove page table downgrade support
      s390/mm: cleanup virtual memory constants usage
      s390/mm: cleanup init_new_context() callback

Christian Borntraeger (2):
      s390/mm: mark private defines for vm_fault_t as such
      s390/config: do not select VIRTIO_CONSOLE via Kconfig

Gerald Schaefer (1):
      s390/ipl: add support to control memory clearing for FCP and CCW re-IPL

Gustavo A. R. Silva (1):
      s390: Replace zero-length array with flexible-array member

Harald Freudenberger (5):
      s390/zcrypt: Support for CCA protected key block version 2
      s390/zcrypt: replace snprintf/sprintf with scnprintf
      s390/ap: Remove ap device suspend and resume callbacks
      s390/zcrypt: use kvmalloc instead of kmalloc for 256k alloc
      s390/ap: remove power management code from ap bus and drivers

Heiko Carstens (6):
      s390/mm: remove fake numa support
      s390: enable bpf jit by default when not built as always-on
      s390/irq: make init_ext_interrupts static
      s390/traps: mark test_monitor_call __init
      s390: remove broken hibernate / power management support
      PM: remove s390 specific callbacks

Joe Perches (4):
      s390: use fallthrough;
      s390/zcrypt: use fallthrough;
      s390/vfio: use fallthrough;
      s390/cio: use fallthrough;

Julian Wiedmann (9):
      s390/qdio: clean up cdev access in qdio_setup_irq()
      s390/qdio: reduce access to cdev->private->qdio_data
      s390/qdio: use QDIO_IRQ_STATE_INACTIVE instead of 0
      s390/qdio: simplify debugfs code
      s390/qdio: export SSQD via debugfs
      s390/qdio: pass ISC as parameter to chsc_sadc()
      s390/ccwgroup: remove pm support
      s390/qdio: remove unused function declarations
      s390/qdio: set qdio_irq->cdev at allocation time

Michael Mueller (1):
      s390/diag: fix display of diagnose call statistics

Niklas Schnelle (2):
      s390/pci: Fix zpci_alloc_domain() over allocation
      s390/pci: Improve handling of unset UID

Peter Oberparleiter (2):
      MAINTAINERS: Update s390/cio maintainer
      MAINTAINERS: Update s390/pci maintainer

Pierre Morel (1):
      s390/pci: embedding hotplug_slot in zdev

Stefan Raspl (1):
      s390/arch: install kernels with their proper version ID

Sven Schnelle (1):
      s390: prevent leaking kernel address in BEAR

Takashi Iwai (1):
      s390/zcrypt: Use scnprintf() for avoiding potential buffer overflow

Thomas Richter (3):
      s390/cpum_sf: Rework sampling buffer allocation
      s390/cpum_cf: Add new extended counters for IBM z15
      s390/cpum_sf: Fix wrong page count in error message

Torsten Duwe (1):
      s390/crypto: explicitly memzero stack key material in aes_s390.c

Ursula Braun (1):
      s390/ism: remove pm support

afzal mohammed (1):
      s390/irq: replace setup_irq() by request_irq()

 MAINTAINERS                            |   4 +-
 arch/s390/Kconfig                      |  73 +----
 arch/s390/appldata/appldata_os.c       |   2 +-
 arch/s390/boot/install.sh              |  17 +-
 arch/s390/configs/debug_defconfig      |   1 +
 arch/s390/configs/defconfig            |   1 +
 arch/s390/crypto/aes_s390.c            |   3 +
 arch/s390/include/asm/hw_irq.h         |   1 -
 arch/s390/include/asm/ipl.h            |   1 +
 arch/s390/include/asm/lowcore.h        |   4 +-
 arch/s390/include/asm/mmu.h            |   2 -
 arch/s390/include/asm/mmu_context.h    |  44 +--
 arch/s390/include/asm/numa.h           |  13 +-
 arch/s390/include/asm/page.h           |  18 +-
 arch/s390/include/asm/pci.h            |   6 +
 arch/s390/include/asm/pgalloc.h        |  39 +--
 arch/s390/include/asm/processor.h      |  10 +-
 arch/s390/include/asm/setup.h          |   7 +
 arch/s390/include/asm/smp.h            |   1 +
 arch/s390/include/asm/topology.h       |  15 +-
 arch/s390/kernel/Makefile              |   1 -
 arch/s390/kernel/asm-offsets.c         |   2 +
 arch/s390/kernel/diag.c                |   2 +-
 arch/s390/kernel/entry.S               |  65 ++--
 arch/s390/kernel/ipl.c                 |  73 ++++-
 arch/s390/kernel/irq.c                 |  26 +-
 arch/s390/kernel/machine_kexec.c       |  31 --
 arch/s390/kernel/perf_cpum_cf_events.c | 123 ++++++-
 arch/s390/kernel/perf_cpum_sf.c        |  44 +--
 arch/s390/kernel/process.c             |   1 +
 arch/s390/kernel/processor.c           |  34 +-
 arch/s390/kernel/setup.c               |   4 +
 arch/s390/kernel/signal.c              |   4 +-
 arch/s390/kernel/smp.c                 |  13 +-
 arch/s390/kernel/suspend.c             | 240 --------------
 arch/s390/kernel/swsusp.S              | 276 ----------------
 arch/s390/kernel/topology.c            |  34 +-
 arch/s390/kernel/traps.c               |   2 +-
 arch/s390/mm/cmm.c                     |  46 +--
 arch/s390/mm/fault.c                   |  21 +-
 arch/s390/mm/hugetlbpage.c             |  11 +-
 arch/s390/mm/mmap.c                    |  40 +--
 arch/s390/mm/pageattr.c                |  16 -
 arch/s390/mm/pgalloc.c                 | 108 +++---
 arch/s390/mm/vmem.c                    |   4 +
 arch/s390/numa/Makefile                |   2 -
 arch/s390/numa/mode_emu.c              | 577 ---------------------------------
 arch/s390/numa/numa.c                  | 147 +--------
 arch/s390/numa/numa_mode.h             |  25 --
 arch/s390/numa/toptree.c               | 351 --------------------
 arch/s390/numa/toptree.h               |  61 ----
 arch/s390/pci/pci.c                    |  83 ++---
 arch/s390/pci/pci_clp.c                |   2 +-
 drivers/pci/hotplug/s390_pci_hpc.c     |  99 ++----
 drivers/s390/block/dasd_diag.c         |   2 +-
 drivers/s390/block/dasd_eckd.h         |   2 +-
 drivers/s390/char/con3215.c            |   2 +-
 drivers/s390/char/hmcdrv_ftp.c         |   2 +-
 drivers/s390/char/raw3270.h            |   2 +-
 drivers/s390/char/sclp_cmd.c           |   2 +-
 drivers/s390/char/sclp_pci.c           |   2 +-
 drivers/s390/char/sclp_sdias.c         |   2 +-
 drivers/s390/char/tape_core.c          |   6 +-
 drivers/s390/cio/airq.c                |   8 +-
 drivers/s390/cio/ccwgroup.c            |  69 ----
 drivers/s390/cio/chsc.c                |   5 +-
 drivers/s390/cio/chsc.h                |   3 +-
 drivers/s390/cio/cio.c                 |   8 +-
 drivers/s390/cio/device.c              |   4 +-
 drivers/s390/cio/idset.c               |   2 +-
 drivers/s390/cio/qdio.h                |   9 +-
 drivers/s390/cio/qdio_debug.c          |  59 ++--
 drivers/s390/cio/qdio_debug.h          |   3 +-
 drivers/s390/cio/qdio_main.c           |  23 +-
 drivers/s390/cio/qdio_setup.c          |  29 +-
 drivers/s390/cio/qdio_thinint.c        |   2 +-
 drivers/s390/crypto/ap_bus.c           | 212 +++---------
 drivers/s390/crypto/ap_bus.h           |   5 -
 drivers/s390/crypto/ap_card.c          |  17 +-
 drivers/s390/crypto/ap_queue.c         |  75 +----
 drivers/s390/crypto/pkey_api.c         |   2 +-
 drivers/s390/crypto/vfio_ap_ops.c      |   2 +-
 drivers/s390/crypto/zcrypt_card.c      |   6 +-
 drivers/s390/crypto/zcrypt_ccamisc.c   |  33 +-
 drivers/s390/crypto/zcrypt_ccamisc.h   |   2 +-
 drivers/s390/crypto/zcrypt_cex2a.c     |   2 -
 drivers/s390/crypto/zcrypt_cex2c.c     |   2 -
 drivers/s390/crypto/zcrypt_cex4.c      |  76 ++---
 drivers/s390/crypto/zcrypt_ep11misc.c  |  10 +-
 drivers/s390/crypto/zcrypt_msgtype6.c  |  10 +-
 drivers/s390/crypto/zcrypt_queue.c     |   4 +-
 drivers/s390/net/ism_drv.c             |  20 --
 include/linux/suspend.h                |  34 --
 kernel/power/Kconfig                   |   3 -
 kernel/power/snapshot.c                |  18 -
 95 files changed, 800 insertions(+), 2809 deletions(-)
 delete mode 100644 arch/s390/kernel/suspend.c
 delete mode 100644 arch/s390/kernel/swsusp.S
 delete mode 100644 arch/s390/numa/mode_emu.c
 delete mode 100644 arch/s390/numa/numa_mode.h
 delete mode 100644 arch/s390/numa/toptree.c
 delete mode 100644 arch/s390/numa/toptree.h
