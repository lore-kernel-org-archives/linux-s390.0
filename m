Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969492BDC0F
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964512; cv=none; b=V/6xLgP/QRlJHKXVzFFGTLYlQ+Yr5coSH61mIq3drWzsUWFcB0ZctgXSUsijkplQ6J4q7EWDEfhHp5QPyKqTkvMrfrYBvmD7/I2XyTRkuvq14nGlXxXvRPCkeSNtQIrKYESb4RIXgUYgbLa5ETFrRB4vEP4ShOjeb4qnDDb6LWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964512; c=relaxed/simple;
	bh=H295ou4PaaiukmqRd/+cgeTH5SlzeAQdBTSu1JXbOMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eXo5+pqEjn/rvu7U9T4yk7XuLL3p6nA77ivHQNmdi4Xcta9wM+DMNlncicmW6iGDEk1xvl7P21kuXE3NA/zhYWO44GCHLeQ4IzpGF487BDLNGZZtfz/W1ulegas3+MK4yE7ZhwtSPUwpzrleoiNYjjpDVqQuq3os+slmenHQ7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdFQ+sAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdFQ+sAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F5A1F000E9;
	Mon, 17 Aug 2026 11:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786964511;
	bh=XdP95CiGSN8tsvgx1g7HnqR3uS3mvC/8vaSnZYII+rQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fdFQ+sAIQ9hK3YB3P0S2K9Evo/JLma4eAqkFFiChQXsRQRCfRyre7MYy3UfYTHH3R
	 CbppFATO4KsIcZCs8x+TfA53HqHPsFgYHfRk4VzZrqXJhu9fRFKWsrfGBTMH1NkJy/
	 hN99SKJ/61M1b7GvhXdCjJfBCLsSS9nWUQx4WMjrezNO3DErBb+t1dtK78lp0sVoZ9
	 zlWkE4urxrTb9G1EO7iM/kl4Yn9qqu/HFQSZkV/jnbaKNGc38Vv7QN7elKOd2GKDx+
	 TeeRd//WKiv6dQOeMlh8PtYQNMLdCUNkxRW6/xOk+kHfBtT3Hotrux7eEX0Zqeb+U/
	 6Cm/XWryiIAhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] s390/crypto: Fix return code handling at
 skcipher_walk_done in PAES algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260817104203.74033-2-freude@linux.ibm.com>
References: <20260817104203.74033-1-freude@linux.ibm.com>
 <20260817104203.74033-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 11:01:50 +0000
Message-Id: <20260817110150.D7F5A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The wrapper functions (e.g., ecb_paes_crypt) incorrectly treat=
 a return value of -EBUSY from crypto_transfer_skcipher_request_to_engine()=
 as an enqueue failure, leading to a Use-After-Free when the crypto engine =
eventually processes the request.
- [Critical] The async request handler returns an error code after already =
finalizing the request, causing the crypto engine to complete the request a=
 second time.
--

--- Patch [1]: [PATCH v2 1/6] s390/crypto: Fix return code handling at skci=
pher_walk_done in PAES algorithms ---
commit 8ebdb4de82e72b4c0a21b2b0f1f7cb80c8245b4f
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix return code handling at skcipher_walk_done in PAES algorit=
hms

This commit adds immediate error checks after skcipher_walk_done()
in PAES algorithms to prevent error masking. It also reworks how
walk->nbytes is checked to avoid double de-allocation of walk resources.

Cc: stable@vger.kernel.org # 6.16+

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index 8cfe6166c193c..ccc7da106c3a0 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c

[ ... ]

> @@ -495,7 +498,7 @@ static int ecb_paes_crypt(struct skcipher_request *re=
q, unsigned long modifier)
>  			atomic_dec(&ctx->via_engine_ctr);
>  	}
> =20
> -	if (rc !=3D -EINPROGRESS)
> +	if (rc !=3D -EINPROGRESS && walk->nbytes)
>  		skcipher_walk_done(walk, rc);

[Severity: Critical]
This is a pre-existing issue, but does this code properly handle backlog
queueing?

If crypto_transfer_skcipher_request_to_engine() returns -EBUSY when the
hardware queue reaches its soft limit, the request is still enqueued.

Because -EBUSY !=3D -EINPROGRESS, this error path will execute and call
skcipher_walk_done(), destroying the scatterlist walk and zeroing
parameters.

Since the engine will eventually process the enqueued request, could this
result in a use-after-free when the engine accesses the destroyed walk
structure? This pattern also appears in cbc_paes_crypt(), ctr_paes_crypt(),
and xts_paes_crypt().

> =20
>  out:

[ ... ]

> @@ -558,7 +561,7 @@ static int ecb_paes_do_one_request(struct crypto_engi=
ne *engine, void *areq)
>  		cond_resched();
>  		pr_debug("rescheduling request\n");
>  		return -ENOSPC;
> -	} else if (rc) {
> +	} else if (rc && walk->nbytes) {
>  		skcipher_walk_done(walk, rc);
>  	}
> =20

[Severity: Critical]
This is a pre-existing issue, but does returning the error code at the end
of this function cause the crypto engine to double-complete the request?

In ecb_paes_do_one_request() and the other async handlers, if
ecb_paes_do_crypt() returns a fatal error, the code finalizes the request
and later returns the error code:

    crypto_finalize_skcipher_request(engine, req, rc);
    local_bh_enable();
    return rc;

The crypto_pump_requests() loop in the engine framework interprets any
returned error other than -ENOSPC as an execution failure and manually calls
crypto_request_complete() a second time.

Could this double completion lead to a use-after-free if the caller frees
the request after the first callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817104203.7403=
3-1-freude@linux.ibm.com?part=3D1
