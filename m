Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/5] s390: rework compat wrapper generation
Date: Wed, 16 Jan 2019 14:15:18 +0100
Message-Id: <20190116131527.2071570-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org, Dominik Brodowski <linux@dominikbrodowski.net>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-s390.vger.kernel.org>

Hi Heiko and Martin,

As promised, I gave this a go and changed the SYSCALL_DEFINEx()
infrastructure to always include the wrappers for doing the
31-bit argument conversion on s390 compat mode.

This does three main things:

- The UID16 rework saved a lot of duplicated code, and would
  probably make sense by itself, but is also required as
  we can no longer call sys_*() functions directly after the
  last step.

- Removing the compat_wrapper.c file is of course the main
  goal here, in order to remove the need to maintain the
  compat_wrapper.c file when new system calls get added.
  Unfortunately, this requires adding some complexity in
  syscall_wrapper.h, and trades a small reduction in source
  code lines for a small increase in binary size for
  unused wrappers.

- As an added benefit, the use of syscall_wrapper.h now makes
  it easy to change the syscall wrappers so they no longer
  see all user space register contents, similar to changes
  done in commits fa697140f9a2 ("syscalls/x86: Use 'struct pt_regs'
  based syscall calling convention for 64-bit syscalls") and
  4378a7d4be30 ("arm64: implement syscall wrappers").
  I leave the actual implementation of this for you, if you
  want to do it later.

I did not test the changes at runtime, but I looked at the
generated object code, which seems fine here and includes
the same conversions as before.

      Arnd

Arnd Bergmann (5):
  s390: open-code s390_personality syscall
  ipc: introduce ksys_ipc()/compat_ksys_ipc() for s390
  s390: use generic UID16 implementation
  s390: autogenerate compat syscall wrappers
  s390: remove compat_wrapper.c

 arch/s390/Kconfig                        |   2 +
 arch/s390/include/asm/syscall_wrapper.h  | 136 +++++++++++
 arch/s390/include/uapi/asm/posix_types.h |   6 +
 arch/s390/kernel/Makefile                |   2 +-
 arch/s390/kernel/compat_linux.c          | 235 +------------------
 arch/s390/kernel/compat_wrapper.c        | 186 ---------------
 arch/s390/kernel/entry.S                 |   4 +-
 arch/s390/kernel/sys_s390.c              |  14 +-
 arch/s390/kernel/syscalls/syscall.tbl    | 286 +++++++++++------------
 include/linux/syscalls.h                 |   4 +
 ipc/syscall.c                            |  20 +-
 11 files changed, 322 insertions(+), 573 deletions(-)
 create mode 100644 arch/s390/include/asm/syscall_wrapper.h
 delete mode 100644 arch/s390/kernel/compat_wrapper.c

-- 
2.20.0
