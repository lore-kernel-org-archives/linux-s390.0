Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D87E412BF8
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457422; cv=none; b=bYKf79cR7/XZ7URV10+7dm57czXhlfqPjkvJSph4cpRNGKYtUowzCna/NWKVEpd1KLrodzMDo2Bgz30OR1B5XO+k36HP237pqZwUtn6Y/1zcUvp25zN27hNvQDEjPS5RCAkQQpfkH4/eRwqAP93JZZCQBfWs0FxUeJ1tWurZnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457422; c=relaxed/simple;
	bh=Vn/TSmXI5Q9D9mzTCfgfnv8lMR0L3/Jj6E1xQr/h2PE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fZKjF3gjtilFY0Ez859DQ/SLDpojW/8SkjyXVnlJb6F/4uxlzWh3bT1bT1UhIkmCn7JS6Eg5I4eJrTStd+2/GUt3b96pAkKMEC3lqvQKtDD1z1Mjw9sxuj34oRj9QVJjgy/Hr0Ywos3mzVc/GYodg6OnH0BBMFVO4Z5xy/e139Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lepu2y1O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lepu2y1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E668F1F000FF;
	Thu,  8 Oct 2026 11:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791457421;
	bh=DfHfXO5De0YMVLRRM2Q2STKIpONhl8HQdAdkRgxnJCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lepu2y1Ov1vqrXUFpVSyN3JuwNdZtMG7cKoQN066/ONSHkWNJkpMAhd3AySnGOn1c
	 8BtHW0kbvRKg+RfCF5Sii+4kSUIm9d6mOSkw3aRSS8Afl6KGvnMOcvITdb+rzbLH9U
	 5sHOdZOEg0/G/tRatPFQhwf0B/nOr/OmHAe8f2AwqmqUjVw8WLwbEDVHk0q9Rycitg
	 NcJZlKFl9ChztIloDUu7tby7iNi6WdgmNyNQ4nCAS+yt7Zi/vNquJsyrumHTx/mySt
	 y2ilsjFu+T09pnJezxHXhOnSgB8RZ8TvSqWDn+XC7WfPCD5xuZCAmPV5KOW5yWilOB
	 xd4QWHvR1QDgQ==
Message-ID: <sashiko-outbox-164075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] s390/crypto: Handle cpacf_kma() return code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261008105242.20730-3-freude@linux.ibm.com>
References: <20261008105242.20730-1-freude@linux.ibm.com>
 <20261008105242.20730-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 11:03:40 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] crypto: s390: missing 'out' label causes build failure
- [Low] s390/crypto: build error due to missing 'out' label
--

commit 45b229c79189e8165da09c03b30411703a7bf4ae
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Handle cpacf_kma() return code

This commit updates gcm_aes_crypt() to check the return code of cpacf_kma()
and bail out with -EIO on any non-zero result.

> diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
> index 62edc66d54788..0e35cca359146 100644
> --- a/arch/s390/crypto/aes_s390.c
> +++ b/arch/s390/crypto/aes_s390.c
> @@ -889,10 +889,13 @@ static int gcm_aes_crypt(struct aead_request *req, =
unsigned int flags)
>  		if (aad_bytes > 0)
>  			memcpy(gw_out.ptr, gw_in.ptr, aad_bytes);
> =20
> -		cpacf_kma(ctx->fc | flags, &param,
> -			  gw_out.ptr + aad_bytes,
> -			  gw_in.ptr + aad_bytes, pc_bytes,
> -			  gw_in.ptr, aad_bytes);
> +		if (cpacf_kma(ctx->fc | flags, &param,
> +			      gw_out.ptr + aad_bytes,
> +			      gw_in.ptr + aad_bytes, pc_bytes,
> +			      gw_in.ptr, aad_bytes)) {
> +			ret =3D -EIO;
> +			goto out;

[Severity: Critical]
Does this code fail to compile? There does not appear to be an out label
defined anywhere within gcm_aes_crypt().

> +		}
> =20
>  		n =3D aad_bytes + pc_bytes;
>  		if (gcm_in_walk_done(&gw_in, n) !=3D n)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008105242.2073=
0-1-freude@linux.ibm.com?part=3D2
