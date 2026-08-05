Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50278357CF4
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948078; cv=none; b=KFw+tTrrBFGcx6UA5qu5jc9uBHzMtgJu9erAiIUnTa+JKRz0dlW1PKGw+3KpidqRVVDYLJfCscz5EsqDbgQ891apQQDyefgPxISvS4JnXoQt+TBeSk3uPTysv5RsfIufToAdN0y/EAF5NpQa2Rw9cV/yYHNDOwY9lWmCoKeXLIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948078; c=relaxed/simple;
	bh=NxQqPiNhiWwiKDbK9pWrJWgKRgmSLvRKhHGwA/48I7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P4wqtoYt0J3YRic6VagDMpEtDOrM9hy78Y5fkW731uYNiiSC931qg8aEtsVOV7xezbDwoFF0YkVMAOy9CfVE21Fk/Ie9qXNukf00TaDYqXcdV1oN6WG+iCnJHDQJT06ZRGI16ePjWEPRZyYXTUkUBp88k/SqZyvRW6s1082r0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHVNaZmJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHVNaZmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8796E1F000E9;
	Wed,  5 Aug 2026 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948076;
	bh=5dqbgNaZ+PVKW+1U734U4LSpc7ufxRiT+UTv9ooGFsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hHVNaZmJfDUpJGxYoy9MXxPuV0rcGUE1Zt32Pn6uywMnhjNSjIDX0KL5/CqHA7ur9
	 7RkqUFwhuKI1BXZQPRe5IZA4cI5vIU/SgF6fw8YIww0PpWxGL+4kKOSfRwWZzkEg2e
	 GhPzB9eFrOj6mUoFAZ3DYLxyPvUAIgkv4UBdQZy4uln+KcHy6hEsWzngDtRf163x+j
	 +L+zQCSvgM+uIjinHyHjDeWC+K5MnKYzSKlSa8SoLgnCzldQ2A+Y380fWp/AJOFlXX
	 R60J2rtf4Kr/Ls67RRjMiDpa4DPvgoO03bW9dZvMvpHK0KePZxj8Gd6OxkUjtSdExs
	 C4lVKet4K2l8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/19] s390/dasd: Add full_track_bias to control
 fulltrack write mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-14-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-14-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:41:15 +0000
Message-Id: <20260805164116.8796E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Using `rq_data_dir(req) =3D=3D WRITE` to gate data buffer accesses=
 allows payload-less requests (such as DISCARD or WRITE_ZEROES) to bypass t=
ype safety, leading to a potential NULL pointer dereference.
- [Medium] Inconsistent initialization of `fulltrack` between the module pa=
rameter logic and the sysfs store function, leading to divergent behavior f=
or the exact same configuration value.
- [Medium] Concurrent sysfs writes to `full_track_bias` can leave `ft_bias`=
 and `fulltrack` in a permanently inconsistent state.
--

--- Patch [13]: [PATCH 13/19] s390/dasd: Add full_track_bias to control ful=
ltrack write mode ---
commit d2feac141aaa53ff2a5f42b4d0748a881207c899
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add full_track_bias to control fulltrack write mode

This patch introduces a per-device full_track_bias sysfs attribute to contr=
ol
the full-track write path for DASD ECKD devices. It routes aligned full-tra=
ck
writes through a new function based on the bias value. The patch also adds a
module parameter to set the default bias for all devices at online time.

> diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_d=
evmap.c
> index 381d616ad433f..035c022255b68 100644
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c

[ ... ]

> @@ -1630,6 +1630,44 @@ dasd_expires_store(struct device *dev, struct devi=
ce_attribute *attr,

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

[Severity: Medium]
Can concurrent sysfs writes to full_track_bias leave ft_bias and fulltrack
in a permanently inconsistent state?

If CPU1 writes 100 and CPU2 writes 0 at the same time, could they interleave
their updates to these two fields, leaving ft_bias at 0 and fulltrack at 1,
or vice-versa?

[Severity: Medium]
Does the logic here mismatch how fulltrack is initialized during online tim=
e?

In dasd_eckd_check_characteristics(), fulltrack is set to 1 only when the
bias is >=3D DASD_FT_BIAS_MAX (100). However, in this sysfs store function,
fulltrack is set to 1 for any non-zero value. Should these conditions match
to prevent the exact same configuration value from producing different
behaviors?

> +
> +	dasd_put_device(device);
> +	return count;
> +}

[ ... ]

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index da488c0775fcd..067ab66209b65 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -5204,11 +5221,20 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(st=
ruct dasd_device *startdev,
>  		/* do nothing, just fall through to the cmd mode single case */
>  	} else if ((data_size <=3D private->fcx_max_data)
>  		   && (fcx_multitrack || (first_trk =3D=3D last_trk))) {
> -		cqr =3D dasd_eckd_build_cp_tpm_track(startdev, block, req,
> -						    first_rec, last_rec,
> -						    first_trk, last_trk,
> -						    first_offs, last_offs,
> -						    blk_per_trk, blksize);
> +		if (!first_offs && (last_offs + 1 =3D=3D blk_per_trk) &&
> +		    rq_data_dir(req) =3D=3D WRITE && basedev->fulltrack) {

[Severity: High]
Can payload-less requests (such as DISCARD or WRITE_ZEROES) bypass type
safety here?

The rq_data_dir() check relies on op_is_write(), which returns true for
dataless operations. If dasd_eckd_build_cp_tpm_writefulltrack() then iterat=
es
over the bio segments without verifying bio_has_data(), could this cause a
NULL pointer dereference when accessing the data fields?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D13
