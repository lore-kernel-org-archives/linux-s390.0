Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEC446BE8
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236161; cv=none; b=GfFL/IftKDVwTUJWrvRQ2zFTzds5O+s+iRAjduBhSxzQLt4ya1p4l0AlipYwUNSj7cebBx5ayzlmw6Cu6uBO+4oJLfefNO+jseQprvipFyGSP1a0miajidqjpQ4tVjh3BjERWmxSYDz/Tymr6ifClKxe42gHnvmihGpQvZNxP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236161; c=relaxed/simple;
	bh=Aip3bgrep0pPWG+A7FWckJUZM1OPK88RzwTxLrvxu7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lzMUbXUhMog4SDoVFmLW7pXq/8k1fWWA3JVZUXsRCu7f3Sa9JBVxmgWk9W1M9u/cVD7gncXUC4AsHn6IzKys/o19gOBhktrWZukt10FEOVf+cuzcgv7HJAwFCaVcBDJMdympDnd57nHw7akGBGi/3amVblmdgyrRbmbfWTMF4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVxc52d5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVxc52d5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104011F00A3A;
	Thu, 20 Aug 2026 14:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787236160;
	bh=0rAji0lUqlsCYXZFrLrerhgzG7CcdhbK/q87ctnckqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DVxc52d5pGUTuFT6o5rS0poCabldQ0XkouoVy83N8AtTTUIaWh+2+s34n7EOUZa6k
	 6l+F5uU0dWq7DNI94b9+yvZ7bhjS20S9qk517lwA+/JT13tT9Iw5wmFjKTjvJ489ge
	 dd0t0aIPtzwOSewnf/kKsin5sJXT5th0Fvd/FHASwVr25t9ZeF+MC5/KVJfyjA5M+k
	 L35oMcOLlcjEFN5A+7CauRYY8uAKpl7Y7ScLh/2AIkaqPcH5cCrqIIJPScs0zPceGs
	 mTTghu9S/hr1+ZVKdll00fDpMJXMym0kjRc/Iq7tm5RHU176QRuUOy+G6L2NyCIJ0E
	 3SLJgn8WKGJ4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] s390/crypto: Fix use of mutex in atomic context
 in PAES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260820141957.19091-4-freude@linux.ibm.com>
References: <20260820141957.19091-1-freude@linux.ibm.com>
 <20260820141957.19091-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:29:19 +0000
Message-Id: <20260820142920.104011F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch correctly replaces an unsafe `mutex_trylock()` with a bi=
nary semaphore in the `paes_s390` PAES CTR implementation, because mutexes =
cannot be safely locked in atomic or interrupt context. However, it fails t=
o apply the exact same fix to the closely related standard AES CTR implemen=
tation in `aes_s390.c`. The function `ctr_aes_crypt()` still uses `mutex_tr=
ylock(&ctrblk_lock)` on its fast path, which is unsafe when called from sof=
tirq/atomic context.
--

--- Patch [3]: [PATCH v5 3/8] s390/crypto: Fix use of mutex in atomic conte=
xt in PAES ---
commit a2afbae94320906011d9357378185a56c441bdd2
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix use of mutex in atomic context in PAES

The PAES CTR implementation used a mutex to lock one page of exclusive
memory for fast CTR processing. Unfortunately a mutex is not save to
use in atomic or interrupt context. So use a binary semaphore instead
which is save to use in such environments.

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index d075b0241f1f5..e8bbfc376ebb1 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
[ ... ]
> @@ -971,7 +972,7 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ct=
x,
>  	if (rc)
>  		goto out;
> =20
> -	locked =3D mutex_trylock(&ctrblk_lock);
> +	locked =3D down_trylock(&ctrblk_sem) =3D=3D 0;

[Severity: High]
This is a pre-existing issue, but I noticed the standard AES CTR
implementation in arch/s390/crypto/aes_s390.c seems to suffer from the
exact same problem.

Looking at ctr_aes_crypt() in aes_s390.c, it still uses mutex_trylock()
on its fast path:

arch/s390/crypto/aes_s390.c:ctr_aes_crypt() {
    ...
	if (unlikely(!sctx->fc))
		return fallback_skcipher_crypt(sctx, req, 0);

	locked =3D mutex_trylock(&ctrblk_lock);

	ret =3D skcipher_walk_virt(&walk, req, false);
    ...
}

Since mutexes cannot be safely locked in atomic or interrupt context, and
network IPsec/MACsec could execute packet decryption in softirq context,
does the standard AES implementation need this identical fix as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820141957.1909=
1-1-freude@linux.ibm.com?part=3D3
