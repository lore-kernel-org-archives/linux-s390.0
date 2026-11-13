Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588929;
	b=wh2EdPMI4VLjQP2x+aFf6s4niquMeebOKEltehuX96LeroX5r1vDUMSGep41alybLSzt
	 OnBHdpixSI+pYC0VbvA7kRCmuvpOG9e3/TK0unCSs++QY2tzRFJwjDwiQ0Nm72kxU2y1p
	 17mepLPTK0Nt3umGIqYLylLnGrVu7/PprnoD2aEK3gx0NoHotszPGT07zRo5SNwZCotbk
	 2T5ThwHMzVDwNFY8V1FAGC8oHAcELOeeS5tcgFJYpCioVaHyPPrsNadPov8fu7elcRhpf
	 fyOm/tEVOj6o25IUdMHxLG22mBz5xRU09C7etlVLPzWBiAp0iCq18RYTsGvBypaCZ6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588929;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=71rB/jeQ4Dqg3UoF5AV9mpnYgAhLE4wiM6MLTcN/nLo=;
	b=Az5q5b0knF3tAtpbDyos1BfxaqdGzaKzntC3jlEVRIVw57CsZe95N2SifAhVKc0PpY5v
	 yFwhrJGS2PiWHPAVGNeOMSCejvXE0+iUtG+umRaZL3M1Pmc6Qe6/BF0YYMRgZgc4ydkm9
	 Q58Hj4LaZKdmHjKoqkuYk+X5m5WTf6zR+W8da1k9OsSaOAQpuo7rvjcrSmMKuZFa33CWf
	 rLMiw6HSEoy5QWN7X96JwA6/O73mtRstuqnvs3CEKtc/BuZy7is6UUVSMqt6VibQf3lEj
	 1NzlOuyjIEuppBiAxTq5KG6zi14NaPtGJwPa1qIYKMfw/JxauUhCM7YMgOgdupxO31A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=rw5OK60f;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FBD606A89A;
	Fri, 13 Nov 2026 16:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65FBD606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=rw5OK60f
Received: from eipi10.cs.unibo.it (host0.studiodavoli.it [109.234.61.1])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id AB6401C025B;
	Fri, 13 Nov 2026 17:55:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1794588921;
	bh=SChBcdrJlogBMXg3d4rRZsXyKf0PIZtbwEr5Ng5xtEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rw5OK60fhD5pJRyqzG3XRwUi1bFm9DE7Oy9RcM6h5Yx/92yBYXcnxd7SHV/uIah48
	 Wj88gHdjDeJeO8ZOV3+AzLfV6pr4amr8GDzY10IvJT3ZzXtJoAaVxo42CxDwXYotFU
	 Wz3lFtLSBIKOIoUJ/f0VjXOElGReMT0s78kwTiSY=
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
Subject: [PATCH v10 1/3] seccomp: let the tracer skip a syscall independently of its number
Date: Fri, 13 Nov 2026 17:55:03 +0100
Message-ID: <20261113165509.229869-2-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113165509.229869-1-renzo@cs.unibo.it>
References: <20261113165509.229869-1-renzo@cs.unibo.it>
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
2.55.0

