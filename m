Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AF31B83B;
	Tue, 28 Apr 2026 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415879; cv=none; b=iauUXZe4Y1djAWE4ZKHt5FEyailJJ1Z7zbhTRh/+HApzc5KBUIF9v9dkjxbW7aqO8EjF59TwY8LwPDmP5Iw2cEkLihQr7oQpASGRyfspx1mt1Ltj5S6b7o1BLSGLnYG4HJg/72ePgcGQkazCzC9o6iwMLCNMc/fRvLU3c8bUkxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415879; c=relaxed/simple;
	bh=6yRAJ6iKr3kWjPNrlXKo2X48nCi0v4xhOisZi6+X9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9gowZ77aEkHiGSNCR/mrKmByCNlM1XEUWXaLjZxVRtjx02/p/mahkVCUU4RdaA9Kc4samU97WafVNFdMV2MFZ6UFOlEfyld8ABny/5TLXKz8ByOC5S4GVzKyhgsjPN8yS/2ojB9z4sBcD9goWVkcXyzEYZ0Z3ci0nEUa6zynjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9lMM1oN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9lMM1oN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA86C2BCAF;
	Tue, 28 Apr 2026 22:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777415879;
	bh=6yRAJ6iKr3kWjPNrlXKo2X48nCi0v4xhOisZi6+X9Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9lMM1oNq3qzKjp7GY4B2074nR2F/0prN+EBu2ms++hexCEzZyNwPlQNUSQty5Lcx
	 DDToVvh8kd35vB0U5nOlwhnEr/h9VEVBwFdX+kw7YoZW3sefo3xDnmMEvEywYTTBaP
	 lrUmNWhwbtfTzS3mG9ecYobmHI5OHtkMvdO3K6VDoO7ML4noNXx3A6RyGjaNShuSYo
	 3lOuzzKWvJVIQg/YCQ7GiRVHfM5UbKzEQehvJu6gqYEcsllRHIyBSPVHiJN9FV6DHo
	 /Fqd1PEk3LUZ/OOV0QoPTjFt+TcFzIQQmBG3ZPPR7HewVMzs1JojmWjbi4T5TC0ANX
	 d13PEytDpiGtw==
Date: Tue, 28 Apr 2026 15:37:57 -0700
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 3/3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <afE2xchFRh2xARBn@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-4-minchan@kernel.org>
 <aesiYAumkLCyedf0@tiehlicka>
 <aevzbx_Pk5Cu5exa@google.com>
 <ae8KD_Tq0t7RvUy1@tiehlicka>
 <ae_dRZ95dCDTTxaQ@google.com>
 <afBbRUaGnE8WZIkY@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afBbRUaGnE8WZIkY@tiehlicka>

On Tue, Apr 28, 2026 at 09:01:25AM +0200, Michal Hocko wrote:
> On Mon 27-04-26 15:03:49, Minchan Kim wrote:
> > On Mon, Apr 27, 2026 at 09:02:39AM +0200, Michal Hocko wrote:
> > > On Fri 24-04-26 15:49:19, Minchan Kim wrote:
> > > > On Fri, Apr 24, 2026 at 09:57:20AM +0200, Michal Hocko wrote:
> > > > > On Tue 21-04-26 16:02:39, Minchan Kim wrote:
> > > > > > Currently, process_mrelease() requires userspace to send a SIGKILL signal
> > > > > > prior to the call. This separation introduces a scheduling race window
> > > > > > where the victim task may receive the signal and enter the exit path
> > > > > > before the reaper can invoke process_mrelease().
> > > > > > 
> > > > > > When the victim enters the exit path (do_exit -> exit_mm), it clears its
> > > > > > task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
> > > > > > leaving the actual address space teardown (exit_mmap) to be deferred until
> > > > > > the mm's reference count drops to zero. In Android, arbitrary reference counts
> > > > > > (e.g., async I/O, reading /proc/<pid>/cmdline, or various other remote
> > > > > > VM accesses) frequently delay this teardown indefinitely, defeating the
> > > > > > purpose of expedited reclamation.
> > > > > > 
> > > > > > This delay keeps memory pressure high, forcing the system to unnecessarily
> > > > > > kill additional innocent background apps before the memory from the first
> > > > > > victim is recovered.
> > > > > 
> > > > > Thanks, this makes the motivation much more clear and usecase very
> > > > > sound.
> > > > > 
> > > > > > This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
> > > > > > an integrated auto-kill mode. When specified, process_mrelease() directly
> > > > > > injects a SIGKILL into the target task.
> > > > > > 
> > > > > > To solve the race condition deterministically, we grab the mm reference
> > > > > > via mmget() and set the MMF_UNSTABLE flag *before* sending the SIGKILL.
> > > > > > Using mmget() instead of mmgrab() keeps mm_users > 0, preventing the
> > > > > > victim from calling exit_mmap() in its own exit path.
> > > > > 
> > > > > Why is this needed? Address space tear down is an operation that can run
> > > > > from several execution contexts.
> > > > 
> > > > Agreed.
> > > > 
> > > > > 
> > > > > > This ensures that
> > > > > > the memory is reclaimed synchronously and deterministically by the reaper
> > > > > > in the context of process_mrelease(), avoiding delays caused by
> > > > > > non-deterministic scheduling of the victim task.
> > > > > 
> > > > > The memory is still reclaimed synchronously from the mrelease context.
> > > > > This is really confusing.
> > > > > 
> > > > > Please also explain why do you need to do all that ugly
> > > > > task_will_free_mem hoops. Why cannot you simply kill the task if
> > > > > task_will_free_mem fails (if PROCESS_MRELEASE_REAP_KILL is used).
> > > > 
> > > > I wanted to handle shared address spaces.
> > > > Even though we are okay with the target task not being in a SIGKILL
> > > > state yet (since we are about to kill it), we must ensure that all
> > > > *other* processes sharing the same mm are also dying.
> > > 
> > > Then just bail out when the mm is shared accross thread groups, rather
> > > than kill just one of them. Or kill all of them. There is no reason to
> > > play around that on the task_will_free_mem level.
> > 
> > Kiling unrelated processes just because they share an mm is too radicical.
> 
> Well, that depends on what you try to achieve. The global OOM killer
> does kill all tasks sharing the mm.
> 
> > Thinking about quick check whether mm is shared.
> > 
> > An idea:
> > 
> > `atomic_read(&mm->mm_users) > task->signal->nr_threads` to detect sharing
> > across thread groups without looping like task_will_free_mem.
> 
> We have MMF_MULTIPROCESS. Can you use that?

That makes sense. Thanks.

Then, how about this?

From be4bd22a100ed6be2d1d2599ddb9da04043143eb Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Fri, 24 Apr 2026 14:27:08 -0700
Subject: [PATCH] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL
 flag

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

To handle shared address spaces safely in the auto-kill mode, we bail out
immediately if the mm is marked with MMF_MULTIPROCESS when
PROCESS_MRELEASE_REAP_KILL is specified. This protects existing users of
process_mrelease() from behavior changes while preventing unsafe reaping of
shared memory.

Fundamentally, this allows process_mrelease() to trigger targeted memory
reclaim (via oom_reaper infrastructure) quickly, even if the victim is
not yet in the exit path, while reusing existing race handling between
reaper and exit_mmap.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/uapi/linux/mman.h |  4 ++++
 mm/oom_kill.c             | 27 ++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

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
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5c6c95c169ee..efa6541b1c47 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -20,6 +20,7 @@
 
 #include <linux/oom.h>
 #include <linux/mm.h>
+#include <uapi/linux/mman.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
@@ -1217,9 +1218,11 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
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
@@ -1236,19 +1239,29 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	}
 
 	mm = p->mm;
-	mmgrab(mm);
+	if (reap_kill && mm_flags_test(MMF_MULTIPROCESS, mm)) {
+		ret = -EINVAL;
+		task_unlock(p);
+		goto put_task;
+	}
 
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
+		ret = kill_pid(task_tgid(task), SIGKILL, 0);
+		if (ret)
+			goto drop_mm;
+	}
 
 	if (mmap_read_lock_killable(mm)) {
 		ret = -EINTR;
-- 
2.54.0.545.g6539524ca2-goog




