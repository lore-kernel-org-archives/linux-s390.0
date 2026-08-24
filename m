Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3441A564
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576026; cv=none; b=AmA0VYTi+oydQ+0WR0EXXdzq+26I6w+8KJcndwgOrL7DKKhlIPKhbxYhe8JduaWDe3dGVi6sIkFx+xer7niC60RVAPy1aPa4i5qcyTBBqCZv5zaNrjGxkMH7Gv4RSOl10ZsHU/okwYKO65ggdmVPzyKCOOlZbWa6itYo75fqHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576026; c=relaxed/simple;
	bh=u3Lw7mXE4LeGG2X6gIXWFXFEcuoKbzp5Wca3e6j7/LM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jMV7uUBjraBC2wSqvsObzMqP7SYIjOwmczJzXfy00dgfXbMlmE1uOHyj9UTroK43HfOEuMrJuna0wlr27pzzv9/t+QPL1Y4bp7mQjDEmRBFhczBF7PFMkwzfRidiFhH5DNm8cszb0kkv001WDy1VPFrYZ0IXDfhaRy9ajS43v5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFWDbN6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFWDbN6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C691F00A3D;
	Mon, 24 Aug 2026 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787576024;
	bh=Zo9OQV3uqGDclP51KXknjQwrYtakJCgbtWcdSSpb1wM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LFWDbN6N1jUPx9zQk/s7WvH+Oxg6VSjn+yzwk2S3dxuLUXOyAweVynxRQYNrB7Nzn
	 VKkUWUVA01EhWReQQl9e0+JSC2d+GUlTMkUQgak0k8xRC/dm5v7eZH85I21jRYLi4X
	 I4kjFoBl7YeqXGVjxOnp92qRkLrnrD/R+Ni+jwEjI7S4Kn/LwvaGSvH28IdKmfoitJ
	 d7DDlbxSd3Mwzg9z9WWKm7cFvnNt6aCG07aIzkOw7AFxKFfwiINakZFt3vmT3VpCr3
	 YsrJ1wc5OPz8lbvCcQSPTzMe6xA9EkW6GZmgNkiSCKyqfvKCCO23t4tBNjbCPqTNEk
	 CwXgJzrWuWPLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3 v2] s390/pai: Support CPU hotplug for PMU PAI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260824122307.86133-4-tmricht@linux.ibm.com>
References: <20260824122307.86133-1-tmricht@linux.ibm.com>
 <20260824122307.86133-4-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 12:53:43 +0000
Message-Id: <20260824125344.42C691F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `cpus_read_lock()` during PAI event allocation and destruc=
tion causes race conditions with the new CPU hotplug callbacks, leading to =
NULL pointer dereferences or memory leaks.
--

--- Patch [3]: [PATCH 3/3 v2] s390/pai: Support CPU hotplug for PMU PAI ---
commit 91620cb7064d1e27822672c053b2886bba4751a9
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/pai: Support CPU hotplug for PMU PAI

This commit adds CPU hotplug support for the PAI PMU, creating per-CPU data
structures during CPU add/remove to prevent panics when CPUs are hotplugged
during perf runs.

> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> index 52d9f654346a2..04a9dafa8f371 100644
> --- a/arch/s390/kernel/perf_pai.c
> +++ b/arch/s390/kernel/perf_pai.c

[ ... ]

> @@ -160,13 +178,11 @@ static void pai_event_destroy(struct perf_event *ev=
ent)
>  	free_page(PAI_SAVE_AREA(event));
>  	mutex_lock(&pai_reserve_mutex);
>  	if (event->cpu =3D=3D -1) {
> -		struct cpumask *mask =3D PAI_CPU_MASK(event);
> -
> -		for_each_cpu(cpu, mask)
> -			pai_event_destroy_cpu(idx, cpu);
> -		kfree(mask);
> +		atomic_dec(&pai_root[idx].tskctx);
> +		for_each_online_cpu(cpu)
> +			pai_event_destroy_cpu(idx, cpu, false);

[Severity: High]
Does this code introduce a memory leak if a CPU is offlined concurrently?

If a CPU is offlined, it is removed from cpu_online_mask at CPUHP_BRINGUP_C=
PU.
If a concurrent perf event destruction runs, for_each_online_cpu() will skip
the offlining CPU, failing to decrement its refcnt.

When the offline process reaches pai_offline_cpu(), it reads tskctx as 0, so
refcount_sub_and_test(0, ...) does not drop the reference, leaving the memo=
ry
permanently leaked.

Should cpus_read_lock() be held during pai_event_destroy() to prevent this?

>  	} else {
> -		pai_event_destroy_cpu(idx, event->cpu);
> +		pai_event_destroy_cpu(idx, event->cpu, false);
>  	}
>  	mutex_unlock(&pai_reserve_mutex);
>  }

[ ... ]

> @@ -322,24 +362,20 @@ static int pai_alloc(struct perf_event *event)
>  		goto out;
> =20
>  	for_each_online_cpu(cpu) {
> -		rc =3D pai_alloc_cpu(idx, cpu);
> +		rc =3D pai_alloc_cpu(idx, cpu, false);
>  		if (rc) {
>  			for_each_cpu(cpu, maskptr)
> -				pai_event_destroy_cpu(idx, cpu);
> -			kfree(maskptr);
> -			goto out;
> +				pai_event_destroy_cpu(idx, cpu, false);
> +			goto undo;
>  		}
>  		cpumask_set_cpu(cpu, maskptr);
>  	}
> =20
> -	/*
> -	 * On error all cpumask are freed and all events have been destroyed.
> -	 * Save of which CPUs data structures have been allocated for.
> -	 * Release them in pai_event_destroy call back function
> -	 * for this event.
> -	 */
> -	PAI_CPU_MASK(event) =3D maskptr;
>  	rc =3D 0;
> +	/* Trace per-task events for CPU hotplug. */
> +	atomic_inc(&pai_root[idx].tskctx);

[Severity: High]
Can this race with CPU hotplug and lead to a NULL pointer dereference?

If CPU hotplug begins (e.g., via sysfs), pai_online_cpu() executes at
CPUHP_BP_PREPARE_DYN. Since no per-task events exist (tskctx =3D=3D 0), it =
skips
allocation.

If a concurrent system-wide perf event is created here, pai_alloc() iterates
cpu_online_mask. Since the new CPU is not yet in the online mask (which
happens later at CPUHP_BRINGUP_CPU), it skips allocation for the new CPU, a=
nd
then increments tskctx to 1.

When the CPU completes bring-up and a task schedules on it, will pai_add()
dereference the unallocated per-CPU pointer and cause a kernel panic?

> +undo:
> +	kfree(maskptr);
>  out:
>  	return rc;
>  }

[ ... ]

> @@ -389,7 +425,7 @@ static int pai_event_init(struct perf_event *event, i=
nt idx)
> =20
>  	mutex_lock(&pai_reserve_mutex);
>  	if (event->cpu >=3D 0)
> -		rc =3D pai_alloc_cpu(idx, event->cpu);
> +		rc =3D pai_alloc_cpu(idx, event->cpu, false);
>  	else
>  		rc =3D pai_alloc(event);
>  	mutex_unlock(&pai_reserve_mutex);

[Severity: High]
Does pai_event_init() need to hold cpus_read_lock() here?

Acquiring cpus_read_lock() before taking pai_reserve_mutex (to avoid ABBA
deadlocks with the hotplug writer lock) would serialize event allocation wi=
th
CPU hotplug operations, preventing the races mentioned above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824122307.8613=
3-1-tmricht@linux.ibm.com?part=3D3
