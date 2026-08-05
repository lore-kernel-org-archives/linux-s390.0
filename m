Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E663481238
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950096; cv=none; b=qKDDbWU7zvALLo1m5tXR1beBskYimmt20swC/UOOD+3bYdF+ppCiEnoCg+4rehPJcLp9wgy6r0WKSbLcNhuu6ajRGEZI9QBdn0LJBxU5oXRvUp2OOznLndRVcKB0MElo3latuHNHInpTk9bfGIVw6+fzoZw0vtbFDEjqeGFdovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950096; c=relaxed/simple;
	bh=7i6+AxbtjJuaoRFdcvCj+JyggeiLv9I34/t3uku/dzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LY56ajpaE6WkNNghfIoymj7vXlsS2Uq2mCO4Aj661DsHjqZUxaoqMFhoo7Y/yfLSzp4ha8+rDCLQ161bB2pQ3T3hUB0Mb0pFScgGYFTbe2mOlWljyFZx0uOKc8XSTCcIelpRNGnn2F7iJdkwkJbpxBE/64kxcbPT1ElXz8ZEU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVdGN12M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVdGN12M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581B41F000E9;
	Wed,  5 Aug 2026 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785950094;
	bh=CaumgEYFUC7NYZ71RgKE4qszX2I/3CdjJo8FCmvO060=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nVdGN12M/BzAuzV9Rnas95LpGQm+XHN4rp2GmnBLdABn4lQZaT14x1MHzQqC86wm6
	 TOUbuywudNkf/mYc8DNSl9j3cqQ3hMt2BUQIEW124wkwOP3d/7UkxwaGX1k9k7GtfN
	 W/3fc4kQNgMq53pSjf3PdDdeyhWXt5c84K6QJVODZpFaD5kYWcZeJBu/eOxgTLxHIr
	 owwh9OhkXKspO2+5fV/XwQvm7KvcaCuJJGvq/HsAONTNBW/xmsMmI6hzybxcDG1GeP
	 cD0DW829f1M1rOtpJQzOyfJUZeRQUsHM4UgmRlLX5LKNw/FXdfNqTRq+BTGGpYZ8DW
	 IEjRN3z4WEVcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/19] s390/dasd: Stamp a format label into newly
 formatted volumes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260805111612.1285190-16-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-16-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 17:14:52 +0000
Message-Id: <20260805171453.581B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Data race on `ese_format_quick` allows concurrent space release =
to incorrectly taint the format label of a volume.

Pre-existing issues:
- [High] Heap buffer overflow in `dasd_eckd_build_format` when formatting m=
ultiple tracks with intensity 0x01, 0x04, 0x09, or 0x0c.
--

--- Patch [15]: [PATCH 15/19] s390/dasd: Stamp a format label into newly fo=
rmatted volumes ---
commit 6ce217cc3945c138bfb4345ea55cd9cbaf16ceb9
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Stamp a format label into newly formatted volumes

This commit writes a 512-byte on-disk label during CDL volume formatting to
record whether the volume is ESE and if it was a quick or full format.
The quick format state is derived from a preceding full space release.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 62c03c4787c83..25a9055b97a2c 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -2723,6 +2724,28 @@ dasd_eckd_build_check(struct dasd_device *base, st=
ruct format_data_t *fdata,
>  	return cqr;
>  }
> =20
> +/* Fill the format label into a R4 record buffer, zero-padded to blksize=
. */
> +static void dasd_eckd_fill_format_label(struct dasd_device *device, void=
 *data,
> +					unsigned int blksize)
> +{
> +	struct dasd_eckd_private *private =3D device->private;
> +	struct dasd_format_label *label =3D data;
> +
> +	memset(label, 0, blksize);
> +	label->magic =3D DASD_ESE_LABEL_MAGIC;
> +	label->version =3D DASD_ESE_LABEL_VERSION;
> +	if (dasd_eckd_is_ese(device))
> +		label->flags |=3D DASD_ESE_LABEL_F_ESE;
> +	if (private->ese_format_quick)

[Severity: Medium]
Is the ese_format_quick flag safe from concurrent updates?

In dasd_eckd_fill_format_label(), private->ese_format_quick is read lockles=
sly
while generating the CCW requests in userspace context.

If a concurrent BIODASDRAS (space release) ioctl completes and sets this fl=
ag=20
to 1 via dasd_eckd_release_space_full():

dasd_eckd_release_space_full()
    private->ese_format_quick =3D 1;

Could the concurrent format process fetch a stale or intermediate value and
incorrectly encode DASD_ESE_LABEL_F_QUICK into the volume's on-disk label?

> +		label->flags |=3D DASD_ESE_LABEL_F_QUICK;
> +	else
> +		label->flags |=3D DASD_ESE_LABEL_F_FULL;
> +	label->blksize =3D blksize;
> +	label->format_tod =3D get_tod_clock();
> +	strscpy(label->kernel_version, init_utsname()->release,
> +		sizeof(label->kernel_version));
> +}

[ ... ]

> @@ -2774,6 +2798,15 @@ dasd_eckd_build_format(struct dasd_device *base, s=
truct dasd_device *startdev,
> =20
>  	use_prefix =3D base_priv->features.feature[8] & 0x01;
> =20
> +	/*
> +	 * Stamp the format label into R4 of the very first track. Only for CDL
> +	 * (R4 is the first non-special record there), only when this request
> +	 * covers track 0, only for the record-writing format intensities (not
> +	 * track invalidation), and only if the track actually has an R4.
> +	 */
> +	write_label =3D (intensity & 0x08) && !((intensity & ~0x08) & 0x04) &&
> +		      fdata->start_unit =3D=3D 0 && rpt > 3;
> +
>  	switch (intensity) {
>  	case 0x00:	/* Normal format */
>  	case 0x08:	/* Normal format, use cdl. */
> @@ -2820,6 +2853,10 @@ dasd_eckd_build_format(struct dasd_device *base, s=
truct dasd_device *startdev,
>  		return ERR_PTR(-EINVAL);
>  	}

[Severity: High]
This is a pre-existing issue, but does this allocation lack a multiplicatio=
n=20
factor for nr_tracks?

Looking at dasd_eckd_build_format(), for track invalidation=20
(intensity 0x04 or 0x0c), the memory calculation sets cplength statically
to 3 and datasize only provisions for a single eckd_count payload.

Later in the function, the code unconditionally iterates over nr_tracks:

for (j =3D 0; j < nr_tracks; j++) {
    ...
    if ((intensity & ~0x08) & 0x04) {  /* erase track */
        ect =3D (struct eckd_count *) data;
        data +=3D sizeof(struct eckd_count);
        ...
        ccw++;
    }
}

If nr_tracks is greater than 1, it appears this loop will write past the=20
allocated bounds of the memory chunk since the allocation size was not scal=
ed
by nr_tracks.

Can this cause a heap buffer overflow during a privileged BIODASDFMT ioctl?

> =20
> +	/* room for the label data that R4 carries in addition to its count */
> +	if (write_label)
> +		datasize +=3D fdata->blksize;
> +
>  	fcp =3D dasd_fmalloc_request(DASD_ECKD_MAGIC, cplength, datasize, start=
dev);
>  	if (IS_ERR(fcp))
>  		return fcp;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D15
