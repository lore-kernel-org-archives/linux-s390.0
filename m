Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89E4421229
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889144; cv=none; b=Y1OMg5Rw7W44GdmVEu7Wgbfrog4DMlZuXVKNQFj5vrlvGv11kUtCiCN8Emf75tY3aTWVIq9BA4Kz/Yt3j6MACcHXUMOAI57sdbi13JY2W0izJT7CJTIc8w3y/iovvSOaIS490OkKE3+x7ggpDpjHsg3saN6h+8+Md4LEpi/wXzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889144; c=relaxed/simple;
	bh=qBlGCqGMBMQSJiYrIwT0dD5n184ndHBJiaDXS0cauG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D8jW/lQgEreyr04YRCHs8Z+OTHyUeSj1csCw+PNAJdpOTDWj8ZIStzaCT9taNEA5+T+N55hm8y7KfnVlxSDlnp8fkzcK+abY9SWCXlpnc9pslwddPobBJ1LI3U+t9ZFKwW1p/V98MEg1MAf9bbmLSYIc/FibkMTvLIFxGwNWCJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHnGy6wj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHnGy6wj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818651F000E9;
	Fri, 24 Jul 2026 10:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784889140;
	bh=rqRq7bZ6tF5lCIH5awWSH3VAE3p31XsmHNyExF4RB5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WHnGy6wjhgWdx043ChkOSXmjw+ghiAiCxpXr/uw0Hi6EmeH6Pz3B90usBVtgkEkqG
	 d0m53D/aJJ1dsnAA9yUs8zoB/pvvF6hprNPUJDnlytAerPxUrS3NwWQScV9USqoBrl
	 2tszPf3V7Doww6O2neiO998Koa6DiK/PafZjbLO7IzewvUQdmlDPxCIJTSrKsUZ1SO
	 yKH3pt9SrOMpCJFy6p5OIiyjgQICVtbflIQgn7IOpBc3tVXVeU2ydTMDZz8kYAGqjA
	 PEqHWzg0/UMDLhyGvQ6xSK2+eM3Aowet+Zshs/eBr/WF0UaErvliQXoOXTVrLn5tHM
	 1eADtV/ezVTMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] s390/zcrypt: Improve EP11 CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260724095128.140810-3-freude@linux.ibm.com>
References: <20260724095128.140810-1-freude@linux.ibm.com>
 <20260724095128.140810-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:32:20 +0000
Message-Id: <20260724103220.818651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch replaces a working 64-bit integer overflow check with a =
flawed one, introducing a bypass for 64-bit wrap-arounds in the CEIL4 macro=
 that allows a Denial of Service (DoS) via usercopy hardening.
--

--- Patch [2]: [PATCH v3 2/2] s390/zcrypt: Improve EP11 CPRB length and ove=
rflow checks ---
commit b608e764c33b544400d55b5be70e199d907fd586
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve EP11 CPRB length and overflow checks

This commit modifies length and overflow checks for EP11 CPRB requests
and replies. It replaces an existing overflow check with a U32_MAX check
after alignment and adds minimum size validations before copying from
userspace.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 4ac767661cb50..3b56b7745588c 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -474,16 +474,24 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool use=
rspace, struct ap_message *ap
>  		unsigned int	dom_val;	/* domain id	   */
>  	} __packed * payload_hdr =3D NULL;
> =20
> -	if (CEIL4(xcrb->req_len) < xcrb->req_len)
> -		return -EINVAL; /* overflow after alignment*/
> +	size_t req_len, rep_len;
> =20
> -	/* length checks */
> -	ap_msg->len =3D sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
> +	/* request length and overflow checks */
> +	if (xcrb->req_len < sizeof(struct ep11_cprb) + 2 * sizeof(unsigned char=
))
> +		return -EINVAL;
> +	req_len =3D CEIL4(xcrb->req_len);
> +	if (req_len > U32_MAX)
> +		return -EINVAL;

[Severity: High]
Does this new check fail to detect 64-bit wrap-arounds that the old check
correctly caught?

If xcrb->req_len is set to U64_MAX - 1 (0xFFFFFFFFFFFFFFFE), the + 3 inside
the CEIL4 macro wraps around in 64-bit unsigned arithmetic to 1, causing
CEIL4 to evaluate to 0.

Since req_len becomes 0, the req_len > U32_MAX check passes, bypassing the
length validation.

Later in xcrb_msg_to_type6_ep11cprb_msgx(), z_copy_from_user() is called
with this massive, unvalidated xcrb->req_len:

	if (z_copy_from_user(userspace, msg->userdata,
			     (char __force __user *)xcrb->req, xcrb->req_len)) {

Could this large size passed to z_copy_from_user() trigger a WARN_ON_ONCE
in the kernel's usercopy hardening (check_copy_size) because bytes > INT_MA=
X,
potentially leading to a kernel panic in environments with panic_on_warn
enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724095128.1408=
10-1-freude@linux.ibm.com?part=3D2
