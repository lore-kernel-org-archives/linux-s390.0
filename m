Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879EE474266
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515710; cv=none; b=gZPPl9PTEcmGiMC/qHd2Cb3QSzUsHHe4U+A9xLeoCNXptnjE00uAWIrfEOOX4qQTGbZuIgY+RERtNq9nUvnv+8CMx4yXIqDKToTUnictz2iLMJehxrby73s5ZUyDeVFWLT5GuD9WlJvikOYQrvQtSik3SjUwume/GcVt3okF9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515710; c=relaxed/simple;
	bh=O7sM64BCRSMyeQc9jCdoz2SmnnzjWfkye2W8odt9eOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MZeTeFTj/rOyaHhdfhVRmDzA1xbmEh7EBCr55ppGpV2rtUgkfmaT7emG7lGE3/igTx3cD995hCJ0l2LYtQliDCpWS2TNmtjLe2dMJmnS/5ON9znKFnTV7CMCxSse+t6yxzlyK7/Q0dvU+bIgmvf+Yx5dh7Ymw0ThncxSBpo/n+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfY2k0kX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfY2k0kX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15FA1F00AC4;
	Fri, 31 Jul 2026 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515708;
	bh=R4ZQbpk9obxwmNAU/l4iNKmNnSujYuCSdUUBVcNnyRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MfY2k0kX3jeXdnJVYzuxtTGEb5nQITeSTj0J0IagswgPFEeUJg4xsGmaZ0EkRsXUb
	 DAclwzu7XHfv9wWmDZk71MtmAo9qTln5Did03WNFflpulh0+iUqre5u+9iYlvVzaWh
	 I29/avQNFj1/BJttOjt6TP9fC5Qu1wNB4Hkc9pzli91nSP6/zqRVHnFbxLSHp91zoT
	 W8CL/MPxsHaBho55IHQNj6A+fukOPOfibhnz6VcnjFDF6QLvAMrZAG6YwcLYEsB6gU
	 FKHacSmG1FRionTIH+JWJaJFOxHkO3ibVgBWtfa+9Q2Mp3hQ+Q/F87mwt7nZxsUC98
	 R9wIF13H1XbJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/17] s390/dasd: Stamp a format label into newly
 formatted volumes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-14-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-14-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:35:07 +0000
Message-Id: <20260731163507.E15FA1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Data race on the `ese_format_quick` flag across concurrent forma=
t and space release ioctls.

Pre-existing issues:
- [High] Preexisting heap buffer overflow in dasd_eckd_build_format for non=
-standard intensities when formatting multiple tracks.
--

--- Patch [13]: [PATCH v5 13/17] s390/dasd: Stamp a format label into newly=
 formatted volumes ---
commit 48510a9c8812b7b8251c801cd33769f3a6c5745d
Author: Stefan Haberland <sth@linux.ibm.com>
s390/dasd: Stamp a format label into newly formatted volumes

When a CDL volume is formatted, write a small on-disk label so the format
can later be recognised by the kernel. The next patch will use this for
ESE detection.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 1df861f80c268..1e349dbec44de 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -2770,6 +2794,15 @@ dasd_eckd_build_format(struct dasd_device *base, s=
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

[Severity: High]
This is a pre-existing issue, but does the calculation for non-standard for=
mat
intensities in dasd_eckd_build_format() under-allocate memory?

Looking at intensity 0x01, cplength is allocated as:

	case 0x01:	/* Write record zero and format track. */
	case 0x09:	/* Write record zero and format track, use cdl. */
		cplength =3D 2 + rpt * nr_tracks;

But the subsequent loop unconditionally adds (1 + rpt) CCWs per track for
intensity 0x01, which exceeds the allocated cplength when nr_tracks > 1.

Can this overflow the heap allocation and corrupt memory if an administrator
issues a BIODASDFMT ioctl with a non-standard intensity across multiple tra=
cks?

> @@ -2816,6 +2849,10 @@ dasd_eckd_build_format(struct dasd_device *base, s=
truct dasd_device *startdev,
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> +	/* room for the label data that R4 carries in addition to its count */
> +	if (write_label)
> +		datasize +=3D fdata->blksize;
> +
>  	fcp =3D dasd_fmalloc_request(DASD_ECKD_MAGIC, cplength, datasize, start=
dev);

[ ... ]

> @@ -4068,6 +4132,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struc=
t dasd_block *block,
> =20
>  static int dasd_eckd_release_space_full(struct dasd_device *device)
>  {
> +	struct dasd_eckd_private *private;
>  	struct dasd_ccw_req *cqr;
>  	int rc;
> =20
> @@ -4079,10 +4144,16 @@ static int dasd_eckd_release_space_full(struct da=
sd_device *device)
> =20
>  	if (!rc) {
>  		/*
> -		 * Releasing all space (RAS) wipes every track and the device is fully
> -		 * sparse again, so restart the heuristic from ft1.
> +		 * Releasing all space (RAS) wipes every track and the device is
> +		 * fully sparse again, so restart the heuristic from ft1.
>  		 */
>  		dasd_ft_bias_apply(device);
> +		/*
> +		 * A full release is what makes a subsequent format a quick
> +		 * (thin) one; remember it so the format label records that.
> +		 */
> +		private =3D device->private;
> +		private->ese_format_quick =3D 1;

[Severity: Medium]
Are there concurrent accesses to the ese_format_quick flag during ioctls?

If a user issues concurrent BIODASDRAS and BIODASDFMT ioctls on the same bl=
ock
device, could they race on reading and writing this lockless variable?

dasd_eckd_release_space_full() sets it to 1 here without locks, while
dasd_eckd_format_device() clears it, and dasd_eckd_fill_format_label() reads
it. Could this lead to a non-deterministic state where a formatted volume is
incorrectly tagged as quick or full in its on-disk label?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D13
