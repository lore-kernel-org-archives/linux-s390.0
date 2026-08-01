Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02254489863
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584318; cv=none; b=niPHXotptds0BMagN2qNVmVUF8lfR8aTbW2E9QL9f8vqCYX960rPJso14gskHiAgnBkMw0/nzPF1h7eoNsFbbfFdpWMXF7fv9xB8dxdlh6M7aG9eevUQkYzdjHRg1ejOxCs/73ABgQZWehMvJETRiw2UiorZF30WegAkWyBEaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584318; c=relaxed/simple;
	bh=46/ab33HjaGPaR4M3GEfmC+1lrc8wxaoKNnIVOAJsIs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d9MXS4oHCPPVButJbqBPbCMO7fStlKBRncp0qGnIcHWe1lecw4w46EMXnzMALi6vTtxjEczChmllTDII7s2Kl9VPyNIvr9GVwWSmhtHsQL+ReGAZ40c0gzI4O1Sop3Mvjy28Syzyxp0Bni1UfQgCj2tjOHVGZTda9Eu989Fdl00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUyLXd5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUyLXd5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEA71F00AC4;
	Sat,  1 Aug 2026 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785584316;
	bh=GUCmySwZ68ZjC3ez0FA4nGaOI9jE98UVVJ4oJ5MaxBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XUyLXd5S2K8HziTXWeWgFoLChGvLnO/Y6jZVZ3L2VKMCNY+tlcSJvbYJAH5RbY6sh
	 47MJ6wZ+JxNUj6QWVZyLn3JVsHoE7DZIl7wO7QYywlFMUgRlCjSDeoiEhO0VAbG0lO
	 PXlCZIiLkuePlUcdyaSGovgciqvi5RiINn5nzD91l1q0y63ddUNs5/2XkBMxtycz0x
	 P5M6kXc9zwQxKx8K94LMzSy1DKcIxqwyc+LhA5ZODQ/YJr4jqNAyv2pII5Um99uY8b
	 tjC0zpIldguny2EdUZtu3E8Sr7ZwXKxDI84FLlt+fwKkRoKLFCXGFbNpgwcWWMLafp
	 VvAd7YQ5/iKfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/18] s390/dasd: Detect ESE volumes from the on-disk
 format label
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260801111008.3391031-16-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-16-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:38:35 +0000
Message-Id: <20260801113836.5BEA71F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The in-memory ESE label cache (`private->ese_label_valid`) is no=
t invalidated when track 0 is formatted without an ESE label, leaving the d=
river with a stale ESE state that no longer matches the physical disk.

Pre-existing issues:
- [High] Fatal NULL pointer dereference in `dasd_release_space()` for devic=
es whose discipline lacks the `is_ese` method (e.g., FBA or DIAG devices).
--

--- Patch [15]: [PATCH v6 15/18] s390/dasd: Detect ESE volumes from the on-=
disk format label ---
commit d17ebb7bd94d36c62afdabb020d82a8a18a64bba
Author: Stefan Haberland <sth@linux.ibm.com>
Subject: s390/dasd: Detect ESE volumes from the on-disk format label

This commit updates the DASD driver to detect Extent Space Efficient (ESE)
volumes by reading the format label from track 0 during device bring-up. It
caches this label and derives the ESE status from it, allowing volumes copi=
ed
from ESE storage to maintain their thin-provisioned handling on different
hardware.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index ebffb3364c33c..35a970e006fd0 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> @@ -3224,23 +3353,35 @@ static int dasd_eckd_format_device(struct dasd_de=
vice *base,
>  	struct dasd_eckd_private *private =3D base->private;
>  	int rc;
> =20
>  	rc =3D dasd_eckd_format_process_data(base, fdata, enable_pav, 0, NULL,
>  					   0, NULL);
> +	if (fdata->start_unit !=3D 0)
> +		return rc;
> +
> +	if (rc) {
> +		/*
> +		 * The format failed, so the label cached speculatively during
> +		 * CCW build may not match the disk; drop it so is_ese() falls
> +		 * back to the hardware field until the next successful format
> +		 * or bring-up.
> +		 */
> +		private->ese_label_valid =3D false;
> +		return rc;
> +	}

[Severity: Medium]
When track 0 is formatted, what happens if no ESE label is written?

If a user issues the BIODASDFMT ioctl with start_unit =3D=3D 0 and a non-CDL
layout (e.g., intensity & 0x08 =3D=3D 0), dasd_eckd_build_format() might not
write a new label. The physical label on track 0 is then zeroed or destroyed
by the format.

However, dasd_eckd_format_device() only clears private->ese_label_valid on
failure. Could this regression leave the driver using a stale ESE state that
no longer matches the physical disk after a successful format?

[ ... ]
> @@ -4241,6 +4382,14 @@ static int dasd_eckd_release_space_trks(struct das=
d_device *device,
>  static int dasd_eckd_release_space(struct dasd_device *device,
>  				   struct format_data_t *rdata)
>  {
> +	/*
> +	 * Space release (and thus a quick format) requires real ESE hardware.
> +	 * is_ese() may be true from a copied label on non-ESE hardware, so gate
> +	 * on the hardware capability, not on is_ese().
> +	 */
> +	if (!dasd_eckd_ese_capable(device))
> +		return -EOPNOTSUPP;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does the ioctl path for space
release have a NULL pointer dereference for devices without an is_ese metho=
d?

In drivers/s390/block/dasd_ioctl.c, dasd_release_space() contains this chec=
k:

    if (!device->discipline->is_ese && !device->discipline->is_ese(device))
        return -ENOTSUPP;

Since it uses a logical AND (&&) instead of OR (||), if the discipline (e.g=
.,
FBA or DIAG) lacks the is_ese method, the first operand evaluates to true.

Will this force the evaluation of the second operand, immediately
dereferencing the NULL function pointer when a user issues the BIODASDRAS
ioctl?

>  	if (rdata->intensity & DASD_FMT_INT_ESE_FULL)
>  		return dasd_eckd_release_space_full(device);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D15
