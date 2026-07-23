Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E76318EC5
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816202; cv=none; b=jKPfZYklqHExY1fd3uEDipvTwVT2p26C8T6eEYC92mYj4xkEuVu2crVEQw/06sUFUDgP3gYrAMeH+XZDwFhhMq37kpZ459FfR1hEfX+Q1I+2z+8KZ5uVzAxP8kkJ2sG0tFf8+0d5zzwofrcRoHT0xFLV1FG07aheDKns0OItx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816202; c=relaxed/simple;
	bh=M9t6OSVV45OXuFKLV+GYYfItK+aypZ+kBx9BxyuHoeY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WIOgWKZ2rURb80hVDRUl6uPwn0pULbj7ksMw2bPuD61KB3RUwPxMhnkXn6dgSOmD/aOapxkS2HGfjgN90hmeMxErGgtRJRsHIUFrIy4GRKRnwQwygssA7WCeNQd6QQQCPhJVDj1g8vWex67JpM0UqDeWHAAwDnrk9ihv1xIIjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF+Iw7xp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF+Iw7xp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0084B1F000E9;
	Thu, 23 Jul 2026 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784816199;
	bh=nw+09rd10Krxtzt5TEt0/igo+VAmYaildWyhY/2ayjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LF+Iw7xpB2YxB//Vz0wWaG7CLwJWF4R4wcIqAtLOEK/Qw1A3X+BG8AO1P3yWKsRFm
	 CMbcnT2tjNTUmBwT9D23DQAIKEt0bIc+CxOYyy8pMYzVnDbYrg1os6gvdgNfpM4j8x
	 VeWmaZRDsFJV5GQ9wXjMdYl+CUaP6cruuAGX5ZuLpuTkeQBOFTF1FCT8QUl2SeTaxB
	 SDs5YVHxPTSJFBqm8+SgtrI3oJjkJsLGJ9Bk3CLRgYKN2UGsKKMif6sxBnhEswywfL
	 UOKNokmkWT5sDS+B1tU0LCCrQ3FUj9lhYAmSiGYcR2o4u1/JayC8dFA7I5DN+qdmwL
	 dq6RU3WxXvaYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/13] s390/dasd: Add full_track_bias sysfs attribute
 to control fulltrack write mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260723134743.672413-8-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-8-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:16:38 +0000
Message-Id: <20260723141639.0084B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unconditional enablement of `WRITE_FULL_TRACK` via the `full_track=
_bias` module parameter causes a severe throughput regression for non-ESE s=
tandard ECKD devices.
- [Medium] Using `rq_data_dir(req) =3D=3D WRITE` incorrectly routes datales=
s operations to `dasd_eckd_build_cp_tpm_writefulltrack()`, violating the su=
bsystem guide and risking a NULL pointer dereference.
- [Medium] The `fillsize` calculation in `dasd_eckd_build_cp_tpm_writefullt=
rack()` lacks padding headroom, causing sporadic request build failures.
- [Low] Concurrent writes to the `full_track_bias` sysfs attribute can leav=
e `ft_bias` and `fulltrack` in an inconsistent state.
--

--- Patch [7]: [PATCH v3 07/13] s390/dasd: Add full_track_bias sysfs attrib=
ute to control fulltrack write mode ---
commit ba2fbebc6514d0ac9b7370c40e5b4ab38ea6caff
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add full_track_bias sysfs attribute to control fulltrack write m=
ode

This commit adds a full_track_bias sysfs attribute to control the full-track
write mode for ESE devices. It sets an initial default bias from a module
parameter and routes aligned write requests to the full-track write path.

> diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_d=
evmap.c
> index 381d616ad433f..035c022255b68 100644
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c

[ ... ]

> @@ -1630,6 +1630,44 @@ dasd_expires_store(struct device *dev, struct devi=
ce_attribute *attr,
>  static DEVICE_ATTR(expires, 0644, dasd_expires_show, dasd_expires_store);

[ ... ]

> +static ssize_t full_track_bias_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct dasd_device *device;
> +	unsigned int val;
> +
> +	if (kstrtouint(buf, 0, &val) || val > DASD_FT_BIAS_MAX)
> +		return -EINVAL;
> +
> +	device =3D dasd_device_from_cdev(to_ccwdev(dev));
> +	if (IS_ERR(device))
> +		return -ENODEV;
> +
> +	device->ft_bias =3D val;
> +	device->fulltrack =3D val ? 1 : 0;

[Severity: Low]
Can concurrent writes to this sysfs attribute leave ft_bias and fulltrack
in an inconsistent state?

These fields are updated sequentially without lock protection. If two
threads write different values simultaneously, it might result in a
mismatched state.

> +
> +	dasd_put_device(device);
> +	return count;
> +}

[ ... ]

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index afbc915ea4d0c..c10fe20e7d3ff 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -2118,6 +2130,10 @@ dasd_eckd_check_characteristics(struct dasd_device=
 *device)
>  	device->path_interval =3D DASD_ECKD_PATH_INTERVAL;
>  	device->aq_timeouts =3D DASD_RETRIES_MAX;
> =20
> +	/* default ESE fulltrack write aggressiveness from the module parameter=
 */
> +	device->ft_bias =3D min_t(unsigned int, full_track_bias, DASD_FT_BIAS_M=
AX);
> +	device->fulltrack =3D device->ft_bias ? 1 : 0;

[Severity: High]
Does this unconditionally enable fulltrack writes for standard non-ESE ECKD
devices?

The fulltrack flag is enabled based on the default bias, without checking
if the device is actually ESE capable. This appears to force the
WRITE_FULL_TRACK command for standard ECKD devices, which has an overall
penalty for maximum throughput.

> +
>  	if (private->conf.gneq) {
>  		value =3D 1;

[ ... ]

> @@ -5165,11 +5181,20 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(st=
ruct dasd_device *startdev,
>  		/* do nothing, just fall through to the cmd mode single case */
>  	} else if ((data_size <=3D private->fcx_max_data)
>  		   && (fcx_multitrack || (first_trk =3D=3D last_trk))) {
> -		cqr =3D dasd_eckd_build_cp_tpm_track(startdev, block, req,
> -						   first_rec, last_rec,
> -						   first_trk, last_trk,
> -						   first_offs, last_offs,
> -						   blk_per_trk, blksize);
> +		if (!first_offs && (last_offs + 1 =3D=3D blk_per_trk) &&
> +		    rq_data_dir(req) =3D=3D WRITE && basedev->fulltrack) {

[Severity: Medium]
Does this incorrectly route dataless operations like REQ_OP_WRITE_ZEROES
to the full-track write path?

The rq_data_dir() macro checks the lowest bit of the operation, which means
it evaluates to true for dataless operations. If this routes a dataless
request to dasd_eckd_build_cp_tpm_writefulltrack(), iterating over bio
segments can result in a NULL pointer dereference because dataless
operations lack a bi_io_vec.

The block layer subsystem guidelines explicitly forbid using op_is_write()
as a guard for data fields, and require bio_has_data() instead.

[Severity: Medium]
When dasd_eckd_build_cp_tpm_writefulltrack() is called, is the fillsize
calculation large enough to account for page alignment padding?

Inside dasd_eckd_build_cp_tpm_writefulltrack(), the fillsize is calculated
exactly:

fillsize =3D trkcount * (sizeof(struct eckd_r0) +
                       (sizeof(struct eckd_count) * (blk_per_trk + 2)));

However, reserve_nocross() skips padding bytes when encountering a page
boundary and subtracts the padding from the remaining space:

pad =3D PAGE_SIZE - off;
if (*space < pad)
        return NULL; /* out of space */
*p      =3D (void *)((char *)*p + pad);
*space -=3D pad;

Can this lack of padding headroom cause the preallocated filldata buffer to
run out of space prematurely, forcing a failure and a fallback to a slower
I/O mode?

> +			cqr =3D dasd_eckd_build_cp_tpm_writefulltrack(startdev, block, req,
> +								    first_rec, last_rec,
> +								    first_trk, last_trk,
> +								    first_offs, last_offs,
> +								    blk_per_trk, blksize, NULL);
> +		} else {
> +			cqr =3D dasd_eckd_build_cp_tpm_track(startdev, block, req,
> +							   first_rec, last_rec,
> +							   first_trk, last_trk,
> +							   first_offs, last_offs,
> +							   blk_per_trk, blksize);
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D7
