Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3F39A057
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320157; cv=none; b=JY8bBtPVL6MIn8KVwby1ftGyZSmJiNsH1sqPxnmkaT1SyLyx4bG3HZff03JLMS38Kmjouspq7NoSrPFAMUvOoFml5BLWj4Rh15UWz9aSGEbhVE1/EmRopdeRqcsNwktJWFFrQ4oF9M3EYzHB6MaOHBE6ZqoKRNfRh8HbUbe2NW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320157; c=relaxed/simple;
	bh=dXXbyyabO0MwPuorjDsinXOpaZyRolIc6uqqFVmIJxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OxtazRzfCVPzKWps1aF16vNUA5tQW7AtLZ+H4W3o1EHY1pXlVcwZnAiUskExMn09VJog/8lwIwBTlVXRlJI1eYc+ZT/1h7vA2hgNQPaX8LJ3WIvuN41OwFZ52QBY0+70bZpM2xWC9hDC1/Ox0WUzmd9nahujSvo6LpR/hJQF5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU+Cbqys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU+Cbqys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D0C1F00A3D;
	Wed, 29 Jul 2026 10:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785320156;
	bh=BxmoDY7bnWUNeIsPbWkYDEFoRbCCklsoHpBMGR22L8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LU+CbqysNTQoFT3dw7L+2fBloJ8vu9rNp4a4eK8K7UgijaooHzPsP+3/nQSgz/sGy
	 rplhK7hrUfjfxKvnv5u2kgDRuEepBS3Z4rWG0/QLXdQn9LkXd2sp82Us52LZa5yru3
	 tUnqSDDzHSL7n90dHBYjlCgPt8a6D8ezX276jCx+KMNsoi9Ev/50B1irO5qrteC9IG
	 pI9WlUyc6hJZJV5bZBLbBycT8J9oYlc6ytS5nLiSsq1syB7GnW0oKmeqzaWoDaFyT2
	 A0s6fP0eza5RQaHUbM9SpDKmLDjH3TX4bBZhlIzX/YEWQ/aGy0lBxqQyNdxnyZDbF1
	 Gfghg3taa3pWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/5] s390/zcrypt: Fix CPRB memory allocation in
 zcrypt misc code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260729095318.184141-2-freude@linux.ibm.com>
References: <20260729095318.184141-1-freude@linux.ibm.com>
 <20260729095318.184141-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 10:15:55 +0000
Message-Id: <20260729101556.13D0C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete memory scrubbing in CPRB free functions leaves paddin=
g bytes unzeroed.

Pre-existing issues:
- [High] Information leak of uninitialized kernel heap memory to AP hardwar=
e due to unpadded EP11 request lengths.
- [High] Incomplete fix in EP11 CPRB memory allocation causes valid 4-byte =
padded hardware replies to be rejected with -EMSGSIZE.
--

--- Patch [1]: [PATCH v7 1/5] s390/zcrypt: Fix CPRB memory allocation in zc=
rypt misc code ---
commit cba05c09d2194f550fb91ddbd8234cd389b1848a
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code

This commit rounds up the memory allocation for CPRB structures to a
multiple of 4 bytes. It ensures the base CPRB and parameter block are
aligned to a 4-byte boundary, which is required by the zcrypt layer.

> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/z=
crypt_ccamisc.c
> index 84936a795b956..0aa72593ae2bd 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> @@ -231,6 +232,10 @@ EXPORT_SYMBOL(cca_check_sececckeytoken);
>   * block, reply CPRB and reply param block and fill in values
>   * for the common fields. Returns 0 on success or errno value
>   * on failure.
> + * It is guaranteed that request and a possible param block
> + * are aligned to a 4 byte boundary. Furthermore if a param
> + * block is used, the memory allocated for this is rounded up to
> + * the next multiple of 4 bytes.
>   */
>  static int alloc_and_prep_cprbmem(size_t paramblen,
>  				  u8 **p_cprb_mem,
> @@ -239,7 +244,8 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
>  				  u32 xflags)
>  {
>  	u8 *cprbmem =3D NULL;
> -	size_t cprbplusparamblen =3D sizeof(struct CPRBX) + paramblen;
> +	size_t cprbplusparamblen =3D
> +		ALIGN(sizeof(struct CPRBX), 4) + ALIGN(paramblen, 4);

[Severity: Medium]
If the allocation size is rounded up here, do the corresponding
free_cprbmem() functions need to be updated to clear the padded size?

For example, in drivers/s390/crypto/zcrypt_ccamisc.c:free_cprbmem():

    memzero_explicit(mem, 2 * (sizeof(struct CPRBX) + paramblen));

And in drivers/s390/crypto/zcrypt_ep11misc.c:free_cprbmem():

    memzero_explicit(mem, sizeof(struct ep11_cprb) + payload_len);

Currently they use the unpadded lengths. Can this leave the padding bytes
unzeroed when freed, potentially leaking sensitive hardware response data
that spills into the padding?

[ ... ]

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
>  	struct ep11_cprb *cprb =3D NULL;
> =20
>  	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
> -		if (len <=3D CPRB_MEMPOOL_ITEM_SIZE)
> +		if (memlen <=3D CPRB_MEMPOOL_ITEM_SIZE)
>  			cprb =3D mempool_alloc_preallocated(cprb_mempool);
>  	} else {
> -		cprb =3D kmalloc(len, GFP_KERNEL);
> +		cprb =3D kmalloc(memlen, GFP_KERNEL);
>  	}
>  	if (!cprb)
>  		return NULL;
> -	memset(cprb, 0, len);
> +	memset(cprb, 0, memlen);

[Severity: High]
This is a pre-existing issue, but since we are aligning EP11 lengths, does
the AP message creation leak uninitialized kernel memory?

In drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx(),
the message length is rounded up:

    ap_msg->len =3D sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);

But only the unpadded length is copied into the buffer:

    if (z_copy_from_user(userspace, msg->userdata, (char __force __user *)x=
crb->req, xcrb->req_len))

Since drivers/s390/crypto/ap_bus.c:ap_init_apmsg() allocates the buffer
without __GFP_ZERO:

    ap_msg->msg =3D kmalloc(maxmsgsize, GFP_KERNEL);

Can the padding gap between xcrb->req_len and CEIL4(xcrb->req_len) leak up
to 3 bytes of uninitialized kernel heap memory to the AP hardware?


[Severity: High]
This is a pre-existing issue, but does aligning the memory allocation
resolve the EMSGSIZE failures if prep_urb() still uses the unpadded length?

In drivers/s390/crypto/zcrypt_ep11misc.c:prep_urb(), the unpadded length
is passed:

    u->resp_len =3D rep_len;

When the hardware replies with a 4-byte padded length,=20
convert_type86_ep11_xcrb() in drivers/s390/crypto/zcrypt_msgtype6.c
checks it against the unpadded resp_len:

    if (xcrb->resp_len < msg->fmt2.count1) {
        pr_debug("resp_len %u < required %u =3D> EMSGSIZE\n",
                 (unsigned int)xcrb->resp_len, msg->fmt2.count1);
        return -EMSGSIZE;
    }

Does this cause valid padded hardware replies to be rejected with
-EMSGSIZE for unaligned requests?

> =20
>  	cprb->cprb_len =3D sizeof(struct ep11_cprb);
>  	cprb->cprb_ver_id =3D 0x04;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729095318.1841=
41-1-freude@linux.ibm.com?part=3D1
