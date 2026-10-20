Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535723;
	b=Jm/nayMBkpVGb4uvxPQTQo920yIDjzsR5LOkNxkKyzD1F1VJuJU9qH+YrEXqFvuzTBrm
	 nOi+b+Ay3viLP86sN7PBkC+08L4Nds2xCh38RpfiadxwfXZWsAo6qTtnKt69D8INUivJj
	 b5TLYKVSq7KwYsIqlt+WhXPfOI6Luj6HG+m9nwoDm9XeeoMUH6AY4Lx+6EP21j0SxoOiF
	 IEZfWcl3YNbMZ7hivyrcZJqG/4X2tsQf0LIFQYbkTw1evrcIAnVXNN5Xh/+ET2Dyxt7eH
	 HSS8NaaovQ278zgKdPi+ZbO6UBMsLReKeYDCODmEFZUtyg7xNS8/T2p1hYyn0mpfXbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535723;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jTVej4XiZHu2/J1IznIB6FnyFrgfuyNpPk/uLcIpGv0=;
	b=3bOBQpXWSoIb372/11hCGTNgk41pVykX4jkNL57avyATpRw08zEgqheswNGGThvcIxdJ
	 abHIyybYtEQixBM64NnBq/G92IQ7nP8DIJsHUMNP30lc+hwrv18Gi7Ff/wCew9J2oV+oU
	 dh9iCgwvcjxOjTG6xmNhLS3DBOYyzKf10YacgWiq+epecGIMlIYgfkCPF/8/Vhvnnf4fB
	 76WDp9Xu9hDXrA2iVQB4cPjzjbvqjbJH7MClUVNwGqC82QhtT8PSSGjFtAmsEE8I8Mw0Z
	 pn4t3Kb+RJupbSX+DnLcviIQfs3djntwY4PO/AUq/8GT7VbK2jiMOfPS/XkIFPRAN/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSeqoUOe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF167606A31A
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSeqoUOe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA841F000C9;
	Tue, 20 Oct 2026 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792535722;
	bh=jTVej4XiZHu2/J1IznIB6FnyFrgfuyNpPk/uLcIpGv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gSeqoUOewGKTWyYAtu8nVdElVqXDvVRkPsEPHYaDPOl2NMvZSFMk/D4v4iS/vtiAj
	 25rMDAAWwPleYk4s/eyvlGNOBOumwVdhWwDD2SyUf2WkBJqBtnWvf4SDwaUguBdiS8
	 Xw7sS2EZkguh3YsLP8navyK+XIR5UBvy2H9Bl/+bdeDYWFSi66VuaZHJx18Kl/SeKH
	 A+U5lUKsqdmZUVyWGtnXIojOByvqC/nYiUti1lcKPSBhEnGA3fnTMAXl7vcIzr+1Ct
	 ltqxre8xZXGWK9kBBc6/EyHh/pgggovMy81nZXa/cXUiokuvT/ikIif8F0LcYA/XCW
	 NE0fvNxV+A9DQ==
Message-ID: <sashiko-outbox-179544@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] kbuild: Move testing of '-mfentry' back to Makefile
 from Kconfig
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020-kconfig-fix-mfentry-check-v1-1-428258bc0fc0@kernel.org>
References: <20261020-kconfig-fix-mfentry-check-v1-0-428258bc0fc0@kernel.org>
 <20261020-kconfig-fix-mfentry-check-v1-1-428258bc0fc0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 22:35:21 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Unlike cc-option in Kbuild, cc-option in Kconfig does not test options
> with either bit ('-m32' / '-m64') or endianness ('-mbig-endian' /
> '-mlittle-endian') flags because which flag to use may depend on the
> result of the configuration stage. This difference changes the result of
> testing for '-mfentry' support when using the kernel.org s390 cross
> compiler, which is configured for 32-bit by default.
>=20
>   $ s390-linux-gcc -mfentry -o /dev/null -x c -c /dev/null
>   cc1: error: '-mfentry' is supported only for 64-bit CPUs
>=20
> arch/s390/Makefile sets '-m64' in KBUILD_CPPFLAGS early, so '-mfentry'
> support was properly tested before the move to Kconfig.
>=20
>   $ s390-linux-gcc -m64 -mfentry -o /dev/null -x c -c /dev/null
>=20
> Ricardo reported another issue with moving this check from Kbuild to
> Kconfig, as '-mfentry' is not supported for x86_32 without '-fno-pic',
> which affects GCC builds that are configured with PIE enabled by
> default. arch/x86/Makefile adds '-fno-pic' to KBUILD_CFLAGS, so this
> works properly in Kbuild.
>=20
> Move the '-mfentry' check back into Kbuild to avoid adding additional
> complexity to the Kconfig entry.
>=20
> Fixes: 454e00cf8ee5 ("kbuild: avoid re-running compiler and linker probes=
")
> Reported-by: Ricardo Ribalda <ribalda@chromium.org>
> Closes: https://lore.kernel.org/20261020-pie-v1-1-9be09f2324b1@chromium.o=
rg/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-kconfig-fi=
x-mfentry-check-v1-0-428258bc0fc0@kernel.org?part=3D1

