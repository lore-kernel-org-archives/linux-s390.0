Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16B43E070
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131804; cv=none; b=i91SHEXMwt0kVn74/Yutf4YgSl3LHEFJZWviYd6jflTVUfqVJpfJ/zyNsGAgqmv82+XLMmufvo1byOtw6t8ftbJp8qXoTKaS1RUkspaF74Ee0O+bJv3yoefNooXDKc7dv6dOo5GMxh1c92/u8UDFsfXc44q6Ko88b57C+DW81I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131804; c=relaxed/simple;
	bh=ZF0Y8nMlq5Aqm9mLMAA1jlb1CkFB+4FU33mvwaZOsnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JAQ7JM7R0QvIVURsboakwNd3G3F/N1ejW2O1gMGjgUie7VEtLSWclZ6M6OmZOQWrzfqhMdpbhux2aLRYIEhleM6Kwbi29edvUiRs5nv7t7r1wp705gcfP5l82Iwjggr08l4k2T3jRjwpQVBfHTsVniWBcz3YH/XoMKTqRCEgpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6frFppR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6frFppR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3601F000E9;
	Wed, 19 Aug 2026 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787131801;
	bh=GPaBnIAEmwcftyQdgTT4eG3qAhLIzWK5wGjZhqx032A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y6frFppR57pWSNe37ythauIC0Tbu5uNuk4/mT8cM5BL2jCkaOv0s68UGbHOV7+N+L
	 D0iImMWQgT5oRXapVUp/tucjxas6+Ghxf9IFSfgCRvLwxmr9GiSl2mm1KG7AFfbiPx
	 0A4FmIKYr5lRrFPmHFX/Xwe70264XPu61Cqrnxx9nq8F4oUh1VGHnzasJFEzlhK0H/
	 PkpNiZcGhmG1k+kzASbz4ZAbJaPEu7ESsNkSPDlSKzYM3H7d1SHtXt3DylJjmdi9K+
	 qAYx/M7lle5LEbaJfW9ArqhPqRxMq6YKaEDC08/kGRiBzaloN932JFJNT4eQVVbhuW
	 UJ+znW2xM/IUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] s390/crypto: Fix handling of EBUSY in PAES when
 req is pushed to crypto engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260819091734.7331-6-freude@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
 <20260819091734.7331-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:30:00 +0000
Message-Id: <20260819093000.BA3601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch corrects the handling of the `-EBUSY` return code for th=
e crypto engine in `paes_s390.c` but fails to apply the identical fix to `p=
hmac_s390.c`, leading to state corruption and Use-After-Free.
- [High] The `do_one_request` engine callbacks complete the crypto request =
twice if a synchronous error occurs during processing, leading to a double =
completion and Use-After-Free.
--

--- Patch [5]: [PATCH v4 5/7] s390/crypto: Fix handling of EBUSY in PAES wh=
en req is pushed to crypto engine ---
commit 3e0f47412e8d6356e198b6481361a3ba704da13f
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix handling of EBUSY in PAES when req is pushed to crypto eng=
ine
   =20
This commit adds -EBUSY as a successful return code when transferring
skcipher requests to the crypto engine in paes_s390.c. This prevents
state cleanup on requests that are successfully queued on the backlog.

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index 03446bfac37f2..2048327c1ffe4 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
> @@ -494,15 +495,17 @@ static int ecb_paes_crypt(struct skcipher_request *=
req, unsigned long modifier)
>  	if (rc =3D=3D 0 || rc =3D=3D -EKEYEXPIRED) {
>  		atomic_inc(&ctx->via_engine_ctr);
>  		rc =3D crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, =
req);
> -		if (rc !=3D -EINPROGRESS)
> +		if (rc =3D=3D -EINPROGRESS || rc =3D=3D -EBUSY)
> +			cleanup =3D false;
> +		else
>  			atomic_dec(&ctx->via_engine_ctr);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but should the same fix be appli=
ed
to the hash requests in phmac_s390.c?

For example, in phmac_update():

arch/s390/crypto/phmac_s390.c:phmac_update() {
    ...
	if (rc =3D=3D 0 || rc =3D=3D -EKEYEXPIRED) {
		req_ctx->async_op =3D OP_UPDATE;
		atomic_inc(&tfm_ctx->via_engine_ctr);
		rc =3D crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req);
		if (rc !=3D -EINPROGRESS)
			atomic_dec(&tfm_ctx->via_engine_ctr);
	}

	if (rc !=3D -EINPROGRESS) {
		hwh_advance(hwh, rc);
		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
	}
    ...
}

It looks like phmac_update, phmac_final, and phmac_finup also incorrectly
treat -EBUSY as a failure, which could dismantle the state needed by the
engine thread.

[ ... ]

[Severity: High]
This is a pre-existing issue, but could the do_one_request callbacks lead to
a double completion if a synchronous error occurs?

In ecb_paes_do_one_request():

arch/s390/crypto/paes_s390.c:ecb_paes_do_one_request() {
    ...
	crypto_finalize_skcipher_request(engine, req, rc);
	local_bh_enable();
	return rc;
}

If rc is negative, does returning it here after calling
crypto_finalize_skcipher_request() force the engine thread to incorrectly
complete the request a second time?

Could this also affect cbc_paes_do_one_request(), ctr_paes_do_one_request(),
xts_paes_do_one_request(), and phmac_do_one_request()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819091734.7331=
-1-freude@linux.ibm.com?part=3D5
