Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06380485505
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132794; cv=none; b=RwysTLnExV2Bk4QRVp8aprLlJ85N6oWDnlvzrzl+cU+QAKFzese7Y9gY70GYE0JAUJSBFSkHn6lP3NQISr25lSLEh1htJ4hm5rYJm4ihCasB8+hggqkAP5SzGs2v+qOATZJR2RrGrlmX0ihjtq8JBUGanFS+7SPXhINpEeCI7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132794; c=relaxed/simple;
	bh=3IoTbul1OIKUfMaXG8rvMJ2k7/ZMW/O9DgIuBitgqYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bqbaylWMij1w6EyOB0mV6BsMnBAHpXuOdcb+uwzFwrKq17/Tbp+DffwEtDmbodzsacyciZXVbGaUbV46MWsxSQEOXkrKeMf0K8qFl9cPCjFY8xd/Jl/FteznOsrdXTlHHC21L5h70WkFj91Th/YnFKistTEs1m3sM5ibkcXLvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4chhsbK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4chhsbK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF281F000FF;
	Fri, 11 Sep 2026 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132786;
	bh=Os5vsej/sJTuscl2aIUBSd27vo29ee0g1dK2oL9Eab0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q4chhsbKQ4OXJosCgiw3VBVk47W3Sr138ftYv4ui2Wj3mq+bxxq1C7y5e5xVo30cN
	 aG9vOPq8Iga0Sb8woKHwSFxrFd//WszSfg8KzoOZ2vemVIKcdcmeIMBgtplvNZbrlW
	 I/wtyxmFwQvSavXW0+VQkwEcWRMgMOcqxHEjLKkjdFd8Z2Av77UbyUf7z7v40glb4K
	 Z8Vzli8I4qdJXVmZm3552/4fB1PHJWm0F2moB047Gf7jwjhIMnCxwRaVnN6b2kZme0
	 XjuMTqfcUcbbUxdrAjqdGDbKw41WuHaAxyAPwX1jKmnz1w3SXbz861OgIYrZj7BmSE
	 fvjUVAkLjXG+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/1] s390/zcrypt: Fix and improve zcrypt reply
 message verification checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260911130544.43484-2-freude@linux.ibm.com>
References: <20260911130544.43484-1-freude@linux.ibm.com>
 <20260911130544.43484-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 13:19:45 +0000
Message-Id: <20260911131946.6BF281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Strict length checks placed before error checks in convert_respons=
e_ica and convert_response_ep11_xcrb break retry logic for short error repl=
ies.
--

commit 8039067e4a9fd6e25e23de18df187889de05156f
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Fix and improve zcrypt reply message verification checks

This commit improves boundary checks and reply size validations in the
zcrypt device driver to prevent out-of-bounds memory accesses. Length
validations are added before processing reply structures for CCA, EP11,
and ICA messages.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 3df1d676de5d8..9bd08f0376c33 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
[ ... ]
> @@ -777,11 +786,15 @@ static int convert_response_ica(struct zcrypt_queue=
 *zq,
>  {
>  	struct type86x_reply *msg =3D reply->msg;
> =20
> +	/* reply->len is always >=3D sizeof(struct error_hdr) here */
> +
>  	switch (msg->hdr.type) {
>  	case TYPE82_RSP_CODE:
>  	case TYPE88_RSP_CODE:
>  		return convert_error(zq, reply);
>  	case TYPE86_RSP_CODE:
> +		if (reply->len < sizeof(struct type86x_reply))
> +			return -EINVAL;

[Severity: High]
Does this length check preempt the error handling for short hardware error
replies?=20

If the hardware returns a short TYPE86 error reply (such as format 1 TYPE86
errors which are only 8 bytes), it appears this will immediately return
-EINVAL before the msg->hdr.reply_code check can process it.

This bypasses the error conversion and retry logic in convert_error() for
transient hardware or bus errors (e.g., REP82_ERROR_TRANSPORT_FAIL), causing
them to falsely propagate as invalid arguments to userspace applications
instead of being retried.

>  		if (msg->cprbx.ccp_rtcode &&
>  		    msg->cprbx.ccp_rscode =3D=3D 0x14f &&
>  		    outputdatalength > 256) {
[ ... ]
> @@ -854,11 +876,15 @@ static int convert_response_ep11_xcrb(bool userspac=
e, struct zcrypt_queue *zq,
>  {
>  	struct type86_ep11_reply *msg =3D reply->msg;
> =20
> +	/* reply->len is always >=3D sizeof(struct error_hdr) here */
> +
>  	switch (msg->hdr.type) {
>  	case TYPE82_RSP_CODE:
>  	case TYPE87_RSP_CODE:
>  		return convert_error(zq, reply);
>  	case TYPE86_RSP_CODE:
> +		if (reply->len < sizeof(struct type86_ep11_reply))
> +			return -EINVAL;

[Severity: High]
Similarly, does this strict length check break the error processing and ret=
ry
mechanism for EP11 requests if a short TYPE86 error reply is returned?

>  		if (msg->hdr.reply_code)
>  			return convert_error(zq, reply);
>  		if (msg->cprbx.cprb_ver_id =3D=3D 0x04)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911130544.4348=
4-2-freude@linux.ibm.com?part=3D1
