Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB53E025C
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977335; cv=none; b=IP9lNG8exkfnmZZD/s8xzejwTjoMTR9knjixWB/xxAOTF2MqpmXfh7F9JOne91yzAy00tP8VIfbknV4y/5Mo6ZgWaH5PgJLkbJRh203YaxW2MU35BrO0LYpG5kii63MU3C2zSn66tI/1yZMCZk9UjpL/eIlC8JwCGgcndFv9tnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977335; c=relaxed/simple;
	bh=8udqldsvdPGLLf5SRDkGSKgi9GZV95LzPYQImzGhB78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BBsa8/E/VCocesL3EYdxEJOl2QCiW4AEt4bdqf9aBmpGGfGFvyoTz/SjX81gJyJjbnDGalXDGp4fctsGeTvBsHDu28/f66Tv4I5tCeYdVnHzQ7cVI2CYFzBmsFNzR+xUQjpAGFAtc85tCN0JisG3fXG5VfL85EIgGSRUlztSGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T26SDtWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T26SDtWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28CE1F00A3A;
	Mon, 17 Aug 2026 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786977334;
	bh=pXttAEKlr7kWg84INWsHxNY278mQT0hrhDmeW7lk0iI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T26SDtWouh7QwsowzUoo3oFg+90y9mW75wRMRA8KdCGE1YAWvrMns+HPK2Q75Dm7u
	 WHyObvPNZAjsFX0OyxE7daZBB76A74v+dZVAMKlBy0c9m8v9MLSLHOvI1D9j0fpWmv
	 K/BK33XQ7Ib3480uyl35v8z4DSRp7Yn3uKnbtJGrZtUkt2JaOFiVZnVHg40ugm0w6r
	 i4eAVdtw0PqIhUwC0oxAzSvkPhpuMQUrAmAyRAx+prFTJmuUsF14nQVuVsWvEqxExR
	 JwXdpHIqIBKuK5Eb+bNlUjLYH3bWH5Bjb2BpYaxIzEahdr6DnNqrXt6iSUh6c9e6oJ
	 d+PhBnS03uUgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] s390/crypto: Fix handling of EBUSY in PHMAC when
 req is pushed to crypto engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260817141654.77940-7-freude@linux.ibm.com>
References: <20260817141654.77940-1-freude@linux.ibm.com>
 <20260817141654.77940-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:35:33 +0000
Message-Id: <20260817143533.F28CE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch rewrites the `-EBUSY` return code from the crypto engine=
 to `-EINPROGRESS`, improperly propagating a fake success state to the call=
er and breaking the crypto API backpressure mechanism.

Pre-existing issues:
- [Critical] `phmac_do_one_request` triggers a double completion when an as=
ynchronous request fails with an error code.
- [Critical] Unconditional `hwh_advance()` on error paths leads to a double=
 `kunmap_local()` or a NULL pointer dereference panic.
--

--- Patch [6]: [PATCH v3 6/6] s390/crypto: Fix handling of EBUSY in PHMAC w=
hen req is pushed to crypto engine ---
commit 049db089e02c25bd82461143ffc80704186a5ebb
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix handling of EBUSY in PHMAC when req is pushed to crypto en=
gine

When a request is transferred to the engine via
crypto_transfer_hash_request_to_engine() there are two return codes
signaling a successful transfer: EINPROGRESS and EBUSY. However the
correct handling of EBUSY was missing and has been added as a return
code indicating a successful transfer to the crypto engine.

> diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
> index 03ca33ffe6ccf..9d77198b22ff9 100644
> --- a/arch/s390/crypto/phmac_s390.c
> +++ b/arch/s390/crypto/phmac_s390.c
> @@ -629,6 +629,8 @@ static int phmac_update(struct ahash_request *req)
>  		req_ctx->async_op =3D OP_UPDATE;
>  		atomic_inc(&tfm_ctx->via_engine_ctr);
>  		rc =3D crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req=
);
> +		if (rc =3D=3D -EBUSY)
> +			rc =3D -EINPROGRESS;

[Severity: High]
Does this break the crypto API backpressure mechanism?

When the engine's queue is full, crypto_enqueue_request() queues the
request to the backlog and returns -EBUSY. Callers like dm-crypt rely on
this -EBUSY signal to apply backpressure and throttle incoming requests.

By unconditionally mutating -EBUSY to -EINPROGRESS, do we deceive the caller
into thinking the request is processing normally, breaking the feedback loop
and allowing unbounded queue growth?

Furthermore, the crypto engine will later invoke the completion callback
with -EINPROGRESS when dequeued. Are callers who received -EINPROGRESS
initially instead of -EBUSY prepared for this state transition?

Would it be safer to decouple the local pending check from the return value?
For example:

if (rc !=3D -EINPROGRESS && rc !=3D -EBUSY)
	atomic_dec(&tfm_ctx->via_engine_ctr);

>  		if (rc !=3D -EINPROGRESS)
>  			atomic_dec(&tfm_ctx->via_engine_ctr);
>  	}
> =20
>  	if (rc !=3D -EINPROGRESS) {
>  		hwh_advance(hwh, rc);

[Severity: Critical]
This is a pre-existing issue, but does unconditional execution of
hwh_advance() on error paths risk a double kunmap_local() or a null
pointer dereference panic?

If a hash operation completes successfully locally but errors out later
(for instance, if -EKEYEXPIRED causes an -ENOSPC engine fallback), the walk
might already be completely consumed and successfully unmapped.

If we then call hwh_advance() on the already-closed walk, does it execute
crypto_hash_walk_done() again on the same address, resulting in a double
kunmap_local()?

Additionally, if the request size is 0 bytes, crypto_hash_walk_first()
might not map any memory at all. Could this trigger a panic by
unconditionally attempting to unmap a null address offset in the error path?

[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but looking at
phmac_do_one_request(), is there a risk of a double completion when an
asynchronous request fails?

arch/s390/crypto/phmac_s390.c:phmac_do_one_request() {
	...
	crypto_finalize_hash_request(engine, req, rc);
	local_bh_enable();
	return rc;
}

If an error occurs, the driver explicitly finalizes the request by calling
crypto_finalize_hash_request(), which synchronously completes the request
by invoking the caller's callback.

However, the function then returns the negative rc back to the crypto
engine. Seeing a negative return value and not -ENOSPC, will the crypto
engine core incorrectly assume the driver failed to take ownership of the
request and immediately invoke crypto_request_complete() a second time?

Should this function return 0 after explicitly finalizing a request?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817141654.7794=
0-1-freude@linux.ibm.com?part=3D6
