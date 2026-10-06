Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CF42E004
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296650; cv=none; b=pA3+7XPfJMhjc1tObP0W3QfJcAKWVQMtNMlB0/1Sw2F3M0QCpsDq2JeEoCUvmLZiJMCbpSEn6Im1b8IIQOSXrwJQUmkoAditwX3u2PZKE32UJJ9aixVGC8hIcTnYtWxQSxhy5+YVrJFofBvCiz2g0PnCpSstgT3/gsf7UDID0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296650; c=relaxed/simple;
	bh=e9C3CJ8xO0Lbs9N2AvScWG8gDZcF0zrsP2Ybpi3rgbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RRz56SJWBCWn4MZFzQ4rICQcLDhKa+2q1hxJ6UnhtQfrTXFJX969ck13rLqGI4H77Mc1n/AhTMIhm9xu6bgrsPhqOb4QvsHP5u1B6eVeUNXYlThUzLpY7EGGhaFPXWHxGUOhr4tu/U2ec1TBFEgEBli5iu0fBTxvlAtpY2d0D8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmQmi06m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmQmi06m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469F81F000FF;
	Tue,  6 Oct 2026 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791296649;
	bh=fgnAKJKQSFVfq3D4ENjxGvqgGrNPVfjcnBpDMmzENSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hmQmi06mIPqkfmGJ4XX2mV01gEdCEdUpeIb9iVFAeZRtqUusgP939MhIjc8pd7VDS
	 +axSPYIo3sz7HPNo0bR7HpsA0oW8Bg63MIDyxTUK7TWTbTI9cYsPmnJKVAZ8SwkJLx
	 MKsBwfQQCiHN+ArtArI1Xeu24sSW2k7CWDA+IPoij4F12cvTp53JawhCORZjWcQL3Y
	 myBVkNLOfE6t9CgdkPXEL3I+FTmscQR34BVxWLuZpiJ++TkutxPl4MC1Gz6k4/8e0G
	 A60ogSlTbnoSUlt7P6SAjhRWyf1oxYHLMyTTE9hxO9wpPdCQAjhej1ot9pUPnt4EWz
	 FLsCeOguDNI7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] s390/zcrypt: Guard domain index uses against
 speculative bypass
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261006141245.7558-2-freude@linux.ibm.com>
References: <20261006141245.7558-1-freude@linux.ibm.com>
 <20261006141245.7558-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 14:24:08 +0000
Message-Id: <20261006142409.469F81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/zcrypt: speculative bypass of array_index_nospec() in domain =
checks
--

commit 2f58ddfe66cdbe9c54595e16465810bc53b3d205
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Guard domain index uses against speculative bypass

The previous array_index_nospec() placement only covered the admin
permission check, leaving ap_test_config_usage_domain() and
ap_test_config_ctrl_domain() in the CCA path exposed to speculative
execution. This commit moves the sanitization to before all permission
and config checks in both the CCA and EP11 paths.

> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcryp=
t_api.c
> index ec6a4c2f9f04a..d2ff7ab54c8d5 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -877,9 +877,17 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_=
perms *perms,
>  	print_hex_dump_debug("ccareq: ", DUMP_PREFIX_ADDRESS, 16, 1,
>  			     ap_msg.msg, ap_msg.len, false);
> =20
> +	/* Make sure domain is either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 */
> +	if (domain !=3D AUTOSEL_DOM) {
> +		if (domain >=3D AP_DOMAINS) {
> +			rc =3D -EINVAL;
> +			goto out;
> +		}
> +		domain =3D array_index_nospec(domain, AP_DOMAINS);
> +	}

[Severity: High]
Could placing array_index_nospec() inside this conditional block lead to a
speculative execution bypass?

If the CPU's branch predictor is mistrained to assume domain =3D=3D AUTOSEL=
_DOM,
the speculative execution could skip this block entirely. This would leave =
an
out-of-bounds domain completely unclamped.

> +
>  	if (perms !=3D &ap_perms && domain < AP_DOMAINS) {
>  		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
> -			domain =3D array_index_nospec(domain, AP_DOMAINS);
>  			if (!test_bit_inv(domain, perms->adm)) {

[Severity: High]
Since the nospec clamping could be bypassed speculatively above, could this
block be entered with an out-of-bounds domain?

If the CPU then mispredicts the if (domain < AP_DOMAINS) check as true, does
this result in a speculative out-of-bounds read when test_bit_inv() is call=
ed
with the unclamped domain?

>  				rc =3D -ENODEV;
>  				goto out;

[ ... ]

> @@ -1078,9 +1086,17 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, str=
uct ap_perms *perms,
>  	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
>  			     ap_msg.msg, ap_msg.len, false);
> =20
> +	/* Make sure domain is either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 */
> +	if (domain !=3D AUTOSEL_DOM) {
> +		if (domain >=3D AP_DOMAINS) {
> +			rc =3D -EINVAL;
> +			goto out;
> +		}
> +		domain =3D array_index_nospec(domain, AP_DOMAINS);
> +	}

[Severity: High]
Does this identical pattern in the EP11 path also expose the domain variable
to the same speculative execution bypass?

> +
>  	if (perms !=3D &ap_perms && domain < AP_DOMAINS) {
>  		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
> -			domain =3D array_index_nospec(domain, AP_DOMAINS);
>  			if (!test_bit_inv(domain, perms->adm)) {

[Severity: High]
Does this result in the same speculative out-of-bounds read during the EP11
admin check, similar to the CCA path above?

>  				rc =3D -ENODEV;
>  				goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006141245.7558=
-1-freude@linux.ibm.com?part=3D1
