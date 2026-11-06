Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976430;
	b=akpDTVaeIDQRoyMV+mU3ezh7oZXetapASVaGweBLVAP8mYp6cIaW3NwtYQcB6WlGSvCH
	 wqI9RONjAZ7xc4Ttw7LndOs0wmhRWoxkfP2H76T9cHYd2RfnsPgq9tkV0AGJ1wQhOX9sl
	 xAmLl4N1z8b0XxVaHVHYnQDmvECWzXHlUeVJ48I6HbtMlVETUkEZ/b4M7vsoJKkKOrf9U
	 mczcP8H5r+hHFv73ULi3CUSJFx7n6/nGzdbfUbonXYvWSc5vzw/JMkbisxPW6SslhY47e
	 yiJqDQt/i35yl3iGoLTzr5sNfvSMQuZSpGr3NSN1SmJcr+UiFmdKIoKVJnqSykwvqCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976430;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Uhnd/cXF44dbuXcqe4bAtulK5gcsaTe6drW+FaFIL0g=;
	b=MPivPohOqAFv2kQsBqV08oyvEpllBjmly8ZfrX35C+tGVyxyFhg9ZO05Q1y2gPBHbNof
	 sz0qs3laSvMpa65xrzwKfDJ08JCris3ATHg+FqoAOyLkuKKxLr+dXcer1GPlVRLcfJF/J
	 vWQg9/6OyGxOV3ZVEmzNDqNRGAlzAjG5F9U2JDrX6rGb+86DpxelZoP8XpYVafcaVFvOS
	 DTAQUisB9GruPMoOjn7ew8NxJPoDpIwguTWuvxAGU9Bs3Exf/9C68VTuH9Y7L2B1crQVP
	 m3sd6df4/ejwY+dipmf4rFOCZEW1YZRdUwQMggGvz9+BBATTQ0ex+6aUTgXLK9RsLOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MP9jaj6U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A38606A331
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MP9jaj6U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EA41F0089F;
	Fri,  6 Nov 2026 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976430;
	bh=Uhnd/cXF44dbuXcqe4bAtulK5gcsaTe6drW+FaFIL0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MP9jaj6UB+o7zwK+E9/SXs5EICFWSr0J+v14xB2r2AtxJneZMrfbGSA+zicqZc1WQ
	 bQHHF8F+2Bg9jZVZHQ4xi+Y8xo8rqIPoHJjhfidu6+0ICVT7x+330aGu3rOYLiKZfk
	 JUII2sFX1ps/ynXhSG7r/LByg4ZwJRm3CRtZRtXuSxMdgntwTZXvWBZpqLsXN/mvbu
	 6vcZwjgojmenILXfpoWIoSBERZ5FsyWr4kiO5tagW0XemkHq4MJ/kRJxkX9d05PkUQ
	 BrnLLlAmR9nuzKPkY/cwGFMU7UuUoqlI+T2HFyn2ceAUfjuS8Dv9cnc1m3Np4GGKGz
	 qU/K4xxsaijZw==
Message-ID: <sashiko-outbox-201606@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/15] lib/lz4: backport upstream's aarch64 fast
 decode loop enablement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-6-ee04c3f0d7dc@samsung.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144258eucas1p1f59ead3e337482e074bfb26f4553e70d@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-6-ee04c3f0d7dc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:47:09 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> v1.10.0 leaves LZ4_FAST_DEC_LOOP off for aarch64 built with clang, after
> a slowdown reported on some Android phones in 2019 (upstream PR #707).
> An arm64 kernel built with clang therefore decodes with the slower loop.
>=20
> Upstream has since enabled it for all aarch64, in three unreleased
> commits:
>=20
> commit 0aa33884faf5 ("[LZ4] Limit disabling LZ4_FAST_DEC_LOOP to aarch64+=
clang+android")
> commit 51f8af506b4a ("Fix missing endif")
> commit ed86bc1ed802 ("AArch64: Enable LZ4_FAST_DEC_LOOP for Android")
>=20
> Arm measured +3.5% to +15.6% on Cortex-A510 to X4 with clang. Take the
> lz4.c hunks of all three. This goes away at the next re-sync.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lz4-vendor=
-upstream-v2-0-ee04c3f0d7dc@samsung.com?part=3D6

