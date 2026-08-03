Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8023B27F7
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747869; cv=none; b=aMEbcCc0B1ogd0XgXlOpGC1PBcnXTuPk4p+xke6NqMfADdTMMbkaq5JxY5IgbNmrAvGR/5L5S48+2PcKpTQnrxlbE03THqr4eG3BbI+xFi/fKecNCecxuZh8UxkHdeaCwe1EJBRhTl48XYKh6Ndmqs1hwDOsrD2hQpAPMWPW7UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747869; c=relaxed/simple;
	bh=P3kJ6RoF/0q75DkT+vxTRjZPDM2wtFKmeLYsmprmp/Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RMLSte/KPwCGOlGYt3hbwO95NalFxdZn4VE8QL1JhlK732I7yzj0DiWp/nxYAxlhrMT9WOhAhXA2/MOECuXongZ0s41Vc3olrLdQqMBmwuupASQonVWktvYsPgC5If0mOe9seRKmJT470oHZMZnb5x35UQUv0GP3L2hZBe+5hss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcDEQ/12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcDEQ/12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AF31F000E9;
	Mon,  3 Aug 2026 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785747867;
	bh=pT7DTSGSAVE98lvzNFepaGscf3Rlg4bpxCBLcS+XXzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mcDEQ/12wssEVLeyGpNd3+beePQmjMN1JQ+HbaEZBUzebox2I3NMXNgxf6R3xQi42
	 SA20mqmB/hwRL/ZkRDUXIU1S1683aY9rsXN0+dJ/YrmjV0+YeFJU0PgezBrlsPF+RY
	 IFK3qyDThoCrNFHzTuDyTNs+VEoRbhUhBhS2BZP+N/kI2Og54JIfObKic/ccIBa8MF
	 jnyyIxW0GNyHDKfY0+51g27GuHRA3dOucpgdcKRUAKFVe3qqIqelFXS0iVX9Vg4tcS
	 qO1f8jBauV43bIicJhlM6Nyr4ihWu61lHtx3pSpIPPAYb+szpdLGIaIeaYWvK7chAx
	 L8ifLAzW29esA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/5] s390/zcrypt: Improve CCA CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803083339.212885-3-freude@linux.ibm.com>
References: <20260803083339.212885-1-freude@linux.ibm.com>
 <20260803083339.212885-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 09:04:26 +0000
Message-Id: <20260803090427.81AF31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Out-of-bounds read into uninitialized padding due to relaxed bound=
s check.

Pre-existing issues:
- [High] Missing minimum size validation for EP11 requests allows uninitial=
ized memory access.
--

--- Patch [2]: [PATCH v11 2/5] s390/zcrypt: Improve CCA CPRB length and ove=
rflow checks ---
commit 91475dced80fa0f4ff3795e01d4bba627b9d0bfe
Author: Harald Freudenberger <freude@linux.ibm.com>
s390/zcrypt: Improve CCA CPRB length and overflow checks

This commit improves length and overflow validations for CCA CPRB structure=
s.
It updates calculations to use size_t, adds U32_MAX boundary checks, and
enforces minimum control block size requirements.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 40f72cdf284d3..3e19e79d747cf 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c

[ ... ]

> @@ -404,8 +394,8 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace,=
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
Does this change allow an out-of-bounds read into uninitialized padding?

The bounds check was relaxed from checking against
request_control_blk_length to checking against the 4-byte aligned req_cblen.

If a user supplies an unaligned xcrb->request_control_blk_length (e.g., 37)
and sets msg->cprbx.cprb_len to point into the uninitialized padding
(e.g., 38), it appears up to 2 bytes of uninitialized kernel heap memory can
be read into msg->hdr.function_code and subsequently sent to the
cryptographic hardware.

[Severity: High]
This is a pre-existing issue, but could we apply similar minimum size
validation to xcrb_msg_to_type6_ep11cprb_msgx() for EP11 requests?

When a user calls the zcrypt ioctl for an EP11 request with an undersized
xcrb->req_len (e.g., 0):

drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx() {
    ...
    if (z_copy_from_user(userspace, msg->userdata,
                         (char __force __user *)xcrb->req, xcrb->req_len)) {
    ...
}

User-supplied data is copied using the user-controlled length without
verifying it meets the minimum required size for the struct fields that
are subsequently accessed.

This allows uninitialized heap memory in ap_msg->msg to dictate control flow
and be sent to the cryptographic hardware when reading fields like
msg->pld_lenfmt or msg->cprbx.flags.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803083339.2128=
85-1-freude@linux.ibm.com?part=3D2
