Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 15 Mar 2016 11:13:23 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.6 merge window
Message-ID: <20160315111323.26598324@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

- Add the CPU id for the new z13s machine
- Add a s390 specific XOR template for RAID-5 checksumming based on the
  XC instruction. Remove all other alternatives, XC is always faster
- The merge of our four different stack tracers into a single one
- Tidy up the code related to page tables, several large inline functions
  are now out-of-line. Bloat-o-meter reports ~11K text size reduction
- A binary interface for the priviledged CLP instruction to retrieve
  the hardware view of the installed PCI functions
- Improvements for the dasd format code
- Bug fixes and cleanups

Adam Buchbinder (1):
      s390: Fix misspellings in comments

Christian Borntraeger (1):
      s390/cpumf: Improve guest detection heuristics

Heiko Carstens (11):
      s390/stacktrace: use nosched instead of savesched parameter
      s390: add current_stack_pointer() helper function
      s390/dumpstack: add missing ri bit to show_registers() output
      s390/dumpstack: use bit fields to decode psw mask in show_registers()
      s390/dumpstack: merge all four stack tracers
      s390: add z13s model number to z13 elf platform
      s390/oprofile: add z13/z13s model numbers
      s390/dis: use correct escape sequence for '%' character
      s390/fault: merge report_user_fault implementations
      s390/percpu: remove this_cpu_cmpxchg_double_4
      s390/cpumf: add missing lpp magic initialization

Jan Höppner (3):
      s390/dasd: Improve dasd format code
      s390/dasd: Simplify code in format logic
      s390/dasd: Refactor dasd format functions

Joe Perches (1):
      s390: Use pr_warn instead of pr_warning

Martin Schwidefsky (10):
      s390/xor: optimized xor routing using the XC instruction
      s390/pageattr: do a single TLB flush for change_page_attr
      s390/mm: remove unnecessary indirection with pgste_update_all
      s390/mm: correct comment about segment table entries
      s390/kvm: simplify set_guest_storage_key
      s390/pci: add ioctl interface for CLP
      s390/mm: uninline ptep_xxx functions from pgtable.h
      s390/mm: uninline pmdp_xxx functions from pgtable.h
      s390/mm: split arch/s390/mm/pgtable.c
      s390: fix floating pointer register corruption (again)

Sebastian Ott (3):
      s390/pci: remove pdev pointer from arch data
      s390/dasd: remove casts to dasd_*_private
      s390/pci: enforce fmb page boundary rule

Stefan Haberland (1):
      s390/dasd: fix incorrect locking order for LCU device add/remove

 arch/s390/Kconfig                  |    8 +-
 arch/s390/include/asm/clp.h        |   27 +
 arch/s390/include/asm/gmap.h       |   64 ++
 arch/s390/include/asm/pci.h        |    5 +-
 arch/s390/include/asm/pci_clp.h    |   30 +-
 arch/s390/include/asm/percpu.h     |    1 -
 arch/s390/include/asm/perf_event.h |    2 +-
 arch/s390/include/asm/pgalloc.h    |    4 -
 arch/s390/include/asm/pgtable.h    |  636 +++------------
 arch/s390/include/asm/processor.h  |   12 +
 arch/s390/include/asm/rwsem.h      |    2 +-
 arch/s390/include/asm/setup.h      |    2 +
 arch/s390/include/asm/xor.h        |   21 +-
 arch/s390/include/uapi/asm/clp.h   |   28 +
 arch/s390/kernel/asm-offsets.c     |    1 +
 arch/s390/kernel/cpcmd.c           |    3 +-
 arch/s390/kernel/debug.c           |    6 +-
 arch/s390/kernel/dis.c             |   17 +-
 arch/s390/kernel/dumpstack.c       |   93 ++-
 arch/s390/kernel/entry.S           |  107 +--
 arch/s390/kernel/irq.c             |    3 +-
 arch/s390/kernel/perf_cpum_cf.c    |    2 +-
 arch/s390/kernel/perf_cpum_sf.c    |    9 +-
 arch/s390/kernel/perf_event.c      |   58 +-
 arch/s390/kernel/setup.c           |    2 +
 arch/s390/kernel/stacktrace.c      |   93 +--
 arch/s390/kernel/time.c            |    6 +-
 arch/s390/kernel/traps.c           |   21 +-
 arch/s390/kvm/diag.c               |    1 +
 arch/s390/kvm/guestdbg.c           |    4 +-
 arch/s390/kvm/interrupt.c          |    1 +
 arch/s390/kvm/kvm-s390.c           |    3 +-
 arch/s390/kvm/priv.c               |    1 +
 arch/s390/lib/Makefile             |    2 +-
 arch/s390/lib/xor.c                |  134 ++++
 arch/s390/mm/Makefile              |    4 +-
 arch/s390/mm/extmem.c              |   16 +-
 arch/s390/mm/fault.c               |   16 +-
 arch/s390/mm/gmap.c                |  774 ++++++++++++++++++
 arch/s390/mm/hugetlbpage.c         |    7 +-
 arch/s390/mm/pageattr.c            |    8 +-
 arch/s390/mm/pgalloc.c             |  360 +++++++++
 arch/s390/mm/pgtable.c             | 1549 +++++++++---------------------------
 arch/s390/oprofile/Makefile        |    2 +-
 arch/s390/oprofile/backtrace.c     |   78 --
 arch/s390/oprofile/init.c          |   21 +-
 arch/s390/pci/pci.c                |   11 +-
 arch/s390/pci/pci_clp.c            |  247 +++++-
 arch/s390/pci/pci_debug.c          |    5 +-
 arch/s390/pci/pci_dma.c            |   21 +-
 arch/s390/pci/pci_event.c          |   13 +-
 drivers/pci/hotplug/s390_pci_hpc.c |    8 +-
 drivers/s390/block/dasd_alias.c    |  290 ++++---
 drivers/s390/block/dasd_devmap.c   |   10 +-
 drivers/s390/block/dasd_diag.c     |   69 +-
 drivers/s390/block/dasd_eckd.c     |  311 ++++----
 drivers/s390/block/dasd_fba.c      |   28 +-
 drivers/s390/block/dasd_genhd.c    |    4 +-
 drivers/s390/block/dasd_int.h      |    9 +-
 drivers/s390/block/dasd_ioctl.c    |   38 +-
 drivers/s390/block/dasd_proc.c     |    5 +-
 drivers/s390/block/dcssblk.c       |   13 +-
 drivers/s390/char/monreader.c      |   10 +-
 drivers/s390/char/sclp_cmd.c       |   27 +-
 drivers/s390/char/sclp_cpi_sys.c   |    6 +-
 drivers/s390/char/tape_core.c      |    4 +-
 drivers/s390/char/vmlogrdr.c       |    6 +-
 drivers/s390/cio/blacklist.c       |    9 +-
 drivers/s390/cio/ccwreq.c          |   13 +-
 drivers/s390/cio/cio.c             |    2 +-
 drivers/s390/cio/device.c          |   23 +-
 drivers/s390/net/lcs.c             |    4 +-
 drivers/s390/net/qeth_l3_main.c    |    2 +-
 73 files changed, 2800 insertions(+), 2632 deletions(-)
 create mode 100644 arch/s390/include/asm/gmap.h
 create mode 100644 arch/s390/include/uapi/asm/clp.h
 create mode 100644 arch/s390/lib/xor.c
 create mode 100644 arch/s390/mm/gmap.c
 create mode 100644 arch/s390/mm/pgalloc.c
 delete mode 100644 arch/s390/oprofile/backtrace.c
