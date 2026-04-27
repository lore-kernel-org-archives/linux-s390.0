Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259834B1B4;
	Mon, 27 Apr 2026 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330364; cv=none; b=JvHjSWWID6iKQN1ho4vbCRw+ls2LIDqplX+jWKZ3imcfzh5z/wd3MoYwj0kfgruVS7Hz+5nKgSB5V5nZ4Ub2vYmpRbh0Knse79egnNDe0OWLgxRp7tsS8KZSyKmeSJdtLcTRXLmfh2MusbnLrc568UUMkhmdCVSENc+4WtEaYbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330364; c=relaxed/simple;
	bh=naILOOeceSH7gxGqzl9s9OfI8mPKDP5hLrbE9sgbdqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBWLmLnC9Jc49FHwAMIv3Qy43PmVo3bvkJxN5cFNQgg38YDoe7TiKwKVox+YrKp0ljZTl7Di3NivkZ7vAlN6/cln6nTYaSYVhFXoRWxqKXu+86Owp4871lyyNLhB/j4ebEXkqhzyySiBGx2Vlq/Cwm/N+co2/+x76XRziHVmr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQHuAQyk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQHuAQyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBF1C19425;
	Mon, 27 Apr 2026 22:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777330364;
	bh=naILOOeceSH7gxGqzl9s9OfI8mPKDP5hLrbE9sgbdqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQHuAQykeFe6C0ai+ixhiAb4LvOC1ZVCpjNX8WMjxR9PF6w0/xLPSqb/YemocAlAn
	 XrH5ES4JiKpw9BuyKiK8DYf5CBFuoeAnmvkAlPAffMXSDPGIWpmq4Bs00lRBCoiU/J
	 QYgAANxb6f2ht+6XTxtDOOeJ20H2CZE2Li6DCu3lHjqSPg/q/xtSofS9iPtL8JFsuI
	 +qWk0Pa4m7ln4qMUu9q0X8lQC/5AWr+TG99oxfURjJG6gKrFHsAIr3K5C2shi0BPsl
	 FgcobMMzEdPvXPKVGA/K46+64l/8k8LjtLTyYmRWQRg4+qEJaQy1xupfiCVjBR1xWY
	 97N0AtmnGhj5Q==
Date: Mon, 27 Apr 2026 15:52:42 -0700
From: Minchan Kim <minchan@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, mhocko@suse.com,
	brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, timmurray@google.com
Subject: Re: [PATCH v1 3/3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <ae_oul_xgD5Kgnqi@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-4-minchan@kernel.org>
 <CAJuCfpFK+qatN_vHArEKOYe+LRHQG0e3inJrzVdz-mABi-BSTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFK+qatN_vHArEKOYe+LRHQG0e3inJrzVdz-mABi-BSTg@mail.gmail.com>

On Mon, Apr 27, 2026 at 01:34:37PM -0700, Suren Baghdasaryan wrote:
> On Tue, Apr 21, 2026 at 4:03 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > Currently, process_mrelease() requires userspace to send a SIGKILL signal
> > prior to the call. This separation introduces a scheduling race window
> > where the victim task may receive the signal and enter the exit path
> > before the reaper can invoke process_mrelease().
> >
> > When the victim enters the exit path (do_exit -> exit_mm), it clears its
> > task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
> > leaving the actual address space teardown (exit_mmap) to be deferred until
> > the mm's reference count drops to zero. In Android, arbitrary reference counts
> > (e.g., async I/O, reading /proc/<pid>/cmdline, or various other remote
> > VM accesses) frequently delay this teardown indefinitely, defeating the
> > purpose of expedited reclamation.
> >
> > This delay keeps memory pressure high, forcing the system to unnecessarily
> > kill additional innocent background apps before the memory from the first
> > victim is recovered.
> >
> > This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
> > an integrated auto-kill mode. When specified, process_mrelease() directly
> > injects a SIGKILL into the target task.
> >
> > To solve the race condition deterministically, we grab the mm reference
> > via mmget() and set the MMF_UNSTABLE flag *before* sending the SIGKILL.
> > Using mmget() instead of mmgrab() keeps mm_users > 0, preventing the
> > victim from calling exit_mmap() in its own exit path. This ensures that
> > the memory is reclaimed synchronously and deterministically by the reaper
> > in the context of process_mrelease(), avoiding delays caused by
> > non-deterministic scheduling of the victim task.
> >
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  include/uapi/linux/mman.h |  4 +++
> >  mm/oom_kill.c             | 56 +++++++++++++++++++++++++++------------
> >  2 files changed, 43 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> > index e89d00528f2f..4266976b45ad 100644
> > --- a/include/uapi/linux/mman.h
> > +++ b/include/uapi/linux/mman.h
> > @@ -56,4 +56,8 @@ struct cachestat {
> >         __u64 nr_recently_evicted;
> >  };
> >
> > +/* Flags for process_mrelease */
> > +#define PROCESS_MRELEASE_REAP_KILL     (1 << 0)
> > +#define PROCESS_MRELEASE_VALID_FLAGS   (PROCESS_MRELEASE_REAP_KILL)
> > +
> >  #endif /* _UAPI_LINUX_MMAN_H */
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 5c6c95c169ee..730ba0d19b53 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -20,6 +20,7 @@
> >
> >  #include <linux/oom.h>
> >  #include <linux/mm.h>
> > +#include <uapi/linux/mman.h>
> >  #include <linux/err.h>
> >  #include <linux/gfp.h>
> >  #include <linux/sched.h>
> > @@ -850,7 +851,7 @@ bool oom_killer_disable(signed long timeout)
> >         return true;
> >  }
> >
> > -static inline bool __task_will_free_mem(struct task_struct *task)
> > +static inline bool __task_will_free_mem(struct task_struct *task, bool ignore_exit)
> >  {
> >         struct signal_struct *sig = task->signal;
> >
> > @@ -862,6 +863,9 @@ static inline bool __task_will_free_mem(struct task_struct *task)
> >         if (sig->core_state)
> >                 return false;
> >
> > +       if (ignore_exit)
> > +               return true;
> > +
> >         if (sig->flags & SIGNAL_GROUP_EXIT)
> >                 return true;
> >
> > @@ -878,7 +882,7 @@ static inline bool __task_will_free_mem(struct task_struct *task)
> >   * Caller has to make sure that task->mm is stable (hold task_lock or
> >   * it operates on the current).
> >   */
> > -static bool task_will_free_mem(struct task_struct *task)
> > +static bool task_will_free_mem(struct task_struct *task, bool ignore_exit)
> >  {
> >         struct mm_struct *mm = task->mm;
> >         struct task_struct *p;
> > @@ -892,7 +896,7 @@ static bool task_will_free_mem(struct task_struct *task)
> >         if (!mm)
> >                 return false;
> >
> > -       if (!__task_will_free_mem(task))
> > +       if (!__task_will_free_mem(task, ignore_exit))
> >                 return false;
> >
> >         /*
> > @@ -916,7 +920,7 @@ static bool task_will_free_mem(struct task_struct *task)
> >                         continue;
> >                 if (same_thread_group(task, p))
> >                         continue;
> > -               ret = __task_will_free_mem(p);
> > +               ret = __task_will_free_mem(p, false);
> >                 if (!ret)
> >                         break;
> >         }
> > @@ -1034,7 +1038,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
> >          * so it can die quickly
> >          */
> >         task_lock(victim);
> > -       if (task_will_free_mem(victim)) {
> > +       if (task_will_free_mem(victim, false)) {
> >                 mark_oom_victim(victim);
> >                 queue_oom_reaper(victim);
> >                 task_unlock(victim);
> > @@ -1135,7 +1139,7 @@ bool out_of_memory(struct oom_control *oc)
> >          * select it.  The goal is to allow it to allocate so that it may
> >          * quickly exit and free its memory.
> >          */
> > -       if (task_will_free_mem(current)) {
> > +       if (task_will_free_mem(current, false)) {
> >                 mark_oom_victim(current);
> >                 queue_oom_reaper(current);
> >                 return true;
> > @@ -1217,8 +1221,9 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> >         unsigned int f_flags;
> >         bool reap = false;
> >         long ret = 0;
> > +       bool reap_kill;
> >
> > -       if (flags)
> > +       if (flags & ~PROCESS_MRELEASE_VALID_FLAGS)
> >                 return -EINVAL;
> >
> >         task = pidfd_get_task(pidfd, &f_flags);
> > @@ -1236,19 +1241,33 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> >         }
> >
> >         mm = p->mm;
> > -       mmgrab(mm);
> >
> > -       if (task_will_free_mem(p))
> > -               reap = true;
> > -       else {
> > -               /* Error only if the work has not been done already */
> > -               if (!mm_flags_test(MMF_OOM_SKIP, mm))
> > +       reap_kill = !!(flags & PROCESS_MRELEASE_REAP_KILL);
> > +       reap = task_will_free_mem(p, reap_kill);
> > +       if (!reap) {
> > +               if (reap_kill || !mm_flags_test(MMF_OOM_SKIP, mm))
> >                         ret = -EINVAL;
> > +
> > +               task_unlock(p);
> > +               goto put_task;
> >         }
> > -       task_unlock(p);
> >
> > -       if (!reap)
> > -               goto drop_mm;
> > +       if (reap_kill) {
> > +               /*
> > +                * We use mmget() instead of mmgrab() to keep mm_users > 0,
> > +                * preventing the victim from calling exit_mmap() in its
> > +                * own exit path. This ensures that the memory is reclaimed
> > +                * synchronously and deterministically by the reaper.
> > +                */
> > +               mmget(mm);
> 
> I don't quite understand why you need to mmget() and prevent the
> victim from calling exit_mmap() here. As long as we successfully
> mmgrab'ed the mm, we can safely proceed with mmap locking and doing
> __oom_reap_task_mm(). Victim can execute exit_mmap() in parallel with
> __oom_reap_task_mm(). In fact that's even desirable! I remember a
> recent patch that used mas_for_each_rev() in __oom_reap_task_mm() to
> reclaim memory in reverse order so that exit_mmap() and
> __oom_reap_task_mm() can start from opposite ends of the address space
> and converge in the middle, working concurrently.

Good information. Will change it in next respin.
