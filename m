Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38944756DB
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826070; cv=none; b=oA20lpS8Bjsisqv9Lia9c94vR3a7b9dPHXU4nmLAeQTQpMCEju0mB7GpPozQKk6v5d7slt6UepxvtOp7eObv3wn6xhM1waSd5xmQUCoETMB7LXyuIHIMPTvMvqIXQlMQqMMIrZEnq3qgjjOlnMFN7/dp0c7hOgvpRFymV1/AQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826070; c=relaxed/simple;
	bh=dTDucGM6//hBF85umjrIBGawGYgd3gWPEqyDnPzUWaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HB76nCAe7jq09ZaKAh+iqSBhLNLj/IGquJ0mGoacuJ+tvU0IkfoXb8ifrlIxsPKKFzDSi38ojHxO+J2ni9yoDEESAZ2QksZcFW6SonSS7WANqV8ihIMn1LvsSnTZLZjedmDI7eoj8KUSpyLLlQ3oCNFC8zR0NsO/21kjKHnGXpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ADA1F000E9;
	Thu, 23 Jul 2026 17:01:08 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] s390/zcrypt: Improve length check and overflow
 detection at zcrypt msg type 6
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260723164412.134500-2-freude@linux.ibm.com>
References: <20260723164412.134500-1-freude@linux.ibm.com>
 <20260723164412.134500-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 17:01:06 +0000
Message-Id: <20260723170108.73ADA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing minimum length checks on user-supplied CPRB blocks all=
ow uninitialized kernel memory reads, leading to authorization bypass.
--

--- Patch [1]: [PATCH v2 1/1] s390/zcrypt: Improve length check and overflo=
w detection at zcrypt msg type 6 ---
commit 87017972d7d7c12e7f847a32953e15083d57a2bb
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve length check and overflow detection at zcrypt msg type=
 6

This commit replaces CEIL4 macro overflow checks with check_add_overflow()
to prevent undefined behavior and buffer overflow vulnerabilities in
xcrb_msg_to_type6cprb_msgx() and xcrb_msg_to_type6_ep11cprb_msgx(). Size
variables are also converted from signed to unsigned types.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 40f72cdf284d3..d2ae58789aa31 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -342,19 +342,18 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspac=
e, struct ap_message *ap_msg,
>  		};
>  	} __packed * msg =3D ap_msg->msg;
> =20
> -	int rcblen =3D CEIL4(xcrb->request_control_blk_length);
> -	int req_sumlen, resp_sumlen;
> -	char *req_data =3D ap_msg->msg + sizeof(struct type6_hdr) + rcblen;
> -	char *function_code;
> +	u32 u, req_cblen, rep_cblen, req_sumlen, rep_sumlen;
> +	char *req_data, *function_code;
> =20
> -	if (CEIL4(xcrb->request_control_blk_length) <
> -			xcrb->request_control_blk_length)
> -		return -EINVAL; /* overflow after alignment*/
> +	if (check_add_overflow(xcrb->request_control_blk_length, 3, &u))
> +		return -EINVAL; /* would overflow at CEIL4 */
> +	req_cblen =3D CEIL4(xcrb->request_control_blk_length);
> =20
>  	/* length checks */
> -	ap_msg->len =3D sizeof(struct type6_hdr) +
> -		CEIL4(xcrb->request_control_blk_length) +
> -		xcrb->request_data_length;
> +	if (check_add_overflow(sizeof(struct type6_hdr), req_cblen, &u))
> +		return -EINVAL;
> +	if (check_add_overflow(u, xcrb->request_data_length, &ap_msg->len))
> +		return -EINVAL;
>  	if (ap_msg->len > ap_msg->bufsize)
>  		return -EINVAL;

[Severity: Critical]
This is a pre-existing issue, but is there a missing minimum length check
for xcrb->request_control_blk_length (and xcrb->req_len) here?

If an unprivileged user issues the ZSECSENDCPRB ioctl with an artificially
small request_control_blk_length, the message buffer allocated via kmalloc
is not zero-padded by z_copy_from_user.

Later in drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6cprb_msgx(),
the domain is read from potentially uninitialized memory:

	if (domain)
		*domain =3D msg->cprbx.domain;

The same applies to xcrb->req_len in xcrb_msg_to_type6_ep11cprb_msgx(),
where the target_id is also read from uninitialized memory:

	if (domain)
		*domain =3D msg->cprbx.target_id;

If this uninitialized memory happens to match AUTOSEL_DOM (0xFFFF), it
bypasses the authorization check in
drivers/s390/crypto/zcrypt_api.c:_zcrypt_send_cprb():

	if (perms !=3D &ap_perms && domain < AP_DOMAINS) {
		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
			if (!test_bit_inv(domain, perms->adm)) {
				rc =3D -ENODEV;
				goto out;
			}
		} else if ((ap_msg.flags & AP_MSG_FLAG_USAGE) =3D=3D 0) {

Since 0xFFFF is not less than AP_DOMAINS, the check is bypassed entirely.

Could this allow unauthorized users to execute privileged administrative
commands or access secure cryptographic keys belonging to other domains?

Would it make sense to add a lower bound check for these lengths to prevent
reading uninitialized kernel memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723164412.1345=
00-1-freude@linux.ibm.com?part=3D1
