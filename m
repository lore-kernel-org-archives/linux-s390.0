Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F973A7194
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058135; cv=none; b=KeYeIv87r+l9Pe6xUzm0TUWZxJXfAuFtzoxu2GfuSVyZ0nDEryQMvgqLipLSl5ZZ1eMAaAVbFAs2dBh6EzoGjdVXbuO+6kZcmCxzr48NiOvzL9RmFogloHtT/Mr+qt3QRiAiXpAhEWZiW+M22jvXJTPPAYl5w7z4N3N1QXILJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058135; c=relaxed/simple;
	bh=ZHB8fGkO/pcY2ntLtZrmzwWlJM7ncrRHU85nyTHSHFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=luX9dVDcqEapwBEkBmOJfP4NohwfWrY4ECLA2DFuPUknkMiFoubut4Hbw8EkuX7T+uxX4eNy7+Lshd+S+cJ5T5jMnVFnjwymLolUkMm1VPyBhCEwY8SncQj1+b9WKcM48wlTor1cXrFLMytn1249p3PCAB6pviCaFdEYObH6SxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dznqte+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dznqte+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2F61F000FF;
	Thu, 10 Sep 2026 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058133;
	bh=jTLnFIGQdHIjJhzUEDYlZsYXoVjFcDB8DQn7OtZWUPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dznqte+wfic1RoAWttujO+JatKWNvTaaLW7qWx1Lfin0dx+5AgtjmgdSKN7J3PqXd
	 V4psqjCkv/1++CeIp42kJPipMC9YChUkx1exPjSYpyY9NJdAeod+OSpSeGdkHLMefP
	 buO+sORG5WmFUJtFmurTLhUntVDVcyI3V850FIG/oQ/hwAKqWOzAQeccmxTx2EJf4j
	 soU4jmsmiHWGf5VqrTO3eK/BE7mOnYivL91pfruocU8Lu6+Wp/m7qk080dAIpzxFUl
	 IOSvfFM1XvCPhKf5Vhb2MafPm4xs8HslO7s2jZf5PGJDHVq6wQ4uyHbeQpeqkQOix/
	 IBArUeDqcP1Pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/1] s390/zcrypt: Fix and improve zcrypt reply
 message verification checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260910161906.36251-2-freude@linux.ibm.com>
References: <20260910161906.36251-1-freude@linux.ibm.com>
 <20260910161906.36251-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 16:35:32 +0000
Message-Id: <20260910163532.CD2F61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Legitimate XCRB and RNG responses will be spuriously rejected due =
to enforcing an incorrect minimum length of sizeof(struct type86x_reply).
--

commit 991141a9c29feb41fbfdd37e1610a682977e72b6
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Fix and improve zcrypt reply message verification checks

This commit adds and improves checks related to buffer sizes and reply sizes
for CCA, EP11, and ICA messages in the zcrypt driver. It adds length
validation before accessing reply message structures to prevent out-of-boun=
ds
reads. It also reworks payload evaluation functions.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 3df1d676de5d8..a7d392272cfa2 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
[ ... ]
> @@ -820,6 +833,8 @@ static int convert_response_xcrb(bool userspace, stru=
ct zcrypt_queue *zq,
>  {
>  	struct type86x_reply *msg =3D reply->msg;
> =20
> +	/* reply->len is always >=3D sizeof(struct error_hdr) here */
> +
>  	switch (msg->hdr.type) {
>  	case TYPE82_RSP_CODE:
>  	case TYPE88_RSP_CODE:
> @@ -827,9 +842,14 @@ static int convert_response_xcrb(bool userspace, str=
uct zcrypt_queue *zq,
>  		return convert_error(zq, reply);
>  	case TYPE86_RSP_CODE:
>  		if (msg->hdr.reply_code) {
> -			xcrb->status =3D msg->fmt2.apfs;
> +			if (reply->len < sizeof(struct type86_fmt2_msg))
> +				xcrb->status =3D 0x0008044DL;
> +			else
> +				xcrb->status =3D msg->fmt2.apfs;
>  			return convert_error(zq, reply);
>  		}
> +		if (reply->len < sizeof(struct type86x_reply))
> +			return -EINVAL;

[Severity: High]
Does this code incorrectly reject legitimate XCRB responses?

It appears that this check assumes XCRB replies use the large ICA-specific
type86x_reply struct. If a userspace application sends a valid XCRB request
without a data payload, the hardware replies successfully without padding.

While zcrypt_msgtype6_receive() correctly computes len as offset1 + count1
and verifies it exactly matches the hardware reply length, this check evalu=
ates
reply->len < sizeof(struct type86x_reply). Since type86x_reply includes 6
additional bytes (pad[4] and length) intended only for ICA responses, its s=
ize
is larger than an empty-payload XCRB response.

Could this result in valid XCRB responses being rejected with -EINVAL,
causing a regression for userspace applications using the ICAXCRB ioctl?

>  		if (msg->cprbx.cprb_ver_id =3D=3D 0x02)
>  			return convert_type86_xcrb(userspace, zq, reply, xcrb);
>  		fallthrough;	/* wrong cprb version is an unknown response */
[ ... ]
> @@ -885,6 +909,8 @@ static int convert_response_rng(struct zcrypt_queue *=
zq,
>  {
>  	struct type86x_reply *msg =3D reply->msg;
> =20
> +	/* reply->len is always >=3D sizeof(struct error_hdr) here */
> +
>  	switch (msg->hdr.type) {
>  	case TYPE82_RSP_CODE:
>  	case TYPE88_RSP_CODE:
> @@ -892,6 +918,8 @@ static int convert_response_rng(struct zcrypt_queue *=
zq,
>  	case TYPE86_RSP_CODE:
>  		if (msg->hdr.reply_code)
>  			return -EINVAL;
> +		if (reply->len < sizeof(struct type86x_reply))
> +			return -EINVAL;

[Severity: High]
Does this check similarly apply a logically flawed minimum-size limit to RNG
hardware responses?

It seems this could fail if the hardware RNG response buffer size
configuration ever drops below the 6-byte delta caused by the ICA-specific
padding in type86x_reply.

>  		if (msg->cprbx.cprb_ver_id =3D=3D 0x02)
>  			return convert_type86_rng(zq, reply, data);
>  		fallthrough;	/* wrong cprb version is an unknown response */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910161906.3625=
1-2-freude@linux.ibm.com?part=3D1
