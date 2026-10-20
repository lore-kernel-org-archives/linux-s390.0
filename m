Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479428;
	b=TDK//GzdxoaU9tiKUW1NsnfpaVGwCxy2us2ia704uwOBsm/4iQ5v26496wTFdCn+j36W
	 YpsilPFdT1fSKFFX5pd+NZd3aHwk5lAdc55kRG1/cOOoaQgqhO8+q9MSWTvF4TUhYeegI
	 V5u6mI/jVYnkMV8G4uGSO3He4DAZlgmzFA/GOarIbn0moN4q2W24/k9E/wXmLXrWkY0b9
	 mOBSH7uiSvSnL9P1v53g5Hc1YLTFlhVNokRDFyhlzwkfI485At2kB+oYLYiXWErvsz5+z
	 gT0s/txXvsEV049Rm/hfTCj2JphCq67AscwOIexMgDMGQGCn/CVP1SRcpaXNdWSIBcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479428;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=X7li7zppPfXAQDWIziNGfnEjMbFeJImmkhr9aLqumbs=;
	b=jFYHR/5atvmd2Y4KVJ9zalqylVq1rN/4Omw+IFJPn6jhJHdWwaUmddrVbf4kXtMeUs1h
	 W4zAQD8PclVNLgMWoxmoGgkeQtURx5RP6YjuMeYSfpgKlHZrX2/zQYM5gfIBMYVHc1lnP
	 tZWg2KuaS5MAOZbVtm03kImLGYudMu2tK2kMGc0cz/WZ8TFNCcS6g1NC8vC85z3wan+oc
	 s9tuf8eK/Oc4lv0UM4U29/3B9IrtWd+novVSenundH+qt6T44kf1t2ScpMLKeORa491bP
	 mViyfQyY+qX81/dcmDnO6dzjI9p32BsiOPYkomOiPVieGI1S6gS9wZKVo3YsQw9PtyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=oZeAzt9L;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A81606A321;
	Tue, 20 Oct 2026 06:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A81606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=oZeAzt9L
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id C28E71C0251;
	Tue, 20 Oct 2026 08:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1792479420;
	bh=kecThFQauD5pORZjNAwNTrsBZzkWTRHw2R4hetODibc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oZeAzt9LAx7VhJ95rrODuBZq0TUfJxDYfDzhnRMVkLZgidLms+gqQ+yuahFM6mNtd
	 yZ3NCF/HcuRHTW3fSXxGYOnTadPqNd85XyJ0IOCQOtrHlBi6e3Ns1YOMedfnBv8fZh
	 VuaK6Hlki41GZHXsQheHgRRPKCNcY3ytcRhwl3+Y=
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Davide Berardi <berardi.dav@gmail.com>,
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
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	strace-devel@lists.strace.io,
	Renzo Davoli <renzo@cs.unibo.it>
Subject: [PATCH v8 1/3] seccomp: let the tracer skip a syscall independently of its number
Date: Tue, 20 Oct 2026 08:56:31 +0200
Message-ID: <20261020065635.490528-2-renzo@cs.unibo.it>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Davide Berardi <berardi.dav@gmail.com>

At a PTRACE_EVENT_SECCOMP stop the tracer can only skip the system call
by setting its number to -1, which seccomp reads back with
syscall_get_nr().  This depends on how each architecture lays out the
syscall number and the return value in the registers:

 - on some architectures the syscall number shares a register with the
   return value (e.g. v0 on MIPS), so setting the return value after the
   number would overwrite the skip request, and each of them needs its
   own way to keep it (MIPS keeps a copy of the number in thread_info);

 - on s390 syscall_get_nr() returns the low 16 bits of int_code, so -1
   is read back as 65535: seccomp does not skip the call but runs the
   filters again on syscall 65535, which kills the task if the filter
   denies unknown syscalls.

Add a per-task flag which the tracer sets with
seccomp_ptrace_skip_syscall() while the tracee is stopped at the
PTRACE_EVENT_SECCOMP stop, after it has set the return value.  When the
tracee resumes, seccomp skips the system call like for
SECCOMP_RET_ERRNO, which every architecture already handles without
touching the return value.

The flag is cleared by the tracee before the stop and written by the
tracer only while the tracee is stopped, so it needs no locking: the
wake-up of the tracee orders it like the registers written by the
tracer.

The next patch uses this in PTRACE_SET_SYSCALL_INFO.

Suggested-by: Michal Suchánek <msuchanek@suse.de>
Assisted-by: claude-opus-5-5
Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
---
 include/linux/seccomp.h       | 33 +++++++++++++++++++++++++++++++++
 include/linux/seccomp_types.h |  4 ++++
 kernel/seccomp.c              | 11 ++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index fcb3eb9825e5..ee31857f3ba6 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -75,6 +75,32 @@ static inline int seccomp_mode(struct seccomp *s)
 #ifdef CONFIG_SECCOMP_FILTER
 extern void seccomp_filter_release(struct task_struct *tsk);
 extern void get_seccomp_filter(struct task_struct *tsk);
+
+/**
+ * seccomp_ptrace_skip_syscall - make a tracee skip the current system call
+ * @tsk: tracee stopped at a PTRACE_EVENT_SECCOMP stop
+ *
+ * Must only be called by the tracer of @tsk while @tsk is stopped at a
+ * PTRACE_EVENT_SECCOMP stop, after it has set the return value of the system
+ * call.  When the tracee resumes, the system call is skipped and the return
+ * value is left untouched, like with SECCOMP_RET_ERRNO.
+ */
+static inline void seccomp_ptrace_skip_syscall(struct task_struct *tsk)
+{
+	tsk->seccomp.ptrace_skip = true;
+}
+
+/**
+ * seccomp_ptrace_syscall_skipped - check for seccomp_ptrace_skip_syscall()
+ * @tsk: tracee stopped at a PTRACE_EVENT_SECCOMP stop
+ *
+ * Return: true if the tracer requested to skip the system call during the
+ * current PTRACE_EVENT_SECCOMP stop of @tsk.
+ */
+static inline bool seccomp_ptrace_syscall_skipped(struct task_struct *tsk)
+{
+	return tsk->seccomp.ptrace_skip;
+}
 #else  /* CONFIG_SECCOMP_FILTER */
 static inline void seccomp_filter_release(struct task_struct *tsk)
 {
@@ -84,6 +110,13 @@ static inline void get_seccomp_filter(struct task_struct *tsk)
 {
 	return;
 }
+static inline void seccomp_ptrace_skip_syscall(struct task_struct *tsk)
+{
+}
+static inline bool seccomp_ptrace_syscall_skipped(struct task_struct *tsk)
+{
+	return false;
+}
 #endif /* CONFIG_SECCOMP_FILTER */
 
 #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
diff --git a/include/linux/seccomp_types.h b/include/linux/seccomp_types.h
index cf0a0355024f..4bdb8424055b 100644
--- a/include/linux/seccomp_types.h
+++ b/include/linux/seccomp_types.h
@@ -18,11 +18,15 @@ struct seccomp_filter;
  *
  *          @filter must only be accessed from the context of current as there
  *          is no read locking.
+ * @ptrace_skip: set by the tracer while the task is stopped at a
+ *               PTRACE_EVENT_SECCOMP stop to request that the system call is
+ *               skipped, after it has set the return value.
  */
 struct seccomp {
 	int mode;
 	atomic_t filter_count;
 	struct seccomp_filter *filter;
+	bool ptrace_skip;
 };
 
 #else
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 86cf4460d69e..edeb21fa3e23 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1306,6 +1306,7 @@ static bool __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		}
 
 		/* Allow the BPF to provide the event message */
+		current->seccomp.ptrace_skip = false;
 		ptrace_event(PTRACE_EVENT_SECCOMP, data);
 		/*
 		 * The delivery of a fatal signal during event
@@ -1319,7 +1320,15 @@ static bool __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		 */
 		if (fatal_signal_pending(current))
 			goto skip;
-		/* Check if the tracer forced the syscall to be skipped. */
+		/*
+		 * Check if the tracer forced the syscall to be skipped, either
+		 * with seccomp_ptrace_skip_syscall(), which does not depend on
+		 * how the architecture encodes the syscall number and the
+		 * return value in the registers, or by setting the syscall
+		 * number to -1.
+		 */
+		if (current->seccomp.ptrace_skip)
+			goto skip;
 		this_syscall = syscall_get_nr(current, current_pt_regs());
 		if (this_syscall < 0)
 			goto skip;
-- 
2.55.0

