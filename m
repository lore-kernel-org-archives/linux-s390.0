Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B11283C83
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747022; cv=none; b=kYtIxFSyIqM2nz+c283LDfS5SPvkjEstWoszK8H/0SCl8QvRYPfhl8cO56fhOYg3DECSfF9Q76jyJHx7JI0sro2Cm+lN5i8AmJT5emLUEvxkOCpPuxui8pfAlma+JCnmPSMY5ikKYa22m9Mz/j7Fq+yU19obaWoWw8idva6YZgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747022; c=relaxed/simple;
	bh=bE8CtM9wOOhd9Q2gNTBlySMqYuBT/kpbzKGdps+C7CM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gd2iy8jQKiQt+q3a6RcK3nO0PCo7brDOXkF6QS5xiy5u5PV4Df8NPwLwfhf7nDR36Dpgda+d/Zw08lyULjzZK24q4I/XXpFxYx/HghfCJy5bl7APhu41laiSrkDX+tjejon1QkDMfXcLYREx/GtYeRryjaOF9YacbaG0NQ3szWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSbRy4Gh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSbRy4Gh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E061F000E9;
	Mon,  3 Aug 2026 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785747021;
	bh=sOF6V2vYiCle26AiIDCZj67qzsCpdV0blS/o1PlZaHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gSbRy4GhnmuxVw5x7D5LGVXCxd0n5+OizwJiZoDwInX519IM74k6F8o/EzlVr4Y12
	 BwEdvOPT9OdSj4w93Xlm/WOd9byhy83ETXHztdD2zGhOc2ArI5GnwWeoTaRfR4x+fr
	 cPnaLRmOz/mIP0YDtBo0AK3pExJyCfzZl1VR7fYuue+jkLH0csqkQB5FvjVmzkBG5g
	 zwwAzpfMkJxI/T0oTFtD3y3vUjDw2BX2KmsbN/RSDRjvX+qKaoIZqC3yJqjSUeofFE
	 +tjz6Yf/uHFZ57GAgz6+nEN61H6JU9sr1n12ws8x6jzq0tN1U1zXmj7bLsOKy/Ez28
	 ykZmJAkfO2lmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/5] s390/zcrypt: Improve EP11 CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260803083339.212885-4-freude@linux.ibm.com>
References: <20260803083339.212885-1-freude@linux.ibm.com>
 <20260803083339.212885-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 08:50:20 +0000
Message-Id: <20260803085021.30E061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incomplete Fix / Domain Isolation Bypass. The patch introduces=
 proper ASN.1 parsing in `xcrb_msg_to_type6_ep11cprb_msgx()` to extract the=
 function code, allowing shorter encodings of `func_val` (e.g., 1 byte inst=
ead of 4). However, it fails to update the subsequent send function `zcrypt=
_msgtype6_send_ep11_cprb()`, which still uses a fixed-offset C struct (`str=
uct pld_hdr`) to overwrite the domain ID (`dom_val`) in the payload. Becaus=
e the EP11 hardware natively parses the ASN.1 payload, an attacker can supp=
ly a shorter `func_val` to shift the actual `dom_val` field. The driver wil=
l validate the request but overwrite the wrong offset, leaving the attacker=
-supplied domain ID intact. The hardware will then process the payload usin=
g the attacker-controlled domain ID, bypassing cryptographic domain isolati=
on.
--

--- Patch [3]: [PATCH v11 3/5] s390/zcrypt: Improve EP11 CPRB length and ov=
erflow checks ---
commit ded2aaf4bb041722a4604d826ab3b2f1e7bf5794
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve EP11 CPRB length and overflow checks

This commit fixes missing minimum size validation and arithmetic overflows
in xcrb_msg_to_type6_ep11cprb_msgx(). It introduces proper size checks and a
simple ASN.1 parsing mechanism for the payload up to the function value
field.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 3e19e79d747cf..7e1f76c935ee1 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -491,26 +540,51 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool use=
rspace, struct ap_message *ap

[ ... ]

> +	/* function length */
> +	if (offs >=3D pld_len)
> +		return -EINVAL;
> +	i =3D asn1_length_decode(pld + offs, pld_len - offs, &u);
> +	if (i < 0)
> +		return -EINVAL;
> +	offs +=3D i;
> +	if (offs >=3D pld_len || u > pld_len - offs)
> +		return -EINVAL;
> +	/* function value */
> +	i =3D asn1_int_decode(pld + offs, u, &u);
> +	if (i < 0)
> +		return -EINVAL;
> +	offs +=3D i;
> +	*fcode =3D 0xFFFF & u;

[Severity: Critical]
This is a pre-existing issue, but this updated parsing exposes a bypass of
the cryptographic domain isolation.

The new ASN.1 logic correctly parses a variable-length payload, allowing a
shorter encoding of func_val (e.g., 1 byte instead of 4). However, how does
the subsequent send function handle this?

Looking at zcrypt_msgtype6_send_ep11_cprb(), it appears to still use a
fixed C-struct offset to overwrite the domain ID:

drivers/s390/crypto/zcrypt_msgtype6.c:zcrypt_msgtype6_send_ep11_cprb() {
        ...
        payload_hdr =3D (struct pld_hdr *)((&msg->pld_lenfmt) + lfmt);
        payload_hdr->dom_val =3D AP_QID_QUEUE(zq->queue->qid);
        ...
}

If an unprivileged user issues an EP11 CPRB ioctl with a valid ASN.1 payload
containing a 1-byte function ID, wouldn't the fixed offset in
zcrypt_msgtype6_send_ep11_cprb() miss the actual dom_val field?

It seems this would result in the driver validating the request but
overwriting the wrong offset. This could leave an attacker-supplied domain
ID intact, allowing the EP11 hardware to process the payload using the
wrong domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803083339.2128=
85-1-freude@linux.ibm.com?part=3D3
