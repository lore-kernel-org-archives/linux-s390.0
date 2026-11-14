Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794680384;
	b=b879PSpsWlTo4GxJJcU8Qfj5tE+64+IexI8iOMF3JKl3kJE0mac8SGy8Ouy/n4iDaKsI
	 mxGTSDJGzZeUZm3/7zvzV+/GCb1c1yTtYK2lJjzs9DbDWAYWirKdjI2c9e2+E4ZAeLXPB
	 hSXqCr6iGhIqs9gwkaDFMMALr3pO9MjTjYlcBccoFiLpf6kpJ5YVDApoGG38/jmiuxBqX
	 xOsiQ5KN5b2FVjIae+S2ADnSp6cMlZ8Pv+Jc0Pcf5+zGtXhMkO/YRYE4+6V5LHSidSLST
	 +O5rN+Y4nQ0J/SO4GDG7BSqKpBXTzpma3Fsbb1KH1mQvVrigCN+c3Nwb5uE9X39puPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680384;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IEN6DMmQ7DzcccVgC+QAOPS2C8pTq6JAPLeqeTnDenE=;
	b=bfcSiHQvEPYKTa38EiOQ6eJYU2yATeA7o9T2chTbvjCRwT7o+xTA8fdRGjqwxl1BE68l
	 QKcehn3QjIswdba+sVFBjc47vYjoX4B9KmGdrqypJSKjZ5Tr0saHXDx2Y6ZXDLbd0kywB
	 Wv27UsmVGb+cLIiVqfDUsV6/gMxleILRCZK9fEX7pxifHNENNOkqdz0KTdBlhbEENlqAj
	 9qShhVG5DWyyz2tk6qGPoPLye5uT/SZ0DMB9UJs/pTV8XVGuIa7+WeZuTN+vKEZ5yjZBO
	 oL91GXe20l7KJnSPx+JqM81UZJhwojXH9N8F4nvWdmCg4AcuMY/OOBa7GEx3uKBQDbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=QQcmgZIM;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7DC606A331;
	Sat, 14 Nov 2026 18:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C7DC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=QQcmgZIM
Received: from eipi10.cs.unibo.it (host0.studiodavoli.it [109.234.61.1])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 1FAB31C025B;
	Sat, 14 Nov 2026 19:19:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1794680376;
	bh=Y/wiJwTpddm1xSyZCLed0jyYCYmsGZG6L6nJZ7ZUclc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQcmgZIM4eUKQaJmmxs7LkgSkcXAbxRoaW587WOysJrhwn5shxypf+lmjo3PI0FrC
	 bXY6+ieOqfZhbLMf3aCN5DLhzgZyc0XqC6GPkl0zILAJaj4tyWcj8PEDcVUjoeMk3J
	 5qg7f0cnUNvFlmmkqm0SymqCk9Sm7tuiIp4XeOMU=
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
Subject: [PATCH v11 1/3] seccomp: let the tracer skip a syscall independently of its number
Date: Sat, 14 Nov 2026 19:19:20 +0100
Message-ID: <20261114181923.370930-2-renzo@cs.unibo.it>
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
index 3b6cc376fff5..0dd0a6960e96 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -76,6 +76,32 @@ static inline int seccomp_mode(struct seccomp *s)
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
@@ -85,6 +111,13 @@ static inline void get_seccomp_filter(struct task_struct *tsk)
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
index 3eecba5ccdef..31a7772ebb7d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1314,6 +1314,7 @@ static bool __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		}
 
 		/* Allow the BPF to provide the event message */
+		current->seccomp.ptrace_skip = false;
 		ptrace_event(PTRACE_EVENT_SECCOMP, data);
 		/*
 		 * The delivery of a fatal signal during event
@@ -1327,7 +1328,15 @@ static bool __seccomp_filter(int this_syscall, const bool recheck_after_trace)
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
2.47.3

