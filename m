Return-Path: <linux-kernel-owner+w=401wt.eu-S1755838AbYJXKvy@vger.kernel.org>
Date: Fri, 24 Oct 2008 12:50:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 updates for 2.6.28-rc1
Message-ID: <20081024105049.GC4620@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lethal@linux-sh.org, paulus@samba.org, benh@kernel.crashing.org, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive s390 updates. Please note that this includes the new s390 vdso
support which Martin posted on linux-kernel and linux-arch.

I'm aware that I missed the merge window. This is because I would have
liked to see the kernel message catalogue go in first since the vdso code
did depend on the kmsg patches and would have generated a merge conflict.
But...
So since this is late feel free to ignore and we will have to wait for
the 2.6.29 merge window.

The s390 vdso preparation patch "arch_setup_additional_pages argument"
touches other architectures (x86, sh and powerpc):

arch_setup_additional_pages currently gets two arguments, the binary
format descripton and an indication if the process uses an executable
stack or not. The second argument is not used by anybody, it could
be removed without replacement.

What actually does make sense is to pass an indication if the process
uses the elf interpreter or not. The glibc code will not use anything
from the vdso if the process does not use the dynamic linker, so for
statically linked binaries the architecture backend can choose not
to map the vdso.

Thanks,
Heiko

Christian Borntraeger (3):
      [S390] vmcp: remove BKL
      [S390] pgtables: Fix race in enable_sie vs. page table ops
      [S390] s390: Fix build for !CONFIG_S390_GUEST + CONFIG_VIRTIO_CONSOLE

Frank Munzert (2):
      [S390] tape block: complete request with correct locking
      [S390] tape: disable interrupts in tape_open and tape_release

Heiko Carstens (3):
      [S390] Fix sysdev class file creation.
      [S390] Change default IPL method to IPL_VM.
      [S390] No more 4kb stacks.

Jan Glauber (2):
      [S390] qdio: prevent double qdio shutdown in case of I/O errors
      [S390] qdio: remove incorrect memset

Martin Schwidefsky (2):
      [S390] arch_setup_additional_pages arguments
      [S390] introduce vdso on s390

Roel Kluin (1):
      [S390] appldata: unsigned ops->size cannot be negative

 arch/powerpc/include/asm/elf.h           |    2 +-
 arch/powerpc/kernel/vdso.c               |    3 +-
 arch/s390/Kconfig                        |   19 ++--
 arch/s390/appldata/appldata_base.c       |    2 +-
 arch/s390/include/asm/auxvec.h           |    2 +
 arch/s390/include/asm/elf.h              |   16 ++
 arch/s390/include/asm/kvm_virtio.h       |    2 +-
 arch/s390/include/asm/mmu.h              |    4 +-
 arch/s390/include/asm/mmu_context.h      |   19 ++-
 arch/s390/include/asm/page.h             |    2 +
 arch/s390/include/asm/pgtable.h          |    8 +-
 arch/s390/include/asm/thread_info.h      |    5 -
 arch/s390/include/asm/vdso.h             |   39 +++++
 arch/s390/kernel/Makefile                |    7 +-
 arch/s390/kernel/asm-offsets.c           |   15 ++
 arch/s390/kernel/smp.c                   |   24 ++--
 arch/s390/kernel/time.c                  |   31 ++++
 arch/s390/kernel/vdso.c                  |  232 ++++++++++++++++++++++++++++++
 arch/s390/kernel/vdso32/Makefile         |   55 +++++++
 arch/s390/kernel/vdso32/clock_getres.S   |   39 +++++
 arch/s390/kernel/vdso32/clock_gettime.S  |  128 ++++++++++++++++
 arch/s390/kernel/vdso32/gettimeofday.S   |   82 +++++++++++
 arch/s390/kernel/vdso32/note.S           |   12 ++
 arch/s390/kernel/vdso32/vdso32.lds.S     |  138 ++++++++++++++++++
 arch/s390/kernel/vdso32/vdso32_wrapper.S |   13 ++
 arch/s390/kernel/vdso64/Makefile         |   55 +++++++
 arch/s390/kernel/vdso64/clock_getres.S   |   39 +++++
 arch/s390/kernel/vdso64/clock_gettime.S  |   89 ++++++++++++
 arch/s390/kernel/vdso64/gettimeofday.S   |   56 +++++++
 arch/s390/kernel/vdso64/note.S           |   12 ++
 arch/s390/kernel/vdso64/vdso64.lds.S     |  138 ++++++++++++++++++
 arch/s390/kernel/vdso64/vdso64_wrapper.S |   13 ++
 arch/s390/mm/pgtable.c                   |   16 +-
 arch/sh/include/asm/elf.h                |    2 +-
 arch/sh/kernel/vsyscall/vsyscall.c       |    3 +-
 arch/x86/include/asm/elf.h               |    2 +-
 arch/x86/vdso/vdso32-setup.c             |    2 +-
 arch/x86/vdso/vma.c                      |    2 +-
 drivers/s390/char/tape_block.c           |    6 +-
 drivers/s390/char/tape_core.c            |    8 +-
 drivers/s390/char/vmcp.c                 |    3 -
 drivers/s390/cio/qdio_debug.c            |   19 +--
 drivers/s390/cio/qdio_main.c             |    1 -
 fs/binfmt_elf.c                          |    2 +-
 44 files changed, 1286 insertions(+), 81 deletions(-)
 create mode 100644 arch/s390/include/asm/vdso.h
 create mode 100644 arch/s390/kernel/vdso.c
 create mode 100644 arch/s390/kernel/vdso32/Makefile
 create mode 100644 arch/s390/kernel/vdso32/clock_getres.S
 create mode 100644 arch/s390/kernel/vdso32/clock_gettime.S
 create mode 100644 arch/s390/kernel/vdso32/gettimeofday.S
 create mode 100644 arch/s390/kernel/vdso32/note.S
 create mode 100644 arch/s390/kernel/vdso32/vdso32.lds.S
 create mode 100644 arch/s390/kernel/vdso32/vdso32_wrapper.S
 create mode 100644 arch/s390/kernel/vdso64/Makefile
 create mode 100644 arch/s390/kernel/vdso64/clock_getres.S
 create mode 100644 arch/s390/kernel/vdso64/clock_gettime.S
 create mode 100644 arch/s390/kernel/vdso64/gettimeofday.S
 create mode 100644 arch/s390/kernel/vdso64/note.S
 create mode 100644 arch/s390/kernel/vdso64/vdso64.lds.S
 create mode 100644 arch/s390/kernel/vdso64/vdso64_wrapper.S
