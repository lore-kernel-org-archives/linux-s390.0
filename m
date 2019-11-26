Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32777 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfKZQZb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 Nov 2019 11:25:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay6so8395874plb.0
        for <linux-s390@vger.kernel.org>; Tue, 26 Nov 2019 08:25:31 -0800 (PST)
Date: Tue, 26 Nov 2019 08:25:28 -0800
From: Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] seccomp updates for v5.5-rc1
Message-ID: <201911260818.9C5DC1E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, David Abdurachmanov <david.abdurachmanov@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, bpf@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>, Daniel Borkmann <daniel@iogearbox.net>, kernel test robot <rong.a.chen@intel.com>, linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>, Song Liu <songliubraving@fb.com>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Tyler Hicks <tyhicks@canonical.com>, Will Drewry <wad@chromium.org>, x86@kernel.org, Yonghong Song <yhs@fb.com>

Hi Linus,

Please pull these seccomp updates for v5.5-rc1. Mostly this is
implementing the new flag SECCOMP_USER_NOTIF_FLAG_CONTINUE, but there
are cleanups as well. Most notably, the secure_computing() prototype
has changed (to remove an unused argument), but this has happened at the
same time as riscv adding seccomp support, so the cleanest merge order
would be to merge riscv first, then seccomp with the following patch for
riscv to handle the change from "seccomp: simplify secure_computing()":

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 0f84628b9385..407464201b91 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -159,7 +159,7 @@ __visible void do_syscall_trace_enter(struct pt_regs *regs)
 	 * If this fails we might have return value in a0 from seccomp
 	 * (via SECCOMP_RET_ERRNO/TRACE).
 	 */
-	if (secure_computing(NULL) == -1) {
+	if (secure_computing() == -1) {
 		syscall_set_nr(current, regs, -1);
 		return;
 	}

Thanks!

-Kees

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.5-rc1

for you to fetch changes up to 23b2c96fad21886c53f5e1a4ffedd45ddd2e85ba:

  seccomp: rework define for SECCOMP_USER_NOTIF_FLAG_CONTINUE (2019-10-28 12:29:46 -0700)

----------------------------------------------------------------
seccomp updates for v5.5

- implement SECCOMP_USER_NOTIF_FLAG_CONTINUE (Christian Brauner)
- fixes to selftests (Christian Brauner)
- remove secure_computing() argument (Christian Brauner)

----------------------------------------------------------------
Christian Brauner (6):
      seccomp: avoid overflow in implicit constant conversion
      seccomp: add SECCOMP_USER_NOTIF_FLAG_CONTINUE
      seccomp: test SECCOMP_USER_NOTIF_FLAG_CONTINUE
      seccomp: simplify secure_computing()
      seccomp: fix SECCOMP_USER_NOTIF_FLAG_CONTINUE test
      seccomp: rework define for SECCOMP_USER_NOTIF_FLAG_CONTINUE

 arch/arm/kernel/ptrace.c                      |   2 +-
 arch/arm64/kernel/ptrace.c                    |   2 +-
 arch/parisc/kernel/ptrace.c                   |   2 +-
 arch/s390/kernel/ptrace.c                     |   2 +-
 arch/um/kernel/skas/syscall.c                 |   2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c         |   2 +-
 include/linux/seccomp.h                       |   6 +-
 include/uapi/linux/seccomp.h                  |  29 +++++++
 kernel/seccomp.c                              |  28 +++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 110 +++++++++++++++++++++++++-
 10 files changed, 169 insertions(+), 16 deletions(-)

-- 
Kees Cook
