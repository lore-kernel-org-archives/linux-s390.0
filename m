Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525323BBFCC
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167965; cv=none; b=ZJLyrlyBWT9EqjpZ1DNPb7VUIaez664t9gZZ3qkAVs+amGcLaSnIWBqjhAaRets8pn0bAAuvPAML7zOvErD/SNdzkQ6nmGtOQV9djAu8VIiCZ1Dn4vTCPqmlh1JAmpSMfe+SYPc4saoMhAxr0WVAip8yPkiv/8q3joJnPI+9mGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167965; c=relaxed/simple;
	bh=pTDCBFazyh3pqVqTvGMUuiA/ex+YIm9CmsFlrcBNOww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HN6dBShlxD7MWU+YKYijTso5fNCgcpTayIWdeKM7ZU3+94G5+FM2PurwdfcatNXFcu9h1H6pK1i59sx4nCubhjnGozGzFANw3CDGLoikpFKnhNxj0gSw//IRqJgmX9A1F7cvSSBPQ+4+rC2pg5My8InnR5+Cu73YxRH29a/Icvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luOKyWiC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luOKyWiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895B61F000E9;
	Mon, 31 Aug 2026 09:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788167963;
	bh=VOVyZE3jmIcu9PMgDenMN71fdbZf3jkIm53l+GwlXP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=luOKyWiCOfbhc5RzeS71bzqSV6lRQW+WLMfhZc9GIjwSFqIepIjbOjJmR9yFOY0db
	 2xV3SVuT/QG1bC0k31soCFrazRiodpRt/teYBBCsi3J82dfd+8FRgt5RacktEEWECV
	 W+qnPD6o394zHR5sIglWcbQnRWc48aoVyhXjTjHMFabCJbhnDkc5eOyB/7UNlHCG0K
	 lAncUdtsdET5viFoAtmfbHssRmIocsmSqvNKQiJVlaCRAIwfR8H7lxDtdCrKjJk6hD
	 wqdDnFp4pNOFRlRLaqpdRwstAwDYyLPsL8pfqsiUNg8WuC0xo0uSSMu+7ElG6VXZkm
	 DZyq4ijz35F8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/9] s390/crypto: Fix use of mutex in atomic context
 in PAES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260831083838.3703-4-freude@linux.ibm.com>
References: <20260831083838.3703-1-freude@linux.ibm.com>
 <20260831083838.3703-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:19:22 +0000
Message-Id: <20260831091923.895B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The standard AES CTR implementation (`ctr-aes-s390`) calls `mutex_=
trylock()` and `mutex_unlock()` within its encryption routine `ctr_aes_cryp=
t()`. This is unsafe because synchronous skcipher algorithms can be invoked=
 from atomic/interrupt contexts (such as softirqs processing IPsec traffic)=
, leading to locking violations and potential crashes.
--

commit 54e6d65629d9606907edef94511d7b4e99ed2398
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix use of mutex in atomic context in PAES

This commit fixes a locking violation in the PAES CTR implementation by
replacing a mutex with a binary semaphore. Mutexes are not safe to use in
atomic or interrupt contexts, where crypto operations are often invoked. It
also restructures the PAES CTR code to remove conditional locking.

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index d075b0241f1f5..10d1c56a049d6 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
> @@ -45,7 +45,7 @@ module_param_named(clrkey, pkey_clrkey_allowed, bool, 0=
444);
>  MODULE_PARM_DESC(clrkey, "Allow clear key material (default N)");
> =20
>  static u8 *ctrblk;
> -static DEFINE_MUTEX(ctrblk_lock);
> +static DEFINE_SEMAPHORE(ctrblk_sem, 1);

[Severity: High]
This is a pre-existing issue, but while this patch successfully fixes the
mutex usage in the PAES implementation, does the standard AES CTR
implementation in arch/s390/crypto/aes_s390.c suffer from the exact same
problem?

Looking at ctr_aes_crypt() in arch/s390/crypto/aes_s390.c, it appears to
still use a mutex:

arch/s390/crypto/aes_s390.c:ctr_aes_crypt() {
    ...
    locked =3D mutex_trylock(&ctrblk_lock);
    ...
}

and later:

arch/s390/crypto/aes_s390.c:ctr_aes_crypt() {
    ...
    if (locked)
        mutex_unlock(&ctrblk_lock);
    ...
}

Since the AES CTR skcipher algorithm is registered as synchronous, it can be
called from softirq context, such as when processing IPsec traffic. Calling
mutex operations from softirq context violates kernel locking rules and can
trigger lockdep warnings or panics on PREEMPT_RT kernels.

Does the AES CTR implementation need a similar fix to use a binary semaphore
instead of a mutex?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083838.3703=
-1-freude@linux.ibm.com?part=3D3
