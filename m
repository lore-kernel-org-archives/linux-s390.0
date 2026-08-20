Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204235CB9C
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236524; cv=none; b=DvGM5pWri2BCc5tXdJM5uk48Meq2DVeUeM3ImaLb1V7hAaRdOgWk1pz7bZnWB5lAP1W3bMkzA6WEPctZA8sGkMos0ohag3ihRKqSElv+TnARk2jL0mRx/+6xs6A8yZUak47WSjcuL6bJYzk4oFwSQjGE8mYz/OnqCpDfNmZ2yVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236524; c=relaxed/simple;
	bh=6eK2Le7yKKJqAdxOjEBADtW+fgMiyyMpJgZdCMP1RWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AFfMOkAzhZE7WFE1JWl9XUO9Y/MqAAW4v68MXhrxSr5dge4GOZsRobiDIK+c7XjvQNAd1351zw8yhJNnoYMgG6iereJeJh/4QOx8jhyIVUUci5pevelDFRTK8m2UTfQmwKRI+YuEL9hGK2NhyA+xW5GFUjtEaT7oUdx2wiJvUHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVfNsg6x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVfNsg6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3221F000E9;
	Thu, 20 Aug 2026 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787236522;
	bh=XI6bSFeHeXngkKcQfZRnCuytXmPD/e0AxL8Dpl5bNHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aVfNsg6x+7ojdlA8HL8eBKTiUEWifmMpBltETuinpTij4ht1Wxiwi+CWZrddgWmxI
	 anNguMkJpkIVm35R4hjm7ENewx9lUwfeQSHnWylTkMGmqWSfp1YKdtEZdZFU+DzaQK
	 npkHFPXRYEtNagy7YSUZQuO/iMuQgzwUBgAfga79ukqM5RhFOoI00f7v47eAtbV9a4
	 TfdGmjEjwjlpbwMNGtq4y2KTP1jtAmvEh95fOoX91QzTMHR+nJYQPflCdJkvR3BFJT
	 VfBSsfQ/Ev2T6bHU6b+UvM21BXHlKRtSQCGkE7Ef2gf7kKgOUPlQbXB2GCHVaVALLa
	 Jd7n7oUKPoCyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] s390/crypto: Fix handling of EBUSY in PHMAC when
 req is pushed to crypto engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260820141957.19091-7-freude@linux.ibm.com>
References: <20260820141957.19091-1-freude@linux.ibm.com>
 <20260820141957.19091-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:35:22 +0000
Message-Id: <20260820143522.7C3221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect module teardown order in `s390_phmac_exit` leads to kthr=
ead leaks and Use-After-Free of the `crypto_engine`.
--

--- Patch [6]: [PATCH v5 6/8] s390/crypto: Fix handling of EBUSY in PHMAC w=
hen req is pushed to crypto engine ---
commit c74c807c2aeebffc7e981ca45b5b377727342ad1
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to crypto en=
gine
   =20
When a request is transferred to the engine via
crypto_transfer_hash_request_to_engine() there are two return codes
signaling a successful transfer: EINPROGRESS and EBUSY. However the
correct handling of EBUSY was missing and has been added as a return
code indicating a successful transfer to the crypto engine.

Cc: stable@vger.kernel.org # 6.17+

> diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
> index 03ca33ffe6ccf..30c8a59af1a4e 100644
> --- a/arch/s390/crypto/phmac_s390.c
> +++ b/arch/s390/crypto/phmac_s390.c

[ ... ]

> @@ -716,15 +726,17 @@ static int phmac_finup(struct ahash_request *req)
>  		/* req->async_op has been set to either OP_FINUP or OP_FINAL */
>  		atomic_inc(&tfm_ctx->via_engine_ctr);
>  		rc =3D crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req=
);
> -		if (rc !=3D -EINPROGRESS)
> +		if (rc =3D=3D -EINPROGRESS || rc =3D=3D -EBUSY)
> +			cleanup =3D false;
> +		else
>  			atomic_dec(&tfm_ctx->via_engine_ctr);
>  	}
> =20
> -	if (rc !=3D -EINPROGRESS)
> +	if (cleanup && hwh->walkbytes > 0)
>  		hwh_advance(hwh, rc);
> =20
>  out:
> -	if (rc !=3D -EINPROGRESS)
> +	if (cleanup)
>  		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
>  	pr_debug("rc=3D%d\n", rc);
>  	return rc;

[Severity: High]
This is a pre-existing issue, but while reviewing this file I noticed a
potential module teardown order problem in s390_phmac_exit() in=20
arch/s390/crypto/phmac_s390.c:

    if (phmac_crypto_engine) {
        crypto_engine_stop(phmac_crypto_engine);
        crypto_engine_exit(phmac_crypto_engine);
    }

    for (i =3D ARRAY_SIZE(phmac_algs) - 1; i >=3D 0; i--) {
        phmac =3D &phmac_algs[i];
        if (phmac->registered)
            crypto_engine_unregister_ahash(&phmac->alg);
    }

Could this lead to kthread leaks and a use-after-free of the crypto_engine?

If s390_phmac_init() fails to register a subsequent algorithm after
successfully registering the first, it jumps to the error path and
calls s390_phmac_exit().

Because the first algorithm is already registered and the module is in
MODULE_STATE_COMING, a concurrent userspace program can successfully
allocate it and continuously submit hash requests.

Since s390_phmac_exit() calls crypto_engine_stop() before unregistering
the algorithms, the continuous stream of requests keeps the engine busy.
This can cause crypto_engine_stop() to time out and return -EBUSY,
which leads to crypto_engine_exit() returning without destroying the
kworker thread.

Finally, misc_deregister() destroys the device, freeing the devm-managed
crypto_engine struct, and the module is subsequently unloaded.

Would the still-running kworker thread then access freed memory and
execute freed module code, potentially causing a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820141957.1909=
1-1-freude@linux.ibm.com?part=3D6
