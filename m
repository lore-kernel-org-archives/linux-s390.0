Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C191A6816
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651970; cv=none; b=jyU+9LJvKCqV31aNPNXvHo0uRHUhQS3VSld1VpgFSRCD6mglS0or7v2Yy0B7QpLbsjvb35Rt+pyvis8U78Gz+ri8ZMXLIgDt8A9+HQ438nxGz0NbK0wbyCBZU6XMa3jLE9Ve8/x8Pdvb2rA43v+aq+T4SbXvKtdb4z63/G2gC40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651970; c=relaxed/simple;
	bh=mzU9qN2s4cl8/oB6F8WrSldtZWrKaALQkwNn7ctT/pE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EO++6dUgCwlxhqALZUBTG8JRYnGz5KK0jcjPfq3ddmVADOBYGliHqWktECHb+IDGPqoPRDkI6xetD4HWaFXu61Y0vUWgVp07U3dUOcXsaw+lz6/ZNHq2ErMKw6n8+4JbkbPVlxrYDy2kjzqLq9s4r/uwdgvJ/r1DzbLS5jilKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or8Unfis; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or8Unfis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DC81F000E9;
	Tue, 25 Aug 2026 09:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787651969;
	bh=alZlY77WMjwL1nHwrVAdTGrEUOjCl27OPA23QvVwUjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=or8UnfisPH/PQ/JypRHTV26RHMyXkH0As5TWTV4JC8sbkFOCxINWxApbpdRSkmY5e
	 GFzXJxCI7tRzISSgIfRxSpktXy79bmsPFw8pjF9YmGu+iS+jP8WSgcAgOMsRWkIFgt
	 DHgJNUms0HeOfjovCBGIAAJ5QAzaTsVhRAlMtygA5kUliA045NoIdyzDqCSW/KH0WF
	 bAozE6TCW0NVlXRQWyKbNn5pFN/qHcfIvVbnGJu0IyoM9Mct7I5VXN/jREqZl/PiJT
	 h40fCHp17vYSA5aLKXejH/+jTsu+C/1lOjfw21vUaT3C9MuW8Jz3HHqks7cMSyPCCu
	 ahC7Ws5JZIpYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/pai: Reduce excessive debug feature size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260825094925.1791807-1-hca@linux.ibm.com>
References: <20260825094925.1791807-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 09:59:28 +0000
Message-Id: <20260825095928.C9DC81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing CPU hotplug handling causes uninitialized per-CPU pointers=
 to be dereferenced when task-bound perf events migrate to newly onlined CP=
Us.
--

--- Patch [1]: [PATCH] s390/pai: Reduce excessive debug feature size ---
commit 07fb6d75462afb53888116fff8b2fe4b2e6d8db6
Author: Heiko Carstens <hca@linux.ibm.com>

s390/pai: Reduce excessive debug feature size

The pai debug feature is registered with 256 areas, where each area
contains 32 pages. This sums up to a total of 32MiB. The code does not use
any debug exceptions, which means that 255 of those areas are never
used.

> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> index cdb8006220ca0..ab76ed7ad791e 100644
> --- a/arch/s390/kernel/perf_pai.c
> +++ b/arch/s390/kernel/perf_pai.c
> @@ -1221,7 +1221,7 @@ static int __init paipmu_setup(void)
>  static int __init pai_init(void)
>  {
>  	/* Setup s390dbf facility */
> -	paidbg =3D debug_register("pai", 32, 256, 128);
> +	paidbg =3D debug_register("pai", 1, 1, 128);

[Severity: High]
This is a pre-existing issue, but does the PAI PMU code handle CPU
hotplugging correctly?

If pai_alloc() only allocates PMU tracking structures for currently online
CPUs:

arch/s390/kernel/perf_pai.c:pai_alloc() {
    ...
    for_each_online_cpu(cpu) {
        rc =3D pai_alloc_cpu(event, cpu);
        if (rc) {
    ...
}

And a task with an active PAI event migrates to a newly onlined CPU where
structures were not allocated, won't mp->mapptr be NULL here:

arch/s390/kernel/perf_pai.c:pai_add() {
    ...
    struct pai_map *cpump =3D mp->mapptr;
    struct paiext_cb *pcb =3D cpump->paiext_cb;
    unsigned long ccd;

    if (++cpump->active_events =3D=3D 1) {
    ...
}

Could this lead to a NULL pointer dereference when accessing
cpump->paiext_cb or cpump->active_events?

>  	if (!paidbg) {
>  		pr_err("Registration of s390dbf pai failed\n");
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825094925.1791=
807-1-hca@linux.ibm.com?part=3D1
