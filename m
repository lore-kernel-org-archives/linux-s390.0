Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE94DBD6B
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815801; cv=none; b=lqi62gMtsCw7vjfVQOCkqHa7tTUp6vwxg3VTkN4gP7jd2k7OyN9pRi7+JobxkAgEhdmElSZDp1oMj63a+7d2Qias5aV9lXcX4A/INw6VH/9rgH/Mjab4k/XKrv3q6PBcpfV0rdfCl9Ohr1Dvl2WzO3kN5CuG948RFIK05J1frsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815801; c=relaxed/simple;
	bh=w3f8ZzMEb9fLpkhlHCDXeyOz6QZdUd+nBjIiY+vN+2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LzX2kfRVfhfY1jisENazRWbpVO0LP0T1ROxVLfskMuvPz6cm5lM9Ne55RKT3qb+r68ca55nScLoLyvcG8HRr9i+M2aeWrBiTdCVOS4ad1tPgd7AcKEl4sB6P1mhyo8U2MwzvX1+6N0Sr7svnDtcknTUWCmt/efOrTeFCjNgnWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xldpo19o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xldpo19o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419031F000E9;
	Thu, 23 Jul 2026 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815794;
	bh=N+vMNcTmLv/2teTfSE4LEvZ1COeboWPTXdwwMEx7nyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xldpo19oDcjpvHQ58Pej3CEv5E0qnGskuv8Xz5uKrzFXqdWHJNs6dpviX8fl2QxtY
	 fNCxPX1otY3pMfYuhqpwGg1CKC5gPIc0DsA2I8nVbS792B/Dai/yCNfeRCSrH9uhkR
	 yy035ky3wMzX08IoqiE5Fl/rYli/G89Rbape/ByXYeWxXJpyLYP8D5BRhnhMVjnC8k
	 n2wC+getQjp4p/6WES2c2UyWZC7XDP7+WWJSHzg678foEUS04AWPCXEhxr0yQBOqMX
	 QemvcCFLLEmTPtqGQsgpYdSv4UcEWubpue43Wgfte35IotsK0vFL+3Ek8541R+FO/r
	 QoNwkP1NLi/Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/13] s390/dasd: Stamp a format label into newly
 formatted volumes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260723134743.672413-10-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-10-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:09:53 +0000
Message-Id: <20260723140954.419031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] C11 data race causes dropped or incorrectly applied 'quick' labe=
l on disk format.

Pre-existing issues:
- [High] Kernel heap buffer overflow in `dasd_eckd_build_format` when forma=
tting with non-default intensities (0x01, 0x04, 0x09, 0x0C) and `nr_tracks =
> 1`.
--

--- Patch [9]: [PATCH v3 09/13] s390/dasd: Stamp a format label into newly =
formatted volumes ---
commit 1005f080c8236dc0e2aeb3812fe0d07cb9db2604
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Stamp a format label into newly formatted volumes

When a CDL volume is formatted, this patch writes a small on-disk label
in track 0, head 0, record 4 so the format can later be recognised by the
kernel. The label records a magic, a version, whether the volume is ESE,
and whether it was formatted quick or full.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 8b5f592b04d95..b514a94eb41f3 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -2689,6 +2689,28 @@ dasd_eckd_build_check(struct dasd_device *base, st=
ruct format_data_t *fdata,
[ ... ]
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
> +		label->flags |=3D DASD_ESE_LABEL_F_QUICK;

[Severity: Medium]
Can this read of private->ese_format_quick race with concurrent operations?

The flag is set and cleared without locking in dasd_eckd_release_space_full=
()
and dasd_eckd_format_device(). If administrative tools issue concurrent for=
mat
or release IOCTLs on the same block device, could this result in reading a
stale or overwritten value, causing the volume to be incorrectly labeled as
'full' instead of 'quick'?

> +	else
> +		label->flags |=3D DASD_ESE_LABEL_F_FULL;
> +	label->blksize =3D blksize;
> +	label->format_tod =3D get_tod_clock();
> +	strscpy(label->driver_ver, DASD_ESE_LABEL_DRIVER,
> +		sizeof(label->driver_ver));
> +}
[ ... ]
> @@ -2786,6 +2818,10 @@ dasd_eckd_build_format(struct dasd_device *base, s=
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

[Severity: High]
This is a pre-existing issue, but does the size calculation for cplength and
datasize in dasd_eckd_build_format() cause a heap buffer overflow for
non-default intensities?

When fdata->intensity specifies track invalidation (0x04 or 0x0c) or writing
record zero (0x01 or 0x09), the allocations do not account for the nr_tracks
multiplier correctly:

For track invalidation, cplength allocates space for exactly 1 track:

	case 0x04:	/* Invalidate track. */
	case 0x0c:	/* Invalidate track, use cdl. */
		cplength =3D 3;

For writing record zero, cplength is similarly under-scaled:

	case 0x01:	/* Write record zero and format track. */
	case 0x09:	/* Write record zero and format track, use cdl. */
		cplength =3D 2 + rpt * nr_tracks;

Since dasd_eckd_format_process_data() calculates format_step > 1 by default,
nr_tracks is typically > 1. When the loop iterations later write beyond the=
se
improperly sized limits:

			ccw->cmd_code =3D DASD_ECKD_CCW_WRITE_RECORD_ZERO;
			ccw->flags =3D CCW_FLAG_SLI;
			ccw->count =3D 8;
			ccw->cda =3D virt_to_dma32(ect);
			ccw++;

Could the ccw and data pointers overrun their designated regions in the
allocated chunk, corrupting adjacent heap structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D9
