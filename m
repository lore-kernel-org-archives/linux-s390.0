Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8D46EC9E
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711848; cv=none; b=EQAVIWRnxC4lHhOcq+LwKEVBuqNawnd+a66kgKpBpYiok1reHwO+rcYRkDjF81S5YltfEBVgHFjDbWW0s4ob/K4tbrRRCe1gdJe1+MMvtRImw4lPEkB7YHUwqwaLyW1Cm21h7B6PtqqqAtVuh/xbfpZTFLetvUquWK840+cQZPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711848; c=relaxed/simple;
	bh=2w2zXCxY2INX/cnpgh/I6cJaqsyCFNjKSE7v9ypPPJk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=guEEMLe6P+xUSsp+2yAHrJvV1TX4WOCO/PyGrzF7X8YEdtp7jCM8apER9hFS4Lqrs0rX0noAkY430ndktXjJCkUFzWvPccUyITjXXz5JYI8xXuYEfdQyywEmH6BucXJjjofNl232V066y+0UrT/dfJNToLQTYSa/Y4I7OFJvjBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmQgfEr2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmQgfEr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86161F000E9;
	Fri, 14 Aug 2026 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711844;
	bh=U3n8OTnWCro7mGk6UaH8QOXhKbD3AfHK6fOwIVeLZOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gmQgfEr2YFeMGWo6K2TjpRqPl0M7+K1aBY9rGnX5OMhJ+4yD8V55aUpAfYJWx227p
	 6mxLGIwlvGVsnMkiciQLI8/EA4zjXh4pyKA/mL6jWMC9jkZ+hHicM80nNhXm8GahgE
	 4lyHqAzPudqw4q06BMuOljmZkCQnmW0XBikYyPeYrUpl8z1bP5SCU4QtIoexriWT0N
	 XeMra9a743uVulIp/sxShz+2aUN8TgAqBqk8TytEDXDn8owLrsQHb7bwW/OltIEo8f
	 zChfEEuF7o7sl8u8oaaWL/4G1FdhA/0erDCSL5/WGiEPss2xbWogE6e/JS3Wlhbyzi
	 8vW6i7qYn7yjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] s390/crypto: Fix missing scrub of temp buffers
 with AES ctr and gcm algorithm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260814123711.61145-3-freude@linux.ibm.com>
References: <20260814123711.61145-1-freude@linux.ibm.com>
 <20260814123711.61145-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 12:50:43 +0000
Message-Id: <20260814125043.A86161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing scrub of sensitive temporary buffer in `ctr_paes_do_cryp=
t()` when handling remaining bytes < AES_BLOCK_SIZE.
--

--- Patch [2]: [PATCH v4 2/3] s390/crypto: Fix missing scrub of temp buffer=
s with AES ctr and gcm algorithm ---
commit 3d2b9adbb3df3417589c4d42aa1add6ac98dbf33
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix missing scrub of temp buffers with AES ctr and gcm algorit=
hm

In function ctr_aes_crypt() there is a buffer used to process
remaining bytes < AES_BLOCK_SIZE. This buffer was not scrubbed and
thus could lead to expose of unwanted data. When the buffer is used
explicitly scrub it at the end of the code block to avoid exposure of
maybe sensitive data.

In a similar way the function gcm_aes_crypt() hat an error path where
the CPACF param block was not scrubbed. Instead of return early now
these error paths go to end of function where explicit scrubbing is
done. Similar with the buffers which are part of the gcm_sg_walk
structs from the variables gw_in and gw_out.

Cc: stable@vger.kernel.org # 6.8+

> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 62edc66d54788..10561aa687c78 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c

[ ... ]

> @@ -596,7 +596,7 @@ static int ctr_aes_crypt(struct skcipher_request *req)
>  	/*
>  	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
>  	 */
> -	if (nbytes) {
> +	if (!ret && nbytes) {
>  		memset(buf, 0, AES_BLOCK_SIZE);
>  		memcpy(buf, walk.src.virt.addr, nbytes);
>  		cpacf_kmctr(sctx->fc, sctx->key, buf, buf,
> @@ -604,6 +604,7 @@ static int ctr_aes_crypt(struct skcipher_request *req)
>  		memcpy(walk.dst.virt.addr, buf, nbytes);
>  		crypto_inc(walk.iv, AES_BLOCK_SIZE);
>  		ret =3D skcipher_walk_done(&walk, 0);
> +		memzero_explicit(buf, sizeof(buf));
>  	}
> =20
>  	return ret;

[Severity: Medium]
This is a pre-existing issue, but while you are patching ctr_aes_crypt(),
could the same missing scrub vulnerability be present in the PAES equivalen=
t?

Looking at ctr_paes_do_crypt() in arch/s390/crypto/paes_s390.c, when the
remaining bytes are less than AES_BLOCK_SIZE, it uses a local buf array in =
an
almost identical manner but never explicitly scrubs it before returning:

arch/s390/crypto/paes_s390.c:ctr_paes_do_crypt() {
...
	/* final block may be < AES_BLOCK_SIZE, copy only nbytes */
	if (nbytes) {
		memset(buf, 0, AES_BLOCK_SIZE);
		memcpy(buf, walk->src.virt.addr, nbytes);
		while (1) {
			if (cpacf_kmctr(ctx->fc, param, buf,
					buf, AES_BLOCK_SIZE,
					walk->iv) =3D=3D AES_BLOCK_SIZE)
				break;
...
		}
		memcpy(walk->dst.virt.addr, buf, nbytes);
		crypto_inc(walk->iv, AES_BLOCK_SIZE);
		rc =3D skcipher_walk_done(walk, 0);
	}

out:
	pr_debug("rc=3D%d\n", rc);
	return rc;
}

Can this leak plaintext or ciphertext to the kernel stack where it might be
subsequently exposed to user space via uninitialized stack padding?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814123711.6114=
5-1-freude@linux.ibm.com?part=3D2
