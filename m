Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3360427FBB
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766741; cv=none; b=SfWE4k5Wo3E4Sldey4los2AvIt/zvfmBAhjjqyS9tUtroHg47hdxoKc2Vy2AkZFRDb3N1a6B9Nt0GyDKTVKcvZOl+VaSvVq+cNox/m5ylSQORvscy497/SzXu5Xj570viR50ez+EE5U5QdzlThh9deYqIQdPvjCKAN9NDJPpiyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766741; c=relaxed/simple;
	bh=SkyvK0dRAfUi0j+FKCXPW42BvqJ007dDumEjuxoltAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JtLXERj61ra6RbBoZ5+XO857xTqSxu3CWG91+cbcCANwDV2cHp7IiMNiYCjmBaDaowkCJJm8c9u1xLhO9zdQY2BhwrgAAJAy0HIeWIIssNMGisncoDz1BVv7HcLR3Lc+3mCRu6fswGyxp5nb8q3PPJobAgXdwSiJ4NvqkrlWjdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+xzqodf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+xzqodf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B501F00ACF;
	Mon,  3 Aug 2026 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766739;
	bh=ZLbAOjylrk/FqJSGltUqRkj7HFP2+oXOmT7o6KoYTn8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c+xzqodfPn6GCBmLxW1+dYNnaK/Dq+v0hXZV9obusxkoyf8Z1AR4WxmY3e2qL/gUi
	 nfTvB55smofiQypwh8zQiP5n7qhcboc42Y1I4IArd/wDdhs9WIdLX+4y12VO7nlEfD
	 fxmh1MHqdKCYWObMRxeAOkjPupyuvXHFPgHogLSjQze5y/l6xb63qBjJ50M8OmZYUW
	 iLEQWTI5o8r54k9alwrgVWaLSTD8Efojy61yLJPO9oij5MJbvNyQ2B7fPxxwoUOR5M
	 KINI7c8rGpEtlCrjBKQ6hSUNQgV1q8+U9n52gtgxWnjn56SDPMGLwEXvS3exdXR9ju
	 feXaRPZJ59jpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete 5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803134932.2385616-1-tmricht@linux.ibm.com>
References: <20260803134932.2385616-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:18:58 +0000
Message-Id: <20260803141859.41B501F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The CPU hotplug handler incorrectly initializes the per-CPU PMU st=
ructure refcount to 1, leading to premature freeing and subsequent UAF/NULL=
 dereference for active events.
- [High] Kernel panic in cpumf_pmu_stop() during CPU offline teardown becau=
se cpuhw is freed before the event is stopped.
- [Medium] The CPU hotplug handler misinterprets `cpu_cf_root.refcnt` as a =
count of per-task events, erroneously allocating structures for hotplugged =
CPUs when only per-CPU events exist.
- [Medium] Concurrent per-task event initialization and CPU hotplug can dou=
ble-allocate CPUMF references, leading to a permanent memory leak.
--

--- Patch [1]: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete 5 ---
commit 4991a250e6aaf68659c77722e073f5976ce4c570
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/cpum_cf: Handle CPU hotplug add and delete 5

This patch addresses a kernel crash that occurs when CPUs are hotplugged
during a per-task perf session. It modifies the CPU hotplug add and delete
handlers to allocate and free the CPUMF per-CPU infrastructure when per-task
processes are active.

> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum=
_cf.c
> index 2076ac22e2c49..817978039744f 100644
> --- a/arch/s390/kernel/perf_cpum_cf.c
> +++ b/arch/s390/kernel/perf_cpum_cf.c
[ ... ]
> @@ -1105,13 +1121,13 @@ static int cpum_cf_online_cpu(unsigned int cpu)
>  {
>  	int rc =3D 0;
> =20
> -	/*
> -	 * Ignore notification for perf_event_open().
> -	 * Handle only /dev/hwctr device sessions.
> -	 */
>  	mutex_lock(&cfset_ctrset_mutex);
> -	if (refcount_read(&cfset_opencnt)) {
> +	/* Allocate per-CPU infrastructure when event task active. */
> +	mutex_lock(&pmc_reserve_mutex);
> +	if (refcount_read(&cpu_cf_root.refcnt))
>  		rc =3D cpum_cf_alloc_cpu(cpu);

[Severity: High]
Does this incorrectly initialize the per-CPU PMU structure refcount to 1?

If a user creates multiple per-task perf events, the global number of active
events is N > 1. When a new CPU is hotplugged online, cpum_cf_alloc_cpu()
allocates cpuhw for this CPU but sets its refcount to 1 instead of N.

When the user closes any single event, cpum_cf_free() iterates over all
online CPUs and decrements the refcount by 1. On the newly hotplugged CPU,
the refcount drops from 1 to 0 and cpuhw is freed, even though N-1 events
are still active.

When one of these remaining events is disabled, rotated, or scheduled out,
cpumf_pmu_stop() is called and dereferences the NULL cpuhw pointer, causing
a panic.

[Severity: Medium]
Does this misinterpret cpu_cf_root.refcnt as a count of per-task events?

The cpu_cf_root.refcnt counter tracks all CPUMF allocations, including
per-CPU events. If a user creates a per-CPU event on CPU 0, the root
refcount becomes > 0.

If CPU 1 is then hotplugged online, this check sees the non-zero refcount
and assumes per-task events exist, allocating a cpuhw on CPU 1.

When the per-CPU event on CPU 0 is eventually destroyed, cpum_cf_free()
only cleans up CPU 0, permanently leaking the cpuhw allocated on CPU 1.

[Severity: Medium]
Can concurrent per-task event initialization and CPU hotplug cause a double
allocation here?

When a new CPU comes online, it is added to the online mask before the
architecture-specific CPUHP callbacks are executed. If a per-task perf event
is initialized concurrently, cpum_cf_alloc() iterates over the online CPU
mask without holding hotplug locks:

	if (cpu =3D=3D -1) {
		if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
			rc =3D -ENOMEM;
			goto out;
		}
		for_each_online_cpu(cpu) {
			rc =3D cpum_cf_alloc_cpu(cpu);

It will observe the new CPU in the mask and allocate a cpuhw with a refcount
of 1. Shortly after, the CPU hotplug thread executes cpum_cf_online_cpu()
for the new CPU. It sees cpu_cf_root.refcnt > 0 and unconditionally calls
cpum_cf_alloc_cpu() a second time for the same CPU, incrementing the refcou=
nt
to 2.

When the single event is later destroyed, the refcount only drops by 1,
permanently leaking the cpuhw structure.

> +	mutex_unlock(&pmc_reserve_mutex);
> +	if (refcount_read(&cfset_opencnt)) {
>  		if (!rc)
>  			cfset_online_cpu(cpu);
>  	}
[ ... ]
> @@ -1130,13 +1146,15 @@ static int cpum_cf_offline_cpu(unsigned int cpu)
>  	 * perf_event_open() created events. Perf common code triggers event
>  	 * destruction when the event file descriptor is closed.
>  	 *
> -	 * Handle only /dev/hwctr device sessions.
> +	 * Handle /dev/hwctr device sessions.
>  	 */
>  	mutex_lock(&cfset_ctrset_mutex);
> -	if (refcount_read(&cfset_opencnt)) {
> +	if (refcount_read(&cfset_opencnt))
>  		cfset_offline_cpu(cpu);
> +	mutex_lock(&pmc_reserve_mutex);
> +	if (refcount_read(&cpu_cf_root.refcnt))
>  		cpum_cf_free_cpu(cpu);

[Severity: High]
Does this prematurely drop the refcount and potentially free cpuhw before
the perf events are stopped?

During a CPU offline operation, teardown callbacks are executed in reverse
order. cpum_cf_offline_cpu() is registered at CPUHP_AP_PERF_S390_CF_ONLINE,
which runs before the perf core's teardown at CPUHP_AP_PERF_ONLINE.

This modified logic unconditionally calls cpum_cf_free_cpu() if the root
refcount is non-zero, which can free cpuhw if its refcount reaches 0.

Later, when the perf core attempts to stop active events or multiplex timers
fire during the offlining window, cpumf_pmu_stop() is invoked. Since it lac=
ks
a NULL check, it dereferences the NULL cpuhw pointer, leading to a panic.

> -	}
> +	mutex_unlock(&pmc_reserve_mutex);
>  	mutex_unlock(&cfset_ctrset_mutex);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803134932.2385=
616-1-tmricht@linux.ibm.com?part=3D1
