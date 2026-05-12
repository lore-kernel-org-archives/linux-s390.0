Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7CA376BCA
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624223; cv=pass; b=ETPjWzdZj3eFPkhUJbufULcpJPLKPNPHRSmNGQkOoeYeUf1zOKVXd2sHKfYhLqaJ9VoAHCWAW2uVRH0HYnuShlNDm4XJmokoK5zhab2nlSYP/ajtC8b3hbG1wehjj5d9yjhutQDnx3a3iioe98n2T5MUDlrKk2W+1HhCfuet1q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624223; c=relaxed/simple;
	bh=5WdL1RfT6i0Pq2ZStlBz3Fzl5NL4eEcrNRYvRXI0UMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQZ84mPQeOXlpc21r9PDlyEQujp7FcbOYeOMDh1tVWdOmCbXtzfMz9VSkO2JFyB/UKtudzxwZNPBDbN0H0QaeuRBij2/tdGhJ30KWgOMacMMEI/rUML8qU+9+J/ubcsrsaz9OISjFlT5ib+uMiMRqjQahwpnpeqB5BCcxF6WYC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfM3orD8; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfM3orD8"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13246950f3cso7973092c88.1
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 15:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778624221; cv=none;
        d=google.com; s=arc-20240605;
        b=T/2Efyc/r2pTy2ptSLlB2SfAiFsVB34yVOIG2/6J3yjMljYNXgVl4USeJqWIWPMLgj
         lK3D7NAHjG7t/R3urBMqY1iYOWCLCRgAOirwL9gEptelnaEoas18ncHiegVV92IhouUs
         byi4AUr2cbAlMG673cuXwuOU6f92R2I3WkVurpfxiHDIue7lJRJ112RbcfptSm68FNKO
         WwKzXHa0m1wuKsn/JG1Pa2jpBuve4I4cqO8kz3gAnBvhUugU1hF9N8h+qksMHxL+BtDE
         3CyV+ZiMTZ2vGZ1kVyyx/OPS1xdBnGwUV9/4I3L1Z2NPXFWMMJpNgnGDWTcSDBbqk3vI
         EtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ObJAjm73ouLKogCFTEjSP3hfRY8j66w83JcFpvEzHZo=;
        fh=NL/Te4oASzsGhS+1KlHH1aKdPVwfM6LCJ+O4O9uEnd8=;
        b=hSr2zZtmTOgZl63Q4mpRPBDuFdgkNSSLKDFuaJ4Edq74APdpSldglMQuhaEH7hBTmR
         Y7fN8tSwYOSbBaS3NwU6fZf5BCXxS1rDI621RN7mcKLlR+Ue/ViyPTbaZovfnezqi3rW
         rTteHmj3wIuhtj4ggZozSiVy9tXJdvUuPSqCBtuC66+8OLiUAZMZTbgByzlcF6i6sQjQ
         YilAA56z1UPTjLwc94eEJNHXm1l3gorCMIbs5PCRwPhelaeXOj4arHD1E0apihwV8sUj
         EM380weHZexFIBfsJWkIvQ587v71PX5/k1GNE8tbN0gIhPRRcxNsCcZKgERmvfWxELwJ
         ATJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778624221; x=1779229021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObJAjm73ouLKogCFTEjSP3hfRY8j66w83JcFpvEzHZo=;
        b=wfM3orD8i1u278R9wTs5HHQ11Re2q7GkCl32yG4Os1h49rpRSIG107hzvxmJdSrI9K
         Qw0cJ8ew9alY42RPVAsryACxZ7keMIjlRpLpnaczLgXBOmAgGJkovgPwUatCYWUsKfFD
         4APLtdNrWwfQuEN5xerx5DjbKcBB2EEaB9x9TAXNFpDuyxEIaIpDXnG/aMAGIJrCfx7U
         A2mh4NJqrNieerkIOyUBuOudBjwXtI+/WNUsYxyD/srDSZmt6m5y7AJJYjECWNLD7IVM
         Qe6ZvI57eVAcDn4/SiNdnWFttnb7zpSQpqX2dVJH4c7fumL6nWwY32QV0ZnUX8QDaV6c
         DBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624221; x=1779229021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ObJAjm73ouLKogCFTEjSP3hfRY8j66w83JcFpvEzHZo=;
        b=OQrJT7FQ9ralenPRmhK5Olkg884g6NoXQR6NF3/5FmOkr/9/btycbSWNc34qrYdsMg
         jGN1yA3zYQNPGZCcGRx4f4aRfi7wzeE0O1cgOqHT3OIBAS3Y7/6b0Dp9c6Y41Hv+sCMV
         PitSd+VxfnGbAN6YjPHBNN/OsZyZBu78hoPZIvTBRix0Cp4vKl8xtHFZE/zP5LNgFrW7
         +OuhkbGrrzdyjxWRSJ5Cv3aL/pHbKrL9lbSMpf7o2g8VnA3tqZe7DPeO0au6R8Zvoi2J
         Ke99PuLkWCdi26eh3Ic6xdur18kO2sQjusZSEcMRQwlheDPlc/akpCZF9KvIyY+E7wOn
         DqHg==
X-Forwarded-Encrypted: i=1; AFNElJ/T87KOwqM7OqQWVa7gFqSVso5ti0enLB5veHrX7LytXeYy6YS9XwsVoCJAD6Yfa1KMo6rC+abojUlK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+1VFIG+3seGhIPfYn8l2n2bXPHwBKWS1JDV4o9EFhL9KkjUMO
	aYF4CErivfA0mXhSI5QcryVHXfw+EsGJItkypL7+Jx0YqUszKnwsmfbOfj4OMf+u/+4SmMMVVCh
	MxdgT2Y28rMyHhkbCHHox/XKrNnYnkh8sOVaUnys=
X-Gm-Gg: Acq92OHaxc6RPzXybE188FPMFxrdgmh1hX02aG149hmVdUjJA2U1q9j5Mhkx64iUDOD
	/5zltdjroaLL9MGHei/agc7g/65W8bCQwbOGmCvc8v2PCf+Y5Mx1IjiVE1h0a2M8O40sRQHUVQb
	MuwwMtns7mE2Nqohv1Towr/60rzQNXpJdtxwNsSi7xTqzi5HrMKl0ZEBIt9eaZTs4/tAhlhv1uO
	41SI9K/rc5stV9Ly77cKyiv8P89fY4GI9rUlV93iULprCgPXqnWAzjmyY1HO4VZ1BHSVxfRB57I
	nnmRUBgNLoSgTXG96hvHdaR5DeliYziYjnpFiivYEGzRbd72oTtFvxVwvtxDSMLx1U6fbXvJodn
	XUva+5C9q+itPWWUMEXhaI1st11kB0huBSYJpfQQS20CPfw==
X-Received: by 2002:a05:7022:43:b0:128:d4be:7428 with SMTP id
 a92af1059eb24-13436781e9bmr586296c88.19.1778624220291; Tue, 12 May 2026
 15:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c00-02.v2.ttenwd4@ub.hpns> <p02-02.v2.g990a0c64420d.ttenwd4@ub.hpns>
In-Reply-To: <p02-02.v2.g990a0c64420d.ttenwd4@ub.hpns>
From: John Stultz <jstultz@google.com>
Date: Tue, 12 May 2026 15:16:47 -0700
X-Gm-Features: AVHnY4K9E2v1wLNwly4ld4TGlYjOrrNGdOQeVUnkF0yNbjLKnCqRtqqqQG5TuFU
Message-ID: <CANDhNCqrh28F=omb7ftuXpbMssA0+5paZTkq5Zr5zee6zZ7=Tg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/core: Don't proxy-exec unmatched cookie lock owners
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vineeth Pillai <vineethrp@google.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 3:42=E2=80=AFAM Vasily Gorbik <gor@linux.ibm.com> wr=
ote:
>
> Core scheduling chooses a core-wide cookie before __schedule()
> installs the next task. With proxy-exec enabled, that task becomes the
> donor/scheduling context, and find_proxy_task() may then replace the
> execution context with the runnable mutex owner. If its cookie differs
> from the selected core cookie, running it would bypass core scheduling's
> cookie selection.
>
> When the final mutex owner found by find_proxy_task() does not match the
> selected core cookie, stop proxying the donor. If the current execution
> context is already in the blocked chain, fall back to idle like the
> existing proxy-exec retry paths do. Otherwise deactivate the donor and
> let __schedule() pick again. The mutex owner can be picked later under
> its own cookie.
>
> Fixes: 7de9d4f94638 ("sched: Start blocked_on chain processing in find_pr=
oxy_task()")
> Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  kernel/sched/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8aed55592ca9..d338fb714ce8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6960,6 +6960,12 @@ find_proxy_task(struct rq *rq, struct task_struct =
*donor, struct rq_flags *rf)
>                  */
>         }
>         WARN_ON_ONCE(owner && !owner->on_rq);
> +
> +       if (owner && !sched_cpu_cookie_match(rq, owner)) {
> +               if (curr_in_chain)
> +                       return proxy_resched_idle(rq);
> +               goto deactivate;
> +       }


Hrm. This is less pretty.

My previous (admittedly shallow) thinking on the core-scheduler was
that it wouldn't be an issue for proxy because the donor wasn't going
to actually run on the cpu, so whatever isolation is done on the core,
the donor migration wouldn't be a problem.

But I'm seeing now the donor won't be *chosen* until it has the right
core_cookie, and then that may be different from the owners cookie.

It seems like ideally we want the donor's effective cookie to be the
same as the runnable-owner's in the chain.  The downside to this is
you have to walk the blocked_on chain to evaluate this, and the whole
core_tree rbtree sorts by cookie, so its not trivial to rework
selection this way.   And since the runnable-owner of the chain-tree
changes over time, we can't just set the inherited cookie when we set
blocked_on.

So I will need to think a bit more on this.

In the short term, I think you're change is probably ok since it makes
sure we don't run tasks with the wrong cookie, but it effectively
stops proxying from having a beneficial effect.

Thanks again so much for raising this issue (along with K Prateek)!

thanks
-john
