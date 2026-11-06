Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976689;
	b=SLPYmIBPXW4llb+3D0w355gQnO1bke1xksNgKhE5N7fvtf1cG0922T8neSCD4tjzphWp
	 +MarUgqSC36lp18tcEFGclIUP8+tUZiQnwOW/D3kU1kTVd9j7Ap1UyOA+c/ZLZJc9LMD0
	 1RfLyvQ+1A3mA+2bnAmfEkn1iUX7w1Pz1BgcMnRfHslgp2lMNaHPLmN5M/nil30zsS02b
	 VC8SrO5pQUtMwlRfroywhJ5WoXFIaKD+ZslBVwQpywdFmZO2jCzl4Otd9bGLkcNLyMM3L
	 pcjpnL3G5JYC9EYnMkGrD2eOrP+YZ50KXGMXkwrYtgW3/faIRayYHmY2Aaa06YcssXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976689;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8dNGnr1H9TEX8AZV16Sw16O3ChWY8YaHvNUIWOJ3DQk=;
	b=xYFnW9IrR9Ql1GdrkB/+aFYMemroF2cHBhur19fM9ycON7rMYmaUxlZ3Rxe2uJG2ad4P
	 stZ/P9m6vtTMICE9AVxCP6GBvVqEzrLXTC76I90Vd1He6Kr4Ruc1OFGpdGncOA4VX+fft
	 uofOiJ5KdKUAuHqvTQ9pO4fLOZdbwF/0uuh1heUMcIsSekP0y01wfSpjO7mIVQX2Ym5eu
	 HXhwuiodF8rAUR6eKr2CheFWwLgL4Aoxeowb1gVVda7EWITMdF5r4ZMUWDNZy8jVRUkWO
	 UvNJ56DDzebq4IDBhzUEpHQtckLhxgQyjbSgMtbpoND8xCMPTYMxldQ1/56x2+L1tOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZNWqYnI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF4606A32D
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZNWqYnI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3661F0089F;
	Fri,  6 Nov 2026 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976688;
	bh=8dNGnr1H9TEX8AZV16Sw16O3ChWY8YaHvNUIWOJ3DQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZNWqYnIGnhDOeGu8UpRLBzDVc2FXuebUhFx2P2alQh96BxVJv2d5qe0KOS3l2ZYs
	 IOEdsSCzSE+mqUkpx2rEazZv1H8iDxr3Flp0UwPot3fF1dBDBUINwRoe+dSwYsLoye
	 MG3fKttJwVqq4jNi5y0yrekNvYpRfBssXTMC5Wc7pO9MnZ0xW+A8RXNUsqwMkEB9U+
	 31yUuegwHCjTxjUkMyGefBBpwlyXMZLWNFrKn2SUNmgM8CYKMcVAaFqBq12NvJmAB0
	 12X23vL4nTlc6WIWHkkCvy/LS8t3HOq2DPARKkFG1FYp5uuhEoNlt3Xk82OtnGx8GE
	 EMaZFWjXVmQVA==
Message-ID: <sashiko-outbox-201619@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/15] lib/lz4: replace lz4_kernel_api.h's prototypes
 with <linux/lz4.h>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-14-ee04c3f0d7dc@samsung.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144312eucas1p26109d26cecef034bf7734283cb04b211@eucas1p2.samsung.com>
 <20261106-lz4-vendor-upstream-v2-14-ee04c3f0d7dc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:51:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> lz4_kernel_api.h carried its own copy of the twenty public prototypes
> because it could not include <linux/lz4.h>, which defined the stream
> types that upstream's headers also define.
>=20
> The types are incomplete now, so it can. Two prototype lists for one
> ABI is a drift hazard: the entry points were built against one and their
> callers against the other, so no compiler ever saw both, and MODVERSIONS
> would not catch a mismatch either, since it hashes the exporter's view
> only. Now there is one list.
>=20
> It also puts the public constants in scope of the entry points, so the
> size assertions can name them, and the HC level clamp can use
> LZ4HC_CLAMP_CLEVEL, static_asserted equal to upstream's
> LZ4HC_CLEVEL_OPT_MIN.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lz4-vendor=
-upstream-v2-0-ee04c3f0d7dc@samsung.com?part=3D14

