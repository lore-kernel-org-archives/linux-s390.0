Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281DD3BE62B
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142046; cv=none; b=UZyiN5eo6eqXiZ5hW83jtY2ID5I3Pc2MnPhysQ9SWb03P3kYJ5hE7QfAceliR3ZQFvxuWwr+OpiZQcUr/KC7s9nEkBhbZOod7YgGDHQsvPcjJr//Z+9lV/2Mrw2yBySyvl/JP5LXVR/CBy6LvUXZcjXNmcNLrSqF9X3c4Uu2AkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142046; c=relaxed/simple;
	bh=EaRZB1J5hw+145kQv/qwsSgI9JSXAEtopfuWgglEzeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g0p5yTm1MyZVr9htNk3+W1yj63PDuqPKHC9z6uJHT/zv0L0aqe69jxbRMvg6qZawi06/CBOHMsb9l1neULnLSf+2yQUIuc50HyQ7VChSrUYr+2I2HrthxKXJnQg4tRuXLUBUFTqZc78VfzohhunJP/As4bjtwZsmargMJ3tk/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7cgTz75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7cgTz75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9039D1F000E9;
	Mon, 27 Jul 2026 08:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785142044;
	bh=ejs2QM7pQt44fFUbfvwF89f1ASg76guHW4B3jA9R29E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J7cgTz75ScRhNwher3Byq80yAYGwploztP9bFm8ev8Yk6IN1RtPP/FjPzQPeZ0CkB
	 ZmEddr5f1ce9ygewjpC6PpjIx+OsyKNFjZ1x+/Y5lXR5937+Y+Qlbc+sPXWjknAfdR
	 7M2XU9tt4Dn84em6eCpHqvgvQO5avJIt78/p7LuTWDsKAcaQpaGlzRfOZsJO4KUDw1
	 /JBF+A6FhDjqQcorkr48wLuOPAKKcQ4Rzh+pRa7ETbmgwgJBQV6/VqQ9m7iPVs/OGw
	 EsoV+/I4Wl/geEKfejQ406trgIhe2ED1GM0O29JN2xbXN25VJZW5xErgJUwoGVQ+fU
	 57xBHs7gwyzfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] s390/zcrypt: Improve CCA CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260727083200.151976-2-freude@linux.ibm.com>
References: <20260727083200.151976-1-freude@linux.ibm.com>
 <20260727083200.151976-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 08:47:24 +0000
Message-Id: <20260727084724.9039D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer overflow in `xcrb_msg_to_type6_ep11cprb_msgx` allows b=
ypassing message length checks, leading to an out-of-bounds `memset` in `co=
py_from_user` that panics the kernel.
- [High] Missing minimum size validation in `xcrb_msg_to_type6_ep11cprb_msg=
x` allows uninitialized memory access.
- [High] Kernel memory leak via uninitialized alignment padding bytes in `x=
crb_msg_to_type6_ep11cprb_msgx`.
- [High] The driver trusts length and offset values (`offset1`, `count1`) f=
rom the hardware's type86_fmt2 message without fully checking them against =
the received message length, which can lead to an out-of-bounds kernel memo=
ry read.
--

--- Patch [1]: [PATCH v6 1/2] s390/zcrypt: Improve CCA CPRB length and over=
flow checks ---
commit 7784ed33ea5e9edca90b3daa3295185e1ce64459
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve CCA CPRB length and overflow checks

The xcrb_msg_to_type6cprb_msgx() function lacks proper input validation,
creating several security vulnerabilities including integer overflows, miss=
ing
minimum size validations, and a potential kernel memory leak. This patch fi=
xes
these issues by using size_t for length calculations, adding boundary check=
s,
and zeroing trailing bytes.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 40f72cdf284d3..2e4aef330b680 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -342,49 +342,40 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspac=
e, struct ap_message *ap_msg,
[ ... ]
> -	if (CEIL4(xcrb->request_control_blk_length) <
> -			xcrb->request_control_blk_length)
> -		return -EINVAL; /* overflow after alignment*/
> -
> -	/* length checks */
> +	/* request length and overflow checks */
> +	if (xcrb->request_control_blk_length < sizeof(struct CPRBX))
> +		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but it appears a similar missing
minimum size validation exists in xcrb_msg_to_type6_ep11cprb_msgx().

Can a small req_len (e.g., 0) cause reads of uninitialized kernel heap memo=
ry
when extracting fields like pld_lenfmt or flags?

drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx() {
    ...
    if ((msg->pld_lenfmt & 0x80) =3D=3D 0x80) {
    ...
}

> +	req_cblen =3D CEIL4((size_t)xcrb->request_control_blk_length);
> +	if (req_cblen > U32_MAX)
> +		return -EINVAL;
>  	ap_msg->len =3D sizeof(struct type6_hdr) +
> -		CEIL4(xcrb->request_control_blk_length) +
> -		xcrb->request_data_length;
> +		req_cblen + xcrb->request_data_length;
>  	if (ap_msg->len > ap_msg->bufsize)
>  		return -EINVAL;

[Severity: Critical]
This is a pre-existing issue, but it looks like xcrb_msg_to_type6_ep11cprb_=
msgx()
has an integer overflow similar to the one fixed in this patch.

Can a massive req_len cause an integer overflow when computing ap_msg->len,
bypassing the ap_msg->bufsize bounds check?

drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx() {
    ...
    ap_msg->len =3D sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
    ...
    if (z_copy_from_user(userspace, msg->userdata,
                         (char __force __user *)xcrb->req, xcrb->req_len)) {
    ...
}

If z_copy_from_user() is called with the large length, the copy_from_user()
fallback memset could write outside the allocated kernel buffer.

[ ... ]
> @@ -404,6 +395,9 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace,=
 struct ap_message *ap_msg,
>  			     xcrb->request_control_blk_addr,
>  			     xcrb->request_control_blk_length))
>  		return -EFAULT;
> +	if (xcrb->request_control_blk_length < req_cblen)
> +		memset(msg->userdata + xcrb->request_control_blk_length,
> +		       0, req_cblen - xcrb->request_control_blk_length);

[Severity: High]
This is a pre-existing issue, but does xcrb_msg_to_type6_ep11cprb_msgx() le=
ak
kernel memory via uninitialized alignment padding bytes in a similar way?

The buffer length sent to the hardware incorporates alignment, but only req=
_len
bytes are copied, leaving padding bytes uninitialized:

drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx() {
    ...
    if (z_copy_from_user(userspace, msg->userdata,
                         (char __force __user *)xcrb->req, xcrb->req_len)) {
    ...
}

[ ... ]
> @@ -437,10 +431,13 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspac=
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
This isn't a bug introduced by this patch, but does convert_type86_xcrb()
trust length and offset values from the hardware without fully checking the=
m?

zcrypt_msgtype6_receive() only validates offset2 and count2 if count2 is
non-zero, ignoring offset1 and count1 during the bounds check:

drivers/s390/crypto/zcrypt_msgtype6.c:zcrypt_msgtype6_receive() {
    ...
    if (t86r->fmt2.count2)
        len =3D t86r->fmt2.offset2 + t86r->fmt2.count2;
    ...
}

Later, convert_type86_xcrb() uses offset1 and count1 for a copy to user spa=
ce
without verifying they are within the initialized message buffer:

drivers/s390/crypto/zcrypt_msgtype6.c:convert_type86_xcrb() {
    ...
    if (z_copy_to_user(userspace, xcrb->reply_control_blk_addr,
                       data + msg->fmt2.offset1, msg->fmt2.count1))
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727083200.1519=
76-1-freude@linux.ibm.com?part=3D1
