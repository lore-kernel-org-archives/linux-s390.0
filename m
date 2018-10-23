Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 23 Oct 2018 09:01:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.20 merge window #1
Message-Id: <20181023090121.70cdbef2@mschwideX1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull s390 fixes and features for 4.20

The following changes since commit 55a5542a546238354d1f209f794414168cf8c71d:

  s390/hibernate: fix error handling when suspend cpu != resume cpu (2018-09-20 13:20:23 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-4.20-1

for you to fetch changes up to f822ad2c2c03af85a531c5174136b6d5b1abc566:

  s390/pkey: move pckmo subfunction available checks away from module init (2018-10-22 08:37:46 +0200)

----------------------------------------------------------------
s390 updates for the 4.20 merge window

 - Improved access control for the zcrypt driver, multiple device nodes
   can now be created with different access control lists

 - Extend the pkey API to provide random protected keys, this is useful
   for encrypted swap device with ephemeral protected keys

 - Add support for virtually mapped kernel stacks

 - Rework the early boot code, this moves the memory detection into the
   boot code that runs prior to decompression.

 - Add KASAN support

 - Bug fixes and cleanups

----------------------------------------------------------------
Chengguang Xu (1):
      s390/dasd: remove unnecessary condition check

Colin Ian King (1):
      s390/tape: fix spelling mistake "partion" -> "partition"

Halil Pasic (1):
      s390/zcrypt: enable AP bus scan without a valid default domain

Harald Freudenberger (6):
      s390/zcrypt: multiple zcrypt device nodes support
      s390/zcrypt: zcrypt device driver cleanup
      s390/zcrypt: provide apfs failure code on type 86 error reply
      s390/zcrypt: add ap_adapter_mask sysfs attribute
      s390/zcrypt: fix broken zcrypt_send_cprb in-kernel api function
      s390/pkey: move pckmo subfunction available checks away from module init

Heiko Carstens (2):
      s390/dumpstack: print psw mask and address again
      s390/mem_detect: add missing include

Ingo Franzki (8):
      s390/pkey: Introduce new API for random protected key generation
      s390/pkey: Define protected key blob format
      s390/pkey: Add sysfs attributes to emit protected key blobs
      s390/pkey: Add sysfs attributes to emit secure key blobs
      s390/pkey: Introduce new API for random protected key verification
      s390/pkey: Introduce new API for transforming key blobs
      s390/crypto: Enhance paes cipher to accept variable length key material
      s390/pkey: Load pkey kernel module automatically

Jan Höppner (1):
      s390/sclp: Allow to request adapter reset

Janosch Frank (1):
      s390/sthyi: Fix machine name validity indication

Julian Wiedmann (2):
      s390/qdio: clean up AOB handling
      s390/ccwgroup: add get_ccwgroupdev_by_busid()

Martin Schwidefsky (9):
      s390: add initial 64-bit restart PSW
      s390/appldata: pass parameter list pointer to appldata_asm
      s390/appldata: do not use stack buffers for hardware data
      s390/hypfs: do not use stack buffers for hardware data
      s390/monwriter: do not use stack buffers for hardware data
      s390/pfault: do not use stack buffers for hardware data
      init: add arch_call_rest_init to allow stack switching
      s390: add stack switch helper
      s390: add support for virtually mapped kernel stacks

Mikhail Zaslonko (1):
      s390/vmalloc: fix VMALLOC_START calculation

Thomas Richter (1):
      s390/perf: Return error when debug_register fails

Vasily Gorbik (47):
      s390/vdso: avoid 64-bit vdso mapping for compat tasks
      s390/vdso: correct CFI annotations of vDSO functions
      s390: clean up stacks setup
      s390: unify stack size definitions
      s390: remove decompressor's head.S
      s390/decompressor: rework uncompressed image info collection
      s390/decompressor: get rid of .bss usage
      s390/sclp: simplify early hsa_size detection
      s390: rescue initrd as early as possible
      s390/decompressor: clean up and rename compressed/misc.c
      s390: introduce .boot.data section
      s390/sclp: move sclp_early_read_info to sclp_early_core.c
      s390/mem_detect: move tprot loop to early boot phase
      s390: introduce .boot.data section compile time validation
      s390/mem_detect: introduce SCLP storage info
      s390/mem_detect: introduce z/VM specific diag260 call
      s390/mem_detect: use SCLP info for continuous memory detection
      s390/mem_detect: replace tprot loop with binary search
      s390/mem_detect: add info source debug print
      s390/sclp: introduce sclp_early_get_hsa_size
      s390: move ipl block and cmd line handling to early boot phase
      s390/mm: add missing pfn_to_kaddr helper
      s390/kasan: avoid vdso instrumentation
      s390/kasan: avoid instrumentation of early C code
      s390/kasan: replace some memory functions
      s390: introduce MAX_PTRS_PER_P4D
      s390: add pgd_page primitive
      s390/kasan: add initialization code and enable it
      s390/kasan: double the stack size
      s390/kasan: avoid user access code instrumentation
      s390/mm: add kasan shadow to the debugfs pgtable dump
      s390/kasan: dynamic shadow mem allocation for modules
      s390/kasan: use noexec and large pages
      compiler: introduce __no_sanitize_address_or_inline
      s390/smp: kasan stack instrumentation support
      s390/kasan: reipl and kexec support
      s390/dumpstack: disable __dump_trace kasan instrumentation
      s390/kasan: enable stack and global variables access checks
      s390/kasan: free early identity mapping structures
      s390/kasan: add option for 4-level paging support
      s390/mm: optimize debugfs ptdump kasan zero page walking
      s390/mm: improve debugfs ptdump markers walking
      s390/head: avoid doubling early boot stack size under KASAN
      s390/kasan: avoid kasan crash with standby memory defined
      s390/kasan: optimize kasan vmemmap allocation
      s390/kasan: add support for mem= kernel parameter
      s390/kasan: support preemptible kernel build

zhong jiang (2):
      s390/zcrypt: Use kmemdup to replace kmalloc + memcpy
      s390: vmlogrdr: Use ARRAY_SIZE instead of reimplementing its function

 arch/s390/Kconfig                                  |   9 +
 arch/s390/Makefile                                 |   2 +-
 arch/s390/appldata/appldata_base.c                 |  33 +-
 arch/s390/boot/.gitignore                          |   1 +
 arch/s390/boot/Makefile                            |  24 +-
 arch/s390/boot/boot.h                              |  11 +
 arch/s390/boot/cmdline.c                           |   2 +
 arch/s390/boot/compressed/Makefile                 |  37 +-
 arch/s390/boot/compressed/decompressor.c           |  85 +++
 arch/s390/boot/compressed/decompressor.h           |  25 +
 arch/s390/boot/compressed/head.S                   |  52 --
 arch/s390/boot/compressed/misc.c                   | 116 ----
 arch/s390/boot/compressed/vmlinux.lds.S            |  24 +-
 arch/s390/boot/compressed/vmlinux.scr.lds.S        |  15 -
 arch/s390/boot/ctype.c                             |   2 +
 arch/s390/boot/head.S                              |  12 +-
 arch/s390/boot/ipl_parm.c                          | 182 ++++++
 arch/s390/boot/ipl_vmparm.c                        |   2 +
 arch/s390/boot/mem_detect.c                        | 182 ++++++
 arch/s390/boot/startup.c                           |  64 +++
 arch/s390/boot/string.c                            | 138 +++++
 arch/s390/crypto/paes_s390.c                       |  63 ++-
 arch/s390/defconfig                                |   1 +
 arch/s390/hypfs/hypfs_sprp.c                       |  42 +-
 arch/s390/include/asm/appldata.h                   |  19 +-
 arch/s390/include/asm/boot_data.h                  |  11 +
 arch/s390/include/asm/ccwgroup.h                   |   2 +
 arch/s390/include/asm/facility.h                   |   9 +-
 arch/s390/include/asm/ipl.h                        |   4 +-
 arch/s390/include/asm/kasan.h                      |  30 +
 arch/s390/include/asm/lowcore.h                    |   4 +-
 arch/s390/include/asm/mem_detect.h                 |  82 +++
 arch/s390/include/asm/mmu.h                        |   2 +
 arch/s390/include/asm/mmu_context.h                |   1 +
 arch/s390/include/asm/page.h                       |   1 +
 arch/s390/include/asm/pgtable.h                    |  20 +-
 arch/s390/include/asm/pkey.h                       |  26 +
 arch/s390/include/asm/processor.h                  |  53 +-
 arch/s390/include/asm/qdio.h                       |   2 -
 arch/s390/include/asm/sclp.h                       |   5 +
 arch/s390/include/asm/sections.h                   |  12 +
 arch/s390/include/asm/setup.h                      |   3 +-
 arch/s390/include/asm/string.h                     |  21 +
 arch/s390/include/asm/thread_info.h                |  13 +-
 arch/s390/include/asm/vmlinux.lds.h                |  20 +
 arch/s390/include/uapi/asm/pkey.h                  |  34 ++
 arch/s390/include/uapi/asm/zcrypt.h                |  19 +-
 arch/s390/kernel/Makefile                          |   6 +-
 arch/s390/kernel/asm-offsets.c                     |   2 +-
 arch/s390/kernel/base.S                            |   2 +-
 arch/s390/kernel/dumpstack.c                       |  10 +-
 arch/s390/kernel/early.c                           |  47 +-
 arch/s390/kernel/early_nobss.c                     |  24 +-
 arch/s390/kernel/entry.S                           |  53 +-
 arch/s390/kernel/entry.h                           |   3 +
 arch/s390/kernel/head64.S                          |   6 +-
 arch/s390/kernel/ipl.c                             | 119 +---
 arch/s390/kernel/ipl_vmparm.c                      |  36 ++
 arch/s390/kernel/irq.c                             |  10 +-
 arch/s390/kernel/machine_kexec.c                   |  17 +-
 arch/s390/kernel/module.c                          |  15 +-
 arch/s390/kernel/perf_cpum_sf.c                    |   6 +-
 arch/s390/kernel/setup.c                           | 210 +++++--
 arch/s390/kernel/smp.c                             |  87 +--
 arch/s390/kernel/sthyi.c                           |   8 +-
 arch/s390/kernel/swsusp.S                          |  11 +-
 arch/s390/kernel/vdso.c                            |   8 +-
 arch/s390/kernel/vdso32/Makefile                   |   3 +-
 arch/s390/kernel/vdso32/clock_gettime.S            |  19 +-
 arch/s390/kernel/vdso32/gettimeofday.S             |   3 +-
 arch/s390/kernel/vdso64/Makefile                   |   3 +-
 arch/s390/kernel/vdso64/clock_gettime.S            |  25 +-
 arch/s390/kernel/vdso64/gettimeofday.S             |   3 +-
 arch/s390/kernel/vmlinux.lds.S                     |  16 +
 arch/s390/lib/Makefile                             |   4 +
 arch/s390/lib/mem.S                                |  12 +-
 arch/s390/mm/Makefile                              |   6 +-
 arch/s390/mm/dump_pagetables.c                     |  58 +-
 arch/s390/mm/fault.c                               |  38 +-
 arch/s390/mm/init.c                                |   5 +-
 arch/s390/mm/kasan_init.c                          | 387 +++++++++++++
 arch/s390/mm/maccess.c                             |  25 +-
 arch/s390/mm/mem_detect.c                          |  62 --
 arch/s390/purgatory/head.S                         |   4 +-
 drivers/crypto/Kconfig                             |  11 +
 drivers/s390/block/dasd.c                          |   6 +-
 drivers/s390/char/Makefile                         |   1 +
 drivers/s390/char/monwriter.c                      |  33 +-
 drivers/s390/char/sclp.h                           |  52 ++
 drivers/s390/char/sclp_cmd.c                       |  11 +-
 drivers/s390/char/sclp_early.c                     | 123 +---
 drivers/s390/char/sclp_early_core.c                | 116 ++++
 drivers/s390/char/sclp_pci.c                       |  10 +-
 drivers/s390/char/tape_3590.c                      |   2 +-
 drivers/s390/char/vmlogrdr.c                       |   2 +-
 drivers/s390/cio/ccwgroup.c                        |  30 +
 drivers/s390/cio/qdio_main.c                       |  15 +-
 drivers/s390/cio/qdio_setup.c                      |   1 -
 drivers/s390/crypto/Makefile                       |   2 +-
 drivers/s390/crypto/ap_bus.c                       |  79 ++-
 drivers/s390/crypto/ap_bus.h                       |  25 +
 drivers/s390/crypto/pkey_api.c                     | 521 ++++++++++++++++-
 drivers/s390/crypto/zcrypt_api.c                   | 627 +++++++++++++++++++--
 drivers/s390/crypto/zcrypt_api.h                   |  15 +-
 drivers/s390/crypto/zcrypt_card.c                  |   2 -
 drivers/s390/crypto/zcrypt_cca_key.h               |   2 -
 drivers/s390/crypto/zcrypt_cex2a.c                 |   6 +-
 drivers/s390/crypto/zcrypt_cex2a.h                 |   6 +-
 .../crypto/{zcrypt_pcixcc.c => zcrypt_cex2c.c}     | 125 ++--
 .../crypto/{zcrypt_pcixcc.h => zcrypt_cex2c.h}     |  14 +-
 drivers/s390/crypto/zcrypt_cex4.c                  |  20 +-
 drivers/s390/crypto/zcrypt_error.h                 |  24 +-
 drivers/s390/crypto/zcrypt_msgtype50.c             |  24 +-
 drivers/s390/crypto/zcrypt_msgtype50.h             |   2 -
 drivers/s390/crypto/zcrypt_msgtype6.c              |  74 +--
 drivers/s390/crypto/zcrypt_msgtype6.h              |  15 +-
 drivers/s390/crypto/zcrypt_queue.c                 |   2 -
 include/linux/compiler-gcc.h                       |   7 +
 include/linux/start_kernel.h                       |   2 +
 init/main.c                                        |   9 +-
 lib/Kconfig.kasan                                  |   9 +
 121 files changed, 3712 insertions(+), 1183 deletions(-)
 create mode 100644 arch/s390/boot/boot.h
 create mode 100644 arch/s390/boot/cmdline.c
 create mode 100644 arch/s390/boot/compressed/decompressor.c
 create mode 100644 arch/s390/boot/compressed/decompressor.h
 delete mode 100644 arch/s390/boot/compressed/head.S
 delete mode 100644 arch/s390/boot/compressed/misc.c
 delete mode 100644 arch/s390/boot/compressed/vmlinux.scr.lds.S
 create mode 100644 arch/s390/boot/ctype.c
 create mode 100644 arch/s390/boot/ipl_parm.c
 create mode 100644 arch/s390/boot/ipl_vmparm.c
 create mode 100644 arch/s390/boot/mem_detect.c
 create mode 100644 arch/s390/boot/startup.c
 create mode 100644 arch/s390/boot/string.c
 create mode 100644 arch/s390/include/asm/boot_data.h
 create mode 100644 arch/s390/include/asm/kasan.h
 create mode 100644 arch/s390/include/asm/mem_detect.h
 create mode 100644 arch/s390/include/asm/vmlinux.lds.h
 create mode 100644 arch/s390/kernel/ipl_vmparm.c
 create mode 100644 arch/s390/mm/kasan_init.c
 delete mode 100644 arch/s390/mm/mem_detect.c
 rename drivers/s390/crypto/{zcrypt_pcixcc.c => zcrypt_cex2c.c} (62%)
 rename drivers/s390/crypto/{zcrypt_pcixcc.h => zcrypt_cex2c.h} (63%)
