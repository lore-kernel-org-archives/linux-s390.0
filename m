Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753237DEBE
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787242070; cv=none; b=Mz9rnWhD64qKwzSPPhGcrNpYqFBUzXOqVD+OagQ/a+kGecYZ5c4xk8tlTHCyS23bE4j0Rh7B/7PLCiyquOhE4Zig97KNM+46bZn/+gvJoJQLGg55avcgbkGQF3UkBXAG3AirnmwMKIpzB8QXTUQSJrnCCIJQq5yjfWIK74fhJsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787242070; c=relaxed/simple;
	bh=oPyg5lYQ1i5GgmIiJifc9n+kWrwvIP6CZDFqWe3EYoY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G4o3diaKV/wKs4hBwpWYf3rzhYWca30AIliHafo9RoD2RpN9CstkoguTxRuae2M6x4x9NJAYMBcLmQuRCOjPV+C4yj358w49FOrxOPBytYoW5R1KhSH914WCO1oVNCc06MG/w1svKA/lKEbFzdTmk7u9uQTIhaZO8P5zrMZZooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzLDQfXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzLDQfXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EF51F000E9;
	Thu, 20 Aug 2026 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787242069;
	bh=2bFlTQ9t1sSRaMYTWNaXiWvSJ+R9HwH5ADrtvQ4sW04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gzLDQfXGRtkoYigR73KLnhDeTwBW7nRd1TPMYC22WxtfsTquMhIrIu+exF9dC9xAR
	 EuU9NeVUy2mORaGBX7L6nP0mw86IVg02k1OkE9nlBVKXXW5F66ITZ6zF70MeZ699fL
	 cp2fywvVpvOP0IXeqjnat0F/tT4AD6MzUL+bDRLza/RdnwVJLt/fo7CCcOofxnzcXL
	 ixI/TAREwWz4+/oJHh+hOpyEhyl8yqg9G5uC6H0dJPaUS4ygt08SpgiiqlEWHu3NfR
	 CwcvhxlNAnPTz/PnJXwqMxD30TwpJhhOKtZgQhC9FnpFLidCkDly1OW4cmvNimS7gg
	 qjjwrZFo1dS3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] s390/zcrypt: Validate length in reply before
 using it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Holger Dengler" <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260820155003.945837-2-dengler@linux.ibm.com>
References: <20260820155003.945837-1-dengler@linux.ibm.com>
 <20260820155003.945837-2-dengler@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 16:07:48 +0000
Message-Id: <20260820160749.42EF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing upper bounds check on `prepparm->kb.tlv1.len` in `cca_genc=
ipherkey` allows massive kernel memory leak.
- [High] Unvalidated array lengths in `cca_query_crypto_facility` can cause=
 out-of-bounds pointer arithmetic and memory accesses.
--

--- Patch [1]: [PATCH v2 1/1] s390/zcrypt: Validate length in reply before =
using it ---
commit eab8ad18f4433da6c81f9cb5f87967a1dc92a89b
Author: Holger Dengler <dengler@linux.ibm.com>

    s390/zcrypt: Validate length in reply before using it

This patch addresses a potential buffer over-read and over-write in
_ip_cprb_helper() by validating the key token length in the CPRB reply
against the previously validated parameter block length.

> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/z=
crypt_ccamisc.c
> index d4ce6352b5b2e..19909bf43dc91 100644
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
> +	 * Validate t->len by comparing it with the length information in the
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

[Severity: High]
This isn't a bug introduced by this patch, but since we are fixing reply
length validations here, does cca_gencipherkey() have a similar missing
upper bounds check?

In drivers/s390/crypto/zcrypt_ccamisc.c:cca_gencipherkey():

	keybuflen =3D prepparm->kb.tlv1.len - 2 * sizeof(uint16_t);
	rc =3D cca_check_secaescipherkey(zcrypt_dbf_info, DBF_ERR,
				       prepparm->kb.tlv1.gen_key,
				       keybuflen, keybitsize, 1);
	// ...
	if (keybuf) {
		if (*keybufsize >=3D keybuflen)
			memcpy(keybuf, t, keybuflen);

The prepparm->kb.tlv1.len field comes from the device reply. It is checked =
for
a minimum bound, but it doesn't seem to be checked against the total parame=
ter
block size. Could a corrupted or malfunctioning hardware crypto adapter (or=
 a
spoofed virtual device) return a valid kb.len but a forged large tlv1.len?

If so, could this unbounded length drive an out-of-bounds memcpy() read from
the cprbmem allocation into keybuf, potentially leaking unrelated kernel da=
ta
to userspace?


[Severity: High]
This is a pre-existing issue, but I see another area where unvalidated
reply lengths might cause memory access issues.

In drivers/s390/crypto/zcrypt_ccamisc.c:cca_query_crypto_facility():

		ptr +=3D len;
	}
	/* check and possible copy reply var array */
	len =3D *((u16 *)ptr);

The untrusted len is added directly to ptr without bounds validation. If a
malicious or malfunctioning crypto adapter returns a CPRB reply payload with
a very large len field (e.g., 65535) for the rule or variable array, wouldn=
't
the subsequent dereference read from an unvalidated memory location?

Could this out-of-bounds pointer arithmetic and memory access trigger a
kernel panic via a page fault on unmapped memory?

>  	memcpy(key_token, t, t->len);
>  	*key_token_size =3D t->len;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820155003.9458=
37-1-dengler@linux.ibm.com?part=3D1
