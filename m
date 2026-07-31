Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41323D7F0
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516856; cv=none; b=qdf6qLM5/jF4CglUM2TrXnaD2GyDyD5d7TVbrvxKl/uFCpsX5TLB/iSf8OjT9fS+8G7R8BxDMSIuyGFi9qsHZRyz0TFStBHgo8LIYAAIZ4ryDBvPxEnnfrX3fj3DqtOQyNsUUMmyJSmuQPEsNwb33QZeU9Y6cPrw6hIFu1kn7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516856; c=relaxed/simple;
	bh=R7uVkihIUGxIM/xxR0GHla6sqW7taVnr9HcQGGICa2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V6Hwu8qC+5R9/GdUNSNu4vuJ6is/J+EwjD4h3BuFyiJtFzNSIEfgTfIOY7pOUfDee6AUG8BKvrMjSMSTyBW7Ztp3GZq2YpYXAn+KRbNYBoJfDlRLHIYjLuKt0fbCP8HxlS7zZk8gU6RdiqVAQTq2M56Wg6dWqd5Y7eWnj6g1mnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VltqmLXq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VltqmLXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8B41F00AC4;
	Fri, 31 Jul 2026 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785516855;
	bh=TRfMBWMm4uyXD0rPE6zKQDE/x8tZXnkoEK/eoU6zKhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VltqmLXqRAK8WADv4psYLWhka1b/IBT4yolpTQUC89qnOC9DdV5ycoYi8eyYmense
	 lu65f/bb/TAgnLgyNdYohqNMBTmY3MFkJSbPwnTEbVr3YzFWUL4YnuSZLw6RepuvVQ
	 wqOQ7KHczCAMmf8PixDcanfczjam/NfGmW6WS5SXNMGGT0eAXWpvqReJUVWy0CDmrN
	 //R5tVEQvhOAQsgoFjweoxf5pvlFx5SX3POT1Dr7Y3avsrbD5jWCuPtJzyXipmTcSA
	 S+Nx06LOWMG6CqLlcS3qmhPqjIxIhxv/3jVYW3JxozmyP0QpAPcIHTphU65CyW0+SA
	 M0GH47RDv3p8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/17] s390/dasd: Re-enable discard support for ESE
 volumes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-17-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-17-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:54:14 +0000
Message-Id: <20260731165414.7D8B41F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Setting discard_granularity to a non-power-of-two value corrup=
ts block layer discard math.
- [High] Returning BLK_STS_NOTSUPP for a benign unaligned discard causes fi=
lesystems to permanently disable discard support.
- [High] Potential divide-by-zero kernel panic in dasd_eckd_disc_limits if =
ext_bytes evaluates to 0.
--

--- Patch [16]: [PATCH v5 16/17] s390/dasd: Re-enable discard support for E=
SE volumes ---
commit 7e5698c663d8a9a7aaad634b522a9f242320381c
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Re-enable discard support for ESE volumes

Re-enable block-layer discard for ESE ECKD volumes, releasing thin space
via release allocated space (RAS). This routes REQ_OP_DISCARD to a RAS rele=
ase
over the request's track range and defines limits using extent granularity.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c

[ ... ]

> @@ -3157,6 +3159,15 @@ static blk_status_t do_dasd_request(struct blk_mq_=
hw_ctx *hctx,
>  			rc =3D BLK_STS_RESOURCE;
>  		} else if (PTR_ERR(cqr) =3D=3D -EINVAL) {
>  			rc =3D BLK_STS_INVAL;
> +		} else if (PTR_ERR(cqr) =3D=3D -EOPNOTSUPP) {
> +			/*
> +			 * e.g. a discard that covers no whole extent. This is an
> +			 * expected, benign outcome (fstrim ranges rarely align to
> +			 * the large ESE extent granularity), so silence the
> +			 * per-request block-layer error print for it.
> +			 */
> +			req->rq_flags |=3D RQF_QUIET;
> +			rc =3D BLK_STS_NOTSUPP;

[Severity: High]
Will this cause upper layers to completely disable discard support?

When returning BLK_STS_NOTSUPP for a benign unaligned discard, filesystems
like ext4 typically interpret this as the underlying device lacking discard
support entirely. This causes them to clear their DISCARD mount flag,
permanently disabling discard for the volume.

Should this instead complete the request with BLK_STS_OK so that it acts as
a silent no-op without breaking subsequent discard requests?

>  		} else {
>  			DBF_DEV_EVENT(DBF_ERR, basedev,
>  				      "CCW creation failed (rc=3D%ld) on request %p",

[ ... ]

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -7708,6 +7767,49 @@ static unsigned int dasd_eckd_max_sectors(struct d=
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

[Severity: High]
Can ext_bytes evaluate to zero here?

If the hardware or hypervisor supplies malformed RDC data, or if recs_per_t=
rk
evaluates to 0 due to an unrecognized device type, ext_bytes will be zero.

Would the subsequent modulo arithmetic (UINT_MAX % ext_bytes) then trigger
a divide-by-zero panic during device initialization?

> +	if (max_bytes / ext_bytes > ext_limit)
> +		max_bytes =3D ext_bytes * ext_limit;
> +
> +	max_discard_sectors =3D max_bytes / 512;
> +
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

[Severity: Critical]
Is it safe to use a non-power-of-two value for discard_granularity here?

The block layer strictly requires discard_granularity to be a power of two
because it relies on bitwise macros to compute discard alignments (such as
sector &=3D ~(granularity >> SECTOR_SHIFT - 1) in __blkdev_issue_discard).

Could supplying a non-power-of-two value break these assumptions and cause
the block layer to compute incorrect sector offsets and lengths, potentially
discarding live filesystem data instead of free space?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D16
