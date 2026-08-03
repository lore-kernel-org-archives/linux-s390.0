Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A441386C3F
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775401; cv=none; b=kId9llXXeZeWh+UckISbnSS76eOIHWoxirSk4QSrftx/cslvFtfjfFRprFDfqk+ZjS+GvEwhqaWY1s4/F9fEg/r7Py9hE5FMoJ1yeKDTqBbfZCjXOzQWeTe9zQJdWOqgKyPl7D4gUeJUX05Uu9cxkIOh65WVtEZ+aAifggXYI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775401; c=relaxed/simple;
	bh=V70VTjd4w1pcFkNdKdzoy5HEfwr3VCJaj14Tms74Qjs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ENdh77Sq7gC0yL69QgBfHNFpvzljbofD3m0UUsFt3b3622QePEv3C0oxHdETXjeH/RLVU/jH7ILRjwpHVuB08u+zZX2qCqLIb7bJ5NvUkaTnKsoYZ0yNLK62rIjth+30ZtaOeF8gR8kRjSekla1u37aCmMeq6LuwVwuUy0UdkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlrH0Uya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlrH0Uya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73BC1F000E9;
	Mon,  3 Aug 2026 16:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785775399;
	bh=42wRr/E9nlF/9S8IFs0/gs+9INsqO/aCiC3Kq2rk7N0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QlrH0Uya+aRB3BKZZx6kAfV9Zk5lDWfG9LYnKMrYbVvGmyhFBTRmJGFrBk7/y+wWD
	 TWe6A0iy/ftIISzfrl/HLWKa92xXpmfSlXFGZzLVqRazkSjRQkiky9hftGnvhUbN+K
	 otjeHFAguxTeOMDgfl06GW2vJcf8LkDGsdEI5lU5HeUx4E7ZXWZBtKLHeBPkMSE0qH
	 IY8Aoeig19UehHAFbo6LHzdl2Dpbte32vBcDrF0jqBDROnOTzBB7DBPFoKyAh1AhVG
	 PEhJHzkLZ+0nhd39bhIkiXHnr3qt5g0Dwq+myVN14aG39yl3AA4xspIhwJWDRymolV
	 B/xruPUDL7rcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete 6
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803161651.3803702-1-tmricht@linux.ibm.com>
References: <20260803161651.3803702-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:43:18 +0000
Message-Id: <20260803164318.E73BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The CPU hotplug online handler allocates `cpuhw` with a hardcoded =
reference count of 1, ignoring the actual number of active users tracked by=
 `tskcnt`. When any single active per-task event closes, it drops the newly=
 onlined CPU's reference count to 0, prematurely freeing the infrastructure.
- [High] Unconditional freeing of CPU-bound event infrastructure during CPU=
 hotplug offline permanently breaks those events upon subsequent online.
--

--- Patch [1]: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete 6 ---
commit 8c8ba5511cad2b2a0060e9a629b6a2e2df504f2d
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/cpum_cf: Handle CPU hotplug add and delete 6

This commit changes the CPUMF PMU initialization to track the number of
active task-context events and allocate per-CPU infrastructure during CPU
hotplug add when these events are present. This prevents a NULL pointer
dereference panic when a per-task process is scheduled on a newly onlined
CPU that wasn't present during the initial perf event creation.

> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum=
_cf.c
> index 2076ac22e2c49..c94334a4cfc4b 100644
> --- a/arch/s390/kernel/perf_cpum_cf.c
> +++ b/arch/s390/kernel/perf_cpum_cf.c
[ ... ]
> @@ -1105,13 +1136,13 @@ static int cpum_cf_online_cpu(unsigned int cpu)
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
Does this code assign a reference count of 1 to the newly allocated
infrastructure regardless of how many active users are tracked by tskcnt?

If tskcnt is greater than 1, and a single task event closes,
cpum_cf_free() will decrement the reference count on all online CPUs.

Would this drop the reference count on this newly onlined CPU to 0, prematu=
rely
freeing the infrastructure while other events or /dev/hwctr sessions are
still active?

> +	mutex_unlock(&pmc_reserve_mutex);
> +	if (refcount_read(&cfset_opencnt)) {
>  		if (!rc)
>  			cfset_online_cpu(cpu);
>  	}
> @@ -1130,13 +1161,12 @@ static int cpum_cf_offline_cpu(unsigned int cpu)
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
Does this unconditional call to cpum_cf_free() permanently break CPU-bound
events when the CPU goes offline and comes back online?

CPU-bound events allocate infrastructure via cpum_cf_alloc() with a specific
CPU, taking the else branch which does not increment tskcnt:

arch/s390/kernel/perf_cpum_cf.c:cpum_cf_alloc() {
    ...
	if (cpu =3D=3D -1) {
		...
		if (!rc)
			atomic_inc(&cpu_cf_root.tskcnt);
	} else {
		rc =3D cpum_cf_alloc_cpu(cpu);
	}
    ...
}

When the CPU comes back online, cpum_cf_online_cpu() checks tskcnt:

arch/s390/kernel/perf_cpum_cf.c:cpum_cf_online_cpu() {
    ...
	if (atomic_read(&cpu_cf_root.tskcnt))
		rc =3D cpum_cf_alloc_cpu(cpu);
    ...
}

Since tskcnt was never incremented for the CPU-bound event, the
infrastructure is not reallocated. When the perf core attempts to restart t=
he
event on the new CPU, cpumf_pmu_add() will return -ENODEV.

>  	mutex_unlock(&cfset_ctrset_mutex);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803161651.3803=
702-1-tmricht@linux.ibm.com?part=3D1
