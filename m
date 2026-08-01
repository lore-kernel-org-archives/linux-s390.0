Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D9DDCD
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584780; cv=none; b=HjwGJFn34Uq4vn4hOW7l1CwhTJ/or8n5pJ0Ae4z/c33/a6OmeoRPhYZXEgDJjsgFe6tVfws96AAuCKsVZa5N3tTfqRTRCgbvgb/oumR5HRfAtH5GNsvrjg4bxOhaLwxggdz6Kqf/ooY/BAdkQbL8Hepa4R0oSM6zLgpunajFeVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584780; c=relaxed/simple;
	bh=pspzRCFh7d1yZYIxiCAZd5laZQFHMgAng2mYYA0w8bM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HkivkwY3V4vWQcs1Eo84yGsrZ5aVF1qe2478sMaG0Rs82z8ktnhLsqRn8efSt3u168Z3VN+s43PwdW560C/UT7lqyHfeGqJs8IHmCqjEDewm0PgyBZKBCnN7IXh+f/bqCUvKFk5hBo5RyZa69C9HL/E8AnsZD5OLPaWbhfNaSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzcNOhJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzcNOhJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7231F00AC4;
	Sat,  1 Aug 2026 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785584779;
	bh=vynbINEr+MH/M5aBfpER8CGBC4gVnw+WSuTY/OcilrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzcNOhJxRyz47amD2hnunm04t/gSSx60FmUpx50shcHtDCBMq0A0JqttsrY05N/lR
	 PlJm25aWSRQquxxE/KpquCf1Y1GifqxAiHtI7WiFK7ID2pfQ0DXzWIpbfduo7dgFw3
	 V+l5p0SgcP+YBArbhwTxdz3nwwYpVEqemuOl+kl1ynGjKRobFlmvuffGp0kTc/azqC
	 oGmPgCs6y/YJPUKJVgBqvKdtZJGtS4fr6XJXaLDcgmxMFyHh9imlafoNhTRRDQgt7V
	 Yne5nBHJzdRWkm8ejQhHgn1TR+DVWhJBfvGjsHdShqA84mYxX3CRcOVk+Uq0UTlhGf
	 MPYwdEM6AEP0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/18] s390/dasd: Derive adaptive ESE fulltrack
 heuristic from ft_bias
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-14-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-14-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:46:18 +0000
Message-Id: <20260801114618.CA7231F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Premature `dasd_ft_bias_apply` call leaves adaptive heuristic vari=
ables uninitialized, causing FSM evaluation on every I/O
--

--- Patch [13]: [PATCH v6 13/18] s390/dasd: Derive adaptive ESE fulltrack h=
euristic from ft_bias ---
commit 898e7c695e4b33bd0b7466d135dcbce8e6436652
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Derive adaptive ESE fulltrack heuristic from ft_bias

This patch derives an adaptive heuristic from the ft_bias configuration for
s390 DASD devices. It uses short probe windows to measure the NRF rate and
dynamically switches between fulltrack and plain writes, falling back and
capping the backoff interval as needed.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 9003e28a4ebbe..67c301e182c0f 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -2162,8 +2162,7 @@ dasd_eckd_check_characteristics(struct dasd_device =
*device)
> =20
>  	/* default ESE fulltrack write aggressiveness from the module parameter=
 */
>  	device->ft_bias =3D min_t(unsigned int, full_track_bias, DASD_FT_BIAS_M=
AX);
> -	/* only the "always" endpoint forces fulltrack unconditionally here */
> -	device->fulltrack =3D (device->ft_bias >=3D DASD_FT_BIAS_MAX) ? 1 : 0;
> +	dasd_ft_bias_apply(device);

[Severity: High]
Does calling dasd_ft_bias_apply() happen too early here, before the volume
information is read?

Because dasd_eckd_read_vol_info() hasn't been called yet, the ESE flag is
still 0, causing dasd_ese_adaptive() to return false during initialization.
This results in dasd_ft_bias_apply() returning early and leaving heuristic
parameters like ese_heu_start_interval and ese_heu_probe_window at 0:

drivers/s390/block/dasd_int.h:dasd_ft_bias_apply() {
    ...
	if (!dasd_ese_adaptive(device)) {
		device->fulltrack =3D (a >=3D DASD_FT_BIAS_MAX) ? 1 : 0;
		device->ese_probe_state =3D DASD_ESE_HEU_FT1_ACTIVE;
		return;
	}
    ...
}

As a result, in dasd_ese_heuristic_tick(), the interval check will evaluate
to false on every I/O because ese_probe_interval is 0:

drivers/s390/block/dasd_eckd.c:dasd_ese_heuristic_tick() {
    ...
	if (atomic_inc_return(&basedev->ese_io_cnt) < (int)basedev->ese_probe_inte=
rval)
		return;
    ...
}

Will this completely defeat the backoff and cause the state machine to be
evaluated with atomic exchanges on every single I/O for the lifetime of the
device?

> =20
>  	if (private->conf.gneq) {
>  		value =3D 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D13
