Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD864B1475
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212397; cv=none; b=ngzFKzICfApDUWDkV50RJJs+8gOBxjf0oTRUSsIXGtXjWVXuuJK4GblGcYbchkZQaM+difT7ZdTSOAy565PiU/y0FiMFgkMh6SagnNlEGg0nw0G0ygKMNzbIrjNI/p9ypP2aHPWWko+S6oFohrH63lICV6va6xpXNVJvq4G5QKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212397; c=relaxed/simple;
	bh=DCofHnCBlxUMxAU6i+gCIQGPtNUPXQ+YVptg1tWFpwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qg/pdi5nADB1muYgzkNEXyvldJUfjXZzHTlaVVO8zLGfQSn57eeo4WJs25pnHKE32uu1VcoYWVzcVt2Ai9VqCu34kNNMPPH4GU7BRFjeLWVWrbyJLuvt4vo6gH8dZvj6I/XD9cyDCsxPoZ93J15PJTG3uFFExeRMwHdyuT6ZJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkwnfk9A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkwnfk9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53D91F000FF;
	Mon,  5 Oct 2026 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212396;
	bh=6SyWJT4E8OJowMBQ2olwWZDm5fhbDMyTFzMNSXyOhM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tkwnfk9A+w/GkjB4y5+fPrSYOkH0Jnb+HJvZTOh+9CL5kCywFQ1HD6D1h6LIbpw4I
	 kCnFiVeaoAsxwGsFYrXRLihhxhKSCAjOxWD/uEu1fd/bb5ENJ1OugQMizVuvdfoUpf
	 U7cjHT6qMCPUeI8Z1qnFYhfV4217IOuCQKH7DrOs96tUwnIFWEqVGSixp3YuY1Z1dK
	 oCFl+ej78Cn68opvhaH3SRKdk2UPXJDBGo3/M4HKzqD05oh8Nik8mr6JS6sJ6VBUzO
	 Hl8dO2hlbTU9n8cYUbcxnZM4vd1DyVRYz7VonVQLlFXe7/g+m1CV9VkDxef9YJsRdu
	 SMpp5vP5nnvRA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] s390/appldata: Emulate virtual timer with
 delayed work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261005145004.156348-2-hca@linux.ibm.com>
References: <20261005145004.156348-1-hca@linux.ibm.com>
 <20261005145004.156348-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 14:59:55 +0000
Message-Id: <20261005145955.D53D91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] sysctl: race in timer deactivation allows permanent stall
- [Medium] appldata: interval sysctl updates ignored due to schedule_delaye=
d_work()
- [Medium] appldata: CPU offlining causes arithmetic underflow and prematur=
e execution
--

commit 8e2ea62d851c3c34199ee4aaf1c6b3ad590787f1
Author: Heiko Carstens <hca@linux.ibm.com>

s390/appldata: Emulate virtual timer with delayed work

This commit emulates the virtual timer in appldata using delayed work
to allow for the eventual removal of the vtimer infrastructure. The work is
scheduled for the minimum wall-clock time until the configured CPU-time
interval elapses, subsequently reading per-CPU statistics.

> diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appl=
data_base.c
> index 9cba4633c3f3b..aca747c98f1b0 100644
> --- a/arch/s390/appldata/appldata_base.c
> +++ b/arch/s390/appldata/appldata_base.c

[ ... ]

> +static u64 appldata_total_cpu_time_ns(void)
> +{
> +	u64 total =3D 0;
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		total +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_USER];
> +		total +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];
> +		total +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_SYSTEM];
> +		total +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_IRQ];
> +		total +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_SOFTIRQ];
> +	}
> +	return total;
> +}

[Severity: Medium]
Is it safe to use for_each_online_cpu() here for a monotonic time counter?

If a CPU goes offline, won't the returned total time unexpectedly shrink?
Later, when calculating the elapsed time:

elapsed =3D now - appldata_cputime_start;

If now shrinks to be smaller than appldata_cputime_start, elapsed will
underflow to a massive unsigned value. This bypasses the elapsed < interval
check in appldata_work_fn() and causes the callbacks to execute immediately.

[ ... ]

> +static void appldata_schedule_work(u64 remaining)
>  {
> -	queue_work(appldata_wq, (struct work_struct *) data);
> +	unsigned int ncpus =3D num_online_cpus();
> +	unsigned long delay =3D HZ / 10;
> +
> +	/*
> +	 * At most ncpus CPUs consume CPU time simultaneously, so the
> +	 * minimum wall-clock time until the remaining CPU time elapses
> +	 * is remaining / ncpus.
> +	 * Make sure the work is not scheduled more than once per 100ms.
> +	 */
> +	delay =3D max(delay, nsecs_to_jiffies(remaining / ncpus));
> +	schedule_delayed_work(&appldata_work, delay);
>  }

[Severity: Medium]
Does this successfully update the interval if the work is already queued?

When a user updates the interval via /proc/sys/appldata/interval, the sysctl
handler calls appldata_work_setup(APPLDATA_MOD_TIMER), which eventually cal=
ls
this function.

Since schedule_delayed_work() is a no-op when a work item is already queued,
it seems the requested interval change is ignored for the current cycle. Wo=
uld
mod_delayed_work() be required here instead to update the existing timer?

[ ... ]

> @@ -215,12 +240,12 @@ appldata_timer_handler(const struct ctl_table *ctl,=
 int write,
>  	if (rc < 0 || !write)
>  		return rc;
> =20
> -	spin_lock(&appldata_timer_lock);
> -	if (timer_active)
> -		__appldata_vtimer_setup(APPLDATA_ADD_TIMER);
> -	else
> -		__appldata_vtimer_setup(APPLDATA_DEL_TIMER);
> -	spin_unlock(&appldata_timer_lock);
> +	if (timer_active) {
> +		scoped_guard(mutex, &appldata_timer_lock)
> +			appldata_work_setup(APPLDATA_ADD_TIMER);
> +	} else {
> +		appldata_work_setup(APPLDATA_DEL_TIMER);
> +	}
>  	return 0;
>  }

[Severity: Medium]
Is there a race condition here since the APPLDATA_DEL_TIMER path does not
take the appldata_timer_lock?

If a sysctl write of 0 (DEL_TIMER) races with a concurrent sysctl write of 1
(ADD_TIMER), they could interleave. If DEL_TIMER executes locklessly and
sets appldata_timer_active =3D 0 just before ADD_TIMER takes the lock and q=
ueues
the work, DEL_TIMER might proceed to unconditionally cancel the newly queued
work.

This would leave the timer in an active =3D 1 state without any delayed work
queued, permanently breaking appldata gathering.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005145004.1563=
48-1-hca@linux.ibm.com?part=3D1
