Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6ADDCD
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584754; cv=none; b=MrlbufBkiizb6KBrPS8rnNcdHFQggNj3toZoirr0trSjWuKIAwr0ZCACaZJb7L+FQWdkXSl2jFGewK1nLzFgrDhK8x1YUP8xClAL0UeY83PcBxP+9cjJim2H8IDs/Jtut0VdSd1gZcXRcDzDTvy+2K/fyHCVOtpqfHXiXlTcfU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584754; c=relaxed/simple;
	bh=q4Cia3dPHKBDJLPYCptPkK12zWRR/apAvD7nvQdX5/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EW7LUlmWsiOsF5x3hc3Uz8wiavTPc5gbvm8gjo/UygDJfNRUvgmjUM0IzxN8748ezgZ0a3gVURUoyRchQAdDamMWvCr6vjcHstlkALFZWo5UP+m6HtBqvmRWU4Muk2ErYocIbhibvFObTI7Qe7jsHuMJJYcsmMIpg0TOnDZMDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahpLq3MC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahpLq3MC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F1E1F00AC4;
	Sat,  1 Aug 2026 11:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785584753;
	bh=SrBWgj9Y4HSgd7z6e8Pk87DlHGfqjveofxaE323wNQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ahpLq3MCyUVXinF1We541TYSNNo0y7ncPXUM6Ui+KPn8bgZaKLdxckKnfK5r4KueU
	 9yNigEbPD2uV0aykM1M+jGMakX8StE2KKcwRTMlcrQB0uMm+v280c0Rj1cOkzvFkky
	 W3TDU9nJy7+REO/IBknfZs5PUBisdU3d6hIDH84UB3xAdo5tyZBjEWNDhimWeAnuGz
	 9KI4kRVtp5inT8v6MIWLiSLxTdtjM6df0Z6F4nWlvB5fn2N+RRMZgKEOrHajflrzfn
	 YXi9/lo8gJScNk4GE4KER7PZ4xvE52k+18qKAjI2DgkQ+CtBruzR47hC3yfFvc6uSF
	 GA96tOZz5zXgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/18] s390/dasd: Re-enable discard support for ESE
 volumes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-18-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-18-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:45:52 +0000
Message-Id: <20260801114552.E7F1E1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Setting `discard_granularity` to a non-power-of-two value (`ext_by=
tes`) corrupts block layer alignment calculations, leading to undefined beh=
avior and invalid sysfs limit checks.
- [Medium] Failing to clear discard limits when `DASD_FEATURE_DISCARD` is a=
bsent leaks stale state, silently dropping discards.
--

--- Patch [17]: [PATCH v6 17/18] s390/dasd: Re-enable discard support for E=
SE volumes ---
commit a7ac6b0317116af2619de6aa7c00453f40467824
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Re-enable discard support for ESE volumes

Re-enable block-layer discard for ESE ECKD volumes, releasing thin space
via release allocated space (RAS). REQ_OP_DISCARD is routed to a RAS
release over the request's track range, and discard requests run on the
base device only. Discard limits use extent granularity via the disc_limits
discipline hook so the block layer only issues extent-aligned discards.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -353,17 +353,19 @@ static int dasd_state_basic_to_ready(struct dasd_de=
vice *device)
>  	 */
>  	lim.dma_alignment =3D lim.logical_block_size - 1;
> =20
> -	if (device->discipline->has_discard) {
> +	if (device->features & DASD_FEATURE_DISCARD) {
>  		unsigned int max_bytes;
> =20
> -		lim.discard_granularity =3D block->bp_block;
> -
> -		/* Calculate max_discard_sectors and make it PAGE aligned */
> -		max_bytes =3D USHRT_MAX * block->bp_block;
> -		max_bytes =3D ALIGN_DOWN(max_bytes, PAGE_SIZE);
> -
> -		lim.max_hw_discard_sectors =3D max_bytes / block->bp_block;
> -		lim.max_write_zeroes_sectors =3D lim.max_hw_discard_sectors;
> +		if (device->discipline->disc_limits) {
> +			device->discipline->disc_limits(block, &lim);
> +		} else {
> +			lim.discard_granularity =3D block->bp_block;
> +			/* Calculate max_discard_sectors and make it PAGE aligned */
> +			max_bytes =3D USHRT_MAX * block->bp_block;
> +			max_bytes =3D ALIGN_DOWN(max_bytes, PAGE_SIZE);
> +			lim.max_hw_discard_sectors =3D max_bytes / block->bp_block;
> +			lim.max_write_zeroes_sectors =3D lim.max_hw_discard_sectors;
> +		}
>  	}

[Severity: Medium]
If a volume is reconfigured from thin (ESE) to standard and re-evaluated,
does this leak stale discard limits?

Since queue_limits_start_update() retains the old limits, skipping an
explicit clearing of lim.max_hw_discard_sectors and lim.discard_granularity
when DASD_FEATURE_DISCARD is absent might leave stale values.

Could this cause the block layer to continue issuing REQ_OP_DISCARD requests
which are then silently dropped?

>  	rc =3D queue_limits_commit_update(block->gdp->queue, &lim);
>  	if (rc)
>  		return rc;

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> +static void dasd_eckd_disc_limits(struct dasd_block *block,
> +				  struct queue_limits *lim)
> +{
> +	struct dasd_device *device =3D block->base;
> +	struct dasd_eckd_private *private =3D device->private;
> +	unsigned int logical_block_size =3D block->bp_block;
> +	unsigned int max_discard_sectors, max_bytes, ext_bytes;
> +	int recs_per_trk, trks_per_cyl, ext_limit, ext_size;
> +
> +	if (!dasd_eckd_ese_capable(device) || dasd_eckd_ext_size(device) =3D=3D=
 0)
> +		return;

[Severity: Medium]
Similarly, does this early return abandon limit initialization without
clearing existing stale limits if the device is no longer ESE capable?

[ ... ]

> +	lim->max_hw_discard_sectors =3D max_discard_sectors;
> +	/*
> +	 * ext_bytes is the hardware extent size and is not a power of two, so
> +	 * the block layer's power-of-two round_up()/round_down() alignment
> +	 * helpers compute it only approximately. That is a hint, not a
> +	 * correctness requirement: RAS safety is enforced in the CCW builder,
> +	 * which rounds the range inward to whole extents and rejects a request
> +	 * that covers no whole extent, so a misaligned range is never
> +	 * over-released. At worst a few sub-extent discards are declined.
> +	 */
> +	lim->discard_granularity =3D ext_bytes;

[Severity: High]
Is it safe to assign a non-power-of-two hardware extent size (ext_bytes)
to lim->discard_granularity here?

The block layer strictly requires this value to be a power of two because it
relies on bitwise masks in sysfs store functions, like
queue_max_discard_sectors_store(). Filesystems also expect a power of two
for these fields.

Could this corrupt bitwise calculations, randomly failing valid sysfs writes
and causing filesystems to miscalculate discard boundaries?

> +}
> +
>  static struct ccw_driver dasd_eckd_driver =3D {
>  	.driver =3D {
>  		.name	=3D "dasd-eckd",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D17
