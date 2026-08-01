Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D9330CD89
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609545; cv=none; b=Wgn74Z3my6Cjh9daP/N0oUexMXrc+xg6zOTQ1iKrWzutN4TQMSO7ESbbeq6hzoyOXSZcMX45E8s7/hlWBpN/C/a2XAqoPh3UCR1xcAQdYLrjWUAkppJknT4LWZcYZrKkZsObl1RgSTTKpgOCuW9V1vmmRmVVBHHBcLV9CLaFIjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609545; c=relaxed/simple;
	bh=CbaVR4ISR/Bid6c/ersHL1mUFXL6zXU2JDCsd5Tkl/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mz1VGoc5L4Z/3pVADOaXvA/Oj4nB5syE5r1d9Xu1g+wcKbtuyH/0cOXFc14iNhn9HFlSXn9bUpo2QBESsrJ51EWOI5x/fps+r4+Zgmnfr1MOkuATm60kEPLVQQPV+eank1o4sCSpUVdcAd6JzpY+9mXPAd3QoM4KAbAUfYx4l3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klQ1D/qg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klQ1D/qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CEB1F00AC4;
	Sat,  1 Aug 2026 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785609543;
	bh=6mysQOLZTiyVPbOXZRoXnYf6++QyxzlmeNmGkCa9kEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=klQ1D/qgYUc0MKXGEhhjG5DEvn5+zgmDr9dEyh55W/rCSy9v4A9hGrV8xJ5+wcGjN
	 BJOjEjtJLPyhlnfszwOrv5T4Po/K7HL/cmqKBMUTUPGMHRNxkYxyDKpDEl+ajbNltn
	 nqW47kOPMUbfwK6Fw6RdirNKeOpdEL14xixPEsI+PBycEVKdwOEhF1Gmy0F2OuszeB
	 jLGEYDq0qryrF1uL09vyKnXPINXcs5abFk3i9WEPboG3Tupo1h3tn9SrTsc16wYho2
	 55MsLVVZrUbf2qhnL+nXmU6jU6gR56D78JrYinPiUEPr5n076wzmunCvpScMvVfCNv
	 lO8K1SE2vVUow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/19] s390/dasd: Detect ESE volumes from the on-disk
 format label
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-17-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-17-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:39:02 +0000
Message-Id: <20260801183903.50CEB1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The in-memory ESE format label cache (`ese_label_valid`) is not =
invalidated when the on-disk label is overwritten or erased without a new l=
abel being explicitly written.
- [Medium] Lockless read and non-atomic update of the `ese_label` cache cau=
ses data races and potential torn reads.

Pre-existing issues:
- [Critical] Heap buffer overflow in `dasd_eckd_build_format()` when format=
ting multiple tracks with intensity 0x01.
- [High] Pre-existing NULL pointer dereference in `dasd_release_space()` fo=
r devices without an `is_ese` discipline function.
--

--- Patch [16]: [PATCH v7 16/19] s390/dasd: Detect ESE volumes from the on-=
disk format label ---
commit ac9e4583836d81406ee7f0dc251d245f5892a7de
Author: Stefan Haberland <sth@linux.ibm.com>
Subject: s390/dasd: Detect ESE volumes from the on-disk format label

Read the format label from track 0 record 4 at device bring-up and cache
it. When a valid label is present, is_ese() is derived from it instead of
the hardware volume field. The cache is refreshed after a format so is_ese()
stays coherent without an offline/online cycle.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 7a27dc08fb961..68736f9efcaf2 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -1676,7 +1676,8 @@ static int dasd_eckd_read_vol_info(struct dasd_devi=
ce *device)
> +static int dasd_eckd_is_ese(struct dasd_device *device)
> +{
> +	struct dasd_eckd_private *private =3D device->private;
> +
> +	/* sysfs may read this during set_online before private is allocated */
> +	if (!private)
> +		return 0;
> +
> +	if (private->ese_label_valid)
> +		return !!(private->ese_label.flags & DASD_ESE_LABEL_F_ESE);

[Severity: Medium]
Does this code allow a data race when reading the label flags?

Looking at dasd_eckd_is_ese() and dasd_eckd_on_demand_format(), they read
private->ese_label_valid and private->ese_label.flags without locks or
memory barriers.

If a concurrent update happens in dasd_eckd_fill_format_label() during a
format operation, could this lead to a torn read and transiently incorrect
sysfs output?

> +
> +	return dasd_eckd_ese_capable(device);
> +}

[ ... ]

> @@ -2733,7 +2847,12 @@ static void dasd_eckd_fill_format_label(struct das=
d_device *device, void *data,
>  	label->format_tod =3D get_tod_clock();
>  	strscpy(label->kernel_version, init_utsname()->release,
>  		sizeof(label->kernel_version));
> +
> +	/*
> +	 * Populate the cache directly from the bytes just computed instead of
> +	 * synchronously reading them back from disk after the write lands.
> +	 */
> +	private->ese_label =3D *label;
> +	private->ese_label_valid =3D true;

[Severity: Medium]
Does this code update the 512-byte label cache safely?

Since this struct copy is not atomic, could concurrent readers in
dasd_eckd_is_ese() observe an inconsistent state?

>  }

[ ... ]

> @@ -3227,23 +3353,35 @@ static int dasd_eckd_format_device(struct dasd_de=
vice *base,
> -	if (fdata->start_unit =3D=3D 0)
> -		private->ese_format_quick =3D 0;
> +	private->ese_format_quick =3D 0;
> +
> +	/*
> +	 * A full format returns the device to a fully sparse state and has just
> +	 * committed a fresh label; restart the heuristic from ft1 on the now
> +	 * current is_ese state, without an offline cycle.
> +	 */
> +	dasd_ft_bias_apply(base);
> +
>  	return rc;
>  }

[Severity: Medium]
Does this code properly invalidate the label cache when the label is erased?

In dasd_eckd_format_device(), the success path clears ese_format_quick but
does not clear ese_label_valid when track 0 is formatted with a non-CDL
layout (intensity 0) where no label is explicitly written.

Similarly, space release successfully unallocates all tracks (erasing
track 0) in dasd_eckd_release_space_full() but fails to invalidate the
label cache.

Could this cause the driver to retain a stale label cache and incorrectly
apply ESE-specific performance heuristics to non-ESE devices?


Additional observations about related pre-existing code:

[Severity: High]
This is a pre-existing issue, but does dasd_release_space() in
drivers/s390/block/dasd_ioctl.c have a NULL pointer dereference?

If a device uses a discipline that does not implement the is_ese callback,
such as FBA:

    if (!device->discipline->is_ese && !device->discipline->is_ese(device))

Could this logic flaw trigger a panic when a user issues the release space
ioctl, since it uses a logical AND instead of OR?


[Severity: Critical]
This is a pre-existing issue, but does dasd_eckd_build_format() in
drivers/s390/block/dasd_eckd.c have a heap buffer overflow?

When formatting multiple tracks with intensity 0x01, the memory is allocated
for the CCW chain using:

    cplength =3D 2 + rpt * nr_tracks;

However, the generation loop consumes an extra CCW per track for record zer=
o,
meaning it consumes 1 + rpt CCWs per track.

If a user requests a format spanning multiple tracks, could this deficit
cause an out-of-bounds write into the dasd_alloc_chunk heap memory pool?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D16
