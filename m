Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9D30D418
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583626; cv=none; b=YsdSbFy7iCnMassp4y0LPsUdkuxLZiL9G6f1OpNqJnjNx5/511l4ZKGewwHyqqJVXgna926UGDG4+eIGxzgHpAlQhSe+vBv+0f8xkOaQawM5gG78AM/xhAsxFLg1yVRBcVufF7X5azzGdFbTPx+xuDZecpWCCwnsExspe57tNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583626; c=relaxed/simple;
	bh=VTgvwAlZm+O0CVF0NzBRzfdZYHvxK7bLLNdtXQURjYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QKAAZ2DmMS/Tg2oFwOQN5kqMTWtMfjj6ZsQkwpp1fQZEqQfePh8OibeZbum6JRaBqsaGNYZ+5BYTc1oRKbbyq/fdhxQFKpiAA+26bKAVJAlyHp5lMM39SLcnUhwlfv9JVAcNIj+M139gPPbw1o+q0YdRTVDLBvcLK3u29MBBJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTx5XYAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTx5XYAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172021F00AC4;
	Sat,  1 Aug 2026 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785583624;
	bh=nOD6NBycJw5f4lKmDCcinIKbvPfEjdXbs86R7d/tRXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oTx5XYAW0hjo3ntf1a1IUGA2MdoA2/N1T7BtDDyIG5goQZDN4CImM4z5kKQ3o44Pl
	 KtHmre4KVrh2nSLLH0ZHPbc2cFrBdlZv8QPy+2JqnNcNmNsNOSs3q5KBu2TmtrCvvp
	 3idlWrNjNZlRbCPzqdL4zVXag8hEUMFuDspIaZsQHVu7xKs2ssddAET2vDSofK/T44
	 neXtyce2OnB6DtKvzOdvvAv16VJ46Iz+Np/T9x4bc/VBjF0cMtTcYwZVZ+Sqebflx4
	 9l6ldUDXjkfFhnjtJyoYa/971cal6xrZJtjckGcDiqbCuyh63FWxjNluixDqYm+Rbi
	 tfp1Ac3FhU5bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/18] s390/dasd: Add full_track_bias to control
 fulltrack write mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-13-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-13-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:27:03 +0000
Message-Id: <20260801112704.172021F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `full_track_bias` parameter is unconditionally applied to all =
ECKD devices, inflicting performance penalties on standard non-ESE volumes.
- [Medium] Inconsistent handling of `full_track_bias` values 1-99 between d=
evice initialization and the sysfs store function.
- [Medium] Race condition in sysfs store method allows a torn update to per=
manently desync the `ft_bias` and `fulltrack` state.
--

--- Patch [12]: [PATCH v6 12/18] s390/dasd: Add full_track_bias to control =
fulltrack write mode ---
commit cca10efd2af8b0fe1b751764fcdbf7d7f54c4ef1
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add full_track_bias to control fulltrack write mode

Add a per-device full_track_bias sysfs attribute to gate the full-track
write path for ESE devices. A module parameter sets the initial default val=
ue
applied to devices at online time.

> diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_d=
evmap.c
> index 381d616ad433f..035c022255b68 100644
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c
> @@ -1630,6 +1630,44 @@ dasd_expires_store(struct device *dev, struct devi=
ce_attribute *attr,
> =20

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
Is it possible for concurrent sysfs writes to leave these variables out of
sync?

Because the sysfs core does not serialize concurrent writes to the same file
if opened via separate file descriptors, could an interleaved execution from
two threads writing 100 and 0 concurrently result in a torn update where
ft_bias is 0 but fulltrack remains 1?

[Severity: Medium]
Does this sysfs store function contradict the initialization logic for valu=
es
between 1 and 99?

During device initialization, dasd_eckd_check_characteristics() restricts
device->fulltrack to 0 for a value like 50 (the default). However, if the
exact same value (50) is written to this sysfs attribute, this line
unconditionally sets device->fulltrack to 1.

Could this cause a sudden unprompted change in I/O behavior upon rewriting
the current configuration value?

> +
> +	dasd_put_device(device);
> +	return count;
> +}
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 5e7a531707a0c..9003e28a4ebbe 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
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

[Severity: High]
Will this module parameter be applied to all ECKD devices, even standard
non-ESE volumes?

The commit message states the bias should be applied to every ESE volume at
online time. However, this appears to unconditionally copy the module
parameter into every ECKD device's state regardless of whether the volume
is actually ESE, without checking dasd_eckd_is_ese(device).

> @@ -5199,11 +5216,20 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(st=
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
> +			cqr =3D dasd_eckd_build_cp_tpm_writefulltrack(startdev, block, req,
> +								    first_rec, last_rec,
> +								    first_trk, last_trk,
> +								    first_offs, last_offs,
> +								    blk_per_trk, blksize, NULL);

[Severity: High]
If basedev->fulltrack is set for a non-ESE device, will this downgrade
standard track-based I/O to WRITE_FULL_TRACK?

If an administrator sets dasd_eckd_mod.full_track_bias=3D100 to optimize
their Extent Space Efficient (ESE) volumes, it looks like all standard
(non-ESE) volumes will indiscriminately inherit this setting and suffer a
severe maximum throughput degradation penalty.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D12
