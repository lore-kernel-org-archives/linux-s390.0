Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 19 Apr 2018 08:23:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.17-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180419082353.0dd23146@mschwideX1>
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

After the common code kexec patches went in via Andrew we can
now push the architecture parts to implement the kexec-file-load
system call. Plus a few more bug fixes and cleanups, this includes
an update to the default configurations.

Heiko Carstens (4):
      s390/kexec_file: add generated files to .gitignore
      s390: add support for IBM z14 Model ZR1
      s390: remove gcov defconfig
      s390: rename default_defconfig to debug_defconfig

Martin Schwidefsky (3):
      s390/smsgiucv: disable SMSG on module unload
      s390: update defconfig
      s390/signal: cleanup uapi struct sigaction

Philipp Rudo (7):
      s390/kexec_file: Prepare setup.h for kexec_file_load
      s390/kexec_file: Add purgatory
      s390/kexec_file: Add kexec_file_load system call
      s390/kexec_file: Add image loader
      s390/kexec_file: Add crash support to image loader
      s390/kexec_file: Add ELF loader
      s390/Kconfig: Move kexec config options to "Processor type and features"

Sebastian Ott (1):
      s390/nospec: include cpu.h

Thomas Richter (1):
      s390/decompressor: Ignore file vmlinux.bin.full

Vasily Gorbik (3):
      s390/sclp: avoid potential usage of uninitialized value
      s390/boot: remove unused COMPILE_VERSION and ccflags-y
      s390: remove couple of duplicate includes

 arch/s390/Kbuild                                   |   1 +
 arch/s390/Kconfig                                  |  32 +-
 arch/s390/boot/Makefile                            |   6 -
 arch/s390/boot/compressed/.gitignore               |   1 +
 .../configs/{default_defconfig => debug_defconfig} |  30 +-
 arch/s390/configs/gcov_defconfig                   | 661 ---------------------
 arch/s390/configs/performance_defconfig            |  20 +-
 arch/s390/defconfig                                |  13 +-
 arch/s390/include/asm/kexec.h                      |  23 +
 arch/s390/include/asm/purgatory.h                  |  17 +
 arch/s390/include/asm/setup.h                      |  40 +-
 arch/s390/include/uapi/asm/signal.h                |  23 +-
 arch/s390/kernel/Makefile                          |   3 +
 arch/s390/kernel/asm-offsets.c                     |   5 +
 arch/s390/kernel/compat_wrapper.c                  |   1 +
 arch/s390/kernel/kexec_elf.c                       | 147 +++++
 arch/s390/kernel/kexec_image.c                     |  76 +++
 arch/s390/kernel/machine_kexec_file.c              | 245 ++++++++
 arch/s390/kernel/nospec-branch.c                   |   1 +
 arch/s390/kernel/perf_cpum_cf_events.c             |   1 +
 arch/s390/kernel/setup.c                           |   1 +
 arch/s390/kernel/syscalls/syscall.tbl              |   1 +
 arch/s390/purgatory/.gitignore                     |   2 +
 arch/s390/purgatory/Makefile                       |  37 ++
 arch/s390/purgatory/head.S                         | 279 +++++++++
 arch/s390/purgatory/purgatory.c                    |  42 ++
 drivers/s390/block/dasd_diag.c                     |   1 -
 drivers/s390/char/sclp_early_core.c                |   2 +-
 drivers/s390/net/qeth_l2_main.c                    |   1 -
 drivers/s390/net/smsgiucv.c                        |   2 +-
 30 files changed, 998 insertions(+), 716 deletions(-)
 rename arch/s390/configs/{default_defconfig => debug_defconfig} (97%)
 delete mode 100644 arch/s390/configs/gcov_defconfig
 create mode 100644 arch/s390/include/asm/purgatory.h
 create mode 100644 arch/s390/kernel/kexec_elf.c
 create mode 100644 arch/s390/kernel/kexec_image.c
 create mode 100644 arch/s390/kernel/machine_kexec_file.c
 create mode 100644 arch/s390/purgatory/.gitignore
 create mode 100644 arch/s390/purgatory/Makefile
 create mode 100644 arch/s390/purgatory/head.S
 create mode 100644 arch/s390/purgatory/purgatory.c
