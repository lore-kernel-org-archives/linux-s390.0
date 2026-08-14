Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923DB35CB7C
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716620; cv=none; b=RUNU+rmw0THtOfxuyf3+JP0Zo8X52oopRxxRq7cWETjnTnuVxuHioe26zKM2/dktquJrF9G8+BmgrwQv9h+SwDA7sMJh+TRXqduJgvxfOKtoNKnMtOIBzb2S24yvD+B2LvDyhMnIXYnAbCXZ4P55qKciqOSfTuxZTSgMjcp5lWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716620; c=relaxed/simple;
	bh=xwc/uSs9+N+t1XPyb3QKxExKPbG/g23xrUkSVpeAcE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YVtP3D/aodmJa96fpNem4AI4xrtrkGQG26/r5FMsvF7ESxgX7FdWSLaNt9la4KDnTj8HUgRgMw5EzJcQ3nCJ48N8FXYwJ1EFxU2ZLGLaWfUspoLDp26Ylgz7zNyLsktZQMbK3THtmgozWs7BfLA5bmzwahRYdhNmS0NNwzR9cs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yme0ax8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yme0ax8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F591F000E9;
	Fri, 14 Aug 2026 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786716619;
	bh=I5GomHFlMT3nlSqWIrdPqzuCNAuSsRhqIaDHDCzVQ6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yme0ax8fdDVV76UY9PAUGvyKfXIe1HRGvU48wkAOJE9dV69XPIyK62CupsClIbZHB
	 YwQCHbN3yHktrdUU3go917ov8SOdE7n6E0Y7YE17n+wlzfZS26gnVATQFisyu85Eqt
	 xz6+vLZvljjWz/4hbraPmYYHVF9S979rufVWG3Zhberd5PMYv9Vx4tMmIqijROFxjj
	 IYFwEmi6QbybOFwhpvS7/AHissUcmbWSGXVKtT3tL37RKYsSyUj51Q7l78Ic1uKJzV
	 4DGDvItFX4FFweGar4gtaL3BiZA8cJ+7rrrlQmpudJEDqZDTpEC/3joXoHTLN6Gmg2
	 C5B0DjxzH0/WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/pai: Handle multiple PMU stop callback
 invocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260814135027.2910179-1-tmricht@linux.ibm.com>
References: <20260814135027.2910179-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:10:18 +0000
Message-Id: <20260814141018.C5F591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch uses `list_for_each_entry_safe()` to fix local iteration=
 of `syswide_list` in `pai_have_samples()`, but fails to address a critical=
 core perf list corruption. Synchronously calling `perf_sched_cb_dec()` ins=
ide `pai_stop()` during throttling deletes the PMU from the core perf's `sc=
hed_cb_list` while it is being actively iterated, causing a `LIST_POISON1` =
dereference.
--

--- Patch [1]: [PATCH v2] s390/pai: Handle multiple PMU stop callback invoc=
ations ---
commit a01c8fd8b7dcb185446a23cc1b40824b995801a5
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/pai: Handle multiple PMU stop callback invocations

This commit adds a check for PERF_HES_STOPPED in PMU->stop() to handle
multiple back-to-back invocations from throttling and scheduling. It also
changes pai_have_samples() to safely iterate syswide_list to prevent list
corruption during synchronous throttling.

> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> index cdb8006220ca0..6d0bf4ddec8f2 100644
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
>  		pai_have_sample(event, cpump);
>  }

[Severity: High]
This is a pre-existing issue, but does fixing the local syswide_list
iteration here still leave a similar list corruption in the core perf code?

If a system-wide PAI sampling event with a low sample period overflows
during a context switch (while inside this pai_have_samples() loop), it
can trigger perf_event_throttle(), which synchronously calls pmu->stop().

In that path, pai_stop() calls perf_sched_cb_dec(event->pmu), which mutates
the core sched_cb_list:

arch/s390/kernel/perf_pai.c:pai_stop() {
    ...
    } else {                                /* Sampling */
        if (!(event->attach_state & PERF_ATTACH_TASK)) {
            perf_sched_cb_dec(event->pmu);
    ...
}

However, perf_pmu_sched_task() in kernel/events/core.c iterates that same
sched_cb_list using an unsafe list_for_each_entry() loop:

kernel/events/core.c:perf_pmu_sched_task() {
    ...
    list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
        __perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_in);
    ...
}

Could this synchronous perf_sched_cb_dec() call from pai_stop() during
throttling still cause a LIST_POISON1 dereference crash inside
perf_pmu_sched_task()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814135027.2910=
179-1-tmricht@linux.ibm.com?part=3D1
