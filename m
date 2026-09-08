Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606255930F
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874665; cv=none; b=B/9ruU4aIMLDuQDvwESl7sM57ynSnhqJtiyobqxbemhF/c1vahPea89XD7nElnZoaKHyo9BqDjH033+JzHnrpiZ4Ha/u6B34WEe22XuzQR0n/TzgOJZM3jZNN7BfHY5DTNaW8QNg2umwEXFb4an5ZmPNVp0ucliAroAvO0i0RNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874665; c=relaxed/simple;
	bh=7R8yLBbz0DVC949U36addudfJEyeBrMn+74z8DzsWlU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ao4/YUe2yxPw5fSR9pcRgj9FPytxYAyS05odnVqOQZtPA//xl3iYxc5CZOJ9moukgG5VjUnyTQQ5o6/2Dc2y8uSXQeB6W5pnPDgVnjmfjnYvV1rovATj68opllX+oChvFnfZK9+w5VyiPHxgPoFiM5qH+J7ERZC7fnI7nMIRnfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyZtpdKU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyZtpdKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8391F00A3F;
	Tue,  8 Sep 2026 13:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788874649;
	bh=m8mIdzlwozZVZOBSHL1kd5SLD5yunmC1baXofwJKhp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LyZtpdKURGpwukWY5iRhfq127Skv1dnVNAVbTh4p9awKUrmC9Xkb/FGSNpIPP4tEC
	 NhW772tevf6uibkTbymY1eyXuiiFf7M3KJJuMWj1Tl9H1mLd4bYRPpd3LD6JougvGx
	 BJ0rPC525p7YgXwFMc8WRJyrmkV4ACLikKOMSTvyPBOpy7hwkt/flGXE3iUe3pk+6w
	 5e3bPsAs+o2Xiiz3/fbSfkPBFxtioMsZ5LosJ0G0JlQLlJFA4wUqnrNc3c40bjsf5F
	 yxEzabyzHiuX6fsxGJCR6rtfFRybHgLlO0Sl/+CXFxecdwFKUXZ7WGZ4hHL9cJl9pA
	 3QDKYr3AhtNNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] s390/zcrypt: Fix and improve zcrypt reply
 message verification checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260908131817.17644-2-freude@linux.ibm.com>
References: <20260908131817.17644-1-freude@linux.ibm.com>
 <20260908131817.17644-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:37:28 +0000
Message-Id: <20260908133729.2C8391F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing error code assignment (`msg->rc =3D -EMSGSIZE`) on short r=
eplies leads to kernel memory disclosure in multiple message receive functi=
ons.

Pre-existing issues:
- [Medium] Incomplete length validation for CEXXC_RESPONSE_TYPE_XCRB allows=
 an out-of-bounds read of CPRBX fields in convert_type86_rng().
--

commit 4aedb5baa8548df5ca01ec9ef8a55fbf780a7ee8
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Fix and improve zcrypt reply message verification checks

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA, EP11 (AP message
type 6) and ICA (AP type 50) messages. The verification code related
to reply field length was not designed well and thus firmware
deficiencies could lead to unexpected behavior in the zcrypt device
driver.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto=
/zcrypt_msgtype50.c
> index d6fc2d8e7fad9..80c447ea2d839 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype50.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype50.c
> @@ -416,26 +416,40 @@ static void zcrypt_msgtype50_receive(struct ap_queu=
e *aq,
>  		.reply_code =3D REP82_ERROR_MACHINE_FAILURE,
>  	};
>  	struct type80_hdr *t80h;
> -	int len;
> +	size_t len;
> =20
>  	/* Copy the reply message to the request message buffer. */
>  	if (!reply)
>  		goto out;	/* ap_msg->rc indicates the error */
> +
>  	t80h =3D reply->msg;
> -	if (t80h->type =3D=3D TYPE80_RSP_CODE) {
> -		len =3D t80h->len;
> -		if (len > reply->bufsize || len > msg->bufsize ||
> -		    len !=3D reply->len) {
> -			pr_debug("len mismatch =3D> EMSGSIZE\n");
> -			msg->rc =3D -EMSGSIZE;
> -			goto out;
> -		}
> -		memcpy(msg->msg, reply->msg, len);
> -		msg->len =3D len;
> -	} else {
> -		memcpy(msg->msg, reply->msg, sizeof(error_reply));
> +
> +	if (reply->len < sizeof(*t80h) ||
> +	    t80h->type !=3D TYPE80_RSP_CODE) {
> +		if (reply->len < sizeof(error_reply))
> +			memcpy(msg->msg, &error_reply, sizeof(error_reply));
> +		else
> +			memcpy(msg->msg, reply->msg, sizeof(error_reply));
>  		msg->len =3D sizeof(error_reply);
> +		goto out;

[Severity: High]
Does this missing error code assignment on short replies inadvertently
validate them?

If the hardware sends a reply that is shorter than sizeof(*t80h) but has a
valid success header, this early bailout catches it but fails to set msg->rc
to an error code like -EMSGSIZE. Because the caller sees rc =3D=3D 0, it may
parse the success header and read uninitialized/leftover memory from the
request buffer, potentially leaking kernel memory to userspace.

> +	}
> +
> +	len =3D t80h->len;

[ ... ]

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 3df1d676de5d8..b53801b0a9710 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -766,6 +766,13 @@ static int convert_type86_rng(struct zcrypt_queue *z=
q,
> =20
>  	if (msg->cprbx.ccp_rtcode !=3D 0 || msg->cprbx.ccp_rscode !=3D 0)
>  		return -EINVAL;

[Severity: Medium]
This isn't a bug introduced by this patch, but could this blindly access
ccp_rtcode and ccp_rscode if the hardware sent a truncated reply?

If a hardware or emulator responds to a CEXXC_RESPONSE_TYPE_XCRB request
with a truncated message that satisfies the 51-byte minlen checked in
zcrypt_msgtype6_receive(), but doesn't include the full CPRBX structure,
these fields may contain leftover data from the request buffer.

> +	/*
> +	 * Note that offset2 and count2 have already been checked in
> +	 * zcrypt_msgtype6_receive(). So only check for not exceeding
> +	 * the hard coded rng buffer size.
> +	 */
> +	if (msg->fmt2.count2 > ZCRYPT_RNG_BUFFER_SIZE)
> +		return -EMSGSIZE;
>  	memcpy(buffer, data + msg->fmt2.offset2, msg->fmt2.count2);
>  	return msg->fmt2.count2;
>  }

[ ... ]

> @@ -928,48 +935,80 @@ static void zcrypt_msgtype6_receive(struct ap_queue=
 *aq,
>  	};
>  	struct ap_response_type *resp_type =3D &msg->response;
>  	struct type86x_reply *t86r;
> -	int len;
> +	size_t minlen, len;
> =20
>  	/* Copy the reply message to the request message buffer. */
>  	if (!reply)
>  		goto out;	/* ap_msg->rc indicates the error */
> +
>  	t86r =3D reply->msg;
> -	if (t86r->hdr.type =3D=3D TYPE86_RSP_CODE &&
> -	    t86r->cprbx.cprb_ver_id =3D=3D 0x02) {
> -		switch (resp_type->type) {
> +	minlen =3D sizeof(t86r->hdr) + sizeof(t86r->fmt2) +
> +		offsetof(struct CPRBX, cprb_ver_id) +
> +		sizeof(t86r->cprbx.cprb_ver_id);

[Severity: Medium]
This isn't a bug introduced by this patch, but does this minlen check
guarantee the rest of the CPRBX structure is present?

This check ensures the message has a valid cprb_ver_id (51 bytes), but it
might not guarantee the rest of the CPRBX structure is present before allow=
ing
the CEXXC_RESPONSE_TYPE_XCRB branch to succeed, potentially leading to the
issue in convert_type86_rng() mentioned above.

> +
> +	if (reply->len < minlen ||
> +	    t86r->hdr.type !=3D TYPE86_RSP_CODE ||
> +	    t86r->cprbx.cprb_ver_id !=3D 0x02) {
> +		if (reply->len < sizeof(error_reply))
> +			memcpy(msg->msg, &error_reply, sizeof(error_reply));
> +		else
> +			memcpy(msg->msg, reply->msg, sizeof(error_reply));
> +		msg->len =3D sizeof(error_reply);
> +		goto out;

[Severity: High]
Does this missing error code assignment (msg->rc =3D -EMSGSIZE) similarly l=
ead
to unintended memory disclosures as in zcrypt_msgtype50_receive()?

For ICA requests, convert_type86_ica() could use the leftover count1 to copy
up to PAGE_SIZE bytes of the buffer back to userspace if the rc remains 0.

> +	}
> +
> +	switch (resp_type->type) {

[ ... ]

> @@ -992,34 +1031,53 @@ static void zcrypt_msgtype6_receive_ep11(struct ap=
_queue *aq,
>  	};
>  	struct ap_response_type *resp_type =3D &msg->response;
>  	struct type86_ep11_reply *t86r;
> -	int len;
> +	size_t minlen, len;
> =20
>  	/* Copy the reply message to the request message buffer. */
>  	if (!reply)
>  		goto out;	/* ap_msg->rc indicates the error */
> +
>  	t86r =3D reply->msg;
> -	if (t86r->hdr.type =3D=3D TYPE86_RSP_CODE &&
> -	    t86r->cprbx.cprb_ver_id =3D=3D 0x04) {
> -		switch (resp_type->type) {
> +	minlen =3D sizeof(t86r->hdr) + sizeof(t86r->fmt2) +
> +		offsetof(struct ep11_cprb, cprb_ver_id) +
> +		sizeof(t86r->cprbx.cprb_ver_id);
> +
> +	if (reply->len < minlen ||
> +	    t86r->hdr.type !=3D TYPE86_RSP_CODE ||
> +	    t86r->cprbx.cprb_ver_id !=3D 0x04) {
> +		if (reply->len < sizeof(error_reply))
>  			memcpy(msg->msg, &error_reply, sizeof(error_reply));
> -			msg->len =3D sizeof(error_reply);
> -		}
> -	} else {
> -		memcpy(msg->msg, reply->msg, sizeof(error_reply));
> +		else
> +			memcpy(msg->msg, reply->msg, sizeof(error_reply));
>  		msg->len =3D sizeof(error_reply);
> +		goto out;

[Severity: High]
Could this logic omit setting the error code for short EP11 messages as wel=
l?

Bypassing length validation here may similarly allow uninitialized buffer
reads.

>  	}
> +
> +	switch (resp_type->type) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908131817.1764=
4-1-freude@linux.ibm.com?part=3D1
