Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 4 Oct 2016 08:04:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.9 merge window #1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161004080430.625f8d24@mschwide>
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

The new features and main improvements in this merge for v4.9

 - Support for the UBSAN sanitizer

 - Set HAVE_EFFICIENT_UNALIGNED_ACCESS, it improves the code in some places

 - Improvements for the in-kernel fpu code, in particular the overhead
   for multiple consecutive in kernel fpu users is recuded

 - Add a SIMD implementation for the RAID6 gen and xor operations

 - Add RAID6 recovery based on the XC instruction

 - The PCI DMA flush logic has been improved to increase the speed
   of the map / unmap operations

 - The time synchronization code has seen some updates

And bug fixes all over the place.

Bhaktipriya Shridhar (1):
      s390: Remove deprecated create_singlethread_workqueue

Christian Borntraeger (3):
      s390: claim efficient unaligned access
      ubsan: allow to disable the null sanitizer
      s390: enable UBSAN

Colin Ian King (2):
      s390/crypto: avoid returning garbage value
      s390/dasd: add missing \n to end of dev_err messages

David Hildenbrand (4):
      s390/time: simplify stp time syncs
      s390/time: cleanup etr leftovers
      s390/time: fixup the clock comparator on all cpus
      s390/time: avoid races when updating tb_update_count

Dong Jia Shi (1):
      s390: cio: remove redundant cio_cancel declaration

Heiko Carstens (1):
      KVM: s390: generate facility mask from readable list

Markus Elfring (1):
      s390/tape: Use memdup_user() rather than duplicating its implementation

Martin Schwidefsky (16):
      s390/mm: no local TLB flush for clearing-by-ASCE IDTE
      s390/mm,kvm: flush gmap address space with IDTE
      s390/mm: merge local / non-local IPTE helper
      s390/mm: merge local / non-local IDTE helper
      s390/pci: add zpci_report_error interface
      s390/vx: allow to include vx-insn.h with .include
      s390/fpu: improve kernel_fpu_[begin|end]
      s390/nmi: improve revalidation of fpu / vector registers
      RAID/s390: add SIMD implementation for raid6 gen/xor
      s390/crypto: cleanup cpacf function codes
      s390/crypto: simplify return code handling
      s390/crypto: simplify init / exit functions
      s390/crypto: cpacf function detection
      s390/crypto: simplify CPACF encryption / decryption functions
      RAID/s390: provide raid6 recovery optimization
      s390: add assembler include path for vx-insn.h

Masahiro Yamada (1):
      s390/crashdump: use list_first_entry_or_null

Michael Holzheu (1):
      s390/config: Enable config options for Docker

Paul Gortmaker (1):
      s390: migrate exception table users off module.h and onto extable.h

Sascha Silbe (2):
      s390/con3270: fix use of uninitialised data
      s390/con3270: fix insufficient space padding

Sebastian Ott (9):
      s390/vmur: fix irq pointer dereference in int handler
      s390: export header for CLP ioctl
      iommu/s390: simplify registration of I/O address translation parameters
      s390/pci_dma: remove dma address range check
      s390/pci_dma: simplify dma address calculation
      s390/pci_dma: improve map_sg
      s390/pci_dma: split dma_update_trans
      s390/pci_dma: improve lazy flush for unmap
      s390/cio: fix accidental interrupt enabling during resume

Stefan Haberland (5):
      s390/dasd: add missing KOBJ_CHANGE event for unformatted devices
      s390/dasd: fix hanging offline processing
      s390/dasd: fix panic during offline processing
      s390/dasd: make query host access interruptible
      MAINTAINERS: update DASD maintainer

 MAINTAINERS                             |   4 +-
 arch/s390/Kconfig                       |   3 +
 arch/s390/Makefile                      |   2 +
 arch/s390/appldata/appldata_base.c      |   2 +-
 arch/s390/boot/compressed/Makefile      |   1 +
 arch/s390/configs/default_defconfig     |  11 +-
 arch/s390/configs/gcov_defconfig        |  13 +-
 arch/s390/configs/performance_defconfig |  13 +-
 arch/s390/crypto/aes_s390.c             | 590 ++++++++++++--------------------
 arch/s390/crypto/crc32-vx.c             |   2 +-
 arch/s390/crypto/des_s390.c             | 330 ++++++++----------
 arch/s390/crypto/ghash_s390.c           |  20 +-
 arch/s390/crypto/prng.c                 | 101 ++----
 arch/s390/crypto/sha1_s390.c            |   2 +-
 arch/s390/crypto/sha256_s390.c          |   2 +-
 arch/s390/crypto/sha512_s390.c          |   2 +-
 arch/s390/crypto/sha_common.c           |  23 +-
 arch/s390/include/asm/cpacf.h           | 178 +++++-----
 arch/s390/include/asm/facilities_src.h  |  24 ++
 arch/s390/include/asm/fpu/api.h         |  32 +-
 arch/s390/include/asm/lowcore.h         |   3 +-
 arch/s390/include/asm/mmu.h             |   1 +
 arch/s390/include/asm/mmu_context.h     |   1 +
 arch/s390/include/asm/pci.h             |   5 +
 arch/s390/include/asm/pgtable.h         |  74 ++--
 arch/s390/include/asm/tlbflush.h        |  72 ++--
 arch/s390/include/asm/vx-insn.h         | 148 ++++++--
 arch/s390/include/uapi/asm/Kbuild       |   1 +
 arch/s390/kernel/Makefile               |   3 +
 arch/s390/kernel/crash_dump.c           |   4 +-
 arch/s390/kernel/early.c                |   2 +-
 arch/s390/kernel/fpu.c                  | 317 +++++++----------
 arch/s390/kernel/kprobes.c              |   2 +
 arch/s390/kernel/nmi.c                  |  67 ++--
 arch/s390/kernel/sysinfo.c              |   2 +-
 arch/s390/kernel/time.c                 |  86 +----
 arch/s390/kernel/traps.c                |   3 +-
 arch/s390/kernel/vdso32/Makefile        |   3 +-
 arch/s390/kernel/vdso64/Makefile        |   3 +-
 arch/s390/kvm/kvm-s390.c                |  38 +-
 arch/s390/mm/fault.c                    |   2 +-
 arch/s390/mm/gmap.c                     |  15 +
 arch/s390/mm/pageattr.c                 |   4 +-
 arch/s390/mm/pgtable.c                  |  18 +-
 arch/s390/pci/pci.c                     |   9 +
 arch/s390/pci/pci_dma.c                 | 246 +++++++++----
 drivers/iommu/s390-iommu.c              |   3 +-
 drivers/s390/block/dasd.c               |  39 ++-
 drivers/s390/block/dasd_devmap.c        |   1 +
 drivers/s390/block/dasd_eckd.c          |   2 +-
 drivers/s390/block/dasd_erp.c           |   4 +-
 drivers/s390/block/dasd_int.h           |   1 +
 drivers/s390/char/con3270.c             |  11 +-
 drivers/s390/char/tape_3590.c           |  11 +-
 drivers/s390/char/vmur.c                |   9 +-
 drivers/s390/cio/chsc.c                 |  20 +-
 drivers/s390/cio/cio.h                  |   1 -
 drivers/s390/scsi/zfcp_aux.c            |   2 +-
 include/linux/raid/pq.h                 |   2 +
 lib/Kconfig.ubsan                       |  11 +
 lib/raid6/.gitignore                    |   1 +
 lib/raid6/Makefile                      |   6 +
 lib/raid6/algos.c                       |   6 +
 lib/raid6/recov_s390xc.c                | 116 +++++++
 lib/raid6/s390vx.uc                     | 168 +++++++++
 scripts/Makefile.ubsan                  |   5 +-
 66 files changed, 1535 insertions(+), 1368 deletions(-)
 create mode 100644 lib/raid6/recov_s390xc.c
 create mode 100644 lib/raid6/s390vx.uc
