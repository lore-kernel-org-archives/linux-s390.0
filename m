Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B84B37B3F2
	for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877783; cv=pass; b=WH8luabhjlC4QFQg18sq34Ia8Fn1mOAHjjXaI0sTkWR8SUrulOHsZbPjOc6dKcU0c+H3y8hygcdvWTrEaIEjhOEv4vEkPP1b6yV5SI1l6xlSUrdBSmj7LsdXKKSTWs1sx3hO2Lhc8T+Mx345njJb4u+ZuSVNR9NHMvnyOjM7Pjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877783; c=relaxed/simple;
	bh=zzpwX41CDNX8Vh4iWDAltIUNiyHIKHZUGGGfAynsGy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L65bXqw5plVMcN4GYco3tyKFQwA3R3te7NZ25KNOIrnd72nYpqMVa5YgA6Mcbl3Icz/Qu3dslvdQR+MxtAMKbW51DKV7vj3aR7nvqeQQbmA4hTMCB0Pr65Uc9KLy5Bi7yVrQkLRAc+niAMi+wMP7LIIH2DlT0EGAtqD4Wmwe9f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGzKcxiB; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGzKcxiB"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e61648f10so9211cf.1
        for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 13:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778877781; cv=none;
        d=google.com; s=arc-20240605;
        b=Q+tM13M8TbIC/zkqZ6vskTJu6TcMI8vMgsrdE+HCTg4eDRlRiuPl1Ei9+d3xBKTJgy
         VgEePS40VbjxQ3Q+m5CoMbdpeDR3zs0s2leXX05bBt6BGpENRX5CSyPUVsj1NVxtyUEM
         7V+Lh7ROuONDQXuaUKErgTiX8p2zcf70cdmCll65rc4QWz2F6QsxkHNvAVBQj/+ddEr7
         EBTcWn40TUad/s1JHGQjx5Ly8QC8jgY5j+tJWB+pznUcos3/DkxckGY2TqKxrkQkDNfz
         37nBjHGdtpbMoMID4yCLO3RcfRnnB7Whoa4iCNj3duclW909TJSWDZG9U6exWIVMGnd8
         u2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oIEPnncosyxG+qoVtyVWxbkjLGRLxQV9lWWWkRh9UR8=;
        fh=EA7/dOZ21J3+v++ZtyX8skMQidg4Q6DtKdd00Zw9wOU=;
        b=IJa4SDMIDA5ZBDprZmCmloT2oDHua8HMPwrZPqWi3Fda5c4Fhc//z73pIwonMgNiXU
         XHXyjYI/sqIkxlbYIfTduNlpsDrPiSkKkLXQyrOX6Llccs4ros9nOT8drT4zXDGP28UG
         mTb4Sz2OXxKrjkCN0yBMkp54its3gXPjWqIeCSmIiwbqViWKyscaA43shzhNGdIfBC7J
         84Ol5AfDxrmSaJemQY10440GWbsoAbJ77L0sZgIbx6saEFIYmp54CnU2HVmZtA18uhqU
         1LLKmVi4Twh2hv4sE5srWzve4SUVll7eQcmAe+o1gvlHhuAxkR1AGlb9NsD7vDDx3+RQ
         frlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778877781; x=1779482581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIEPnncosyxG+qoVtyVWxbkjLGRLxQV9lWWWkRh9UR8=;
        b=oGzKcxiB5/zLiXAtV8dOutP/DVWoef8/Hsbe0SaoofsYogC7ymArkJ+0tj4Auyl/MK
         dMr8cQ28f+0lnapTfdkOddrHFVfhIPMjcKzd5cVOGIPMDE7JyQIaQlU9wM85FWQLmLQQ
         TbdMZ7Ldm19ACst/Mf9gTmogYwWIUV7Ml4HEnBYZOa8UYKBfS0zFUcgaJTyAMdhuYifE
         n7xvKa5ns2bn/7p76gNnRNwe+ij6gF3Px9tJ37Mql2CbMPuGrhKt8JLi6RnGzNo6XOnl
         9oh3GR6JOX+viI7v9WluEpjQ255T5F8VDJmBW6yHBGNiERVmObtDdaeXpIyhLKXeqrdp
         luzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778877781; x=1779482581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oIEPnncosyxG+qoVtyVWxbkjLGRLxQV9lWWWkRh9UR8=;
        b=lxm88rAllBMMyJ1fOVEvLtrmexUs4pdckpx+Ih4J1MOr197ahu2cAoLv+IUWpFDxDM
         ZitTVdYh1rEmcm2Y3bTU5Z2pv7enmh4DFgVhFsBwDDxWu2vcHqUyVCd23Rk6Go6OC9A/
         TEvhPFq/1VqcWNpzDGn6WQcGBukyb/+DwE3zM41Gz4Fzl9Mru73E580SFvBKLnDLikIu
         3HYZqkfoMpDC99gJc8sbe7a/UUuTUtzJInM4M5p8OBBp8OYr7p2YRDyrKJ3ZwkaHxhrO
         yNJHxqFNrronRP9aJbgWVG7/CF3bkVujVvFlayzoqHqUvpDcmllljgTcM1Jw77QAjqER
         94dg==
X-Forwarded-Encrypted: i=1; AFNElJ8y6UDZhfkYw+c1CKhvasbR8siZhlWJFNIgHgdEbifxHBmf37Wk9J3j2EJTPwiB1zMlsT+QZ4keAzpV@vger.kernel.org
X-Gm-Message-State: AOJu0YysBcKekTTDsjtwzzTBT3JouOJ8HZf/OJq0qzL4qEfVOFgSf9iG
	F86xnPyas2P85+UEul3+93ROKO/J4Fgwurv44gIJOfmUfzNYsrzUom+3UWfwqJzr/dfnqZGS/um
	me4sBEuE/wjVMt2qMqwSz0cjh6f2WbHg0QJSbIlnX
X-Gm-Gg: Acq92OGY/O7x5tzzLS3gNZabfatSCA6H94yM2qt+BLOKgHFa+vzftqnfuEnPAUOBDHI
	qWq6mEUsHoM/ArvlGu5/mlGicfeqe7VofdPOs7uArX4hj7M4En0zDMueGFY5IiRB1HXPETpahGU
	qkPXcaPN8mQr8A2COEA/8MTPGusDuQWWAQKiFg32Xa+lodWzqZaAz/N2mZT6MZILkvuCgd2heHw
	VagmDqL5jr7Sv2+ScOLIKIaNoCN3F1oMWm8zq5Sa7N8mU7s8v3zGgl5huH391qvvyq04GwaRYpN
	M6igqaIdOsSQ1OAW
X-Received: by 2002:a05:622a:8d0f:b0:50f:bea3:9485 with SMTP id
 d75a77b69052e-5167000f1ddmr2427121cf.2.1778877780506; Fri, 15 May 2026
 13:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511214226.937793-1-minchan@kernel.org> <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
In-Reply-To: <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 15 May 2026 13:42:48 -0700
X-Gm-Features: AVHnY4LaA8ooM-LgAY3QYxs9bJUt5O1D11inE3Tl56Z1Ia-0ys_ET_0vdoKDU4Y
Message-ID: <CAJuCfpE_Kew9+umy2=7hzPdAe6yT23y=sk0BB=4BQpMZCJUvpA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL
 flag
To: Christian Brauner <brauner@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	akpm@linux-foundation.org, hca@linux.ibm.com, linux-s390@vger.kernel.org, 
	david@kernel.org, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 7:41=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, May 11, 2026 at 02:42:26PM -0700, Minchan Kim wrote:
> > Currently, process_mrelease() requires userspace to send a SIGKILL sign=
al
> > prior to invocation. This separation introduces a scheduling race windo=
w
> > where the victim task may receive the signal and enter the exit path
> > before the reaper can invoke process_mrelease().
> >
> > When the victim enters the exit path (do_exit -> exit_mm), it clears it=
s
> > task->mm immediately. This causes process_mrelease() to fail with -ESRC=
H,
>
> To be quite frank about the patch as written below: I think this is a
> completely crazy api. And I really dislike it.
>
> Right now we have clear and simple signal sending semantics for pidfds:
>
> * thread-specific pidfd -> thread-directed signal (unless signal is threa=
d-group scoped by default)
> * thread-group pidfd -> thread-group directed signal
>
> with specific overrides for pidfd_send_signal():
>
> * PIDFD_SIGNAL_THREAD           -> only signal thread
> * PIDFD_SIGNAL_THREAD_GROUP     -> signal thread-group
> * PIDFD_SIGNAL_PROCESS_GROUP    -> signal process-group
>
> And now this patch aims to elevate process_mrelease() to a _signal
> sending function_. And the semantics are complete special sauce too.
>
> You are effectively introducing a custom signal scope that is mm-based
> and then also plumbing it into a completely unrelated function that
> should have absolutely nothing to do with this.
>
> This is such Zebroid API. I really would hate to see it land.
>
> This came up because of the ptrace bug that was just recently discovered
> and that Linus fixed yesterday. This is another instance where I think
> the correct fix is to keep task->mm around until the process is reaped
> and then you can throw away all of the really ugly semantic in this
> patch afaict. I'd really like to see that merged as it would also clean
> up the ptrace code:
>
> https://lore.kernel.org/all/20201016024019.1882062-1-jannh@google.com

Yeah, I think this patchset would help process_mrelease() find the mm
to reap even after the process has passed its exit_mm(). We just need
to add:

if (!mm)
        mm =3D task->exit_mm;

Inside process_mrelease(). I had a similar idea of stashing mm and the
approach seems sane to me. Keeping UAPI unchanged is another upside
IMHO.

>
> > leaving the actual address space teardown (exit_mmap) to be deferred un=
til
> > the mm's reference count drops to zero. In the field (e.g., Android),
> > arbitrary reference counts (reading /proc/<pid>/cmdline, or various oth=
er
> > remote VM accesses) frequently delay this teardown indefinitely,
> > defeating the purpose of expedited reclamation.
> >
> > In Android's LMKD scenarios, this delay keeps memory pressure high, for=
cing
> > the system to unnecessarily kill additional innocent background apps be=
fore
> > the memory from the first victim is recovered.
> >
> > This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to suppo=
rt
> > an integrated auto-kill mode. When specified, process_mrelease() direct=
ly
> > injects a SIGKILL into the target task after finding its mm.
> >
> > To solve the race condition, we grab the mm reference via mmgrab() befo=
re
> > sending the SIGKILL. If the user passed PROCESS_MRELEASE_REAP_KILL, we =
assume
> > it will free its memory and proceed with reaping, making the logic as s=
imple
> > as reap =3D reap_kill || task_will_free_mem(p).
> >
> > To handle shared address spaces, we deliver SIGKILL to all processes sh=
aring
> > the same address space using do_pidfd_send_signal_pidns(). This ensures=
 the
> > target pid resides inside the caller's PID namespace hierarchy prior to
> > signal delivery. We iterate over all processes sharing the mm and deliv=
er
> > SIGKILL to each. If delivering the signal to any of the sharing process=
es
> > fails, we return an error. Note that this approach may leave partial
> > side-effects if some processes are killed successfully before a failure=
 occurs.
> >
> > Cc: Christian Brauner <brauner@kernel.org>
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  include/linux/signal.h    |  4 +++
> >  include/uapi/linux/mman.h |  4 +++
> >  kernel/signal.c           | 29 ++++++++++++++++++---
> >  mm/oom_kill.c             | 55 ++++++++++++++++++++++++++++++++++-----
> >  4 files changed, 81 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/signal.h b/include/linux/signal.h
> > index f19816832f05..bdbe6b3addec 100644
> > --- a/include/linux/signal.h
> > +++ b/include/linux/signal.h
> > @@ -276,6 +276,8 @@ static inline int valid_signal(unsigned long sig)
> >
> >  struct timespec;
> >  struct pt_regs;
> > +struct mm_struct;
> > +struct pid;
> >  enum pid_type;
> >
> >  extern int next_signal(struct sigpending *pending, sigset_t *mask);
> > @@ -283,6 +285,8 @@ extern int do_send_sig_info(int sig, struct kernel_=
siginfo *info,
> >                               struct task_struct *p, enum pid_type type=
);
> >  extern int group_send_sig_info(int sig, struct kernel_siginfo *info,
> >                              struct task_struct *p, enum pid_type type)=
;
> > +extern int do_pidfd_send_signal_pidns(struct pid *pid, int sig, enum p=
id_type type,
> > +                                   siginfo_t __user *info, unsigned in=
t flags);
> >  extern int send_signal_locked(int sig, struct kernel_siginfo *info,
> >                             struct task_struct *p, enum pid_type type);
> >  extern int sigprocmask(int, sigset_t *, sigset_t *);
> > diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> > index e89d00528f2f..4266976b45ad 100644
> > --- a/include/uapi/linux/mman.h
> > +++ b/include/uapi/linux/mman.h
> > @@ -56,4 +56,8 @@ struct cachestat {
> >       __u64 nr_recently_evicted;
> >  };
> >
> > +/* Flags for process_mrelease */
> > +#define PROCESS_MRELEASE_REAP_KILL   (1 << 0)
> > +#define PROCESS_MRELEASE_VALID_FLAGS (PROCESS_MRELEASE_REAP_KILL)
> > +
> >  #endif /* _UAPI_LINUX_MMAN_H */
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index d65d0fe24bfb..b2dc08a9bdd3 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -4046,6 +4046,30 @@ static int do_pidfd_send_signal(struct pid *pid,=
 int sig, enum pid_type type,
> >       return kill_pid_info_type(sig, &kinfo, pid, type);
> >  }
> >
> > +/**
> > + * do_pidfd_send_signal_pidns - Send a signal to a process via its str=
uct pid
> > + *                              while validating PID namespace hierarc=
hy.
> > + * @pid:   the struct pid of the target process
> > + * @sig:   signal to send
> > + * @type:  scope of the signal (e.g. PIDTYPE_TGID)
> > + * @info:  signal info payload
> > + * @flags: signaling flags
> > + *
> > + * Verify that the target pid resides inside the caller's PID namespac=
e
> > + * hierarchy prior to signal delivery.
> > + *
> > + * Return: 0 on success, negative errno on failure.
> > + */
> > +int do_pidfd_send_signal_pidns(struct pid *pid, int sig, enum pid_type=
 type,
> > +                            siginfo_t __user *info, unsigned int flags=
)
> > +{
> > +     /* Enforce PID namespace hierarchy boundary */
> > +     if (!access_pidfd_pidns(pid))
> > +             return -EINVAL;
> > +
> > +     return do_pidfd_send_signal(pid, sig, type, info, flags);
> > +}
> > +
> >  /**
> >   * sys_pidfd_send_signal - Signal a process through a pidfd
> >   * @pidfd:  file descriptor of the process
> > @@ -4094,16 +4118,13 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, =
int, sig,
> >               if (IS_ERR(pid))
> >                       return PTR_ERR(pid);
> >
> > -             if (!access_pidfd_pidns(pid))
> > -                     return -EINVAL;
> > -
> >               /* Infer scope from the type of pidfd. */
> >               if (fd_file(f)->f_flags & PIDFD_THREAD)
> >                       type =3D PIDTYPE_PID;
> >               else
> >                       type =3D PIDTYPE_TGID;
> >
> > -             return do_pidfd_send_signal(pid, sig, type, info, flags);
> > +             return do_pidfd_send_signal_pidns(pid, sig, type, info, f=
lags);
> >       }
> >       }
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 5c6c95c169ee..253aa80770f2 100644
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
> > @@ -925,6 +926,39 @@ static bool task_will_free_mem(struct task_struct =
*task)
> >       return ret;
> >  }
> >
> > +/*
> > + * kill_all_shared_mm - Deliver SIGKILL to all processes sharing the g=
iven address space.
> > + * @victim: the targeted OOM process group leader
> > + * @mm:     the virtual memory space being reaped
> > + *
> > + * Traverse all threads globally and signal any user processes sharing=
 the identical
> > + * mm footprints, ensuring no concurrent users pin the memory. Skips t=
he system
> > + * global init and kernel worker threads.
> > + */
> > +static int kill_all_shared_mm(struct task_struct *victim, struct mm_st=
ruct *mm)
> > +{
> > +     struct task_struct *p;
> > +     bool failed =3D false;
> > +
> > +     rcu_read_lock();
> > +     for_each_process(p) {
> > +             if (!process_shares_mm(p, mm))
> > +                     continue;
> > +             if (is_global_init(p)) {
>
> You can't signal init in any shape or form any way. Why bother reporting
> failure at all.
>
> > +                     failed =3D true;
> > +                     continue;
> > +             }
> > +             if (unlikely(p->flags & PF_KTHREAD))
> > +                     continue;
> > +
> > +             if (do_pidfd_send_signal_pidns(task_pid(p), SIGKILL, PIDT=
YPE_TGID, NULL, 0))
> > +                     failed =3D true;
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     return failed ? -EBUSY : 0;
>
> Why are you returning EBUSY? This makes no sense imho.
>
> > +}
> > +
> >  static void __oom_kill_process(struct task_struct *victim, const char =
*message)
> >  {
> >       struct task_struct *p;
> > @@ -1217,9 +1251,11 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, un=
signed int, flags)
> >       unsigned int f_flags;
> >       bool reap =3D false;
> >       long ret =3D 0;
> > +     bool reap_kill;
> >
> > -     if (flags)
> > +     if (flags & ~PROCESS_MRELEASE_VALID_FLAGS)
> >               return -EINVAL;
> > +     reap_kill =3D !!(flags & PROCESS_MRELEASE_REAP_KILL);
> >
> >       task =3D pidfd_get_task(pidfd, &f_flags);
> >       if (IS_ERR(task))
> > @@ -1236,19 +1272,24 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, u=
nsigned int, flags)
> >       }
> >
> >       mm =3D p->mm;
> > -     mmgrab(mm);
> >
> > -     if (task_will_free_mem(p))
> > -             reap =3D true;
> > -     else {
> > +     reap =3D reap_kill || task_will_free_mem(p);
> > +     if (!reap) {
> >               /* Error only if the work has not been done already */
> >               if (!mm_flags_test(MMF_OOM_SKIP, mm))
> >                       ret =3D -EINVAL;
> > +             task_unlock(p);
> > +             goto put_task;
> >       }
> > +
> > +     mmgrab(mm);
> >       task_unlock(p);
> >
> > -     if (!reap)
> > -             goto drop_mm;
> > +     if (reap_kill) {
> > +             ret =3D kill_all_shared_mm(task, mm);
> > +             if (ret)
> > +                     goto drop_mm;
> > +     }
> >
> >       if (mmap_read_lock_killable(mm)) {
> >               ret =3D -EINTR;
> > --
> > 2.54.0.563.g4f69b47b94-goog
> >
> >
