Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B24749DD
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717908; cv=none; b=EFfwZlW/x3E3+cjd71N66Ajb17NaPYV+JxMLQ35H+tGLEv6Sg/GTnrN3kTjGHQet7PQfJIeVKBJmAuhXYVvwmHZHDCtokNbRu4gW93mUwmBzngIkJXBgEgNP9V+dLnn40v3rPNYNFqk8MoPslls7Gn82T6NERjKSVODEPlSKzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717908; c=relaxed/simple;
	bh=qG1YPcTiXm5z6BP4wJOTbOBlgPxkHcZFNaKGEdpaOxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FXTooHkd512nBw5Wq1ayF/t5oLU1S+S56gN15u3Mt0jJMvoMP2mcrKjWQKXJI6CCpvg83Hkb70dRtE0TgGiC4Rm6bQYC+eWu2ce5V2bJ+zqEsc/54YxWiP8kTQdtFpG2oROzqsQUXdpVAS62/K/fIKjXoWqJcjFF3CHTEkXPIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaeNfEBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaeNfEBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EE41F00A3A;
	Fri, 14 Aug 2026 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786717903;
	bh=MvPo50LpVTDUZjLGThUOhz2SYua1XuH23qF6S3OfT/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YaeNfEBT3XRWNLx+VNRvZA4oe7ayAECqEZd9UtkYVepSNCLEloCV38ST4CxCO+KcV
	 icbMQ8Rem6YEz8/oOnF2U/SxvV93td2abeJ8eQsNH9HX55J2QP9TxxhDXhaVJs0Qzu
	 VRDPmRZcr07SbXQl7PsYvm2Pds/OaAA2VcLW5Z+imuc2JvOVIGC4vCJsiylF+53raJ
	 qZUNj+BgRez168W6NZbBZEyU1LlUpyxL7PeE223emgY7mEQ3d8hpqhG7Cvls5wtPbv
	 mkTAInbny8We8NM41a0OrQakagvg4isdX3T3d1uJw1/oYmRn0WSnV5+ZNhyvP8c3OJ
	 lt99odAvQxHdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] s390/crypto: Generate intermediate CV for API
 partial block handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Holger Dengler" <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260814142010.259918-2-dengler@linux.ibm.com>
References: <20260814142010.259918-1-dengler@linux.ibm.com>
 <20260814142010.259918-2-dengler@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:31:43 +0000
Message-Id: <20260814143143.75EE41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware Alignment Requirement Violation due to `__packed` attribu=
te
--

--- Patch [1]: [PATCH v1 1/1] s390/crypto: Generate intermediate CV for API=
 partial block handling ---
commit 6ca29d2947b71c2e1420feb8fbee6504922ff37f
Author: Holger Dengler <dengler@linux.ibm.com>

s390/crypto: Generate intermediate CV for API partial block handling

This commit updates the internal hash_data() function to conditionally use
cpacf_kimd() for intermediate chaining values when API partial block handli=
ng
is requested, reserving cpacf_klmd() for the final hash value.

> diff --git a/arch/s390/crypto/hmac_s390.c b/arch/s390/crypto/hmac_s390.c
> index f8cd09f341d4b..445fa7bbd9586 100644
> --- a/arch/s390/crypto/hmac_s390.c
> +++ b/arch/s390/crypto/hmac_s390.c
> @@ -150,7 +150,10 @@ static int hash_data(const u8 *in, unsigned int inle=
n,
> =20
>  #undef PARAM_INIT
> =20
> -	cpacf_klmd(func, &param, in, inlen);
> +	if (final)
> +		cpacf_klmd(func, &param, in, inlen);
> +	else
> +		cpacf_kimd(func, &param, in, inlen);

[Severity: High]
This is a pre-existing issue, but could the alignment of the param block pa=
ssed
to cpacf_kimd() and cpacf_klmd() trigger a hardware specification exception?

The param variable is defined earlier in hash_data() with the __packed
attribute:

	union {
		struct sha256_paramblock {
			u32 h[8];
			u64 mbl;
		} sha256;
		struct sha512_paramblock {
			u64 h[8];
			u128 mbl;
		} sha512;
	} __packed param;

The __packed attribute reduces the compiler's alignment requirement for par=
am
to 1 byte. The z/Architecture requires doubleword (8-byte) alignment for KI=
MD
and KLMD parameter blocks.

If the compiler places param on a stack address not divisible by 8, won't t=
his
cause a kernel panic when passed to these hardware instructions?=20

Since the struct fields inside the union are naturally packed, can we remove
the __packed attribute to ensure the compiler maintains safe alignment?

> =20
>  	memcpy(digest, &param, digestsize);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814142010.2599=
18-2-dengler@linux.ibm.com?part=3D1
