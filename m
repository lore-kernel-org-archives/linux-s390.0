Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F436167F
	for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322092; cv=pass; b=aw2vqxlHiDr7u0gZnPlxMjSqeC/HmzccAEW5Qm1hsnkKkU0+1427Un+byBN/iMsL44xpdFnr3T9UoJMqC8puVApMDL+CVW8HGzji07rPQVHTjlN7E+S4q3bj278BXV+tQt4MnEfPzbIMmIGZ4EzK+XnLl7wX1cEdS1iFvHwojdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322092; c=relaxed/simple;
	bh=GlXakv3c5ZJ47nxeq7tyJSuU4g9M7MH9i2Rayjy3RJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hb2SpJl5tmLrRv7PWW7we3l1YC4dX9vkc+NuRRIOZHUw0YpCDt7gQfn2YTpGmja0iOi4zUW0bdWMfkffwKOPKsCU5kOn/VbLh7EmGP6B3KPDO/Chjxy1xEGU1LILD8O9PMIjrbCYNN6K9Dk/7MOknOJccGbr9d8o8QXBV0s/n3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUMe8eJ6; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUMe8eJ6"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d6b393d60so166401cf.0
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 13:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777322090; cv=none;
        d=google.com; s=arc-20240605;
        b=N2YGtTOWrWibXk0DPQf47M3Myy/v8QQ14gmnhftotN3wADSh+O6jRDXuVoiaJoquJq
         FbpV9gbxip1G01CzE+1G7ymWxNoLbypTyLaNtXT1YCS+bUWX9NXJPy+0BqMmiFkyxIna
         bVyR5JGWYjxtKT1ASGjiWtZPGHlWptRzgt4M+HI9Yo2lZ2R8lbx2slH9l8ngUhOdy3JN
         4vjks0426vse/Cx/uLBpD+mmvMZGYh9pDoHWPKDb+jxE3c/TEGxKomPI29GPIwFjHXYI
         i4rnj5HLW2XI6Ng8mDhs8nejiRZkHchEM0VLrGVO/35ZVuZ0V2HvYba6TAfAEVBnT62V
         rpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DhWqUuRS27TshBWv94CX8/aDWOniyA7iNM1Yxs8Y1bU=;
        fh=rgZL+gkkEOdM0ftD0WSpoX1hwqbi6z1Z/9GSqHwWCfY=;
        b=XF6M/eBfVIBHyloiYXYZ3j+re6t9MM1yV3f+O+oN61vfGDpVEsd9pUvvwTuyYwBwA7
         ZbHk7N0pbQH6KrXAY6I4Yo8o0XEAxMNLxVbV7SiFcfe1beyBPopqeUF9Rc3IL2Ga+8Wd
         dRgCwEPHxdpPBvWofvl5qWH54x/E1hmRvhJUGnQ9B3HFo9GACoGDapHlDFKreAnv+UGt
         1buUaczV+T4fRXHnN4ifImJJT33EIat1+ODvj+RftYPy428cOCDtM6h/WFXT9P3nppvd
         7EXQ25Gw7hF1UR2nPJgG80uOSieCs6KkEjmnHR8OUZo+bKxY/DNTwBkSYgN5cuaZInde
         lmjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777322090; x=1777926890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhWqUuRS27TshBWv94CX8/aDWOniyA7iNM1Yxs8Y1bU=;
        b=OUMe8eJ6lVQdc29CqiAdN5yXabczcHJtXHqdupO/l+O9R4W9sW/ISP0fGye1mbzYpA
         1EB2eE9tMLxWmhoCvHlNJx2Jnof+cFWEwRbX8yF2oOtWE+35gLGhJsyScHBv+TELc+z4
         GwMwim0SSDYEyQwhoH2xDkEpD2CsNjRRCICTDfam1qUuSKiriB1XJgtxgt8KNaP8vjYP
         e8Zbe3tSlBiaq42oz7neX4a9E3QXCeUvPgSr7iZNnf5LGUsJzPUyc7yWi1M278tq346w
         B1KCCPj9SiVzPvNqut3Xe2Ux1hGouEdaFzBZLlDnK7LhbTWNyNpZo+zp94m4t39LTtlk
         0YzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777322090; x=1777926890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DhWqUuRS27TshBWv94CX8/aDWOniyA7iNM1Yxs8Y1bU=;
        b=RjeCKpSi3SHvfd2K5J1j4eCrxjlsQW6rcd1PjrwGBB9Ta/r0a6ITQX22lMi9l8pVto
         vQde2Eta3JTRw5whIahlUD1oGlizOD1V04+F7eTiD+U5R2eLc3jWKY+A2MKwJZO0wMyD
         Bje/shkyMbwFyLoCxIAlj1RmgotugYUGwAf9De8W1s/840EMqGV6XEEE2SfeTj0l+L3E
         VSMeNdEd2tRaj3DRml1brJsphgSOaoc7AUCkn8VFpruRPhcZ8KMOnLgtBj4jRFvUKdVO
         ylbL8r2L6qwsIKaZdIh7MMgs/Mg7wAX3o3XBEQYtRGpf+JjFv7sBuxxGUbGao/VONRH6
         bIbA==
X-Forwarded-Encrypted: i=1; AFNElJ+QW3QK0xcLQu9iypTO2jQzf9jjSAXbblWb7VLVxe5ZnmNSkmq08byk2mBvokemraSpfQoAb/FPCgYr@vger.kernel.org
X-Gm-Message-State: AOJu0YyseCl2F1L6M7GRc+mFSgVUdxxjFtWxpSceRkBUD5ohIW3ZINr5
	XRQtSWUUg6XNHroMy93zD13RdaLT3HuTLBNxqbM4P8n8lvaisQ5BwTtfQ4ylJPgWeG+rVf0B5sz
	5pRpDjnqZSN2jTaoPPuL0ciR5rmb/GaZfZaZ/LtCv
X-Gm-Gg: AeBDietC6oLkNkDnjrA/uXNlqM2go0mtKRaYpsVWJwG6kqcOfomuLSiHuYKzebP/hRF
	X1K6Ycy2KSGlk0dEkjAxN0N4dQGi3GuXLv9Bh6mrGeqvjEn2InLHzblN0E0/974WSzp+frQdFvy
	MWnhPqwjmw3Fyy/kBb2e96FyXRKDNcAinQ6EUKwZmmI4nEBP7xXBJilxGbFi5vD81x4WVGzUQtC
	5Ee+5CRYC7Qr6F3TjES2h0047QOngLtgsKxzmLEg185TYhLxiXq95aETn+rXMgucbxoGe4jHgsR
	y949nHfP7Er+58O00T4u8tlkMjs=
X-Received: by 2002:a05:622a:8d0e:b0:50e:595d:164 with SMTP id
 d75a77b69052e-5100cbeb145mr3380701cf.8.1777322089076; Mon, 27 Apr 2026
 13:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421230239.172582-1-minchan@kernel.org> <20260421230239.172582-4-minchan@kernel.org>
In-Reply-To: <20260421230239.172582-4-minchan@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 27 Apr 2026 13:34:37 -0700
X-Gm-Features: AVHnY4I5Wx2UawYOebex5DxQ-pCvX_szKcR7n0x14TYqFsbSSMINsoQ03bpahTg
Message-ID: <CAJuCfpFK+qatN_vHArEKOYe+LRHQG0e3inJrzVdz-mABi-BSTg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
To: Minchan Kim <minchan@kernel.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com, linux-s390@vger.kernel.org, 
	david@kernel.org, mhocko@suse.com, brauner@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, timmurray@google.com, 
	Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 4:03=E2=80=AFPM Minchan Kim <minchan@kernel.org> wr=
ote:
>
> Currently, process_mrelease() requires userspace to send a SIGKILL signal
> prior to the call. This separation introduces a scheduling race window
> where the victim task may receive the signal and enter the exit path
> before the reaper can invoke process_mrelease().
>
> When the victim enters the exit path (do_exit -> exit_mm), it clears its
> task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
> leaving the actual address space teardown (exit_mmap) to be deferred unti=
l
> the mm's reference count drops to zero. In Android, arbitrary reference c=
ounts
> (e.g., async I/O, reading /proc/<pid>/cmdline, or various other remote
> VM accesses) frequently delay this teardown indefinitely, defeating the
> purpose of expedited reclamation.
>
> This delay keeps memory pressure high, forcing the system to unnecessaril=
y
> kill additional innocent background apps before the memory from the first
> victim is recovered.
>
> This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
> an integrated auto-kill mode. When specified, process_mrelease() directly
> injects a SIGKILL into the target task.
>
> To solve the race condition deterministically, we grab the mm reference
> via mmget() and set the MMF_UNSTABLE flag *before* sending the SIGKILL.
> Using mmget() instead of mmgrab() keeps mm_users > 0, preventing the
> victim from calling exit_mmap() in its own exit path. This ensures that
> the memory is reclaimed synchronously and deterministically by the reaper
> in the context of process_mrelease(), avoiding delays caused by
> non-deterministic scheduling of the victim task.
>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  include/uapi/linux/mman.h |  4 +++
>  mm/oom_kill.c             | 56 +++++++++++++++++++++++++++------------
>  2 files changed, 43 insertions(+), 17 deletions(-)
>
> diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> index e89d00528f2f..4266976b45ad 100644
> --- a/include/uapi/linux/mman.h
> +++ b/include/uapi/linux/mman.h
> @@ -56,4 +56,8 @@ struct cachestat {
>         __u64 nr_recently_evicted;
>  };
>
> +/* Flags for process_mrelease */
> +#define PROCESS_MRELEASE_REAP_KILL     (1 << 0)
> +#define PROCESS_MRELEASE_VALID_FLAGS   (PROCESS_MRELEASE_REAP_KILL)
> +
>  #endif /* _UAPI_LINUX_MMAN_H */
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 5c6c95c169ee..730ba0d19b53 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -20,6 +20,7 @@
>
>  #include <linux/oom.h>
>  #include <linux/mm.h>
> +#include <uapi/linux/mman.h>
>  #include <linux/err.h>
>  #include <linux/gfp.h>
>  #include <linux/sched.h>
> @@ -850,7 +851,7 @@ bool oom_killer_disable(signed long timeout)
>         return true;
>  }
>
> -static inline bool __task_will_free_mem(struct task_struct *task)
> +static inline bool __task_will_free_mem(struct task_struct *task, bool i=
gnore_exit)
>  {
>         struct signal_struct *sig =3D task->signal;
>
> @@ -862,6 +863,9 @@ static inline bool __task_will_free_mem(struct task_s=
truct *task)
>         if (sig->core_state)
>                 return false;
>
> +       if (ignore_exit)
> +               return true;
> +
>         if (sig->flags & SIGNAL_GROUP_EXIT)
>                 return true;
>
> @@ -878,7 +882,7 @@ static inline bool __task_will_free_mem(struct task_s=
truct *task)
>   * Caller has to make sure that task->mm is stable (hold task_lock or
>   * it operates on the current).
>   */
> -static bool task_will_free_mem(struct task_struct *task)
> +static bool task_will_free_mem(struct task_struct *task, bool ignore_exi=
t)
>  {
>         struct mm_struct *mm =3D task->mm;
>         struct task_struct *p;
> @@ -892,7 +896,7 @@ static bool task_will_free_mem(struct task_struct *ta=
sk)
>         if (!mm)
>                 return false;
>
> -       if (!__task_will_free_mem(task))
> +       if (!__task_will_free_mem(task, ignore_exit))
>                 return false;
>
>         /*
> @@ -916,7 +920,7 @@ static bool task_will_free_mem(struct task_struct *ta=
sk)
>                         continue;
>                 if (same_thread_group(task, p))
>                         continue;
> -               ret =3D __task_will_free_mem(p);
> +               ret =3D __task_will_free_mem(p, false);
>                 if (!ret)
>                         break;
>         }
> @@ -1034,7 +1038,7 @@ static void oom_kill_process(struct oom_control *oc=
, const char *message)
>          * so it can die quickly
>          */
>         task_lock(victim);
> -       if (task_will_free_mem(victim)) {
> +       if (task_will_free_mem(victim, false)) {
>                 mark_oom_victim(victim);
>                 queue_oom_reaper(victim);
>                 task_unlock(victim);
> @@ -1135,7 +1139,7 @@ bool out_of_memory(struct oom_control *oc)
>          * select it.  The goal is to allow it to allocate so that it may
>          * quickly exit and free its memory.
>          */
> -       if (task_will_free_mem(current)) {
> +       if (task_will_free_mem(current, false)) {
>                 mark_oom_victim(current);
>                 queue_oom_reaper(current);
>                 return true;
> @@ -1217,8 +1221,9 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsig=
ned int, flags)
>         unsigned int f_flags;
>         bool reap =3D false;
>         long ret =3D 0;
> +       bool reap_kill;
>
> -       if (flags)
> +       if (flags & ~PROCESS_MRELEASE_VALID_FLAGS)
>                 return -EINVAL;
>
>         task =3D pidfd_get_task(pidfd, &f_flags);
> @@ -1236,19 +1241,33 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, uns=
igned int, flags)
>         }
>
>         mm =3D p->mm;
> -       mmgrab(mm);
>
> -       if (task_will_free_mem(p))
> -               reap =3D true;
> -       else {
> -               /* Error only if the work has not been done already */
> -               if (!mm_flags_test(MMF_OOM_SKIP, mm))
> +       reap_kill =3D !!(flags & PROCESS_MRELEASE_REAP_KILL);
> +       reap =3D task_will_free_mem(p, reap_kill);
> +       if (!reap) {
> +               if (reap_kill || !mm_flags_test(MMF_OOM_SKIP, mm))
>                         ret =3D -EINVAL;
> +
> +               task_unlock(p);
> +               goto put_task;
>         }
> -       task_unlock(p);
>
> -       if (!reap)
> -               goto drop_mm;
> +       if (reap_kill) {
> +               /*
> +                * We use mmget() instead of mmgrab() to keep mm_users > =
0,
> +                * preventing the victim from calling exit_mmap() in its
> +                * own exit path. This ensures that the memory is reclaim=
ed
> +                * synchronously and deterministically by the reaper.
> +                */
> +               mmget(mm);

I don't quite understand why you need to mmget() and prevent the
victim from calling exit_mmap() here. As long as we successfully
mmgrab'ed the mm, we can safely proceed with mmap locking and doing
__oom_reap_task_mm(). Victim can execute exit_mmap() in parallel with
__oom_reap_task_mm(). In fact that's even desirable! I remember a
recent patch that used mas_for_each_rev() in __oom_reap_task_mm() to
reclaim memory in reverse order so that exit_mmap() and
__oom_reap_task_mm() can start from opposite ends of the address space
and converge in the middle, working concurrently.

> +               task_unlock(p);
> +               ret =3D kill_pid(task_tgid(task), SIGKILL, 0);
> +               if (ret)
> +                       goto drop_mm;
> +       } else {
> +               mmgrab(mm);
> +               task_unlock(p);
> +       }
>
>         if (mmap_read_lock_killable(mm)) {
>                 ret =3D -EINTR;
> @@ -1263,7 +1282,10 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsi=
gned int, flags)
>         mmap_read_unlock(mm);
>
>  drop_mm:
> -       mmdrop(mm);
> +       if (reap_kill)
> +               mmput(mm);
> +       else
> +               mmdrop(mm);
>  put_task:
>         put_task_struct(task);
>         return ret;
> --
> 2.54.0.rc1.555.g9c883467ad-goog
>
>
