Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F93255F2C
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691816; cv=none; b=QVgpfTPRJCoUsL1oSG/p/SA4MlNgk0RVCuOSawtGKqbQ9K/pZwfv2QstbLD4GYHu9i5ia93WJ+wbqRTLQCbn7sAiAvY64LICHrjZYkfxsen5yDOgUZXkO8Fx0/WowSAmiUtMglZnu+AjtLO2/BNhU03KguLHTJBmeFTBoVSGVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691816; c=relaxed/simple;
	bh=ZwLQk4KjJ1hnIlnJA/COQf7ayRKmZd9xAt1sBrqHYHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gGFeix7DjJ1JSl1yQYVrWlrL4obHDfOB4T/BD3IbNOsR4w5aDgpCuxhJ340HMQEmauDcAHmkk2Ui57Yslw2SrOVoMYKttZ6fL142tV0EeIaXMmCkADxI7FiRYnKe7+2Gmx41lzDj8iSU7ecmNmIVZPcn/EDACj71mDFN1jvyBVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6DsL8MH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6DsL8MH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8AB1F00A3A;
	Fri, 10 Jul 2026 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691815;
	bh=osnPzCvn9azVz0MIdF6YRoRJnUdNNv7xATqw3VH51jw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e6DsL8MHotpNuJedb82gXltrmkRHyr2cuCkX8aamzVmJndW5tE640ezbA3XgRNWDz
	 DCzuov3dHOB1z++UQ6mN8Euafh8NX6IB06nOCSfEjbM6DQJd/UX+Zt9HseZWP+2aBc
	 MYa5MKvankLopSinpC0oE352neB9Ur2CYBKzdqagH4jnu1qcSLf2nSsIESpnP6+3FO
	 8JTsWXVGdbPVRqHnJmfOI6PUKr8aLrLTkafFF8qxLtLJxiGWd3+eBaogEYQdSDpM8W
	 zl94MsZlnjr/xOM23mDB7Mzcxa3L4hdKqTwj3QESn37cs+5X7OruBpIzXTtGm5HOox
	 hUXVxx2pokp6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] s390/zcrypt: Fix missing mem scrub at clear key
 import in cca_clr2cipherkey()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260710132658.77231-2-freude@linux.ibm.com>
References: <20260710132658.77231-1-freude@linux.ibm.com>
 <20260710132658.77231-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 13:56:54 +0000
Message-Id: <20260710135655.1B8AB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds validation on the hardware-provided length field `t=
->len` leads to out-of-bounds reads and writes from the CPRB reply block.
--

--- Patch [1]: [PATCH v1 1/1] s390/zcrypt: Fix missing mem scrub at clear k=
ey import in cca_clr2cipherkey() ---
commit ca71a93310e3d552d6d70f4020264235acf62e73
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey=
()

This commit adds a scrub parameter to _ip_cprb_helper() to control whether
the internal CPRB buffer is zeroed out before freeing. This prevents clear
key material from being left in memory during key token import.

> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/z=
crypt_ccamisc.c
> index 84936a795b956..6a237e880b40b 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> @@ -971,7 +971,8 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
>  			   int clr_key_bit_size,
>  			   u8 *key_token,
>  			   int *key_token_size,
> -			   u32 xflags)
> +			   u32 xflags,
> +			   bool scrub)
>  {

[ ... ]

> @@ -1111,7 +1112,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
>  	*key_token_size =3D t->len;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for the
hardware-provided t->len field to cause an out-of-bounds read or write?

Looking at _ip_cprb_helper() in drivers/s390/crypto/zcrypt_ccamisc.c, the
t->len field is used directly from the untrusted hardware response:

drivers/s390/crypto/zcrypt_ccamisc.c:_ip_cprb_helper() {
    ...
    t =3D (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
    memcpy(key_token, t, t->len);
    *key_token_size =3D t->len;
    ...
}

If a malfunctioning or compromised coprocessor returns a CPRB reply block
with a valid outer kb.len but a maliciously large inner t->len, could this
memcpy copy up to 64KB of adjacent kernel memory, overflowing the 16KB
token allocation in cca_clr2cipherkey()?

A similar pattern also appears to exist in cca_gencipherkey(). Would it be
safer to validate t->len against the source CPRB reply block size and the
destination buffer size before using it?

>  out:
> -	free_cprbmem(mem, PARMBSIZE, false, xflags);
> +	free_cprbmem(mem, PARMBSIZE, scrub, xflags);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710132658.7723=
1-2-freude@linux.ibm.com?part=3D1
