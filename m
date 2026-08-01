Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B5A3BED69
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608433; cv=none; b=peFmwIzm7kZk+55XrJ+sttnvDHq/QCJfti0stBnSLXHy1tq4bkGUVBU4gUGQtMZzEzypmJM0QlGeATpwVn02YC3TVfeIlutoAiCHD/dh2oG0mXogj+xvk7aSwe7l5RzwfTABpLP782SMqdmDGjpd6PqgNyG/90FntSCnWF2D0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608433; c=relaxed/simple;
	bh=wCTRJsTxQuETLXGPGcADMELe2eClU1vUMvI9m059vc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HhpGNnOFz2Ic/IHbj/Esl0Uflukl1XY62M58CMuor6K1G/zskMR57mlYW8jSe1wcXWcTyn1j9ZvgXCdxDEVkak4aOVKM0BwSoQ4Wte8dNiMmJi4x5Ei2pxqx2UsVS+MaQX+C8u/TW18qozwJzh32HsfIA4oEcGWx+WC33zT8edw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmxjidRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmxjidRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F2C1F00AC4;
	Sat,  1 Aug 2026 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608431;
	bh=R3xaWQUo7entT/oYfbJFYMMI+aNCU1I+m8vJ2vcSdWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmxjidRpOSmf00jg3GI/OD5VIjPZ5/mi0SypDwO1AO9G/WEAfxgcIKAbUUx7p4NsC
	 fJjmYzAj4Jxb8hBH9v38z8viAutoa+8yER2EifbXIEqOqgUYFp3eSo/MRSVHFFUPKc
	 6VLFRRUN8peXkF8YSVWXmu+DzHkaumEvlGXrOnyN4PwQlkLOOoo48ltEv+nkncpEBK
	 5ih49wkft4Nmok+SIJocxwq1BnN0/t/eUTVr+vTknjqTn6sR7ad2y/Ss/EQ8SujRIA
	 94VOBiImhXOkDNhxV4tEL+mEXspyEphg7cnMkj3RHcyUIHQuoeWF7XpQGCgZ32GeBN
	 mX8CvuO9byBzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/19] s390/dasd: Add full_track_bias to control
 fulltrack write mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-14-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-14-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:20:30 +0000
Message-Id: <20260801182030.A7F2C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Inconsistent initialization of the `fulltrack` flag between the =
module parameter and sysfs store, breaking the intended default behavior.
- [Low] Lockless concurrent updates to `ft_bias` and `fulltrack` by multipl=
e writers cause persistent state inconsistency.
--

--- Patch [13]: [PATCH v7 13/19] s390/dasd: Add full_track_bias to control =
fulltrack write mode ---
commit 377e4de782323378dcdb6afeafb0086a91d9e269
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add full_track_bias to control fulltrack write mode

This patch adds a sysfs attribute full_track_bias to control full-track
writes on ESE devices. It also adds a module parameter to set the default
bias applied to devices at online time.

> diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_d=
evmap.c
> index 381d616ad433f..035c022255b68 100644
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c

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
Can concurrent writes to this sysfs attribute cause a persistent state
inconsistency? If two threads write different values (like 100 and 0) at the
same time, could the lockless updates to device->ft_bias and device->fulltr=
ack
interleave, leaving ft_bias =3D 0 but fulltrack =3D 1?

> +
> +	dasd_put_device(device);
> +	return count;
> +}

[ ... ]

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index e731d7e183121..0247e9a6d7929 100644
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
Does this initialization miss the intended default behavior described in the
commit message?

With the default ft_bias of 50, the ternary operator evaluates to 0, which
disables the feature by default during device initialization. However, in
full_track_bias_store() in dasd_devmap.c, the code uses:

    device->fulltrack =3D val ? 1 : 0;

meaning if an administrator manually writes the exact same default value of=
 50
to sysfs, the flag flips to 1. Should this initialization match the sysfs s=
tore
logic to enable full-track writes out-of-the-box for any non-zero value?

> +
>  	if (private->conf.gneq) {
>  		value =3D 1;
>  		for (i =3D 0; i < private->conf.gneq->timeout.value; i++)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D13
