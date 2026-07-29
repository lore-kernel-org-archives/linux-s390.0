Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F503D4112
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319102; cv=none; b=gnJBwdhRZDadmPl3s6/TVi+O4p2Ws3hyyybxh9mcuyvNg8kkBTKMxvojl25RhocGPqrMxblZJ7zB7A7lhEQSThf7CAR4c4CqjLKZffFkoNJrKAxK7hFBJHzTu8AkVk5huw7Cbjztx6Z3+N+ooxzLRj2Jr34E0BZ1bKflx6u41BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319102; c=relaxed/simple;
	bh=r1bpo1IigwrO+vMBI/UofhNeo6XRx7vTQ9wU/Ha44YY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GAGF27m+emAW+A4i7nNjanNkBcNqQ/ooI3afgOAeIP4W6sLXEKCdFDQXFo3/B/LiQ9MciFsNfk7blkh9ItIJJKkVNuiAw/6rK4Pf/amhu7N/qXIhKEteV7RJbJmAZFkN7G1C8TVJn93iGm0btdGxUO/Q/abxGAYCfW0FLl6zwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YacjjEui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YacjjEui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE5D1F000E9;
	Wed, 29 Jul 2026 09:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785319101;
	bh=zbq1aQ6N4TaiEnw9FYYoeFrfPcGOc5PJVcq5cOd8yXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YacjjEuiZa2eupjv6iwFNoU9ECMrjvrfLi6wOWs25d1FaFLpyklRoqSvbfP9gJdQu
	 d5VQQR7BJwUJyfadSSAwpi055kHAY7RPVKgQj1qn1Fyzm4ipsAP2QqVMmtp8arm1i0
	 tpnOCS/RQY8l71gLSkhT1I7pXZ+25zc9Y0TobSUMHCYRt4E2bfTWkXpZmuse0VbzEy
	 7bAZahQFHOZ9zm5rz1mgxEHWg7N6614ZgCkmPXrLfqDDtht+3bv5Jy94d1DkHAJ452
	 nU53f/HNTaOKW9JGgO1R1mupqZw4+Cq8Ugxmt9RlBETmveswj1BNrcvlqmKUD9jyJO
	 P53c+gNxr9F7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] s390/zcrypt: Validate length for CCA AES cipher
 key requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Holger Dengler" <dengler@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260729093616.4184642-2-dengler@linux.ibm.com>
References: <20260729093616.4184642-1-dengler@linux.ibm.com>
 <20260729093616.4184642-2-dengler@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 09:58:20 +0000
Message-Id: <20260729095821.1DE5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Heap buffer overflow in `cca_ecc2protkey` when copying a user-=
provided ECC key token into a fixed-size buffer.
--

--- Patch [1]: [PATCH v1 1/2] s390/zcrypt: Validate length for CCA AES ciph=
er key requests ---
commit 7b35c8aa05e7fb7c7837b88e5f3b7fc85f721c98
Author: Holger Dengler <dengler@linux.ibm.com>

s390/zcrypt: Validate length for CCA AES cipher key requests

This commit adds a bounds check in cca_cipher2protkey() to ensure the copy
length derived from the key token does not exceed the available space in the
CPRB parameter block. If the length is too large, the request is rejected
early with -EINVAL.

> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/z=
crypt_ccamisc.c
> index 84936a795b956..db6a4211a97e0 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> @@ -1261,6 +1261,9 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, cons=
t u8 *ckey,
>  	} __packed * prepparm;
>  	int keytoklen =3D ((struct cipherkeytoken *)ckey)->len;
> =20
> +	if (keytoklen > PARMBSIZE - sizeof(struct aureqparm))
> +		return -EINVAL;
> +

[Severity: Critical]
This is a pre-existing issue, but does a similar heap buffer overflow exist=
 in
cca_ecc2protkey()?

It appears cca_ecc2protkey() also copies a user-provided ECC key token into=
 a
fixed-size buffer without a similar bounds check. A user with access to
/dev/pkey could call the PKEY_KBLOB2PROTK2 ioctl, passing an
eccprivkeytoken with a large len field.

This would be passed down through cca_key2protkey() to cca_ecc2protkey(),
where it allocates a 512-byte parameter block via
alloc_and_prep_cprbmem() and copies the token:

drivers/s390/crypto/zcrypt_ccamisc.c:cca_ecc2protkey() {
    ...
	int keylen =3D ((struct eccprivkeytoken *)key)->len;

	/* get already prepared memory for 2 cprbs with param block each */
	rc =3D alloc_and_prep_cprbmem(PARMBSIZE, &mem,
				    &preqcblk, &prepcblk, xflags);
    ...
	/* kb, cca token */
	preqparm->kb.len =3D keylen + 3 * sizeof(uint16_t);
	preqparm->kb.cca_key_token_len =3D keylen + 2 * sizeof(uint16_t);
	memcpy(preqparm->kb.cca_key_token, key, keylen);
    ...
}

Since the parameter block header consumes 90 bytes, any keylen > 422 bytes
could overflow the allocated memory. Is a similar check needed there?

>  	/* get already prepared memory for 2 cprbs with param block each */
>  	rc =3D alloc_and_prep_cprbmem(PARMBSIZE, &mem,
>  				    &preqcblk, &prepcblk, xflags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729093616.4184=
642-1-dengler@linux.ibm.com?part=3D1
