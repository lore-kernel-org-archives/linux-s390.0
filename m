Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570F3090C1
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964289; cv=none; b=ipFa2VuVZtUOabXMtW9JkNe8k16fQV4WoC+x4w5GnM8kPXvPd3KJQBKe7Gnd80JWWbwLXy0sbLkTqYk/3bYy7DBPzUKfe0HwUsGrWXh/VBacn6VBeUZ/JyuVipwfrNduQjn5YmPBg68S5nGGMxEmujnhP9RSNINtngQPlTEUFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964289; c=relaxed/simple;
	bh=oHJPrbIi8R6ZaLxaqfFsvT9hxrcP2558tnTZS4/d8RI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jCMX4eOGLKJ21ACLvDiz69PBzCpBYosEmepD2CwHWHD9Lc4ZQLkvlrMrhFypIzqBeaYn8eLDBtzzifhe9V5G/dRhGhpg4GmlOAvei7MeiVJAMKyi4hlWy4jAH4FwH6kgWydDgZo7aWUSmpPep7vVXoDmCEm1XQF4+giUq4LXIjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKng8ELF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKng8ELF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47441F000E9;
	Mon, 17 Aug 2026 10:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786964285;
	bh=ktlPQY9byBdc09OPDRGiwTGcnpnF38fd/wvHVqONVkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mKng8ELFfz9eafoW7tZG1MF0q0Vf2TEGkJUmFHRejIJAEyvsKe5sgf5/xPFW08Gyn
	 0i1fmuboU2bACfWGxdXKaa31ZnM669KBinSZM/AFfp/Alu5Lc2+UlMnzNEnq9XJscK
	 LrHxrNdgAI5FqkXHtOS+EXCPRTehHHzKdXz0zFh2ptBmYLwgSmzYFZsLYs8CJaCko7
	 c+Rn3EZu+pA6Mx4zz+2U5nfl2qeiap9WohcoO0J1bkBz+KeH/cWRHpcTlhTLiRhyU8
	 5LPRsSgOsZqFvatH9lBuI/Qjkh6mMGJHKQj/Q2OoHADOvZAIzwXpdQFKEIKcCJhJTu
	 HQmlHHndN/0dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] s390/crypto: Fix handling of EBUSY in PAES when
 req is pushed to crypto engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260817104203.74033-6-freude@linux.ibm.com>
References: <20260817104203.74033-1-freude@linux.ibm.com>
 <20260817104203.74033-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 10:58:04 +0000
Message-Id: <20260817105804.A47441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch incorrectly skips cleanup on all -EBUSY return codes, fa=
iling to distinguish between asynchronous enqueue success and synchronous h=
ardware errors.

Pre-existing issues:
- [Critical] The handling of -EBUSY when transferring hash requests to the =
crypto engine is broken in HMAC algorithms, leading to memory corruption an=
d use-after-free.
--

--- Patch [5]: [PATCH v2 5/6] s390/crypto: Fix handling of EBUSY in PAES wh=
en req is pushed to crypto engine ---
commit 8647fcf36245bb280632aa13fa77c2090293e0d8
Author: Harald Freudenberger <freude@linux.ibm.com>
Subject: s390/crypto: Fix handling of EBUSY in PAES when req is pushed to c=
rypto engine

This commit addresses a missing check for -EBUSY when a request is
successfully transferred to the crypto engine backlog in the PAES algorithm=
s.
It updates the return code checks to treat -EBUSY similarly to -EINPROGRESS=
 to
avoid incorrectly cleaning up the request while it is still queued.

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index 03446bfac37f2..b60696c49fccf 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
> @@ -494,15 +494,15 @@ static int ecb_paes_crypt(struct skcipher_request *=
req, unsigned long modifier)
>  	if (rc =3D=3D 0 || rc =3D=3D -EKEYEXPIRED) {
>  		atomic_inc(&ctx->via_engine_ctr);
>  		rc =3D crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, =
req);
> -		if (rc !=3D -EINPROGRESS)
> +		if (rc !=3D -EINPROGRESS && rc !=3D -EBUSY)
>  			atomic_dec(&ctx->via_engine_ctr);
>  	}
> =20
> -	if (rc !=3D -EINPROGRESS && walk->nbytes)
> +	if (rc !=3D -EINPROGRESS && rc !=3D -EBUSY && walk->nbytes)
>  		skcipher_walk_done(walk, rc);
> =20
>  out:
> -	if (rc !=3D -EINPROGRESS)
> +	if (rc !=3D -EINPROGRESS && rc !=3D -EBUSY)
>  		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));

[Severity: High]
Does this bypass cleanup if ecb_paes_do_crypt() fails synchronously?

Looking at ecb_paes_crypt(), ecb_paes_do_crypt() can fail synchronously and
return -EBUSY due to hardware key conversion failures:

    if (!atomic_read(&ctx->via_engine_ctr)) {
        rc =3D ecb_paes_do_crypt(ctx, req_ctx, tested, false);
        if (rc =3D=3D 0)
            goto out;
    }

If rc is -EBUSY, the fallback block is skipped:

    if (rc =3D=3D 0 || rc =3D=3D -EKEYEXPIRED) {
        atomic_inc(&ctx->via_engine_ctr);
        rc =3D crypto_transfer_skcipher_request_to_engine(paes_crypto_engin=
e, req);
        ...

Then we reach the updated cleanup logic, which now skips execution when rc =
is
-EBUSY. Could this lead to leaked resources from skcipher_walk_done() and an
indefinite wait, since the caller interprets -EBUSY as a successful queue t=
o the
engine but no callback will ever arrive?

Similar logic is updated in cbc_paes_crypt(), ctr_paes_crypt(), and
xts_paes_crypt().


This is a pre-existing issue, but I noticed a similar pattern in phmac_s390=
.c
that might need addressing.

arch/s390/crypto/phmac_s390.c:phmac_update()
    rc =3D crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req);
    if (rc !=3D -EINPROGRESS)
        atomic_dec(&tfm_ctx->via_engine_ctr);
    ...
    if (rc !=3D -EINPROGRESS) {
        hwh_advance(hwh, rc);
        memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
    }

[Severity: Critical]
If crypto_transfer_hash_request_to_engine() returns -EBUSY when the request=
 is
successfully added to the backlog queue, will this incorrectly treat it as a
failure?

If so, this could unmap the scatterlist via hwh_advance() and zero the hash
context via memzero_explicit() while the crypto engine later operates on it
asynchronously.

Is it necessary to apply the same -EBUSY handling fixes to the HMAC algorit=
hms?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817104203.7403=
3-1-freude@linux.ibm.com?part=3D5
