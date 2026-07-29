Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7D453A27
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336773; cv=none; b=P7ELBmuEh+T24YVrTbAVBoTjfH6WUDhymD4euunyZqr7xQykkDAB8cDsKL6e0sLX8yHV1UHBrek3TBKDGHkMppXTuptBnaVU1P2bFzXCObyV2lYKjjcrhBoA05HxEXPZBpbEitwH+4PCSdbXlWt2csl0HVxuZikNU6iNIPBhIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336773; c=relaxed/simple;
	bh=0DhKjdcpav27ENbWj9cswDJgTTPN7+7+n/DFCOoVuzg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A9EIaj9VKVs4KSVmRsIrqu95uZkEqaqZ2Pdj/eGn579P2XnP7iUZnCEOcFbnGa9zNKfpdxp4eCwCo8sq0uhXff5dqVveBgrqCldJvjChIw+/JCnxyMobZMkC/ynIb5HVYTtMo3A88oUtCHjuIwrzQW2vCv9xxmWhm8I8p9SYyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKesROVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKesROVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AC01F00A3A;
	Wed, 29 Jul 2026 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336772;
	bh=7DGk9mCigb70pj+JPS3EpSU8L5UHU7Mw/GhvXkI8dj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nKesROVtaDvuknm+TI6aIvR7Bg9sfnFG8O5CwPZsCFCSLaso1JCpVchs5ybPj63xw
	 XEVqTWFxxJtr8hmT0x4N6Me/vBsfw9vF/20UqmDoxVCgkIiVFRUNPyrJAwEmCq6wCe
	 9hOP8y1OlvEsElZZPwIRfBbfmJlBdKKABp+AupWJbEBkCbUsQMZS8caEGEKKFh5hmE
	 iiuBLgyjWMq3zradDduiz4bIE4Q8pdsgZ9sTW1y//NUMnF5yNmiEmHdMFxv6iSBeH4
	 MvdC5d27kJDHaW4oKcusl2q1U7IrFk9Mad+nAvA9A5+V9DNsFBf8W9R/X+wzR1OGQg
	 d37+dxZ1t+uAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/5] s390/zcrypt: Fix CPRB memory allocation in
 zcrypt misc code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260729143928.191969-2-freude@linux.ibm.com>
References: <20260729143928.191969-1-freude@linux.ibm.com>
 <20260729143928.191969-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 14:52:51 +0000
Message-Id: <20260729145251.92AC01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete memory scrubbing in `free_cprbmem()` due to missing 4=
-byte alignment rounding.
--

--- Patch [1]: [PATCH v8 1/5] s390/zcrypt: Fix CPRB memory allocation in zc=
rypt misc code ---
commit 8719946bc97657e1ca3c996d1d00474456aa0ef0
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
   =20
Both CPRB alloc functions in zcrypt_ccamisc.c and zcrypt_ep11misc.c
did not round up the memory allocation to a multiple of 4 bytes as it
is needed by the zcrypt layer to process the CPRBs.

Now the alloc_and_prep_cprbmem() and alloc_cprbmem() functions
guarantee that the base CPRB struct and a possible parameter block are
aligned to a 4-byte boundary and the backing memory allocation is
rounded up to the next multiple of 4 byte. Also the free_cprbmem() is
updated and scrubs the rounded up amount of memory.

> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/=
zcrypt_ep11misc.c
> index 3dda9589f2b95..e604c100ccce2 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
> @@ -355,21 +356,24 @@ EXPORT_SYMBOL(ep11_check_aes_key);
> =20
>  /*
>   * Allocate and prepare ep11 cprb plus additional payload.
> + * It is guaranteed that the memory is aligned to a 4 byte boundary.
> + * Furthermore the memory allocation is rounded up to the next
> + * multiple of 4 bytes (with taking the payload_len into account).
>   */
>  static void *alloc_cprbmem(size_t payload_len, u32 xflags)
>  {
> -	size_t len =3D sizeof(struct ep11_cprb) + payload_len;
> +	size_t memlen =3D ALIGN(sizeof(struct ep11_cprb) + payload_len, 4);

[Severity: Medium]
The commit message states that free_cprbmem() is updated to scrub the round=
ed
up amount of memory. While this change is present for zcrypt_ccamisc.c, was=
 it
missed for zcrypt_ep11misc.c?

Since alloc_cprbmem() now allocates the rounded up memory size, does
free_cprbmem() in zcrypt_ep11misc.c also need to be updated to scrub the
matching size?=20

Currently, it still uses the exact unrounded size:

    static void free_cprbmem(void *mem, size_t payload_len, bool scrub, u32=
 xflags)
    {
        if (mem && scrub)
            memzero_explicit(mem, sizeof(struct ep11_cprb) + payload_len);

Could this leave up to 3 bytes of the newly added padding unscrubbed when an
EP11 CPRB is freed? If the cryptographic hardware writes sensitive data into
the padding bytes of a 4-byte aligned response, this data would not be zero=
ed
before the memory is returned to the allocator.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729143928.1919=
69-1-freude@linux.ibm.com?part=3D1
