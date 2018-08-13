Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 13 Aug 2018 09:59:33 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 updates for 4.19
Message-Id: <20180813075933.GA3790@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Linus,

since Martin is on vacation you get the s390 pull request from me:

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

 - Host large page support for KVM guests. As the patches have large
   impact on arch/s390/mm/ this series goes out via both the KVM and
   the s390 tree.

 - Add an option for no compression to the "Kernel compression mode" menu,
   this will come in handy with the rework of the early boot code.

 - A large rework of the early boot code that will make life easier for
   KASAN and KASLR. With the rework the bootable uncompressed image is
   not generated anymore, only the bzImage is available. For debuggung
   purposes the new "no compression" option is used.

 - Re-enable the gcc plugins as the issue with the latent entropy plugin
   is solved with the early boot code rework.

 - More spectre relates changes:
   + Detect the etoken facility and remove expolines automatically.
   + Add expolines to a few more indirect branches.

 - A rewrite of the common I/O layer trace points to make them
   consumable by 'perf stat'.

 - Add support for format-3 PCI function measurement blocks.

 - Changes for the zcrypt driver:
   + Add attributes to indicate the load of cards and queues.
   + Restructure some code for the upcoming AP device support in KVM.

 - Build flags improvements in various Makefiles.

 - A few fixes for the kdump support.

 - A couple of patches for gcc 8 compile warning cleanup.

 - Cleanup s390 specific proc handlers.

 - Add s390 support to the restartable sequence self tests.

 - Some PTR_RET vs PTR_ERR_OR_ZERO cleanup.

 - Lots of bug fixes.

Shortlog:

Arnd Bergmann (1):
      s390: hypfs: use ktime_get_seconds() instead of get_seconds()

Claudio Imbrenda (1):
      s390/kvm: fix deadlock when killed by oom

Dominik Dingel (2):
      s390/mm: Clear huge page storage keys on enable_skey
      s390/mm: hugetlb pages within a gmap can not be freed

Dong Jia Shi (1):
      MAINTAINERS: Remove myself as maintainer

Gerald Schaefer (1):
      s390/mm: fix addressing exception after suspend/resume

Gustavo A. R. Silva (4):
      s390/ap_bus: replace PTR_RET with PTR_ERR_OR_ZERO
      s390/dasd: replace PTR_RET with PTR_ERR_OR_ZERO
      s390/hypfs: Replace PTR_RET with PTR_ERR_OR_ZERO
      s390/tape: replace PTR_RET with PTR_ERR_OR_ZERO

Harald Freudenberger (5):
      s390/zcrypt: Add ZAPQ inline function.
      s390/zcrypt: Review inline assembler constraints.
      s390/zcrypt: Show load of cards and queues in sysfs
      s390/zcrypt: Integrate ap_asm.h into include/asm/ap.h.
      s390/zcrypt: add copy_from_user length plausibility checks

Heiko Carstens (1):
      s390/sysinfo: add missing #ifdef CONFIG_PROC_FS

Hendrik Brueckner (1):
      s390/cpum_sf: save TOD clock base in SDBs for time conversion

Janosch Frank (11):
      s390/mm: Make gmap_protect_range more modular
      s390/mm: Abstract gmap notify bit setting
      s390/mm: Add gmap pmd linking
      s390/mm: Add gmap pmd notification bit setting
      s390/mm: Add gmap pmd invalidation and clearing
      s390/mm: Add huge page dirty sync support
      s390/mm: Clear skeys for newly mapped huge guest pmds
      s390/mm: Add huge pmd storage key handling
      KVM: s390: Add skey emulation fault handling
      s390/mm: Add huge page gmap linking support
      KVM: s390: Add huge page enablement control

Julian Wiedmann (1):
      s390/qdio: reset old sbal_state flags

Kees Cook (1):
      RAID/s390: Remove VLA usage

Martin Schwidefsky (9):
      Merge branch 'zcrypt' into features
      s390: detect etoken facility
      s390/keyboard: sanitize array index in do_kdsk_ioctl
      s390: disable gcc plugins
      s390: reenable gcc plugins
      Merge tag 'hlp_stage1' of git://git.kernel.org/.../kvms390/linux into features
      s390/numa: move initial setup of node_to_cpumask_map
      s390/lib: use expoline for all bcr instructions
      s390: fix br_r1_trampoline for machines without exrl

Philipp Rudo (4):
      s390/purgatory: Fix crash with expoline enabled
      s390/purgatory: Add missing FORCE to Makefile targets
      s390/purgatory: Remove duplicate variable definitions
      s390/kdump: Fix elfcorehdr size calculation

Sebastian Ott (7):
      s390/pci: add fmt3 fmb
      s390/dasd: fix cast-function-type warnings
      s390/cio: ensure that a chpid is registered only once
      s390/css: start the subchannel evaluation earlier
      s390/css: validate subchannel prior to allocation
      s390/css: reduce stsch calls
      s390/chsc: fix packed-not-aligned warnings

Souptick Joarder (1):
      s390: vdso_fault return type

Stefan Haberland (2):
      s390/dasd: fix panic for failed online processing
      s390/dasd: fix hanging offline processing due to canceled worker

Thomas Richter (6):
      s390 cio: Rewrite trace point in s390_cio_interrupt
      s390 cio: Rewrite trace point in s390_cio_tpi
      s390 cio: Rewrite trace point in s390_cio_stcrw
      s390 cio: Rewrite trace point in s390_cio_adapter_int
      s390 cio: Rewrite trace point in s390_cio_tsch
      s390 cio: Rewrite trace point class s390_class_schib

Vasily Gorbik (50):
      s390: disable asm code expolines if cc does not support it
      s390/build: remove obsolete -mkernel-backchain flag
      s390/decompressor: correct build flags
      s390: remove uncompressed kernel image build
      s390/decompressor: trim the kernel image up to 1M
      s390/boot: make head.S and als.c be part of the decompressor only
      s390/decompressor: rename entry point to startup_decompressor
      s390/als: avoid .init.* sections usage
      s390/decompressor: avoid reusing uncompressed image objects
      s390/decompressor: reuse lib/mem.S for mem functions
      s390/decompressor: avoid repeating objects list in Makefile
      s390: add custom target and make path extension optional for .bss check
      s390/decompressor: extend .bss check for early code
      s390/decompressor: allow preprocessor in piggy.o linker script
      s390/decompressor: allow to pack uncompressed vmlinux.bin into piggy.o
      init/Kconfig: add an option for uncompressed kernel
      s390/decompressor: support uncompressed kernel
      s390/setup: do not reserve the decompressor code
      s390/dasd: correct numa_node in dasd_alloc_queue
      s390/scm_blk: correct numa_node in scm_blk_dev_setup
      s390/extmem: fix gcc 8 stringop-overflow warning
      s390/dasd,zfcp: fix gcc 8 stringop-truncation warnings
      s390/dasd: fix gcc 8 stringop-truncation warning
      s390: fix gcc 8 stringop-truncation warnings in proc handlers
      s390/perf: fix gcc 8 array-bounds warning
      s390/decompressor: discard ___kcrctab section
      s390: put expoline execute-trampolines into .text section
      s390: remove unused _ehead symbol
      s390: get rid of the first mb of uncompressed image
      s390: correct _stext offset
      s390: move _text to an actual .text start
      s390/decompressor: correct EXCLUDE_FILE construct
      s390: align struct lowcore to double page size
      s390/tape: fix stringop-truncation gcc 8 warnings
      s390/tape: fix gcc 8 stringop-truncation warning
      s390/monwriter: fix gcc 8 stringop-truncation warning
      s390/boot: block uncompressed vmlinux booting attempts
      s390/tools: fix gcc 8 stringop-truncation warnings
      s390/decompressor: avoid constant startup.a rebuilds
      s390/decompressor: avoid packing *.o.chkbss files into startup.a
      s390/build: add *.o.chkbss files to targets list
      s390/decompressor: support extra debug flags
      s390/mm: correct allocate_pgste proc_handler callback
      s390/sclp_async: replace callhome proc handler with generic one
      s390/topology: correct topology mode proc handler
      s390/cmm: split and simplify cmm pages proc handler
      s390/appldata: reuse generic proc handler functions
      s390/crypto: fix gcc 8 stringop-truncation warning
      s390/cmm: avoid add_timer on concurrently used timer
      rseq/selftests: add s390 support

 Documentation/virtual/kvm/api.txt                  |  16 +
 MAINTAINERS                                        |   1 -
 arch/s390/Kconfig                                  |   1 +
 arch/s390/Makefile                                 |  42 +-
 arch/s390/appldata/appldata_base.c                 | 122 ++---
 arch/s390/boot/Makefile                            |  45 +-
 arch/s390/{kernel => boot}/als.c                   |  20 +-
 arch/s390/boot/compressed/.gitignore               |   1 +
 arch/s390/boot/compressed/Makefile                 |  55 +--
 arch/s390/boot/compressed/head.S                   |   8 +-
 arch/s390/boot/compressed/misc.c                   |  37 --
 arch/s390/boot/compressed/vmlinux.lds.S            |  15 +-
 .../compressed/{vmlinux.scr => vmlinux.scr.lds.S}  |   4 +
 arch/s390/boot/ebcdic.c                            |   2 +
 arch/s390/{kernel => boot}/head.S                  |  11 +-
 arch/s390/{kernel => boot}/head_kdump.S            |   0
 arch/s390/boot/mem.S                               |   2 +
 arch/s390/boot/sclp_early_core.c                   |   2 +
 arch/s390/hypfs/hypfs_diag.c                       |   4 +-
 arch/s390/hypfs/inode.c                            |   6 +-
 arch/s390/include/asm/ap.h                         | 284 ++++++++++--
 arch/s390/include/asm/cpu_mf.h                     |  12 +-
 arch/s390/include/asm/gmap.h                       |  10 +
 arch/s390/include/asm/hugetlb.h                    |   5 +-
 arch/s390/include/asm/lowcore.h                    |   2 +-
 arch/s390/include/asm/mmu.h                        |   2 +
 arch/s390/include/asm/mmu_context.h                |   1 +
 arch/s390/include/asm/nospec-insn.h                |   4 +-
 arch/s390/include/asm/pci.h                        |   5 +
 arch/s390/include/asm/pgtable.h                    |  13 +-
 arch/s390/include/asm/purgatory.h                  |   6 -
 arch/s390/include/asm/qdio.h                       |   1 -
 arch/s390/include/asm/sections.h                   |   2 -
 arch/s390/include/asm/setup.h                      |   4 +-
 arch/s390/include/uapi/asm/chsc.h                  |  10 +-
 arch/s390/kernel/Makefile                          |  24 +-
 arch/s390/kernel/crash_dump.c                      | 104 ++++-
 arch/s390/kernel/early.c                           |  12 +
 arch/s390/kernel/entry.h                           |   1 -
 arch/s390/kernel/head64.S                          |  43 +-
 arch/s390/kernel/nospec-branch.c                   |  12 +-
 arch/s390/kernel/nospec-sysfs.c                    |   2 +
 arch/s390/kernel/perf_cpum_sf.c                    |  14 +-
 arch/s390/kernel/perf_regs.c                       |   6 +-
 arch/s390/kernel/setup.c                           |   4 +-
 arch/s390/kernel/sysinfo.c                         |   4 +
 arch/s390/kernel/topology.c                        |  44 +-
 arch/s390/kernel/vdso.c                            |   2 +-
 arch/s390/kernel/vmlinux.lds.S                     |  13 +-
 arch/s390/kvm/kvm-s390.c                           |  82 +++-
 arch/s390/kvm/priv.c                               | 105 +++--
 arch/s390/lib/mem.S                                |  16 +-
 arch/s390/mm/cmm.c                                 |  74 ++-
 arch/s390/mm/extmem.c                              |   4 +-
 arch/s390/mm/fault.c                               |   2 +
 arch/s390/mm/gmap.c                                | 454 +++++++++++++++++-
 arch/s390/mm/hugetlbpage.c                         |  24 +
 arch/s390/mm/page-states.c                         |   2 +-
 arch/s390/mm/pageattr.c                            |   6 +-
 arch/s390/mm/pgalloc.c                             |   2 +-
 arch/s390/mm/pgtable.c                             | 159 +++++--
 arch/s390/net/bpf_jit_comp.c                       |   2 -
 arch/s390/numa/numa.c                              |  16 +-
 arch/s390/pci/pci_debug.c                          |   8 +
 arch/s390/purgatory/Makefile                       |   9 +-
 arch/s390/purgatory/head.S                         |  45 +-
 arch/s390/purgatory/purgatory.c                    |   9 -
 arch/s390/scripts/Makefile.chkbss                  |  11 +-
 arch/s390/tools/gen_opcode_table.c                 |   4 +-
 drivers/s390/block/dasd.c                          |  17 +-
 drivers/s390/block/dasd_alias.c                    |   2 +-
 drivers/s390/block/dasd_devmap.c                   |   2 +-
 drivers/s390/block/dasd_eckd.c                     |  12 +-
 drivers/s390/block/dasd_eer.c                      |   4 +-
 drivers/s390/block/scm_blk.c                       |   1 +
 drivers/s390/char/Makefile                         |   5 -
 drivers/s390/char/keyboard.c                       |  28 +-
 drivers/s390/char/monwriter.c                      |   2 +-
 drivers/s390/char/sclp_async.c                     |  38 +-
 drivers/s390/char/tape_3590.c                      |   8 +-
 drivers/s390/char/tape_class.c                     |   6 +-
 drivers/s390/cio/chp.c                             |  21 +-
 drivers/s390/cio/chsc.c                            |  18 +-
 drivers/s390/cio/chsc.h                            |  18 +-
 drivers/s390/cio/cio.c                             |  77 +---
 drivers/s390/cio/cio.h                             |   1 -
 drivers/s390/cio/css.c                             |  82 +++-
 drivers/s390/cio/css.h                             |   3 +-
 drivers/s390/cio/qdio_main.c                       |   5 +-
 drivers/s390/cio/trace.h                           | 102 +++-
 drivers/s390/crypto/ap_asm.h                       | 236 ----------
 drivers/s390/crypto/ap_bus.c                       |  25 +-
 drivers/s390/crypto/ap_bus.h                       |   1 +
 drivers/s390/crypto/ap_card.c                      |   1 -
 drivers/s390/crypto/ap_queue.c                     |  20 -
 drivers/s390/crypto/pkey_api.c                     |   2 +-
 drivers/s390/crypto/zcrypt_card.c                  |  12 +
 drivers/s390/crypto/zcrypt_cca_key.h               |  20 +-
 drivers/s390/crypto/zcrypt_msgtype6.c              |  20 +-
 drivers/s390/crypto/zcrypt_queue.c                 |  12 +
 drivers/s390/scsi/zfcp_aux.c                       |   2 +-
 include/uapi/linux/kvm.h                           |   1 +
 init/Kconfig                                       |  15 +-
 lib/raid6/s390vx.uc                                |  34 +-
 tools/testing/selftests/rseq/param_test.c          |  24 +
 tools/testing/selftests/rseq/rseq-s390.h           | 513 +++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h                |   2 +
 107 files changed, 2372 insertions(+), 1094 deletions(-)
 rename arch/s390/{kernel => boot}/als.c (83%)
 rename arch/s390/boot/compressed/{vmlinux.scr => vmlinux.scr.lds.S} (70%)
 create mode 100644 arch/s390/boot/ebcdic.c
 rename arch/s390/{kernel => boot}/head.S (98%)
 rename arch/s390/{kernel => boot}/head_kdump.S (100%)
 create mode 100644 arch/s390/boot/mem.S
 create mode 100644 arch/s390/boot/sclp_early_core.c
 delete mode 100644 drivers/s390/crypto/ap_asm.h
 create mode 100644 tools/testing/selftests/rseq/rseq-s390.h
