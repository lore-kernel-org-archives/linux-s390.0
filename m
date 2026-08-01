Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB9356779
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584237; cv=none; b=g0BjJ0q6pqSaX3GiDX8qdMQqi2jqW1ursO/v8umuV6tc7yBpJpPfRxP6o+GaZ2XP6cnFDXBIFQpqisQ1rLP64t7SP2BlHBE2s8zI+od1ncqYJTJRLVFnIBKvqV38r7flKLnRIwEp1X5BypvCXTqJuWs6zMGcWgvroVag8MJIa9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584237; c=relaxed/simple;
	bh=BvldfPhOgQ+XsAjo/6ORMpnUOnZujeiJLVRveBs5paY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dYeGAf56ZII+bQpe487wXp5u6uFzKptbbT7QrP3ZBXn2Hpmvay4edivt2JnO2XntI7KK3su0A7dkDdjSvqhZn5Hned5hhbOW4HzXF6l9qL1IeiQTU9nL9zONH3gLlyjBfaCGg+SWei7w0XuFIrR3qENqBAzUTSQ/6HWmSwDcMTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnZkbmdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnZkbmdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611961F00AC4;
	Sat,  1 Aug 2026 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785584235;
	bh=y1KPZBYzdwJ3mXzlyZPxRzaL1JoGMprxjHQDk/Pn/ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FnZkbmdqxnCMVqZyXl2CxfssdjsI+v2xWHFQmZCb/w4bSdwVMKD8o14Dm/zWOVc8k
	 UiUIN/B7fa2z+QDK5htGUIt9fq138Uy/VKp0naMak25DVMN7dVjnjlk4PsDTAbDCHD
	 I64thL1Jjb0l0LBoyzL9tqKQIFDY5O7PWJLLcz/+5doWbomPm3l6tgl+lIIyPxsuzq
	 sMiy1pStXPMIGPfyHb8sIuLAiwpr01W5qgdrGnD+xUaDePGWc5Pux/oQKwv6IJMqkL
	 MOE0E2oERW4uyKDE1Vw46C3zgVVlDEuUlVQQgBRxN8aAJiH54PbJk/7x5gJ/ztp6r0
	 tkxegnIwDpI/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/18] s390/dasd: Extend prepare_itcw() to support
 WRITE_FULL_TRACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-10-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-10-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:37:15 +0000
Message-Id: <20260801113715.611961F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The newly added DASD_ECKD_CCW_WRITE_FULL_TRACK case correctly init=
ializes fields but they are unconditionally overwritten by trailing common =
code in prepare_itcw().
- [High] Uninitialized `start_trk` and `end_trk` in non-format requests cau=
se false-positive collision detection when track 0 is formatted.
--

--- Patch [9]: [PATCH v6 09/18] s390/dasd: Extend prepare_itcw() to support=
 WRITE_FULL_TRACK ---
commit c073fedc91e7807d5ec588cea865d8b63661d671
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK

This commit extends prepare_itcw() to build the FCX prefix block (PFX +
LRE) for the new DASD_ECKD_CCW_WRITE_FULL_TRACK track-mode I/O command. It
allocates the prefix buffer on the stack to prevent memory allocation
failures under pressure during the writeback path.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 77ceba151560b..01c6cdc8430fe 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -4383,11 +4383,13 @@ static int prepare_itcw(struct itcw *itcw,

[ ... ]

>  	switch (cmd) {
> @@ -4446,7 +4453,38 @@ static int prepare_itcw(struct itcw *itcw,
>  		 * data as well.
>  		 */
>  		if (dedata->ga_extended & 0x08 && dedata->ga_extended & 0x02)
> -			pfxdata.validity.time_stamp =3D 1; /* 'Time Stamp Valid' */
> +			pfxdata->validity.time_stamp =3D 1; /* 'Time Stamp Valid' */
> +		pfx_cmd =3D DASD_ECKD_CCW_PFX;
> +		break;
> +	case DASD_ECKD_CCW_WRITE_FULL_TRACK:
> +		dedata->mask.perm =3D 0x3;
> +		dedata->mask.auth =3D 0x00;
> +		dedata->attributes.operation =3D basepriv->attrib.operation;
> +		dedata->blk_size =3D blksize;
> +		dedata->ga_extended |=3D 0x42;
> +		rc =3D set_timestamp(NULL, dedata, basedev);
> +		lredata->operation.orientation =3D 0x0;
> +		lredata->operation.operation =3D 0x3F;
> +		lredata->extended_operation =3D 0x11;
> +		lredata->auxiliary.check_bytes =3D 0x2;
> +		lredata->extended_parameter_length =3D 0x02;
> +		if (count > 8) {
> +			lredata->extended_parameter[0] =3D 0xFF;
> +			lredata->extended_parameter[1] =3D 0xFF;
> +			lredata->extended_parameter[1] <<=3D (16 - count);
> +		} else {
> +			lredata->extended_parameter[0] =3D 0xFF;
> +			lredata->extended_parameter[0] <<=3D (8 - count);
> +			lredata->extended_parameter[1] =3D 0x00;
> +		}
> +		sector =3D 0xFF;
> +		/*
> +		 * If XRC is supported the System Time Stamp is set. The
> +		 * validity of the time stamp must be reflected in the prefix
> +		 * data as well.
> +		 */
> +		if (dedata->ga_extended & 0x08 && dedata->ga_extended & 0x02)
> +			pfxdata->validity.time_stamp =3D 1; /* 'Time Stamp Valid' */
>  		pfx_cmd =3D DASD_ECKD_CCW_PFX;
>  		break;
>  	case DASD_ECKD_CCW_READ_COUNT_MT:

[Severity: High]
Does the trailing code in prepare_itcw() overwrite these initialized fields
for the new full-track write command?

In the trailing code further down in prepare_itcw():

	if (cmd =3D=3D DASD_ECKD_CCW_READ_COUNT_MT) {
		lredata->auxiliary.length_valid =3D 0;
		lredata->auxiliary.length_scope =3D 0;
		lredata->sector =3D 0xff;
	} else {
		lredata->auxiliary.length_valid =3D 1;
		lredata->auxiliary.length_scope =3D 1;
		lredata->sector =3D sector;
	}

If rec_on_trk is non-zero, it will recalculate sector and overwrite the 0xFF
initialized above, and it will unconditionally set length_valid =3D 1 which=
 is
incorrect for WRITE_FULL_TRACK. Should the exception condition be updated to
also exclude the new full-track write command?

[ ... ]

Additional note regarding track-based collision detection introduced in this
series:

[Severity: High]
Can uninitialized start_trk and end_trk in non-format requests cause
false-positive collision detection when track 0 is formatted?

Standard read/write requests are allocated via dasd_smalloc_request(), which
zeroes the request struct, but start_trk and end_trk are never initialized =
for
normal I/O requests (leaving them at 0).

When a format request completes on track 0 (format->start_trk =3D=3D 0),
dasd_return_cqr_cb() evaluates dasd_req_conflict() against all in-flight
requests:

drivers/s390/block/dasd_int.h:dasd_req_conflict() {
	...
	return !(cqr1->format->end_trk < cqr2->start_trk ||
		 cqr2->end_trk < cqr1->format->start_trk);
}

For uninitialized standard I/O requests, the overlap condition
!(0 < 0 || 0 < 0) evaluates to true, erroneously flagging all in-flight
standard I/O requests with collision =3D true.=20

If those requests later receive an NRF error and require formatting, their
collision flag incorrectly tells test_and_set_format_track() they collided,
causing an immediate I/O retry without actually formatting the track. Does
this result in infinite retry loops and I/O failures on track 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D9
