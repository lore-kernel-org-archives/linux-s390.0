Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5240411A1F
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342958; cv=none; b=b2wP8IFraw8+UeRx6PFlW69XWjM704KXxk/8fyAGPZXR44WX+Ap8cKinuEnruwtB+STSZmRgDigcRNwfSoPo8MIBmPpi4njSw4UyAa8Trjyu+PKlkQGdy8/Z/omh1jNkV9HOfEyE3HiwG5PTKAufljSXc0W1jkVvib/A9Hi/uTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342958; c=relaxed/simple;
	bh=hiGlfocsYTIz87CcCyn1pt9kJRegEQv7kSdf4PPusz0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Exhwu/K/iExH0rvj3T6l7UC3CSVkmstxKGxWwU80bANHgtu6vJmQDmIlDn9GmvA1LZs7nIwmcQsvb9MxVnAs8dRryOtO8o84Kjh6bpQWRHa3QBCSufm4Wtbv0pj/8Wv7qgWx4579Cle42UR5VW2Mc9OQrzb5n0So+siNOWKZiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFFrmvF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFFrmvF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F272B1F000E9;
	Wed, 29 Jul 2026 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342957;
	bh=o+36L4Aos88AiqQzCI+Xen9sjMl48w2dpjOP6CbnQd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TFFrmvF6i+i90Wtl9W0rLpmOdimCoNevZcgWVQar26M8sPojtyoRVI5nIWC6e/8Gf
	 C8OpMcvatc9UsxN24VQEACD+mrkZvkEaKtOGuiv/XlGsnhPuU+fSIJ/xc2cU9VwjUn
	 vbkdA+7BV0sOe/pAho5U6J7Gn5liR1IjIyW45vea5kL44UgH1pyQuRikfapwS2c8Bd
	 PxxPOUqW4DrqdWUh3rY+jkMCsYThoFv6Vdr3PqXFdY5o9FakJxgYtmjNdt77EyM7kG
	 rNTUdPUeHnaK8vil7zX5YN6+BQ7hnX7A7OkE/jrqb6mTjPQ9973Uh4mdxfkjJEvmYo
	 pgKeK7MT21Jzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/5] s390/zcrypt: Improve EP11 CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260729154458.195135-4-freude@linux.ibm.com>
References: <20260729154458.195135-1-freude@linux.ibm.com>
 <20260729154458.195135-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:35:56 +0000
Message-Id: <20260729163556.F272B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The `asn1_int_decode` function casts potentially unaligned byte po=
inters to `u16 *` and `u32 *`, invoking undefined behavior.

Pre-existing issues:
- [Critical] The patch updates `xcrb_msg_to_type6_ep11cprb_msgx()` to flexi=
bly parse ASN.1 payloads but leaves the legacy fixed C-struct overlay (`str=
uct pld_hdr`) in `zcrypt_msgtype6_send_ep11_cprb()` untouched, allowing dom=
ain isolation to be bypassed.
--

--- Patch [3]: [PATCH v9 3/5] s390/zcrypt: Improve EP11 CPRB length and ove=
rflow checks ---
commit ea4312469ba49e7cc43bf68e3a1d383e305d99b5
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve EP11 CPRB length and overflow checks

The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
validation, creating security vulnerabilities:
1. Missing minimum size validation: The ep11_cprb structure and
   subsequent payload fields (pld_tag, pld_lenfmt) are copied from
   userspace without verifying sufficient buffer length.
2. Arithmetic overflow in length calculations: CEIL4 alignment could
   overflow, bypassing size checks and enabling buffer overflows.
3. The payload is asn1 encoded but the function just uses a simple c
   struct overlay to access some fields of the payload.

Fix by using size_t for length calculations, adding U32_MAX boundary
checks after alignment, and validating minimum request size and
minimum reply size before copying from userspace. Do a very simple
asn1 parsing of the payload up to the function value field.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index fb37e28c82424..c4b5d9b85f7a9 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -439,12 +439,61 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspac=
e, struct ap_message *ap_msg,
>  	return 0;
>  }
> =20
> +/*
> + * Simple asn1 int reader/decoder helper function
> + * Returns number of bytes processed or < 0 on failure
> + * Only accepts int length values of 1, 2 or 4.
> + */
> +static inline int asn1_int_decode(const u8 *buf, size_t intlen, u32 *u)
> +{
> +	switch (intlen) {
> +	case 1:
> +		*u =3D (u32)(*((u8 *)buf));
> +		return 1;
> +	case 2:
> +		*u =3D (u32)be16_to_cpup((u16 *)buf);

[Severity: High]
Does this code trigger undefined behavior?

The buf parameter points to an arbitrary offset within an ASN.1 encoded
payload in xcrb_msg_to_type6_ep11cprb_msgx(), which is not guaranteed to
be 2-byte aligned. Casting this unaligned u8 * to u16 * and passing it to
be16_to_cpup() violates C strict alignment rules.

While s390 hardware generally supports scalar unaligned accesses, the
compiler may assume u16 * is properly aligned and emit instructions that
strictly require alignment, potentially causing a kernel panic when parsing
untrusted payloads.

> +		return 2;
> +	case 4:
> +		*u =3D (u32)be32_to_cpup((u32 *)buf);

[Severity: High]
Does this code also trigger undefined behavior for 4-byte values?

Similar to the 2-byte case above, this casts a potentially unaligned byte
pointer to a u32 *, which could cause an Oops if the compiler emits
alignment-strict instructions.

> +		return 4;
> +	default:
> +		return -EINVAL;
> +	}
> +}

[ ... ]

> -	struct pld_hdr {
> -		unsigned char	func_tag;	/* fixed value 0x4 */
> -		unsigned char	func_len;	/* fixed value 0x4 */
> -		unsigned int	func_val;	/* function ID	   */
> -		unsigned char	dom_tag;	/* fixed value 0x4 */
> -		unsigned char	dom_len;	/* fixed value 0x4 */
> -		unsigned int	dom_val;	/* domain id	   */
> -	} __packed * payload_hdr =3D NULL;
> -

[Severity: Critical]
This is a pre-existing issue, but this patch updates
xcrb_msg_to_type6_ep11cprb_msgx() to parse ASN.1 payloads dynamically,
while leaving the legacy fixed C-struct overlay (struct pld_hdr) untouched
in zcrypt_msgtype6_send_ep11_cprb().

Does this allow the cryptographic domain isolation to be bypassed?

The kernel enforces crypto domain isolation by overwriting the dom_val field
in the user-provided EP11 payload with the queue's domain:

drivers/s390/crypto/zcrypt_msgtype6.c:zcrypt_msgtype6_send_ep11_cprb() {
    ...
    payload_hdr =3D (struct pld_hdr *)((&msg->pld_lenfmt) + lfmt);
    payload_hdr->dom_val =3D AP_QID_QUEUE(zq->queue->qid);
    ...
}

Because this still uses the hardcoded C-struct which assumes func_val is
exactly 4 bytes, what happens if an unprivileged user crafts an ASN.1
payload where the function ID is encoded in 1 or 2 bytes?

It appears the actual dom_val would be shifted earlier in the payload, and
the kernel would overwrite the wrong bytes at a fixed offset, leaving the
user-controlled domain ID unmodified. This seems to allow an attacker to
execute crypto commands against unauthorized domains.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729154458.1951=
35-1-freude@linux.ibm.com?part=3D3
