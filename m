Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D13DD846
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785959074; cv=none; b=uB/f1LVvN+1yWsBktSMZ3slrwPX4lk7pRtLvWaLNaLnRh5hbDLS/DenK0U/LWPuq/vOvK3qr5nG86zbr9kP//1w7yVN1Rkjzo8WJYomKD8AF6A5MB0SAYpdWH3sM6XH/1UJR1AWVndF8vX9AnW45CouTKnXDCeZegSzg2/6uZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785959074; c=relaxed/simple;
	bh=rrLqiV7HN9FbP7IceyrOPpFxoQfmfFGYqBrdcnJ/1H4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GFtF2zM/5mUW0Cw23betkRKCIeL5tEbMVSxJ0MwchjMF0RyfZ2FR6gt78sMH1Xn3dvhXOKOePACMTbtmn9SQQ9wjCmNLuP6rkRZIzPlXfdUVRIivLUKdQm9/aYqpPC9EvOvzePoiZegMb8O2UP9rGUJoRSUY8SdsDwT2KC/hNI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJK/jrjg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJK/jrjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585D51F000E9;
	Wed,  5 Aug 2026 19:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785959071;
	bh=HSD5ssFXBdd55Ilr3PUGTZn0WbmkH2MWM2ZirJewLqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJK/jrjg/KDC6Z8lRaydkf+s9z7xdLPejQgBSJt8qLM0rCFNN+IkrMa84tDEu1+Me
	 TSxryLyThxiiXMhhhvyHwI9OqggQBEZKSVgD49uIs3G53SUe1CSKMdgThEbrWxKbX4
	 lmsJyNpEHaz82mMsmeP0aHQtoxdF1Wwg0i4K+JffklQzbpPbVibGlbzUx3sXKD0O+K
	 SvN0jAHlyE8ByNaYXiANbT+ZOZnq7eHYfF+xNCDTfhXgttFAD/0YlJ+TcgOhwykczK
	 igCwzdHsaYMlQzfAehqITYZTUgbaiYoKdXcgpD8qkKR9jc68vEvrgBbygeiQt7WTDB
	 zFrf13J00WLhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/19] s390/dasd: Report ESE capability and format mode
 at device online
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260805111612.1285190-18-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-18-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 19:44:30 +0000
Message-Id: <20260805194431.585D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing memory barrier when publishing the on-disk format label,=
 allowing lockless sysfs readers to observe uninitialized data.
--

--- Patch [17]: [PATCH 17/19] s390/dasd: Report ESE capability and format m=
ode at device online ---
commit 248d6eb45e332487f9255bf060a4d057f9939181
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Report ESE capability and format mode at device online

This patch extends the device information line logged when a volume comes
online with the ESE hardware capability and the on-disk format mode. The
format mode is derived from the on-disk format label.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index d5854ed0076e3..3c4fcfb1558de 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -2609,15 +2610,29 @@ static int dasd_eckd_end_analysis(struct dasd_blo=
ck *block)
[ ... ]
> +	/*
> +	 * Report the ESE hardware capability and the format mode. The mode
> +	 * comes from dasd_eckd_on_demand_format() (the on-disk label, or the
> +	 * ESE state when no label is present), matching the on_demand_formatti=
ng
> +	 * sysfs attribute.
> +	 */
> +	ese_str =3D dasd_eckd_ese_capable(device) ? ", ESE" : "";
> +	fmt_str =3D "";
> +	if (dasd_eckd_on_demand_format(device))

[Severity: Medium]
Could this lockless read of ese_label_valid in dasd_eckd_on_demand_format()
observe uninitialized or torn data from ese_label due to compiler reorderin=
g?

Looking at where the label is populated, such as in
dasd_eckd_read_format_label():

		private->ese_label =3D *label;
		private->ese_label_valid =3D true;

and in dasd_eckd_fill_format_label():

	private->ese_label =3D *label;
	private->ese_label_valid =3D true;

The valid flag is set to true immediately after the struct assignment witho=
ut a
write memory barrier. In dasd_eckd_on_demand_format(), there is also no
acquire barrier:

	if (private->ese_label_valid)
		return !!(private->ese_label.flags & DASD_ESE_LABEL_F_QUICK);

Since dasd_eckd_on_demand_format() is accessible via sysfs attributes like
on_demand_formatting concurrently while the device is coming online or
formatting, could this missing barrier cause sysfs to transiently return
incorrect values (0 instead of 1)?

> +		fmt_str =3D ", on-demand format";
> +	else if (dasd_eckd_ese_capable(device))
> +		fmt_str =3D ", full format";
> =20
>  	dev_info(&device->cdev->dev,
> -		 "DASD with %u KB/block, %lu KB total size, %u KB/track, "
> -		 "%s\n", (block->bp_block >> 10),
> +		 "DASD with %u KB/block, %lu KB total size, %u KB/track, %s%s%s\n",
> +		 (block->bp_block >> 10),
>  		 (((unsigned long) private->real_cyl *
>  		   private->rdc_data.trk_per_cyl *
>  		   blk_per_trk * (block->bp_block >> 9)) >> 1),
>  		 ((blk_per_trk * block->bp_block) >> 10),
>  		 private->uses_cdl ?
> -		 "compatible disk layout" : "linux disk layout");
> +		 "compatible disk layout" : "linux disk layout",
> +		 ese_str, fmt_str);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D17
