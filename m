Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D0513576
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864043; cv=none; b=D4WWi4i1M/Vgk768MoGMpsi78C2OvmI1UmjfVoqWxpIzmtiPfLuU6LLLOsA1uuPRo0y7XEn7pFZY1EZGhswgK/6fq2XFPFHYmlx76VF7m10oV46+/n4XJ3kyOX58DtveZWtxF1NutPkVMJgGQzLvwjBXVMVrAxG+0yO0b4J5QBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864043; c=relaxed/simple;
	bh=kOhqncv5XCZ7r1wutg9WfqJInWhTomtwX/fOjw8gu+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ib+Ly3kFR7SWEHOCDN+fJcee0tEcL5h6t6ZqSXz2wMOESSuxUtZA5SICj0+DEO/k6tzYuUXZz9DdMcTjO7T4r42lb51V3L9sNsbLnLsTur49qtERNHJBKJesBjrDS8SPdJA8WWaQTaSRLD0h6t1D+944NmRNQg8gTXigcFD9p1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iobFmETs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iobFmETs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C5D1F00A3D;
	Tue,  8 Sep 2026 10:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788864042;
	bh=oFlFYB7JsZy8OlPUw/REtl9ziZINj9mm81h84T7Rop8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iobFmETswYr+yzJytrLWmEfq49n+3DzAbIp4Pua+Ob57W3VwvJft0UDFEVNUtFTb/
	 aPXmaGF4+pc+wgyyCGTsc9V0VBJrLlVYUAg8fEcCBiBecNrcuPrWSgOH3tcKMK6v4m
	 s8kD2haDlqtWW70LpBZZyvkwkHePh6SnhfNqNBtrV49uP4hIzdWOV9rul7SClVORNC
	 suL9lgh3/y7/26BiOqDzkR7obR1LtauFrT/UkH+XfOjtkKCaG35rNuZV9bhSTwNsS9
	 TJzq67kTbMFCoNQr7Lx8fFEH/yj3P8MAJa55pCi6Z26WPs36fpzZtNN+0tORq9AXcd
	 JKoMezgYjbukw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] s390/zcrypt: Fix and improve zcrypt reply
 message verification checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260908102058.14329-2-freude@linux.ibm.com>
References: <20260908102058.14329-1-freude@linux.ibm.com>
 <20260908102058.14329-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 10:40:41 +0000
Message-Id: <20260908104041.D3C5D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The length validation for XCRB replies with a secondary data segme=
nt (`count2 > 0`) fails to verify that the primary segment's boundaries (`o=
ffset1 + count1`) fit within the message buffer, allowing an out-of-bounds =
read and uninitialized kernel heap memory disclosure to userspace.
--

commit e0149d402b0c0e1ac4ba64b32211aa5a4effb09f
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Fix and improve zcrypt reply message verification checks

This commit reworks length validation for crypto card replies in the
zcrypt device driver. It adds bounds checks to prevent out-of-bounds
reads when handling CCA, EP11, and ICA messages.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c

[ ... ]

> @@ -928,48 +935,82 @@ static void zcrypt_msgtype6_receive(struct ap_queue=
 *aq,

[ ... ]

> +	case CEXXC_RESPONSE_TYPE_XCRB:
> +		len =3D (size_t)t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
> +		if (t86r->fmt2.offset1 > reply->len ||
> +		    t86r->fmt2.count1 > reply->len) {
> +			msg->rc =3D -EMSGSIZE;
> +			pr_debug("offset1 %u count1 %u rpl.len %zu mismatch, msg.rc=3D%d\n",
> +				 t86r->fmt2.offset1, t86r->fmt2.count1,
> +				 reply->len, msg->rc);
> +			goto out;
> +		}
> +		if (t86r->fmt2.count2) {
> +			len =3D (size_t)t86r->fmt2.offset2 +
> +				(size_t)t86r->fmt2.count2;

[Severity: High]
This is a pre-existing issue, but does this overwrite of len bypass the
bounds checking for offset1 and count1 against reply->len?

When count2 is greater than 0, len is overwritten with the secondary
segment's length (offset2 + count2). Later in zcrypt_msgtype6_receive(),
the length validation check only verifies:

if (len !=3D reply->len) {
        ...
}
if (len > reply->bufsize || len > msg->bufsize) {
        ...
}

Since len is now based entirely on offset2 and count2, the primary
segment's boundaries (offset1 + count1) are never verified to ensure
they actually fit within the message buffer (offset1 + count1 <=3D reply->l=
en).

Could this lead to an out-of-bounds read later when convert_type86_xcrb()
handles the reply?

If a malformed reply has count2 > 0 but crafted offset1 and count1
values, convert_type86_xcrb() will use the unvalidated offset1 and count1
to copy kernel data to userspace:

drivers/s390/crypto/zcrypt_msgtype6.c:convert_type86_xcrb() {
        ...
        if (z_copy_to_user(userspace, xcrb->reply_control_blk_addr,
                           data + msg->fmt2.offset1, msg->fmt2.count1))
                return -EFAULT;
        ...
}

Since the message buffer is allocated without zeroing, could this copy
uninitialized heap memory past the end of the valid firmware reply
back to userspace?

> +			if (t86r->fmt2.offset2 > reply->len ||
> +			    t86r->fmt2.count2 > reply->len) {
>  				msg->rc =3D -EMSGSIZE;
> +				pr_debug("offset2 %u count2 %u rpl.len %zu mismatch, msg.rc=3D%d\n",
> +					 t86r->fmt2.offset2, t86r->fmt2.count2,
> +					 reply->len, msg->rc);
>  				goto out;
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908102058.1432=
9-2-freude@linux.ibm.com?part=3D1
