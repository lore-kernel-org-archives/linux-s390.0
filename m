Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894653B05B5
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341994; cv=none; b=pJrZkrOf2HOIMePKwZvo63mXD7TmwXjkJXb6CSRVckUE9av/Rlw1HMNdUQpCsUoSDHFpn+j75fmlaegYPeKbUb1xEeuj+9/5eJJfK0fV1kFJIqPeW6w05AixPOrzFzY8VsopGMgwhELAP3/bx6+BqhFWCGG9jZl0XlpRNhowzcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341994; c=relaxed/simple;
	bh=yhdw9DP+BHMnAZYtgY8FLfi73O0T5fhm9CX5PHDqwDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EsAgLDZUq7du3rdLGc3zEEbbt+9KMFwOepqKttSsdGYeIu5qBQRgeLSShojEzBwaQTcUYLwOTJbitGbNey85D0koDdTRk23CZWbUj1j76gfv1pOn15gHBHRQ0S8cbs3sZi53CMKsWe5FNvo693DFtb4sefQBuR7y12XJMy8YsoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMN/7iHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMN/7iHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC9A1F000E9;
	Wed, 29 Jul 2026 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785341991;
	bh=4I+rfb5KdqNksa98vGi0uckJM9A5hHR98jKqcc8521I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PMN/7iHYFVqTFyip2x5o6nRYWABMZFL4osZYed+vb792xGJQpb2L8HxruQiN6iqjS
	 T94eTUwe08Q/fQnubbfhzcWex7F4bRw3+9NqxzT1QICnLZAUWqFCN11D8LpNSknFxi
	 30Y1Zd8mo7iuldGuvTxHJI1ONI0eqkzr1Is+fFFFrFP31CUfXkIN5T6MplF9wQgY7g
	 eXuN8Qv0XYPPgeyrcc3MVyPOUU2pMvVUAMtyrWOcIZ7ZyJSFMGDG8WrToz/3AXV40d
	 aqF4axp8FfPAmL9cnZSzqwrtjx4hBYfuxQLTZVqTul9xNRo1i3940U3m+iHnLAxwlC
	 vuILRAKTAyfMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/5] s390/zcrypt: Improve CCA CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260729154458.195135-3-freude@linux.ibm.com>
References: <20260729154458.195135-1-freude@linux.ibm.com>
 <20260729154458.195135-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:19:50 +0000
Message-Id: <20260729161950.8DC9A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Uninitialized memory read due to incorrect bounds check when copyi=
ng subfunction code.
- [Low] Redundant and mathematically impossible integer overflow checks on =
64-bit sum calculations.

Pre-existing issues:
- [High] Missing minimum size validation for EP11 CPRB messages allows read=
ing uninitialized memory.
--

--- Patch [2]: [PATCH v9 2/5] s390/zcrypt: Improve CCA CPRB length and over=
flow checks ---
commit 93cf9dfadb28a27fc37f0252a7721661ccec467d
Author: Harald Freudenberger <freude@linux.ibm.com>
s390/zcrypt: Improve CCA CPRB length and overflow checks

This commit addresses integer overflow and missing bounds checks in the
xcrb_msg_to_type6cprb_msgx function during CCA CPRB processing. It introduc=
es
64-bit size_t variables for length arithmetic and explicitly bounds the
calculated lengths to U32_MAX. Minimum control block sizes are also validat=
ed
prior to copying data from userspace.

> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c

[ ... ]

> @@ -342,49 +342,40 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspac=
e, struct ap_message *ap_msg,
> +	req_sumlen =3D req_cblen + xcrb->request_data_length;
> +	if (req_sumlen > U32_MAX)
> +		return -EINVAL;
> +	if (req_cblen <=3D xcrb->request_data_length ?
>  	    req_sumlen < xcrb->request_data_length :
> -	    req_sumlen < CEIL4(xcrb->request_control_blk_length)) {
> +	    req_sumlen < req_cblen) {
>  		return -EINVAL;
>  	}

[Severity: Low]
Does this ternary check provide any value now that the lengths are using
64-bit size_t?

Since req_cblen and req_sumlen are bounded to U32_MAX, their sum cannot
overflow a 64-bit variable, making this condition impossible to reach.

[ ... ]

> @@ -404,8 +395,8 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace,=
 struct ap_message *ap_msg,
>  			     xcrb->request_control_blk_addr,
>  			     xcrb->request_control_blk_length))
>  		return -EFAULT;
> -	if (msg->cprbx.cprb_len + sizeof(msg->hdr.function_code) >
> -	    xcrb->request_control_blk_length)
> +	/* copy subfunction code into AP msg type 6 function code field */
> +	if (msg->cprbx.cprb_len > req_cblen - sizeof(msg->hdr.function_code))
>  		return -EINVAL;
>  	function_code =3D ((unsigned char *)&msg->cprbx) + msg->cprbx.cprb_len;
>  	memcpy(msg->hdr.function_code, function_code,

[Severity: High]
Can this modification lead to an uninitialized memory read?

If an attacker passes a CPRB request where xcrb->request_control_blk_length
is 13 bytes, the aligned req_cblen becomes 16. If they also set
cprbx.cprb_len to 14, z_copy_from_user() will copy only 13 bytes, leaving
the padding uninitialized.

The new bounds check allows cprb_len =3D 14 (since 14 is not greater than
16 - 2), and the code then copies 2 uninitialized bytes starting at offset =
14
into msg->hdr.function_code. This could leak kernel heap memory to the
crypto device and influence routing decisions.

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a similar missing
minimum size validation in xcrb_msg_to_type6_ep11cprb_msgx().

drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx() {
...
	/* Import CPRB data from the ioctl input parameter */
	if (z_copy_from_user(userspace, msg->userdata,
			     (char __force __user *)xcrb->req, xcrb->req_len)) {
		return -EFAULT;
	}

	if ((msg->pld_lenfmt & 0x80) =3D=3D 0x80) {
...
}

Does this function also need a minimum size validation?

If a user issues the ZSENDEP11CPRB ioctl with an EP11 user request block
where req_len is extremely small (e.g., 0), z_copy_from_user() will succeed
by copying 0 bytes. The kernel then evaluates fields like msg->pld_lenfmt,
msg->cprbx.flags, and msg->cprbx.target_id from uninitialized kernel heap
memory, potentially allowing bypasses of authorization boundaries.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729154458.1951=
35-1-freude@linux.ibm.com?part=3D2
