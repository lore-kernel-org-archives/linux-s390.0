Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383F838DC50
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422930; cv=none; b=XYHkneVcGQT2lXyg1Lm+yhBU/nlQtQ0BzgWcddshI/XkT8ZlDJQ469MTzqCCc7IkEoZeNB+dMWL+f2c9JVmr9MMcJwFluLAwvvuLB6VsHnJBeiCufFcsZ37SRpXW2mp7j8pwqfwRHb62g0HZw0IgFfaGOXtWhEFyhDDCRD5lep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422930; c=relaxed/simple;
	bh=TmeKDnfp1qhT4HJvBAEe24+nUzyoXUP25uCHD8DR0oE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g0xkMUyM31vsHakQPR8HRigI7RpdJCF7hWT3lzQlAfNvrSm0y0bJbk+mJFcCj6BQDj43cx+Dl4SzFgfY5GJhgMK+nfZttQpyZK2Ky3spH2AT+UO7w31nYARlh0WQos8Rv4IDsx6omwEqL9v6v75NZwX4ENSMtabyshjPaJW5zc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF3YRtfV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF3YRtfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF66F1F000E9;
	Thu, 30 Jul 2026 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785422929;
	bh=7+Qwis1LA98xdPcY0/2fyJVyiHrA7zWrM14OjtliKQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MF3YRtfVxDVN8lOKOv7e6W+iJXWzSccHxaA1BzRhZUUkAKLPRfDzviXLc6JIdLtN2
	 yAoBt0McsAE+dfvFT2DiKyPBOYLYBkbdnFKty/VHreTR6mxfYWazOzQnhheq/ZcOp9
	 ml7EIcf0dl/gGbHkGZ4F69D24lKBoqK0QZT4Rprj04vbvrHsFpTwk/r057jdd2D7CN
	 1yEQRKCNkdFEjTqNVBARaMIHIshmxMoy081Gr9R/bwaCmbJ6RSGuXJW3Wd4ItwLhri
	 8pLCadZwRaCMdl+AMtcbWNi+0OlV1UtiOXlEzG879s4qOarBlM6QjmeEgnIAcJUwZT
	 NiKVVdcRblMKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/5] s390/zcrypt: Improve CCA CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260730141509.205970-3-freude@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
 <20260730141509.205970-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 14:48:48 +0000
Message-Id: <20260730144848.AF66F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Uninitialized alignment padding bytes may be read during functio=
n code extraction in `xcrb_msg_to_type6cprb_msgx`.

Pre-existing issues:
- [Critical] A 64-bit integer overflow in `xcrb_msg_to_type6_ep11cprb_msgx`=
 allows a massive `req_len` to bypass the buffer size check.
- [High] The EP11 request path lacks minimum size validation, leading to un=
initialized kernel memory access.
- [High] A user can bypass administrative domain permission checks by setti=
ng the target domain to AUTOSEL_DOM (0xFFFF).
--

--- Patch [2]: [PATCH v10 2/5] s390/zcrypt: Improve CCA CPRB length and ove=
rflow checks ---
commit 168ea93b9d93d40b4d0625f5a9d932544117496a
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve CCA CPRB length and overflow checks
   =20
This patch improves input validation in the xcrb_msg_to_type6cprb_msgx
function. It uses size_t for length calculations, adds bounds checks after
alignment, validates the minimum control block size, and detects overflow
in sum calculations.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c

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

[Severity: Medium]
Can this relaxed bounds check result in reading uninitialized alignment
padding?

If a userspace caller sends a CCA ioctl where
xcrb->request_control_blk_length is not a multiple of 4 (for example, 21),
the z_copy_from_user() call copies exactly 21 bytes. Up to 3 bytes of
padding might be left uninitialized.

Because the check now compares against req_cblen instead of
xcrb->request_control_blk_length, could a crafted cprbx.cprb_len (e.g., 22)
pass this validation and point into the uninitialized padding area, allowing
the subsequent memcpy() to read uninitialized kernel heap memory into
msg->hdr.function_code?

>  		return -EINVAL;
>  	function_code =3D ((unsigned char *)&msg->cprbx) + msg->cprbx.cprb_len;
>  	memcpy(msg->hdr.function_code, function_code,

[ ... ]


While reviewing these length check improvements, I also noticed a few
pre-existing issues in related code:


[Severity: Critical]
This isn't a bug introduced by this patch, but does
xcrb_msg_to_type6_ep11cprb_msgx() suffer from a similar 64-bit integer
overflow?

In drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx():

    ap_msg->len =3D sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
    if (ap_msg->len > ap_msg->bufsize)
        return -EINVAL;

If a userspace caller passes an ioctl with req_len equal to U64_MAX - 79,
CEIL4(req_len) evaluates to U64_MAX - 79. Adding sizeof(struct type6_hdr)
wraps the 64-bit value to 8, completely bypassing the buffer bounds check.

Would the subsequent copy_from_user() then zero-fill the kernel heap on
failure and cause memory corruption?


[Severity: High]
This is a pre-existing issue, but the EP11 request path seems to lack the
minimum size validation that this patch adds to the CCA path.

In drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx():

    if (z_copy_from_user(userspace, msg->userdata,
                         (char __force __user *)xcrb->req, xcrb->req_len)) {

If an attacker submits an EP11 ioctl with a small req_len (e.g., 4 bytes),
the kernel copies only 4 bytes. Could the function then read EP11 structure
fields such as msg->pld_lenfmt and msg->cprbx.flags from uninitialized
memory to determine function codes and domains?


[Severity: High]
This isn't a bug introduced by this patch, but looking at the domain
permissions, is there a way to bypass administrative checks?

In drivers/s390/crypto/zcrypt_api.c:_zcrypt_send_cprb():

    if (perms !=3D &ap_perms && domain < AP_DOMAINS) {
        if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
            if (!test_bit_inv(domain, perms->adm)) {

And similarly in _zcrypt_send_ep11_cprb():

    if (perms !=3D &ap_perms && domain < AUTOSEL_DOM) {
        if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
            if (!test_bit_inv(domain, perms->adm)) {

If a user submits a CPRBX or EP11 request containing an administrative
command and sets the embedded domain field to 0xFFFF (AUTOSEL_DOM), the
condition domain < AP_DOMAINS evaluates to false.

Does this cause the administrative permission check to be completely skippe=
d,
allowing a user with only usage privileges to execute administrative
commands on that domain?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730141509.2059=
70-1-freude@linux.ibm.com?part=3D2
