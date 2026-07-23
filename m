Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477A43BDAF
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817011; cv=none; b=EGYSVQbEGDKhA8pu3jauf0idMuQDOI9zL3+szUqzbKulVZx66TfXyIfPoV/UPtLgbjDigILEiITTkaqJ+jLQNJgCxNij3wHwROeXjxjABne403QEQJ9ptiHPBheDjEcsuqn7+6fnOhhn+9Jqc8gwaSUPS7eUboiyIoouIdWStAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817011; c=relaxed/simple;
	bh=0Hp3KIPEm1xPYaqwtpD/4GATItE7jUBe480K6o6DAv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hfqTrR3C9xQphKus4xjkNrji+jY5B3mhhIMKdmusGNdJ8kuA5PTTWJFhY6uTHB9Vkk3nTHi7Q49XNCNWDeICnWRhF38X4M90bD24zJLKAeFr4Twk6OxTwuFLn494H0/0fyIHpPw1jxuNQSeJR69ZTQ1a0+PeG+h4oTgxpJgndBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596611F000E9;
	Thu, 23 Jul 2026 14:30:10 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/13] s390/dasd: Re-enable discard support for ESE
 volumes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260723134743.672413-13-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-13-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:30:06 +0000
Message-Id: <20260723143010.596611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Missing `REQ_OP_DISCARD` check in `dasd_eckd_build_cp_raw()` c=
auses NULL pointer dereference.
- [Critical] `dasd_eckd_free_cp()` crashes on `REQ_OP_DISCARD` completions =
due to NULL pointer dereference.
- [High] Non-power-of-2 `discard_granularity` breaks block layer alignment =
macros.
--

--- Patch [12]: [PATCH v3 12/13] s390/dasd: Re-enable discard support for E=
SE volumes ---
commit 246816ee6050524d3b489a73da17fa2d1d56cbcc
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Re-enable discard support for ESE volumes

Re-enable block-layer discard for ESE ECKD volumes, releasing thin space
via release allocated space (RAS).

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 1832ef5cdeedd..571a693a33a3c 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -5768,11 +5822,13 @@ static struct dasd_ccw_req *dasd_eckd_build_alias=
_cp(struct dasd_device *base,
>  						     struct request *req)
>  {
>  	struct dasd_eckd_private *private;
> -	struct dasd_device *startdev;
> +	struct dasd_device *startdev =3D NULL;
>  	unsigned long flags;
>  	struct dasd_ccw_req *cqr;
> =20
> -	startdev =3D dasd_alias_get_start_dev(base);
> +	/* Discard requests (space release) can only run on the base device. */
> +	if (req_op(req) !=3D REQ_OP_DISCARD)
> +		startdev =3D dasd_alias_get_start_dev(base);
>  	if (!startdev)
>  		startdev =3D base;
>  	private =3D startdev->private;

[Severity: Critical]
If the device has DASD_FEATURE_USERAW enabled, does this route discard
requests to dasd_eckd_build_cp_raw() where they will cause a panic?

In dasd_eckd_build_alias_cp(), we fall through to here:

        if ((base->features & DASD_FEATURE_USERAW))
                cqr =3D dasd_eckd_build_cp_raw(startdev, block, req);

If req is a REQ_OP_DISCARD, dasd_eckd_build_cp_raw() iterates over the data
segments using rq_for_each_segment(bv, req, iter). Because discard bios have
a non-zero bi_size but no data buffers (bi_io_vec is NULL), will the segment
iterator blindly dereference the NULL bi_io_vec and trigger a kernel panic?

[Severity: Critical]
When these discard requests complete, will dasd_eckd_free_cp() crash due to
a similar NULL pointer dereference?

When a request completes, dasd_eckd_free_alias_cp() delegates to
dasd_eckd_free_cp(). If dasd_page_cache is initialized, dasd_eckd_free_cp()
unconditionally attempts to iterate over the request's bio segments:

        rq_for_each_segment(bv, req, iter) {
                ...
        }

Since discard requests have no data buffers (bi_io_vec is NULL) but a
non-zero bi_size, will this iteration dereference the NULL array and panic
on every discard IO completion?

[ ... ]

> @@ -7654,6 +7710,40 @@ static unsigned int dasd_eckd_max_sectors(struct d=
asd_block *block)
>  	return DASD_ECKD_MAX_BLOCKS << block->s2b_shift;
>  }
> =20
> +/*
> + * Discard on ECKD releases space through RAS, which works on whole exte=
nts.
> + * Advertise extent granularity so the block layer only sends extent-ali=
gned
> + * discards (avoiding partially specified extents), and only for volumes=
 on ESE
> + * hardware. Non-ESE devices are left without discard limits.
> + */
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
> +
> +	trks_per_cyl =3D private->rdc_data.trk_per_cyl;
> +	recs_per_trk =3D recs_per_track(&private->rdc_data, 0, logical_block_si=
ze);
> +
> +	ext_size =3D dasd_eckd_ext_size(device);
> +	ext_limit =3D min(private->real_cyl / ext_size, DASD_ECKD_RAS_EXTS_MAX);
> +	ext_bytes =3D ext_size * trks_per_cyl * recs_per_trk * logical_block_si=
ze;
> +	max_bytes =3D UINT_MAX - (UINT_MAX % ext_bytes);
> +	if (max_bytes / ext_bytes > ext_limit)
> +		max_bytes =3D ext_bytes * ext_limit;
> +
> +	max_discard_sectors =3D max_bytes / 512;
> +
> +	lim->max_hw_discard_sectors =3D max_discard_sectors;
> +	lim->discard_granularity =3D ext_bytes;

[Severity: High]
Will this non-power-of-two discard granularity break the block layer macros?

The block layer uses round_up() and round_down() with discard_granularity to
calculate payload splits and alignment. These macros rely on bitwise masking
and strictly require the divisor to be a power of two.

Since ext_bytes (e.g., 21 tracks * 15 heads * 12 records * 4096 bytes) is
not a power of two, could this cause the block layer to compute incorrect,
unaligned discard boundaries and split bios into unsupported sizes?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D12
