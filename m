Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1C46D54A
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235648; cv=none; b=G0l3sjnK16KLru9UQ2EYUFJxTgzA6ub/bBqJlkcse6Q77KWK2z+1JslCe/7/kaNcqkh8HaUZs0ioopONv10QEckXZuLoFjnbYNpelnOoT0e5rjj+16w0G0ThR3bcJpXTazWjT0VbGWk/z8p0YffaRAfspO8i60eTShoN9ZqqOxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235648; c=relaxed/simple;
	bh=hjkSmNF/dRTpU/5xT17Xsm0DTpOoXvb66O6U3xy5xyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OId+oD3ddmE59FqB5hsJfAnGlLwAYe5KGFVfAwO3S9bbf6yY5jNTdeBsQOSypUio0DLRFinnTaeHi1mfBG1aoMDHeY+1gyAZZNwKPlvaEoNBWpfC9ExG/7HrfcpIv2Gphlr7VJnx6H1qKb3cOkTriFYQaE4sXL5knxw9GTidv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rvicwre6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rvicwre6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40931F000E9;
	Thu, 20 Aug 2026 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787235644;
	bh=qLDBFmSOw3rtC/+1xkLaH8rI7OmFKOEnGY7FtUoyTAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rvicwre6oX8VLR4E+qN1hYdC40B5ZEvu/xoA1G/mFxxcFTAP6dBYP8yAgDNPxt4j3
	 w7+Wg4f1CbM0jDM6cci8wCZ9KzuScBpt5xRrI+TJ8bt8CSzAbZVGTNuLkAmUMnt9Vr
	 PYazZAAW3b3G+L4iD/fA3mtsUAje4ViT+ASSmLWWqSVD8fODeidkw2cmVsmAf9oRQ6
	 /gtOZcZAvjC0xxYw+gZFgaKwMbZQ92yAr6k0dpKF2WTEnJoAxmedwZp4DIz7U0+h+z
	 l+1sLiF3d8Ey5xTTLndaiLil/4MyUo5Ooc3xy+SQv7eEFdAcP9rd2jKfnP/MZnl9FP
	 kuROZodt+tM3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] s390/zcrypt: Validate length in reply before
 using it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Holger Dengler" <dengler@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260820140439.892324-2-dengler@linux.ibm.com>
References: <20260820140439.892324-1-dengler@linux.ibm.com>
 <20260820140439.892324-2-dengler@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:20:43 +0000
Message-Id: <20260820142043.F40931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes an out-of-bounds read in `_ip_cprb_helper()` but m=
isses identical vulnerabilities in `cca_gencipherkey()` and `_ep11_genaeske=
y()`.
- [High] Unvalidated length fields in the CPRBX response payload are used t=
o advance a memory pointer, causing severe out-of-bounds reads in `cca_quer=
y_crypto_facility()`.
--

--- Patch [1]: [PATCH v1 1/1] s390/zcrypt: Validate length in reply before =
using it ---
commit 3fcaad86f04a2a9419691d5f1a54cc873f326675
Author: Holger Dengler <dengler@linux.ibm.com>

s390/zcrypt: Validate length in reply before using it

The length information in the reply is used to copy the key token to
the target buffer. An invalid information in t->len of the reply may
cause an over-read of the target buffer and also a over-write of the
target buffer. To prevent that, check t->len before using it.

> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/z=
crypt_ccamisc.c
> index d4ce6352b5b2e..54b8edd1dfc74 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> @@ -1158,8 +1158,21 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
> =20
>  	/* do not check the key here, it may be incomplete */
> =20
> -	/* copy the vlsc key token back */
> +	/*
> +	 * Copy the vlsc key token back.
> +	 * The available space in the destination (key_token) and the source
> +	 * (t) buffer is always larger as the valid range of prepparm->kb.len.
> +	 * Validate t->len ba comparing it with the length information in the
> +	 * param block of the request (prepparm->kb.len)
> +	 * The value range of prepparm->kb.len has been checked above.
> +	 */
>  	t =3D (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
> +	if (t->len !=3D prepparm->kb.len - 3 * sizeof(uint16_t)) {
> +		ZCRYPT_DBF_ERR("%s reply with invalid key_token length %u\n",
> +			       __func__, t->len);
> +		rc =3D -EIO;
> +		goto out;
> +	}
>  	memcpy(key_token, t, t->len);
>  	*key_token_size =3D t->len;

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing the
unvalidated length field from the device reply here, should similar validat=
ion
be added to cca_gencipherkey() and _ep11_genaeskey()?

In drivers/s390/crypto/zcrypt_ccamisc.c:cca_gencipherkey(), the code reads
the generated token length directly from the untrusted reply and calculates
the copy length without checking bounds against the structure size:

    keybuflen =3D prepparm->kb.tlv1.len - 2 * sizeof(uint16_t);
    ...
    if (keybuf) {
        if (*keybufsize >=3D keybuflen)
            memcpy(keybuf, t, keybuflen);

Could a malicious or compromised device return an inflated length, causing
memcpy() to read thousands of bytes out-of-bounds from the cprbmem
allocation and potentially leak kernel memory to userspace?

A similar unvalidated copy appears in
drivers/s390/crypto/zcrypt_ep11misc.c:_ep11_genaeskey(), which relies entir=
ely
on the untrusted device data length:

    memcpy(keybuf, rep_pl->data, rep_pl->data_len);

[Severity: High]
This is a pre-existing issue, but does a similar vulnerability exist in
drivers/s390/crypto/zcrypt_ccamisc.c:cca_query_crypto_facility() where the
unvalidated length field is used to advance a memory pointer?

In that function, the code blindly advances ptr using an unchecked length
provided by the device payload:

    len =3D *((u16 *)ptr);
    if (len > sizeof(u16)) {
        ...
        ptr +=3D len;
    }

If the hardware returns a corrupt or malicious length, could ptr advance
far beyond the cprbmem buffer bounds, leading to an out-of-bounds dereferen=
ce
on the next iteration or exposing arbitrary kernel memory during the
subsequent memcpy()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820140439.8923=
24-2-dengler@linux.ibm.com?part=3D1
