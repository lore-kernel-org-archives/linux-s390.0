Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 31 Aug 2015 15:43:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.3 merge window
Message-ID: <20150831154320.06ca3722@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

The big one is support for fake NUMA, splitting a really large machine
in more manageable piece improves performance in some cases, e.g. for
a KVM host.

The FICON Link Incident handling has been improved, this helps the
operator to identify degraded or non-operational FICON connections.

The save and restore of floating point and vector registers has been
overhauled to allow the future use of vector registers in the kernel.

A few small enhancement, magic sys-requests for the vt220 console via SCLP,
some more assembler code has been converted to C, the PCI error handling
is improved.

And the usual cleanup and bug fixing.

Alexander Kuleshov (1):
      s390/jump_label: Use %*ph to print small buffers

Christian Borntraeger (1):
      KVM: s390: use pid of cpu thread for sampling tagging

Gerald Schaefer (2):
      s390/mm: enable gup code for NUMA
      s390/mm: make arch_add_memory() NUMA aware

Guenter Roeck (1):
      s390/lib: export __delay

Heiko Carstens (9):
      s390/smp: add missing __init annotation to __smp_store_cpu_state()
      s390: remove generic email address from maintainers file
      s390/syscalls: ignore syscalls reachable via sys_socketcall
      s390/facilities: remove transactional-execution bits
      s390: remove unneeded sizeof(void *) comparisons
      s390/uaccess: remove uaccess_primary kernel parameter
      s390/hmcdrv: fix interrupt registration
      s390/zcrypt: use msleep() instead of mdelay()
      s390/nmi: initialize control register 0 earlier

Hendrik Brueckner (13):
      s390/kernel: move EX_TABLE macros to linkage.h header file
      s390/kernel: use test_fp_ctl() to verify the floating-point control word
      s390/kvm: validate the floating-point control before restoring it
      s390/kernel: introduce fpu-internal.h with fpu helper functions
      s390/kernel: dynamically allocate FP register save area
      s390/vx: add vector instruction support for older binutils versions
      s390/kernel: lazy restore fpu registers
      cpufeature: correctly annotate the module init function
      s390/module: enable generic CPU feature modalias using s390 ELF hwcaps
      s390/crypto: add cpu feature modaliases for crypto modules
      s390/kernel: remove save_fpu_regs() parameter and use __LC_CURRENT instead
      s390/ctrlchar: improve handling of magic sysrequests
      s390/sclp_vt220: support magic sysrequests

Martin Schwidefsky (12):
      s390/kvm: fix interrupt race with HANDLE_SIE_INTERCEPT
      s390/kvm: integrate HANDLE_SIE_INTERCEPT into cleanup_critical
      s390/kernel: squeeze a few more cycles out of the system call handler
      s390/nmi: use the normal asynchronous stack for machine checks
      s390/sclp: convert early sclp console code to C
      s390/mm: add NUMA balancing primitives
      s390/vtime: limit MT scaling value updates
      s390/vdso: emit a GNU hash
      s390/setup: fix novx parameter
      s390/mm: simplify page table alloc/free code
      s390/dcssblk: correct out of bounds array indexes
      s390/3270: redraw screen on unsolicited device end

Michael Holzheu (5):
      s390/numa: add emulation support
      s390/topology: remove topology lock
      s390/numa: make core to node mapping data dynamic
      s390/numa: re-add DIE sched_domain_topology_level
      s390/numa: remove superfluous ARCH_WANT defines

Peter Oberparleiter (3):
      s390/sclp: Change SCLP console default buffer-full behavior
      s390/cio: Fix comma
      s390/cio: Implement proper Link Incident Record handling

Peter Senna Tschudin (2):
      s390: remove unneeded semicolon
      s390: remove unneeded variables

Philipp Hachtmann (3):
      s390/numa: add core infrastructure
      s390/numa: add topology tree infrastructure
      s390/numa: enable support in s390 configs

Sebastian Ott (5):
      s390/pci: inline get_zdev
      s390/pci: free resources after failed bus allocation
      s390/pci: handle events for unused functions
      s390/pci: use pci_rescan_remove_lock
      s390/pci: move debug messages to debugfs

Stefan Haberland (2):
      s390/dasd: fix failing path verification
      s390/dasd: enhance CUIR scope detection

 MAINTAINERS                             |   6 -
 arch/s390/Kbuild                        |   1 +
 arch/s390/Kconfig                       |  75 ++++
 arch/s390/Makefile                      |   2 +
 arch/s390/configs/default_defconfig     |   2 +
 arch/s390/configs/gcov_defconfig        |   2 +
 arch/s390/configs/performance_defconfig |   3 +
 arch/s390/crypto/aes_s390.c             |   3 +-
 arch/s390/crypto/des_s390.c             |   3 +-
 arch/s390/crypto/ghash_s390.c           |   3 +-
 arch/s390/crypto/prng.c                 |   4 +-
 arch/s390/crypto/sha1_s390.c            |   3 +-
 arch/s390/crypto/sha256_s390.c          |   3 +-
 arch/s390/crypto/sha512_s390.c          |   3 +-
 arch/s390/include/asm/cpufeature.h      |  29 ++
 arch/s390/include/asm/ctl_reg.h         |   2 +
 arch/s390/include/asm/fpu-internal.h    | 110 ++++++
 arch/s390/include/asm/kvm_host.h        |   6 +-
 arch/s390/include/asm/linkage.h         |  22 ++
 arch/s390/include/asm/mmzone.h          |  16 +
 arch/s390/include/asm/numa.h            |  35 ++
 arch/s390/include/asm/pci.h             |  22 +-
 arch/s390/include/asm/pgtable.h         |  13 +
 arch/s390/include/asm/processor.h       |  36 +-
 arch/s390/include/asm/sclp.h            |   2 +-
 arch/s390/include/asm/switch_to.h       | 135 +------
 arch/s390/include/asm/topology.h        |  39 ++
 arch/s390/include/asm/unistd.h          |  24 +-
 arch/s390/include/asm/vx-insn.h         | 480 +++++++++++++++++++++++++
 arch/s390/include/uapi/asm/unistd.h     |  10 +-
 arch/s390/kernel/Makefile               |  11 +
 arch/s390/kernel/asm-offsets.c          |   3 +
 arch/s390/kernel/compat_signal.c        |  48 +--
 arch/s390/kernel/entry.S                | 614 +++++++++++++++++++++++---------
 arch/s390/kernel/head.S                 |   5 +-
 arch/s390/kernel/jump_label.c           |   9 +-
 arch/s390/kernel/nmi.c                  |  11 +-
 arch/s390/kernel/perf_cpum_sf.c         |   9 +-
 arch/s390/kernel/process.c              |  52 ++-
 arch/s390/kernel/processor.c            |   9 +
 arch/s390/kernel/ptrace.c               | 174 ++++-----
 arch/s390/kernel/s390_ksyms.c           |   3 +
 arch/s390/kernel/sclp.S                 | 355 ------------------
 arch/s390/kernel/sclp.c                 | 160 +++++++++
 arch/s390/kernel/setup.c                |  19 +-
 arch/s390/kernel/signal.c               |  47 +--
 arch/s390/kernel/smp.c                  |   4 +-
 arch/s390/kernel/syscalls.S             |  10 +-
 arch/s390/kernel/topology.c             |  31 +-
 arch/s390/kernel/traps.c                |  34 +-
 arch/s390/kernel/vdso32/Makefile        |   2 +-
 arch/s390/kernel/vdso64/Makefile        |   2 +-
 arch/s390/kernel/vtime.c                |  12 +-
 arch/s390/kvm/kvm-s390.c                | 130 +++++--
 arch/s390/lib/delay.c                   |   1 +
 arch/s390/lib/uaccess.c                 |  15 +-
 arch/s390/mm/fault.c                    |   2 +-
 arch/s390/mm/gup.c                      |  10 +
 arch/s390/mm/init.c                     |  40 +--
 arch/s390/mm/pgtable.c                  | 225 +++++-------
 arch/s390/numa/Makefile                 |   3 +
 arch/s390/numa/mode_emu.c               | 530 +++++++++++++++++++++++++++
 arch/s390/numa/numa.c                   | 184 ++++++++++
 arch/s390/numa/numa_mode.h              |  24 ++
 arch/s390/numa/toptree.c                | 342 ++++++++++++++++++
 arch/s390/numa/toptree.h                |  60 ++++
 arch/s390/pci/pci.c                     |  34 +-
 arch/s390/pci/pci_dma.c                 |   8 +-
 arch/s390/pci/pci_event.c               |  12 +-
 arch/s390/pci/pci_insn.c                |  33 +-
 arch/s390/pci/pci_sysfs.c               |  17 +-
 drivers/s390/block/dasd_alias.c         |   6 +-
 drivers/s390/block/dasd_eckd.c          | 333 ++++++++++++-----
 drivers/s390/block/dasd_eckd.h          |  11 +-
 drivers/s390/block/dasd_int.h           |   1 +
 drivers/s390/block/dcssblk.c            |  14 +-
 drivers/s390/char/con3270.c             |   4 +
 drivers/s390/char/ctrlchar.c            |  16 +-
 drivers/s390/char/ctrlchar.h            |  12 +
 drivers/s390/char/diag_ftp.c            |   4 +-
 drivers/s390/char/monreader.c           |   2 +-
 drivers/s390/char/sclp.c                |   6 +-
 drivers/s390/char/sclp_cmd.c            |  18 +-
 drivers/s390/char/sclp_vt220.c          |  52 ++-
 drivers/s390/char/tty3270.c             |   4 +
 drivers/s390/cio/chsc.c                 | 165 ++++++---
 drivers/s390/cio/device_ops.c           |   2 +-
 drivers/s390/cio/eadm_sch.c             |   3 +-
 drivers/s390/crypto/ap_bus.c            |   2 +-
 drivers/s390/crypto/zcrypt_pcixcc.c     |   2 +-
 drivers/s390/net/qeth_l2_main.c         |   5 +-
 drivers/s390/net/qeth_l3_main.c         |   5 +-
 drivers/s390/scsi/zfcp_fsf.c            |   2 +-
 include/linux/cpufeature.h              |   7 +-
 94 files changed, 3696 insertions(+), 1368 deletions(-)
 create mode 100644 arch/s390/include/asm/cpufeature.h
 create mode 100644 arch/s390/include/asm/fpu-internal.h
 create mode 100644 arch/s390/include/asm/mmzone.h
 create mode 100644 arch/s390/include/asm/numa.h
 create mode 100644 arch/s390/include/asm/vx-insn.h
 delete mode 100644 arch/s390/kernel/sclp.S
 create mode 100644 arch/s390/kernel/sclp.c
 create mode 100644 arch/s390/numa/Makefile
 create mode 100644 arch/s390/numa/mode_emu.c
 create mode 100644 arch/s390/numa/numa.c
 create mode 100644 arch/s390/numa/numa_mode.h
 create mode 100644 arch/s390/numa/toptree.c
 create mode 100644 arch/s390/numa/toptree.h

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
