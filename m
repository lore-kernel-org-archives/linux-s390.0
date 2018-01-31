Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 31 Jan 2018 07:49:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.15 merge window
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20180131074952.01303090@mschwideX1>
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

Bug fixes, small improvements and one notable change:

 * The system call table and the unistd.h header are now generated
   automatically with a shell script from a text file.

Christophe JAILLET (1):
      s390/dasd: Simplify code

Eugene Syromiatnikov (1):
      s390: fix handling of -1 in set{,fs}[gu]id16 syscalls

Heiko Carstens (1):
      s390: remove bogus system call table entries

Hendrik Brueckner (8):
      s390/kernel: emit CFI data in .debug_frame and discard .eh_frame sections
      s390/vdso: revise CFI annotations of vDSO functions
      s390/disassembler: add generated gen_opcode_table tool to .gitignore
      s390/syscalls: add system call table
      s390/syscalls: add syscalltbl script
      s390/syscalls: add Makefile to generate system call header files
      s390/syscalls: use generated syscall_table.h and unistd.h header files
      s390/tools: generate header files in arch/s390/include/generated/

Jan Höppner (1):
      s390/dasd: Remove dead return code checks

Pravin Shedge (1):
      s390/kprobes: remove duplicate includes

Vasily Gorbik (5):
      s390/head: replace hard coded values with constants
      s390/ipl: avoid usage of __section(.data)
      s390/sclp: fix .data section specification
      s390/decompressor: swap .text and .rodata.compressed sections
      s390/decompressor: discard __ksymtab and .eh_frame sections

 arch/s390/Makefile                      |  14 +-
 arch/s390/boot/compressed/Makefile      |   1 +
 arch/s390/boot/compressed/vmlinux.lds.S |  12 +-
 arch/s390/include/asm/Kbuild            |   5 +
 arch/s390/include/asm/dis.h             |   2 +-
 arch/s390/include/asm/dwarf.h           |  37 +++
 arch/s390/include/asm/facility.h        |   2 +-
 arch/s390/include/asm/unistd.h          |   1 +
 arch/s390/include/uapi/asm/Kbuild       |   3 +
 arch/s390/include/uapi/asm/unistd.h     | 401 +-------------------------------
 arch/s390/kernel/compat_linux.c         |   8 +-
 arch/s390/kernel/entry.S                |   4 +-
 arch/s390/kernel/head.S                 |  10 +-
 arch/s390/kernel/ipl.c                  |  12 +-
 arch/s390/kernel/kprobes.c              |   1 -
 arch/s390/kernel/syscalls.S             | 392 -------------------------------
 arch/s390/kernel/syscalls/Makefile      |  52 +++++
 arch/s390/kernel/syscalls/syscall.tbl   | 390 +++++++++++++++++++++++++++++++
 arch/s390/kernel/syscalls/syscalltbl    | 232 ++++++++++++++++++
 arch/s390/kernel/vdso32/Makefile        |   3 +
 arch/s390/kernel/vdso32/clock_getres.S  |   5 +-
 arch/s390/kernel/vdso32/clock_gettime.S |  17 +-
 arch/s390/kernel/vdso32/getcpu.S        |   5 +-
 arch/s390/kernel/vdso32/gettimeofday.S  |   9 +-
 arch/s390/kernel/vdso64/Makefile        |   3 +
 arch/s390/kernel/vdso64/clock_getres.S  |   5 +-
 arch/s390/kernel/vdso64/clock_gettime.S |  21 +-
 arch/s390/kernel/vdso64/getcpu.S        |   5 +-
 arch/s390/kernel/vdso64/gettimeofday.S  |   9 +-
 arch/s390/kernel/vmlinux.lds.S          |   3 +
 arch/s390/tools/.gitignore              |   1 +
 arch/s390/tools/Makefile                |  23 +-
 arch/s390/tools/gen_facilities.c        |   4 +-
 arch/s390/tools/gen_opcode_table.c      |   4 +-
 drivers/s390/block/dasd.c               |  12 -
 drivers/s390/block/dasd_eckd.c          |   7 +-
 drivers/s390/char/sclp_early_core.c     |   4 +-
 37 files changed, 856 insertions(+), 863 deletions(-)
 create mode 100644 arch/s390/include/asm/dwarf.h
 delete mode 100644 arch/s390/kernel/syscalls.S
 create mode 100644 arch/s390/kernel/syscalls/Makefile
 create mode 100644 arch/s390/kernel/syscalls/syscall.tbl
 create mode 100755 arch/s390/kernel/syscalls/syscalltbl
