Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379CD3D8114
	for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965609; cv=none; b=KBWYW2KWagnLa9oC3TIaKy9h4wADOiyi/rK2V+nzARlHx9Vgqvi+h5CbVHHbmkS242P8WqIwFiiZvhGd3AwXaFKjenUes+rRjRx20+mKFPoAwk89syiElmafe71Up9X5CbpGaLtDnnkdCvkoqDUef9K+PasVvrQbYWWPv/cYhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965609; c=relaxed/simple;
	bh=v8oGte1nICQf3lPzs/IH7HujDZ08x8KnEuuH3pyLmXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NL/bzBz+1lDoPyIEkDAMb2xXF4ai8QGRrqg4ffC1LZYO7cnjOo8zfN3mP1XIPp/5BwO/2ZqzZNvz1hsG71roeLy2g5dxd5tYWwq7R8IGUbDl+BJzacz0vxRB6H2qrb6cVk+hcmBQFdJMsooCk8+7gpikq/H/20sU524fqtCQTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ0PH/CG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ0PH/CG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D23C2BCC6
	for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774965608;
	bh=v8oGte1nICQf3lPzs/IH7HujDZ08x8KnEuuH3pyLmXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QQ0PH/CG0dWacUziG4TNgGC3pZnU4geMh3an4vCBQT4so9mzz6OnOMW6HjZW/5pIR
	 VIK02bsYHgPtDxWO9hiZ9oCZSIuVJlHMYylbdgza8MaXjEsUWbiOFWmbL/CNJ6WWyz
	 3hW/J+jSuPKcoyoH+oyoWOnh+u8WKdnuncyzsEN2BvRxr4xNAfrFyqobe1/JDevGVK
	 bGFEB7jWDn4ZL5G6MaL2BQINbPAK6Bu5YyIG31K/V0uXmhgT+gNqvIKxR8r64uutlF
	 HForGfWlPhfy1Gi0mRpoCxwcciky2Hccat3M2CRIPCkulov95gD8wvMSRfxSrttxlk
	 3ML0Cls2uYXcQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-463a0e14abfso3249147b6e.2
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 07:00:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWi/Y/oS3Y4g0ABO1lfe19NGQHBolg9MfQUJHd1FP1hASe2X2tLlW7QLv7u1tRC0BmntN6/xUQPv1LB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8rBQh52YetS4Who3BIENN4syVFRaeTejgErJU0HdrWW4MybHe
	jJ2H6zOVCViPWQygb0WvsaNgIV9bM3BiGKRqxxxvPScKiu5w/Fcz9nHEVveP44zR2mK92waM9W7
	Jc2VGh5R791rK/PD0FpqzHfRpiimUKFE=
X-Received: by 2002:a05:6808:1493:b0:467:f3d4:fc4e with SMTP id
 5614622812f47-46a8a596197mr7405781b6e.33.1774965607378; Tue, 31 Mar 2026
 07:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331131622.30505-1-frederic@kernel.org> <20260331131622.30505-2-frederic@kernel.org>
In-Reply-To: <20260331131622.30505-2-frederic@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 31 Mar 2026 15:59:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gK3WdPhVuY-SJNJ4WK87kL3w9Q8KGBtt5RuE1AUoxdLQ@mail.gmail.com>
X-Gm-Features: AQROBzC01cSpFeB8dQHSq2PjzTVT0MM4PbeCSZP1pxl-fD4ctuT__P9I9dxaSrc
Message-ID: <CAJZ5v0gK3WdPhVuY-SJNJ4WK87kL3w9Q8KGBtt5RuE1AUoxdLQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] sched/idle: Handle offlining first in idle loop
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Kieran Bingham <kbingham@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Mel Gorman <mgorman@suse.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, 
	Valentin Schneider <vschneid@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 3:16=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Offline handling happens from within the inner idle loop,
> after the beginning of dyntick cputime accounting, nohz idle
> load balancing and TIF_NEED_RESCHED polling.
>
> This is not necessary and even buggy because:
>
> * There is no dyntick handling to do. And calling tick_nohz_idle_enter()
>   messes up with the struct tick_sched reset that was performed on
>   tick_sched_timer_dying().
>
> * There is no nohz idle balancing to do.
>
> * Polling on TIF_RESCHED is irrelevant at this stage, there are no more
>   tasks allowed to run.
>
> * No need to check if need_resched() before offline handling since
>   stop_machine is done and all per-cpu kthread should be done with
>   their job.
>
> Therefore move the offline handling at the beginning of the idle loop.
> This will also ease the idle cputime unification later by not elapsing
> idle time while offline through the call to:
>
>         tick_nohz_idle_enter() -> tick_nohz_start_idle()
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>

No issues found, so

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  kernel/sched/idle.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 3681b6ad9276..521a076d8845 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -260,6 +260,14 @@ static void do_idle(void)
>  {
>         int cpu =3D smp_processor_id();
>
> +       if (cpu_is_offline(cpu)) {
> +               local_irq_disable();
> +               /* All per-CPU kernel threads should be done by now. */
> +               WARN_ON_ONCE(need_resched());
> +               cpuhp_report_idle_dead();
> +               arch_cpu_idle_dead();
> +       }
> +
>         /*
>          * Check if we need to update blocked load
>          */
> @@ -311,11 +319,6 @@ static void do_idle(void)
>                  */
>                 local_irq_disable();
>
> -               if (cpu_is_offline(cpu)) {
> -                       cpuhp_report_idle_dead();
> -                       arch_cpu_idle_dead();
> -               }
> -
>                 arch_cpu_idle_enter();
>                 rcu_nocb_flush_deferred_wakeup();
>
> --
> 2.53.0
>
