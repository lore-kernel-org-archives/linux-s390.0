Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 00/12] arch/s390/ license text cleanup
Date: Fri, 24 Nov 2017 15:00:31 +0100
Message-Id: <20171124140043.10062-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-ID: <linux-s390.vger.kernel.org>

Here are 12 patches against linux-next of today that add SPDX
identifiers to the remaining files in arch/s390 that do not currently
have them, and then it cleans up the various different ways that the
license text boilerplate was written for the GPLv2 in a few files.  This
cleanup was done in the quest to remove the 700+ different ways the
kernel describes GPLv2.

No copyright headers or any other non-license-description text was
removed in these patches.

FWIW, this license cleanup action has been "blessed" by IBM lawyers, but
feel free to check internally if you are curious.

Greg Kroah-Hartman (12):
  s390: kernel: add SPDX identifiers to the remaining files
  s390: kvm: add SPDX identifiers to the remaining files
  s390: crypto: add SPDX identifiers to the remaining files
  s390: mm: add SPDX identifiers to the remaining files
  s390: pci: add SPDX identifiers to the remaining files
  s390: appldata: add SPDX identifiers to the remaining files
  s390: add SPDX identifiers to the remaining files
  s390: kvm: Remove redundant license text
  s390: kernel: Remove redundant license text
  s390: include: Remove redundant license text
  s390: crypto: Remove redundant license text
  s390: Remove redundant license text

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
 arch/s390/include/asm/kprobes.h         | 15 +--------------
 arch/s390/include/asm/kvm_host.h        |  5 +----
 arch/s390/include/asm/kvm_para.h        |  7 +------
 arch/s390/include/asm/livepatch.h       |  8 +-------
 arch/s390/include/asm/syscall.h         |  5 +----
 arch/s390/include/asm/sysinfo.h         |  5 +----
 arch/s390/include/uapi/asm/kvm.h        |  4 ----
 arch/s390/include/uapi/asm/kvm_para.h   |  4 ----
 arch/s390/include/uapi/asm/kvm_perf.h   |  4 ----
 arch/s390/include/uapi/asm/virtio-ccw.h |  4 ----
 arch/s390/include/uapi/asm/zcrypt.h     | 14 --------------
 arch/s390/kernel/dis.c                  |  1 +
 arch/s390/kernel/dumpstack.c            |  1 +
 arch/s390/kernel/ipl.c                  |  1 +
 arch/s390/kernel/kprobes.c              | 15 +--------------
 arch/s390/kernel/lgr.c                  |  1 +
 arch/s390/kernel/module.c               | 15 +--------------
 arch/s390/kernel/nmi.c                  |  1 +
 arch/s390/kernel/perf_cpum_cf.c         |  5 +----
 arch/s390/kernel/perf_cpum_sf.c         |  5 +----
 arch/s390/kernel/perf_event.c           |  5 +----
 arch/s390/kernel/setup.c                |  1 +
 arch/s390/kernel/stacktrace.c           |  1 +
 arch/s390/kernel/sthyi.c                |  4 ----
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
 arch/s390/kvm/Makefile                  |  5 +----
 arch/s390/kvm/diag.c                    |  5 +----
 arch/s390/kvm/gaccess.h                 |  5 +----
 arch/s390/kvm/guestdbg.c                |  5 +----
 arch/s390/kvm/intercept.c               |  5 +----
 arch/s390/kvm/interrupt.c               |  5 +----
 arch/s390/kvm/irq.h                     |  5 +----
 arch/s390/kvm/kvm-s390.c                |  5 +----
 arch/s390/kvm/kvm-s390.h                |  5 +----
 arch/s390/kvm/priv.c                    |  5 +----
 arch/s390/kvm/sigp.c                    |  5 +----
 arch/s390/kvm/vsie.c                    |  5 +----
 arch/s390/mm/cmm.c                      |  1 +
 arch/s390/mm/gmap.c                     |  1 +
 arch/s390/mm/mmap.c                     | 16 +---------------
 arch/s390/mm/pgtable.c                  |  1 +
 arch/s390/pci/pci.c                     |  1 +
 arch/s390/pci/pci_debug.c               |  1 +
 arch/s390/pci/pci_dma.c                 |  1 +
 arch/s390/pci/pci_insn.c                |  1 +
 73 files changed, 67 insertions(+), 263 deletions(-)

-- 
2.15.0
