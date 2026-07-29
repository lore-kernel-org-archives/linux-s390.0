Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B04446E6
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326821; cv=none; b=AzJjP3MuSTp3ykIRgN0jB6LTSnWDEcYxdSvlqJFv6GgBtn7L1lYSxLmpG6Fw1lumEBg1RyUX0FkrOBL7ZipZBFV/6ZvJsqhLU1txYO2IDvPSHgVmQMlgi+17fyI6iST3WGPFaXvffKpH7XLTgJ/3A+aYv5X9PYbU86jZB29wTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326821; c=relaxed/simple;
	bh=Pb6CjgFWFaDZF9kz5bVOMmtGR7ocfNaU1WEMe8YXLSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OM6j9IAqNmrbFpnpN7u4XRtl6lkKKpOYa2+PR8rLCBxFieA29fvfCsc9WSlUvgdU2lvNHWgoaeXQtVJo9OTx+st+Pya2Jlhs5ZOlJ+5QInPl2wzwyz/ZdedsnI8dQhTVg5uv+PPjyFKqM+cUeeG0AaBQentPu1G28xOKUjeAR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FikgegVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FikgegVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D361F000E9;
	Wed, 29 Jul 2026 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785326819;
	bh=233Jc8J7a7K8nCIFmofJ8j2e8nUuIHPyi39MzwArGLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FikgegVathHRH9aIjBQNJmN04xWnaRPUPVmapdLE7O0WsgO/DLcGHJSCm/p69Ej00
	 f8JasWcHIGtmgrq/ZzzkE5xFVk8GO4RYrvyvz651Q125i0x7cyPRrUE4bVSovY6d2i
	 5NfGaOzwKBikpLS48KOruGALL81bqQnUo29ItWZ7Dk0z2s1FPikPBM17lTjpRyP7DA
	 t9gflq5HUtMtJo7ZKYWhEbiibNqP/BXRoQbCYtIKa+kUoPuUYZrQjJbm4+s1vXQYzi
	 F3joWTtsh90YW6RF5126U46rw2g4AmX2iDZCEgBRrdejLMcASlbUQ0wta4LoxICJrJ
	 D3kx0CNLJpu+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/1] s390/zcrypt: Fix buffer over-read in
 cca_cipher2protkey
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260729114009.187946-2-freude@linux.ibm.com>
References: <20260729114009.187946-1-freude@linux.ibm.com>
 <20260729114009.187946-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:06:59 +0000
Message-Id: <20260729120659.A1D361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unbounded token length allows heap buffer overflow in `cca_cip=
her2protkey` and `cca_ecc2protkey` when building CPRB requests.
- [High] Unvalidated firmware-provided length in `cca_gencipherkey` can lea=
d to a massive out-of-bounds read and memory leak to user-space.
- [High] Unbounded `t->len` in `_ip_cprb_helper` can cause a heap buffer ov=
erflow when copying a response from the crypto card.
--

--- Patch [1]: [PATCH v4 1/1] s390/zcrypt: Fix buffer over-read in cca_ciph=
er2protkey ---
commit df110319f8dcc4a61962c0699f5ad1038f1b9085
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Fix buffer over-read in cca_cipher2protkey

This commit adds validation of the actual key buffer size and token length
fields in the cca_check_sec*token functions. It prevents buffer over-reads
and under-runs that could lead to kernel crashes or memory exposure.

> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/z=
crypt_ccamisc.c
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
[ ... ]
> @@ -936,23 +975,28 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 ke=
ybitsize, u32 keygenflags,
>  	}
> =20
>  	/* and some checks on the generated key */
> +	t =3D (struct cipherkeytoken *)prepparm->kb.tlv1.gen_key;
> +	if (prepparm->kb.tlv1.len < 2 * sizeof(uint16_t) + sizeof(*t)) {
> +		rc =3D -EIO;
> +		goto out;
> +	}
> +	keybuflen =3D prepparm->kb.tlv1.len - 2 * sizeof(uint16_t);
>  	rc =3D cca_check_secaescipherkey(zcrypt_dbf_info, DBF_ERR,
>  				       prepparm->kb.tlv1.gen_key,
> -				       keybitsize, 1);
> +				       keybuflen, keybitsize, 1);
>  	if (rc) {
>  		rc =3D -EIO;
>  		goto out;
>  	}
> =20
>  	/* copy the generated vlsc key token */
> -	t =3D (struct cipherkeytoken *)prepparm->kb.tlv1.gen_key;
>  	if (keybuf) {
> -		if (*keybufsize >=3D t->len)
> -			memcpy(keybuf, t, t->len);
> +		if (*keybufsize >=3D keybuflen)
> +			memcpy(keybuf, t, keybuflen);

[Severity: High]
This isn't a bug introduced by this patch, but can an unvalidated firmware
response lead to an out-of-bounds read here?

The hardware returns a response containing a tlv1.len field which is
used to calculate keybuflen. If a compromised or buggy crypto card firmware
sets an abnormally large tlv1.len, does this memcpy read past the 512-byte
parameter block into adjacent kernel heap memory and leak it to userspace?

Could we add a bounds check against the 512-byte allocation limit before
performing the memcpy?

>  		else
>  			rc =3D -EINVAL;
>  	}
> -	*keybufsize =3D t->len;
> +	*keybufsize =3D keybuflen;
> =20
>  out:

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential regression involving
buffer overflows in cca_cipher2protkey and cca_ecc2protkey when building
request blocks.

In cca_cipher2protkey, if a user issues an ioctl providing a malicious token
with a large len field, does this overwrite the 512-byte buffer?

drivers/s390/crypto/zcrypt_ccamisc.c:cca_cipher2protkey() {
    ...
    preqparm->kb.len =3D keytoklen + 3 * sizeof(uint16_t);
    preqparm->kb.cca_key_token_len =3D keytoklen + 2 * sizeof(uint16_t);
    memcpy(preqparm->kb.cca_key_token, ckey, keytoklen);
    ...
}

The cca_check_secaescipherkey function ensures t->len is less than or equal
to keysize, where keysize is the user-provided size that can be up to
8192 bytes. If keytoklen is larger than the 512-byte limit, could this memc=
py
overwrite the allocation?

A similar pattern exists in cca_ecc2protkey:

drivers/s390/crypto/zcrypt_ccamisc.c:cca_ecc2protkey() {
    ...
    preqparm->kb.len =3D keylen + 3 * sizeof(uint16_t);
    preqparm->kb.cca_key_token_len =3D keylen + 2 * sizeof(uint16_t);
    memcpy(preqparm->kb.cca_key_token, key, keylen);
    ...
}

[Severity: High]
This is also a pre-existing issue, but I observed a similar unbounded length
usage in _ip_cprb_helper that might cause an out-of-bounds read and write.

When copying a response from the crypto card, the t->len field is trusted
directly from the hardware:

drivers/s390/crypto/zcrypt_ccamisc.c:_ip_cprb_helper() {
    ...
    t =3D (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
    memcpy(key_token, t, t->len);
    *key_token_size =3D t->len;
    ...
}

If the hardware provides a malformed response with a large t->len, does this
memcpy read out-of-bounds from the 512-byte parameter block?

Additionally, if this corrupted length is returned to cca_clr2cipherkey,
could it be used to write back into a new 512-byte request block and cause
another overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729114009.1879=
46-2-freude@linux.ibm.com?part=3D1
