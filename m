Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19C3D9DC3
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637077; cv=none; b=k4t9vn+++VueewEB0HM7fY2vOFo3WMtwJ0+dFXtLk4tof7uqcCwZdbmYb6zJMYgnw6SEGaX56wt+g6y3rGWJYg2ZZWtny9cnPWEAXoqkwSWPBYHHEKUsuOwWCrdEeJY76VD7HpAFduy9ybLj0WVuoFoK2noEh7uuUQ+K0/Sck9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637077; c=relaxed/simple;
	bh=aKDIkMeeGqyyroGBiJLOJ28jHbCIQRz0bYDcJnaDTbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WIikHhYSPXOVkbo/Z5eLphHaEUf3Y+I6+UODuZ1TVn8yyyn66m2BB5spvq35f5gDmZk8KJEdC7bGsSYH3wgkxFgJLqYIvCHWBbf4HGa1bvJL2y6O5Rit3CeR5HcDHwXwmo0mTgyebg+8aNdNi5djboJLMdiZomTB8sa+tw5IEuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGTdv4U9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGTdv4U9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBF91F000E9;
	Thu, 13 Aug 2026 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786637076;
	bh=MQw9qkpi3VPB+fq/TKuVBWkEEb6V9iLImXWNVzDC6+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UGTdv4U9rDMOW6aVxLgIBTnqa5/TPsKgsK8z+Lshq9djkN0DbT6GGoP6gshhb+SwQ
	 H0fggoUs9TKvnqoKqywplf6u3pocX3B7NzEOrLpUMSlBVYAD0ievvgEppR3TYizzzS
	 G55hE8E0MsgOgMAa25UyKXTndB1ZeEvPFFDWiXMe9mlZbiYEMfBXx1mmBeG4DF37Jb
	 /KIENgnyf0s7ht31//zNgfZmUAuh4AIe2Sb7/v3qFbgnHa2K2VD+y3LeVZyIi+rUOR
	 0gJ6FuoDmagoPiQRn3b2KpVwhC8BJ3XEJ3gNIIaSPC1Zb/xUh4UoHKn0hQxiHzrpYl
	 AgaFRNakqj6VQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] s390/crypto: Rewrite AES ctr mode to be prepared
 for context analysis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260813155406.50051-4-freude@linux.ibm.com>
References: <20260813155406.50051-1-freude@linux.ibm.com>
 <20260813155406.50051-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 16:04:35 +0000
Message-Id: <20260813160435.8BBF91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Bypassing `ctrblk_lock` in softirq context forces AES-CTR to proce=
ss data one block (16 bytes) at a time, severely degrading performance for =
softirq crypto users like IPsec.
--

--- Patch [3]: [PATCH v3 3/3] s390/crypto: Rewrite AES ctr mode to be prepa=
red for context analysis ---
commit 7a2551a9e3023dcb2323f560164fee63c00a3278
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Rewrite AES ctr mode to be prepared for context analysis

This commit rewrites the AES CTR implementation to resolve a clang
thread-safety warning regarding the ctrblk_lock mutex. It splits the
cryptographic operations into __ctr_aes_crypt() and checks in_task()
before attempting mutex_trylock() to avoid locking in softirq context.

> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 10561aa687c78..8295cb3fc56c2 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c
> @@ -562,46 +562,62 @@ static unsigned int __ctrblk_init(u8 *ctrptr, u8 *i=
v, unsigned int nbytes)
[ ... ]
> +static int __ctr_aes_crypt(struct s390_aes_ctx *sctx,
> +			   struct skcipher_walk *walk, bool locked)
> +{
> +	unsigned int n, nbytes;
> +	int ret =3D 0;
> +	u8 *ctrptr;
> +
> +	while (!ret && ((nbytes =3D walk->nbytes) >=3D AES_BLOCK_SIZE)) {
> +		n =3D AES_BLOCK_SIZE;
> +		if (nbytes >=3D 2 * AES_BLOCK_SIZE && locked)
> +			n =3D __ctrblk_init(ctrblk, walk->iv, nbytes);
> +		ctrptr =3D (n > AES_BLOCK_SIZE) ? ctrblk : walk->iv;

[Severity: High]
Since locked is false for softirq contexts, does this code bypass
__ctrblk_init() and clamp n to AES_BLOCK_SIZE (16 bytes)?

This causes the loop to only process 16 bytes per iteration instead of
handling the payload in bulk.

[ ... ]
>  static int ctr_aes_crypt(struct skcipher_request *req)
>  {
[ ... ]
>  	ret =3D skcipher_walk_virt(&walk, req, false);
> -	while (!ret && ((nbytes =3D walk.nbytes) >=3D AES_BLOCK_SIZE)) {
> -		n =3D AES_BLOCK_SIZE;
> +	if (ret)
> +		return ret;
> =20
> -		if (nbytes >=3D 2*AES_BLOCK_SIZE && locked)
> -			n =3D __ctrblk_init(ctrblk, walk.iv, nbytes);
> -		ctrptr =3D (n > AES_BLOCK_SIZE) ? ctrblk : walk.iv;
> -		cpacf_kmctr(sctx->fc, sctx->key, walk.dst.virt.addr,
> -			    walk.src.virt.addr, n, ctrptr);
> -		if (ctrptr =3D=3D ctrblk)
> -			memcpy(walk.iv, ctrptr + n - AES_BLOCK_SIZE,
> -			       AES_BLOCK_SIZE);
> -		crypto_inc(walk.iv, AES_BLOCK_SIZE);
> -		ret =3D skcipher_walk_done(&walk, nbytes - n);
> -	}
> -	if (locked)
> +	if (in_task() && mutex_trylock(&ctrblk_lock)) {

[Severity: High]
Does this in_task() check unconditionally prevent softirq contexts from
acquiring the mutex?

Network crypto frameworks (e.g. IPsec) typically execute AES-CTR=20
operations within softirq contexts (NET_RX_SOFTIRQ, NET_TX_SOFTIRQ), where=
=20
in_task() evaluates to false. This forces all such softirq users into the
fallback path calling __ctr_aes_crypt(sctx, &walk, false).

By forcing softirq contexts to process data 16 bytes at a time, does this
introduce a massive performance regression for network crypto workloads?

> +		/* process context and mutex acquired */
> +		ret =3D __ctr_aes_crypt(sctx, &walk, true);
>  		mutex_unlock(&ctrblk_lock);
> +	} else {
> +		ret =3D __ctr_aes_crypt(sctx, &walk, false);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813155406.5005=
1-1-freude@linux.ibm.com?part=3D3
