Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEE37B41E
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093349; cv=none; b=pojM76xgOvJa+kR8J1CnPBp91IR2CT0v6cYJQg/HylR3l7ber8F3uUybqOtDIxG1xQzv1gvCtVcdBHIjiZe8NXydJyz1On7SpxGmZfEec6mlDr5PKH76tlATsevds6leI5kXDzMmH2Z+JR58OQ2Z3mO9xF5nxXILXyqp6dHCIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093349; c=relaxed/simple;
	bh=rp+Oou3GS5NuL3ZdU/8vKxcJass/YsECkB0ZM06yK4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MxzEljxAw2YMcZFosTZYwkf+9OCSw3YgqjmtcUzeVvXb8OalGQJh1xwTs8/JXnSJvXAREAQzq6T4tFtZIA1Xo1UDHrZn5GVznf2AB4hrdChm4dmiTBffC7JbROganGjyuHUntXlKk5/U4Y3BM8Rpib6RTgktcQitFDprApc1uI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX9f+LYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX9f+LYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46F21F000E9;
	Fri,  7 Aug 2026 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786093348;
	bh=hjSnq8MMlW6tXtKh5f29gBBizElxirE7udcn5E8Yzl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eX9f+LYnBKVu2CIFPK6tS/q2CPDtI+sG7Mj8DUxFKg51qurcLr7vr7amtoyCKzoY+
	 Gx4LsEyPLMq8dquiZzRTV+YBOPTaz8LhfO+CHqg7VjenT/rVq/xbM/qyNTs7v2Xwh0
	 jp4opUlSkzcS5I0MSxHNlaf7DfrDRnGtQWJv4CPOnlh0LLX8s25aNRn2DlYQq6Somc
	 jkSOAM/rSnN7Pl7QUgvJm7lZnVN6qYwQFMZWU0CKESbJMOPvgDRvbwlVSW+XcICLTw
	 lCyECDiQZ8voAzgfnRjQKpS3+3lSRflMP3hBg17TQqrc+ubMVmEGOOlyK07kUceqX2
	 iyejAxnQND8pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] s390/pai: Move locking to event init and delete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260807083910.3771502-2-tmricht@linux.ibm.com>
References: <20260807083910.3771502-1-tmricht@linux.ibm.com>
 <20260807083910.3771502-2-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:02:27 +0000
Message-Id: <20260807090227.A46F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing CPU hotplug support causes a NULL pointer dereference in `=
pai_add()` when a task with an active PAI event migrates to a newly onlined=
 CPU.
--

--- Patch [2]: [PATCH 2/2] s390/pai: Move locking to event init and delete =
---
commit fa13d9fdfca46f4567335a92efab0ab04b313967
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/pai: Move locking to event init and delete

This commit moves the mutex locking from the per-CPU allocation functions
to the higher-level event allocation and deletion routines. No functional
changes are introduced.

> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> index 7c13f5586c793..03c5bda53cccb 100644
> --- a/arch/s390/kernel/perf_pai.c
> +++ b/arch/s390/kernel/perf_pai.c

[ ... ]

> @@ -390,10 +388,12 @@ static int pai_event_init(struct perf_event *event,=
 int idx)
>  		}
>  	}
> =20
> +	mutex_lock(&pai_reserve_mutex);
>  	if (event->cpu >=3D 0)
>  		rc =3D pai_alloc_cpu(idx, event->cpu);
>  	else
>  		rc =3D pai_alloc(event);

[Severity: High]
This is a pre-existing issue, but does the current design lack CPU hotplug
support?

Looking at pai_alloc() called here, it only allocates memory for currently
online CPUs:

pai_alloc() {
...
        for_each_online_cpu(cpu) {
                rc =3D pai_alloc_cpu(idx, cpu);
...

If a task-bound PAI event is created and a new CPU is hotplugged later, the
per-CPU mapptr for the new CPU appears to remain NULL.

When the task with the active event is scheduled onto the newly onlined
CPU, the perf core will call pai_add(), which seems to unconditionally
dereference cpump:

pai_add() {
        struct pai_map *cpump =3D mp->mapptr;
        struct paiext_cb *pcb =3D cpump->paiext_cb;

        if (++cpump->active_events =3D=3D 1) {
...

Can this result in a kernel panic due to a NULL pointer dereference when
a task migrates to a newly onlined CPU?

> +	mutex_unlock(&pai_reserve_mutex);
>  	if (rc) {
>  		free_page(PAI_SAVE_AREA(event));
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807083910.3771=
502-1-tmricht@linux.ibm.com?part=3D2
