Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F644C77D0
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336619; cv=none; b=kOZzaDpQQ+xQ0z5QAvZfavHUEkRJDZGZQMtPKpRSL8E9HqKtngFXZXqCgJNZnyvkoYUq2lZt6ed4wy8zNLqK+F1DoEsYoUNxBxz7w9pKHPgNj8WmfNjw0kjhCQkBX+JekVhHP4qje+Edi8NfYvqzDvCjAeXqOYVx72aRHg5QAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336619; c=relaxed/simple;
	bh=tj6NeZ9VeCAmVyZvCaQH5qFkfoLVPYwv0RahJ5B9c/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gaNaHe6x9NsAjvm0AVx1ul16y30Df/Tsy59vRrTMCRlJxF7AakcAj2y/3Y8X3uOBI8hsII+ESNXUOuodvthz/P/W7pEbMgHj99gUqygE5HXD48OQl3awm9LmwkT5o9zyGN8z0wM22tTAhS2rYCh3pgDWOk3J+Iihtlz+VGP+YXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1+LRtRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1+LRtRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7061F00A3A;
	Wed, 29 Jul 2026 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336617;
	bh=J6Mg3CiMBUvJcO8vE7YR527UQaudF6TSvWy1L4ZVTAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I1+LRtRlKhUN+zNqwyq1jeOPpPKsjojVZeEUCe93NuztVBAGQt1twkahwIsDHuq1p
	 maQM5NSwuYAdm6an5kLnvuq9GQiMenogEu0lD2bPwZar8lzu/wUBhmuUn4bfxvBZjp
	 M1loDdLC/Q+XIaDK4er/QIGLKCodFWpa/doTTPxq716f2rkSOOM8RrOx/VXCaUX+fr
	 pXw1hK64Kn797Ssi8e81aeC3KYKEmbpiTsb36qRRngVp5Ba70SgQjyruy+OWJFsOTx
	 /5nld0gL3cpnM1aPo125FnpjxUCkfUdBERIV/deMAowHFwErcF550zYbYBICd+wlUj
	 6kIfVa+SAhrUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] s390/zcrypt: Improve EP11 CPRB domain handling
 with ASN.1 parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260729143928.191969-5-freude@linux.ibm.com>
References: <20260729143928.191969-1-freude@linux.ibm.com>
 <20260729143928.191969-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 14:50:16 +0000
Message-Id: <20260729145016.EB7061F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Undefined behavior due to unaligned memory access via direct poi=
nter casting.
--

--- Patch [4]: [PATCH v8 4/5] s390/zcrypt: Improve EP11 CPRB domain handlin=
g with ASN.1 parsing ---
commit 78d69567226ac24ed3207a9812dbc20b238a13e1
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing

This commit replaces struct overlays with explicit ASN.1 parsing for
EP11 CPRB payload domain fields, adding validation and a new helper
function for safely encoding integer values.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index c4b5d9b85f7a9..59e182d1bddf9 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -1223,6 +1223,28 @@ int prep_ep11_ap_msg(bool userspace, struct ep11_u=
rb *xcrb,
>  					       func_code, domain);
>  }
> =20
> +/*
> + * Simple asn1 int writer/encoder helper function
> + * Returns number of bytes processed or < 0 on failure
> + * Only accepts int length values of 1, 2 or 4.
> + */
> +static inline int asn1_int_encode(u8 *buf, size_t intlen, u32 u)
> +{
> +	switch (intlen) {
> +	case 1:
> +		*((u8 *)buf) =3D (u8)u;
> +		return 1;
> +	case 2:
> +		*((u16 *)buf) =3D cpu_to_be16(u);

[Severity: Medium]
Could this lead to unaligned memory accesses?

When asn1_int_encode() is called from zcrypt_msgtype6_send_ep11_cprb()
using pld + offs, the offset is dynamically calculated from variable length
ASN.1 tags and lengths, which may leave the buf pointer unaligned.

While s390 hardware handles unaligned accesses, directly casting a potentia=
lly
unaligned u8 pointer to u16* could violate C standard alignment rules and
potentially lead to compiler misoptimization. Would it be safer to use
put_unaligned_be16() here?

> +		return 2;
> +	case 4:
> +		*((u32 *)buf) =3D cpu_to_be32(u);

[Severity: Medium]
Similarly, should this use put_unaligned_be32() instead of a direct cast
to u32* for the same unaligned pointer reasons?

> +		return 4;
> +	default:
> +		return -EINVAL;
> +	}
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729143928.1919=
69-1-freude@linux.ibm.com?part=3D4
