Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A79432BD4
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008125; cv=none; b=Az9UUf7EX1EckD7mVRaugGHvwBp8PRxF8oFOFyIRP04KmkhHt2onx+MuIf1yuZ+Js5GwCvNltJFgD6jCQ28EAEdJAVdOnofd4i78D4TOZfdIH7+5dI572/8WFoFeDMexIsElGRmyD09Mf8JYvz+cnK1SOMo/BWbQAZy1xlEicVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008125; c=relaxed/simple;
	bh=YxPWw3YnXRcWHcqqrJ87fQ5IZWTX84kRRlrWmQUSvms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=azbfFTSUkjqnMTrcPo1q8xv7axGbCwQTghD94zMNMy9S8LaVdFOZDN3D+sO3MY+QZb1eFGIWa3gnvX0nEX8Ui7jgc8saMdkTv231DdiVhcpFTOSn4IWqiEj0SpyZZDZ0+RQFrIWKMDTLzvO16QeuQ5uOol3x0KkysR3sbjU1Cn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3V7eawn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3V7eawn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F073E1F000E9;
	Thu,  6 Aug 2026 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786008123;
	bh=QwUxeXt1nCZ+z8BEXYr3a/M7lgLxfFmQc1f525NF6LI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3V7eawnpfTn1GabhRyuLTGbHX0FmLhtWfdl8ioX1yjBh6mVxLsoLvSFojm0CqX/w
	 IjWVRorov0lSzK6bOdNg4N5JjyyNLT/RLu+kaOmJ6VfbF4IJ794flb5XYYV32S/gQD
	 JsrMZ/3rwIUtPGB5dOzlEm23BloDBp3vdbhtGEoPCVZRW0Uz137f/lKXmpPwAU++EU
	 q1TQBWKN9QmSv3+8TuU268ZgEZRUxHcytgR43bqhVixoEZPExQggGYz3y29h4YWtit
	 8f/3bUkvq6b4k0/tI1OIGB1jWRzFzDW1qdvLA9lmu3GiDo5nhjjHbG5iOT7PPMJTVX
	 wIk9zJ3ZU2+Rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] s390/crypto: Explicit scrub temp buffer in AES
 ctr mode algorithm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260806084950.17679-3-freude@linux.ibm.com>
References: <20260806084950.17679-1-freude@linux.ibm.com>
 <20260806084950.17679-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 09:22:02 +0000
Message-Id: <20260806092202.F073E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing zeroization of the highly sensitive AES master key (`p=
aram` structure) on early error paths in `gcm_aes_crypt()`.
- [High] The `ctr_paes_do_crypt()` function in Protected AES (PAES) CTR mod=
e suffers from the exact same stack buffer leak fixed in `ctr_aes_crypt()`,=
 exposing plaintext or ciphertext on the kernel stack.
- [High] The `gcm_aes_crypt()` function leaves temporary scatter/gather wal=
k buffers (`gw_in` and `gw_out`) and authentication tags unscrubbed on the =
kernel stack, exposing sensitive plaintext and ciphertext data.
- [High] The PowerPC `p10_aes_gcm_crypt()` glue code uses an unscrubbed sta=
ck buffer to process partial AES-GCM blocks.
- [High] Invalid use of `mutex_trylock()` and `mutex_unlock()` in potential=
ly atomic/softirq context in `ctr_aes_crypt()` and `ctr_paes_do_crypt()`.
--

--- Patch [2]: [PATCH v2 2/2] s390/crypto: Explicit scrub temp buffer in AE=
S ctr mode algorithm ---
commit e6f2a17e1141661b93e968958338ce9c79ff6466
Author: Harald Freudenberger <freude@linux.ibm.com>

    s390/crypto: Explicit scrub temp buffer in AES ctr mode algorithm
   =20
    In function ctr_aes_crypt() there is a buffer used to process
    remaining bytes < AES_BLOCK_SIZE. This buffer was not scrubbed and
    thus could lead to expose of unwanted data. Explicitly scrub it at
    the end of the code block.

> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 366ce22d36237..f52c612ae9cb3 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c
> @@ -604,6 +604,7 @@ static int ctr_aes_crypt(struct skcipher_request *req)
>  		memcpy(walk.dst.virt.addr, buf, nbytes);
>  		crypto_inc(walk.iv, AES_BLOCK_SIZE);
>  		ret =3D skcipher_walk_done(&walk, 0);
> +		memzero_explicit(buf, sizeof(buf));

[Severity: High]
This isn't a bug introduced by this patch, but since ctr_aes_crypt() is a
synchronous skcipher that can be called from softirq context, is it safe to
use mutex_trylock() and mutex_unlock() here?

arch/s390/crypto/aes_s390.c:ctr_aes_crypt() {
    ...
	locked =3D mutex_trylock(&ctrblk_lock);
    ...
    if (locked)
		mutex_unlock(&ctrblk_lock);
    ...
}

Holding or releasing a sleepable lock like a mutex from a software interrupt
context typically results in lockdep splats. The identical pattern also
exists in arch/s390/crypto/paes_s390.c in ctr_paes_do_crypt().

[Severity: High]
This is a pre-existing issue, but arch/s390/crypto/paes_s390.c seems to have
the exact same stack buffer leak for the protected aes ctr mode. Could this
also expose unwanted data?

arch/s390/crypto/paes_s390.c:ctr_paes_do_crypt() {
    ...
	if (nbytes) {
		memset(buf, 0, AES_BLOCK_SIZE);
		memcpy(buf, walk->src.virt.addr, nbytes);
        ...
		memcpy(walk->dst.virt.addr, buf, nbytes);
		crypto_inc(walk->iv, AES_BLOCK_SIZE);
		rc =3D skcipher_walk_done(walk, 0);
        // missing memzero_explicit(buf, sizeof(buf));
	}
    ...
}

This temporary stack buffer buf[] appears to be populated with cryptographic
data but never explicitly zeroized before returning.

[Severity: High]
This is a pre-existing issue, but could gcm_aes_crypt() in the same file
also be exposing sensitive plaintext and ciphertext data on the kernel stac=
k?

arch/s390/crypto/aes_s390.c:gcm_aes_crypt() {
	struct gcm_sg_walk gw_in, gw_out;
	u8 tag[GHASH_DIGEST_SIZE];
    ...
}

The gw_in and gw_out structures contain u8 buf[AES_BLOCK_SIZE] bounce
buffers used during scatterlist walks for unaligned chunks. These walk
buffers, along with the authentication tag, are omitted from the
memzero_explicit() block at the end of the function.

[Severity: Critical]
This is a pre-existing issue, but does an early return in gcm_aes_crypt()
bypass the explicit zeroization of the param structure containing the
master key?

arch/s390/crypto/aes_s390.c:gcm_aes_crypt() {
    ...
		n =3D aad_bytes + pc_bytes;
		if (gcm_in_walk_done(&gw_in, n) !=3D n)
			return -ENOMEM;
		if (gcm_out_walk_done(&gw_out, n) !=3D n)
			return -ENOMEM;
    ...
	memzero_explicit(&param, sizeof(param));
	return ret;
}

If gcm_in_walk_done() or gcm_out_walk_done() fail, the function early
returns -ENOMEM and skips zeroizing the param structure on the stack.

[Severity: High]
This is a pre-existing issue, but I am wondering if the powerpc aes-gcm
stitched implementation has a similar partial block leak?

arch/powerpc/crypto/aes-gcm-p10-glue.c:p10_aes_gcm_crypt() {
    ...
	while ((nbytes =3D walk.nbytes) > 0 && ret =3D=3D 0) {
		const u8 *src =3D walk.src.virt.addr;
		u8 *dst =3D walk.dst.virt.addr;
		u8 buf[AES_BLOCK_SIZE];

		if (unlikely(nbytes > 0 && nbytes < AES_BLOCK_SIZE))
			src =3D dst =3D memcpy(buf, src, nbytes);
    ...
}

The local buf array holds partial blocks but is never zeroized
before the loop continues or the function returns, leaving data on the stac=
k.

>  	}
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806084950.1767=
9-1-freude@linux.ibm.com?part=3D2
