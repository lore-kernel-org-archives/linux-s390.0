Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF1346C840
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932404; cv=none; b=sy2PQpznp/lAdfiFTbq3p4qLxhD+pGkPpfPhWaB15qZO1g2rWAAW7/DKZZpL21yLvzOL+xkBM14/XJgny/70Dxv9kk0uFzmlZC+63JCiVAkTnTusqWLW6BskD217ME8MLrC4zS4ipDgR0zEgOExsm6SQ1Co9TF7ybltRfvEbEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932404; c=relaxed/simple;
	bh=CYOILT6Uca1QbjEb5dEHiOqIq6STDmh3iMKMrPhoWMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sH3csf8H7vTXt71HLEAgYQMzaYr7xJH+GdORnZfYLE2gOHiFyDGsBe1KU0FT6ek4ikDEQxGg1yoUuzXZDjny/d0U/ZqVgtQtR4RsQPNCNCqwJe1xICmo2Pv5tyhhjwtrD+VgwCeMqOWskSYPG5eU8lWfufWEYabPGwnf7xUYxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5wqBugc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5wqBugc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3121F00899;
	Fri,  2 Oct 2026 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932401;
	bh=B5xVwseAuBdY6QJfs8dIvv17qjtS1pt8syfXleia8sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5wqBugcESKuRxTEzFFaDme/CJ0Ub2zV1OJP2mHLKXkfiLAcTV2m/kIVmQv9rFKKB
	 kZEK+JxpW0X4rbrlir03Ud0UB9LLLN+HND+dPWNIHhKZRP9mKem27ZaxbBUIgz9Po9
	 y7v7kZMN66dVNPRfDsPyD6r0YpfyY9aAqV1diei9IV8VtMVsWvglGBFaMomxJQxbXH
	 +OeZRCHnn5CpmHsNBPm6ipFmlD04vrI1Do3lJCDbfZ1WldMPSUjqB10nszbIEO6XY6
	 2zlu5o+dzPAZ6oYdXVjZ5882JPY3hpcxkRAVSSAhPLnI/tLG7xH/N0bpZPrlphQH9V
	 ny3SJKTmTChng==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 10/13] lib/sbm: Dynamically allocate sbm index
 when CPU is activated
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261001192849.74788-11-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-11-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:20 +0000
Message-Id: <20261002091321.4E3121F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] lib/sbm: array overflow in alloc_sbm_index() due to hardcoded BITS=
_PER_LONG
- [High] sched/core: premature SBM index free causes UAF and out-of-bounds =
access
- [High] sched/core: unhandled alloc_sbm_index() failure allows corrupting =
sbm[-1]
- [Medium] lib/sbm: sentinel value collision with architecture instance IDs=
 corrupts topology
--

commit 525dc1ae45d6fc1670c637f040964c4d0eb2f14a
Author: K Prateek Nayak <kprateek.nayak@amd.com>

lib/sbm: Dynamically allocate sbm index when CPU is activated
   =20
Add infrastructure to establish CPU to sparsebitmap (sbm) index relation
before CPU is turned active. CPU coming online looks for a free slot
based on its instance ID and acquires a free slot.

> diff --git a/init/main.c b/init/main.c
> index 2613d3f9b3ce9..b7406bd3acc87 100644
> --- a/init/main.c
> +++ b/init/main.c
[ ... ]
> @@ -1652,6 +1653,11 @@ static noinline void __init kernel_init_freeable(v=
oid)
> =20
>  	smp_prepare_cpus(setup_max_cpus);
> =20
> +	sbm_init();
> +
> +	/* Finish initializing boot CPU since it is already active. */
> +	alloc_sbm_index(smp_processor_id());

[Severity: High]
Does this code need to check the return value of alloc_sbm_index()? If it
fails and returns -ENOENT, the boot CPU might proceed without a valid mappi=
ng,
potentially exposing the -1 default value to subsystem bitwise operations.

> +
>  	workqueue_init();
> =20
>  	init_mm_internals();
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0bb86a43a5920..977f579da4108 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
[ ... ]
> @@ -8636,6 +8637,14 @@ int sched_cpu_activate(unsigned int cpu)
>  	 */
>  	balance_push_set(cpu, false);
> =20
> +	alloc_sbm_index(cpu);

[Severity: High]
Similar to the boot CPU initialization, should we handle potential errors f=
rom
alloc_sbm_index() here? If the slots are full and it returns -ENOENT, the C=
PU
is brought fully online without a valid mapping, which might cause memory
corruption when writing to sbm[-1].bitmap.

> +
> +	/*
> +	 * Make sure sbm mappings are visible
> +	 * before CPU is toggled active.
> +	 */
> +	smp_mb();
> +
>  	/*
>  	 * When going up, increment the number of cores with SMT present.
>  	 */
[ ... ]
> @@ -8688,6 +8697,14 @@ int sched_cpu_deactivate(unsigned int cpu)
> =20
>  	set_cpu_active(cpu, false);
> =20
> +	/*
> +	 * Make sure CPU is inactive before
> +	 * sbm indices are reclaimed.
> +	 */
> +	smp_mb();
> +
> +	free_sbm_index(cpu);

[Severity: High]
Can reclaiming the index before synchronize_rcu() cause out-of-bounds array
accesses? If a concurrent lockless reader iterates the sbm and reads the in=
dex
before it is cleared, but calls sbm_idx_to_cpu() after this free_sbm_index()
call, it might receive -1.

> +
>  	/*
>  	 * From this point forward, this CPU will refuse to run any task that
>  	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
> diff --git a/lib/sbm.c b/lib/sbm.c
> index 82280e3306de8..b80ed1d961379 100644
> --- a/lib/sbm.c
> +++ b/lib/sbm.c
[ ... ]
> @@ -15,6 +63,72 @@ int __weak arch_sbm_cpu_instance_id(int cpu)
>  	return 0;
>  }
> =20
> +static int sbm_cpu_to_instance(int cpu)
> +{
[ ... ]
> +int alloc_sbm_index(int cpu)
> +{
> +	int cpu_instance =3D sbm_cpu_to_instance(cpu);
> +	int i, idx =3D BITS_PER_LONG, free_index =3D -1;
> +
> +	for (i =3D 0; i < sbm_num_instance; ++i) {
> +		if (__sbm_idx_metadata[i].instance_id =3D=3D cpu_instance) {
> +			idx =3D find_first_zero_bit(&__sbm_idx_metadata[i].allocated_mask,
> +						  BITS_PER_LONG);
> +
> +			if (idx < BITS_PER_LONG)
> +				break;
> +		}
> +		if (free_index =3D=3D -1 && __sbm_idx_metadata[i].instance_id =3D=3D -=
1)
> +			free_index =3D i;

[Severity: Medium]
Could this condition falsely match if an architecture returns -1 for an
instance ID (like NUMA_NO_NODE)? If the first CPU sets the instance ID to -=
1,
subsequent CPUs with valid instance IDs might mistakenly see this leaf as
empty, and overwrite the previous CPU's mapping.

> +	}
> +
> +	if (i =3D=3D sbm_num_instance && free_index =3D=3D -1)
> +		return -ENOENT;
> +
> +	if (i =3D=3D sbm_num_instance) {
> +		__sbm_idx_metadata[free_index].instance_id =3D cpu_instance;
> +		i =3D free_index;
> +		idx =3D 0;
> +	}
> +
> +	WARN_ON_ONCE(idx >=3D sbm_max_threads_per_instance);

[Severity: High]
Does this code overflow into subsequent leaves when
sbm_max_threads_per_instance is smaller than BITS_PER_LONG? Since the
find_first_zero_bit() limit and the break condition above hardcode
BITS_PER_LONG instead of checking against sbm_max_threads_per_instance, the
global idx computed below might overflow the leaf's boundary and corrupt
mappings for other instances.

> +
> +	__set_bit(idx, &__sbm_idx_metadata[i].allocated_mask);
> +
> +	idx =3D (i << __sbm_shift) + idx;
> +	_sbm_idx_to_cpu()[idx] =3D cpu;
> +	_sbm_cpu_to_idx()[cpu] =3D idx;
> +
> +	return 0;
> +}
> +
> +void free_sbm_index(int cpu)
> +{
> +	int idx =3D sbm_cpu_to_idx(cpu);
> +	u32 leaf;
> +
> +	if (idx < 0)
> +		return;
> +
> +	_sbm_idx_to_cpu()[idx] =3D -1;
> +	_sbm_cpu_to_idx()[cpu] =3D -1;
> +
> +	leaf =3D runtime_const_shift_right_32(idx, __sbm_shift);
> +	idx =3D runtime_const_mask_32(idx, __sbm_mask);
> +
> +	__clear_bit(idx, &__sbm_idx_metadata[leaf].allocated_mask);

[Severity: High]
If the allocation allowed an index to overflow past
sbm_max_threads_per_instance, will the shifted leaf calculation here resolve
to the wrong leaf and clear an allocated bit belonging to another instance?

> +
> +	if (find_first_bit(&__sbm_idx_metadata[leaf].allocated_mask, BITS_PER_L=
ONG) =3D=3D
> +	    BITS_PER_LONG)
> +		__sbm_idx_metadata[leaf].instance_id =3D -1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D10
