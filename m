From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 00/16] compat: Introduce and use in_compat_syscall
Date: Mon, 25 Jan 2016 14:24:14 -0800
Message-ID: <cover.1453759363.git.luto@kernel.org>
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Linux distinguishes compat syscalls from normal syscalls in two ways.
First, compat syscalls use separate entry points.  This is entirely
sensible.  Second, code paths that are common to compat and non-compat
syscalls can query is_compat_task() to check whether they are being
called from a compat syscall or not.

The latter is problematic.  Two architectures explicitly allow tasks
to issue syscalls for which the task bitness and the syscall bitness
don't match.  On x86, is_compat_task returns true if the current
syscall is a compat syscall, which is a different condition from being
a compat task.  This oddity is confusing.  On SPARC, is_compat_task
does what it sounds like, which means that user programs can cause
is_compat_task to fail to match the syscall entry used.  That could
expose bugs.

This series introduces in_compat_syscall() as a new way to query the
syscall type.  On SPARC, it really does check the syscall bitness.
Later patches change all of the non arch-specific is_compat_task
callers to use in_compat_syscall.  The last patch removes
is_compat_task on x86, which will prevent this confusion from
recurring.

I've cc'd the maintainers of all archs that support compat.  If your
arch makes it possible for a malicious user process to invoke a compat
syscall in a nominally 64-bit task or vice versa and your arch is not
x86 or SPARC, please tell me.

Davem, can you check whether I handled SPARC correctly?

Andy Lutomirski (16):
  compat: Add in_compat_syscall to ask whether we're in a compat syscall
  sparc/compat: Provide an accurate in_compat_syscall implementation
  sparc/syscall: Fix syscall_get_arch
  seccomp: Check in_compat_syscall, not is_compat_task, in strict mode
  ptrace: in PEEK_SIGINFO, check syscall bitness, not task bitness
  auditsc: For seccomp events, log syscall compat state using
    in_compat_syscall
  staging/lustre: Switch from is_compat_task to in_compat_syscall
  ext4: In ext4_dir_llseek, check syscall bitness directly
  net/sctp: Use in_compat_syscall for sctp_getsockopt_connectx3
  net/xfrm_user: Use in_compat_syscall to deny compat syscalls
  firewire: Use in_compat_syscall to check ioctl compatness
  efivars: Use in_compat_syscall to check for compat callers
  amdkfd: Use in_compat_syscall to check open() caller type
  input: Redefine INPUT_COMPAT_TEST as in_compat_syscall()
  uhid: Check write() bitness using in_compat_syscall
  x86/compat: Remove is_compat_task

 arch/sparc/include/asm/compat.h                      |  6 ++++++
 arch/sparc/include/asm/syscall.h                     |  9 ++++++++-
 arch/x86/include/asm/compat.h                        |  3 ++-
 arch/x86/include/asm/ftrace.h                        |  2 +-
 arch/x86/kernel/process_64.c                         |  2 +-
 drivers/firewire/core-cdev.c                         |  4 ++--
 drivers/firmware/efi/efivars.c                       |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c             |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c             |  2 +-
 drivers/hid/uhid.c                                   |  2 +-
 drivers/input/input-compat.h                         | 12 +-----------
 drivers/staging/lustre/lustre/llite/llite_internal.h |  2 +-
 fs/ext4/dir.c                                        |  2 +-
 include/linux/compat.h                               | 15 +++++++++++++++
 kernel/auditsc.c                                     |  4 ++--
 kernel/ptrace.c                                      |  2 +-
 kernel/seccomp.c                                     |  4 ++--
 net/sctp/socket.c                                    |  2 +-
 net/xfrm/xfrm_user.c                                 |  2 +-
 19 files changed, 49 insertions(+), 30 deletions(-)

-- 
2.5.0
