Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219946EF7C
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711642; cv=none; b=NAQLWSgfAmodnDdVOlyxQKFN21Hwkm1t0PwkgppArR8qS7pF5nD9WS8Lh1lph8NpST6PDXG+CHMWmS0jN2jAHnZUJrsaGWWoZSx39+fiY3h+CpZ/kJKn9W8SxNy3AV7ZMQhEj+ZW0KRe2zvP5dOZXpMNJrxwVT7nuU4T/snKzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711642; c=relaxed/simple;
	bh=yOIk/CIgRoPp69heFOmntNyWBWzWlSUMvvsWcpDdnSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BYyeT+LDCNetwCKc83zmSJk6JI/tY3VVZe108wtGzTWeceZOzibjzZHpVxXe4kEUjb2bbpbtzUHtYIjivCAjQdHJHnkhIgkjGFudmrSPfjyBapkX+KUBEfjzux9APzrjWfJ9+V9lhvxzYN9xuyQm+kHQyLZQDqLP/rRj280fBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVR6qyZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVR6qyZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518781F00A3A;
	Fri, 14 Aug 2026 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711637;
	bh=yIqOV4i/EDEhq8mKxhsIps66xFiWTRvokrAOOeeSJ34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MVR6qyZrCH1uQTVJIqXuID7pBsV92WgUJ/wDpU9//HsdU0lStgAs1R2r3gaIkYLow
	 4Bl5dbcz+qiGq/DMK3y6ZnbN3pbpSMwGhC94XdEcSJ72tos+wvyDiYEp7riuISSYa4
	 7tHAF3/pdaMDU5CSE4fFrq0vMWDfu/XNREse7EjUZkyU+PRxe7fI/2IiCd+Lth6Kj5
	 rqlS1haDfka62da4eV9pOx24WI8GJY/7q+ZcIBubetOrSLms16ijUf+vy00FC0S+Q7
	 DEUYjL80PSShEQ+Fg+b3nI437pUq0dYKW3DEgQzytaqDs2SsrzrVJugZRG/pyu57ow
	 2DrBBmEtYsGLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] s390/crypto: Fix skcipher_walk return code
 handling in aes_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260814123711.61145-2-freude@linux.ibm.com>
References: <20260814123711.61145-1-freude@linux.ibm.com>
 <20260814123711.61145-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 12:47:16 +0000
Message-Id: <20260814124717.518781F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Using a mutex (`ctrblk_lock`) in `ctr_aes_crypt`, which can be exe=
cuted in interrupt/softirq context.
--

--- Patch [1]: [PATCH v4 1/3] s390/crypto: Fix skcipher_walk return code ha=
ndling in aes_s390 ---
commit 17298a26fe3f9b4cf4ce956d4ad5d1b5f20ca7ef
Author: Harald Freudenberger <freude@linux.ibm.com>
s390/crypto: Fix skcipher_walk return code handling in aes_s390

This patch adds proper return code checking from skcipher_walk_virt() in
the processing loops of several symmetric cipher modes to prevent operating
on an uninitialized walk structure if the initialization fails.

> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 62edc66d54788..366ce22d36237 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c

[ ... ]

> @@ -577,7 +577,7 @@ static int ctr_aes_crypt(struct skcipher_request *req)
>  	locked =3D mutex_trylock(&ctrblk_lock);

[Severity: High]
This isn't a bug introduced by this patch, but can using a mutex here
corrupt the interrupted task's lock state?

Since ctr_aes_crypt() can be executed in softirq context (such as during
IPsec ESP receive processing via NET_RX_SOFTIRQ), calling mutex_trylock()
and later mutex_unlock() assigns ownership to the arbitrarily interrupted
task. Mutexes enforce strict task ownership and are explicitly forbidden
in interrupt context, even when using trylock.

Could this trigger lockdep splats, incorrect optimistic spinning behavior,
or hard panics on PREEMPT_RT kernels where mutexes are strictly task-bound?

> =20
>  	ret =3D skcipher_walk_virt(&walk, req, false);
> -	while ((nbytes =3D walk.nbytes) >=3D AES_BLOCK_SIZE) {
> +	while (!ret && ((nbytes =3D walk.nbytes) >=3D AES_BLOCK_SIZE)) {
>  		n =3D AES_BLOCK_SIZE;
> =20
>  		if (nbytes >=3D 2*AES_BLOCK_SIZE && locked)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814123711.6114=
5-1-freude@linux.ibm.com?part=3D1
