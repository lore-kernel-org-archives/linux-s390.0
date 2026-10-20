Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510199;
	b=aqGTl0pgSa+v70bJNLBo/r1sXyo2g9wuu636NAF+l9uox9WJx9Is+JkuCO5ntj8asdhd
	 14sphJY2jjMtWGTBWGack9/czDUrJMe4GZZsARyd8R3+DLkcu4dEGHaL2jynDcF4DoobN
	 GISpWu/JPjp5Q9xvby1sfjyIJ++5MusWz0HDOxC+hz0H6i0ocuory+ac6j20b/fJKvS9s
	 JugmD0EmUhuAtTw3zl9of2FO/IRNqxuvgv2xvnG2q7YSW0hSSxV93GnWhvvYWxzq1ieha
	 7Wm0YUfbs7g0dg6+9xMC/RejJrqmga9RIvIvCxMeKKv464YriJFGRl7EDvxwG/R+OPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510199;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ofcykhfhNK12YLYENqutUEOmHnqlx6au/qEhAK44Ct0=;
	b=eIfaPVb9RWVTjbGpspWAEVNaPDSCFwYvAaHwVM9Cmafu8FRSubS8iDiPoGH71xN0aSpc
	 g/gcecLme8xhnsMzaPjqMuxzIjkRdO1swkhiu5tEyUv5bSEA11kn1lxDPa64DOb1hGmrW
	 oBeLSAB6jkRVa/2TOFZv/YeHAjy4zpkO7ui24X5U81vSEPVFmTx3nHa35mW4foZmNTbPi
	 IkC1L7dsZaeVXKuHOXiMTqXjYGXCwj+viLmsXlm7JEUDCDqM6DRb81/BmkWm2k5wMnOAo
	 CFvKtap7go+Edxfv6/bo9P+Za0O2ZqIrt1CDmhqvLk2Y5Eo6W5qRqjmjnF/ZF/vz6Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=kRHG9pcu;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD12606A31A;
	Tue, 20 Oct 2026 15:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCD12606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=kRHG9pcu
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 3A0EC1C007A;
	Tue, 20 Oct 2026 17:29:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1792510195;
	bh=veBmBn3FP2ffZE8f3zwhKGlOWly7L1HMV7ZmK5ooywI=;
	h=From:To:Cc:Subject:Date:From;
	b=kRHG9pcuP0Y7DqcEuULu6cEu9AWpH1YZuefZ81VcPnI8bCJ6QDpCS7DTOVDFJPlzl
	 w5Tr81XOinKSb1MUWHExSsZsgXT9fLnKEuurdq8P6EQpYV81AKQci9cPk+1nJQS3Xz
	 HGTwke/ANaCIm92ino7itEzb1GnTlqMKQMnEfm/8=
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Renzo Davoli <renzo@cs.unibo.it>,
	Oleg Nesterov <oleg@redhat.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	strace-devel@lists.strace.io
Subject: [PATCH v9 0/3] PTRACE_SET_SYSCALL_INFO: add support for seccomp syscall skipping
Date: Tue, 20 Oct 2026 17:29:40 +0200
Message-ID: <20261020152945.575664-1-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
PTRACE_GET_SYSCALL_INFO by allowing a tracer to modify details of a
system call in which the tracee is currently blocked.

This patch set extends PTRACE_SET_SYSCALL_INFO with support for
skipping a system call at a PTRACE_EVENT_SECCOMP stop and setting its
return value.  To do this, the tracer changes 'op' from
PTRACE_SYSCALL_INFO_SECCOMP to PTRACE_SYSCALL_INFO_EXIT and fills in the
exit union fields (rval and is_error).

Michal pointed out in the review of v7 [1] that the register state alone
cannot tell whether a syscall has to be executed or skipped with a
preset return value, since on some architectures the return value
shares a register with the syscall number or the arguments, and that
the "already dispatched" information should be architecture
independent rather than an architecture-specific thread flag.

v8 does exactly that: the tracer no longer sets the syscall number to -1
and relies on syscall_get_nr() reading it back as negative.  Instead,
patch 1 adds a per-task flag owned by seccomp, which the tracer sets
while the tracee is stopped.  When the tracee resumes, seccomp skips the
system call just like for SECCOMP_RET_ERRNO, a path every architecture
already handles without touching the return value.  This also fixes
skipping on s390, where -1 is read back as syscall 65535.

On powerpc, this series depends on the fix posted separately [2]:
syscall_set_return_value() currently sets TIF_SYSCALL_RET on the
*caller*, i.e. on the tracer when called from PTRACE_SET_SYSCALL_INFO,
and skipped system calls lose non-error return values.  Both problems
are regressions in v7.3-rc and already break the existing
set_syscall_info selftest and seccomp_bpf user_notification_basic on
ppc64le.

[1] https://lore.kernel.org/lkml/apWFHkZnCMfxQCEk@kunlun.suse.cz/
[2] https://lore.kernel.org/lkml/20261018151539.440213-1-renzo@cs.unibo.it/

Testing (QEMU, v7.3-rc6, tools/testing/selftests/ptrace/set_syscall_info
and tools/testing/selftests/seccomp/seccomp_bpf):

                               x86_64 (KVM)   ppc64le (TCG)   s390x (TCG)
  ptrace/set_syscall_info      2/2            2/2             2/2
  seccomp/seccomp_bpf          111/111        111/111         110/111 (*)

  Skipping getpid() at a PTRACE_EVENT_SECCOMP stop, with a filter that
  kills the process on unknown syscall numbers:

  op=SECCOMP, nr=-1 (before)   error          r3 left as is   SIGSYS kill
  op=SECCOMP->EXIT (this)      -ESRCH         -ESRCH          -ESRCH

  (*) user_notification_wait_killable_after_reply timed out under TCG
      while another VM was running; it passes 5/5 both with and without
      this series on an idle x86_64 KVM guest.

  Build-tested also with CONFIG_SECCOMP=n and CONFIG_SECCOMP_FILTER=n.
  Not tested: MIPS, arm64, riscv, loongarch, real hardware.

Changes in v9:
* selftests/ptrace/set_syscall_info.c: check for seccomp filter support,
  fix failure report
* rebased to Linux 7.3

Changes in v8:
* skip the system call via a seccomp per-task flag instead of
  syscall_set_nr(-1), as suggested by Michal Suchánek
* new helper ptrace_set_syscall_info_seccomp_skip() instead of a bool
  argument to ptrace_set_syscall_info_exit() (Michal Suchánek)
* once the system call is skipped, reject further
  PTRACE_SYSCALL_INFO_SECCOMP updates during the same stop
* selftest: also test an error return value and the above
* dropped the Reviewed-by tags of Oleg and Dmitry, as patch 2 changed
  significantly

Changes in v7:
* rebased to Linux 7.3-rc1

Changes in v6:
* selftests/ptrace/set_syscall_info.c: improve messages in case of failure.

Changes in v5:
* reworded the explanation for not supporting PTRACE_SYSCALL_INFO_ENTRY yet.
* selftests/ptrace: removed a redundant check.

Changes in v4:
* Reworded the commit messages for clarity.
* Renamed the local variable child_op to op in ptrace_set_syscall_info()
* Clean up and improve the coding style of selftests/ptrace/set_syscall_info.c
  (suggested by Dmitry V. Levin)

Changes in v3:
* restrict the syscall skipping feature to PTRACE_SYSCALL_INFO_SECCOMP

Changes in v2:
bugfix: _NONE -> _EXIT transition was erroneously permitted

Davide Berardi (1):
  seccomp: let the tracer skip a syscall independently of its number

Renzo Davoli (2):
  ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
  selftests/ptrace: add a test case for PTRACE_SET_SYSCALL_INFO syscall
    skipping

 include/linux/seccomp.h                       |  33 +++
 include/linux/seccomp_types.h                 |   4 +
 kernel/ptrace.c                               |  45 +++-
 kernel/seccomp.c                              |  11 +-
 .../selftests/ptrace/set_syscall_info.c       | 230 +++++++++++++++++-
 5 files changed, 319 insertions(+), 4 deletions(-)


base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
prerequisite-patch-id: abdd0fc0973bc3845ae7bfe84d855a7213ccd3d7
-- 
2.55.0

