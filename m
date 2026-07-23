Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE13EEAF9
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801710; cv=none; b=JprCotxhH7R+3XUj9sLJyKI/2Gu7Yhdiu+rLr6FG/jmhPHbDcIGK5pje3vDHg8yQ5Y+na4g2zKqs47C1DTLPaDg3mrBLXRdb2/PJ3a517qSgzTFQCd5pda1jlIFXLT5irV/bKCUEG7GxFy2fAd8uHCZC9NU3UNtLK4c4x2dUORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801710; c=relaxed/simple;
	bh=GeCgatHR0Q9mqZ0MWElZ7hMv45pUaa9E3iFbIvKwsqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RItOJsKeSKhoaXeVxJTjIAID9RXREIr88AJrTEMzX1Z0Xpj2xKsyNYmuBVabOqU79T1J2DwfPu1SVnlNgU47Hkg+xE9lDBRDko8yvarAVeEVfa3xdqn0382mdY2IDDxWKXNoVv3s72MItllXu2lGwlultGgThL0DyF+zJpeX6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhEHq5jZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhEHq5jZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2661F000E9;
	Thu, 23 Jul 2026 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784801704;
	bh=RQWjV70ut4DD2/cosIIVFSSxBUoejKfL8XAxTVDldJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BhEHq5jZaqeH2iy6ONhc5DyqmPOz6n2Fa44Ing4C57X9QhuN1U5GY9N1vVaHeVtb3
	 80eFzzMq7J+GfiVctlesI5xDC7Z2cOCFJaotlQm4mPmpuglDu8lHJT3ulO/ym+cQwq
	 9ddBU96Vq8KtzbiqYVkuepz39XV7DELfJnQE7+s48D9vLEWkobaxexWom7nPvZ7cq7
	 7qdYSzEZeKm00+7JEiipNVZDneV/68WmDbyhaRxeo2s0PH4ZA/nykoQXX5PLu7/vrE
	 3o/p9TfeC2ZbnPSodEKYYA3c+ySRjMH2hFB24i1E7jY2xImanRkJZ0klNevj8gkPeP
	 YG7UIdgRyMlAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] s390/zcrypt: Fix wrong domain value verification
 with EP11 CPRBs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260723095453.127322-2-freude@linux.ibm.com>
References: <20260723095453.127322-1-freude@linux.ibm.com>
 <20260723095453.127322-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:15:03 +0000
Message-Id: <20260723101503.AF2661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing `array_index_nospec()` mitigation leading to a Spectre v1 =
vulnerability.

Pre-existing issues:
- [Critical] Privilege Escalation / Access Control Bypass in administrative=
 CPRBs.
--

--- Patch [1]: [PATCH v3 1/2] s390/zcrypt: Fix wrong domain value verificat=
ion with EP11 CPRBs ---
commit 9a314209ce4cb4581d3716a2f6e1c11a24aab46e
Author: Harald Freudenberger <freude@linux.ibm.com>
s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs

This commit fixes an upper limit check for the domain value when an EP11
CPRB is processed for sending to a crypto card. It adjusts the check to use
AP_DOMAINS to prevent heap memory access beyond the permissions array.

> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcryp=
t_api.c
> index f57189c2b839e..81eefdeae2485 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -1077,7 +1077,7 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, stru=
ct ap_perms *perms,
>  	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
>  			     ap_msg.msg, ap_msg.len, false);
> =20
> -	if (perms !=3D &ap_perms && domain < AUTOSEL_DOM) {
> +	if (perms !=3D &ap_perms && domain < AP_DOMAINS) {

[Severity: Critical]
This is a pre-existing issue, but does this logic completely bypass the
administrative permission checks if domain is greater than or equal to
AP_DOMAINS?

If a user provides a domain value like AUTOSEL_DOM (0xFFFF), this condition
evaluates to false, skipping the permission check block entirely. This
appears to allow a user with only usage access to bypass the perms->adm
check.

Since the CCA equivalent _zcrypt_send_cprb() has the same logic, and the
domain can be overwritten later with the dynamically selected queue's domain
before submission:

drivers/s390/crypto/zcrypt_msgtype6.c:zcrypt_msgtype6_send_cprb() {
    ...
    /* update domain field within the CPRB struct */
    msg->cprbx.domain =3D AP_QID_QUEUE(zq->queue->qid);
    ...
}

Can this lead to regressions by allowing arbitrary administrative commands =
to
be executed on the queue?

>  		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {

[Severity: High]
Does this code leave the domain variable vulnerable to speculative execution
attacks?

Since domain is extracted from untrusted user-provided data, the bounds
check could be mispredicted. If the CPU speculatively executes the true
path for an out-of-bounds domain, test_bit_inv() performs a bitwise load
from memory offset by domain.

Would it be appropriate to sanitize the domain variable with
array_index_nospec() before it is used as an index into perms->adm to
prevent potential kernel memory leaks via cache side channels?

>  			if (!test_bit_inv(domain, perms->adm)) {
>  				rc =3D -ENODEV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723095453.1273=
22-1-freude@linux.ibm.com?part=3D1
