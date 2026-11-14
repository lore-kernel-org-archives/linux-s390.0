Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794680384;
	b=VSFJIel98aZZ6j5md8SD8BCHD9dsVvIofjdNOGCQtzNrPpilrbeCu2DO1oLaK449FTa5
	 66+Kn3dEDFn/orJ7SzDaS4KJ5JO3W4PoNauhTrtfAtQ9qkcqUi3iXpDQ4+N1tpaBH9aeW
	 y+5AtNGRnqufPWWhnZ2Z3x/Z1EKBn9cLHwdm0vanrDyvdTVWWZJzgAV2KQTFoFsGtWFm+
	 NhHhgublE9f1h9804dEkG/jAYNxwbWJisFYkGoZ5uKcpj3awcDud/C1s7b7nSUKTprDo1
	 kQMcltxgat1XKKCg64RtU8A5Pzx/n8YVP4m0zIU9b1l6pNgItoQ7duyI3myjZE/w3yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680384;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fneCtoft1jE/z5cQICLaBJ4/CSSYpKeQ7A9soDkriNI=;
	b=ZUQisef8YsIwBcn7UDXxKU2AC2ez3NsjEv3oD2/VRcxKvFZ8T3yL3V14qcAVpOkLMe2X
	 Z44wkhNj1svWcCa98QMUXgBSHU8ZwD0Efy9Q1Ids9qmUd2eeRjeuG71Z/UbSBxH+qs8xN
	 Q8e9hOjD97XIyZLFOB2Pii6uPZwji2miC1sw352HKnRAMltx5AUOepADXxQhrRK+8cZLs
	 W8BbuPcTnRA+fNTiDiCqyXGM0Hpyqt8RA+gfnOcOPZYgNolH8J1tT+9AOEoSJjxeF82Kg
	 9x8Bv8/KxOmLgGS2H8v5UiIdFVcnksKlQ2h7WrW9uUHzFXSt7j05lK3UzVSN5auRUYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=aP3HwpnO;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9FC606A329;
	Sat, 14 Nov 2026 18:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B9FC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=aP3HwpnO
Received: from eipi10.cs.unibo.it (host0.studiodavoli.it [109.234.61.1])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 1A4041C0145;
	Sat, 14 Nov 2026 19:19:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1794680374;
	bh=/jZX3I3Baf9Yzk43cr+jSHpUEb9Hel2mhebb/m9ZUaM=;
	h=From:To:Cc:Subject:Date:From;
	b=aP3HwpnOX9fpF9+uRHGXvdKP7vUX16c4N10VZUiROLKfGMrX+NF/miPeZY0ddycCi
	 y9PtbcODQIs8a7Kr+psTN05b3stH+J4nI/Sb76lKX22TQhwm/XKe/1+hWzgaSI667G
	 SHcQKQ5oWYN4513oBF60P4YDEtzE2tB26K6+hEbE=
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
Subject: [PATCH v11 0/3] PTRACE_SET_SYSCALL_INFO: add support for seccomp syscall skipping
Date: Sat, 14 Nov 2026 19:19:19 +0100
Message-ID: <20261114181923.370930-1-renzo@cs.unibo.it>
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
[3] https://sashiko.dev/#/patchset/20261113165509.229869-1-renzo@cs.unibo.it?part=2

Testing (tools/testing/selftests/ptrace/set_syscall_info and
tools/testing/selftests/seccomp/seccomp_bpf):

v11, QEMU, v7.4-rc2:

                               x86_64 (KVM)
  ptrace/set_syscall_info      2/2
  seccomp/seccomp_bpf          142/142

v9, QEMU, v7.3-rc6 (the v11 change is architecture independent):

                               x86_64 (KVM)   ppc64le (TCG)   s390x (TCG)
  ptrace/set_syscall_info      2/2            2/2             2/2
  seccomp/seccomp_bpf          111/111        111/111         110/111 (*)

  Build-tested also with CONFIG_SECCOMP=n and CONFIG_SECCOMP_FILTER=n.

  Skipping getpid() at a PTRACE_EVENT_SECCOMP stop, with a filter that
  kills the process on unknown syscall numbers:

  op=SECCOMP, nr=-1 (before)   error          r3 left as is   SIGSYS kill
  op=SECCOMP->EXIT (this)      -ESRCH         -ESRCH          -ESRCH

  (*) user_notification_wait_killable_after_reply timed out under TCG
      while another VM was running; it passes 5/5 both with and without
      this series on an idle x86_64 KVM guest.

  ppc64le results were obtained with an earlier version of the powerpc
  fix [2] applied.

  Not tested: MIPS, arm64, riscv, loongarch, real hardware.

Changes in v11:
* once the system call is skipped, PTRACE_GET_SYSCALL_INFO reports the
  stop as a PTRACE_SYSCALL_INFO_EXIT one, as the syscall number and
  arguments may have been overwritten by the return value (reported by
  Sashiko [3]); a later PTRACE_SYSCALL_INFO_SECCOMP update is still
  rejected, now by the generic check on the stop type
* selftests/ptrace/set_syscall_info.c: check PTRACE_GET_SYSCALL_INFO
  after the system call is skipped

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
 kernel/ptrace.c                               |  49 +++-
 kernel/seccomp.c                              |  11 +-
 .../selftests/ptrace/set_syscall_info.c       | 249 +++++++++++++++++-
 5 files changed, 342 insertions(+), 4 deletions(-)

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.55.0

