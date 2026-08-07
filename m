Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31023FDC0E
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092684; cv=none; b=CR7+2+1Kp7okZUAq9ig72bEkldS/s+eBs5wvDDBSgLT/jbYvnUaet2utGDE/xHtqqyzt/zgqu3tDlwTHxujtJtYhYwgmaO66mt3TZuAOmE8b80qwSYFec6qT8tUYQLMPTts7872zAOp/sZ0+gsGOy4pW2o0e4iCSZq3SFVWmY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092684; c=relaxed/simple;
	bh=q4LK3gLhiWTGXlGliPU0dTMlRiT3UZ3DLb90CzgWNb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a9wweWD2If0ODk0Z3c9y57GKVTrLsXNvR9F5/1Cp0e5BCLpU/nL8CqXkXriecf9m3rxTFAHI4jGzFbvi8gbI09/o2qmdN4oIxQ2s/P7TlvBPHqHJpHwjSqiBCNyAHyt+bSa39Qvjc+EpIsktMRfkocOhhC7y4/HpYzq6u8Rqcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI9RCfu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI9RCfu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533281F000E9;
	Fri,  7 Aug 2026 08:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092683;
	bh=yx7NirbkxoovqffPx5utEowrXkw0VNhxUqq7P1H2qfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UI9RCfu92e9LliTym+xmQxMuncOubq8ftwdYR0tjNWYJf9UBHwWRp1fQ/jKhQosdT
	 fgxS1ga9wAF4fBezDyBvCyWlnInU3HlTaWwAD8Fk00zm5wucA591eoFSe5sao1rqOS
	 ejfpCKKB5uYGLwyhf5g70vKXrKiqFD+ZAx9eKG5Uw8z2uL0duWrYxta7/D3GAU17yf
	 k/Yq3VU5ZzlKAx3iPAVPsWk0UkCes4pVPGX5i0HfFeV1qUTQ1kUxDqR7Ef1SWH7f7X
	 Y2aB9LjfEkXUic/S4uBojssBkwqr46B35VJIrjIaTNN33BFvsLzYrBZ2yXAO0w+PHU
	 qR2u9sYikfCYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] s390/pai: Use PAI PMU index as parameter replacing
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260807083910.3771502-1-tmricht@linux.ibm.com>
References: <20260807083910.3771502-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:51:21 +0000
Message-Id: <20260807085122.533281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The PAI PMU lacks CPU hotplug state registration. When a per-task =
event is created, per-CPU data is allocated only for currently online CPUs.=
 If a task migrates to a newly onlined CPU, PMU callbacks dereference a NUL=
L per-CPU pointer, causing a kernel panic.
--

--- Patch [1]: [PATCH 1/2] s390/pai: Use PAI PMU index as parameter replaci=
ng event ---
commit a1e342cbbe1229dba8d0d235d003b35f9d061a5f
Author: Thomas Richter <tmricht@linux.ibm.com>

s390/pai: Use PAI PMU index as parameter replacing event

This patch updates the PAI PMU code to use the PAI index value directly
as a function argument instead of passing a pointer to struct perf_event.
This simplifies functions like pai_alloc_cpu() and pai_event_destroy_cpu()
without introducing any functional changes.

> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> index cdb8006220ca0..7c13f5586c793 100644
> --- a/arch/s390/kernel/perf_pai.c
> +++ b/arch/s390/kernel/perf_pai.c

[ ... ]

> @@ -318,6 +316,7 @@ static int pai_alloc_cpu(struct perf_event *event, in=
t cpu)
> =20
>  static int pai_alloc(struct perf_event *event)
>  {
> +	int idx =3D PAI_PMU_IDX(event);
>  	struct cpumask *maskptr;
>  	int cpu, rc =3D -ENOMEM;
> =20
> @@ -326,10 +325,10 @@ static int pai_alloc(struct perf_event *event)
>  		goto out;
> =20
>  	for_each_online_cpu(cpu) {
> -		rc =3D pai_alloc_cpu(event, cpu);
> +		rc =3D pai_alloc_cpu(idx, cpu);

[Severity: High]
This is a pre-existing issue, but does this allocation strategy handle CPU
hotplug correctly?

Since memory for the PMU context is only allocated for currently online
CPUs, what happens if a task migrates to a newly onlined CPU?

Looking at pai_add(), if a task is scheduled on a newly hotplugged CPU
where no memory was allocated, it seems mp->mapptr will be NULL:

arch/s390/kernel/perf_pai.c:pai_add() {
    ...
    struct pai_map *cpump =3D mp->mapptr;
    struct paiext_cb *pcb =3D cpump->paiext_cb;
    ...
}

Can this lead to a NULL pointer dereference when accessing cpump->paiext_cb?

Should the PAI PMU register for CPU hotplug states to ensure memory is
allocated when new CPUs come online?

>  		if (rc) {
>  			for_each_cpu(cpu, maskptr)
> -				pai_event_destroy_cpu(event, cpu);
> +				pai_event_destroy_cpu(idx, cpu);
>  			kfree(maskptr);
>  			goto out;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807083910.3771=
502-1-tmricht@linux.ibm.com?part=3D1
