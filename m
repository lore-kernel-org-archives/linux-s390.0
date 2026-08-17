Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596373F928B
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964173; cv=none; b=aj6hfO6cT2l/3npBjVqeRRMZKblXd6Bm6ySNuC4Vd8Ku/FWYeLtDR1IOZ3RQmTS5cz89HUDXLygVgmBwkbAKnskyKk5JyU9fEjK8inPdoytJjrjhmYY/iLDMkJWs4NrVjbVmKzDq/0+TL14oV/p2rOk5MJYc4X+D9yCEeIVH3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964173; c=relaxed/simple;
	bh=s2f6gYVRvqSXeD7Z1U5KpG2g319RjzQf7R+VxDRirnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C0hBE0QH8GX6s6X0V57fPgdkYhr4bSahgALks0AKAtqQeVx5FrEx4i/splIccjyzlVHWOU7Pn8Pf/dQCTPytEGJOyoUpikmTryxC+Lp+ZmB7gIQ9Vh1fpGOq+M79dLBM5iNq4Kfrpc56NUZNdmLi+8Gt92DIDZaqD0LHL3TebOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNtuWiq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNtuWiq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843EA1F00A3A;
	Mon, 17 Aug 2026 10:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786964166;
	bh=0E0XUNjy+9pfyhlaxu3x/j08xvgriQ2yOrJBx6IFFOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bNtuWiq4ykD7uuod+U2ZzM1mt2rr/ANhZXJFFw8qzx6G5g8ze24VuLPrtNIJfktpy
	 2i7D35LeaWlor1+7hkiXJeLWPePiOd/bcyzdyv+Q2+tOl+Py0cmKWGtUakuQvOJf4S
	 mAJkgiXUOjUMF/4K0N3hY3W5qcD6zsVP8EbOAdhBJ4TzLaMtTmlMoWh2NyVnFUB/Kb
	 B5dpWo1GRwJrr+KyK05lg0Glxn8Rq/tG2yxNtdF7x2mm3GnPEBBKIOg+p04pV+aIyw
	 uRDFJ7XGs8t1xgLZRdodwhBtI3z6V0S4jcZGH2MfbuMiQJ1nXMAS/5QEZ5Cnm+608o
	 rMDg4NsZLH0jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] s390/crypto: Fix handling of EBUSY in PHMAC when
 req is pushed to crypto engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260817104203.74033-7-freude@linux.ibm.com>
References: <20260817104203.74033-1-freude@linux.ibm.com>
 <20260817104203.74033-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 10:56:06 +0000
Message-Id: <20260817105606.843EA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] API Violation: kmap_local_page() mapped in one thread and unma=
pped in another
- [High] Double-Unmap / Memory Corruption in `phmac_finup` error path
--

--- Patch [6]: [PATCH v2 6/6] s390/crypto: Fix handling of EBUSY in PHMAC w=
hen req is pushed to crypto engine ---
commit 937135347da9f51601b4d25da73d8f9de9ecb6c8
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to crypto en=
gine

When a request is transferred to the engine via
crypto_transfer_hash_request_to_engine() there are two return codes
signaling a successful transfer: EINPROGRESS and EBUSY. However the
correct handling of EBUSY was missing and has been added as a return
code indicating a successful transfer to the crypto engine.

> diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
> index 03ca33ffe6ccf..adf14553ad392 100644
> --- a/arch/s390/crypto/phmac_s390.c
> +++ b/arch/s390/crypto/phmac_s390.c
> @@ -629,11 +629,11 @@ static int phmac_update(struct ahash_request *req)
>  		req_ctx->async_op =3D OP_UPDATE;
>  		atomic_inc(&tfm_ctx->via_engine_ctr);
>  		rc =3D crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req=
);

[Severity: Critical]
This is a pre-existing issue, but does deferring this request to the crypto
engine kworker thread cause a cross-thread kmap_local_page() violation?

Earlier in phmac_update(), hwh_prepare() maps memory into the local task.
If the request is deferred to the async engine, the local map context will
be leaked, causing kunmap_local() corruption when it is unmapped in the
worker thread.

> -		if (rc !=3D -EINPROGRESS)
> +		if (rc !=3D -EINPROGRESS && rc !=3D -EBUSY)
>  			atomic_dec(&tfm_ctx->via_engine_ctr);
>  	}

[ ... ]

> @@ -716,15 +716,15 @@ static int phmac_finup(struct ahash_request *req)
>  		/* req->async_op has been set to either OP_FINUP or OP_FINAL */
>  		atomic_inc(&tfm_ctx->via_engine_ctr);
>  		rc =3D crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req=
);

[Severity: Critical]
This is a pre-existing issue, but does deferring this request to the crypto
engine kworker thread cause a cross-thread kmap_local_page() violation?

Similar to phmac_update(), hwh_prepare() maps memory into the local task.
If the request is deferred to the async engine, the local map context will
be leaked, causing kunmap_local() corruption when it is unmapped in the
worker thread.

> -		if (rc !=3D -EINPROGRESS)
> +		if (rc !=3D -EINPROGRESS && rc !=3D -EBUSY)
>  			atomic_dec(&tfm_ctx->via_engine_ctr);
>  	}
> =20
> -	if (rc !=3D -EINPROGRESS)
> +	if (rc !=3D -EINPROGRESS && rc !=3D -EBUSY)
>  		hwh_advance(hwh, rc);

[Severity: High]
This isn't a bug introduced by this patch, but could unconditionally calling
hwh_advance() here on an engine fallback error path cause a double-unmap?

On a fallback failure, unconditionally calling hwh_advance() causes
crypto_hash_walk_done() to call kunmap_local() on already unmapped
pointers, potentially resulting in memory corruption.

> =20
>  out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817104203.7403=
3-1-freude@linux.ibm.com?part=3D6
