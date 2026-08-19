Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606137A839
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132231; cv=none; b=LX87+KsQgoZL+eqUEfgWZBuH/JiEdbto6gG/po5l5l5kjxedDYaUVFgGBorYHswFbk+QOYHJcO7iy2vYtqtTW1G2NoCa7OtKNNZ/OP+jIs0X9Td2titA2whsphFxpmSl8VNQqwp5+1hqvVX0HN8wy6gunLGzHRE84om3wWcBFjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132231; c=relaxed/simple;
	bh=E9XpgPx/CkkVjNNvxI5/YRBRVElfIyuMlTgWGRBOrQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sqjTKmIvvYyA8JQJxQzPhQ/rlCWsfA9ghXiWy7GL62W2SlXbJDQObP5E4VhcNEJLZR38cv2Dg3gYKc/6jH4t0JJaoadB3zKOheKZOAdcvzhzS8wDTIgtTqQaldGXx3IKXOwA9Y/690YlU1H6qv5WwiYf1toMNRmen2zx4Ioz6q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoLxSmlC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoLxSmlC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A491F000E9;
	Wed, 19 Aug 2026 09:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787132229;
	bh=hkSWvhWuvCEeA0OX8xsBYluCuYq7geHlG6fQHCIZmCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WoLxSmlCAV6EPeT15onaF+eRjUI7hV91tzKALzIb8QRQR8Kezx1QHGeQW9m5mjv/4
	 7hG7caa6A+OTRBrhb6IRj+2s+Vsn5hU9aa8zZ5R3oVlXVslRqIDBmaaLbzzNTYGLdt
	 44p/4AzX+UT7b6JLRt0g6tleK1FgXnHpfNGcpD5yg44RuNOZXx3tNQ4PrNQjPz7n5F
	 ESMKqnh/2FFO9bORAGJgK2H/GyBx12vrK790Ot0gk0dCe8vnXnkHH4oDHMFIMwhScV
	 DjrnkuEzIcgy3OB6yF6HqtT9zEd5sxS7tDPSOSj/ILC4MjicRrFaqQ4U9CiYXzgdlj
	 vIEUpVmpo9SIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] s390/crypto: Fix handling of EBUSY in PHMAC when
 req is pushed to crypto engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260819091734.7331-7-freude@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
 <20260819091734.7331-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:37:08 +0000
Message-Id: <20260819093709.52A491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Thread-local memory mapping (kmap_local_page) is leaked across=
 an asynchronous boundary, leading to an invalid cross-thread kunmap_local.
- [High] Double completion of asynchronous requests on error paths in `phma=
c_do_one_request`.
- [High] Persistent hardware busy state causes the driver to complete the r=
equest with `-EBUSY`, which the crypto API swallows, leading to an infinite=
 wait.
--

--- Patch [6]: [PATCH v4 6/7] s390/crypto: Fix handling of EBUSY in PHMAC w=
hen req is pushed to crypto engine ---
commit 85264caf4d41b4adaeaed2f15efd8b287915969c
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to crypto en=
gine

This commit fixes the handling of the -EBUSY return code when a request is
transferred to the crypto engine via crypto_transfer_hash_request_to_engine=
().
It adds -EBUSY as a successful transfer indicator alongside -EINPROGRESS,
preventing premature cleanup of the request context.

> diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
> index 03ca33ffe6ccf..30c8a59af1a4e 100644
> --- a/arch/s390/crypto/phmac_s390.c
> +++ b/arch/s390/crypto/phmac_s390.c

[ ... ]

> @@ -629,12 +632,15 @@ static int phmac_update(struct ahash_request *req)
>  		req_ctx->async_op =3D OP_UPDATE;
>  		atomic_inc(&tfm_ctx->via_engine_ctr);
>  		rc =3D crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req=
);
> -		if (rc !=3D -EINPROGRESS)
> +		if (rc =3D=3D -EINPROGRESS || rc =3D=3D -EBUSY)
> +			cleanup =3D false;

[Severity: Critical]
This is a pre-existing issue, but does setting cleanup =3D false here leak a
thread-local memory mapping across an asynchronous boundary?

When the submitter thread maps the scatterlist page using kmap_local_page()
via hwh_prepare() calling into crypto_hash_walk_first(), the map is strictly
thread-local. If the request is pushed to the engine and the submitter thre=
ad
returns, the local memory remains mapped in its thread context.

Later, the crypto_engine kworker thread processes the queued request in
arch/s390/crypto/phmac_s390.c:phmac_do_one_request(), calling
crypto_hash_walk_done(), which invokes kunmap_local() cross-thread. Can this
cause a kernel BUG or panic by violating the thread-locality requirements of
kmap_local_page()?

> +		else
>  			atomic_dec(&tfm_ctx->via_engine_ctr);
>  	}
> =20
> -	if (rc !=3D -EINPROGRESS) {
> -		hwh_advance(hwh, rc);
> +	if (cleanup) {
> +		if (hwh->walkbytes > 0)
> +			hwh_advance(hwh, rc);
>  		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
>  	}
> =20

[ ... ]

> @@ -667,12 +674,14 @@ static int phmac_final(struct ahash_request *req)
>  		req_ctx->async_op =3D OP_FINAL;
>  		atomic_inc(&tfm_ctx->via_engine_ctr);
>  		rc =3D crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req=
);
> -		if (rc !=3D -EINPROGRESS)
> +		if (rc =3D=3D -EINPROGRESS || rc =3D=3D -EBUSY)
> +			cleanup =3D false;

[Severity: High]
This is a pre-existing issue, but does the driver properly translate persis=
tent
-EBUSY hardware errors before completion?

If the hardware persistently returns -EBUSY when deriving a protected key in
arch/s390/crypto/phmac_s390.c:convert_key(), it exhausts its retries and
returns -EBUSY. This propagates to phmac_do_one_request(), which explicitly
finalizes the request:

    crypto_finalize_hash_request(engine, req, rc);

Since the crypto API's completion wrapper ahash_op_done() explicitly swallo=
ws
-EBUSY because it treats it as a queueing status, completing a request with
-EBUSY prevents the final completion callback from firing. Could this cause
callers using crypto_wait_req() to block forever?

> +		else
>  			atomic_dec(&tfm_ctx->via_engine_ctr);
>  	}
> =20
>  out:
> -	if (rc !=3D -EINPROGRESS)
> +	if (cleanup)
>  		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
>  	pr_debug("rc=3D%d\n", rc);
>  	return rc;

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

[Severity: High]
This is a pre-existing issue, but is there a risk of double completion on e=
rror
paths in arch/s390/crypto/phmac_s390.c:phmac_do_one_request()?

If hardware execution fails and returns an error like -EIO,
phmac_do_one_request() manually completes the request:

    crypto_finalize_hash_request(engine, req, rc);
    local_bh_enable();
    return rc;

By returning the negative rc back to the crypto_engine core, and because the
engine allocates with retry_support=3Dtrue, the core in crypto_pump_request=
s()
will treat this as a failure it must handle. Does this trigger an automatic
fallback crypto_request_complete() that invokes the user's completion callb=
ack
a second time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819091734.7331=
-1-freude@linux.ibm.com?part=3D6
