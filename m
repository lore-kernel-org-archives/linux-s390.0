Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D31F938
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813831; cv=none; b=ue0NgHvTN9qHN3Cj5NcTfYW9gMrto2VkKNh07/7OHEfB5zbSmZ4d2ZHfUqH2VEQWBPPKwZQioBhzfQB8hUIeIwgxQ35v337qcXHqjYbdJPndo9ckt3F+uRnmBFzDstNj7rxNLnQYWkky3Kxt+uq/1jLFermT5t6nccefPDtEO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813831; c=relaxed/simple;
	bh=JPFS6K7D7CcT/92n7R3NYhbrRIAFJFpfNoCaOfWHv30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ml7tuGIRBAiNjvfJZOGyG2uZBg2QpDsPYKo5gQwC5z/gYqFYugiGYJAnBTHio6kIqXxB6Q9ZsV16IeTdnbXNz187yu6qsKYlONhP5CScbFeNuWiAAHXFrtc7HWlAKjnHOHnZLoYPefFwCR7iDJhoOPjxm3cIAyNjoqr7Y4CQ7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKYTzqUs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKYTzqUs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E561F000E9;
	Thu, 27 Aug 2026 06:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787813830;
	bh=dg/K4VDL4NExcPbpkmvJ4j1RYnOn9UWABm5nZIdtnqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QKYTzqUsHssB/LxywfIaJdTPqDgK6yrs6KKPIs9a6y05VaMbVvi+WXeSZdMUvvlqH
	 lUbb84BWEF73BdZevZ2/pEEriXgV+YDZP3gxyzZ6yUHAmA+Yro+jUqz3cuKlPKOsfM
	 SsZ9769yZ2Yc4dWH+QfR0/OuloxMKz7Oh5/QjYPDWdEw8fjXN+swu8ZFKhh4Jw9PFT
	 +y0BUhY4T7iS6v23RZ1zLezMeyOH8oClroTCSIe7JglZgQZVWEIILAtY90DDOjL/Gn
	 wfesj5aqP5QWID7crHLVsx9n973tn4E2KJDuTPZGLafm5baLt1dgVTUSqZ25JMDZkV
	 l9etRNkZ57jbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/pai: Prevent ioctl(PERF_EVENT_IOC_REFRESH)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260827064612.3161950-1-tmricht@linux.ibm.com>
References: <20260827064612.3161950-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 06:57:09 +0000
Message-Id: <20260827065709.D6E561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unprotected modification of core perf_event state (pending_kill, e=
vent_limit) causes data races, dropped signals, and silently breaks the PER=
F_EVENT_IOC_REFRESH API.
--

commit ae843d6ca679921720078776be6911f36a1931c1
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/pai: Prevent ioctl(PERF_EVENT_IOC_REFRESH)

This commit prevents ioctl(fd, PERF_EVENT_IOC_REFRESH, XXX) from taking eff=
ect
on PAI PMU events by clearing event->pending_kill and event->event_limit. T=
he
intention is to prevent counter resets that conflict with the schedule-out
readouts these PMUs are designed for.

> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> index cdb8006220ca0..e43b2f1c94471 100644
> --- a/arch/s390/kernel/perf_pai.c
> +++ b/arch/s390/kernel/perf_pai.c
> @@ -658,6 +658,8 @@ static void pai_have_sample(struct perf_event *event,=
 struct pai_map *cpump)
> =20
>  	if (!event)		/* No event active */
>  		return;
> +	event->pending_kill =3D 0;	/* prevent ioctl(IOC_REFRESH) */
> +	atomic_set(&event->event_limit, 0);

[Severity: High]
Does this unprotected modification of core perf_event state (pending_kill,
event_limit) cause data races, dropped signals, and silently break the
PERF_EVENT_IOC_REFRESH API?

Bypassing core perf locking rules to directly mutate event_limit and
pending_kill causes data races, silently drops pending SIGIO signals, and
breaks the API contract. The ioctl will return success, but userspace will
never receive the requested signal, leading to application hangs.

If a userspace application calls ioctl(fd, PERF_EVENT_IOC_REFRESH, N) on a
PAI event, and concurrently, a context switch calls pai_have_sample(),
writing to event_limit will race with atomic_add() in the core subsystem,
and clearing pending_kill will race with perf_event_wakeup().

PMU drivers should not directly mutate these core fields to implicitly break
an ioctl. This approach creates cross-CPU data races because it lacks the
synchronization (ctx->mutex for limits, irq_work execution order for signal=
s)
used by the core subsystem. Any user with access to the PAI PMU can trigger
this state corruption.

>  	pp =3D &pai_pmu[PAI_PMU_IDX(event)];
>  	rawsize =3D pai_copy(cpump->save, cpump->area, pp,
>  			   (unsigned long *)PAI_SAVE_AREA(event),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827064612.3161=
950-1-tmricht@linux.ibm.com?part=3D1
