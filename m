Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26313112DA;
	Fri, 21 Aug 2026 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342599; cv=none; b=TcZ4wDJ29wjHfSEgqsKGlmI+OvyHBiFAri3tRQPL6ibOQt5lnAzIXADnTJofQkiMK+ITDp5pAwBw+wNO9xy9d/FCQTKQANIg9VbJ2gegvvKDPVecn6uwMpxKg8VzkuUSd1XMdMxg/FM8F7c2iI8A0tyJFg/vklSf2R4RkZShr8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342599; c=relaxed/simple;
	bh=ZaR5vJ8VXu0gS5MPA0Fek+IbMlgWxUWDny7y6WZluSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tG8J62135lOmqUbso3p9Q2K4Prx0hz3cfkNnX02hGw9E0zwbgZkZa/kt9VOCTQslCf+F7wUEhO9NUNydssHwXyJv4nkr9CRnxltAM6Fnw7nJ4R4NUEQadpYrPX73dhKI6SbWZ+PQ3U1swp6zyH8cNePKayB2cez2c41qwhcmuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3lykH+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3lykH+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81811F000E9;
	Fri, 21 Aug 2026 20:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342598;
	bh=ljCQfdBfM+A/lKTC9DLBO+b2rP/2wSraR6zQ2aTGaHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l3lykH+YtgBY6w2WMZLDnZ/0vZnpdwFANDbmB3D51w82/mjkSaxJ6HuQFAMtmTOOk
	 Qridin9b1mjV1zDc5eDsqvSX6kyotTTYeOec7mAdv3jTJZpC615Y3kQsR+K8YIyuvh
	 U/ZosYrhiMTB26C9LZnXm1K2ab1xbrO+REdOOOGQ1b06YRqCLSaojhbAReHqv4Q0a6
	 QxBvpxQOgwye3zLFMjUMZUJ5aTr+fWnhXOmh+LF9PQRUSBlGQpTALd0UZSX9aa2Jd0
	 f2w7Iq5M4P2XGLMnIShYAt0jkApGFzPyxs0orIpprmppSvvB6JMRaEwRwsgm0ByErV
	 V67QJrhzyJlNQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 16/24] unwind_user/eh_frame: Ignore
 DW_CFA_GNU_args_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260821195259.2688377-17-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-17-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:03:17 +0000
Message-Id: <20260821200317.D81811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The DW_CFA_GNU_args_size DWARF CFI instruction is used by GCC to track
> the size of arguments pushed on the stack for exception handling
> purposes.  It is not needed for stack tracing.
>=20
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D16

