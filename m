Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C443CF201
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119912; cv=none; b=Q1qTBZ5ScM1RaSaNuuxitVyuuYE4GxaEMedR9s5LXLgsXdXG8e5Ri6fuuMc7ZKyPQ4LC2TboM4MAtFEpw5QevlhaRByi9GwATGSukwGj8SgnFt//YUAtKJRVvGx6Tw4j6JYWB/MT8xCH2PLzzyLovH4lABGIh+DIqBBVumYBsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119912; c=relaxed/simple;
	bh=+8j4dDTCE5PdOnoyZmM20CItSEm6fuViwzRq6tJigGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s5610ViQ4BDo/UqauByZvmFNH6fXzudghjKjv5qm93E5Gz+Zv/DbkahzgBSyeRdRM6Ic5ZSI8oSHUHhZtDou6mgy6kPHBdToygnB4YtgA0AoEEswemWbAFRim1+ZquLPU+QCEwD7PJ7x6KJ2ZCafD/IjB7XdBg/O/KtFVHPD4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFmbDPkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFmbDPkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2851F00ACA;
	Wed, 19 Aug 2026 06:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787119907;
	bh=tPRcB09e+K7pIEJn1NUcX9fw1pO3CFGamLqLkIDVv6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WFmbDPkbVrA+JZKgu0xiDImGS1bOG23XfTvaORpYCC57TgSIYaTTHJdj0JAXJDed0
	 FliW/FD81zlwtlcGKHC9bkc2TbJFgOvY+dDo/a2xabaBiFmhMsubAi9avgcPy553ew
	 7gSS9LCUUdGHgvgbnoJ0sTepuRzLM/MM7+F8urZj5DNwKjIkuaEBU+dzyQvCoQWQ4u
	 0MKGAwqET4H7Z4uLjh3SEyRpCE76J0KH4XTGuA6FrkM0N+xsRPlS2kP8G4Pktcstsz
	 qphXpBmbug/ClDUdYvd8wAW2BurZ8F+sQGKwmDN5HGFbdL7Ocj6Qtaj3CatvEuJzSQ
	 hk2f2Um0gLd+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] s390/pai: Handle multiple PMU stop callback
 invocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260819055855.1001578-1-tmricht@linux.ibm.com>
References: <20260819055855.1001578-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:11:47 +0000
Message-Id: <20260819061147.9E2851F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] `list_for_each_entry_safe` in `pai_have_samples()` is insufficie=
nt to prevent list corruption (dereferencing `LIST_POISON1`) when group thr=
ottling removes sibling events concurrently.
- [Medium] The patch fails to prohibit setting `event_limit`, leaving the u=
nsupported `pai_stop()` invocation pathway open via `PERF_EVENT_IOC_REFRESH=
`.
--

--- Patch [1]: [PATCH v4] s390/pai: Handle multiple PMU stop callback invoc=
ations ---
commit 8cb65fa5b6a22b922174b5e65e7e2b3d844b3c12
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/pai: Handle multiple PMU stop callback invocations

This commit handles back-to-back PMU stop invocations during task
scheduling and event throttling. It also attempts to prevent the
PERF_EVENT_IOC_PERIOD ioctl for specific events and switches to safe
list iteration in pai_have_samples().

> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> index cdb8006220ca0..05f74d74fad13 100644
> --- a/arch/s390/kernel/perf_pai.c
> +++ b/arch/s390/kernel/perf_pai.c

[ ... ]

> @@ -672,9 +680,9 @@ static void pai_have_samples(int idx)
>  {
>  	struct pai_mapptr *mp =3D this_cpu_ptr(pai_root[idx].mapptr);
>  	struct pai_map *cpump =3D mp->mapptr;
> -	struct perf_event *event;
> +	struct perf_event *event, *e2;
> =20
> -	list_for_each_entry(event, &cpump->syswide_list, hw.tp_list)
> +	list_for_each_entry_safe(event, e2, &cpump->syswide_list, hw.tp_list)

[Severity: Medium]
This is a pre-existing issue, but is list_for_each_entry_safe()
sufficient here if group throttling occurs concurrently?

Since this only protects against the removal of the current entry, if
perf_event_throttle_group() synchronously removes the sibling event
(which is temporarily held in e2), could this result in dereferencing
LIST_POISON1 on the next iteration?

>  		pai_have_sample(event, cpump);
>  }
> =20
> @@ -691,6 +699,17 @@ static void paicrypt_sched_task(struct perf_event_pm=
u_context *pmu_ctx,
>  		pai_have_samples(PAI_PMU_CRYPTO);
>  }
> =20
> +/* Prevent ioctl(fd, PERF_EVENT_IOC_PERIOD, ...) call.
> + * It sets perf_event::event_limit to a positive value and causes
> + * perf_event_overflow() to invoke pai_stop() call back function when
> + * perf_event::event_limit hits zero. This is not supported because the
> + * sample events CRYPTO_ALL and NNPA_ALL are always taken at schedule out
> + * of a task.
> + */
> +static int pai_check_period(struct perf_event *event, u64 value)
> +{
> +	return -EINVAL;
> +}

[Severity: Medium]
This isn't a bug introduced by this patch, but does this fully prevent
userspace from setting event_limit to a positive value?

While this correctly blocks PERF_EVENT_IOC_PERIOD, could a user still
trigger the unsupported behavior by using PERF_EVENT_IOC_REFRESH, which
also modifies event_limit and bypasses this check?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819055855.1001=
578-1-tmricht@linux.ibm.com?part=3D1
