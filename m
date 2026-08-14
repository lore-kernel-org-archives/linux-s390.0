Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60673358363
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711572; cv=none; b=OeR1EvXpxc0xCk6Ttpyd9ujZkBHHudWG9LJNaWDlD1k/E1Z1Esh/KzLjphssO9YjUlAvcF5U+awoir3rUQYDyvjEu45aVMFLRsnrD5z5K9iQtjaKt6LxpygEDSOdk3yEppaP2VYmMjtI/THOVU+kiGImeJ4Zj6mrHzNqN0y1GwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711572; c=relaxed/simple;
	bh=5oweIHoFx0W9CzQX9UXdKJ0B98rclu5ciUDCZMxTKcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EDdOLDsNE/qP7ERFBekCdWVNdTjHVdIlKrG/yjjLijF88ghS9mhaE7i0oyIYWDW8mlEEoqRPsv/V72razGndGNelm8ieUuHKEuuoV4ygWz+iKDHzUx2LCxTWmoFs9xoTrJq5M6PHGMixUPfiQvDnx/rDRIJUedd+HCnysMAnPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGEIINH7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGEIINH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0F31F000E9;
	Fri, 14 Aug 2026 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711566;
	bh=QnISCoFyaT+xrqz6MxR+b7ssMYua1QBgf8cH5vQ9vDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oGEIINH7wfdJDCC1CuduK6MQNrQZaJVCRNTLAdKtCuduj6RJNt0XSSmhXnCM5gpBC
	 7xLg3uFYpE3Sd1tbsY4+JRrila31eMZaK14jP7gbOy1K4NX0uvftmzrWMWMRFuAKb5
	 jgrACEhzIPAWFAhuEapHK219w2k/KsVG1Ebuy2k7hOVxDSWCSdDbc/xXmhd/1ik3+U
	 dt95A03rifjK3FZQIrrnf0SHoZQD14ckCzcybTOanMO7ejc1D3XDKZZ6XTg5cz2kwF
	 +CArQBvZryDu1o5Rb1Drt0iAAm0uY21RV7Xt81Eo8NQq0GBC9BKH/Tb4gKwd2CXCne
	 2Z3SgqGb/Xp+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] s390/crypto: Fix use of mutex in atomic context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260814123711.61145-4-freude@linux.ibm.com>
References: <20260814123711.61145-1-freude@linux.ibm.com>
 <20260814123711.61145-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 12:46:05 +0000
Message-Id: <20260814124606.4B0F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch completely misses the exact same preexisting invalid mut=
ex usage in atomic context in the Protected AES (PAES) CTR implementation (=
`paes_s390.c`).
--

--- Patch [3]: [PATCH v4 3/3] s390/crypto: Fix use of mutex in atomic conte=
xt ---
commit 709721b3784d3a0026753ef3b28100620270373d
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix use of mutex in atomic context

This commit replaces a mutex with a binary semaphore in the s390 AES CTR
implementation. This prevents unsafe locking when the crypto routines are
called from atomic or interrupt contexts.

> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 10561aa687c78..bd9815988c813 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c
[ ... ]
> @@ -569,12 +569,13 @@ static int ctr_aes_crypt(struct skcipher_request *r=
eq)
>  	u8 buf[AES_BLOCK_SIZE], *ctrptr;
>  	struct skcipher_walk walk;
>  	unsigned int n, nbytes;
> -	int ret, locked;
> +	bool locked;
> +	int ret;
> =20
>  	if (unlikely(!sctx->fc))
>  		return fallback_skcipher_crypt(sctx, req, 0);
> =20
> -	locked =3D mutex_trylock(&ctrblk_lock);
> +	locked =3D down_trylock(&ctrblk_sem) =3D=3D 0;

[Severity: High]
This is a pre-existing issue, but it appears the exact same pattern exists =
in
the Protected AES (PAES) CTR implementation which wasn't updated here.

Looking at ctr_paes_do_crypt() in arch/s390/crypto/paes_s390.c:

	locked =3D mutex_trylock(&ctrblk_lock);

Since the skcipher API can be invoked from atomic or interrupt contexts (li=
ke
network softirqs), does the PAES implementation also risk an atomic context
locking violation? Should arch/s390/crypto/paes_s390.c receive a similar
conversion to a binary semaphore?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814123711.6114=
5-1-freude@linux.ibm.com?part=3D3
