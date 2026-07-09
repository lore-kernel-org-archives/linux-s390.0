Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C03EDACE
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589837; cv=none; b=SQZaqMc+s5v4s1cQfWK0pg7sgg4fTU2w5GJfGixaoFAc2iacC+LEJkWtU61j1AjNPVqA63Sz+8jw/QZGwcGuyMqEaLXPI6C6JNsiBifJ1GdnpKw2jjA8glONVpEiGIXZ5ZOSRq7GfvxpHSMBKE6EtQc8oHpjwSKVVEn65tpimPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589837; c=relaxed/simple;
	bh=NrdEVPWsNbFc/OT80BZAhupReOBbenjCiiWUX3V7BO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e9y/qK00WW1dOFQQXP6d1+9/X0uuNScWwFFcQdnl14VTLdPCjqOjHRtQIzVYkI2Jzeh+wz49FLvLCvWK5Oyx61laC7PWesgvR2O8NY1DGDQ7QDoI1hGDeJkXrH6+OwtQRmHykxfVSpMnVmcucVFnjirard6HNhNjoRbXm0oCXHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvQDizWg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvQDizWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608B31F000E9;
	Thu,  9 Jul 2026 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783589835;
	bh=+FHQN61njrRXbC/wS/ivhpZDSrXhHQ/JbJjdZIi3iLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jvQDizWgETsld7wHyGB1BiTACLFagTp5kmS75HwRn/qKJ3fDiMYQ0krzGZDCs41md
	 lESqxZ1ulcpWEahxtagc+t5aH5cXEuqYbE57w+Ged7EtixUH7TI2Mb0JWp+Jo1E+5G
	 7EhNK3OGm2trQ9j5aymwKUfloW/PIoanKSUL6SDs/pJC+WatM0eqtI8//TJa46Ju/S
	 h6eHJOEhh/1azdMOSzrw1PBXtMbMlGE7zWpL/f3JsGPxF4Sd9sZ0cFkKeulyp4yYPp
	 4gCt3Lo0xDyOeKpTiMrAblUTZIReW9TbeEu4H6HNCbRqpAoFikMRplsbBoZlCpbKxg
	 9CikMsS4/MAEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/1] s390/zcrypt: Improve zcrypt reply message
 verification checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260709092219.57356-2-freude@linux.ibm.com>
References: <20260709092219.57356-1-freude@linux.ibm.com>
 <20260709092219.57356-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 09:37:14 +0000
Message-Id: <20260709093715.608B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The `check_add_overflow()` error paths are mathematically unreachab=
le because 32-bit operands cannot overflow a 64-bit `size_t` destination.

Pre-existing issues:
- [High] Unvalidated `offset1` and `count1` fields in `zcrypt_msgtype6_rece=
ive()` lead to a kernel memory leak in `convert_type86_xcrb()` when `count2=
 !=3D 0`.
--

--- Patch [1]: [PATCH v3 1/1] s390/zcrypt: Improve zcrypt reply message ver=
ification checks ---
commit b96e9311c01803c5c1f3023f735aa7268d688c81
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve zcrypt reply message verification checks

This commit adds and improves checks related to buffer sizes and reply sizes
in the handling of replies from crypto cards for CCA and EP11 messages. It
changes length variables from int to size_t and adds overflow checks to
inspect length fields more closely.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 40f72cdf284d3..5deef2e38f065 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c

[ ... ]

> @@ -874,10 +881,23 @@ static void zcrypt_msgtype6_receive(struct ap_queue=
 *aq,
>  			msg->len =3D len;
>  			break;
>  		case CEXXC_RESPONSE_TYPE_XCRB:
> -			if (t86r->fmt2.count2)
> -				len =3D t86r->fmt2.offset2 + t86r->fmt2.count2;
> -			else
> -				len =3D t86r->fmt2.offset1 + t86r->fmt2.count1;
> +			if (t86r->fmt2.count2) {
> +				if (check_add_overflow(t86r->fmt2.offset2,
> +						       t86r->fmt2.count2,
> +						       &len)) {

[Severity: High]
This is a pre-existing issue, but does this conditional validation leave
offset1 and count1 unchecked when count2 is non-zero?

If the hardware or firmware returns a malformed XCRB reply with a non-zero
count2, only offset2 and count2 are validated here against the buffer bound=
s.

However, convert_type86_xcrb() appears to unconditionally copy count1 bytes
from offset1 to userspace without validating if they remain within the boun=
ds
of the reply message:

drivers/s390/crypto/zcrypt_msgtype6.c:convert_type86_xcrb() {
    ...
    if (z_copy_to_user(userspace, xcrb->reply_control_blk_addr,
               data + msg->fmt2.offset1, msg->fmt2.count1))
        return -EFAULT;
    ...
}

Can this lead to an out-of-bounds memory read and an information leak to
userspace?

[Severity: Low]
Is this check_add_overflow() mathematically reachable?

Since len was changed to a size_t, which is strictly 64-bit on the s390x
architecture, and the offset and count variables are 32-bit unsigned intege=
rs,
their sum can never overflow the 64-bit destination.

Does this make the overflow check always evaluate to false and the error
branch dead code?

> +					pr_debug("len overflow =3D> EMSGSIZE\n");
> +					msg->rc =3D -EMSGSIZE;
> +					goto out;
> +				}
> +			} else {
> +				if (check_add_overflow(t86r->fmt2.offset1,
> +						       t86r->fmt2.count1,
> +						       &len)) {
> +					pr_debug("len overflow =3D> EMSGSIZE\n");
> +					msg->rc =3D -EMSGSIZE;
> +					goto out;
> +				}
> +			}
>  			if (len > reply->bufsize || len > msg->bufsize ||
>  			    len !=3D reply->len) {
>  				pr_debug("len mismatch =3D> EMSGSIZE\n");

[ ... ]

> @@ -927,7 +947,12 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_q=
ueue *aq,
>  	    t86r->cprbx.cprb_ver_id =3D=3D 0x04) {
>  		switch (resp_type->type) {
>  		case CEXXC_RESPONSE_TYPE_EP11:
> -			len =3D t86r->fmt2.offset1 + t86r->fmt2.count1;
> +			if (check_add_overflow(t86r->fmt2.offset1,
> +					       t86r->fmt2.count1, &len)) {

[Severity: Low]
Is this check_add_overflow() also mathematically unreachable for the same
reasons mentioned above?

> +				pr_debug("len overflow =3D> EMSGSIZE\n");
> +				msg->rc =3D -EMSGSIZE;
> +				goto out;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709092219.5735=
6-2-freude@linux.ibm.com?part=3D1
