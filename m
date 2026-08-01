Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18C2D6E6C
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785610012; cv=none; b=JcRUMFrEYnXf3yopijPozkrj6uZT2lw6m8JGb2Z0jEuA6j8bHLDk1MxoJt0ZGjQntzsUvk9yTC/a6UqayQ8lORKMAcmoK7CbQpRaZWczQzVuesV05XNM6twYNhK6alHEiv+AWCf4zbFfuOQtXKOtbDhAffGgCE4o93RrEnuSKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785610012; c=relaxed/simple;
	bh=UjR7JmvUCGTfmuZBAfC26Y31SP7BTPsbg/w4RnAbIGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H5iPu0u5l9S7piu3KghSgLV2IrP4d5dh25JuQWgsPR+ACQIKiUZ2bbAe2cxrcTDf14xZT4WLmJpLH+4rYrFOx9qt7VyA6riMHsx9XHbRGc7+MQEQIgW55VdWCvD5pzJBPE8SpTGXehI8Z3Jic+4eI53zg4m2EOHXi7HX507A60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+9zljS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+9zljS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E941B1F00AC4;
	Sat,  1 Aug 2026 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785610011;
	bh=SSw6GcBwIdgH3VG4tDEN5rSNsQ2Y9OK68AsucYHCAvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I+9zljS3ycZoTqDqcU2Lx4PQZmhkh6rAbAJBpslkH6GuBQOajykL3v+pvzXjTXjQi
	 V6i2gSnGd5fKMFba1pJyL5HM8nWFQXIEvPcr68lZJhye62K59U4Fa6ek9eLg8O904X
	 tSiKtnDdZKtlBpKdTApfLtXgM0FVwCw48Ca391c6P9i2A+nOPiFqp7qWPCZ2f+sl3W
	 x1r4tc8CAhUe94RgX+cmmRa4KcOyIKvnGfd4TqIO/p+7Nd85Q4l5KRfl5ZDg2IMIAt
	 1tZczjKPneD03f9EqxdOO/HY9QTWdCieX2Jux7agpLi03cy35iSf0188p0eMLiSMxy
	 d7G41dBSMK/mA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 18/19] s390/dasd: Re-enable discard support for ESE
 volumes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260801180033.3679412-19-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-19-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:46:50 +0000
Message-Id: <20260801184650.E941B1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Setting `discard_granularity` to a non-power-of-two value breaks b=
lock layer bitwise alignment macros, resulting in misaligned discard chunks=
 that silently fail to release any storage space.
--

--- Patch [18]: [PATCH v7 18/19] s390/dasd: Re-enable discard support for E=
SE volumes ---
commit 991725ca26feab13c3c8f77dd5e57ee71891a902
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Re-enable discard support for ESE volumes

This patch re-enables block-layer discard support for ESE ECKD volumes by
routing discard operations to release allocated space (RAS). It introduces
extent-aligned limit constraints and handles discarded ranges at the driver
level.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index 0e01b498b0e8e..cf6a405ee0c75 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
[ ... ]
> @@ -3172,6 +3175,18 @@ static blk_status_t do_dasd_request(struct blk_mq_=
hw_ctx *hctx,
>  			rc =3D BLK_STS_RESOURCE;
>  		} else if (PTR_ERR(cqr) =3D=3D -EINVAL) {
>  			rc =3D BLK_STS_INVAL;
> +		} else if (PTR_ERR(cqr) =3D=3D -EOPNOTSUPP) {
> +			/*
> +			 * A discard that covers no whole extent releases
> +			 * nothing. Discard is advisory, so complete it as a
> +			 * benign no-op: the device does support discard, this
> +			 * range just does not align to the large ESE extent
> +			 * granularity. Returning BLK_STS_NOTSUPP would make
> +			 * filesystems treat the device as lacking discard and
> +			 * stop issuing it. Completed after the lock is dropped.
> +			 */
> +			rc =3D BLK_STS_OK;
> +			complete_noop =3D true;

[Severity: High]
Does this code silently drop all discard requests without actually freeing
any space, when combined with the non-power-of-two discard_granularity?

If discard_granularity is not a power of two, the block layer splits the
discard bio into misaligned chunks. The CCW builder will then reject every
chunk with -EOPNOTSUPP because they don't cover a full extent. This handler
intercepts the error and completes it as BLK_STS_OK, causing user space too=
ls
like fstrim to report success while no space is released.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 27833c6d7ddf3..57e927926be1a 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> +static struct dasd_ccw_req *
> +dasd_eckd_build_cp_discard(struct dasd_device *device, struct dasd_block=
 *block,
> +			   struct request *req, sector_t first_trk,
> +			   sector_t last_trk, unsigned int first_offs,
> +			   unsigned int last_offs, unsigned int blk_per_trk)
> +{
[ ... ]
> +	/*
> +	 * RAS releases whole extents. Only release extents that lie entirely
> +	 * within the (now whole-track) discard range by rounding inward to ext=
ent
> +	 * boundaries - an extent shared with a live allocation must never be
> +	 * released. If no whole extent is covered there is nothing to release
> +	 * safely (e.g. a sub-extent discard, unavoidable with large extents), =
so
> +	 * reject the request rather than release too much.
> +	 */
> +	first_ext_trk =3D roundup(first_trk, trks_per_ext);
> +	/* one past the last whole extent inside the range (exclusive) */
> +	last_ext_end =3D rounddown(last_trk + 1, trks_per_ext);
> +	if (first_ext_trk >=3D last_ext_end)
> +		return ERR_PTR(-EOPNOTSUPP);

[Severity: High]
Does this safety check reject all the chunks generated by the block layer?

Because the block layer splits the discard bio into unaligned chunks based =
on
the corrupted math from discard_granularity, dasd_eckd_build_cp_discard()
determines that no single chunk covers a full hardware extent. It rejects e=
very
chunk with -EOPNOTSUPP, leading to the silent failure described above.

[ ... ]
> @@ -7723,6 +7782,51 @@ static unsigned int dasd_eckd_max_sectors(struct d=
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
[ ... ]
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
Will setting discard_granularity to a non-power-of-two value break the block
layer's bitwise alignment calculations?

The block layer's alignment macros, such as round_down() and round_up()
(defined in include/linux/math.h), strictly require a power of two because
they use bitwise AND masking.

When applied to non-power-of-two values, they calculate incorrect, unaligned
results. For example, round_down(BIO_MAX_SIZE, 15482880) calculates
1048576 & ~15482879, returning exactly 1MB instead of 0.

This is the root cause of the broken discards, as it causes the block layer
to compute completely unaligned boundaries instead of an approximation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D18
