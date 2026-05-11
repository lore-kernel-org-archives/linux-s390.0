Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84ED4D90D8
	for <linux-s390@vger.kernel.org>; Mon, 11 May 2026 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535756; cv=none; b=Ot6YUUogWvG7hfG10gJIBRrawLl8rpn6in0Weks6Iny5gAFVSVU5gs8zwh4iSQkLFeCc0j7cW0NeY0I8Xyodbtai3PJXOJ3guC9yFXdf7AIxen4EjsvivBfHLx8O7XBPVsQHc4WkJ8Prr97k0tUuuMBD5qTgXRE4D2WzlzesYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535756; c=relaxed/simple;
	bh=3PzUwrYt75RUBaa5ANoAdAke6fYmSgjan4PXXAsMM+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCxFITTKUUqNMJxWLmIMDU94NlNYKwT3+RS7f0DmZyTshOopjf/U3ye51Y+KGzvGS+V/6DDEIn1iw1rEcmNJylJxG/T/5pzLME7Hw0iJHmAErAVV88zTOK59xYAlESKlBCe7SNsocD6/Or3ZMOs/X73WuuelqsFSYLUGiQgsYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQdKVA8n; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQdKVA8n"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so13065918eec.1
        for <linux-s390@vger.kernel.org>; Mon, 11 May 2026 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778535754; x=1779140554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=d+UgRnX2o/IheCI05ApznuIAinSPW5zogwfT5DaF5pU=;
        b=DQdKVA8nC8NzGdjOnCQyLtIrzWA6MkmUJOhFf1Mt71zg90HmooMtcRbiomHg1jBgwA
         zq7vmJPKxS48YmQk+C0xM6sXhzgXD5+Qhiflxu73TNS48e0FFePs40Bm/c3cuGAFIu5D
         t59V1qKVPvvK2v7mqq14CS4vZkuSvpRvZPwfMyK7Viw33iVN8ngBF0jY1kLuluTK+2bm
         HeaIDUJeazYE4j9g1kobg3c6DkWcjjs9hI9qJCwOv6Ltn32UTRTp71ao7uqILKo6AACI
         H0jCRhIhlOSyZvGKAZ5+f3ZkWhs4NbBZn78Z11lU9k2cyupkQI7MWd0O1/1WqQHxbsh8
         CpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535754; x=1779140554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+UgRnX2o/IheCI05ApznuIAinSPW5zogwfT5DaF5pU=;
        b=c02iaixKOFCVnJzrFuqte6VuYBpFale7tYy2jjpvS5zoT8SKFScjSVe6S+6ern9ukZ
         vHOB4UReJyjRPrYQL+Px53blYcfVBlsak3misaaAxmjuHznSqj6H2GCEfp5T8aNbyzZ2
         jd8O2ezLKNCGsNreqS+3x0dmhQMYqlKBwBoNTFU/YG81tr3eWf8eUqcy/muQVyHSTQKN
         mK2lcP+IF85Rj2ayZXEJUJEQ+oDt0qwxQpAZMQYqisaMKKeDP+DnIK5BcX7kRFvFHHGJ
         VdaTMQNuaJYHozrlCquPVT/CQZcPShjJxCkPWV+4DMxWgJVYfyIXqALWq5k0D/uNvVTR
         qv0w==
X-Forwarded-Encrypted: i=1; AFNElJ8AkR1xKGo1KUa9xC5yehEl5SF2Q4eMq3XYm0jokcXVsMYBWansN/J97KiBNtckNHQNGFU8IsavGHC0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2E5CLc1Me9LsF3NQNa4kjhDgIkK/nSL/vavn1E2gXG9XjPQwH
	qUy2Ou2V+KKYzv6AprjrC/Eg76hKaPeZAtu9u1uHiQ3x9/MACPWlIQe3A8SevA==
X-Gm-Gg: Acq92OGc88wIa+jCB2e3G+Q8FP4jpPSskbIyMmMU0gCoi5b/f1pFazteJhZmcphplh5
	+N57BEvBjxPhvwTIITmzfY8gQ7280U8qviPjS8yoW7XDJlnNUP5ZRk+SYVRs36u8CzTKt6At16T
	0Sf6ZEGJ3NA/Mdnfd30Hv+xG/rAzRlaEQKaBBroS6cbW3dIlEFRAPxNF1/A5u3edMFSfGrKNJqd
	AbLGnZfdMS3yS+mzu/snFtwOMRCuVIBC9k7oM/ud4yhYdZzzwGjWLuNw7sxfKLJ2FeV9xw+gSrZ
	ETvjZrdRkT1H5X7pqYxvWDeyWvXVrNCO6iArZWIkHRFU7VR8V5JhIT9lElv6ccBJFjT9Do1d/hE
	94AnqVOFM2n4vhZXEiyTK6FiJNDAAz8vcyKVYF8mHsllP2jXeDRj6AQSuliX9pVnlm95uai9+15
	sozOO6Bm8dWPg8Y1tvG0y3EJX0pE6Mw9tockR4ROu96RjYrKgoMapW71BtQYy8PlEkYS466DBzV
	LSX
X-Received: by 2002:a05:7300:641d:b0:2e6:e868:4f38 with SMTP id 5a478bee46e88-2f54ad7251fmr13440980eec.3.1778535753506;
        Mon, 11 May 2026 14:42:33 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2a00:79e0:2e7c:8:9727:409b:8acc:c2d2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafacsm15057543eec.1.2026.05.11.14.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:42:32 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
To: akpm@linux-foundation.org
Cc: hca@linux.ibm.com,
	linux-s390@vger.kernel.org,
	david@kernel.org,
	mhocko@suse.com,
	brauner@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	surenb@google.com,
	timmurray@google.com,
	Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL flag
Date: Mon, 11 May 2026 14:42:26 -0700
Message-ID: <20260511214226.937793-1-minchan@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, process_mrelease() requires userspace to send a SIGKILL signal
prior to invocation. This separation introduces a scheduling race window
where the victim task may receive the signal and enter the exit path
before the reaper can invoke process_mrelease().

When the victim enters the exit path (do_exit -> exit_mm), it clears its
task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
leaving the actual address space teardown (exit_mmap) to be deferred until
the mm's reference count drops to zero. In the field (e.g., Android),
arbitrary reference counts (reading /proc/<pid>/cmdline, or various other
remote VM accesses) frequently delay this teardown indefinitely,
defeating the purpose of expedited reclamation.

In Android's LMKD scenarios, this delay keeps memory pressure high, forcing
the system to unnecessarily kill additional innocent background apps before
the memory from the first victim is recovered.

This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
an integrated auto-kill mode. When specified, process_mrelease() directly
injects a SIGKILL into the target task after finding its mm.

To solve the race condition, we grab the mm reference via mmgrab() before
sending the SIGKILL. If the user passed PROCESS_MRELEASE_REAP_KILL, we assume
it will free its memory and proceed with reaping, making the logic as simple
as reap = reap_kill || task_will_free_mem(p).

To handle shared address spaces, we deliver SIGKILL to all processes sharing
the same address space using do_pidfd_send_signal_pidns(). This ensures the
target pid resides inside the caller's PID namespace hierarchy prior to
signal delivery. We iterate over all processes sharing the mm and deliver
SIGKILL to each. If delivering the signal to any of the sharing processes
fails, we return an error. Note that this approach may leave partial
side-effects if some processes are killed successfully before a failure occurs.

Cc: Christian Brauner <brauner@kernel.org>
Suggested-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/signal.h    |  4 +++
 include/uapi/linux/mman.h |  4 +++
 kernel/signal.c           | 29 ++++++++++++++++++---
 mm/oom_kill.c             | 55 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index f19816832f05..bdbe6b3addec 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -276,6 +276,8 @@ static inline int valid_signal(unsigned long sig)
 
 struct timespec;
 struct pt_regs;
+struct mm_struct;
+struct pid;
 enum pid_type;
 
 extern int next_signal(struct sigpending *pending, sigset_t *mask);
@@ -283,6 +285,8 @@ extern int do_send_sig_info(int sig, struct kernel_siginfo *info,
 				struct task_struct *p, enum pid_type type);
 extern int group_send_sig_info(int sig, struct kernel_siginfo *info,
 			       struct task_struct *p, enum pid_type type);
+extern int do_pidfd_send_signal_pidns(struct pid *pid, int sig, enum pid_type type,
+				      siginfo_t __user *info, unsigned int flags);
 extern int send_signal_locked(int sig, struct kernel_siginfo *info,
 			      struct task_struct *p, enum pid_type type);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index e89d00528f2f..4266976b45ad 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -56,4 +56,8 @@ struct cachestat {
 	__u64 nr_recently_evicted;
 };
 
+/* Flags for process_mrelease */
+#define PROCESS_MRELEASE_REAP_KILL	(1 << 0)
+#define PROCESS_MRELEASE_VALID_FLAGS	(PROCESS_MRELEASE_REAP_KILL)
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/kernel/signal.c b/kernel/signal.c
index d65d0fe24bfb..b2dc08a9bdd3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4046,6 +4046,30 @@ static int do_pidfd_send_signal(struct pid *pid, int sig, enum pid_type type,
 	return kill_pid_info_type(sig, &kinfo, pid, type);
 }
 
+/**
+ * do_pidfd_send_signal_pidns - Send a signal to a process via its struct pid
+ *                              while validating PID namespace hierarchy.
+ * @pid:   the struct pid of the target process
+ * @sig:   signal to send
+ * @type:  scope of the signal (e.g. PIDTYPE_TGID)
+ * @info:  signal info payload
+ * @flags: signaling flags
+ *
+ * Verify that the target pid resides inside the caller's PID namespace
+ * hierarchy prior to signal delivery.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int do_pidfd_send_signal_pidns(struct pid *pid, int sig, enum pid_type type,
+			       siginfo_t __user *info, unsigned int flags)
+{
+	/* Enforce PID namespace hierarchy boundary */
+	if (!access_pidfd_pidns(pid))
+		return -EINVAL;
+
+	return do_pidfd_send_signal(pid, sig, type, info, flags);
+}
+
 /**
  * sys_pidfd_send_signal - Signal a process through a pidfd
  * @pidfd:  file descriptor of the process
@@ -4094,16 +4118,13 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		if (IS_ERR(pid))
 			return PTR_ERR(pid);
 
-		if (!access_pidfd_pidns(pid))
-			return -EINVAL;
-
 		/* Infer scope from the type of pidfd. */
 		if (fd_file(f)->f_flags & PIDFD_THREAD)
 			type = PIDTYPE_PID;
 		else
 			type = PIDTYPE_TGID;
 
-		return do_pidfd_send_signal(pid, sig, type, info, flags);
+		return do_pidfd_send_signal_pidns(pid, sig, type, info, flags);
 	}
 	}
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5c6c95c169ee..253aa80770f2 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -20,6 +20,7 @@
 
 #include <linux/oom.h>
 #include <linux/mm.h>
+#include <uapi/linux/mman.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
@@ -925,6 +926,39 @@ static bool task_will_free_mem(struct task_struct *task)
 	return ret;
 }
 
+/*
+ * kill_all_shared_mm - Deliver SIGKILL to all processes sharing the given address space.
+ * @victim: the targeted OOM process group leader
+ * @mm:     the virtual memory space being reaped
+ *
+ * Traverse all threads globally and signal any user processes sharing the identical
+ * mm footprints, ensuring no concurrent users pin the memory. Skips the system
+ * global init and kernel worker threads.
+ */
+static int kill_all_shared_mm(struct task_struct *victim, struct mm_struct *mm)
+{
+	struct task_struct *p;
+	bool failed = false;
+
+	rcu_read_lock();
+	for_each_process(p) {
+		if (!process_shares_mm(p, mm))
+			continue;
+		if (is_global_init(p)) {
+			failed = true;
+			continue;
+		}
+		if (unlikely(p->flags & PF_KTHREAD))
+			continue;
+
+		if (do_pidfd_send_signal_pidns(task_pid(p), SIGKILL, PIDTYPE_TGID, NULL, 0))
+			failed = true;
+	}
+	rcu_read_unlock();
+
+	return failed ? -EBUSY : 0;
+}
+
 static void __oom_kill_process(struct task_struct *victim, const char *message)
 {
 	struct task_struct *p;
@@ -1217,9 +1251,11 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	unsigned int f_flags;
 	bool reap = false;
 	long ret = 0;
+	bool reap_kill;
 
-	if (flags)
+	if (flags & ~PROCESS_MRELEASE_VALID_FLAGS)
 		return -EINVAL;
+	reap_kill = !!(flags & PROCESS_MRELEASE_REAP_KILL);
 
 	task = pidfd_get_task(pidfd, &f_flags);
 	if (IS_ERR(task))
@@ -1236,19 +1272,24 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	}
 
 	mm = p->mm;
-	mmgrab(mm);
 
-	if (task_will_free_mem(p))
-		reap = true;
-	else {
+	reap = reap_kill || task_will_free_mem(p);
+	if (!reap) {
 		/* Error only if the work has not been done already */
 		if (!mm_flags_test(MMF_OOM_SKIP, mm))
 			ret = -EINVAL;
+		task_unlock(p);
+		goto put_task;
 	}
+
+	mmgrab(mm);
 	task_unlock(p);
 
-	if (!reap)
-		goto drop_mm;
+	if (reap_kill) {
+		ret = kill_all_shared_mm(task, mm);
+		if (ret)
+			goto drop_mm;
+	}
 
 	if (mmap_read_lock_killable(mm)) {
 		ret = -EINTR;
-- 
2.54.0.563.g4f69b47b94-goog

