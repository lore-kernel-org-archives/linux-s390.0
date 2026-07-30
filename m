Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B89438468
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422156; cv=none; b=W/2/vbvKvIM4y1VOisNaW2kFI1Bzpgq3TB2g7T/8xo9JcsEnYgVsZj5Dz1mSIwmXk98FY35jJBFAC65F2WqPgynJ9sVflO2tGWpYqoS9frTvqC8w4c05zcFEDjzfoZbNWwC8ptmuTEHZaX6pSRZvjuY0PmmjpJly/L+LT/hZbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422156; c=relaxed/simple;
	bh=3uReK8yU4c2kuHn4zn1gyjX5hOQkp64E/AwKbpy3w20=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CK6nyQ0zbvUrtvHrONz1XudfRwY7Ka7br/CSgBh5O71kNHEE+ubQRKGrWPWbEnPWhTHiTe1eEqtVQ12nMyHPC0A72GVEIHJs9O9xWvHDXIS/DIeM++PBd8smzkDi9rq9Zqlxj7MfvjbvoyPXHC0Bn4aWGvaPZSIZi/UpiaUKPCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hChdNIZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hChdNIZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01AA1F000E9;
	Thu, 30 Jul 2026 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785422155;
	bh=4lb9berlIvfCMe6KF6501meEPSzTt1xa2V+aMqVEWc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hChdNIZL1lA9ySISDp4NSmbQbvw2o7ZuK9Ubq0fMTrNasNfVvluoRRUXPtPitTj3K
	 4afAH2W5rI5VU7dwU2oMLVH7TU7BZahe9wtyVSdGjjXEZ74Exy/etJxmBYHL9vwieW
	 wejCZCPsUUkceOYyfYhUSjplVoukfX4frAgAC3X0CnAXfW2J/VKttsseQBG8ZFPh4Y
	 Gr4P5lELZIyVHjA/KsKUFivxyI6Vi7LV55tvTtN8Scj5q4NXlthae9Ahah/soB0DHD
	 w9owLS6ar1VW6YBlp4uDobXjhXH+0gPV0gG3JWfLMIuVQ1GKkUyekQgBHF1s4uoYq8
	 bK3IjmReEliHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/5] s390/zcrypt: Improve EP11 CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260730141509.205970-4-freude@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
 <20260730141509.205970-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 14:35:54 +0000
Message-Id: <20260730143554.E01AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The ASN.1 parser in `xcrb_msg_to_type6_ep11cprb_msgx()` can read=
 one byte past the initialized user payload and branch on uninitialized mem=
ory if a maliciously crafted payload causes `offs` to exactly equal `pld_le=
n`.

Pre-existing issues:
- [Critical] The patch replaces the vulnerable C struct overlay parsing in =
`xcrb_msg_to_type6_ep11cprb_msgx()` with a dynamic ASN.1 parser, but comple=
tely misses `zcrypt_msgtype6_send_ep11_cprb()`. The send function still use=
s the flawed, hardcoded `struct pld_hdr` overlay to dynamically patch the d=
omain ID in the ASN.1 payload, allowing domain isolation bypass and data co=
rruption.
- [Medium] Up to 3 bytes of uninitialized kernel heap memory can be transmi=
tted to the hardware coprocessor due to unzeroed alignment padding.
--

--- Patch [3]: [PATCH v10 3/5] s390/zcrypt: Improve EP11 CPRB length and ov=
erflow checks ---
commit 92cbe0a3862e6fcbf60a93a6091ac8e0146860be
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve EP11 CPRB length and overflow checks

The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
validation, creating security vulnerabilities: missing minimum size
validation, arithmetic overflow in length calculations, and simple
c struct overlay for asn1 payload parsing. Fix by using size_t for
length calculations, adding boundary checks, and doing a very simple
asn1 parsing of the payload up to the function value field.

Cc: stable@vger.kernel.org # 7.1+

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c

[ ... ]

> @@ -492,26 +541,51 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool use=
rspace, struct ap_message *ap
> =20
>  	/* Import CPRB data from the ioctl input parameter */
>  	if (z_copy_from_user(userspace, msg->userdata,
> -			     (char __force __user *)xcrb->req, xcrb->req_len)) {
> +			     (char __force __user *)xcrb->req, xcrb->req_len))
>  		return -EFAULT;
> -	}

[Severity: Medium]
This isn't a bug introduced by this patch, but does this code leave the
CEIL4 alignment padding uninitialized?

When xcrb->req_len is not a multiple of 4, the calculated ap_msg->len
includes the CEIL4 padding, but z_copy_from_user() only copies the exact
requested bytes without zeroing the trailing bytes. Could this leak up to
3 bytes of uninitialized kernel heap memory to the hardware coprocessor?

[ ... ]

> +	/* payload length field */
> +	i =3D asn1_length_decode(pld + offs, pld_len - offs, &u);
> +	if (i < 0)
> +		return -EINVAL;
> +	offs +=3D i;
> +	if (offs > pld_len || u > pld_len - offs)
> +		return -EINVAL;

[Severity: Medium]
Does this bounds check allow an out-of-bounds read?

If a maliciously crafted payload has tag and length fields that consume
exactly pld_len bytes, the check offs > pld_len evaluates to false (for
example, when both are 6).

The parser then proceeds to the next line:

> +	/* function tag */
> +	if (pld[offs++] !=3D 0x04)

This would read past the end of the user-provided payload buffer. Should
this check ensure there is at least 1 byte remaining before reading the
function tag?

> +		return -EINVAL;
> +	/* function length */
> +	if (offs > pld_len)
> +		return -EINVAL;

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but does zcrypt_msgtype6_send_ep11_cprb()
also need to be updated to use the new ASN.1 parser instead of the C struct
overlay?

Looking at zcrypt_msgtype6_send_ep11_cprb() in this file, which was not
modified by the patch:

    payload_hdr =3D (struct pld_hdr *)((&msg->pld_lenfmt) + lfmt);
    payload_hdr->dom_val =3D AP_QID_QUEUE(zq->queue->qid);

If a user supplies a valid ASN.1 payload with a 1-byte or 2-byte function
value length, the kernel will patch the domain ID at a fixed offset since
it expects a 4-byte function value.

Could this overwrite the wrong bytes and leave the user-supplied domain ID
intact, potentially bypassing domain isolation when the hardware coprocessor
processes the request?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730141509.2059=
70-1-freude@linux.ibm.com?part=3D3
