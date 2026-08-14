Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF2F4657EA
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711174; cv=none; b=SR9Xyf2Lf4DBBS4Hsxhvov8ZZ2UKzb8wRyv0pspiWFt4ZN4F4Bnk4uNspY6InbsHmwUFiYF/HL4T5aKVsXyuDk/48+su00AnwwIUdzDMA93FSVVBdPQs2jJO7vf/Q81dHSK+vW/KjKeDMjiWNEX3qxB06BzV86OWIPClLJ5B/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711174; c=relaxed/simple;
	bh=TZt0vwuXpv1+Lt+us1uNs1oQJMYkckIEoU0UkmDWKuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PctV1NLVdnBe74pLutPsevbHKxKdfe5F5ijifLRBZVjz72r7tdGZYVJQxuIpys77S9hJIptMaA5x+r5U00g+004B/WeDTqEsgOnC2txp6NLtwfvwraeTxWe7+7K0AFzNsDJt236KVdjnn+mrHuXCBbzmhimHXcGsDuztaODl6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy+A5hEB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy+A5hEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431341F000E9;
	Fri, 14 Aug 2026 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711167;
	bh=Cf9QVmIS94upS+/pXY4EisdMVxTAVNGW9Er0yd6JWaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iy+A5hEBO6vApk1VpvUAVK6/4QRO1gvx5w6znJqxO8BgnyqO5StsZNzHsqtvVxL4k
	 wXRGR+5ug1cH+KD3/Kbdo1Qf/OkNxhQoLfed3k3SlF7cRWnzyaF4wHXkLddmHsTZQr
	 l4z5oAh89Af7iyb6CYj5hkHDa+yoIuYSmXVxipJ3NABYn3V8Q7dhlL3URNTH1ZBkQd
	 9v3GjDA1KQU4oe+2qR7CDiD7aJ0F6A8VkGRMtIuLD5I2qnBzAdxSUukTlAqVA1aQnJ
	 twDANIYG5CRYkf+eGoAnKBpPHSAu+XpkWapsFWvxNLmpTI3jyWupHc7V+CohQ56vw8
	 xsBOpV8jNSjVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/pai: Handle multiple PMU stop callback invocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260814121958.2408863-1-tmricht@linux.ibm.com>
References: <20260814121958.2408863-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 12:39:26 +0000
Message-Id: <20260814123927.431341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting list poisoning crash during system-wide event throttli=
ng due to unsafe list traversal.
--

--- Patch [1]: [PATCH] s390/pai: Handle multiple PMU stop callback invocati=
ons ---
commit 7f302db53fed202e75cc42832375513bbf0c824b
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/pai: Handle multiple PMU stop callback invocations

This commit adds a PERF_HES_STOPPED check in pai_stop() to prevent
back-to-back invocations when throttling and scheduling out occur closely.

> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> index cdb8006220ca0..a377f04296563 100644
> --- a/arch/s390/kernel/perf_pai.c
> +++ b/arch/s390/kernel/perf_pai.c

[ ... ]

> @@ -510,6 +511,13 @@ static void pai_stop(struct perf_event *event, int f=
lags)
>  	struct pai_mapptr *mp =3D this_cpu_ptr(pai_root[idx].mapptr);
>  	struct pai_map *cpump =3D mp->mapptr;
> =20
> +	/* Cope with multiple invocations:
> +	 *   1. perf_event_throttle() --> PMU->stop()
> +	 *   2. task schedules out --> PMU->stop()
> +	 * Check for event already stopped.
> +	 */
> +	if (event->hw.state & PERF_HES_STOPPED)
> +		return;
>  	if (!event->attr.sample_period) {	/* Counting */
>  		pai_pmu[idx].pmu->read(event);
>  	} else {				/* Sampling */

[Severity: High]
This is a pre-existing issue, but does this throttling path cause list
poisoning during system-wide sampling?

When processing system-wide sampling events during context switches,
pai_have_samples() iterates over syswide_list using list_for_each_entry()
instead of the safe variant:

arch/s390/kernel/perf_pai.c:pai_have_samples() {
    ...
    list_for_each_entry(event, &cpump->syswide_list, hw.tp_list)
        pai_have_sample(event, cpump);
    ...
}

If the sampling limit is exceeded, pai_have_sample() can trigger
perf_event_throttle(), which synchronously calls pai_stop().

Just below the diff hunk above, pai_stop() deletes the currently
iterated event from the list:

arch/s390/kernel/perf_pai.c:pai_stop() {
    ...
    } else {                                /* Sampling */
        if (!(event->attach_state & PERF_ATTACH_TASK)) {
            perf_sched_cb_dec(event->pmu);
            list_del(PAI_SWLIST(event));
        ...
}

Since list_for_each_entry() does not protect against node removal, would
returning to the loop in pai_have_samples() dereference the poisoned pointer
and crash the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814121958.2408=
863-1-tmricht@linux.ibm.com?part=3D1
