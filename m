Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE79042B33D
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131868; cv=none; b=NWpUWnynuQiA0O8ZqYmuYI9xJpWNJZzYz1LBf7KAmmKuyPtruw4lc3smgNi/e41UkfvTSZM+IIrOnMdrKr5sUCvBarAziGkVlR3XwYYl2Q0jTj7sqje5cxFFgs/ZAGGh5NBSFKRdxshdXycG+GdoWm6inPRVPly0VGb2KwrQBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131868; c=relaxed/simple;
	bh=B4wmkukWkfX1gvQOQNa/Hoa6g5m1iciYqdoYi9DHXkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BpqmcIRJCbrPYmWoeTF524ZJB1E5ZOfEfjXElXAu+gtM+oyJlhqT7TFOXgKrcVFZjR9IQcBtqUQb7zsJyMUxB9f5ptg7bj9/0dbw+n9lWfViRCnEgGLd1csh5Nkhl2PhVziVlbRoNue/fCiPqzBaIzXC176yRkyaPM5R1uafAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnKACqNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnKACqNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB0C1F000E9;
	Wed, 19 Aug 2026 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787131863;
	bh=xc0gyHRCXfe3nB+65Dx6TkVeUYrsSmNxPUFOgsvzCS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YnKACqNbw2Fj20veaGhaBC/s+AC9D2bNMV7u+sFxB0hVwufOziU420j8KWgCWR3hR
	 E4NH2tRBKN5D042dr4GwBQcWHXO/nBJSFpaTm9Xf0ychiKIym2e31+f4qXH6zMgLwp
	 NRzJWLJWiL/RMkA971tTpL8E47k5PkJECOuPSyk7XST/Zy2Yvtkm/AZrHBtv3VStPI
	 bylJk/LPCBvDp3npZOn6bz9+TfuyxgjMteq9gsXtGY9RFpdiTsjEDWXcffKqeTVfW5
	 hiFWbZsb3R6W1aw44YuZadGWSuBPQaqq+8FWz9nXp3VCh/OQlhs4kQiOCHz3k3mWzw
	 L/yGBRARFyVfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] s390/crypto: Fix return code handling at
 skcipher_walk_done in PAES algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260819091734.7331-2-freude@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
 <20260819091734.7331-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:31:02 +0000
Message-Id: <20260819093102.CFB0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Silent data corruption and broken serialization when hardware =
queue is full and backlog is enabled.
--

--- Patch [1]: [PATCH v4 1/7] s390/crypto: Fix return code handling at skci=
pher_walk_done in PAES algorithms ---
commit 521a2dcdf7aa2bf204154c4172f4175cd3764345
Author: Harald Freudenberger <freude@linux.ibm.com>
Subject: s390/crypto: Fix return code handling at skcipher_walk_done in PAE=
S algorithms

This patch adds immediate error checks after skcipher_walk_done() in all
main PAES cipher processing loops. It also checks if the walk has already
been finalized before calling skcipher_walk_done() to avoid double
de-allocation of resources.

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
This isn't a bug introduced by this patch, but does this logic safely handle
requests when the hardware queue is full?

If crypto_transfer_skcipher_request_to_engine() returns -EBUSY, the request
is successfully backlogged.

However, because rc is not -EINPROGRESS, it appears the driver decrements
the engine counter and calls skcipher_walk_done() here to tear down the
walk.

When the engine later processes this backlogged request, will it operate on
an empty walk and zeroed parameters, silently returning success without
processing the data? Could this lead to data corruption when under heavy I/O
load?

[ ... ]

> @@ -761,7 +766,7 @@ static int cbc_paes_crypt(struct skcipher_request *re=
q, unsigned long modifier)
>  			atomic_dec(&ctx->via_engine_ctr);
>  	}
> =20
> -	if (rc !=3D -EINPROGRESS)
> +	if (rc !=3D -EINPROGRESS && walk->nbytes)
>  		skcipher_walk_done(walk, rc);

[Severity: Critical]
This is a pre-existing issue, but does this cbc_paes_crypt() implementation
share the same -EBUSY fallback issue described above, where backlogged
requests are prematurely torn down?

[ ... ]

> @@ -1079,7 +1089,7 @@ static int ctr_paes_crypt(struct skcipher_request *=
req)
>  			atomic_dec(&ctx->via_engine_ctr);
>  	}
> =20
> -	if (rc !=3D -EINPROGRESS)
> +	if (rc !=3D -EINPROGRESS && walk->nbytes)
>  		skcipher_walk_done(walk, rc);

[Severity: Critical]
This is a pre-existing issue, but does ctr_paes_crypt() also suffer from the
same backlogged request cleanup problem when rc is -EBUSY?

[ ... ]

> @@ -1512,7 +1528,7 @@ static inline int xts_paes_crypt(struct skcipher_re=
quest *req, unsigned long mod
>  			atomic_dec(&ctx->via_engine_ctr);
>  	}
> =20
> -	if (rc !=3D -EINPROGRESS)
> +	if (rc !=3D -EINPROGRESS && walk->nbytes)
>  		skcipher_walk_done(walk, rc);

[Severity: Critical]
This is a pre-existing issue, but does xts_paes_crypt() similarly mask
-EBUSY errors, potentially leading to plaintext being written to disk under
heavy load?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819091734.7331=
-1-freude@linux.ibm.com?part=3D1
