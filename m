Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794680385;
	b=R1KD1fgemXl3MYiI+K7c1OjD69tsD1mycDkZUHf6meDESWcAk7H839Y3nWLmGZrnA92t
	 ddU95jgHWboPoMIdZsuakz20aUpiXgxasShf0S0Am1Z4KvUmVDjqI6ux0OrkM8KtctuQ5
	 bvn6tTaOzJ4Swq2z1IbwXRP/6P+FBxN5pZC+PJG95Bk6Exgee4njTViuSoFdi2faOoN9L
	 sBqYur6T513YanbM5WLJLBS1EO1Mhb3ck4qrGnEdRx+H6HITNjlFpN8sFbbbYydF4NsB5
	 dUYuzEvEfLRGmEGBBnfFBjwNdRKy64EiQRYVq9RPHrcbzdvxJwAKAKM93ytTOJyAXkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680385;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8oBfLZwpv/eoCOouXMcqz9arLxlB4tNECMdtXo018iY=;
	b=lvICzJ7m/MPBgk7Fu/bZ6mCs075EtCkn0rsNIurq9swX0tFv9VQL+9NE+jhQnfGLpotd
	 7Ob+wxNEEDEUVMvG+rHwElg84nEe4286tzzaUrsfGyR9cXRT5j4lA2zSFcu006+kz6aaE
	 wBHmBrsHP0GQCPSNQNQuQdAGA7KgyhOi3hjSK8xx2pnwplyoljOGQL3hy9+aDpDSp0kfD
	 iG/kVzAhUgUTROqkdA9FBVaTHhlHfojLm2e5tDsiFBsdws8Rb5s5L6xjGQJJyvxZTZ10g
	 y5q1sBoHpvkpji4yXLyB+Bj/2I2XAjUm7Ky/Ns02Bj/MryVXc754vBjueJMSeMZvpLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b="r/BUEFN3";
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95B7606A335;
	Sat, 14 Nov 2026 18:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B95B7606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=r/BUEFN3
Received: from eipi10.cs.unibo.it (host0.studiodavoli.it [109.234.61.1])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 5C6261C025E;
	Sat, 14 Nov 2026 19:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1794680377;
	bh=g7Apg1OBV/LXyn2CMuiTxd1+ckmMVyFB32J11ItkIOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/BUEFN3g+e1tPE1F/WZU45cdCm4VBkkYqCWFysuVE5n+ItS0Pi3u3ZkImdimkrc2
	 qfLm1N4dttTWIMsLoFdMHJPvdb/qbhJhMU/57PEdg9fWVD+plvc6CeLs/3mvM2Dykn
	 hdu16fLYWtzKhM08RCg9nuOgvi7ESPCzoHjarvdI=
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
Subject: [PATCH v11 2/3] ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
Date: Sat, 14 Nov 2026 19:19:21 +0100
Message-ID: <20261114181923.370930-3-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114181923.370930-1-renzo@cs.unibo.it>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend PTRACE_SET_SYSCALL_INFO to support skipping a system call
triggered via seccomp.

When a tracer retrieves a ptrace_syscall_info structure with 'op' set to
PTRACE_SYSCALL_INFO_SECCOMP, it can now choose to skip the system call.
To do this, the tracer changes 'op' to PTRACE_SYSCALL_INFO_EXIT and
populates the exit union fields (rval and is_error) to define the return
value and error status for the tracee.

The skip request is passed to seccomp with seccomp_ptrace_skip_syscall()
rather than by setting the system call number to -1, so that it does not
depend on how the architecture lays out the syscall number and the
return value in the registers.  The tracee then skips the system call
the same way as for SECCOMP_RET_ERRNO.

Once the system call has been skipped, PTRACE_GET_SYSCALL_INFO reports
the stop as a PTRACE_SYSCALL_INFO_EXIT one, as the return value may
already have overwritten registers holding the syscall number or
arguments.  Accordingly, a further PTRACE_SET_SYSCALL_INFO with op ==
PTRACE_SYSCALL_INFO_SECCOMP during the same stop fails with -EINVAL,
while op == PTRACE_SYSCALL_INFO_EXIT can still be used to change the
return value.

System call suppression via PTRACE_SYSCALL_INFO_ENTRY is currently not
implemented.  On some architectures (e.g. MIPS), when a system call is
skipped by setting the syscall number to -1 at the entry stop, the
architecture entry path unconditionally overwrites the return value
register with -ENOSYS, clobbering any custom return value set by the
tracer at the entry stop.

Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
[v8: skip via seccomp_ptrace_skip_syscall() instead of syscall_set_nr(-1),
 separate ptrace_set_syscall_info_seccomp_skip(), reject later
 PTRACE_SYSCALL_INFO_SECCOMP updates during the same stop]
[v11: report the stop as PTRACE_SYSCALL_INFO_EXIT once the syscall is
 skipped, instead of rejecting PTRACE_SYSCALL_INFO_SECCOMP explicitly]
Assisted-by: claude-opus-5-5
---
 kernel/ptrace.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 3f2fe68ccb14..ab6f5dab0223 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -34,6 +34,7 @@
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
 #include <linux/syscall_user_dispatch.h>
+#include <linux/seccomp.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -1010,6 +1011,14 @@ ptrace_get_syscall_info_op(struct task_struct *child)
 			return PTRACE_SYSCALL_INFO_NONE;
 		}
 	case SIGTRAP | (PTRACE_EVENT_SECCOMP << 8):
+		/*
+		 * Once the tracer has skipped the system call, the stop is
+		 * reported as a PTRACE_SYSCALL_INFO_EXIT one, as the return
+		 * value might have overwritten the registers holding the
+		 * system call number and arguments.
+		 */
+		if (seccomp_ptrace_syscall_skipped(child))
+			return PTRACE_SYSCALL_INFO_EXIT;
 		return PTRACE_SYSCALL_INFO_SECCOMP;
 	default:
 		return PTRACE_SYSCALL_INFO_NONE;
@@ -1119,12 +1128,35 @@ ptrace_set_syscall_info_exit(struct task_struct *child, struct pt_regs *regs,
 	return 0;
 }
 
+/*
+ * Skip the system call at a PTRACE_SYSCALL_INFO_SECCOMP stop and set its
+ * return value as specified by info->exit.
+ *
+ * The skip request is passed to seccomp out of band instead of by setting
+ * the system call number to -1: on some architectures the syscall number,
+ * or the register seccomp reads it from, shares a register with the return
+ * value, and on others -1 cannot be represented as a syscall number.
+ */
+static int
+ptrace_set_syscall_info_seccomp_skip(struct task_struct *child,
+				     struct pt_regs *regs,
+				     struct ptrace_syscall_info *info)
+{
+	int ret = ptrace_set_syscall_info_exit(child, regs, info);
+
+	if (!ret)
+		seccomp_ptrace_skip_syscall(child);
+
+	return ret;
+}
+
 static int
 ptrace_set_syscall_info(struct task_struct *child, unsigned long user_size,
 			const void __user *datavp)
 {
 	struct pt_regs *regs = task_pt_regs(child);
 	struct ptrace_syscall_info info;
+	int op;
 
 	if (user_size < sizeof(info))
 		return -EINVAL;
@@ -1141,8 +1173,21 @@ ptrace_set_syscall_info(struct task_struct *child, unsigned long user_size,
 	if (info.flags || info.reserved)
 		return -EINVAL;
 
-	/* Changing the type of the system call stop is not supported yet. */
-	if (ptrace_get_syscall_info_op(child) != info.op)
+	op = ptrace_get_syscall_info_op(child);
+
+	/*
+	 * Changing the type of the system call stop is not supported, except
+	 * that a PTRACE_SYSCALL_INFO_SECCOMP stop can be turned into a
+	 * PTRACE_SYSCALL_INFO_EXIT one to skip the system call and set its
+	 * return value.  Once that is done, the stop is reported as a
+	 * PTRACE_SYSCALL_INFO_EXIT one, so only the return value can be
+	 * changed anymore during the same stop.
+	 */
+	if (op == PTRACE_SYSCALL_INFO_SECCOMP &&
+	    info.op == PTRACE_SYSCALL_INFO_EXIT)
+		return ptrace_set_syscall_info_seccomp_skip(child, regs, &info);
+
+	if (op != info.op)
 		return -EINVAL;
 
 	switch (info.op) {
-- 
2.47.3

