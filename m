Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0A40683F
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908664; cv=none; b=vCQgaaRk5QzjrMl45GPrQVLUeTj6rKWktOaie7ShNrXkVB0X+4K1av0tF4Dfs/heVRfzavXGy9tS0b+IaAipoAKlGx4kuuLmSNRrnkzfuj0Ofxgj7/GmWldMMwvKB1cQeKsqNgwQ1MNmlYLxVIfxnGimlgBJQs56vmLlElIelog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908664; c=relaxed/simple;
	bh=Oz+o+Vg8fw7opNBplpavFMVkRCSXMg0oG6ZFZiIlrEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YADUP3rCENQ/CCx2DfURtVGu37WYT5kK6kXA9tqBn4ziV+FT9M8Y97VlHt3S0fKhRV2hGyBitAWOZHv5TVMoVW98O1uYweigI4+bJIKRoyZiK5UMBmmKt2tNJp0CdzZhCeKyLwjmjXrfgOwsEYBO3emn1u0ZmgL7Fcvi5qV9xvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9ReeLXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9ReeLXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C101F000E9;
	Fri, 24 Jul 2026 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784908662;
	bh=iL/FID485mpdqnuAU6Mopl7iHvo2pMQ7ggoBWGpW6HU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n9ReeLXRq8wvz+B7f7vobKishkjklfoa0ghV5Qlg1o8EV/9xplH6nqzo/VLC9aDjY
	 ljVFEfqBfpAo5JDbWGcxxufIKwYyaLaAJnn/Ipi46YqFBJe9OAXYlKMkXdS6K4bRVj
	 GwYhlzSACwIUE6K8YoWwrtvUaWwaFSsg3y+qtHK/HZ3/B4tQfZrp2MsGYglnZ2BHsl
	 e3drDJOtWe4Ya29m2f8wjpD8uDhmnGZfybM4g8zk6dDePcwc5v5b0k/T2glDcljG4P
	 ytOuNkRKjLoyIBvB1OyrwV6Zj1j6M/rsRr1tQMc3hyl0gaFgdejszNjS05AuKDAuF6
	 g9dYMJIsqF6Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] s390/zcrypt: Improve EP11 CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260724151616.147765-3-freude@linux.ibm.com>
References: <20260724151616.147765-1-freude@linux.ibm.com>
 <20260724151616.147765-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 15:57:41 +0000
Message-Id: <20260724155742.61C101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Padding bytes introduced by CEIL4 alignment are not zero-initializ=
ed, causing up to 3 bytes of uninitialized kernel heap memory to be leaked =
to the crypto hardware over the AP bus. This problem wasn't introduced by t=
his patch, but it remains a security vulnerability.
--

--- Patch [2]: [PATCH v5 2/2] s390/zcrypt: Improve EP11 CPRB length and ove=
rflow checks ---
commit c3d8ef25f1e2612bc37abf0a2ac52df48c88d9ee
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve EP11 CPRB length and overflow checks

The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
validation, creating security vulnerabilities. This patch fixes these by
using size_t for length calculations, adding U32_MAX boundary checks after
alignment, and validating minimum request size and minimum reply size
before copying from userspace.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 2e4aef330b680..f7a504f5d54e3 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -477,16 +477,25 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool use=
rspace, struct ap_message *ap
[ ... ]
> +	req_len =3D CEIL4(xcrb->req_len);
> +	if (req_len < xcrb->req_len || req_len > U32_MAX)
> +		return -EINVAL;
> +	ap_msg->len =3D sizeof(struct type6_hdr) + req_len;
>  	if (ap_msg->len > ap_msg->bufsize)
>  		return -EINVAL;
> =20
> -	if (CEIL4(xcrb->resp_len) < xcrb->resp_len)
> -		return -EINVAL; /* overflow after alignment*/
> +	/* reply length and overflow checks */
> +	if (xcrb->resp_len < sizeof(struct ep11_cprb))
> +		return -EINVAL;
> +	rep_len =3D CEIL4(xcrb->resp_len);
> +	if (rep_len < xcrb->resp_len || rep_len > U32_MAX)
> +		return -EINVAL;
> =20
>  	/* prepare type6 header */
>  	msg->hdr =3D static_type6_ep11_hdr;

[Severity: High]
This is a pre-existing issue, but does this code leave up to 3 bytes of
uninitialized kernel memory in the message buffer when xcrb->req_len is not
4-byte aligned?

When copying the request data from userspace just below this code in
xcrb_msg_to_type6_ep11cprb_msgx():

	/* Import CPRB data from the ioctl input parameter */
	if (z_copy_from_user(userspace, msg->userdata,
			     (char __force __user *)xcrb->req, xcrb->req_len)) {
		return -EFAULT;
	}

The copy only transfers xcrb->req_len bytes. Because the message length
dispatched to the hardware includes the padding bytes up to CEIL4(xcrb->req=
_len),
uninitialized memory could be leaked.

Should there be a memset to zero-initialize the remaining padding bytes bef=
ore
the message is dispatched?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724151616.1477=
65-1-freude@linux.ibm.com?part=3D2
