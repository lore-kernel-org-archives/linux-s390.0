Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76BF36B921
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843893; cv=none; b=mFkLsV0KO+JnqjbBJcWJKw8+UiZpdwNspnFPriV1eQYK0A1ZUjhELTk3EumSfG/ErpmljWk43P+2IHpm8O87wuJf3TQOxG8wzqFVZ0khnwqDI9ZC3AI0Z6qkjw9HvlPfSP/T+SqJsRtG0cMBV229j8HYJS+5shHMxQKZ85Btm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843893; c=relaxed/simple;
	bh=naitD+w1q4SJjrpcss4HDMdsZrAIU/CMkGAxtyDegPE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i9BGjVNO8Bj8J5jMYiWmdHgmO8qZch+UGJraquFoGstCyfrVAPN9dQP4DXG1p3Fw21A33FlRMmC/gjOT9XMmRriPE7bX47AbLokwWRIRdX8gRfV8O2qQcSl/p4OAKL9dY/d3H7QiKbI0yieEy4Dorqv20lbmSfPAsWvXQ1ZTKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCCtgH7k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCCtgH7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFAF1F000E9;
	Tue,  4 Aug 2026 11:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785843891;
	bh=G89de9z4qV3VvmuaExcB5Ow4lOCaPvPCOfNFoCehEEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hCCtgH7kZMb0v0+i51RUAdpq+w7O4Fg1cE5IeMgDl9kT4wyYjFTx37CsrHe8GhGvO
	 CoIiKHfBh1wYTrLHMR6Ai0DSRh0b3ULCMoO3QlkL8kwjBp4qFh7Sh2AaFBb67GaVpF
	 fguPXmGVGkXT3iAx6Y6Crh0V3jkJjFqRMPVOB/B1eSMHrzzc965/uMgQafGbrwq+Lh
	 J8KtCrooV/H8O2WirOklmUc94MoElYWr0NCKQTaWhibPTWynxXO6iyY8QH/6ryWQ5L
	 AZpHOjAU+/dRwH/N29gU9RkYqPo/xri6xiXViNzadSsy89+MY9UbdHOyb2cn8yacsT
	 YpqLuW6ym3QSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/crypto: Rework ctr_aes_crypt() to remove
 conditional locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260804113736.1423667-2-hca@linux.ibm.com>
References: <20260804113736.1423667-1-hca@linux.ibm.com>
 <20260804113736.1423667-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 11:44:50 +0000
Message-Id: <20260804114451.3EFAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The error code returned by `skcipher_walk_virt()` is unconditional=
ly overwritten by the return value of `__ctr_aes_crypt()`, silently droppin=
g errors.
--

--- Patch [1]: [PATCH 1/3] s390/crypto: Rework ctr_aes_crypt() to remove co=
nditional locking ---
commit 83af1e74cacdeddf34088df594504204b40a3d99
Author: Heiko Carstens <hca@linux.ibm.com>

s390/crypto: Rework ctr_aes_crypt() to remove conditional locking

This commit removes conditional locking in ctr_aes_crypt() to address a Cla=
ng
thread-safety warning. The block processing loop is moved into a new helper
function __ctr_aes_crypt().

> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 62edc66d54788..4b7e47423e892 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c

[ ... ]

> @@ -589,37 +604,53 @@ static int ctr_aes_crypt(struct skcipher_request *r=
eq)
>  {
>  	struct crypto_skcipher *tfm =3D crypto_skcipher_reqtfm(req);
>  	struct s390_aes_ctx *sctx =3D crypto_skcipher_ctx(tfm);
> -	u8 buf[AES_BLOCK_SIZE], *ctrptr;
>  	struct skcipher_walk walk;
> -	unsigned int n, nbytes;
> -	int ret, locked;
> +	u8 buf[AES_BLOCK_SIZE];
> +	unsigned int nbytes;
> +	int ret;
> =20
>  	if (unlikely(!sctx->fc))
>  		return fallback_skcipher_crypt(sctx, req, 0);
> =20
> -	locked =3D mutex_trylock(&ctrblk_lock);
> -
>  	ret =3D skcipher_walk_virt(&walk, req, false);
> -	while ((nbytes =3D walk.nbytes) >=3D AES_BLOCK_SIZE) {
> -		n =3D AES_BLOCK_SIZE;

[ ... ]

> -		crypto_inc(walk.iv, AES_BLOCK_SIZE);
> -		ret =3D skcipher_walk_done(&walk, nbytes - n);
> -	}
> -	if (locked)
> +
> +	if (mutex_trylock(&ctrblk_lock)) {
> +		ret =3D __ctr_aes_crypt(sctx, &walk, true);
>  		mutex_unlock(&ctrblk_lock);
> +	} else {
> +		ret =3D __ctr_aes_crypt(sctx, &walk, false);
> +	}

[Severity: High]
Does this code accidentally drop the error code from skcipher_walk_virt()?

If skcipher_walk_virt() fails and returns a negative error code (e.g. -ENOM=
EM
or -EINVAL), ret is immediately overwritten by the return value of
__ctr_aes_crypt().

Because walk.nbytes is 0 on error, __ctr_aes_crypt() will skip its loop
and return 0, converting the error into a success:

arch/s390/crypto/aes_s390.c:__ctr_aes_crypt() {
	int ret =3D 0;
	while ((nbytes =3D walk->nbytes) >=3D AES_BLOCK_SIZE) {
		...
	}
	return ret;
}

Could this result in callers silently treating unencrypted data as a
successful cryptographic operation?

> +
> +	nbytes =3D walk.nbytes;
>  	/*
>  	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804113736.1423=
667-1-hca@linux.ibm.com?part=3D1
