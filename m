Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC43603C9
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322177; cv=none; b=E3xcJpGOWtCc1gMmoTXpz8EOoxxAPk0Tm2QsPSJKjvTaKB2NtzNQrgS5xOc9/ltlWIDHfLaRlq3EwvjnkYqNHrfIGT7NtruNhJlQ7vkljZ/myK4e2HVGYvDDOf00zZop3plSm1Gg0uZ4ujtf3E4QnF28QJoWHVATLUnwdz5KPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322177; c=relaxed/simple;
	bh=aIug5Q9Iy8KdNLybmp9/TlUeEzrfxywVvYNn1axzQ+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=meeMEhSDLY1KkwHZ8Y3PDen9MpwHDlSLiZqOwkqQfLlBINHoECBYDbXGZnBpxgPlqZ6rEg0TkrS+ndPcDl/iMjxcXRTptO9DuyUIIEHWPozs4AY9jg+jGDzzZ0rcMo4SvR/acPa1la83qm1r31L4u338zo2y4itKlGfdXldWDp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPltZEJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPltZEJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE571F000E9;
	Wed, 29 Jul 2026 10:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785322176;
	bh=M+5a4FNi9e8pt040HcJaRCCCFKMtIVJL7Mr0k+X7R9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PPltZEJ7ZSXIhd1kYkrCOOVR6kdcfut1+9KPBNBuFJocE+WWVU+rWRaTFxQAOjjSz
	 lSd59axLHCXOnUTtjvlPbbY7tmHRwoFFigTNB02MvAmr/P81cgAaxx/mKMGEh1wi1n
	 FCg5AXfCMHKCwl9a2AOGp1xaoAXnWKrOK61E5B2bNsbgBFx35QpAAXT5Y2T3wmyLsW
	 b5t3Nk1y/DCBU6qtVHbp76RfAsv/v43xhosZtCV+U3JN4e4FRR/rh3mqraOksPQkIP
	 mwSjg7gE3Tl8esLRHF4/C61fuGTqJIiR9uG4+idi0PdVnksn6DTHO3f9uJlT9/7mhe
	 c3jex/164vKTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] s390/zcrypt: Improve EP11 CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260729095318.184141-4-freude@linux.ibm.com>
References: <20260729095318.184141-1-freude@linux.ibm.com>
 <20260729095318.184141-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 10:49:35 +0000
Message-Id: <20260729104936.0CE571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
> validation, creating security vulnerabilities:
> 1. Missing minimum size validation: The ep11_cprb structure and
>    subsequent payload fields (pld_tag, pld_lenfmt) are copied from
>    userspace without verifying sufficient buffer length.
> 2. Arithmetic overflow in length calculations: CEIL4 alignment could
>    overflow, bypassing size checks and enabling buffer overflows.
> 3. The payload is asn1 encoded but the function just uses a simple c
>    struct overlay to access some fields of the payload.
>=20
> Fix by using size_t for length calculations, adding U32_MAX boundary
> checks after alignment, and validating minimum request size and
> minimum reply size before copying from userspace. Do a very simple
> asn1 parsing of the payload up to the function value field.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729095318.1841=
41-1-freude@linux.ibm.com?part=3D3

