Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4F47254E
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253961; cv=none; b=cO5W/I4fUQeTe68PgEvLsAImo70FD7RIopV2WobDnYSzIgpIrJji42RorQ5q/8nwefYlsZqrV4dh7ay1xr2vN0DrQFzDn3N0+hMRJ+/cKEPafuY0a0LQeVORFkQixkEqLAm28Od4GJzh0Q6buf/ldiTJN2dW8uNTTg1HKUAg7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253961; c=relaxed/simple;
	bh=qH1A1MoCtAfLTODJf0h7n/ENrB8Bs/WCqMsMXlnfMpM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aeQHcn7pX83ONSG5vZj8lp9qM7kW+h8QJ6LTDPa9XQZ8rgQjU6rMUsHxY13l4Lz5h1q/Se8yrX+YHpGtWpFeFZkLUu8lrcxPebwDPchQW2z4bmBSmIQZlndtZnVFmjMtf+/xHFuWpMO/9coEVb6gRZddGRA+NqHu4z9vo7j4vUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1ROFv7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1ROFv7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26751F000E9;
	Tue,  1 Sep 2026 09:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788253959;
	bh=uiXDHf8UtYUvg5VQhGV9v+FBF7CSNteuuDBprhz1w0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1ROFv7ZPEcbMvoBjDfm1WdReoj903ABFAbTTCtmGqQpOTv75p4L3A6KY/FfRqJ04
	 BiL3Wbh9ZgmigsbGTQyaK/glFiziJSQaE6tOJMKvMLhcnKT1ptXm68gFiT+Kcq6clM
	 12QccAeAnOzCYEJEy6S2EbBzrVM/v2yLttZhbMZjJJZtP1atb1GnuGRLff/ECC6wIk
	 GgA/SgX9B09v6fwnrHOkFIFRJ0O0XvEDyGjcQD4/WgUvyBU5IaMftERIFbDMsClqeE
	 c5ihpG6B4bZsN5TjnopJml/ve4XOoWXRFOX/4vf6eC7tvIHCjebtin/8cvj3v+tS1d
	 YGmSSXQHdX1ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3 v8] s390/pai: Use PAI PMU index as parameter
 replacing event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260901085448.2260658-2-tmricht@linux.ibm.com>
References: <20260901085448.2260658-1-tmricht@linux.ibm.com>
 <20260901085448.2260658-2-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:12:38 +0000
Message-Id: <20260901091238.F26751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on the hardware-reported NNPA counter count (=
`ib.num_nnpa`) leads to an out-of-bounds kernel heap read.
--

commit a6f12edfe6f84375133dd3bb77d40f4e8c67385e
Author: Thomas Richter <tmricht@linux.ibm.com>
s390/pai: Use PAI PMU index as parameter replacing event

This patch updates pai_alloc_cpu() and pai_event_destroy_cpu() to use
the PAI PMU index value as a parameter instead of a struct perf_event
pointer. Only the index value is actually needed inside these functions.

> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> index cdb8006220ca0..7c13f5586c793 100644
> --- a/arch/s390/kernel/perf_pai.c
> +++ b/arch/s390/kernel/perf_pai.c

[ ... ]

> @@ -241,12 +239,12 @@ static u64 paicrypt_getall(struct perf_event *event)
>   *
>   * Allocate the memory for the event.
>   */
> -static int pai_alloc_cpu(struct perf_event *event, int cpu)
> +static int pai_alloc_cpu(int idx, int cpu)
>  {
> -	int rc, idx =3D PAI_PMU_IDX(event);
>  	struct pai_map *cpump =3D NULL;
>  	bool need_paiext_cb =3D false;
>  	struct pai_mapptr *mp;
> +	int rc;

[Severity: High]
This is a pre-existing issue, but I have a question about how the buffer
allocated in this function is accessed.

In paipmu_setup(), the hardware-reported counter count (ib.num_nnpa) can be
up to 127. The code then artificially increments it for the software ALL ev=
ent:

arch/s390/kernel/perf_pai.c:paipmu_setup() {
    ...
		case PAI_PMU_EXT:
			p->num_avail =3D ib.num_nnpa;
			break;
		}
		p->num_avail +=3D 1;		/* Add xxx_ALL event */
    ...
}

This means p->num_avail can reach 128.

Later in pai_alloc_cpu(), cpump->area is allocated with a fixed size:

arch/s390/kernel/perf_pai.c:pai_alloc_cpu() {
    ...
			cpump->area =3D kzalloc(pai_pmu[idx].area_size, GFP_KERNEL);
    ...
}

For PAI_PMU_EXT, area_size is 1024 bytes, which holds exactly 128 elements.

However, pai_getdata() iterates up to p->num_avail:

arch/s390/kernel/perf_pai.c:pai_getdata() {
    ...
	for (i =3D 1; i <=3D pp->num_avail; i++) {
		u64 val =3D pai_getctr(cpump->area, i,
				     kernel ? pp->kernel_offset : 0);
    ...
}

If ib.num_nnpa is 127, p->num_avail becomes 128. The loop evaluates i =3D 1=
28
and pai_getctr() accesses cpump->area[128] (the 129th element).

Can this cause an out-of-bounds heap read if cpump->area is strictly 1024
bytes?

> =20
>  	mutex_lock(&pai_reserve_mutex);
>  	/* Allocate root node */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901085448.2260=
658-1-tmricht@linux.ibm.com?part=3D1
