Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610F3E5A31
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492399; cv=none; b=jjtESaFqBcandY3tHb4Z80+wcybEuojScpB/AdnkrgdX+1RJwH5phwXj2m0DBgq7X9sP2MtTVYOsncKWrefukpFqxHqr2NCJEZkCiFwLwkgT+Bqp1yu5vbemzmpViIdYsWu1Lp27JPhcHxcguxO4MBccTGns3jJjIMoWZ1lwW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492399; c=relaxed/simple;
	bh=Q+CNsKm6/GckiK3TXieTzGG74/KCmGyLF3o2tpJu6Fg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f7GtqDDaOprQagUqpWGKJ9nx2s2c0VEBntGoaAjGp6bBokJpN7inj65NNDbudoZDyUSG5tuCP4IU8MPyimO3s4voq9eli+J8o4uFX+Qu1JJxCkcsmOn2SSudjSEAbiCXOYUDBiDcRY4INu5SQ24U5PTDdedBNLgbOkokbpHAvww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9WW7xqu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9WW7xqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BC91F000E9;
	Fri, 31 Jul 2026 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785492371;
	bh=XIaB78SVcTg+ljvjXvDhgD91fh8ws2pBtU9kQELe6ZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B9WW7xqu4t/T4I/nvis6jXxgMr64qwnu2f1fvfVXZa6z1DQeRC83g+F33mTFz29KG
	 fPwzFodfeXTpLVZvJi2CkRqEmFiSnZvtoN33no9cLtqemWaab3j9LIEmkH+Lcr2w+v
	 Cmm9jJKu/XYfsS9kQZJMTSCXaJXfPJMm7IuJFjDADflcKp+WW2lH/8H5B/FRzEGGhG
	 xupXCF42yHiikC0r0MSzgwTDATk/GETh8qSjWIfjcMBpePWylEguHlmso7iDr+JZGv
	 jyWg1ZDt7/B5jkVzGqnSBXmL/KChBc90zMl/uLvUwF7Ihuduk+13qop5VL+KPC5ucO
	 2TWlzYsMMeM5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260731095101.3338146-1-tmricht@linux.ibm.com>
References: <20260731095101.3338146-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 10:06:10 +0000
Message-Id: <20260731100610.C3BC91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Premature freeing of per-CPU PMU structures leading to Use-Aft=
er-Free and kernel panics on CPU hotplug.
- [Medium] Missing lock during PMU allocation allows a concurrent CPU hotpl=
ug event to silently miss CPUMF initialization.
--

--- Patch [1]: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete ---
commit 176fe6dc007151d7c2038cd88e4587f550bdcba4
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/cpum_cf: Handle CPU hotplug add and delete

This commit tracks the number of active per-task processes using
a new tskcnt counter. When a CPU is hotplug added, it checks if there
are running per-task processes and installs the CPUMF infrastructure
on the new CPU.

> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum=
_cf.c
> index 2076ac22e2c49..bf23ae9a9fd93 100644
> --- a/arch/s390/kernel/perf_cpum_cf.c
> +++ b/arch/s390/kernel/perf_cpum_cf.c

[ ... ]

> @@ -303,6 +304,8 @@ static int cpum_cf_alloc(int cpu)
>  			cpumask_set_cpu(cpu, mask);
>  		}
>  		free_cpumask_var(mask);
> +		if (!rc)
> +			atomic_inc(&cpu_cf_root.tskcnt);

[Severity: Medium]
Could a concurrent CPU hotplug event happen between the for_each_online_cpu=
()
loop in this function and this atomic_inc()?

Since cpus_read_lock() is not held, a newly hotplugged CPU could observe
tskcnt =3D=3D 0 in cpum_cf_online_cpu() and skip allocating its per-CPU
infrastructure.

Once the atomic_inc() completes, tskcnt is > 0 but the new CPU remains
permanently without cpuhw, which could cause perf events on that CPU to
silently fail. Is CPU hotplug synchronization needed here?

>  	} else {
>  		rc =3D cpum_cf_alloc_cpu(cpu);
>  	}

[ ... ]

> @@ -1105,13 +1122,11 @@ static int cpum_cf_online_cpu(unsigned int cpu)
>  {
>  	int rc =3D 0;
> =20
> -	/*
> -	 * Ignore notification for perf_event_open().
> -	 * Handle only /dev/hwctr device sessions.
> -	 */
>  	mutex_lock(&cfset_ctrset_mutex);
> -	if (refcount_read(&cfset_opencnt)) {
> +	/* Allocate per-CPU infrastructure when per-task context active. */
> +	if (atomic_read(&cpu_cf_root.tskcnt))
>  		rc =3D cpum_cf_alloc_cpu(cpu);

[Severity: Critical]
If there are multiple active task-context events (e.g., tskcnt > 1), does
allocating the new CPU infrastructure here correctly account for them?

Since cpum_cf_alloc_cpu() initializes the new cpuhw->refcnt to 1 regardless
of the actual tskcnt, could a single task closing later decrement the refcnt
to 0 and free cpuhw prematurely in cpum_cf_free_cpu()?

If other remaining active tasks are running on this newly hotplugged CPU or
trigger PMU callbacks, could they trigger a use-after-free when accessing
the freed cpuhw?

> +	if (refcount_read(&cfset_opencnt)) {
>  		if (!rc)
>  			cfset_online_cpu(cpu);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731095101.3338=
146-1-tmricht@linux.ibm.com?part=3D1
