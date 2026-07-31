Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9C440A3E
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514885; cv=none; b=csf+652JtAUaGxxV9hWODvQh8YmybeAhuIbARpazknlSPFnjweLoGlD4952MODi2E3qylQquqxtFhdjZPu4k+m9eiSoIEw/VpPSJ8noat0G4KKL+wgq7GLguQcxRonZ9S2/akJqGs0TZYrdqug+sf+c5LBFqF7octujaGeguXg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514885; c=relaxed/simple;
	bh=c9SaQW+4cw/8eaupOLbIqdsCYJwzbbO/WPSkOjIL8r0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=taoSN7ct2W3iz0HxizQ5CSQqhnsXgVKMIh3Zu8W8NU1A0n/N/gGvtxVZAUYPtZPMnTvbrf5ze2syd1nzlqK9szFfgAOFUVRetHw11tscFG5jl+Mnn0M0GNiw62UyC+wIrTAPfo30wsJaE+coo0Oa1PY7JM5y9fb6oRIqaKhn2jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c51kpxV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c51kpxV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC521F00AC4;
	Fri, 31 Jul 2026 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785514883;
	bh=tlQNq9zkYrA4kh2HnCYClXVG74E82yOwulBnabWGbQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c51kpxV1e8RQHLlJK/V3veQcqMdqFXLXDzvNrW0sbOQU2Wd69uriMT7cdrorqg3zW
	 GykliQedXWjomNSspV24JO8zCRZIe6pciPzzxrsHylEaeiuzu/97rl1yqLKnVKmS6O
	 z6r4nF+NEc8EburAybX9CKe7byxdKU3GPmGzBV4wXxZTVNch9WWkGSWvXxMETxih1h
	 bxFaHlm7lZp4TYnz/UNxOAbyjrAH6KZbXXnpCuQj5qewHmY2xY8XPUZwuBjWE3JidY
	 snXyO1wNEJ4N7XdGhwLuzqEJkPStLJtdrBW54BadHuA+1aqwYBUVMw6ZY7IcL93MMa
	 EesEMIRzwt9CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/17] s390/dasd: Extend prepare_itcw() to support
 WRITE_FULL_TRACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-9-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-9-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:21:23 +0000
Message-Id: <20260731162123.9CC521F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The explicit assignment `lredata->length =3D 0` for `WRITE_FULL_=
TRACK` is unconditionally overwritten.

Pre-existing issues:
- [High] Lockless access to `conf.ned` and `uid.type` in I/O submission pat=
hs races with concurrent path events, leading to a NULL pointer dereference.
--

--- Patch [8]: [PATCH v5 08/17] s390/dasd: Extend prepare_itcw() to support=
 WRITE_FULL_TRACK ---
commit 2948648b7fc2c93cb4193e7c55bd961de4d7e8c2
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK
   =20
prepare_itcw() builds the FCX prefix block (PFX + LRE) for track-mode
I/O. Extend it to handle DASD_ECKD_CCW_WRITE_FULL_TRACK.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 2f6d97c06237b..c1a26485f506d 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -4397,26 +4399,31 @@ static int prepare_itcw(struct itcw *itcw,
[ ... ]
> -	pfxdata.format =3D 1; /* PFX with LRE */
> -	pfxdata.base_address =3D basepriv->conf.ned->unit_addr;
> -	pfxdata.base_lss =3D basepriv->conf.ned->ID;
> -	pfxdata.validity.define_extent =3D 1;
> +	pfxdata->format =3D 1; /* PFX with LRE */
> +	pfxdata->base_address =3D basepriv->conf.ned->unit_addr;
> +	pfxdata->base_lss =3D basepriv->conf.ned->ID;

[Severity: High]
This is a pre-existing issue, but can this lockless access to conf.ned lead
to a NULL pointer dereference?

If a concurrent path event triggers dasd_eckd_pe_handler(), it calls
rebuild_device_uid(), which then calls dasd_eckd_identify_conf_parts().
That function transiently sets conf.ned =3D NULL without holding any locks.

If prepare_itcw() accesses basepriv->conf.ned->unit_addr at that moment, it
will dereference a NULL pointer.

> +	pfxdata->validity.define_extent =3D 1;
> =20
>  	/* private uid is kept up to date, conf_data may be outdated */
>  	if (startpriv->uid.type =3D=3D UA_BASE_PAV_ALIAS)

[Severity: High]
This is a pre-existing issue, but does accessing uid.type here race with a
concurrent memset?

The create_uid() function memsets the uid to 0 under the ccwdev_lock, but t=
his
I/O submission path reads startpriv->uid.type locklessly, exposing it to
transient zeroes.

> -		pfxdata.validity.verify_base =3D 1;
> +		pfxdata->validity.verify_base =3D 1;
[ ... ]
> @@ -4446,7 +4453,39 @@ static int prepare_itcw(struct itcw *itcw,
[ ... ]
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
> +		lredata->length =3D 0;

[Severity: Medium]
Will this lredata->length value be unconditionally overwritten?

Later in prepare_itcw(), there is this assignment:

    lredata->length =3D tlf;

If WRITE_FULL_TRACK is used with a non-zero transfer length factor, the
tlf value will overwrite the explicitly requested 0.

> +		lredata->extended_parameter_length =3D 0x02;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D8
