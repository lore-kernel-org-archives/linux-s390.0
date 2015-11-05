Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Amanieu d'Antras" <amanieu@gmail.com>
Subject: [PATCH v2 00/20] Fix handling of compat_siginfo_t
Date: Thu,  5 Nov 2015 00:50:19 +0000
Message-Id: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amanieu d'Antras <amanieu@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The current handling of compat_siginfo_t is a mess: each architecture has its
own implementation, all of which are incorrect in different ways. This patch
series replaces all of the arch-specific versions with a single generic one that
is guaranteed to produce the same results as a 32-bit kernel.

Most architectures are able to use the generic compat_siginfo_t, except x86 and
MIPS. MIPS uses a slightly different compat_siginfo_t structure for ABI reasons
but can still use the generic copy_siginfo_{to,from}_user32. x86 can't use the
generic versions because it needs special handling for __SI_CHLD for x32 tasks.

One issue that isn't resolved in this series is sending signals between a 32-bit
process and 64-bit process. Sending a si_int will work correctly, but a si_ptr
value will likely get corrupted due to the different layouts of the 32-bit and
64-bit siginfo_t structures.

signalfd_copyinfo was also modified to properly generate data for compat tasks.
In particular the ssi_ptr and ssi_data members need to be sign-extended to 64
bits rather than zero-extended, since that is the behavior in 32-bit kernels.

This series has been tested on x86_64 and arm64.

Changes since v1:
- Properly copy padding bytes and avoid leaking uninitialized data to userspace
- Fixed compile errors on mips and powerpc
- Fixed some compiler warnings
- Fixed some formatting issues

Amanieu d'Antras (20):
  compat: Add generic compat_siginfo_t
  compat: Add generic copy_siginfo_{to,from}_user32
  x86: Update compat_siginfo_t to be closer to the generic version
  x86: Rewrite copy_siginfo_{to,from}_user32
  mips: Clean up compat_siginfo_t
  mips: Use generic copy_siginfo_{to,from}_user32
  arm64: Use generic compat_siginfo_t
  arm64: Use generic copy_siginfo_{to,from}_user32
  parisc: Use generic compat_siginfo_t
  parsic: Use generic copy_siginfo_{to,from}_user32
  s390: Use generic compat_siginfo_t
  s390: Use generic copy_siginfo_{to,from}_user32
  powerpc: Use generic compat_siginfo_t
  powerpc: Use generic copy_siginfo_{to,from}_user32
  tile: Use generic compat_siginfo_t
  tile: Use generic copy_siginfo_{to,from}_user32
  sparc: Use generic compat_siginfo_t
  sparc: Use generic copy_siginfo_{to,from}_user32
  signalfd: Fix some issues in signalfd_copyinfo
  signal: Remove unnecessary zero-initialization of siginfo_t

 arch/arm64/include/asm/compat.h    |  59 --------
 arch/arm64/kernel/signal32.c       |  85 -----------
 arch/mips/include/asm/compat.h     |  63 ++++----
 arch/mips/kernel/signal32.c        |  62 --------
 arch/parisc/include/asm/compat.h   |  52 -------
 arch/parisc/kernel/signal32.c      | 102 -------------
 arch/powerpc/include/asm/compat.h  |  60 --------
 arch/powerpc/kernel/signal_32.c    |  72 +---------
 arch/s390/include/asm/compat.h     |  51 -------
 arch/s390/kernel/compat_signal.c   | 102 -------------
 arch/sparc/include/asm/compat.h    |  54 -------
 arch/sparc/kernel/signal32.c       |  69 ---------
 arch/tile/include/asm/compat.h     |  57 --------
 arch/tile/kernel/compat_signal.c   |  75 ----------
 arch/x86/include/asm/compat.h      |  39 +++--
 arch/x86/kernel/signal_compat.c    | 285 ++++++++++++++++++++++++++++---------
 fs/signalfd.c                      |  58 +++++---
 include/linux/compat.h             |  66 ++++++++-
 include/uapi/asm-generic/siginfo.h |   1 +
 kernel/compat.c                    | 224 +++++++++++++++++++++++++++++
 kernel/ptrace.c                    |   1 -
 kernel/signal.c                    |  16 ++-
 22 files changed, 615 insertions(+), 1038 deletions(-)

-- 
2.6.2
