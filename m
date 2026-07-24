Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA824352002
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907566; cv=none; b=FkuY9x8alwId3BgrriaHLUlLZmpM4kZ8v1uAs3NGFO2P7RqbdWNeNkr1ucLuBfDA2rrlXzMfIQCdUcqgKc9V+1cr6DtDN88ysItymNH4TBRztvYccDLnxGWqGuNyI98uDXBeYSj27Hsd82/Of/SQiZP48N9YjC2CbOC0+MGSLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907566; c=relaxed/simple;
	bh=UfLELFh3MHkOFiC8fvsagdNDgHNFNwtc3aPnBgKR5NQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shLXwRxIl2985LkpJ0F0Y1nEwIj0LAu2ckBP31L6ocBZr203o3yFRP/0awoKmgfNBgcRJ/bXwcJhjF6u5rhQqc1yPfkqSZ5KRlOwvOa7EGByF4I6xQdPJnbm9xljrUx7BcKKQU8JRJeMxZyl2fmgMzBygoKQh4cqmkmobKLRC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+anUkal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+anUkal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278291F000E9;
	Fri, 24 Jul 2026 15:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784907564;
	bh=Lr8umF2nd5LnFmwFgV6yy6AKo2DJXbUS/EpTpNHOtFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+anUkalR0Cj+AUPr/c84qfYx3Rz9HY5Vk57bcz+H2FYTAn6uhkaTivmP4xDtRMQM
	 BjuTo+7bda410gLP5j6ajKuz4czjr37tkYKZhG5TKOuf7pN4Q6Lq0pbHQW3ck6Yj7E
	 GBSfOHUulcVQ1ueXiQ5WT4zxI/KPUvk+06s6n1aPN9Xd5hOrS73tU0qKi2Ekjq5bjo
	 u8SkCiQH+G7lOp1Me+iTY2BbLM1lUwcQOSZJ3x9KLLXaSA0kuNRA7PoIcrr5nguusb
	 gZyPIHL5JGvf7FSXeE81T7EN5cJHNd82xJ7cnREezyXMr6iky/9z540MrkIlHaA9Yl
	 jKWM1vKBAcWcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] s390/zcrypt: Improve CCA CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260724151616.147765-2-freude@linux.ibm.com>
References: <20260724151616.147765-1-freude@linux.ibm.com>
 <20260724151616.147765-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 15:39:23 +0000
Message-Id: <20260724153924.278291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer overflow in EP11 length calculation bypasses bounds ch=
eck, leading to DoS.
- [High] Missing minimum size validation and uninitialized padding memory l=
eak in EP11 message processing.
--

--- Patch [1]: [PATCH v5 1/2] s390/zcrypt: Improve CCA CPRB length and over=
flow checks ---
commit db060c7765ef46ae0c3f096c8f02b7e395cb8a36
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve CCA CPRB length and overflow checks

This commit fixes several security vulnerabilities in the CCA CPRB message
processing function by adding minimum size validation, fixing integer
overflows during alignment, and preventing memory leaks by zeroing trailing
bytes.

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

[Severity: High]
This isn't a bug introduced by this patch, but does the same missing size
validation issue exist in the EP11 counterpart
xcrb_msg_to_type6_ep11cprb_msgx() in the same file?

In xcrb_msg_to_type6_ep11cprb_msgx():

    ap_msg->len =3D sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);

Without a minimum size check on xcrb->req_len (e.g., against
sizeof(struct ep11_cprb)), could this parse uninitialized kernel memory from
ap_init_apmsg() if userspace passes a very small length via the
ZSENDEP11CPRB ioctl?

Later in the same function:

    if (msg->cprbx.flags & 0x80)
            ap_msg->flags |=3D AP_MSG_FLAG_ADMIN;

Could this uninitialized memory dictate administration privileges, or leak
uninitialized padding to the hardware?

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
This is a pre-existing issue, but could the lack of an overflow check in
xcrb_msg_to_type6_ep11cprb_msgx() lead to a denial of service?

In xcrb_msg_to_type6_ep11cprb_msgx(), the length calculation lacks similar
boundary checks:

    ap_msg->len =3D sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
    if (ap_msg->len > ap_msg->bufsize)
            return -EINVAL;

If a local user supplies a massive value for xcrb->req_len
(e.g., 0xFFFFFFFFFFFFFFF0), could CEIL4() wrap around a 64-bit boundary,
resulting in a small length that bypasses the bufsize check?

If bypassed, it would reach the copy operation:

    if (z_copy_from_user(userspace, msg->userdata,
                         (char __force __user *)xcrb->req, xcrb->req_len)) {

When copy_from_user() fails its access_ok check with this massive length,
would it execute memset(..., 0, 0xFFFFFFFFFFFFFFF0), causing an
out-of-bounds write that immediately panics the kernel?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724151616.1477=
65-1-freude@linux.ibm.com?part=3D1
