Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669493C3F6B
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027762; cv=none; b=m+IQeQ1O0yXmeUsl/IAcFRDgIYF3wVJ+MBPAEgEHHbvG1/QcALJbhLkMEY2RoqNOZKmeZnR9GH6I78TbJEqp0cPWb/+9JLSKu3egyVu5hd6wcr9Y6hg4W6qcpq031wX+a6AabPuyo28+NgdO0dd5gfjpwlqb/+PKhr0B+Ue/9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027762; c=relaxed/simple;
	bh=i1ViilAoWIfrvFNy2sfhaaMW34fJ6EiIye9LO/Lk/YM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NHIi0jHQRC/arNoLkMXCj/YNmn5EAlIs5+El0GxOA6J0ewZ+nAbSdPC1m6lsEG/BS1m2MhcpqgBhKUbs5v0HRstAuGpy3khhlkyjzHlOD1Csfw5g3jto1ef291VgUAUBH3uBsLHOKrP+/m/56BS00Jl0I4Yn7CKUls+zWRTHYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDwnOz7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDwnOz7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983591F000FF;
	Thu, 10 Sep 2026 08:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789027761;
	bh=KFAMVVDliXqQVM6vFn7yOJZmGCZM0VX97mLISmdaUj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oDwnOz7cU7FyBaZ9CxD7cyh+H08b6pxt3OEt3vNb5j5/741MNHw+wbSO10BZrX+10
	 0bzRZJo8ysZ6G5K0X3EY5a/JSEsSdnKXzOFLXo/pPyt9nsBwjveIqxn5+u0n/VZSRq
	 Wn8o0u/Iw5g35H32Qawfvw4uMTnSLuV8pWZgd3YfKbKMt76w36m1tLtoiL+3mEm+xw
	 8DpgBGGgCF5kmq6478fPuKFNe+dn7XIGKVYzBFH6IeoGev9pu3EVRoEJYS70mrsfib
	 AToQm0dVTZ/1TWtoN2zTXFReTgRxRZW5UTlVjSfWh84xzPsEV9sdzsI+fA/yZsTMtv
	 Rfdp8ddRXn+eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/hiperdispatch: use system_dfl_wq to reschedule
 hd_capacity_work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Euan Bourke" <euan@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260910075746.1233706-1-euan@linux.ibm.com>
References: <20260910075746.1233706-1-euan@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 08:09:20 +0000
Message-Id: <20260910080920.983591F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Replacing `schedule_delayed_work()` with `mod_delayed_work()` in=
troduces a race condition that can inadvertently overwrite the longer initi=
al delay set by `hd_enable_hiperdispatch()`.
--

commit 2fd466459ccefd111b375205c56ee7b3c6f6c69b
Author: Euan Bourke <euan@linux.ibm.com>

s390/hiperdispatch: use system_dfl_wq to reschedule hd_capacity_work

This commit updates hd_capacity_work to be rescheduled on system_dfl_wq
instead of system_percpu_wq. It accomplishes this by replacing
schedule_delayed_work() with mod_delayed_work().

> diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdis=
patch.c
> index 2172065222661..2b9187e472170 100644
> --- a/arch/s390/kernel/hiperdispatch.c
> +++ b/arch/s390/kernel/hiperdispatch.c
> @@ -265,7 +265,7 @@ static void hd_capacity_work_fn(struct work_struct *w=
ork)
>  	}
>  	trace_s390_hd_work_fn(steal_percentage, hd_entitled_cores, hd_high_capa=
city_cores);
>  	mutex_unlock(&smp_cpu_state_mutex);
> -	schedule_delayed_work(&hd_capacity_work, HD_DELAY_INTERVAL);
> +	mod_delayed_work(system_dfl_wq, &hd_capacity_work, HD_DELAY_INTERVAL);

[Severity: Medium]
Does replacing schedule_delayed_work() with mod_delayed_work() introduce a
race condition that could inadvertently overwrite the initial delay set by
hd_enable_hiperdispatch()?

If hd_capacity_work_fn() drops smp_cpu_state_mutex, and a concurrent CPU
topology update runs arch_update_cpu_topology() and acquires the mutex:

CPU 1:
hd_capacity_work_fn()
    mutex_unlock(&smp_cpu_state_mutex);
    <preempted or delayed>

CPU 2:
arch_update_cpu_topology()
    mutex_lock(&smp_cpu_state_mutex);
    hd_enable_hiperdispatch()
        mod_delayed_work(..., &hd_capacity_work, 1 second timer);

CPU 1:
    mod_delayed_work(system_dfl_wq, &hd_capacity_work, HD_DELAY_INTERVAL);

Could CPU 1 overwrite the longer 1-second delay set by CPU 2 with its
shorter 250ms timer (HD_DELAY_INTERVAL)?

The original schedule_delayed_work() internally uses queue_delayed_work(),
which safely ignores the queue request if the work is already pending,
preserving the longer interval. By switching to mod_delayed_work(), we now
unconditionally modify the timer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910075746.1233=
706-1-euan@linux.ibm.com?part=3D1
