Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51EF3A8FE1
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965317; cv=none; b=ejMw9ao9OXEUMEdPaZDKyQFH5hzbmaSV4eE4Z3/+uCP8D1px5iYrhXesuA0o/uS6X+vKWT8CW81Cth+zBEw+tqaMx5c1g58ttnKjEIfen9ZJXOd8kfvuqY43GvCHXRnkY0hfGL5+aWAnfiA9dr3qf14FSQPYwPbUtVO9Ban7fHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965317; c=relaxed/simple;
	bh=u61wzKqh37VRA5oq/xmqMY+0xmfva1N60dNCKSeA+6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BxLzpI5ZxddRw7nKEdhy5AOfIE3VPDLabPV4tRnnYVz4SFNBbSBLBvU/diaNk5jJnT/xYtdUzde7VEmRTPjBcMaJ3otuED2SgvPRJAz1QMMSUXpXw/irB1P0hfIkgiGdnmSdTqNmzsy/JWC6I3onyPNcBPMH2goRzR0dZO5uLIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeVEDYDM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeVEDYDM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149EB1F000E9;
	Mon, 17 Aug 2026 11:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786965315;
	bh=Rao/wOXTYZO9PwzBe4otNi7R9Tr8PXQSD1cjyTZV/G0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AeVEDYDMz+O/rhQgErbcp+R6ELsWr1v25HNexIX/lgNrY7WIl3zLUAIlWDw8ztU51
	 sjHGg8gNNpG6ahZwfZlre8cUgdcwXUtZrkKiTNsxlYipTWE9WnlXUueOZ4Z+1x/9BF
	 X1hg5LLptlOmSaBPsnCLX2+2lESpZmlTMyjXVaYZb971LUamjt6l6VZJwh3YED1hiy
	 XLeazYwJ4CyeBu5ak5w76YkEY4SVrObSV7TBA24dmrOWrIhMuVtbmXjcbAOnp3zAvZ
	 99Sc8BQaMxl4NuNO0nArGFUoXF8rqAHFvUwsLx7zeBRDU35vNJbX2rNB4pQ4Oo9b8E
	 /SwbNilNIHxrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] s390/pai: Handle multiple PMU stop callback
 invocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260817105904.3933179-1-tmricht@linux.ibm.com>
References: <20260817105904.3933179-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 11:15:14 +0000
Message-Id: <20260817111515.149EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Unnecessarily enabled context switch callback for system-wide co=
unting events.

Pre-existing issues:
- [High] LIST_POISON dereference crash during list iteration due to group t=
hrottling.
- [High] Uninitialized list deletion causing a NULL pointer dereference.
--

--- Patch [1]: [PATCH v3] s390/pai: Handle multiple PMU stop callback invoc=
ations ---
commit 56c4e8b2eb99bf60f554c282666c15e39068225e
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/pai: Handle multiple PMU stop callback invocations

This commit handles back-to-back invocations of the PMU stop callback caused
by perf_event_throttle() followed by the task scheduling out. It adds a che=
ck
for PERF_HES_STOPPED on entry to pai_stop(), and moves context switch callb=
ack
registration into pai_add() and pai_del(). It also attempts to fix an unsafe
iteration in pai_have_samples().

> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> index cdb8006220ca0..388941d9aec18 100644
> --- a/arch/s390/kernel/perf_pai.c
> +++ b/arch/s390/kernel/perf_pai.c

[ ... ]

> @@ -492,6 +491,9 @@ static int pai_add(struct perf_event *event, int flag=
s)
>  			local_ctl_set_bit(0, CR0_PAI_EXTENSION_BIT);
>  		}
>  	}
> +	/* Enable context switch callback for system-wide sampling */
> +	if (!(event->attach_state & PERF_ATTACH_TASK))
> +		perf_sched_cb_inc(event->pmu);

[Severity: Medium]
When moving perf_sched_cb_inc() into pai_add(), the check for
event->attr.sample_period was dropped. Does this unnecessarily enable the
context switch callback for system-wide counting events?

The core scheduler might pointlessly iterate over the callback list for eve=
nts
that do not need it, adding overhead on every context switch.

>  	if (flags & PERF_EF_START)
>  		pai_pmu[idx].pmu->start(event, PERF_EF_RELOAD);
>  	event->hw.state =3D 0;

[Severity: High]
This is a pre-existing issue, but does setting event->hw.state =3D 0
unconditionally bypass the new PERF_HES_STOPPED protection in pai_stop()?

If PERF_EF_START is not passed (for instance, an inactive sibling in a group
scheduled in via group_sched_in), the event is never added to syswide_list.

When pai_stop() is called later, the early return check for PERF_HES_STOPPED
fails, and list_del() is called on an uninitialized list head.

[ ... ]

> @@ -672,9 +683,9 @@ static void pai_have_samples(int idx)
>  {
>  	struct pai_mapptr *mp =3D this_cpu_ptr(pai_root[idx].mapptr);
>  	struct pai_map *cpump =3D mp->mapptr;
> -	struct perf_event *event;
> +	struct perf_event *event, *e2;
> =20
> -	list_for_each_entry(event, &cpump->syswide_list, hw.tp_list)
> +	list_for_each_entry_safe(event, e2, &cpump->syswide_list, hw.tp_list)
>  		pai_have_sample(event, cpump);

[Severity: High]
This isn't a bug introduced by this patch, but does this safe iteration
protect against group throttling deleting the cached e2 element?

Pushing a sample in pai_have_sample() can trigger perf_event_overflow(),
which invokes perf_event_throttle_group(). This synchronously stops all
siblings, calling pai_stop() on each.

If the adjacent list sibling (e2) is in the same group, pai_stop() removes
it from syswide_list via list_del(). When list_for_each_entry_safe() advanc=
es
to e2, its next pointer would be LIST_POISON1, potentially crashing the
kernel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817105904.3933=
179-1-tmricht@linux.ibm.com?part=3D1
