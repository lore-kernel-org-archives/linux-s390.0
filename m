Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7A3F3293
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903353; cv=none; b=GYjcVh59oj6ug0D6bxEKcQcYJ71LCm+wF8c8zs5bslVnCrr6bTO+P4Ih4ookyp1re4hIx0+haWEDB038pzlaVW6bCXdluce5IC09LKC4w19DaHGeeAco6AAIWSjRQh24FhB/Gj5ndvS7iWDIpq9A5dIkcSNW0JMxOh8ljoa5Ip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903353; c=relaxed/simple;
	bh=4JeyyfNHxDHxu/xcSeh8gn7O2/lUre6F4gkey7NBfA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gpE6eV6ca8P196qsRVxXyTQfuAxoFue5Jyu20LHLWBEbVH4UVpsa743Ua2PauAeMSyuANpZPM4OOWdiLJs22XVIPCNHwlSu3Yua4OcutGy2mFTX2jgJgocjUsQCcppjS0ofFjpPTJdEjteed2yoGUkk7ZLnB/o2OW5vhOXJLYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgGFpJFZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgGFpJFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1CF1F000E9;
	Fri, 24 Jul 2026 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784903352;
	bh=U9cMTOXXD9g568iOnMLSK269H8BawQOJFCyCe4qoTBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RgGFpJFZodAFJzmNskQZGKH4gV0CoU0I8X9cagFnxGUIpParWUJT41WKId4ZbN2MH
	 MJjfu2ujeQCmHqIN9VASZjuCHov9yGKjMZw1xK8TjOrUSNK89XCR9hFk7wI5HErmTn
	 jySvnuzuqJ4UXx+mv/T8+ahDlh08HZkV7AY7yiM90i2WDPD97L0mODiAHmRuCDhpB3
	 +0RyWGYQoUV8IXJbnMNlkPW73Sqlo6JWRZ0Jb8LgGag2zmLHeTCZ8s5Vq68mYqVyDK
	 LXCG4F/tWXFOGzDm6SdxUdt14inlZub32SlFBEpokkBBj59hBh9cw01MiZqgqExnjv
	 FR7Y5it4HrbRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] s390/zcrypt: Improve EP11 CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260724134556.144597-3-freude@linux.ibm.com>
References: <20260724134556.144597-1-freude@linux.ibm.com>
 <20260724134556.144597-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:29:11 +0000
Message-Id: <20260724142911.9F1CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Incomplete minimum length check for EP11 CPRB requests leads to =
out-of-bounds reads and writes of uninitialized kernel heap memory.
- [Medium] Uninitialized padding bytes are leaked to the AP coprocessor har=
dware.
--

--- Patch [2]: [PATCH v4 2/2] s390/zcrypt: Improve EP11 CPRB length and ove=
rflow checks ---
commit 35795525c75a20e288cf1cb8e4a3621e47212c8d
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve EP11 CPRB length and overflow checks

The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
validation, creating security vulnerabilities:
1. Missing minimum size validation: The ep11_cprb structure and
   subsequent payload fields (pld_tag, pld_lenfmt) are copied from
   userspace without verifying sufficient buffer length.
2. Arithmetic overflow in length calculations: CEIL4 alignment could
   overflow, bypassing size checks and enabling buffer overflows.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 2e4aef330b680..6f49165d7732e 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -477,16 +477,24 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool use=
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

[Severity: Medium]
This is a pre-existing issue, but does this minimum length check ensure
enough data is copied for the payload header?

Later in xcrb_msg_to_type6_ep11cprb_msgx(), payload_hdr->func_val is access=
ed:

xcrb_msg_to_type6_ep11cprb_msgx() {
    ...
    payload_hdr =3D (struct pld_hdr *)((&msg->pld_lenfmt) + lfmt);
    *fcode =3D payload_hdr->func_val & 0xFFFF;
    ...
}

If xcrb->req_len is smaller than the required size for the payload header,
could this result in reading uninitialized kernel heap memory?

Additionally, could this lead to an out-of-bounds write in
zcrypt_msgtype6_send_ep11_cprb() when it assigns payload_hdr->dom_val?

> +	req_len =3D CEIL4(xcrb->req_len);
> +	if (req_len < xcrb->req_len || req_len > U32_MAX)
> +		return -EINVAL;
> +	ap_msg->len =3D sizeof(struct type6_hdr) + req_len;

[Severity: Medium]
This isn't a bug introduced by this patch, but do we need to zero out the
padding bytes added by CEIL4()?

If xcrb->req_len is not a multiple of 4, the length is rounded up, but the
padding bytes don't appear to be initialized. Could this leak up to 3 bytes
of uninitialized kernel memory to the AP hardware?

>  	if (ap_msg->len > ap_msg->bufsize)
>  		return -EINVAL;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724134556.1445=
97-1-freude@linux.ibm.com?part=3D2
