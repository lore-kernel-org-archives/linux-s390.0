Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40116175A99
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976771; cv=none; b=Th/aeEF+HZaONoWS4MbfauyAWvCZ7D2YaWDUkY1wL9AFJF/QSNf3RCmCDMKUYsN/ufDhnhB5OH9tWFse14IILWFjMfoITxlRKJhcK8yGmezG7192F0ltq56Hz1qjmeDjWfXfAfmTqDzqfvnXHe5QuKHO9/cv3ii9gKWedwuoWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976771; c=relaxed/simple;
	bh=NIG4aMN7QhF2HQr4rHvQh/Y5D1P0AFp/2ueKDi9Ln6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IzSLsGg/vCZyBS1kQ5uafL6Ztr8Yw2UFNJUS/JrUy7x1ZmNMSraH1e7BvDt8xqcwsUC+L5wSVgJwsEAhOShCFyBwpeLG69Ryb8FhiyqToWTvofIjF2vk+leschowrWsAR7N+ubBW4lCL4uTFu+BtO0xKK9h51EiLgtDs7WBZswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf2DWIWt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf2DWIWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4FE1F000E9;
	Mon, 17 Aug 2026 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786976770;
	bh=SRjn+aB7JEM0RYS+2aIMyh+TrJVT/kqEaAZtEeHytRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yf2DWIWt6Gop6FMtZSbTNSpHcUALcXw+d/MAn2QyWApwo6S+ai9f9QwTM2VKQl5XE
	 X6Omfuxe+g/WcWcDAMzBQ6/nIUtSw9OvG2LO+pYDqRYFigStag6L+powy/j2uQYipt
	 YOWnrzLr5J4tSj9n5rPiubgTQNC/pG54p9e4CKFsTK8lwWy+h1Dhuiu2DXhggXCwwA
	 eLAT+C9TIoH0e9eY/uD5exDGCuPvdLVhA8+iZ5amzaH+1Xz5C0D1URL++nkpqN4eiB
	 wbDVGf+3EoQNI6rTYsayHTktvqmDNXxWnL72GVeVr99pUfYsOzL4dNMXQA6JPXOdhh
	 rzIMLU/noFNuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] s390/crypto: Fix use of mutex in atomic context
 in PAES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260817141654.77940-4-freude@linux.ibm.com>
References: <20260817141654.77940-1-freude@linux.ibm.com>
 <20260817141654.77940-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:26:09 +0000
Message-Id: <20260817142609.AC4FE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Temporary stack buffer `buf` containing plaintext and keystrea=
m is not zeroed before returning from `ctr_aes_crypt`.
- [High] The identical `mutex_trylock()` in atomic context bug remains unfi=
xed in `arch/s390/crypto/aes_s390.c` for standard AES CTR mode.
--

--- Patch [3]: [PATCH v3 3/6] s390/crypto: Fix use of mutex in atomic conte=
xt in PAES ---
commit a7d845af838256909450e5168e0a9dc3dda32e5a
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix use of mutex in atomic context in PAES

This commit replaces a mutex with a binary semaphore in the PAES CTR
implementation to allow fast CTR processing. This change avoids issues
when operating in atomic or interrupt contexts where mutexes are unsafe.

Cc: stable@vger.kernel.org # 6.16+

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index d075b0241f1f5..e8bbfc376ebb1 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c

[ ... ]

> @@ -971,7 +972,7 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ct=
x,
>  	if (rc)
>  		goto out;
> =20
> -	locked =3D mutex_trylock(&ctrblk_lock);
> +	locked =3D down_trylock(&ctrblk_sem) =3D=3D 0;

[Severity: High]
This is a pre-existing issue, but does arch/s390/crypto/aes_s390.c also
need this exact same fix?

It looks like ctr_aes_crypt() in arch/s390/crypto/aes_s390.c still uses
mutex_trylock() in atomic context:

arch/s390/crypto/aes_s390.c:ctr_aes_crypt() {
    ...
    locked =3D mutex_trylock(&ctrblk_lock);
    ...
}

Since ctr_aes_crypt() implements standard AES CTR as part of the skcipher
API, it is frequently reached via network processing from softirq context.
Could this trigger lockdep splats or fail on RT kernels if not updated to
use a binary semaphore?

[ ... ]

> @@ -1016,7 +1017,7 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *=
ctx,
>  		}
>  	}
>  	if (locked)
> -		mutex_unlock(&ctrblk_lock);
> +		up(&ctrblk_sem);
> =20
>  	/* final block may be < AES_BLOCK_SIZE, copy only nbytes */
>  	if (nbytes) {

[Severity: Critical]
This isn't a bug introduced by this patch, but while looking at the stack
buffer handling here, does arch/s390/crypto/aes_s390.c need to clear its
temporary buffer before returning?

In ctr_aes_crypt(), there is a temporary stack buffer buf that isn't
zeroed before the function returns:

arch/s390/crypto/aes_s390.c:ctr_aes_crypt() {
    ...
    if (nbytes) {
        ...
        ret =3D skcipher_walk_done(&walk, 0);
    }

    return ret;
}

During partial block processing, buf receives decrypted plaintext and the
remainder contains the raw AES CTR keystream. Since it isn't cleared explic=
itly,
could this leave cryptographic material on the kernel stack and expose
sensitive data to other components via uninitialized stack exposure vectors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817141654.7794=
0-1-freude@linux.ibm.com?part=3D3
