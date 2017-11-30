Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 30 Nov 2017 10:04:14 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.15-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171130100414.1468cb65@mschwideX1>
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

* SPDX identifiers are added to more of the s390 specific files.

* The ELF_ET_DYN_BASE base patch from Kees is reverted, with the change
  some old 31-bit programs crash.

* Bug fixes and cleanups.

Christian Borntraeger (1):
      s390/debug: use pK for kernel pointers

Greg Kroah-Hartman (19):
      s390: block: add SPDX identifiers to the remaining files
      s390: crypto: add SPDX identifiers to the remaining files
      s390: cio: add SPDX identifiers to the remaining files
      s390: char: add SPDX identifiers to the remaining files
      s390: net: add SPDX identifiers to the remaining files
      s390: scsi: zfcp_aux: add SPDX identifier
      s390: virtio: add SPDX identifiers to the remaining files
      s390: crypto: Remove redundant license text
      s390: drivers: Remove redundant license text
      s390: kernel: add SPDX identifiers to the remaining files
      s390: crypto: add SPDX identifiers to the remaining files
      s390: mm: add SPDX identifiers to the remaining files
      s390: pci: add SPDX identifiers to the remaining files
      s390: appldata: add SPDX identifiers to the remaining files
      s390: add SPDX identifiers to the remaining files
      s390: kernel: Remove redundant license text
      s390: include: Remove redundant license text
      s390: crypto: Remove redundant license text
      s390: Remove redundant license text

Harald Freudenberger (1):
      s390/zcrypt: Fix wrong comparison leading to strange load balancing

Heiko Carstens (2):
      s390: rework __switch_to() to allow larger task_struct offsets
      s390/disassembler: remove confusing code

Martin Schwidefsky (4):
      s390: fix alloc_pgste check in init_new_context again
      s390: sthyi: add SPDX identifiers to the remaining files
      s390: revert ELF_ET_DYN_BASE base changes
      s390/gs: add compat regset for the guarded storage broadcast control block

Thomas Richter (1):
      s390/topology: fix compile error in file arch/s390/kernel/smp.c

Vasily Gorbik (1):
      s390/disassembler: correct disassembly lines alignment

 arch/s390/Makefile                      |  5 +----
 arch/s390/appldata/appldata_base.c      |  1 +
 arch/s390/appldata/appldata_mem.c       |  1 +
 arch/s390/appldata/appldata_net_sum.c   |  1 +
 arch/s390/appldata/appldata_os.c        |  1 +
 arch/s390/boot/install.sh               |  5 +----
 arch/s390/crypto/aes_s390.c             |  7 +------
 arch/s390/crypto/arch_random.c          |  6 +-----
 arch/s390/crypto/crc32-vx.c             |  1 +
 arch/s390/crypto/des_s390.c             |  7 +------
 arch/s390/crypto/ghash_s390.c           |  1 +
 arch/s390/crypto/paes_s390.c            |  6 +-----
 arch/s390/crypto/prng.c                 |  1 +
 arch/s390/crypto/sha.h                  |  7 +------
 arch/s390/crypto/sha256_s390.c          |  7 +------
 arch/s390/crypto/sha512_s390.c          |  7 +------
 arch/s390/crypto/sha_common.c           |  7 +------
 arch/s390/hypfs/inode.c                 |  2 +-
 arch/s390/include/asm/cpu_mf.h          |  5 +----
 arch/s390/include/asm/elf.h             | 15 ++++++++-------
 arch/s390/include/asm/kprobes.h         | 15 +--------------
 arch/s390/include/asm/kvm_host.h        |  5 +----
 arch/s390/include/asm/kvm_para.h        |  7 +------
 arch/s390/include/asm/livepatch.h       |  8 +-------
 arch/s390/include/asm/mmu_context.h     |  2 +-
 arch/s390/include/asm/syscall.h         |  5 +----
 arch/s390/include/asm/sysinfo.h         |  5 +----
 arch/s390/include/asm/topology.h        |  1 +
 arch/s390/include/uapi/asm/kvm.h        |  4 ----
 arch/s390/include/uapi/asm/kvm_para.h   |  4 ----
 arch/s390/include/uapi/asm/kvm_perf.h   |  4 ----
 arch/s390/include/uapi/asm/virtio-ccw.h |  4 ----
 arch/s390/include/uapi/asm/zcrypt.h     | 14 --------------
 arch/s390/kernel/debug.c                |  2 +-
 arch/s390/kernel/dis.c                  | 10 ++++++++--
 arch/s390/kernel/dumpstack.c            |  1 +
 arch/s390/kernel/entry.S                | 15 +++++++--------
 arch/s390/kernel/ipl.c                  |  1 +
 arch/s390/kernel/kprobes.c              | 15 +--------------
 arch/s390/kernel/lgr.c                  |  1 +
 arch/s390/kernel/module.c               | 15 +--------------
 arch/s390/kernel/nmi.c                  |  1 +
 arch/s390/kernel/perf_cpum_cf.c         |  5 +----
 arch/s390/kernel/perf_cpum_sf.c         |  5 +----
 arch/s390/kernel/perf_event.c           |  5 +----
 arch/s390/kernel/ptrace.c               |  8 ++++++++
 arch/s390/kernel/setup.c                |  1 +
 arch/s390/kernel/smp.c                  |  1 +
 arch/s390/kernel/stacktrace.c           |  1 +
 arch/s390/kernel/sthyi.c                |  5 +----
 arch/s390/kernel/time.c                 |  1 +
 arch/s390/kernel/topology.c             |  1 +
 arch/s390/kernel/vdso.c                 |  5 +----
 arch/s390/kernel/vdso32/clock_getres.S  |  5 +----
 arch/s390/kernel/vdso32/clock_gettime.S |  5 +----
 arch/s390/kernel/vdso32/gettimeofday.S  |  5 +----
 arch/s390/kernel/vdso64/clock_getres.S  |  5 +----
 arch/s390/kernel/vdso64/clock_gettime.S |  5 +----
 arch/s390/kernel/vdso64/gettimeofday.S  |  5 +----
 arch/s390/kernel/vtime.c                |  1 +
 arch/s390/mm/cmm.c                      |  1 +
 arch/s390/mm/gmap.c                     |  1 +
 arch/s390/mm/mmap.c                     | 16 +---------------
 arch/s390/mm/pgtable.c                  |  1 +
 arch/s390/pci/pci.c                     |  1 +
 arch/s390/pci/pci_debug.c               |  1 +
 arch/s390/pci/pci_dma.c                 |  1 +
 arch/s390/pci/pci_insn.c                |  1 +
 drivers/s390/block/dasd.c               |  1 +
 drivers/s390/block/dasd_devmap.c        |  1 +
 drivers/s390/block/dasd_diag.c          |  1 +
 drivers/s390/block/dasd_eckd.c          |  1 +
 drivers/s390/block/dasd_fba.c           |  1 +
 drivers/s390/block/dcssblk.c            |  1 +
 drivers/s390/block/scm_blk.c            |  1 +
 drivers/s390/block/xpram.c              |  1 +
 drivers/s390/char/fs3270.c              |  1 +
 drivers/s390/char/hmcdrv_mod.c          |  1 +
 drivers/s390/char/monreader.c           |  1 +
 drivers/s390/char/monwriter.c           |  1 +
 drivers/s390/char/raw3270.c             |  1 +
 drivers/s390/char/sclp_async.c          |  1 +
 drivers/s390/char/tape_34xx.c           |  1 +
 drivers/s390/char/tape_3590.c           |  1 +
 drivers/s390/char/tape_class.c          |  1 +
 drivers/s390/char/tape_core.c           |  1 +
 drivers/s390/char/tty3270.c             |  1 +
 drivers/s390/char/vmlogrdr.c            |  1 +
 drivers/s390/char/vmur.c                |  1 +
 drivers/s390/char/zcore.c               |  2 +-
 drivers/s390/cio/ccwgroup.c             |  1 +
 drivers/s390/cio/chp.c                  |  1 +
 drivers/s390/cio/chsc.c                 |  1 +
 drivers/s390/cio/chsc_sch.c             |  1 +
 drivers/s390/cio/cio.c                  |  1 +
 drivers/s390/cio/cmf.c                  | 15 +--------------
 drivers/s390/cio/css.c                  |  3 +--
 drivers/s390/cio/device.c               |  3 +--
 drivers/s390/cio/device_fsm.c           |  1 +
 drivers/s390/cio/device_ops.c           |  3 +--
 drivers/s390/cio/eadm_sch.c             |  1 +
 drivers/s390/cio/isc.c                  |  1 +
 drivers/s390/cio/qdio_main.c            |  1 +
 drivers/s390/cio/qdio_setup.c           |  1 +
 drivers/s390/cio/scm.c                  |  1 +
 drivers/s390/cio/vfio_ccw_drv.c         |  1 +
 drivers/s390/crypto/ap_bus.c            | 15 +--------------
 drivers/s390/crypto/ap_bus.h            | 15 +--------------
 drivers/s390/crypto/pkey_api.c          |  6 +-----
 drivers/s390/crypto/zcrypt_api.c        | 19 +++----------------
 drivers/s390/crypto/zcrypt_api.h        | 15 +--------------
 drivers/s390/crypto/zcrypt_card.c       | 11 +----------
 drivers/s390/crypto/zcrypt_cca_key.h    | 15 +--------------
 drivers/s390/crypto/zcrypt_cex2a.c      | 15 +--------------
 drivers/s390/crypto/zcrypt_cex2a.h      | 15 +--------------
 drivers/s390/crypto/zcrypt_cex4.c       |  1 +
 drivers/s390/crypto/zcrypt_error.h      | 15 +--------------
 drivers/s390/crypto/zcrypt_msgtype50.c  | 15 +--------------
 drivers/s390/crypto/zcrypt_msgtype50.h  | 15 +--------------
 drivers/s390/crypto/zcrypt_msgtype6.c   | 15 +--------------
 drivers/s390/crypto/zcrypt_msgtype6.h   | 15 +--------------
 drivers/s390/crypto/zcrypt_pcixcc.c     | 15 +--------------
 drivers/s390/crypto/zcrypt_pcixcc.h     | 15 +--------------
 drivers/s390/crypto/zcrypt_queue.c      | 11 +----------
 drivers/s390/net/ctcm_main.c            |  1 +
 drivers/s390/net/fsm.c                  |  1 +
 drivers/s390/net/lcs.c                  | 15 +--------------
 drivers/s390/net/netiucv.c              | 16 +---------------
 drivers/s390/net/qeth_core_main.c       |  1 +
 drivers/s390/net/qeth_core_sys.c        |  1 +
 drivers/s390/net/qeth_l2_main.c         |  1 +
 drivers/s390/net/qeth_l3_main.c         |  1 +
 drivers/s390/net/smsgiucv.c             | 15 +--------------
 drivers/s390/net/smsgiucv_app.c         |  1 +
 drivers/s390/scsi/zfcp_aux.c            |  1 +
 drivers/s390/virtio/Makefile            |  5 +----
 drivers/s390/virtio/virtio_ccw.c        |  5 +----
 137 files changed, 161 insertions(+), 529 deletions(-)
