Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783236F8F9
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584008; cv=none; b=pHutITGP6bU8C9adSQxf8oIhpSm45s8jjoRASQVSTqT5aZXuXXUtQ0Wr/y+3JgLNSjlYOfBABW0oMLqQiiKcXDC8k2TtrgoJxjsCCDHdMTUjFQPyNj23Osz6SMeBYB+QpqHCUh5ExrbPpcjJvnKzVuu/PVsubNAT8R3A9bRVWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584008; c=relaxed/simple;
	bh=zQhFxRAtuX95vSV8Ult6FkNzu2zQ+D9Qgfos0IsgWoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gYuE2YyPYZ31OAXq3AJajw5UPPJC9XxSXILAYzRvLWq9jKHtYMphjVhk92SGleiscrhbifLvAmw0sr8PFMfGR10sLJDrdF4ItKfeEdo/B+r6ecXVDbI+ZaMcH1N8Ki2tyg1Or0eHQ5PMlkQiZFi79Q08a0dzmZQ7wv+ADyt6lsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGiiNAUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGiiNAUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DDD1F00AC4;
	Sat,  1 Aug 2026 11:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785584006;
	bh=kvj8s2Q9Ffp9GHgH4HZxonkUUaKt4v7U+zwfVFJU6DA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RGiiNAUvFmh+XlUKiA6tsvaDILjxJVnbybZ3WtpXiRfeNAe2OQdqar8Irr6WZU7uG
	 n3ALqCgDgIxh3eXPLb+9IyJu/CoBhdy87Hm3mg7A00TCFwiCCJ4F/u5oCn1OPGrNhB
	 EZ0B2UpZs8ff+rqfOgqneQ66bBk5OpOwsQqq5892++D82VV4AXMHdGObpl3Utu8LKB
	 QrB4o0heHEvIeOa1GP7SvMUH6CkpzzzfZdnSMHLfXGGZwCZHuAHme9+AabALiMCp1C
	 7RJD772D/yF0nFYLFcE+R12nrLkv0nNtasrEAofyHRoQyfgADf2yZ3Berqvr6FOsdX
	 gV9UCqi4d7Dlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/18] s390/dasd: Stamp a format label into newly
 formatted volumes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-15-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-15-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:33:25 +0000
Message-Id: <20260801113326.46DDD1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unsynchronized modification of the ese_format_quick state flag.

Pre-existing issues:
- [High] Heap buffer overflow in dasd_eckd_build_format when handling speci=
alized format intensities.
--

--- Patch [14]: [PATCH v6 14/18] s390/dasd: Stamp a format label into newly=
 formatted volumes ---
commit 1a0c863785cfe5455ad8a4386ef60684b5d42b93
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Stamp a format label into newly formatted volumes

When a CDL volume is formatted, write a small on-disk label so the format
can later be recognised by the kernel. The label records a magic, a version,
whether the volume is ESE, and whether it was formatted quick (space releas=
ed,
thin) or full.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 67c301e182c0f..ebffb3364c33c 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -2816,6 +2849,10 @@ dasd_eckd_build_format(struct dasd_device *base, s=
truct dasd_device *startdev,
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> +	/* room for the label data that R4 carries in addition to its count */
> +	if (write_label)
> +		datasize +=3D fdata->blksize;
> +

[Severity: High]
This is a pre-existing issue, but can this code cause a heap buffer overflo=
w?

When handling specialized format intensities (e.g., 0x01 or 0x09), the size
calculation in dasd_eckd_build_format() appears to under-calculate the
required allocation for multi-track requests by missing per-track R0
allocations:

dasd_eckd_build_format() {
    ...
	case 0x01:	/* Write record zero and format track. */
	case 0x09:	/* Write record zero and format track, use cdl. */
		cplength =3D 2 + rpt * nr_tracks;
		if (use_prefix)
			datasize =3D sizeof(struct PFX_eckd_data) +
				sizeof(struct LO_eckd_data) +
				sizeof(struct eckd_count) +
				rpt * nr_tracks * sizeof(struct eckd_count);
    ...
}

However, the subsequent loop unconditionally writes nr_tracks sets of CCWs =
and
eckd_count structures:

dasd_eckd_build_format() {
    ...
	for (j =3D 0; j < nr_tracks; j++) {
        ...
		if (intensity & 0x01) {	/* write record zero */
			ect =3D (struct eckd_count *) data;
			data +=3D sizeof(struct eckd_count);
        ...
			ccw++;
    ...
}

Could this write past the allocated boundaries if a user with CAP_SYS_ADMIN
invokes the BIODASDFMT ioctl with a track range spanning multiple tracks?

>  	fcp =3D dasd_fmalloc_request(DASD_ECKD_MAGIC, cplength, datasize, start=
dev);
>  	if (IS_ERR(fcp))
>  		return fcp;

[ ... ]

> @@ -3177,8 +3231,18 @@ static int dasd_eckd_format_device(struct dasd_dev=
ice *base,
>  	if (fdata->start_unit =3D=3D 0)
>  		dasd_ft_bias_apply(base);
> =20
> -	return dasd_eckd_format_process_data(base, fdata, enable_pav, 0, NULL,
> -					     0, NULL);
> +	rc =3D dasd_eckd_format_process_data(base, fdata, enable_pav, 0, NULL,
> +					   0, NULL);
> +
> +	/*
> +	 * The quick-format indicator was consumed by the label stamped into
> +	 * track 0; clear it so a later format that is not preceded by a full
> +	 * space release is recorded as a full format.
> +	 */
> +	if (fdata->start_unit =3D=3D 0)
> +		private->ese_format_quick =3D 0;

[Severity: Medium]
Is it possible for this flag modification to race with concurrent updates?

If a concurrent BIODASDRAS ioctl is executing, dasd_eckd_release_space_full=
()
might update this state flag without locks:

dasd_eckd_release_space_full() {
    ...
		private =3D device->private;
		private->ese_format_quick =3D 1;
    ...
}

Because dasd_eckd_format_device() clears the flag unconditionally after an
unprotected blocking operation, could it overwrite the concurrent update?

This might cause the next disk format label to be incorrectly stamped as a
'full' format rather than a 'quick' format.

> +
> +	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D14
