Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345BF3B1B4
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976857; cv=none; b=Iq3DGwhi5wBhswm5bcOpX7jR1oRLJXDVBPRZCs2++VbFjy8TmcgY+norwOdWCtIo2J+Unw3pRWlFRuTw2u2fCGbz3VFpjcLBhMXSeoneTIw6ASbM4BoKuUFx6sW0GVwkUboMBHQMNbHxDZc/RyUs/4sNpYYbV76chKa3nqv8AaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976857; c=relaxed/simple;
	bh=p7Ml/Kjy5vjpyCmjV330bNQ2m28/wxCxKF/yxASR+Ks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GjxOAvx2lnKTneUIGhza7QVB78HYRc3nwGmYWBC9NaaZEP5OLLL2rzpnChteLgUxp9RlA9uu9kAGFt3kq+OaZxXAZsqSne/PyWKJwtsStgxbzGP+VuPYhMo+VitOi+NN5Dscuk1glK/AUw8nSXqYnPN1qNdyy1IhdRN/WHxPZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCg9mir/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCg9mir/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AEE1F000E9;
	Mon, 17 Aug 2026 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786976856;
	bh=+qBc1y7wvFJ0bxEenSmwXuZL77pJ6Xk6SgnOA0IqZrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TCg9mir/CBlKX7Ime3ybVV+P40nMYerLKFP0xtk+mhiWLzGTM7oOqSi93Bx0Xq/vV
	 ln380LtNPcHkzMX0m05TU3HvmYqDQ7yQcME2Mf6fnyFgNG/m02GzAmCcGV+D8IRphf
	 9fRvjoRX3AMUGPCS4a0vqWSNDD8rdbh4yLql32B82N3Zrmry7iTS7c5CBLRRKkY1IA
	 sIutycikCWnyLidmEu++m641B3XDTOQ2cFQHbqEq2Nl87F42HuC1X8euU9+ny4QzhK
	 4WxZKStzgbeIpRKpruIR6s4l63jfSG10yWlLfq77/rIZg8McxO+iPN4lg6dFKVtnL6
	 4Vy5Pm1BLS86w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] s390/crypto: Fix handling of EBUSY in PAES when
 req is pushed to crypto engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260817141654.77940-6-freude@linux.ibm.com>
References: <20260817141654.77940-1-freude@linux.ibm.com>
 <20260817141654.77940-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:27:35 +0000
Message-Id: <20260817142735.A3AEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch masks the `-EBUSY` backpressure signal by converting it =
to `-EINPROGRESS`, which breaks the crypto API's queue limit enforcement.

Pre-existing issues:
- [High] The module teardown in `paes_s390_fini` attempts to stop the crypt=
o engine before unregistering the algorithms, potentially leaking the engin=
e's kworker and causing a Use-After-Free.
--

--- Patch [5]: [PATCH v3 5/6] s390/crypto: Fix handling of EBUSY in PAES wh=
en req is pushed to crypto engine ---
commit 1a57782d904dcde97b280595a8b6669541d15c94
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix handling of EBUSY in PAES when req is pushed to crypto eng=
ine

When a request is transferred to the engine via
crypto_transfer_skcipher_request_to_engine() there are two return
codes signaling a successful transfer: EINPROGRESS and EBUSY. However
the correct handling of EBUSY was missing and has been added as a
return code indicating a successful transfer to the crypto engine.

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index 03446bfac37f2..1dd48f7a1bdf2 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
> @@ -494,6 +494,8 @@ static int ecb_paes_crypt(struct skcipher_request *re=
q, unsigned long modifier)
>  	if (rc =3D=3D 0 || rc =3D=3D -EKEYEXPIRED) {
>  		atomic_inc(&ctx->via_engine_ctr);
>  		rc =3D crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, =
req);
> +		if (rc =3D=3D -EBUSY)
> +			rc =3D -EINPROGRESS;

[Severity: High]
Does overwriting -EBUSY with -EINPROGRESS break the crypto API's queue limit
enforcement?

Callers like dm-crypt or IPsec rely on -EBUSY to signal that a request with
CRYPTO_TFM_REQ_MAY_BACKLOG was successfully enqueued, but the queue has
reached its maximum capacity.

By returning -EINPROGRESS instead, callers are falsely informed that the qu=
eue
is not full. This defeats the backpressure mechanism and allows callers to
continuously pump requests into the driver, potentially leading to unbounded
growth of the crypto engine queue and memory exhaustion.

Would it be better to preserve the -EBUSY return value but check
if (rc !=3D -EINPROGRESS && rc !=3D -EBUSY) before executing the local tear=
down
paths?

[ ... ]
> @@ -763,6 +765,8 @@ static int cbc_paes_crypt(struct skcipher_request *re=
q, unsigned long modifier)
>  	if (rc =3D=3D 0 || rc =3D=3D -EKEYEXPIRED) {
>  		atomic_inc(&ctx->via_engine_ctr);
>  		rc =3D crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, =
req);
> +		if (rc =3D=3D -EBUSY)
> +			rc =3D -EINPROGRESS;

[Severity: High]
Does this code hide the backlog signal for CBC mode in the same way?

[ ... ]
> @@ -1089,6 +1093,8 @@ static int ctr_paes_crypt(struct skcipher_request *=
req)
>  	if (rc =3D=3D 0 || rc =3D=3D -EKEYEXPIRED) {
>  		atomic_inc(&ctx->via_engine_ctr);
>  		rc =3D crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, =
req);
> +		if (rc =3D=3D -EBUSY)
> +			rc =3D -EINPROGRESS;

[Severity: High]
Does this code hide the backlog signal for CTR mode?

[ ... ]
> @@ -1529,6 +1535,8 @@ static inline int xts_paes_crypt(struct skcipher_re=
quest *req, unsigned long mod
>  	if (rc =3D=3D 0 || rc =3D=3D -EKEYEXPIRED) {
>  		atomic_inc(&ctx->via_engine_ctr);
>  		rc =3D crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, =
req);
> +		if (rc =3D=3D -EBUSY)
> +			rc =3D -EINPROGRESS;

[Severity: High]
Does this code hide the backlog signal for XTS mode?

As a general observation on the teardown path:

[Severity: High]
This isn't a bug introduced by this patch, but does paes_s390_fini() leak t=
he
engine's kworker and cause a use-after-free by stopping the crypto engine
before unregistering the algorithms?

arch/s390/crypto/paes_s390.c:paes_s390_fini() {
	if (paes_crypto_engine) {
		crypto_engine_stop(paes_crypto_engine);
		crypto_engine_exit(paes_crypto_engine);
	}
	__crypto_unregister_skcipher(&ctr_paes_alg);
	...
}

If module initialization fails, paes_s390_fini() could be called while earl=
ier
algorithms are already registered. In this window, another thread can
concurrently allocate a tfm and submit requests.

Because crypto_engine_stop() times out after 10 seconds if requests keep
arriving, it returns -EBUSY, causing crypto_engine_exit() to abort without
destroying the kworker thread.

After the algorithms are unregistered and the module memory is freed, the
surviving kworker will eventually process the queued requests and jump to t=
he
unloaded do_one_request function, resulting in a kernel panic.

Should the algorithms be unregistered first to prevent new TFMs from being
allocated before tearing down the crypto engine?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817141654.7794=
0-1-freude@linux.ibm.com?part=3D5
