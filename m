Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB03EC811
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337166; cv=none; b=COR0jzi8X9kTVN0mjKbanoArEXveRspGoBkMeAjEdOfR2/0DnDrmyWtWDd0n2gdyqoPO5/RU/RpbBTS0OFYZHtfox9e2AafnviX864NMOEwZUHIStRU86Et3jGw9V4HD2hAzg24ubRPVDKK9gG0uigQGDSfvXPeRMYRhZxgOdM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337166; c=relaxed/simple;
	bh=K4C0zvHLT44Xs44Y/m9VP/9H/jQUQOo/ZJmTuHozDKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GJmerfNXD/ml/Tejnu8kirw/PpVobY4idQmAuGvxRktWxh0KqEJAf6+u7UazQJq6PAmDZSBNL/AOly/xUgY1DYIW7DtJiVC1VoVhIt+yBXuzV31QzCJBgmHPZiS/RocgHfEP8XBJSOqKalBns1xl+8SiL8ACbhstUE1bTa3xhaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0j9pHsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0j9pHsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDF91F000E9;
	Wed, 29 Jul 2026 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337165;
	bh=/O1JtOQTGV/chrkVl3kmJMwXDuZRQWzk7AhTqvGYraI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N0j9pHspYfJ80ZcalzzKv4FNqDR6T2HdBUwBtne+ONyvDf/WRXtXwj5LEUovhrIai
	 oLyrMmnn9UsTimRHtRDSi+RA1ssCxtQAu1Lch9LrfgN58JpDrPr/J0RBC0ZWoYhAPe
	 F3F4jLWPG/tt8gaBwIguj+1fjJB6dopQH4zdv8ulSuoZB3yZ3i0EKFzZ1p4UjnkB9K
	 v9P/ALXpP3lWEEbddjlrmwjOI8mFSk2p9TPMQRm/iueznv+3TBWCBIpi9cfJ7iZsYZ
	 X+no9hioIC7yTed0Q+h+5bpYLsIuVUuXiV7VVXAWFLOhRvSacfFA2XaIpGBM1H6MJ/
	 BCaW6FAdCnKrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/5] s390/zcrypt: Improve CCA CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260729143928.191969-3-freude@linux.ibm.com>
References: <20260729143928.191969-1-freude@linux.ibm.com>
 <20260729143928.191969-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 14:59:24 +0000
Message-Id: <20260729145924.BBDF91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] An integer overflow in the length calculation of EP11 requests=
 bypasses the AP message buffer bounds check, leading to a massive heap buf=
fer overflow or immediate kernel panic during the `copy_from_user` operatio=
n.
- [High] The `xcrb_msg_to_type6_ep11cprb_msgx()` function does not verify t=
hat the user-provided `xcrb->req_len` is sufficiently large (e.g., at least=
 `sizeof(struct ep11_cprb)`) before copying from userspace, allowing unders=
ized requests to leave critical message fields populated with uninitialized=
 kernel memory.
--

--- Patch [2]: [PATCH v8 2/5] s390/zcrypt: Improve CCA CPRB length and over=
flow checks ---
commit 9af37e5b015a5cc6a88563feffcb032b0b3d9669
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve CCA CPRB length and overflow checks

The commit fixes integer overflows and missing length checks in
xcrb_msg_to_type6cprb_msgx() by validating input lengths and checking for
addition overflows.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 40f72cdf284d3..fb37e28c82424 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c

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
This isn't a bug introduced by this patch, but looking further down in the
same file, xcrb_msg_to_type6_ep11cprb_msgx() seems to have the same missing
minimum size validation that this patch fixes for CCA CPRB.

In drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx():

	/* Import CPRB data from the ioctl input parameter */
	if (z_copy_from_user(userspace, msg->userdata,
			     (char __force __user *)xcrb->req, xcrb->req_len)) {

If the user-provided xcrb->req_len is smaller than sizeof(struct ep11_cprb),
the rest of the message header could remain uninitialized. Could this result
in uninitialized kernel memory dictating control flow or being used to route
requests?

[Severity: Critical]
This is a pre-existing issue, but xcrb_msg_to_type6_ep11cprb_msgx() also
appears to suffer from the same integer overflow issue:

In drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx():

	/* length checks */
	ap_msg->len =3D sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
	if (ap_msg->len > ap_msg->bufsize)
		return -EINVAL;

If a user provides a large 64-bit xcrb->req_len like 0xFFFFFFFFFFFFFFB0,
could CEIL4(xcrb->req_len) wrap around, bypassing the ap_msg->bufsize
check, and resulting in a huge buffer overflow or kernel panic during the
subsequent z_copy_from_user()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729143928.1919=
69-1-freude@linux.ibm.com?part=3D2
