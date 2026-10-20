Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479430;
	b=OWcl3rlC24qnrvIRZeELi4WwJ6ZHVYyzLmOlx7DYL5CPeVAx/PNGoklOk7xyyYb57Wqg
	 FtdgqG55AdLjpR5AUQtPWMri8Cuss98Sz2Pxs6UhuffUeltHTVFySwCHZkzGESidCrXGb
	 ZHgSW7Rq7WlGTdBT4JOkyFzz02d6KSfxVBSL22ZE2MQrYE/hVC0zJ0KUlm2BYmQNJMrU+
	 PM60NidJtoTMrcvGU/wXkadFWjjJhspzgxAPfDcWc9r4CFRPYsMgMb19jELJU6/V/2ytK
	 9irvk/MaheEVU+ujDoJBybZ+Lw5C5uZOg961KQKQrA4Mx3x6LfZMQH8z82LJ+j737Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479430;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TUmyFYYtU5y2RV1uj+bzgwDMTfwhMJbH7+T2VkwKhwg=;
	b=lLxDVdSFO2TWXh+02jKqAKtub8PfvXcXP75b7bmf165HaP3mVM1krUCaOg8ZfQN5VPjx
	 +mYBpZnIr5E2lKGPvWZrFJ106YT7Qen3/4H+OTfNhbOe24Qi1nugAXAz5rxizqrHClunO
	 jdid6GrYdJfPwU3ncC0GuyXfwE1VmlmsVzwuNbtacc6QzNerMJ02++lVn30H1RTewS8AD
	 6PSnLCmZoU/ZEWMLUj4i01worHN7oOeYmGgHmtpirnbSlhthpNMD3dWXh8tLVJNAz2lsl
	 1vtkPdXCbE7rvmyChoYuGLgGHZLbJbe/rHcBtVRx+g1DdSz5ZjZG/DG0juowN8Jo3Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b="aD/pTPV3";
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D006A606A332;
	Tue, 20 Oct 2026 06:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D006A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=aD/pTPV3
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 30FFE1C025A;
	Tue, 20 Oct 2026 08:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1792479421;
	bh=GKcVaiJ2uWs3/U/oO7CqqD6I8S0OT2zFALYg4nGKvh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aD/pTPV3X+R7HoHeYW+R6GsVuGiIZQ+RS8fuyuaJ3Z66tJBMmtZ888SJgY8IkG+vP
	 +i9TEB2JutNl7Sxw3rCnCEUr6Q+pznvoNYp07GybDQ5uDFr4lWQqswsE8NcGrkd6h9
	 7YzISdSOjEDeHY2a3YjQf76Id09ytT9PZUf4Fhj8=
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
Subject: [PATCH v8 2/3] ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
Date: Tue, 20 Oct 2026 08:56:32 +0200
Message-ID: <20261020065635.490528-3-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020065635.490528-1-renzo@cs.unibo.it>
References: <20261020065635.490528-1-renzo@cs.unibo.it>
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

Once the system call has been skipped, a further PTRACE_SET_SYSCALL_INFO
with op == PTRACE_SYSCALL_INFO_SECCOMP during the same stop fails with
-EINVAL, as the return value may already have overwritten registers
holding the syscall number or arguments; op ==
PTRACE_SYSCALL_INFO_EXIT can still be used to change the return value.

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
Assisted-by: claude-opus-5-5
---
 kernel/ptrace.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d041645d9d17..e02434c30d4e 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -34,6 +34,7 @@
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
 #include <linux/syscall_user_dispatch.h>
+#include <linux/seccomp.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -1119,12 +1120,35 @@ ptrace_set_syscall_info_exit(struct task_struct *child, struct pt_regs *regs,
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
@@ -1141,8 +1165,25 @@ ptrace_set_syscall_info(struct task_struct *child, unsigned long user_size,
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
+	 * return value.  Once that is done, the system call number and
+	 * arguments cannot be changed anymore during the same stop, as the
+	 * return value might share registers with them.
+	 */
+	if (op == PTRACE_SYSCALL_INFO_SECCOMP) {
+		if (info.op == PTRACE_SYSCALL_INFO_EXIT)
+			return ptrace_set_syscall_info_seccomp_skip(child, regs,
+								    &info);
+		if (seccomp_ptrace_syscall_skipped(child))
+			return -EINVAL;
+	}
+
+	if (op != info.op)
 		return -EINVAL;
 
 	switch (info.op) {
-- 
2.55.0

