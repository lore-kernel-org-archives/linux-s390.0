Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F93803DB
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734443; cv=none; b=KLRm8twMqBGkYR9/a0Ye/erInrl0invQL1+oinAoA80qFaZDSgT3rbkDebWBPCfxCifaWw8Rr3WVtg5H+vEFjhG01UA47Ws95sdW9HOq5voV0RCGi2rvsxuwp21+S7RXeEhlV8JhdYcmD8Ur2TO58k7Twxb7rosigCug7pyYfzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734443; c=relaxed/simple;
	bh=IaZ3qwueQsXpZEsIfnuUukrkyb/QwE8aJnB4dGAkEMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X+kUr2KY+PE66B+PBHt54oSrJH8xfKdYXt7vQ/Sayx7DwuYHBkaOyDrTMz4CzrVS8bUStN1qb51LQyK6ZmDTOePxjv2zjqh3l9ojm49bRKGsE5IS/qA4pjfZ7GzLdxUGGhRQxBUwSuS2hUtqn1bETuCU42qUWNoVUzCK+T5PQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdxialXh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdxialXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45251F000E9;
	Wed, 22 Jul 2026 15:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784734442;
	bh=IPX1iYEjQSdnBmkCtYlTXgWP7uaTmSBMvT6HwJJWLIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KdxialXhqr9QezgbSN8e0/eKn2hS2F+rSb+ioDxXBuW3SaMXs9+kZmmL5sEmGR2K7
	 DudD+Qi50+5AVFh35TNHXtKPUeBYDf+jAHEHqBP+aRoEh1qE1c8QDcTX6erABvCRA2
	 4oSfsNK6eyZeajakJr2gqVVCr0N4UheoW2NaFFC8QENJU5FftAneOzwX6dKfs99Tic
	 SO+FhOa8w2OObO2GZdaifmG7AG1nu7mx0SHs781xAYJkgAG1NQNe3hyjHE2HfQa//r
	 rHpcX/OOIV3KDYyTFoFHkIKCkAWCxo/NJdUh0BLT5LJh81f2H1qkGNstd4H9HR85Hl
	 q/Z3w1pUUwxDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] s390/zcrypt: Close speculative mem read
 possibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260722152025.119391-2-freude@linux.ibm.com>
References: <20260722152025.119391-1-freude@linux.ibm.com>
 <20260722152025.119391-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 15:34:01 +0000
Message-Id: <20260722153401.B45251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] In `_zcrypt_send_ep11_cprb`, `array_index_nospec()` is used withou=
t a prior bounds check against `AP_DOMAINS`, silently aliasing out-of-bound=
s domains to domain 0 and bypassing administrative permission checks.

Pre-existing issues:
- [High] Administrative CPRBs with domain =3D=3D AUTOSEL_DOM completely byp=
ass the perms->adm permission check in `_zcrypt_send_cprb` and `_zcrypt_sen=
d_ep11_cprb`.
--

--- Patch [1]: [PATCH v2 1/1] s390/zcrypt: Close speculative mem read possi=
bility ---
commit de8272723358b7baff06b29b44fe219b26350d5e
Author: Harald Freudenberger <freude@linux.ibm.com>
s390/zcrypt: Close speculative mem read possibility

This patch addresses a speculative execution out-of-bounds read by adding
array_index_nospec() to the domain value extracted from user-controlled
CPRB structs before it is used as an array index.

> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcryp=
t_api.c
> index f57189c2b839e..593aace5fc484 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -879,6 +879,7 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_p=
erms *perms,
> =20
>  	if (perms !=3D &ap_perms && domain < AP_DOMAINS) {

[Severity: High]
This is a pre-existing issue, but does this logic allow administrative
CPRBs with domain =3D=3D AUTOSEL_DOM to bypass the perms->adm permission
check entirely?

If a user submits a CPRB request with an administrative command code and se=
ts
the target domain to AUTOSEL_DOM, this condition evaluates to false.

The perms->adm evaluation is skipped, and the kernel later selects a queue
based solely on the user's usage permissions in zcrypt_check_queue().

>  		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
> +			domain =3D array_index_nospec(domain, AP_DOMAINS);
>  			if (!test_bit_inv(domain, perms->adm)) {
>  				rc =3D -ENODEV;
>  				goto out;

[ ... ]

> @@ -1079,6 +1080,7 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, stru=
ct ap_perms *perms,
> =20
>  	if (perms !=3D &ap_perms && domain < AUTOSEL_DOM) {

[Severity: High]
This is a pre-existing issue, but does this similarly skip the admin check
for EP11 CPRBs if domain =3D=3D AUTOSEL_DOM?

>  		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
> +			domain =3D array_index_nospec(domain, AP_DOMAINS);

[Severity: High]
Does this use of array_index_nospec() map out-of-bounds domains to domain 0?

The guard condition for this block in _zcrypt_send_ep11_cprb() checks
domain < AUTOSEL_DOM, but array_index_nospec() bounds against AP_DOMAINS.

If a user provides a domain value between AP_DOMAINS and AUTOSEL_DOM - 1, t=
he
array_index_nospec() call will forcefully mask the out-of-bounds domain to =
0.=20

Will this result in checking perms->adm for domain 0 instead of the request=
ed
domain, potentially allowing an authorization bypass if the user has admin
privileges for domain 0?

>  			if (!test_bit_inv(domain, perms->adm)) {
>  				rc =3D -ENODEV;
>  				goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722152025.1193=
91-2-freude@linux.ibm.com?part=3D1
