Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203A73D3339
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785960292; cv=none; b=M+MFF0gkcHRZFovtOfQsX+l/10PMrjMd4lYEupRf22cx/r2DpDy6KoIH8H8r6Oh/EF7v+l5h9/DEZxh1lOXN3/MaLd/+pzjt/zvAHJPrFj11YXLyX0Pws+oTVkpFOFosljKFwQ/CNaYYIvizgThmOK3wMT9wxXUeO6YxD3XShsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785960292; c=relaxed/simple;
	bh=Jiikp8zI+NX/9PR525mchR4ZRtFtTkb3S3FlLI5v2QU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Op0MxLE7EBzKL1NJOTJg+8zlE4fdZwVfVuYFb+5RwRhOizUMk1ntAazjxn+CE9rrCcEpH2Ox2fQiJGq25Xc898wStgqwTQcWcY7fYVcrW7wAbCZ9cptiqH1W0SkcmnLyUsWJeGjtyFHW5W3T8ehDbT9Mhn+MTVI+SPsaAopgj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9bpdW2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9bpdW2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705241F000E9;
	Wed,  5 Aug 2026 20:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785960290;
	bh=Wz+RL76fDlfAke/vC+bjOu5WuIzPMM97MlHkf03H8ls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G9bpdW2R3XxBCUkd6z7LYbs7rfY//FoTzQ8Xx6VHciMglhYQHZbtPbXbbBEG3XSmx
	 5HiF65AAzIMis1qFPGvBmECWho4103T5Z4FNtztx5w0Ozi6F9Axo9ThvFhiByTmC0G
	 BuwIC8Gbm+1yzeFPW3mIp/jxkGopDF9zgb6ByslrfOqTXN6X+4hyJqPwkcwsS0s3np
	 pmOYY0gJYb3kLXrgu/66RlDbMM7WxHdREsY3wdWdYt2kpxFwWKbbXSxir88QlQK7Ys
	 oTe6Cmrnh3FDH++Cr6I6SNrlzOh/hxLoUzbHaDuWyf+xAYI6ugU2LkFeOvnvunS6Dn
	 WIUSvBgHA5J6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/19] s390/dasd: Re-enable discard support for ESE
 volumes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-19-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-19-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:04:49 +0000
Message-Id: <20260805200450.705241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Setting discard_granularity to a non-power-of-two value breaks blo=
ck layer arithmetic and causes discards to fail silently.
--

--- Patch [18]: [PATCH 18/19] s390/dasd: Re-enable discard support for ESE =
volumes ---
commit 89798f460c12b21c7a8a68cccddbe7f634389280
Author: Stefan Haberland <sth@linux.ibm.com>
s390/dasd: Re-enable discard support for ESE volumes

This commit re-enables block-layer discard for ESE ECKD volumes. It routes
discard operations to a release allocated space (RAS) function, using extent
granularity for discard limits and gating discard support on the
DASD_FEATURE_DISCARD device feature.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index 18f5f097d2b3d..5979758311c80 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -3184,6 +3187,17 @@ static blk_status_t do_dasd_request(struct blk_mq_=
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
> +			 * granularity.
> +			 * Completed after the lock is dropped.
> +			 */
> +			rc =3D BLK_STS_OK;
> +			complete_noop =3D true;

[Severity: High]
Will the misaligned discard requests produced by the alignment math be
silently dropped here?

Because the block layer might split the requests into smaller pieces that do
not cover whole extents, they are caught here and completed with BLK_STS_OK.
This gives the illusion of success to the caller, but substantial portions =
of
the disk might never actually be freed.

[ ... ]
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 3c4fcfb1558de..5c1f328b7c8d7 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> @@ -7727,6 +7786,51 @@ static unsigned int dasd_eckd_max_sectors(struct d=
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
> +}

[Severity: High]
Does setting discard_granularity to a non-power-of-two value break the block
layer alignment arithmetic?

The block layer uses round_up() and round_down() in include/linux/math.h to
handle granularity boundaries, which operate using a bitwise mask (y - 1).
Because the hardware extent size (ext_bytes) is not a power of two, this
bitmask is not a contiguous string of 1s.

This results in pseudo-random alignment boundaries, where the block layer
subsequently emits alternating 1MB and randomly-sized discard requests. Sin=
ce
1MB is smaller than a single ECKD extent (which is typically around 15MB),
these discards will not cover whole extents and will be rejected by
dasd_eckd_build_cp_discard() with -EOPNOTSUPP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D18
