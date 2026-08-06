Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB430B53A
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022993; cv=none; b=a/i25MU0DE59YgKhMNcsudAm2//gfyXXh91MrPUKOZjz289tTbpEpxo8CrxvS79egW3b9mGa0ZtbFgJgR+3QBUSLRUgXDcBdjzfu+Hf86b2rm4J+Ur1Xog9xyVlixvCuwV1mE1dngPTvIm981blWH8Mzce7Ymao6kMmpxvAZq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022993; c=relaxed/simple;
	bh=2pP8QkvV6lz4bQ7IK9W7xo8udEEwIuQZEK6cEt428Ps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EdzDcjaXl5omesHz8cZnBLkV92WeWkDmgEFA5M1prrP5boJu41X2RkbNo8P/P76udh1N3hN+PXN70HDJf5fPbt/MVbWmQgG3RcCC+iSzr9fM4LRxsfRYfExrSpkCuPhOb+1ul8H89gnYkyv3QabPh2qxCVP0OQ833Fih/tkG4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLdE3ZkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLdE3ZkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CE41F000E9;
	Thu,  6 Aug 2026 13:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786022991;
	bh=balRm9MhKwoDmnEKK6RlzgR5NpkrLxd5wDmrcNGhnjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CLdE3ZkAlqYGwIRp1QQmkZaep5FBusDhjIHbkL8Xf0Qr6Z75P1+c/3m1Lq5uw+G1c
	 fpQk/zAKuz1Cof5vW67b3EBdi+XuQcxtDk9Vxq5AwDfdN3ToUqCWf/SlmBFIapCMx9
	 icKxcXWUzU9niv1URZ9kDJhmng4IJncnUk/nPhK6dC1+IxEFLnd4anG2n3MwdROjW8
	 t92yqWeI81s4g4Np9K78vOXsncP1wkf8k0RfzcB8B7mYPYamHcikPkaex8dxOPHKiX
	 F3V85sg2XGSmSO9srSXaxlrBk6uHL+T06Hj/ZeANNDidOKxBoXB9zKL8UM0CBXcPBg
	 OgLiu0cIbE09w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260806131131.2073914-1-tmricht@linux.ibm.com>
References: <20260806131131.2073914-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:29:50 +0000
Message-Id: <20260806132951.11CE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unbounded reference count leak and memory leak on CPU hotplug for =
task events.
- [High] Per-CPU events are permanently broken and suffer data loss when a =
CPU is offlined.
- [High] Reference count overwrite on CPU online leads to Use-After-Free fo=
r per-CPU and hardware counter events.

Pre-existing issues:
- [High] Data race in `cpum_cf_free_cpu` leads to Use-After-Free if interru=
pted by hardware counter alert.
--

--- Patch [1]: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete ---
commit 29becd857d549bdc0388325fd158df7d2f158812
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/cpum_cf: Handle CPU hotplug add and delete
   =20
The command 'perf stat -e cycles -- <command>' crashes the kernel when CPUs
are hotplug added during that run. This commit tracks task-context users to
ensure per-CPU structures are allocated when a new CPU is brought online.

Cc: <stable@vger.kernel.org> # v6.5+

> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum=
_cf.c
> index 2076ac22e2c49..9e8c3d2e71d57 100644
> --- a/arch/s390/kernel/perf_cpum_cf.c
> +++ b/arch/s390/kernel/perf_cpum_cf.c

[ ... ]

> @@ -206,20 +207,19 @@ static int cpum_cf_alloc_root(void)
>  	return rc;
>  }
> =20
> -/* Free CPU counter data structure for a PMU */
> +/* Free CPU counter data structure for a PMU. Called under mutex lock */
>  static void cpum_cf_free_cpu(int cpu)
>  {
>  	struct cpu_cf_events *cpuhw;
>  	struct cpu_cf_ptr *p;
> =20
> -	mutex_lock(&pmc_reserve_mutex);
>  	/*
>  	 * When invoked via CPU hotplug handler, there might be no events
>  	 * installed or that particular CPU might not have an
>  	 * event installed. This anchor pointer can be NULL!
>  	 */
>  	if (!cpu_cf_root.cfptr)
> -		goto out;
> +		return;
>  	p =3D per_cpu_ptr(cpu_cf_root.cfptr, cpu);
>  	cpuhw =3D p->cpucf;
>  	/*
> @@ -227,15 +227,13 @@ static void cpum_cf_free_cpu(int cpu)
>  	 * installed on that CPU, but on different CPUs.
>  	 */
>  	if (!cpuhw)
> -		goto out;
> +		return;
> =20
>  	if (refcount_dec_and_test(&cpuhw->refcnt)) {
>  		kfree(cpuhw);
>  		p->cpucf =3D NULL;

[Severity: High]
This is a pre-existing issue, but is it possible for an interrupt to
dereference this pointer after it is freed?

Since cpum_cf_free_cpu() executes with interrupts enabled, if a CPUMF
measurement alert interrupt triggers right after kfree(cpuhw) but before
p->cpucf is set to NULL:

cpum_cf_free_cpu()
  kfree(cpuhw);
 =20
  --- interrupt occurs ---
  cpumf_measurement_alert()
    this_cpu_cfhw() -> returns p->cpucf
    ... accesses freed memory ...

Would it be safer to clear the pointer before calling kfree?

>  	}
>  	cpum_cf_free_root();
> -out:
> -	mutex_unlock(&pmc_reserve_mutex);
>  }

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
>  			if (rc) {
> @@ -303,20 +302,27 @@ static int cpum_cf_alloc(int cpu)
>  			cpumask_set_cpu(cpu, mask);
>  		}
>  		free_cpumask_var(mask);
> +		if (!rc)
> +			atomic_inc(&cpu_cf_root.tskcnt);
>  	} else {
>  		rc =3D cpum_cf_alloc_cpu(cpu);
>  	}
> +out:
> +	mutex_unlock(&pmc_reserve_mutex);
>  	return rc;
>  }
> =20
>  static void cpum_cf_free(int cpu)
>  {
> +	mutex_lock(&pmc_reserve_mutex);
>  	if (cpu =3D=3D -1) {
>  		for_each_online_cpu(cpu)
>  			cpum_cf_free_cpu(cpu);
> +		atomic_dec(&cpu_cf_root.tskcnt);

[Severity: High]
Does this loop potentially leak the per-CPU data structure if a CPU is
offline?

If task events are closed while a CPU is offline, iterating only over
for_each_online_cpu(cpu) skips that offline CPU.

Will this permanently leave the cpuhw structure and root references orphaned
for that CPU?

>  	} else {
>  		cpum_cf_free_cpu(cpu);
>  	}
> +	mutex_unlock(&pmc_reserve_mutex);
>  }

[ ... ]

> @@ -992,6 +1003,12 @@ static void cpumf_pmu_stop(struct perf_event *event=
, int flags)
>  	struct hw_perf_event *hwc =3D &event->hw;
>  	int i;
> =20
> +	/* Might be zero when a per-task context event is active. Happens
> +	 * when CPUs are made offline and process migration takes place.
> +	 */
> +	if (!cpuhw)
> +		return;
> +

[Severity: High]
Could this early return cause us to lose accumulated performance counter da=
ta?

Since CPU hotplug teardown in s390 executes CPUHP_AP_PERF_S390_CF_ONLINE
(state 209) before the generic perf core's CPUHP_AP_PERF_ONLINE (state 204),
the per-CPU data structure has already been freed by cpum_cf_offline_cpu().

When the perf core eventually calls cpumf_pmu_stop() to stop the event, this
check evaluates to true, aborting the function without updating the hardware
counter state.

>  	if (!(hwc->state & PERF_HES_STOPPED)) {
>  		/* Decrement reference count for this counter set and if this
>  		 * is the last used counter in the set, clear activation

[ ... ]

> @@ -1090,28 +1117,62 @@ static refcount_t cfset_opencnt =3D REFCOUNT_INIT=
(0);	/* Access count */
>  static DEFINE_MUTEX(cfset_ctrset_mutex);
> =20
>  /*
> - * CPU hotplug handles only /dev/hwctr device.
> - * For perf_event_open() the CPU hotplug handling is done on kernel comm=
on
> - * code:
> - * - CPU add: Nothing is done since a file descriptor can not be created
> - *   and returned to the user.
> - * - CPU delete: Handled by common code via pmu_disable(), pmu_stop() and
> - *   pmu_delete(). The event itself is removed when the file descriptor =
is
> - *   closed.
> + * CPU hotplug handles /dev/hwctr device.
> + *
> + * For perf_event_open() the CPU hotplug handler needs to check the numb=
er
> + * of per-task context events currently active. A per-task context event
> + * needs per-CPU data structures. The scheduler might schedule the task =
on
> + * the new CPU and then the CPUMF per-CPU infrastructure must be availab=
le.
> + * Common code relies on that and calls cpumf_pmu_add(), cpumf_pmu_start=
(),
> + * cpumf_pmu_stop() and cpumf_pmu_del() to install PMU backend functions=
 on
> + * the new CPU.
> + *
> + * If no per-task context event has been installed, the events are per-C=
PU
> + * and do not care about a new CPU.
>   */
>  static int cfset_online_cpu(unsigned int cpu);
> =20
>  static int cpum_cf_online_cpu(unsigned int cpu)
>  {
> -	int rc =3D 0;
> +	int i, rc =3D 0;
> =20
> -	/*
> -	 * Ignore notification for perf_event_open().
> -	 * Handle only /dev/hwctr device sessions.
> -	 */
>  	mutex_lock(&cfset_ctrset_mutex);
> -	if (refcount_read(&cfset_opencnt)) {
> +	/* Allocate per-CPU infrastructure when per-task context active. */
> +	mutex_lock(&pmc_reserve_mutex);
> +	if (atomic_read(&cpu_cf_root.tskcnt)) {
>  		rc =3D cpum_cf_alloc_cpu(cpu);

[Severity: High]
Are we failing to reallocate the data structure for CPU-bound events here?

Since per-CPU events do not increment the task context count (tskcnt), this
check is bypassed.

Will subsequent attempts to interact with an existing CPU-bound event
encounter a NULL pointer on this newly onlined CPU?

> +		/* Adjust reference counts:
> +		 * CPU X is offline
> +		 *   perf_event_open() task event E1: tskcnt =3D 1, no cpuhw for CPU X
> +		 *   perf_event_open() task event E2: tskcnt =3D 2
> +		 *   CPU X set online
> +		 *     cpum_cf_online_cpu()
> +		 *       cpum_cf_alloc_cpu(X): cpuhw->refcnt =3D 1
> +		 * E1 closed
> +		 *   hw_perf_event_destroy()
> +		 *     cpum_cf_free(-1)
> +		 *       cpum_cf_free_cpu(X): refcnt 1 -> 0, kfree(cpuhw)
> +		 * E2's task runs on CPU X
> +		 *   cpumf_pmu_add(): this_cpu_cfhw() =3D=3D NULL, -ENODEV
> +		 *
> +		 * If tskcnt > 1, adjust the reference counts to the number
> +		 * of process-context tasks.
> +		 */
> +		if (!rc && atomic_read(&cpu_cf_root.tskcnt) > 1) {
> +			struct cpu_cf_events *cpuhw;
> +			struct cpu_cf_ptr *p;
> +
> +			p =3D per_cpu_ptr(cpu_cf_root.cfptr, cpu);
> +			for (i =3D 1; i < atomic_read(&cpu_cf_root.tskcnt); ++i)
> +				cpum_cf_alloc_root();

[Severity: High]
Is there a risk of an unbounded reference count leak on the root structure
here?

When a CPU goes offline, cpum_cf_offline_cpu() drops a single reference to
cpuhw and cpu_cf_root.refcnt.

However, when brought back online with multiple active task events
(tskcnt > 1), this loop adds tskcnt - 1 new references to
cpu_cf_root.refcnt, causing it to grow indefinitely on every offline/online
cycle.

> +
> +			cpuhw =3D p->cpucf;
> +			refcount_set(&cpuhw->refcnt,
> +				     atomic_read(&cpu_cf_root.tskcnt));

[Severity: High]
Does forcefully setting the reference count here destroy references held by
other active subsystems?

The cpuhw->refcnt field tracks all users on a CPU, including task events,
per-CPU events, and /dev/hwctr sessions.

By overwriting it with tskcnt, wouldn't this erase any references held by
other active sessions, causing a premature free of cpuhw later and leading
to a Use-After-Free?

> +		}
> +	}
> +	mutex_unlock(&pmc_reserve_mutex);
> +	if (refcount_read(&cfset_opencnt)) {
>  		if (!rc)
>  			cfset_online_cpu(cpu);
>  	}
> @@ -1123,20 +1184,11 @@ static int cfset_offline_cpu(unsigned int cpu);
> =20
>  static int cpum_cf_offline_cpu(unsigned int cpu)
>  {
> -	/*
> -	 * During task exit processing of grouped perf events triggered by CPU
> -	 * hotplug processing, pmu_disable() is called as part of perf context
> -	 * removal process. Therefore do not trigger event removal now for
> -	 * perf_event_open() created events. Perf common code triggers event
> -	 * destruction when the event file descriptor is closed.
> -	 *
> -	 * Handle only /dev/hwctr device sessions.
> -	 */
>  	mutex_lock(&cfset_ctrset_mutex);
> -	if (refcount_read(&cfset_opencnt)) {
> +	/* Handle /dev/hwctr device sessions */
> +	if (refcount_read(&cfset_opencnt))
>  		cfset_offline_cpu(cpu);
> -		cpum_cf_free_cpu(cpu);
> -	}
> +	cpum_cf_free(cpu);

[Severity: High]
Does unconditionally freeing the data structure here break active per-CPU
events?

As noted earlier, this function runs before the generic perf core can stop
the event. Unconditionally dropping the refcount to 0 frees cpuhw while the
hardware counter is still active.

>  	mutex_unlock(&cfset_ctrset_mutex);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131131.2073=
914-1-tmricht@linux.ibm.com?part=3D1
