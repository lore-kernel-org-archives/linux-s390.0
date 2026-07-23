Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394BF23D7E6
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823789; cv=none; b=QYadXdm1c12gT9gloTui+VOiVh/UM7KKcjDvygncXwxUcNr7ScTpdp481Ti8e9AJu5Skk0gsryomE4yO2HpHJy6XojZgTLmgFPLQLrB/ev2IOVJ9eC2E2aONF3k1uC8JCJy/uZOInzbL6XG8nnaWulAhWpvTRc9QMi9X24tGJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823789; c=relaxed/simple;
	bh=FrFybG6n+nuyt3WuazQWZ+Mfp4nYx9vw1+l4bkgBNFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OsnLTols1Qm/njVuOxApdeVOlM8DoryNp4oHIFO84+20K1/h3qYcsualLmxmA0hMgvEJYGHaxNDF+BLw3t+QLmpJ1lGfKAUGh5Y3oHneLeS1YctXDowjqkLyqN4w3IotPMTUMxWYTTcHNbHZgB0mwf6b1ac0EFdEBw7EqgnHy60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA7C1F00A3A;
	Thu, 23 Jul 2026 16:23:07 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] s390/zcrypt: Improve length check and overflow
 detection at zcrypt msg type 6
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260723161037.133395-2-freude@linux.ibm.com>
References: <20260723161037.133395-1-freude@linux.ibm.com>
 <20260723161037.133395-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 16:22:56 +0000
Message-Id: <20260723162307.7FA7C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Heap buffer overflow in xcrb_msg_to_type6cprb_msgx() due to mi=
ssing ap_msg->bufsize bound check.
--

--- Patch [1]: [PATCH v1 1/1] s390/zcrypt: Improve length check and overflo=
w detection at zcrypt msg type 6 ---
commit 817ae0ed2183d762b91c6888629d3fa414135f83
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve length check and overflow detection at zcrypt msg type=
 6

This commit replaces manual overflow checks with check_add_overflow() and
changes some variable types to unsigned. It also aims to prevent buffer
overflow risks by improving message length calculations.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 40f72cdf284d3..8bf735a643835 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -342,50 +342,49 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspac=
e, struct ap_message *ap_msg,

[ ... ]

>  	/* length checks */
> -	ap_msg->len =3D sizeof(struct type6_hdr) +
> -		CEIL4(xcrb->request_control_blk_length) +
> -		xcrb->request_data_length;
> -	if (ap_msg->len > ap_msg->bufsize)
> +	if (check_add_overflow(sizeof(struct type6_hdr), req_cblen, &u))
>  		return -EINVAL;
> +	if (check_add_overflow(u, xcrb->request_data_length, &u))
> +		return -EINVAL;
> +	ap_msg->len =3D u;

[Severity: Critical]
Does removing the check against ap_msg->bufsize allow an arbitrarily large
length to bypass validation?

If u is successfully calculated without integer overflow but is larger than
ap_msg->bufsize, it appears the subsequent calls to z_copy_from_user() could
write out of bounds into the ap_msg->msg heap buffer:

drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6cprb_msgx() {
	...
	/* prepare CPRB */
	if (z_copy_from_user(userspace, msg->userdata,
			     xcrb->request_control_blk_addr,
			     xcrb->request_control_blk_length))
		return -EFAULT;
	...
	/* copy data block */
	if (xcrb->request_data_length) {
		req_data =3D ap_msg->msg + sizeof(struct type6_hdr) + req_cblen;
		if (z_copy_from_user(userspace, req_data,
				     xcrb->request_data_address,
				     xcrb->request_data_length))
			return -EFAULT;
	}
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723161037.1333=
95-2-freude@linux.ibm.com?part=3D1
