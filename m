Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588929;
	b=RgBLpBrjUiitpcmY+69dREV8lDit7kiVpIZvKbHvFKjPAuX8G/8L7gAlLmOhI5jxJqiX
	 loBeRI4vRgxHPd5HECs+bAkxVgAmWdvGowgiLg3/OQqVE/UfIh1CORJ+8hB6q3i4bxfzG
	 4fKWQVaxgujaePd9HUNv/l7T7tCKyP090FRA6XnhOwzOaFXVMY/1aS6+/i5qewSupFH2k
	 U0jBUAZ/WdT/WkbKPyTE7ZoOscci/XqnELHLQ1kry3U2nNcKNuBwCe1m0NZd5xirkS8K5
	 CztPIbzip6ozc23pl8LbZHRHvGOxbpWu+/QwzvPFuXAPLOtHm5nOrQveL3/wcphk+YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588929;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=B1hLmphDmkmygIAVjANKrw3p72oqsJ/6EjwlPW6mWQw=;
	b=ydR6fGzTdbt7J3QQfQIjggs7vwk/9DMsP56hxgQsmhe5ddE316i+Lcen7/lSOIU9ESDB
	 0o3cOiU4TUNJpe7DxHqhwtdE3mJ9H4g/uEH/KRRMExXF8rp5QXiOI7oUU0VAQQ0g6FkPm
	 sJoQVjvzYKA/F/dbzBNcvQED7cXpmuGRGpwP2Udgx4IGspm7J0u7AZZhDccQB52FEgz7L
	 LPaZ16ihR6ogbbZCXUo5ziN6dEyC/Yig4qOqIgTVfcb2+fXcTF/d+GfRCgBE7YKnNRtFR
	 bnOOw4SHc0cEpKdtDhqSXFLPzvhS13hB+RFtaZ3oMgvQur76+zK3227D0LCppErjmnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=n78FvPB7;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E583D606A335;
	Fri, 13 Nov 2026 16:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E583D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=n78FvPB7
Received: from eipi10.cs.unibo.it (host0.studiodavoli.it [109.234.61.1])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id EF9C71C0146;
	Fri, 13 Nov 2026 17:55:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1794588918;
	bh=lt54Q9G0U7Kj8Ffssc6luBMSVhoer/ff/txPnMLhsL0=;
	h=From:To:Cc:Subject:Date:From;
	b=n78FvPB7s/BXwbQI3xuquKHigK/K2G+UXKTKZJg082JgmfZj6R9aLS4DC1SHgJK/J
	 GVmtuBkAwxc8gWswvpbpHtAncO4wypohHgKewscQQmwJXCML0BAxNMA22PWgEJ2oxR
	 cEn7rM1FF4C0gzYTbshLa60zMBEWg7djp9NGPS7k=
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
Subject: [PATCH v10 0/3] PTRACE_SET_SYSCALL_INFO: add support for seccomp syscall skipping
Date: Fri, 13 Nov 2026 17:55:02 +0100
Message-ID: <20261113165509.229869-1-renzo@cs.unibo.it>
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

On powerpc, a separate fix has been posted [2]:
syscall_set_return_value() currently sets TIF_SYSCALL_RET on the
*caller*, i.e. on the tracer when called from PTRACE_SET_SYSCALL_INFO,
and skipped system calls lose non-error return values.  These problems
are already present in the source tree and break the existing
set_syscall_info selftest and seccomp_bpf user_notification_basic on
ppc64le independently of this series, which therefore no longer
depends on [2].

[1] https://lore.kernel.org/lkml/apWFHkZnCMfxQCEk@kunlun.suse.cz/
[2] https://lore.kernel.org/lkml/20261030084926.1068384-1-renzo@cs.unibo.it/

Testing (QEMU, v7.3-rc6, done on v9; the code is unchanged in v10,
tools/testing/selftests/ptrace/set_syscall_info and
tools/testing/selftests/seccomp/seccomp_bpf):

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

  ppc64le results were obtained with an earlier version of the powerpc
  fix [2] applied.

  Build-tested also with CONFIG_SECCOMP=n and CONFIG_SECCOMP_FILTER=n.
  Not tested: MIPS, arm64, riscv, loongarch, real hardware.

Changes in v10:
* rebased to Linux 7.4-rc2
* no longer depends on the powerpc fix [2], which addresses a bug
  already present in the source tree

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

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.55.0

