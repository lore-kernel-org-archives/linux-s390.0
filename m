Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4F435AB2
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902867; cv=none; b=UouHWYx8wfXrH8YVX5Y4hG0CJGeV6GChu2KbcQLOM3YWkqaowqXeTPTI/TdZbsecSSqrtRDeUSEqijMAS7X7fcSh4cp6wCQ63iMDT4vDugVf6QKBlyWqtiosANnoxOeq2Ea5aTe2n5MbmS7TrsUtjGD6kcXw6SwFqxlrwZYVNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902867; c=relaxed/simple;
	bh=hqia5KNOFwxS6OkvdaYZBMr839ZA9Q9ZoEXIJXrQftA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=myBj4Wb1kKM+yUayD1MGZDUaJB+NJEHiguvSsy2YeK5xBPNroahAsjXsKRtREinyc5ZsW82MREWxDR87k1vqsncCdjm9qKzINx4/NvmXtihM1cbOhOtpj9hvl73qb27T07MgP69Q+342Cr/qp/uN8Lc5mVt/tOuHCalw9a00Rtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjczZhc1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjczZhc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E611F000E9;
	Fri, 24 Jul 2026 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784902865;
	bh=RQbgTKfaZu7RgDC2r0eh90iqH1b9+l1q8KGaX0wqpRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OjczZhc14KI4UDeJp1POKk/ktDfCO7qzFRuJtfSUB+EhTv+FIRfLSrYS2JYndJLjx
	 yX4K+5URqeskk/DvnaKTOpWr93Vj9igTbakqOb4eoO+GO088mxAGJj1SmIx/HoO+kI
	 olD4anRp3lYKtJn2r7XVqD6bz2w8Fro230PUNEoTXyrRtodJeTbq6oZGeXdjA0Hs3T
	 sZoiT+xm7hRDXd21SnAzPIlijdCLcRfYSy9Oi6llMZ5ZtPjpkXqPJudf9BngdF/F5w
	 36587d/+Y+bXz0vj+KcXGlKzy4jVGW4ULXOyoDEQezWRz173jezbI82Is2ArYsJt1s
	 LV1bMEThmQ9Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] s390/zcrypt: Improve CCA CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260724134556.144597-2-freude@linux.ibm.com>
References: <20260724134556.144597-1-freude@linux.ibm.com>
 <20260724134556.144597-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:21:04 +0000
Message-Id: <20260724142105.78E611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the patch co=
mpletely misses identical logic flaws in the EP11 path (`xcrb_msg_to_type6_=
ep11cprb_msgx`). While the patch successfully fixes critical vulnerabilitie=
s in the CCA path, it leaves the kernel vulnerable to a catastrophic kernel=
 panic (DoS), uninitialized kernel memory reads, and an uninitialized memor=
y leak to hardware via the `ZSENDEP11CPRB` ioctl.
--

--- Patch [1]: [PATCH v4 1/2] s390/zcrypt: Improve CCA CPRB length and over=
flow checks ---
commit 0472132f230811c8d94963dccf05ca137d96d8ec
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve CCA CPRB length and overflow checks

This patch fixes integer overflows, minimum size validation, and potential
kernel memory leaks in xcrb_msg_to_type6cprb_msgx(). It adds U32_MAX
boundary checks, validates minimum control block sizes, and zeros trailing
bytes to prevent leaking uninitialized memory.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 40f72cdf284d3..2e4aef330b680 100644
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

[Severity: Critical]
This is a pre-existing issue, but does xcrb_msg_to_type6_ep11cprb_msgx()
need these same fixes?

It looks like the EP11 path has the same logic flaws that this patch fixes
for the CCA path. For example, if a large req_len is provided, couldn't the
length calculation wrap around and bypass the buffer size check?

drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx()
    ...
    ap_msg->len =3D sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
    ...

If the buffer size check is bypassed, could z_copy_from_user() fail
access_ok() and zero out the destination buffer with a massive length,
crashing the kernel?

drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx()
    ...
    if (z_copy_from_user(userspace, msg->userdata,
                         (char __force __user *)xcrb->req, xcrb->req_len)) {
    ...

Additionally, if req_len is very small, could this lead to uninitialized
memory reads when accessing msg->pld_lenfmt, since there doesn't appear to
be a minimum control block size check?

drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx()
    ...
    if ((msg->pld_lenfmt & 0x80) =3D=3D 0x80) { /*ext.len.fmt 2 or 3*/
    ...

Finally, if req_len requires padding, does the trailing padding get zeroed
out, or could it leak uninitialized kernel heap memory to the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724134556.1445=
97-1-freude@linux.ibm.com?part=3D1
