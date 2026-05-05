Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C783C140F;
	Tue,  5 May 2026 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003985; cv=none; b=IPjsBEc2JgmjV9g5JbSfbp+xGmuuckmv0Bxs4gusRyFIpkIztqd1+0f3AQ1cqhx9v9/JloyOho6i+Vbhv44LuPif2QZZ8ju67YH4FI2z1zNHKodPhMGBEjPKg8ImGwnqzPLwb8aWro7l6sPdC/3lwIiYJT3DIQkF38MJkLQwRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003985; c=relaxed/simple;
	bh=gD66kznneqSBjDfNvHtEYbGQhZNTMG6YArmooZ1UIok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH/T6crCF3fbTm3qn+Jl8ycTGFwFwoJF7QTt6QSAO/f4JyyBYBoBtDu11MPyKC+6TAy0L5bwsXKtmU4nxB+OoWGAP+77mDQuSEiaPuterCQ08Mn0DwSb1IxDJ12J+LMoM0vTCtO+fs4wZqePImpshEZy+/86l2E127PtJRRH7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw0GIQOe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw0GIQOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9ADC2BCB4;
	Tue,  5 May 2026 17:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778003984;
	bh=gD66kznneqSBjDfNvHtEYbGQhZNTMG6YArmooZ1UIok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xw0GIQOeVJKuVxm/2obhNmP0Vzf5X+/XEAP8lLR4hlRrx3FpBBW9jCg5g1Nz1ljQg
	 ZSSGhSTdPgxrL2FHsrG/90MDiyFJqmtPow98ZEkYG+ro8XHrCv9IBe55HfvhscA7jg
	 J1izjdeeyzPa6wbLYR+zkVuV6grokvRZWzW7GXZrL+xyVyrYWhjnixGz76owSb4B1k
	 iLOSg2oI9w5xOKFrlnSypJOm1mnq0/xbq/ZTKv7gTMMx/h+ksmMnAFOFD7k171Uwf7
	 ARwaiPcufZNhHDU52c2nxtyVa7ULIMrAJMxY8n4UkldNV9I4j1WCpc0AHT4DiUpAD0
	 cXZ58NVo+3aVw==
Date: Tue, 5 May 2026 10:59:43 -0700
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <afowD31YsGVdVUBP@google.com>
References: <20260429211359.3829683-1-minchan@kernel.org>
 <afMnKrYT0xG_a-b3@tiehlicka>
 <afUYfpwWsUQoB9hz@google.com>
 <afhQB0CWEcflXpOi@tiehlicka>
 <20260505-wegbleiben-deshalb-f929089dbdab@brauner>
 <afoUt3te1k2TNao-@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afoUt3te1k2TNao-@tiehlicka>

On Tue, May 05, 2026 at 06:03:03PM +0200, Michal Hocko wrote:
> On Tue 05-05-26 11:30:22, Christian Brauner wrote:
> > IIUC, then the OOM kill if invoked from the kernel just takes down
> > without permission checking what it wants to take down. That makes a lot
> > of sense and is mostly safe - after all it is the kernel that initiates
> > the kill.
> > 
> > However, when userspace initiates the kill we need at least the
> > semantics you proposed, Michal. You can only kill processes that you
> > have the necessary privileges over otherwise you end up allowing to
> > SIGKILL setuid binaries over which you hold no privileged possibly
> > generating information leaks or worse.
> 
> Agreed!
> 
> > The other thing to keep in mind is that currently pidfds explicitly do
> > not to allow to signal taks that are outside of their pid namespace
> > hierarchy - see pidfd_send_signal()'s permission checking. I don't want
> > to break these semantics - it's just very bad api design if signaling
> > suddenly behaves differently and pidfd suddenly convey the ability to
> > do a very wide signal scope.
> 
> Agreed!
> 
> > The other thing is that pidfds are handles that can be sent around using
> > SCM_RIGHTS which means they could be forwarded to a container or another
> > privileged user that then initiates kill semantics.
> > 
> > The other thing is that the type of pidfd selects the scope of the
> > signaling operation:
> > 
> > * If the pidfd was created via PIDFD_THREAD then the scope of the signal
> >   is by default the individual thread - unless the signal itself is
> >   thread-group oriented ofc.
> > 
> > * If the pidfd was created wihout PIDFD_THREAD then the scope of the
> >   signal is by default the thread-group.
> > 
> > * pidfd_send_signal() provides explicitly scope overrides:
> > 
> >   (1) PIDFD_SIGNAL_THREAD
> >   (2) PIDFD_SIGNAL_THREAD_GROUP
> >   (3) PIDFD_SIGNAL_PROCESS_GROUP
> > 
> >   The flags should be mostly self-explanatory.
> > 
> >   So I really dislike the idea of now letting the pidfd passed to
> >   process_mrelease() to have an implicit scope suddenly. The problem is
> >   that this is very opaque to userspace and introduces another way to
> >   signal a group of processes.
> 
> I do see your point. Unfortunately the whole concept of mm shared
> across thread (signal) groups is not fitting well into the overall
> model. For the most usecases this is not a big problem. But oom handlers
> do care. If you do not kill all owners of the mm you are not releasing
> any memory.
> 
> > IOW, I still dislike the fact that process_mrelease() is suddenly turned
> > into a signal sending syscall and I really dislike the fact that it
> > implies a "kill everything with that mm and cross other thread-groups".
> > 
> > I wonder if you couldn't just add PIDFD_SIGNAL_MM_GROUP or something to
> > pidfd_send_signal() instead.
> 
> That would be a clean interface for sure. The thing we are struggling
> here is not just the killing side of things but also grabbing the mm
> before it disappears which is the primary reason why process_mrelease is
> turning into signal sending syscall (which you seem to be not in favor
> of).
> 
> So I can see these options on the table
> 1) keep process_mrelease as is and live with the race. This sucks
> because it makes userspace low memory (oom) killers harder to predict.
> 2) we add the proposed option to kill&release into process_mrelease that
> is not aware of shared mm case. This sucks because it creates an easy
> way to evade from the said oom killer
> 3) same as 2 but add PIDFD_SIGNAL_MM_GROUP that would do the right thing
> on the signal handling side. You seem to like the idea from the
> pidfd_send_signal POV but I am not sure you are OK with that being
> implanted into process_mrelease.

For 3, maybe something likle this?
(Just to show the concept for further discussion)

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
2.54.0.545.g6539524ca2-goog



