Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB404B8DF8
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334343; cv=none; b=kjGlwNbmCcffOPtV/eKHghGo7w33RdlBrWcC1NFANHtqE4s+bl07uBJ/tgREkTD89ZlK7OwOglqsL/7546RcZjhliLhkHvsV51N6j8ItyBrQQCdOUFoU1sAk1g742WpmyiiQUOD5u11B88Yc0shtefA3jer7k7I8GMTuftOMke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334343; c=relaxed/simple;
	bh=7uAjQVUvHs5ydV7OLVI6D9ZfgG24X+r+U6/IN1t6dJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C4Za5JXuGQzhO/2dAtWmhndCI6F34FD7sd4SS7b/MvvOes3ky2H1cCw4drSYvhUeBTTgepPgkZCr9juEPuon6tbi3KArVaNCRgTTdWdDGfx0UKt5Z+4poejgaHnNQ+aTkN1Miah1hY5JmQLqT6IEy8d6v/i21b2E28OS1R4vqiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enf0A2Qa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enf0A2Qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28071F000E9;
	Wed, 29 Jul 2026 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785334341;
	bh=q86vtpf1a6nID18Mn1WTzOPu9hhDKe+MwOVGXyXq5Zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=enf0A2QarFmNEh4WpyKtU3i25uiI006+in5pERt2M9nmckrBRRuc+lakiwc14Lt6h
	 Qnrg6CrdzESj5uBp7GFKVAgEpAjeI3odCVQu15lvARFCmQoeoaIfYf9LDcxbWI5lIf
	 1txKj1B9zWe2b4YRsm89Fr34NZOeL968bUBcNyfHmYjmptGjPIKRJ/bdsA4D1FrO/a
	 miFYJf0cT9bRXRr2XKaLUP2UXijwIgpiC+DFoG8A37Lme+uTpLYBadURbtDB5dxJMI
	 XTfguGRo8IOSh6UsiT3G4PCXtko36Rp/Sn4cFHhKBp20zw7g8XMHQdmNTKmuYka3L7
	 hTXechUJA5Mig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] s390/zcrypt: Fix missing mem scrub at clear key
 import in cca_clr2cipherkey()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260729140134.191448-2-freude@linux.ibm.com>
References: <20260729140134.191448-1-freude@linux.ibm.com>
 <20260729140134.191448-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 14:12:20 +0000
Message-Id: <20260729141220.E28071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated length field `t->len` from an untrusted hardware respo=
nse leads to severe out-of-bounds memory accesses during `memcpy()`.
--

--- Patch [1]: [PATCH v2 1/1] s390/zcrypt: Fix missing mem scrub at clear k=
ey import in cca_clr2cipherkey() ---
commit 0678dd664c1b50d9a38dff946d27b4823de1e205
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey=
()

This commit adds a parameter to _ip_cprb_helper() to scrub the CPRB buffer=
=20
after processing clear key material. It also adds explicit zeroing of the=20
buffers before freeing them in cca_clr2cipherkey() to prevent sensitive=20
data exposure.

> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/z=
crypt_ccamisc.c
> index 84936a795b956..9cf268efd4abf 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
[ ... ]
> @@ -1111,7 +1112,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
>  	*key_token_size =3D t->len;

[Severity: High]
This is a pre-existing issue, but is it possible for a compromised or
malfunctioning hardware device to return a maliciously crafted response
length in t->len?

In _ip_cprb_helper(), the unvalidated t->len from the hardware response is
directly used as the length for copying just before this line:

	t =3D (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
	memcpy(key_token, t, t->len);
	*key_token_size =3D t->len;

Without bounds checking against the actual buffer size, could this lead to =
an
out-of-bounds read from the device response buffer and an out-of-bounds wri=
te
into the key_token buffer?

Also, on subsequent iterations in cca_clr2cipherkey(), the poisoned
*key_token_size is used to construct the next request:

	preq_key_block->tlv1.len =3D sizeof(preq_key_block->tlv1) + n;
	preq_key_block->tlv1.flag =3D 0x0030;
	memcpy(preq_key_block->tlv1.key_token, key_token, *key_token_size);

Does this cause another unbounded copy into the smaller parameter buffer du=
ring
the next loop iteration?

> =20
>  out:
> -	free_cprbmem(mem, PARMBSIZE, false, xflags);
> +	free_cprbmem(mem, PARMBSIZE, scrub, xflags);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729140134.1914=
48-2-freude@linux.ibm.com?part=3D1
