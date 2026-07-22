Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B7B35E1C0
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734684; cv=none; b=pt9zrsMu1+WIBhdvYdd0GL5/XO3GgsAGy+Bu7bCUNr0MEl9KavAht20hwLY2Pr0YIp6jvTRfcR7fwQcMlNAbXbI1hY0fZ9k4y6EZKZ8PMIBbDc3YRejXIum2y+gRp8bbUs9o+2ydsSJ39B+nso5IDgf62HobohAvKLkekk7Q+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734684; c=relaxed/simple;
	bh=JC+ojsu6m0t3KwLU1C3V6hnctlRLRUnESzQMPkTuJMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KzBCbmGjBhiSkgws81aiWzjTd726yX3K4i4HtCE8PKu++PD1Z5c72wN660OX3mcWOny8zgf3BbqzPveu9MgRLtZGh3qFHMBU54w0dUxNSFTG/iARP1jCgawIWJhu9gwjdecAqFsuQHpFLDhgnC2vC0vsgxtQU5TcHejD/P7y2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja5l78Ov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja5l78Ov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2681F000E9;
	Wed, 22 Jul 2026 15:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784734682;
	bh=4/37yUVwj9gBzQbY/bzJw+YjrvwdU9lEA9HtkLrCbj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ja5l78Ov4dTjW1N3jh+OBs9JnIAHcJ1qBjiBnR5lvts7NGijHV4jfazv8gQwqzj/L
	 jwfCA1eamOGiWSkAEZKGhg9x6QbCT2ZT7fPQaf8itItzi1tGRQp7dGw08wjXYKpQh1
	 bCo1Xz6qD5ZnP75hJkoek/IK0jQN99Xeus8qrc1wofDemKgAPYSM/dj3loMaVsuTZO
	 ZCxLaqlui7ukB894jm/H7uz/SDWONLdUeTZfXCPawrC1QzAbx+VcCH7+FXgoQ4Vwtj
	 r+TGEsk0d/xtZKHuLwwu0AgRoni3rm1II5Ma0THvXt0OQ/FMTh7wb9ifGJSJUaQnJ4
	 TNZqCbPIr/ksw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] s390/dasd: Make FBA discard support conditional per
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Volkan Unal" <vunal@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260722151651.292621-4-vunal@linux.ibm.com>
References: <20260722151651.292621-1-vunal@linux.ibm.com>
 <20260722151651.292621-4-vunal@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 15:38:01 +0000
Message-Id: <20260722153801.DA2681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Physical FBA devices can falsely inherit discard support if they=
 bind to a bus_id previously used by a virtual FBA device.

Pre-existing issues:
- [High] Processing a discard or write zeroes request via `dasd_fba_free_cp=
()` causes a NULL pointer dereference when accessing `bio->bi_io_vec`.
--

--- Patch [3]: [PATCH 3/3] s390/dasd: Make FBA discard support conditional =
per device ---
commit 87109ad16dbff96168935ae6a9f15a26e6baaf51
Author: Volkan Unal <vunal@linux.ibm.com>

s390/dasd: Make FBA discard support conditional per device
   =20
This commit replaces the static discipline->has_discard flag with dynamic
per-device feature checks. Discard support is conditionally enabled only for
virtual FBA devices (6310/9336), while physical FBA devices (3880/3370) will
report no discard support.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index 3181c06d91ce3..3e009217c130d 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -327,7 +327,7 @@ static int dasd_state_basic_to_ready(struct dasd_devi=
ce *device)
>  	 */
>  	lim.dma_alignment =3D lim.logical_block_size - 1;
> =20
> -	if (device->discipline->has_discard) {
> +	if (dasd_get_feature(device->cdev, DASD_FEATURE_DISCARD) > 0) {
>  		unsigned int max_bytes;
> =20
>  		lim.discard_granularity =3D block->bp_block;
> diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
> index 029acb83ecab6..b28661b7c0446 100644
> --- a/drivers/s390/block/dasd_fba.c
> +++ b/drivers/s390/block/dasd_fba.c
[ ... ]
> @@ -162,8 +172,9 @@ dasd_fba_check_characteristics(struct dasd_device *de=
vice)
>  	if (readonly)
>  		set_bit(DASD_FLAG_DEVICE_RO, &device->flags);
> =20
> -	/* FBA supports discard, set the according feature bit */
> -	dasd_set_feature(cdev, DASD_FEATURE_DISCARD, 1);
> +	/* Virtual and EDEV FBA supports discard, set the according feature bit=
 */
> +	if (cdev_is_virtual_or_edev(cdev))
> +		dasd_set_feature(cdev, DASD_FEATURE_DISCARD, 1);

[Severity: Medium]
Will physical FBA devices inherit discard support if they bind to a bus_id
previously used by a virtual FBA device?

If a virtual device is unbound, the devmap persists in memory with the
DASD_FEATURE_DISCARD bit set. If a physical FBA device is subsequently bound
to the same subchannel, this code doesn't explicitly clear the bit, which
might cause the physical device to incorrectly advertise discard support.

Should there be an else branch to clear the feature bit for physical device=
s?

[ ... ]
> @@ -763,7 +774,6 @@ static struct dasd_discipline dasd_fba_discipline =3D=
 {
>  	.owner =3D THIS_MODULE,
>  	.name =3D "FBA ",
>  	.ebcname =3D "FBA ",
> -	.has_discard =3D true,
>  	.check_device =3D dasd_fba_check_characteristics,

[Severity: High]
This is a pre-existing issue, but does dasd_fba_free_cp() crash when
processing discard or write zeroes requests?

If the kernel is booted with the fixedbuffers parameter (initializing
dasd_page_cache), dasd_fba_free_cp() unconditionally enters the segment loo=
p:

drivers/s390/block/dasd_fba.c:dasd_fba_free_cp() {
    ...
	if (!dasd_page_cache)
		goto out;
    ...
	rq_for_each_segment(bv, req, iter) {
    ...
}

Since discard and write zeroes requests have no data payload, bio->bi_io_vec
is NULL, which will cause a NULL pointer dereference.

Does this iteration need a blk_rq_bytes() or bio_has_data() check before
traversing the segments?

>  	.do_analysis =3D dasd_fba_do_analysis,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722151651.2926=
21-1-vunal@linux.ibm.com?part=3D3
