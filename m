Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326CC47F781
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637151; cv=none; b=gNIgVitZucqsvaG8BxuyruBTtr/Go/OnOHcn/3i1EkqWvMiIWSKSeivbeK25uk2XkDZiW4OXzwel2WOtrmr84EipSAWvj8AzcRlP1iMrELBR05KsYnrwrm2KQpp5Z1suaMi9cFN7Jqn74xB2CcrI//YO0rOPyxgHHbwNj4me4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637151; c=relaxed/simple;
	bh=oxp+0z5FWi3Bb22rLMR8Qazs5qHErZfH7JTk6chEl40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TCsU9rKzCkHYcbN/pEemLlfzckHdNVAHuieHqBo5O/nY1PLQAR4MreWvYbgbiuQN4mGNrL+UO3Cg640+aPelc4A4R0edPeOUTMabARm8XYi7YGwexVNnNOKNg2WABinJP/+7d2LaZrby3g8JA4DvOtpBaneYoenvdkHvxUw8qVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDVhFOUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDVhFOUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E3A1F00A3A;
	Thu, 13 Aug 2026 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786637149;
	bh=xZAzqmYQzw5deTQ+Pie2HdgCfNRZl49LRsuq+D1VlHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDVhFOUEYaK3teTEJHgiR2YzE4cYyAFNVEr0DAKI87X//3D+k6NzzzWuOPmsmgusC
	 Jc3Djb1pSuKuYVVYq9s06TP6rNVe89O7vwHmXjNrFOf7Mv4OwAa0S4/suNM0B5oMIK
	 dmT+ZY9hEr3HaJk8akrglCttq+7o1MpyMpFBMf0wM/AFDSW53V7hwGoEG5kooC4dWb
	 VHNl/6IKGF64m1U1S8siSqWp/s4fLmy0O/wu3/eVtuHH1QYnKda9MiW4uMbetiYAQp
	 Mt1HSUTW9rT/8N/GgbMaS5Fp1X4YsP40iGvrOHU8wNTkcAPFTqSilspcIbJZUDBSLE
	 cLB4TSDdFqdCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] s390/crypto: Fix skcipher_walk return code
 handling in aes_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260813155406.50051-2-freude@linux.ibm.com>
References: <20260813155406.50051-1-freude@linux.ibm.com>
 <20260813155406.50051-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 16:05:48 +0000
Message-Id: <20260813160549.40E3A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `mutex_trylock()` from softirq/interrupt context is unsafe=
 and violates core kernel locking rules.
- [High] Stack buffer `buf` containing sensitive plaintext/ciphertext is no=
t securely erased before returning from `ctr_aes_crypt`.
--

--- Patch [1]: [PATCH v3 1/3] s390/crypto: Fix skcipher_walk return code ha=
ndling in aes_s390 ---
commit 26c79c6f9fbbbd190ba8f14ce8cd5587ce6bbe31
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix skcipher_walk return code handling in aes_s390

The return codes from skcipher_walk_virt() were not properly checked
before entering the processing loops in ecb_aes_crypt() and ctr_aes_crypt().
If skcipher_walk_virt() fails, the walk structure may be in an undefined
state, and attempting to process data could lead to incorrect behavior
or accessing uninitialized memory.

> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 62edc66d54788..366ce22d36237 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c

[ ... ]

> @@ -577,7 +577,7 @@ static int ctr_aes_crypt(struct skcipher_request *req)
>  	locked =3D mutex_trylock(&ctrblk_lock);

[Severity: High]
This is a pre-existing issue, but calling mutex_trylock() from softirq or
interrupt context is unsafe and violates core kernel locking rules.

Because this crypto algorithm can be executed in softirq context (such as
when processing IPsec/ESP packets), the current task is arbitrary, which
will result in a lockdep splat.

Could this be fixed by checking if the execution context permits operating
on a sleepable lock, perhaps using in_task(), before attempting the trylock?

> =20
>  	ret =3D skcipher_walk_virt(&walk, req, false);

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

[Severity: High]
This is a pre-existing issue, but this function appears to return without
securely erasing the stack buffer buf.

When a partial block is processed, up to 15 bytes of sensitive cryptographic
material (plaintext or decrypted ciphertext) is left in this buffer. Could
this stack remnant be leaked to userspace by subsequent syscalls?

Other functions in this driver (e.g., cbc_aes_crypt) use memzero_explicit()
before returning. Should a similar cleanup be added here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813155406.5005=
1-1-freude@linux.ibm.com?part=3D1
