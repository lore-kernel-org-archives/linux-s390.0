Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D063DA7E6
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889240; cv=none; b=hOuEQXChuDR0Kx1U0NLd0BZq1NTgSlXMJOGRq4WPrLpUE1TR03E37KYEUDkKvorht38I2cG5/H0KJxglfsMvGWfwl8bdwm9iLM/QO/7Y2Gii8n3Kn6y+S12kTjKo3EFaNFZsXnS3vBGMIJc/wfFwwKG/KxA9vcE9jPasxlKTIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889240; c=relaxed/simple;
	bh=eQdN39JPnUzIFwRJ9nvc1z09TVHLUPOYzN8RpjxJBvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pUC5RQvj1EJl7DIxW5CaUWL3g4Wus83YIBSKoVKPmqXSmCvAEDSFVTbnE/AkAKtUDrcHMkO9F7LNqMDrRscHbz9JmaXRy3zwG18m128KP28/OeHL3XvONQ6cBY/04ZsIekPylMwPPUtP2hHFl2h4nf+R55seaxVErTW/kHDtGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXlHnfk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXlHnfk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93651F000E9;
	Fri, 24 Jul 2026 10:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784889239;
	bh=n1DzQAlOjLgAVoHFA05MS25iT4jNwcwn9G2Vw8cqM+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HXlHnfk6nF2p7Hq0e+d/rtGYrLnaUA73UMZxbc5zQjd8fiUSGaNiB69l05fPTSng6
	 owqxzM95uY5y5n/ljh0m2sk4TVcSxuzYnDCThAjdmnRGf4VJwKFQJQvk0zd8wlea0c
	 lBnXhkLaQVHfe4NZw5Yaa2sqi5QcD/f0KPwrOKJ67Q6Kqe/vkZORyzxU7DEuFvRDT8
	 FxnLWDNOe1CVuaY4PdvboNhMFLj5WHruqaOaXLK/GMgOTqYAx5IayNjklT5+KPCSz7
	 Urk+df8bC2YlsljyJ88OizaSwEESZTyaP47lAY8X3oCXAJtH0ZHz8bW6paG3Gny1rS
	 A3tog+R2VZ+ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] s390/zcrypt: Improve CCA CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260724095128.140810-2-freude@linux.ibm.com>
References: <20260724095128.140810-1-freude@linux.ibm.com>
 <20260724095128.140810-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:33:58 +0000
Message-Id: <20260724103358.B93651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing minimum size validation in `xcrb_msg_to_type6_ep11cprb_msg=
x` allows uninitialized memory access.
- [Medium] Uninitialized padding bytes from the kernel heap are leaked to t=
he crypto device hardware.
--

--- Patch [1]: [PATCH v3 1/2] s390/zcrypt: Improve CCA CPRB length and over=
flow checks ---
commit 67b21feb8736dd104c27309742d4f5d3ebdf4ba8
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve CCA CPRB length and overflow checks

This commit improves CCA CPRB length and overflow checks in
xcrb_msg_to_type6cprb_msgx(). It switches to using size_t for length
calculations and adds U32_MAX boundary checks after alignment. It also
introduces minimum control block size validation before copying data from
userspace.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 40f72cdf284d3..4ac767661cb50 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -342,49 +342,40 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspac=
e, struct ap_message *ap_msg,
>  		};
>  	} __packed * msg =3D ap_msg->msg;
> =20
> -	int rcblen =3D CEIL4(xcrb->request_control_blk_length);
> -	int req_sumlen, resp_sumlen;
> -	char *req_data =3D ap_msg->msg + sizeof(struct type6_hdr) + rcblen;
> -	char *function_code;
> +	size_t req_cblen, rep_cblen, req_sumlen, rep_sumlen;
> +	char *function_code, *req_data;
> =20
> -	if (CEIL4(xcrb->request_control_blk_length) <
> -			xcrb->request_control_blk_length)
> -		return -EINVAL; /* overflow after alignment*/
> -
> -	/* length checks */
> +	/* request length and overflow checks */
> +	if (xcrb->request_control_blk_length < sizeof(struct CPRBX))
> +		return -EINVAL;
> +	req_cblen =3D CEIL4((size_t)xcrb->request_control_blk_length);
> +	if (req_cblen > U32_MAX)
> +		return -EINVAL;
>  	ap_msg->len =3D sizeof(struct type6_hdr) +
> -		CEIL4(xcrb->request_control_blk_length) +
> -		xcrb->request_data_length;
> +		req_cblen + xcrb->request_data_length;

[Severity: Medium]
This is a pre-existing issue, but does this code leak uninitialized memory =
to
the hardware?

Because ap_msg->len incorporates the 4-byte aligned req_cblen, but the
subsequent z_copy_from_user() only copies xcrb->request_control_blk_length
bytes, the trailing padding bytes in ap_msg->msg could remain uninitialized.

When this message is sent over the bus, does this leak kernel heap data to =
the
crypto device hardware?

>  	if (ap_msg->len > ap_msg->bufsize)
>  		return -EINVAL;

[ ... ]

> @@ -437,10 +428,13 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspac=
e, struct ap_message *ap_msg,
>  	}
> =20
>  	/* copy data block */
> -	if (xcrb->request_data_length &&
> -	    z_copy_from_user(userspace, req_data, xcrb->request_data_address,
> -			     xcrb->request_data_length))
> -		return -EFAULT;
> +	if (xcrb->request_data_length) {
> +		req_data =3D ap_msg->msg + sizeof(struct type6_hdr) + req_cblen;
> +		if (z_copy_from_user(userspace, req_data,
> +				     xcrb->request_data_address,
> +				     xcrb->request_data_length))
> +			return -EFAULT;
> +	}
> =20
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while you are fixing the len=
gth
checks in xcrb_msg_to_type6cprb_msgx(), does xcrb_msg_to_type6_ep11cprb_msg=
x()
need similar minimum size validation?

In xcrb_msg_to_type6_ep11cprb_msgx(), there does not appear to be a check f=
or a
minimum size before reading xcrb->req_len bytes:

	/* Import CPRB data from the ioctl input parameter */
	if (z_copy_from_user(userspace, msg->userdata,
			     (char __force __user *)xcrb->req, xcrb->req_len)) {
		return -EFAULT;
	}

	if ((msg->pld_lenfmt & 0x80) =3D=3D 0x80) {

If an unprivileged user space application issues a ZSENDEP11CPRB ioctl with
req_len smaller than the required control block size, could this result in
subsequent code parsing uninitialized trailing bytes from msg->userdata?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724095128.1408=
10-1-freude@linux.ibm.com?part=3D1
