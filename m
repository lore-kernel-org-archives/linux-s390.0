Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0F199EAD
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564039; cv=none; b=plR02v736fwGfvifPmVAlLD55fWtINzU1fZ0P86iloov4I8yXKv0hxiJMsyv2Gu1GQaZIcyKdeQ57tcryI7F8R7IWfgh2ckJ+lSqBcWTsErlEwCp2af7fBHhbt413GKZj3Ws/gqMV70kZMC7F2ZAHp/NJgLpH2QtpFYKp3xkLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564039; c=relaxed/simple;
	bh=pMl/vMaKdZUmJ+4xZpJdlDg30gltDg0K4SrsX3v4ZR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kFrfWUyQVqU9Lbsit98Cv6B7ZGFnN6JcVubKWS/Y+dK5XclIYrFGGUUaCLCVKnaV4tp5lM6QhnLvBuuI1uWn41T5gakJ369FT59CrSwXyfnGeaOZkIjnIdAwtlfR3K9PZmLeUKeK/qOHJ9woGSFXyaQj4NogC2RxSo6gFtEkQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwH8BDTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwH8BDTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01F41F000E9;
	Mon, 24 Aug 2026 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787564038;
	bh=sBT0RkAYt6GS7rsuIa0hdy7RgVPLPDyynEcLxbhS7RM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VwH8BDTfFsBBvRYmTOdRLMzYBEACNJIddr6jPkzho4pq9vKNahC1cQmUsoFGoH3iI
	 K2ANEqmEwiWq7LbO1GtTK+N3ACBFoZslFN1oO09JOEj5XxEvoCAx0q/7SLCCHSV2np
	 Z29HsAFgnRYHvhHK+c1kONUu4gafAjG6nwTeT6lKZHRSLtUUwkhATgq0mg7+RQLV9u
	 MttKmiw1rPcyDZnTBxpRXsqvP8AtfhkPCCx2xB5Bes3QEb2LzUaYCiZS/CBkIODbp5
	 jv3MTXGOrR7kHuDCbWsH4X6XNEPVRtucWvZtEAyXa6QrDJocCmd7brOQ6k8FgzqHx7
	 9eE9ie0LeUqZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] s390/pai: Support CPU hotplug for PMU PAI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260824092036.3075553-4-tmricht@linux.ibm.com>
References: <20260824092036.3075553-1-tmricht@linux.ibm.com>
 <20260824092036.3075553-4-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:33:57 +0000
Message-Id: <20260824093357.B01F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `cpus_read_lock()` in `pai_alloc()` and `pai_event_destroy=
()` allows race conditions with CPU hotplug, leading to NULL pointer derefe=
rences and memory leaks.
--

--- Patch [3]: [PATCH 3/3] s390/pai: Support CPU hotplug for PMU PAI ---
commit 6133d1aa13480856d8fd2c6934d7911a0b59236d
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/pai: Support CPU hotplug for PMU PAI
   =20
This commit adds CPU hotplug support for the PAI PMU to prevent crashes
when CPUs are hotplugged during perf runs. It dynamically creates and
deletes per-CPU data structures during CPU offline and online states.

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
Since this iterates over the online CPU mask and modifies tskctx here
without holding cpus_read_lock(), could this race with CPU hotplug teardown?

If pai_offline_cpu() executes concurrently with pai_event_destroy():

pai_offline_cpu() runs after the CPU is removed from cpu_online_mask.

pai_event_destroy() would skip the CPU since it is not in the mask,
missing the refcount decrement, but it still decrements the global tskctx.

When pai_offline_cpu() later subtracts this newly decremented tskctx from
the CPU's refcount, will it leave the CPU's refcount permanently above zero
and leak the associated memory?

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
Could this for_each_online_cpu() iteration and tskctx increment also race
with CPU bring-up since it doesn't hold cpus_read_lock()?

The CPU hotplug callbacks are registered at CPUHP_BP_PREPARE_DYN, which
runs on the boot processor before the target CPU is added to
cpu_online_mask.

If a CPU is coming online, pai_online_cpu() could observe tskctx =3D=3D 0
and allocate nothing.

If pai_alloc() runs concurrently, it skips the new CPU because it isn't
in cpu_online_mask yet, but then increments tskctx.

When the new CPU fully comes online, it will have no cpump structure
allocated. Does this result in a NULL pointer dereference in pai_add()
when a task is scheduled on it?

Would wrapping the iterations in pai_alloc() and pai_event_destroy()
with cpus_read_lock() resolve this? (It looks like it would need to be
taken before pai_reserve_mutex to prevent AB-BA deadlocks).

> +undo:
> +	kfree(maskptr);
>  out:
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824092036.3075=
553-1-tmricht@linux.ibm.com?part=3D3
