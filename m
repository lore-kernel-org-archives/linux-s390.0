Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78E3BB57
	for <linux-s390@vger.kernel.org>; Sat, 26 Sep 2026 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790415486; cv=none; b=MDAlaR2i3PteBaX7giTIjJoYW9MgiiRhBco7NUAw399iSwEaR0uk+IvJmJG1gmZCeLAe0latuxYQ6plvyNPRcIsAjYQT3zCYIUeQS7NbnNASE/7DTAflDSJOaKRBdjqfvWjGuJjUlRiI+OTe+oKe4lvzlNzn0ObIXcD2m1hRSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790415486; c=relaxed/simple;
	bh=M+RqIvcQ6bbptMih0p5gzBmegcRAj9bTtvyUZm43BCA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ec6C1RNe+50fky6ee8PQ944dIB2UQGkH5M9ETAqdCa6CfoxArWF0oIUOKeOsgLVn6OtTbfTjP0k+8igNApiCUw0P8TMXK3aNJO+E9FpQmLebJA1XL305APsZHwvN/B0R/JXo9InT6v9F9/at1Tpk2T6RYLwej8ODFjVCuVKxDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVqqYHLa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVqqYHLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0299A1F000FF;
	Sat, 26 Sep 2026 09:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790415485;
	bh=M+RqIvcQ6bbptMih0p5gzBmegcRAj9bTtvyUZm43BCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gVqqYHLazsaQ3gGSABjP70BobRDZ2SXK7fa8bcaOJZ4xGftZM8WSxQsOAQHVp0Etd
	 3o7a5asJPvGFN+5te+/FKmJBNv5u0uESskgiVIXhEaRzLRhqjcYZprx2VQR44P0l4n
	 F4TmasXYb5rSoUEARuOMCw3JUHZBau2bmUp24VnSeGpCv0bJd1Fv6Dz6mCZKi1Hqli
	 89NCHinVjGZJ7PsZG5J/R7Wr1chGemQQhjsLKzoXiYemWSgaHiSBvEA4QaL1UXV3HW
	 gaknuX4BUrAPA9jDtzz1DhQB22fZfVVTfAB8eR3hSLhlwSz0HSmZeWWqSlNYM01TZU
	 zUHkjpMUNPkzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] arch, mm: promote DEBUG_WX to CHECK_WX
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260926-direct-map-verify-wx-v2-1-efcd64a6b74a@kernel.org>
References: <20260926-direct-map-verify-wx-v2-1-efcd64a6b74a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 09:38:04 +0000
Message-Id: <20260926093805.0299A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Verification that the kernel does not have writable + executable
> mappings is about detecting security risks rather than a pure debug
> feature.
>=20
> Major distribution configurations enable it in their kernels as well as
> defconfigs of most architectures that have ARCH_HAS_DEBUG_WX.
>=20
> Rename relevant generic configuration options to use CHECK_WX and move
> their definitions from mm/Kconfig.debug to mm/Kconfig.
>=20
> Rename *debug_checkwx() funcitons and macros to *pgtable_checkwx().
>=20
> For arm that does not widely enable it, only rename its variants of the
> config options.
>=20
> Enabling CHECK_WX adds a few kilobytes to the kernel binary and while
> the added size can be slightly reduced with churny updates of
> architecture implementations of ptdump, the core functionality takes
> most of the added size. It cannot be moved to .init.text because the
> verification has to happen after init sections are freed.
>=20
> With this, make generic CHECK_WX default to STRICT_KERNEL_RWX while
> still leaving users targeting small kernels the possibility to opt-out.
>=20
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-direct-map=
-verify-wx-v2-1-efcd64a6b74a@kernel.org?part=3D1

