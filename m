Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE9143F097
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421754; cv=none; b=OS46B4ZQY21UXrz6rM8d/kjeJcbk4WpIjaXi9ZTKELyvyb9gJnVnVkdF+87m26HQbHhbOWkZxg3jRs0ZVohB1lr/UvUNAphdB7yQEh7rkPb7fhwHlU8+Bp4lcRyiGNI1oz4U0nhjCxTmETzl8d+BEPwxISQDDzmUhZQhK8L/q6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421754; c=relaxed/simple;
	bh=iaI/kc3evdybYWOQqiBjHb2+i3mo+OwfiwfmANr+G7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CF3my7sdUsp1iq8sSYYpAIeTkUmhUmG4OLgrhGU0e+uRdlkxC0GTcFiYPuvnEvwZqyIFX8i6nhdec4+193gMOZGQ45wJ/9mAbP/plbRj5jtuQfB+wLunhzJxBDOyM09XRMb8JPKJ18wj5p7w2Mw0FnRFYothXreH2YmbvV2ZlwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec3E9j9S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec3E9j9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A361F000E9;
	Thu, 30 Jul 2026 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785421753;
	bh=Wag8N4hTWbun5NFYAynUseV8tZbG+YBfQk65Erz5J2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ec3E9j9SvM0f34svXW76NzdjGLYoys9ZRo25nYrhrvDFKKzJc2kHlpnB+ZLFBf/6A
	 yAukvad7PvtZ1Ey2zomi87TCcV60P8Zq2x4e4se+9ySDAbuQl+WATmksaOHQw25ZVz
	 JYzgod8AyBscE2SGUmbIrh1CQ4jAAHgPk6lVoAsZXoj/gYPnRA9WHm4zRmMngkQXN2
	 Fg541i7r6EO3ytkPYpQNTrzBYVqM0ofqNLC5rWYyVTIMJe6vS/wGNYMsd+AK1swnXE
	 tsJnFYUDOiSxMxHN7u1BZGfM7sXOb2vO8M3NOARFn4ykTu8mYrrhPWD9Kki7R7MRtf
	 JTc4jOra2we+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/5] s390/zcrypt: Improve EP11 CPRB domain handling
 with ASN.1 parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260730141509.205970-5-freude@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
 <20260730141509.205970-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 14:29:12 +0000
Message-Id: <20260730142912.C6A361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] An off-by-one error in bounds checking allows a 1-byte out-of-boun=
ds read when parsing the ASN.1 function tag.
--

--- Patch [4]: [PATCH v10 4/5] s390/zcrypt: Improve EP11 CPRB domain handli=
ng with ASN.1 parsing ---
commit 195849014f55379e7fe6dcd2f7156dd9744b4047
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing

This commit replaces struct overlays in EP11 CPRB domain handling with
explicit ASN.1 parsing to improve security and maintainability. It adds
bounds checking and a new helper function for safe integer encoding.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c

[ ... ]

> @@ -1239,51 +1261,94 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool u=
serspace, struct zcrypt_queue *

[ ... ]

> +		/* payload tag */
> +		if (pld[offs++] !=3D 0x30)
> +			return -EINVAL;
> +		/* payload length field */
> +		i =3D asn1_length_decode(pld + offs, pld_len - offs, &u);
> +		if (i < 0)
> +			return -EINVAL;
> +		offs +=3D i;
> +		if (offs > pld_len || u > pld_len - offs)
> +			return -EINVAL;

[Severity: High]
Does this allow a 1-byte out-of-bounds read of the pld buffer if the ASN.1
payload length field uses a multi-byte encoding that exactly consumes the
remaining pld_len bytes?

If offs exactly equals pld_len, the bounds check offs > pld_len will evalua=
te
to false. If u is 0, u > pld_len - offs becomes 0 > 0, which is also false.

> +		/* function tag */
> +		if (pld[offs++] !=3D 0x04)

The code would then proceed to read pld[offs++], reading one byte past the
end of the pld buffer.

Should this bounds check use >=3D instead?

if (offs >=3D pld_len || u > pld_len - offs)

Additionally, looking at xcrb_msg_to_type6_ep11cprb_msgx() in the same file:

	/* payload length field */
	i =3D asn1_length_decode(pld + offs, pld_len - offs, &u);
	if (i < 0)
		return -EINVAL;
	offs +=3D i;
	if (offs > pld_len || u > pld_len - offs)
		return -EINVAL;
	/* function tag */
	if (pld[offs++] !=3D 0x04)

This is a pre-existing issue, but does it suffer from the identical bounds
checking flaw?

> +			return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730141509.2059=
70-1-freude@linux.ibm.com?part=3D4
