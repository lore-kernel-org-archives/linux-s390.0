Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA433EAF3
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749724; cv=none; b=ui6Njbq042Sz7SaxI99Af+akvCfka6rkq4eU8BCKYuMxkXTEnKxjGDgxusKNMvcBN9sQ8ehCw1kt0J5fpWj8CVFlQ/gI4f6ZRGImlNY5pMdPbMoMrqZ7DwcJzWGIgnmvIa3XLsSy7u6uVjkq2GwpOFcvMQJXuhPf8W5N/TSSops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749724; c=relaxed/simple;
	bh=G+rV2/xlAV66FM3W+xMqdlmNp5vcmMhCMKZNNy8ow1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U65o/9EGQTwrgqAdTVHDNMSr+S8ZVC4l1pvjC2z3Hhr9hnQo/LBg0xsTlqdzf1ntbjsA/XhDguaGgx7D1nOfFB4Pf3/kf8Br5VRdz5aR1CebuLtu//6vVMUkKfZtn8azZuEcjpGB4flaILnJVeyvekahejGPmF7qUVtt6qzQO08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e50gFQaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e50gFQaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE941F00AC4;
	Mon,  3 Aug 2026 09:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785749718;
	bh=skPFlUdP0W3hpwgdOMW4EEliJhZeRkcqXoLEgpR2KA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e50gFQafkANuVcqvN6otbiSlfDptcwjzS7/hJOZE+gY0DyfKzyz2gi8I56W4Dg5Fe
	 edPb527R9Wn6awxQAwBsKc+CDLypXLDkqRrS5JwbdIwyLGYuxvCBoQeo78ms7NmlJ3
	 jLrok6oaqeAwxJ1A4LYBGnaDZ4VWl7AFIdMJJZaSWbGTemcCCzxi7tgWW17HZ3lrK9
	 XpgAQia3rXJ66QZSb06qnmpObqOZuQl13RoW2sH2P8PJiX5JIz1T9FaQZta91ge8V1
	 JqDLQhCWpJxnQcZrqi/b6b1rZoG5tx7FdLk5dQi60WjKmYditB5pv5T8oLO4dCTgps
	 MO48Hh/mTJ2Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] s390/cpum_cf: Handle CPU hotplug add and delete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803091940.1318933-1-tmricht@linux.ibm.com>
References: <20260803091940.1318933-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 09:35:17 +0000
Message-Id: <20260803093518.4DE941F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Premature freeing of per-CPU PMU data leading to NULL pointer dere=
ference and kernel panic.
- [High] Per-CPU perf events are permanently broken after their target CPU =
undergoes an offline/online cycle.
- [Medium] Memory leak of `cpuhw` structures due to double-allocation race =
between event initialization and CPU hotplug.
--

--- Patch [1]: [PATCH v4] s390/cpum_cf: Handle CPU hotplug add and delete -=
--
commit fb5dfe8e1024f1616e4e0be3383c2356fabd9b3e
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/cpum_cf: Handle CPU hotplug add and delete

This patch attempts to resolve a kernel panic occurring when CPUs are
hotplugged during a perf stat run. It does so by counting active
per-task processes and allocating the CPUMF per-CPU infrastructure on
newly online CPUs if there are active per-task contexts.

> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum=
_cf.c
> index 2076ac22e2c49..f24b2145a0dfd 100644
> --- a/arch/s390/kernel/perf_cpum_cf.c
> +++ b/arch/s390/kernel/perf_cpum_cf.c
[ ... ]
> @@ -290,9 +286,12 @@ static int cpum_cf_alloc(int cpu)
>  	cpumask_var_t mask;
>  	int rc;
> =20
> +	mutex_lock(&pmc_reserve_mutex);
>  	if (cpu =3D=3D -1) {
> -		if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
> -			return -ENOMEM;
> +		if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
> +			rc =3D -ENOMEM;
> +			goto out;
> +		}
>  		for_each_online_cpu(cpu) {
>  			rc =3D cpum_cf_alloc_cpu(cpu);

[Severity: Medium]
Is there a missing hotplug lock here?

Since for_each_online_cpu() is called without cpus_read_lock(), can this
race with CPU hotplug and cause a memory leak?

If a new CPU is added to cpu_online_mask before the hotplug callbacks
execute, this loop will allocate a cpuhw structure for it and increment
tskcnt. Concurrently, when cpum_cf_online_cpu() runs for the new CPU, it
will see tskcnt > 0 and call cpum_cf_alloc_cpu() again, bumping the
refcount to 2.

When the perf event is later destroyed, cpum_cf_free() will only drop the
refcount by 1, permanently leaking the structure.

[ ... ]
> @@ -1105,13 +1125,13 @@ static int cpum_cf_online_cpu(unsigned int cpu)
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
> +	mutex_lock(&pmc_reserve_mutex);
> +	if (atomic_read(&cpu_cf_root.tskcnt))
>  		rc =3D cpum_cf_alloc_cpu(cpu);

[Severity: High]
If there are multiple active task-context events, does this correctly track
the reference counts?

When a CPU is hotplugged online and tskcnt is greater than 1 (for example,
if userspace has opened two task-context perf events), cpum_cf_alloc_cpu()
is only called once. This initializes the new CPU's refcnt to 1, regardless
of the actual number of active contexts.

If userspace then closes just one of the perf events, cpum_cf_free() will
decrement the refcnt for all CPUs by 1. For the newly onlined CPU, the
refcnt drops to 0 and its cpuhw structure is freed.

However, the second perf event is still active. When the task is scheduled
out from this CPU, perf core calls cpumf_pmu_stop():

cpumf_pmu_stop() {
   cpuhw =3D this_cpu_cfhw();
   ...
   if (!atomic_dec_return(&cpuhw->ctr_set[i]))
}

Since cpuhw is now NULL, won't this dereference a NULL pointer and cause a
kernel panic?

> +	mutex_unlock(&pmc_reserve_mutex);
> +	if (refcount_read(&cfset_opencnt)) {
>  		if (!rc)
>  			cfset_online_cpu(cpu);
>  	}
> @@ -1130,13 +1150,12 @@ static int cpum_cf_offline_cpu(unsigned int cpu)
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
> -		cpum_cf_free_cpu(cpu);
> -	}
> +	cpum_cf_free(cpu);

[Severity: High]
Does unconditionally freeing the per-CPU data break active per-CPU events?

If a per-CPU event is active (which does not increment tskcnt), and its
target CPU is hotplugged offline, this cpum_cf_free() call will drop the
reference count to 0 and free the cpuhw structure.

When the CPU is brought back online, cpum_cf_online_cpu() checks if
tskcnt > 0. Since this is a per-CPU event, tskcnt is 0, and the cpuhw
structure is not reallocated.

The CPU will come online with a NULL cpuhw pointer. When the active per-CPU
event is scheduled on this CPU, cpumf_pmu_add() will evaluate cpuhw =3D=3D =
NULL
and return -ENODEV, permanently preventing the event from counting.

>  	mutex_unlock(&cfset_ctrset_mutex);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803091940.1318=
933-1-tmricht@linux.ibm.com?part=3D1
