Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13B4195CD
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683825; cv=none; b=b5XoPcKwrMF9yuk6nD6E8uD6NBM2LX2vPNXevaIHXuVdb/j8ztydLrdRwHwUct5FGgwmvWJht8Q1uQ0Ui2OX454xY/ump61Y3g0vy5E0jlqmStuAZdrsrYTeCuUpunBuE3BpLeI61wkmheyDB+6Rj7tERF6VT1U9h7ga123N7+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683825; c=relaxed/simple;
	bh=DhSmTqhszdViJaVGZZS4aD/Ee+N3MIYleeVLCVZ/72Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V0iXT1K06XrdOdppwWRp6hppSZQUTffgEIsiBvDgGINgidhJ9WVIwYOZWPFeD4rflrRPmA13ss/O8DCzKSavLS5g+5Jd81YNJ0vbbh6i9P0JFIFbdeE+BInj8Naj1FP/RGVoo5vD6MUHUDtnDt3leG6RKXEpUGckzkq07lg04CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezpgh7wV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezpgh7wV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484231F000E9;
	Fri, 10 Jul 2026 11:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783683813;
	bh=/LWyD9eWBqeEBw068OythxbPiG5GQjNvNPuyIGZDWKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ezpgh7wVS6FjvtGJJkGsnUv/kCune2sKX8XQ1cmK4DVWcy7nq5/A53dYe2HVK4MgK
	 HDgsBy3/DkL4K0a8sDyyCGerXle2QCY6jo8imYNkQBLv3NJcanZMysKTvKVlTlkjzS
	 x2GkY4A9p6xxJP+RQbpyefqGb4YKqDq+YQNDtgyVQ82krhuV6IcvCNB0imvpLIQeQ2
	 9Bz3NN8PWJoiQuNWzxDaGkDyYtv+fCK64S4VtvHaNs4Hw3QWmjnFd3+OdwltwT7HN7
	 JGLmUcy1RqVqI7C6bkZppmJjDUJXP+mq8H1ngtNDY8AwIw/V8X1r+KBszTK3qkxtcx
	 zE13AQ6O64/TQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/1] s390/zcrypt: Improve zcrypt reply message
 verification checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260710112756.75346-2-freude@linux.ibm.com>
References: <20260710112756.75346-1-freude@linux.ibm.com>
 <20260710112756.75346-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 11:43:32 +0000
Message-Id: <20260710114333.484231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit integer overflow in reply length validation allows out-of-b=
ounds kernel memory read.
- [High] Missing bounds validation for `offset1` and `count1` when `count2`=
 is non-zero allows arbitrary kernel memory leak.
--

--- Patch [1]: [PATCH v4 1/1] s390/zcrypt: Improve zcrypt reply message ver=
ification checks ---
commit 6d9229604582e7a664ea0c26830d5edc37b47568
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve zcrypt reply message verification checks

This patch adds or improves checks related to buffer sizes and reply sizes
in the handling of CCA and EP11 replies from crypto cards. It changes reply
buffer sizes from int to size_t and adds a check for RNG replies to avoid
exceeding the hard-coded data buffer limit.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 40f72cdf284d3..ae175cab041b8 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -691,6 +691,13 @@ static int convert_type86_rng(struct zcrypt_queue *z=
q,
> =20
>  	if (msg->cprbx.ccp_rtcode !=3D 0 || msg->cprbx.ccp_rscode !=3D 0)
>  		return -EINVAL;
> +	/*
> +	 * Note that offset2 and count2 have already been checked in
> +	 * zcrypt_msgtype6_receive(). So only check for not exceeding
> +	 * the hard coded rng buffer size.
> +	 */
> +	if (msg->fmt2.count2 > ZCRYPT_RNG_BUFFER_SIZE)
> +		return -EMSGSIZE;
>  	memcpy(buffer, data + msg->fmt2.offset2, msg->fmt2.count2);

[Severity: High]
This is a pre-existing issue, but does this bounds checking fully prevent
out-of-bounds reads if the offset2 and count2 values wrap around?

In zcrypt_msgtype6_receive(), len is calculated as:

    len =3D t86r->fmt2.offset2 + t86r->fmt2.count2;

If the firmware provides values that wrap modulo 2^32 (for instance,
offset2 =3D 0xFFFFFFE0 and count2 =3D 0x40), the sum is evaluated as an add=
ition
of two 32-bit unsigned integers before being zero-extended to size_t.

The wrapped value could match the hardware's reply->len and bypass the
subsequent len > msg->bufsize checks.

This would allow the memcpy() here to read out-of-bounds kernel memory.

Could a malicious or faulty CEX card firmware trigger an out-of-bounds read
of kernel memory with this wrap around?

[ ... ]

> @@ -853,7 +860,7 @@ static void zcrypt_msgtype6_receive(struct ap_queue *=
aq,
>  	};
>  	struct ap_response_type *resp_type =3D &msg->response;
>  	struct type86x_reply *t86r;
> -	int len;
> +	size_t len;
> =20
>  	/* Copy the reply message to the request message buffer. */
>  	if (!reply)
>  		goto out;	/* ap_msg->rc indicates the error */

[Severity: High]
This isn't a bug introduced by this patch, but does the bounds check in this
function correctly validate offset1 and count1 when count2 is non-zero?

When processing a CEXXC_RESPONSE_TYPE_XCRB response, the length validation
logic checks:

drivers/s390/crypto/zcrypt_msgtype6.c:zcrypt_msgtype6_receive() {
	...
		case CEXXC_RESPONSE_TYPE_XCRB:
			if (t86r->fmt2.count2)
				len =3D t86r->fmt2.offset2 + t86r->fmt2.count2;
			else
				len =3D t86r->fmt2.offset1 + t86r->fmt2.count1;
			if (len > reply->bufsize || len > msg->bufsize ||
	...
}

If t86r->fmt2.count2 is non-zero, only offset2 and count2 are validated.

However, in convert_type86_xcrb(), offset1 and count1 are unconditionally
used to copy kernel memory to userspace:

drivers/s390/crypto/zcrypt_msgtype6.c:convert_type86_xcrb() {
	...
	if (z_copy_to_user(userspace, xcrb->reply_control_blk_addr,
			   data + msg->fmt2.offset1, msg->fmt2.count1))
		return -EFAULT;
	...
}

Could firmware provide a valid count2 and offset2 alongside maliciously
large offset1 and count1 values to leak kernel memory to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710112756.7534=
6-2-freude@linux.ibm.com?part=3D1
