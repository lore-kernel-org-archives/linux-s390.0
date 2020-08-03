Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbgHCJdY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Aug 2020 05:33:24 -0400
Date: Mon, 3 Aug 2020 11:33:15 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.9 merge window
Message-ID: <20200803093315.GA4083@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hi Linus,

please pull s390 updates for the 5.9 merge window.

Thanks,
Heiko

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-1

for you to fetch changes up to 9a996c67a65d937b23408e56935ef23404c9418e:

  s390/vmemmap: coding style updates (2020-07-27 10:34:19 +0200)

----------------------------------------------------------------
- Add support for function error injection.

- Add support for custom exception handlers, as required by BPF_PROBE_MEM.

- Add support for BPF_PROBE_MEM.

- Add trace events for idle enter / exit for the s390 specific idle
  implementation.

- Remove unused zcore memmmap device.

- Remove unused "raw view" from s390 debug feature.

- AP bus + zcrypt device driver code refactoring.

- Provide cex4 cca sysfs attributes for cex3 for zcrypt device driver.

- Expose only minimal interface to walk physmem for mm/memblock. This
  is a common code change and it has been agreed on with Mike Rapoport
  and Andrew Morton that this can go upstream via the s390 tree.

- Rework of the s390 vmem/vmmemap code to allow for future memory hot
  remove.

- Get rid of FORCE_MAX_ZONEORDER to finally allow for order-10
  allocations again, instead of only order-8 allocations.

- Various small improvements and fixes.

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/zcore: remove memmap device

Christian Borntraeger (1):
      s390: fix comment regarding interrupts in svc

David Hildenbrand (13):
      s390/vmem: get rid of memory segment list
      s390/extmem: remove stale -ENOSPC comment and handling
      mm/memblock: expose only miminal interface to add/walk physmem
      s390/mm: don't set ARCH_KEEP_MEMBLOCK
      s390/vmem: rename vmem_add_mem() to vmem_add_range()
      s390/vmem: consolidate vmem_add_range() and vmem_remove_range()
      s390/vmemmap: extend modify_pagetable() to handle vmemmap
      s390/vmemmap: cleanup when vmemmap_populate() fails
      s390/vmemmap: take the vmem_mutex when populating/freeing
      s390/vmem: cleanup empty page tables
      s390/vmemmap: fallback to PTEs if mapping large PMD fails
      s390/vmemmap: remember unused sub-pmd ranges
      s390/vmemmap: avoid memset(PAGE_UNUSED) when adding consecutive sections

Gustavo A. R. Silva (1):
      s390/appldata: use struct_size() helper

Harald Freudenberger (7):
      s390/pkey: fix smatch warning inconsistent indenting
      s390/zcrypt: fix smatch warnings
      s390/zcrypt: code beautification and struct field renames
      s390/zcrypt: split ioctl function into smaller code units
      s390/ap: rename and clarify ap state machine related stuff
      s390/zcrypt: provide cex4 cca sysfs attributes for cex3
      s390/ap: rework crypto config info and default domain code

Heiko Carstens (11):
      s390/debug: remove raw view
      s390/debug: remove struct __debug_entry from uapi
      s390/smp: move smp_cpus_done() to header file
      s390/smp: add missing linebreak
      s390/mm: fix typo in comment
      s390/mm: avoid trimming to MAX_ORDER
      s390/mm: allow order 10 allocations
      s390/time: use CLOCKSOURCE_MASK
      s390/time: select CLOCKSOURCE_VALIDATE_LAST_CYCLE
      s390/time: improve comparison for tod steering
      s390/vmemmap: coding style updates

Ilya Leoshkevich (4):
      s390/kernel: unify EX_TABLE* implementations
      s390/kernel: expand exception table logic to allow new handling options
      s390/bpf: implement BPF_PROBE_MEM
      s390: enable HAVE_FUNCTION_ERROR_INJECTION

Julian Wiedmann (3):
      s390/qdio: fix statistics for 128 SBALs
      s390/qdio: allow to scan all 128 Input SBALs
      s390/qdio: remove internal polling in non-thinint path

Niklas Schnelle (1):
      s390/pci: clarify comment in s390_mmio_read/write

Oscar Carter (1):
      s390/tty3270: remove function callback casts

Sven Schnelle (5):
      s390: convert to msecs_to_jiffies()
      s390/pci: remove unused functions
      s390/time: remove unused function
      s390/stp: allow group and users to read stp sysfs files
      s390: add trace events for idle enter/exit

 Documentation/s390/s390dbf.rst          |  17 +-
 arch/s390/Kconfig                       |   7 +-
 arch/s390/appldata/appldata_os.c        |   6 +-
 arch/s390/include/asm/asm-const.h       |  12 +
 arch/s390/include/asm/debug.h           |  18 +-
 arch/s390/include/asm/extable.h         |  52 ++-
 arch/s390/include/asm/linkage.h         |  35 +-
 arch/s390/include/asm/pci_dma.h         |  11 -
 arch/s390/include/asm/pgtable.h         |   2 +-
 arch/s390/include/asm/ptrace.h          |   5 +
 arch/s390/include/asm/smp.h             |   4 +
 arch/s390/include/asm/syscall_wrapper.h |   6 +-
 arch/s390/include/asm/timex.h           |   5 -
 arch/s390/include/uapi/asm/debug.h      |  35 --
 arch/s390/include/uapi/asm/zcrypt.h     | 140 +++----
 arch/s390/kernel/crash_dump.c           |   6 +-
 arch/s390/kernel/debug.c                |  42 --
 arch/s390/kernel/entry.S                |   2 +-
 arch/s390/kernel/idle.c                 |   4 +-
 arch/s390/kernel/kprobes.c              |   4 +-
 arch/s390/kernel/lgr.c                  |   2 +-
 arch/s390/kernel/setup.c                |   8 -
 arch/s390/kernel/smp.c                  |   5 +-
 arch/s390/kernel/time.c                 |  55 ++-
 arch/s390/kernel/topology.c             |   4 +-
 arch/s390/kernel/traps.c                |   7 +-
 arch/s390/lib/Makefile                  |   2 +
 arch/s390/lib/error-inject.c            |  14 +
 arch/s390/mm/cmm.c                      |   2 +-
 arch/s390/mm/extmem.c                   |  32 +-
 arch/s390/mm/fault.c                    |   6 +-
 arch/s390/mm/vmem.c                     | 703 +++++++++++++++++++-------------
 arch/s390/net/bpf_jit_comp.c            | 139 ++++++-
 arch/s390/pci/pci_mmio.c                |  20 +-
 drivers/s390/char/tty3270.c             |  12 +-
 drivers/s390/char/zcore.c               |  57 +--
 drivers/s390/cio/qdio.h                 |   9 +-
 drivers/s390/cio/qdio_debug.c           |   2 +-
 drivers/s390/cio/qdio_main.c            |  41 +-
 drivers/s390/crypto/ap_bus.c            | 317 +++++++-------
 drivers/s390/crypto/ap_bus.h            |  69 ++--
 drivers/s390/crypto/ap_queue.c          | 209 +++++-----
 drivers/s390/crypto/pkey_api.c          |   4 +-
 drivers/s390/crypto/zcrypt_api.c        | 176 ++++----
 drivers/s390/crypto/zcrypt_ccamisc.c    |  69 ++--
 drivers/s390/crypto/zcrypt_cex2c.c      | 129 +++++-
 drivers/s390/crypto/zcrypt_cex4.c       |  30 +-
 drivers/s390/crypto/zcrypt_error.h      |   4 +-
 drivers/s390/crypto/zcrypt_msgtype50.c  |  64 ++-
 drivers/s390/crypto/zcrypt_msgtype6.c   | 112 +++--
 drivers/s390/crypto/zcrypt_msgtype6.h   |   4 +-
 drivers/s390/crypto/zcrypt_queue.c      |   8 +-
 include/linux/memblock.h                |  28 +-
 mm/memblock.c                           |  57 +--
 scripts/sorttable.c                     |  41 ++
 55 files changed, 1595 insertions(+), 1259 deletions(-)
 create mode 100644 arch/s390/include/asm/asm-const.h
 delete mode 100644 arch/s390/include/uapi/asm/debug.h
 create mode 100644 arch/s390/lib/error-inject.c
