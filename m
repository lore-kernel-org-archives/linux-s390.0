Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02BE48986E
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584738; cv=none; b=qmtJGaDbp9frprg57Up96rMOgIszxlFc8qVXTZIJFEHAUw4/y+d+5L6M0Bf6K2/QvEKchMrA446ZDX94TZM+wGnGZBkqntIK5vfQnV51XAHL5oELm6hCqIIokqqxZJyWOXZCImRqh2AMIMDDOEppq7930zl3XuJ9GQounMJhDxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584738; c=relaxed/simple;
	bh=GGGZXzgTP2DUoThmcK1Zs2qUf6MomGLVa1mBe40NXW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WItdRKf3AHgGCfdJVHd5P1X5IC2ZLJJuVSqMZeCHYxGf7rsP4N8yWaSlr5p+4qSpWsuxVaYzLApewgl9XO7X6xHimrfd2jATFdJfnstoBcBCxyQVM+anYHfMIEbH6FBPvbhcMkAroEbtdE5DMTUWxb7L7kFe/xJDVvMy1QuYCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AD/X6GF7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AD/X6GF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5B01F00AC4;
	Sat,  1 Aug 2026 11:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785584737;
	bh=EdfP8/hozZmeBeJjnbWfEhZr2wvTuftuQocS1EwqWck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AD/X6GF7lFM/mXIt9Ix9WgFYL+QFmQYDLBR0mFjTakHJUJKYLeC/6Wd82Udrhtjhr
	 gQRaFJQUZmubIkPcN3B5RQFi9rMaSta+Bkyv4RytRPP0KCfBHbjb+Yvf4UsEa7CWIF
	 USDrUgbxnvCg3fcZ3E0QLJGeC2MPnM1RDagGuFYLzHJAsIM2NjK5gwteYENmSqfe2/
	 /tsBbUZVG+fDKswoARNMx7mVY1Io98X0XovKWsGyHiJtIrqxQ3bDMRjaoLyLMOA8Ww
	 L/jUCeROVJB3A9q8pKrTnzgdJN6xWHdEGhxWwY4FL0zicW4uSUlhROKM8AFF3sJ+/b
	 e4nVeyzl/FoUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/18] s390/dasd: Report ESE capability and format
 mode at device online
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260801111008.3391031-17-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-17-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:45:36 +0000
Message-Id: <20260801114537.1D5B01F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Lockless reading of partially updated `dasd_format_label` causes=
 a data race and potential torn read in sysfs.
--

--- Patch [16]: [PATCH v6 16/18] s390/dasd: Report ESE capability and forma=
t mode at device online ---
commit 1bb0c0f3e976fb237f52d951feaeac8bfd58702e
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Report ESE capability and format mode at device online

This commit extends the device information line logged when a volume comes
online with the ESE hardware capability and the on-disk format mode. The
format mode is derived from the on-disk format label.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 35a970e006fd0..643eb7882f9cd 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -2608,15 +2609,29 @@ static int dasd_eckd_end_analysis(struct dasd_blo=
ck *block)
>  			  private->rdc_data.trk_per_cyl *
>  			  blk_per_trk);
> =20
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
Could calling dasd_eckd_on_demand_format() locklessly result in a data race
and a potential torn read?

When reading from sysfs, or here in dasd_eckd_end_analysis(), we read the
label without locks:

drivers/s390/block/dasd_eckd.c:dasd_eckd_on_demand_format() {
    ...
	if (private->ese_label_valid)
		return !!(private->ese_label.flags & DASD_ESE_LABEL_F_QUICK);
    ...
}

However, other paths overwrite the label locklessly. This happens during
the format ioctl:

drivers/s390/block/dasd_eckd.c:dasd_eckd_fill_format_label() {
    ...
	private->ese_label =3D *label;
	private->ese_label_valid =3D true;
    ...
}

It also happens during device probe:

drivers/s390/block/dasd_eckd.c:dasd_eckd_read_format_label() {
    ...
		private->ese_label =3D *label;
		private->ese_label_valid =3D true;
    ...
}

If a user repeatedly reads the sysfs attribute (or this device online path
is executed) while concurrently running a format ioctl, could this cause a
torn read that returns a corrupted or uninitialized boolean value?

> +		fmt_str =3D ", on-demand format";
> +	else if (dasd_eckd_ese_capable(device))
> +		fmt_str =3D ", full format";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D16
