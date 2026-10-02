Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2203B47D0
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932418; cv=none; b=kz43U99MvB2GC2/WCfYP4tE223G7+F9DdumnXZ+eR5V78aLy9qhQzTBjspBF887dN5LQfwDMLOuM+Wd75W38IUoIbfVMS16zmPddVC/HI5QGRENnkQCU3Af2KSIMPb4bPOYQUTYuozIiIBzxDjtZOjdO6QSqj7v2jhO5gwKF+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932418; c=relaxed/simple;
	bh=3UEB46oCFWENoE1XGsmDVoPhCKURHEZq9NrdiB1bxu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VR/V6VNU43gf9ZZ2up6lptbiTJyYu3CwfTrmSQUesGqW4NYziJ1Wt3wN7Pgp+HqAwkx0yK4Apv6w3O1RPbDgxNjB39hURNJKUVQnwcN3el242Jg9K1dphQ50fuMAK5H2ZZVYWJzo7K83NKHgICanWEppq1SiImvbWijG9a8fifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmQlbCoA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmQlbCoA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555F61F000FF;
	Fri,  2 Oct 2026 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932413;
	bh=sQ+n+1j1GOknW58AvIMQeakVltSXIGJ8/zhBhTw+D/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CmQlbCoAkJPTCz3A7QHH/Bur+5zx41kUs1EgtiSEeCxXdghapwou69XosRn8Ep9bv
	 A07syBPXjR2PYy7ZukPv61V8n2Y35wid+FzHXThpHh4G1swIsfDACg8GSGGUnsctzz
	 Z+JqsGxprEtiGYV2Gv/pU17bDacX3+PLXelq5lMABt96LBLJEdlMBFFifZEJRSJkRv
	 s/5/XdeHQcwAfeo47n9fYsoIGFoykGF+UJL/wPqZzd5MvgsXnxBSrRhr7xnaNURolP
	 CULlpyrQsImuoFio/sAnqyNxA7hRJ64JjltRnt8Nb20NuY4SYX1xT4iuP75GRbNQ0R
	 J6ze1d9yyvc/Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 13/13] sched/fair: Switch nohz.idle_cpus to use
 sbm
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261001192849.74788-14-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-14-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:32 +0000
Message-Id: <20261002091333.555F61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] sched/fair: _nohz_idle_balance() aborts during CPU hotplug
- [Medium] sched/fair: NOHZ blocked load decay broken for NO_HZ_FULL CPUs
- [Medium] sched/fair: silent deletion of ASYM_PACKING idle balance kick
- [Low] sched/fair: missing atomic operation before smp_mb__after_atomic()
--

commit 0b0c43c6e4d9b31b812d8407b146c5dc13783dc8
Author: Peter Zijlstra <peterz@infradead.org>

    sched/fair: Switch nohz.idle_cpus to use sbm

With sbm infrastructure in place, convert the global nohz.idle_cpus cpumask
to use sparsebitmap (sbm).

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a0a659f4c3be6..0b1458c4360e3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -14186,24 +14186,6 @@ static void nohz_balancer_kick(struct rq *rq)
>  		}
>  	}
> =20
> -	sd =3D rcu_dereference_all(per_cpu(sd_asym_packing, cpu));
> -	if (sd) {
> -		/*
> -		 * When ASYM_PACKING; see if there's a more preferred CPU
> -		 * currently idle; in which case, kick the ILB to move tasks
> -		 * around.
> -		 *
> -		 * When balancing between cores, all the SMT siblings of the
> -		 * preferred CPU must be idle.
> -		 */
> -		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
> -			if (sched_asym(sd, i, cpu)) {
> -				flags |=3D NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
> -				goto out;
> -			}
> -		}
> -	}
> -

[Severity: Medium]
Was it intentional to completely remove the ASYM_PACKING handling block here
without a replacement?

This appears to mean tasks will no longer be proactively migrated to favored
cores during NOHZ idle load balancing on asymmetric capacity systems.

>  	sd =3D rcu_dereference_all(per_cpu(sd_asym_cpucapacity, cpu));
>  	if (sd) {
>  		/*

[ ... ]

> @@ -14324,7 +14307,8 @@ void nohz_balance_enter_idle(int cpu)
> =20
>  	rq->nohz_tick_stopped =3D 1;
> =20
> -	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
> +	if (cpumask_test_cpu(rq->cpu, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE=
)))
> +		sbm_cpu_set(nohz.sbm, rq->cpu);
> =20
>  	/*
>  	 * Ensures that if nohz_idle_balance() fails to observe our
>  	 * @idle_cpus_mask store, it must observe the @has_blocked_load
>  	 * and @needs_update stores.
>  	 */
>  	smp_mb__after_atomic();

[Severity: Low]
Does this conditional atomic operation violate the smp_mb__after_atomic() A=
PI
contract when the CPU is not in the housekeeping mask?

If a CPU is not in the housekeeping mask, sbm_cpu_set() is skipped. The
subsequent smp_mb__after_atomic() then executes without a preceding atomic
operation, which may fail to provide hardware memory ordering on architectu=
res
where it is just a compiler barrier.

[ ... ]

> @@ -14351,7 +14335,7 @@ static bool update_nohz_stats(struct rq *rq)
>  	if (!rq->has_blocked_load)
>  		return false;
> =20
> -	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> +	if (!sbm_cpu_test(nohz.sbm, cpu))
>  		return false;

[Severity: Medium]
Will this prevent NO_HZ_FULL CPUs from ever decaying their blocked load when
idle?

When an isolated CPU enters idle, it is excluded from nohz.sbm due to the
housekeeping_cpumask() check in nohz_balance_enter_idle(). Consequently,
update_nohz_stats() entirely skips it because it checks sbm_cpu_test(), whi=
ch
could lead to stale load averages and incorrect scheduling decisions for th=
ose
CPUs.

> =20
>  	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))

[ ... ]

> @@ -14405,7 +14390,10 @@ static void _nohz_idle_balance(struct rq *this_r=
q, unsigned int flags)
>  	 * Start with the next CPU after this_cpu so we will end with this_cpu =
and let a
>  	 * chance for other idle cpu to pull load.
>  	 */
> -	for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
> +	start =3D sbm_cpu_to_idx(cpumask_next_wrap(this_cpu, cpu_online_mask));
> +	sbm_for_each_set_bit_wrap(nohz.sbm, idx, start) {
> +		balance_cpu =3D sbm_idx_to_cpu(idx);
> +

[Severity: High]
Can this iteration abort entirely during CPU hotplug?

_nohz_idle_balance() uses cpumask_next_wrap() on cpu_online_mask. During CPU
teardown, sched_cpu_deactivate() calls free_sbm_index(cpu) which sets the C=
PU's
SBM index to -1, but the CPU remains in cpu_online_mask until later in the
teardown process.

If the ILB samples this offlining CPU, sbm_cpu_to_idx() returns -1, which is
passed as `start` to sbm_for_each_set_bit_wrap().

Since sbm_find_next_bit_wrap() returns -1 when start is -1:

include/linux/sbm.h:sbm_find_next_bit_wrap() {
    ...
	bit =3D sbm_find_next_bit(sbm, 0);
	return bit < start ? bit : -1;
}

won't this cause the loop to terminate immediately without balancing any CP=
Us?

>  		if (!idle_cpu(balance_cpu))
>  			continue;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D13
