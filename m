Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8653D44D01F
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515315; cv=none; b=ZIRv0WvXA9j9dVXYQd9KwJC/YKjpOj1IItWKScOvsi/23q1w3NgT8Ztl63m589Tt6XRE5XPepQ4UO2tmEtaaAOD8nqy6V0nMK6b2PbegFicfWGDJjFndTPhkmbxl5bKhXupkweIMHyCAMzyRVQHls56W119NURUrgJNYQUvjUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515315; c=relaxed/simple;
	bh=2fw5/1SSdPFxO28F5LwP4DVTY8WKgI7c7kJ6WYE0AtI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tLjdRgIZZ0Xi0daQV/7ayNuPfKDUmHJDUvV23cmM+68tcAdInIWHNFCqggUrzqmr3pLp+8QLkrh/K9eDW8F0nk2Pdbb9OlAs0hRB4fnKEEwNGGjpRyPaZM4fzJhJN+iivabmfnbi1XECEj8MtIu6pVsxQ+RMO2YYqSGzqLO7e90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJyYXTAJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJyYXTAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7A21F00ACF;
	Fri, 31 Jul 2026 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515309;
	bh=+aeh7DTMr2uBWBp9XBApqvVNW1yLCuqADCpd3g72Jfs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mJyYXTAJTEdN6q3MWm/5m5r8TU71HQvKvXdvHDi+7aUQpXR4LzBiaXHnltFnBpiyR
	 Y/e+8dQIpJfarp1Q0qpNyq+Q3mFEf3neC+U5rZVICY8KNJuhbLHGPMJpROb14lbiuR
	 MdfO8Fa/nCoPQUKPUL+XRSbktpSdydGk0ygnSU2M/aq7q9Xft+oXpVrBoOYTj/rJS3
	 3q2tXnGmROgZhNG9VddrQZkwfLZr5mDug7z4ExuEDwfIxeDDsu6aLQYremVGpUD/ke
	 ucxQ/UGYkwLMD+PBecJX7CbVldqnrAQMtMq3IVM2A/UFd7xQzWQ+5urvL/gZS9VfgG
	 IX3xh7bLw9HrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/17] s390/dasd: Add full_track_bias to control
 fulltrack write mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-12-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-12-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:28:29 +0000
Message-Id: <20260731162829.9E7A21F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Inconsistent initialization of the `fulltrack` flag disables ful=
l-track writes by default, contradicting the intended behavior and sysfs st=
ore logic.
- [Medium] Full-track writes are applied unconditionally to non-ESE devices=
, exposing them to unintended performance penalties.
--

--- Patch [11]: [PATCH v5 11/17] s390/dasd: Add full_track_bias to control =
fulltrack write mode ---
commit c5f39fbb283ed6068ac10c59d09a116557c8bbf1
Author: Stefan Haberland <sth@linux.ibm.com>
s390/dasd: Add full_track_bias to control fulltrack write mode

This patch adds a per-device full_track_bias sysfs attribute to control
full-track write routing for s390 DASD devices. It introduces a module
parameter to set the default bias applied at online time. The default
value is intended to enable full-track writes out of the box to avoid
ESE format penalties.

> diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_d=
evmap.c
> index 381d616ad433f..035c022255b68 100644
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c

[ ... ]

> @@ -1630,6 +1630,44 @@ dasd_expires_store(struct device *dev, struct devi=
ce_attribute *attr,
> =20
>  static DEVICE_ATTR(expires, 0644, dasd_expires_show, dasd_expires_store);
> =20
> +/* ESE fulltrack write aggressiveness knob (0..100, see DASD_FT_BIAS_*) =
*/
> +static ssize_t
> +full_track_bias_show(struct device *dev, struct device_attribute *attr, =
char *buf)
> +{

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
> +
> +	dasd_put_device(device);
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(full_track_bias);
> +
>  static ssize_t
>  dasd_retries_show(struct device *dev, struct device_attribute *attr, cha=
r *buf)
>  {

[ ... ]

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 4fe1b78366b04..cc5a4791cb8f4 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -2148,6 +2160,11 @@ dasd_eckd_check_characteristics(struct dasd_device=
 *device)
>  	device->path_interval =3D DASD_ECKD_PATH_INTERVAL;
>  	device->aq_timeouts =3D DASD_RETRIES_MAX;
> =20
> +	/* default ESE fulltrack write aggressiveness from the module parameter=
 */
> +	device->ft_bias =3D min_t(unsigned int, full_track_bias, DASD_FT_BIAS_M=
AX);
> +	/* only the "always" endpoint forces fulltrack unconditionally here */
> +	device->fulltrack =3D (device->ft_bias >=3D DASD_FT_BIAS_MAX) ? 1 : 0;

[Severity: Medium]
Is this initialization of device->fulltrack contradicting the logic in
full_track_bias_store()?

In full_track_bias_store() above, device->fulltrack is set to 1 for any
non-zero value (device->fulltrack =3D val ? 1 : 0). However, here it is only
set to 1 if device->ft_bias >=3D DASD_FT_BIAS_MAX.

Since the default full_track_bias is DASD_FT_BIAS_DEFAULT (which is 50), th=
is
yields 0 during initialization. This appears to contradict the commit messa=
ge
which states: "The default (DASD_FT_BIAS_DEFAULT) enables full-track writes=
 so
the ESE format penalty is avoided out of the box."

> +
>  	if (private->conf.gneq) {
>  		value =3D 1;
>  		for (i =3D 0; i < private->conf.gneq->timeout.value; i++)

[ ... ]

> @@ -5194,11 +5211,20 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(st=
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

[Severity: Medium]
Should there be a check here to ensure the device is an ESE volume before
routing the IO to the full-track write path?

The commit message mentions that "The WRITE_FULL_TRACK command has an
advantage on sparse formatted ESE devices but it has an overall penalty for
maximum throughput compared to usual track based IO."

However, neither the initialization in dasd_eckd_check_characteristics() nor
the sysfs store function guards the bias assignment with an ESE check (e.g.,
dasd_eckd_is_ese(basedev)).=20

If basedev->fulltrack is enabled on a non-ESE device either via sysfs or by
fixing the default initialization, could it suffer the performance penalty
without the intended benefits?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D11
