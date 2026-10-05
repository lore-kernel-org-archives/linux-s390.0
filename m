Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0D7081E
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201177; cv=none; b=HOZyXg1IHABDbCBdfSNyE4E5elgs5DbuzzdBTkFOY6sbQTyWYVXR0vnyKvUZGpD9Xn0sOIZYQBSMyX7PuJhUjQaaiyd/JgIPSYjJU4tdBp8l0B1Q5pItv/IV9MdY9dHxHG+3z7wsqng3fO7+ueRKLKmAOpgPKQc0jw+OcBbubwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201177; c=relaxed/simple;
	bh=Isk4B0u2tUq8adJjy/6Y3bapaMmr8ahuTqfFCI6d4ak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jBa/w0Ayk1srjijG8p5A8knP4dqwmwXRwWSFIvSBVpX8paDBWnSDzXAsPchw6CP0np6XYgeqoQhjJedt1nd7pGL3F1j0NSfoaGnfFQxV977JB2nXDX0wwynnfts5ttOz6wjnvpoXjM9S3evuTzQDgAskEB3bixu7F5mBQcP1Sww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa/ANOhk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa/ANOhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8BF1F000FF;
	Mon,  5 Oct 2026 11:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791201176;
	bh=Qw+AV74zx7FFZXry3besOlS1mzpoxFSJnwIWYovuUOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sa/ANOhk7Kx7oDPh1WMwUyd1sPrpFzv8wBgIZn1swxxr/f6S4qGmvM9UyxxrpWXGv
	 855ArdjPdvhxG1JO3Fhctbgtxo4p9X1ythg0nWEa8kepZB9qSfqPrhFP5uAHUsfL2u
	 TYb38C4ojhG178NzbOdORq+89qQvKUZpzX8JCU5gdU5GaE7v7rXTcCoFL9eankHblN
	 SGsee7E/Eoj5MaB4aKV0p4LarMjFRaQ2vhT0srFhL8hGa8A9oi6szt+Jtypqn1f1EH
	 PGeQjnkjEVuF1NqEQkICm/XRETbei1WNuQHjHuQbWSjleBqPjSz2SONV/p63Wjwyqc
	 4PJVGrpmQmUrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] s390/zcrypt: Guard domain index uses against
 speculative bypass
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261005114018.62489-2-freude@linux.ibm.com>
References: <20261005114018.62489-1-freude@linux.ibm.com>
 <20261005114018.62489-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 11:52:55 +0000
Message-Id: <20261005115256.0D8BF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/zcrypt: invalid domain silently routed to domain 0 via array_=
index_nospec()
--

commit def23e498ab28cdfe6fb435523fe4c6e49365857
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Guard domain index uses against speculative bypass

This patch moves the array_index_nospec() sanitization for the domain index
to earlier in the CCA and EP11 paths. This aims to ensure a single call
covers all downstream uses of the index and prevents speculative execution
bypasses.

> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcryp=
t_api.c
> index ec6a4c2f9f04a..c9d6f4539235b 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -877,9 +877,12 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_=
perms *perms,
>  	print_hex_dump_debug("ccareq: ", DUMP_PREFIX_ADDRESS, 16, 1,
>  			     ap_msg.msg, ap_msg.len, false);
> =20
> +	/* Make sure domain is either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 */
> +	if (domain !=3D AUTOSEL_DOM)
> +		domain =3D array_index_nospec(domain, AP_DOMAINS);
> +
>  	if (perms !=3D &ap_perms && domain < AP_DOMAINS) {

[Severity: High]
Does calling array_index_nospec() before the architectural bounds check cau=
se
invalid domains to be silently routed to domain 0?

If a user issues an ioctl with a domain >=3D AP_DOMAINS, array_index_nospec=
()
will clamp the out-of-bounds index to 0. The subsequent check for=20
domain < AP_DOMAINS will then evaluate 0 < AP_DOMAINS, causing the operation
to proceed on domain 0 instead of rejecting the invalid input.

>  		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
> -			domain =3D array_index_nospec(domain, AP_DOMAINS);
>  			if (!test_bit_inv(domain, perms->adm)) {

[ ... ]

> @@ -1078,9 +1081,12 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, str=
uct ap_perms *perms,
>  	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
>  			     ap_msg.msg, ap_msg.len, false);
> =20
> +	/* Make sure domain is either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 */
> +	if (domain !=3D AUTOSEL_DOM)
> +		domain =3D array_index_nospec(domain, AP_DOMAINS);
> +
>  	if (perms !=3D &ap_perms && domain < AP_DOMAINS) {

[Severity: High]
Does this code have the same bounds checking issue here in the EP11 path?

An invalid domain >=3D AP_DOMAINS could be similarly clamped to 0 and pass =
the
subsequent bounds check, executing on the wrong domain.

>  		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
> -			domain =3D array_index_nospec(domain, AP_DOMAINS);
>  			if (!test_bit_inv(domain, perms->adm)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005114018.6248=
9-1-freude@linux.ibm.com?part=3D1
