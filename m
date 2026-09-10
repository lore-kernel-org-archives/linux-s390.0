Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810223E63AA
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033738; cv=none; b=L9uu7vo6x+Wu7cBYZLhZKrKShIgL0WDMD5ubmJtLSA0lFZsTPmI7VAwS49cF9wwvoqkpN+FSVU4cGZ18Hdfwr4r2Ppyjq1pm/7jS5xlNAS5w7MQ+Rd3VCgYSQEwMlhD1BwPVIsCzNXBAsa5ji6nclWw0ZMeXjMYwVgVtvjlSLDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033738; c=relaxed/simple;
	bh=5DoZRnZHLdETs5DJr2re0u35NtP+nMbbIJU2cHKwcZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EgI+owpH1qFDMl8t0Xd4dUUbwf4GR/vsm9SgT/tlBR/NlRydVmZN3fvZoWFn+H+F+5tEnaILIJ3r2cfUT9avW9VHDpsC0jALv2wtJgj1kqihRBgrARMJitfoCIf+qzMgRX45n2JHFBHxBbgOfKPwt8vua0HiFtjM7DVEydX/o+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdDz+ngp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdDz+ngp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E171F00898;
	Thu, 10 Sep 2026 09:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033736;
	bh=FhOMNdmf2IeqBdTohIYq12k9f8cl2c5GmafrkBpAt1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DdDz+ngpzVopWk1U+nuy8wGEkDimkgysRPO3twhwxf8WSYBNPyMZi5wkMk71s96W5
	 nNdovLuGfZDjAeGk64aAkk6utB1LM1t+Y4XASFfZEbZCPiF4A4mOY66JwKgGtl9IJ1
	 EJlOyD7Qkv0sMJunQIm2+qsvbkDVA6ky7dCulylNDDuI84p5TOBxeKiwB7ydaC8Uxt
	 nYjkgCGNGn62aR2LQ1vp0/XprCRH6vonhbCbOmmXbBGPSiMM6xv6OUl0wktoiCO96Z
	 G44JkC9bLl8l/OzZ+sanqlj7oDfZCa143yuLtagncH51KUN0pHWx6yy7ymz54NPm5i
	 BvewjQLoq0vuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] s390/cio: Guard PMCW field accesses with dnv check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineeth Vijayan" <vneethv@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260910093205.3357827-4-vneethv@linux.ibm.com>
References: <20260910093205.3357827-1-vneethv@linux.ibm.com>
 <20260910093205.3357827-4-vneethv@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:48:55 +0000
Message-Id: <20260910094855.B8E171F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access and TOCTOU data race when validating sch->schib.pm=
cw.dnv and reading PMCW fields.
--

commit 2558ea997b16f6b5c46e330784e1d48f82b99802
Author: Vineeth Vijayan <vneethv@linux.ibm.com>

s390/cio: Guard PMCW field accesses with dnv check

This commit adds explicit Device Number Valid (DNV) checks before accessing
PMCW fields from the cached SCHIB. It aims to prevent the use of invalid
data when no I/O device is associated with the subchannel.

> diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
> index c890f21a82ce3..eaf0527bff6cc 100644
> --- a/drivers/s390/cio/chp.c
> +++ b/drivers/s390/cio/chp.c
> @@ -78,6 +78,9 @@ u8 chp_get_sch_opm(struct subchannel *sch)
>  	int opm;
>  	int i;
> =20
> +	if (!sch->schib.pmcw.dnv)
> +		return 0;
> +

[Severity: High]
This is a pre-existing issue, but does checking sch->schib.pmcw.dnv here
without holding sch->lock introduce a Time-of-Check to Time-of-Use (TOCTOU)
race?

Concurrent hardware events could trigger cio_update_schib(), which overwrit=
es
sch->schib using a non-atomic memcpy() while holding sch->lock.

If this happens, could torn or invalid data be read from sch->schib.pmcw on
the subsequent lines when accessing sch->schib.pmcw.chpid[i]?

>  	opm =3D 0;
>  	chp_id_init(&chpid);
>  	for (i =3D 0; i < 8; i++) {

[ ... ]

> diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
> index c1ba4a19368f2..f2f7f8cba410b 100644
> --- a/drivers/s390/cio/device_ops.c
> +++ b/drivers/s390/cio/device_ops.c
> @@ -490,6 +490,8 @@ struct channel_path_desc_fmt0 *ccw_device_get_chp_des=
c(struct ccw_device *cdev,
>  	struct chp_id chpid;
> =20
>  	sch =3D to_subchannel(cdev->dev.parent);
> +	if (!sch->schib.pmcw.dnv)
> +		return NULL;

[Severity: High]
This isn't a bug introduced by this patch, but doesn't this lockless DNV
validation before accessing PMCW fields also risk a data race?

Since callers cannot wrap these API functions in sch->lock (because functio=
ns
like chp_get_chp_desc() can block on memory allocations), is there a way to
safely read these fields without racing with cio_update_schib()?

>  	chp_id_init(&chpid);
>  	chpid.id =3D sch->schib.pmcw.chpid[chp_idx];
>  	return chp_get_chp_desc(chpid);
> @@ -510,6 +512,8 @@ u8 *ccw_device_get_util_str(struct ccw_device *cdev, =
int chp_idx)
>  	struct chp_id chpid;
>  	u8 *util_str;
> =20
> +	if (!sch->schib.pmcw.dnv)
> +		return NULL;

[Severity: High]
This is a pre-existing issue, but is this lockless DNV validation also
subject to the same TOCTOU data race with cio_update_schib() as mentioned
above?

>  	chp_id_init(&chpid);
>  	chpid.id =3D sch->schib.pmcw.chpid[chp_idx];
>  	chp =3D chpid_to_chp(chpid);

[ ... ]

> @@ -662,6 +666,9 @@ int ccw_device_get_mdc(struct ccw_device *cdev, u8 ma=
sk)
>  	struct chp_id chpid;
>  	int mdc =3D 0, i;
> =20
> +	if (!sch->schib.pmcw.dnv)
> +		return 0;
> +

[Severity: High]
This is a pre-existing issue, but could this lockless access to PMCW fields
lead to reading garbage data if cio_update_schib() updates sch->schib
concurrently?

>  	/* Adjust requested path mask to excluded varied off paths. */
>  	if (mask)
>  		mask &=3D sch->lpm;

[ ... ]

> @@ -798,6 +805,8 @@ int ccw_device_get_chpid(struct ccw_device *cdev, int=
 chp_idx, u8 *chpid)
> =20
>  	if ((chp_idx < 0) || (chp_idx > 7))
>  		return -EINVAL;
> +	if (!sch->schib.pmcw.dnv)
> +		return -ENODEV;

[Severity: High]
This isn't a bug introduced by this patch, but does this lockless DNV
validation share the same TOCTOU data race with cio_update_schib() when
reading PMCW fields?

>  	mask =3D 0x80 >> chp_idx;
>  	if (!(sch->schib.pmcw.pim & mask))
>  		return -ENODEV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910093205.3357=
827-1-vneethv@linux.ibm.com?part=3D3
