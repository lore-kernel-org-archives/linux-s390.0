Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4661A2AD00
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605718; cv=none; b=AniPeBouZ41k2OIz3gS8QLUa8aJs3k87aD+ejoT/3HLONg0ENQzfe8qHWoPTyiVPfIMUfei39DUYnsW9JfOQBaYfRez2Zg4urqDfzsAxmOhbw/dRkMfa69AIaNglsqz8ZFcXxosmyMA8E8pGorTuWJHTzZNBOIm1aitWriPqtA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605718; c=relaxed/simple;
	bh=/JStKfrxy/nASbvZhwdbvaq1+6rTiTPyuU7FyfEmxro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IFWh1fEvlqA1EUa+xYEwf/WgrX6r6xVkMTRA+Gykj/rZpOuZ2AYu0jTyehAbE+ALbCrmZf0j5MLsY8iYL93Qyq2ZGUDwQoq5EoVga5uth6VHPrCZkhOBKweHvEl3PpAC04F965WvW/MeuEJHdU4cRSHmZgmzkZmucql1yJv3mPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjuB0hvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjuB0hvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4311F000E9;
	Thu, 13 Aug 2026 07:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786605716;
	bh=enmRVM2587KNgY6p/Kewcv1SG7ZanS99H3KwyNWp4h0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjuB0hvISHhAthKttZyCkfO8LG9TD3zX1m1giK01OijwUykoqx/4pHtILzg/N3/td
	 FVNLoTDVdZUiCPopo25VUZJps7Oqk51y8eA49Vo+1fUB/lgY2whQj2iiEnEOhFHkYf
	 1WbXKCWV8D4adX7CwwMZwhTisnXB+C0Zyul6/p8Q8b5lH9qB1LSnKangTc12wrnzGA
	 Zih1MBjhvcy+iuWioE9HbbzlF7sAUNRN5oLjDUWog8Azf1KEoPjaNOlvipOipmqLDi
	 vAr2J0aC7RgmMVMYiS+EDdDJEH8dnLkcIj7dLAq8EC54DpiVi4acysd1moE+BWG4pt
	 Sz/nB1XUQKBxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/pai: Handle multiple PMU stop callback invocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260813070815.2692398-1-tmricht@linux.ibm.com>
References: <20260813070815.2692398-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 07:21:56 +0000
Message-Id: <20260813072156.9C4311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe iteration over `cpump->syswide_list` in `pai_have_samples()=
` leads to a kernel crash (LIST_POISON dereference) if an event overflows a=
nd is synchronously throttled during the loop.
--

--- Patch [1]: [PATCH] s390/pai: Handle multiple PMU stop callback invocati=
ons ---
commit 8c88016c23029bda1d214155e79ad2671b8e3eb5
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/pai: Handle multiple PMU stop callback invocations

The kernel protects itself against high sampling load by throttling it via
perf_event_throttle(), calling PMU->stop(). Shortly after, the task may be
scheduled out, resulting in a second PMU->stop() invocation. This patch adds
a check for the PERF_HES_STOPPED bit to prevent duplicate handling.

Cc: stable@vger.kernel.org # v6.19+
Fixes: ac03223f0723 ("s390/pai_crypto: Add common pai_stop() function")

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

[Severity: High]
This is a pre-existing issue, but can this synchronous throttle event
corrupt the list iteration during sample processing?

Looking at the iteration in pai_have_samples():

arch/s390/kernel/perf_pai.c:pai_have_samples() {
    ...
    list_for_each_entry(event, &cpump->syswide_list, hw.tp_list)
        pai_have_sample(event, cpump);
    ...
}

If an event reaches its sample limit, perf_event_overflow() triggers
synchronously, invoking perf_event_throttle() which then calls pai_stop().

When pai_stop() is called for a system-wide sampling event, it executes:

    list_del(PAI_SWLIST(event));

Will deleting the event currently being iterated leave the list pointer
at a poison value, causing a panic when the loop in pai_have_samples()
continues? Does pai_have_samples() need to use list_for_each_entry_safe()
instead?

>  	if (!event->attr.sample_period) {	/* Counting */
>  		pai_pmu[idx].pmu->read(event);
>  	} else {				/* Sampling */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813070815.2692=
398-1-tmricht@linux.ibm.com?part=3D1
