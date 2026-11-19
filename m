Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116889;
	b=cta3jDrKCveBFUe52T9pgY4Ufq/jNnuGzYEihcZrbDjvAVX0M0u8KI2FQTVZAZ4/UGOM
	 DQ8xd27v8Lh/cj/1bvank7SHxsI8JEPbWN4n17v+Q0SgHa1fP8ppvvyoTjdYAWFXZLmkI
	 gZEN7iHm57s05lm+h3aNqx/f26rYdyYqh+nRoq2oCg0FLTgAslj599GTki3C8tmuXkmOJ
	 f5I8Y0FVgLAaV8kp7ar77SplSZheDaMvIHah2DPHqo1Md6AECZoJAfuP0mgRdXryOo4iZ
	 k4bz/rH/y8l/1LJ8MDNs4ZxpOb8PHq4xWTy6lC9DII4Eocykdp3fWwzcvQUiviAcI9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116889;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1R9x6uI59Mzw3Ci+eY/t8XpDTfhjfmm9l3Pj32e6piY=;
	b=FEl9qOMS4EWAgbtzL7P+x2nO9HseH3E5Tpa0gfkLBuAc1UsnI4ZBGJrgVMhllC6w45Zg
	 Vm6vcXpXZR4fQQtFqG90Dp0eA5KRLgW/pLJjc2xRa5jzNHGUmZIE1fDptSUetP+SYzFg+
	 4EnOKbcGz+eoOb0V+A3KdYRdvugrI5fHxm6M6UOi7g95+wm2NYknMS4CDF6/xlacHtsfp
	 aJospQVKuZdorTSN10g2TK+g1tJWkKx04hOLorqWo9VnBV6tyJrCp1CxljqjAgvcMAc98
	 0Gm7PoWntLonIuhBySBZZ9+hR7pdNrILsjHqWxh6RzdUv6U8vf1oVLkQCekM1g5HUbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqEfvRUF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10A606A324
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqEfvRUF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A563A1F000C4;
	Thu, 19 Nov 2026 19:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116889;
	bh=1R9x6uI59Mzw3Ci+eY/t8XpDTfhjfmm9l3Pj32e6piY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EqEfvRUF6fesVoLW0ehsy6sP2nUsIAr57HJOr+c4kD7KEwRG4wx6cQ4Z3wVcB5xm6
	 WPojCy+Wy/KlG2cOUOGpVgdFxZPgkFu0MjeTqU/xSxpBTMcVVVS3T8UbUyqC4jZgwQ
	 eE2ALVaXZyCSwLu2x8+tIPE9tcouNLv2zaWnSjBGt/1fIBxb8gk8C9Vzr05xk8FCzx
	 SGE8heYPNfhLAfIo7mwdt/1dNId5fG2pXdFGDcTubVsOx9ZEJys5oK18xqWZ5ywnsi
	 KcyeWUbBbMBSR20F3x/XokI6/R54EYv9pPJoRcVznNpyk1Z8Y5GRn1/seyvJFPAMuB
	 shBKfhjJfZB1w==
Message-ID: <sashiko-outbox-223937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] kobject: Require explicit initialization of
 struct kobj_type::release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119192520.1983406-10-irogers@google.com>
References: <20261119192520.1983406-1-irogers@google.com>
 <20261119192520.1983406-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:34:48 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Documentation/core-api/kobject.rst states:
>=20
>   "One important point cannot be overstated: every kobject must have a
>   release() method, and the kobject must persist (in a consistent state)
>   until that method is called. If these constraints are not met, the code
>   is flawed. Note that the kernel will warn you if you forget to provide
>   a release() method. Do not try to get rid of this warning by providing
>   an \"empty\" release function."
>=20
> Annotate struct kobj_type::release with __must_init so the compiler
> diagnoses any struct kobj_type initializer that omits .release.
>=20
> For the remaining legacy struct kobj_type definitions that still omit a
> release callback, explicitly initialize .release =3D NULL and document
> each site's lifetime status:
> [ ... ]
>=20
> This change does not alter runtime behavior at these sites.
>=20
> Link: https://lpc.events/event/20/contributions/2392/
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119192520.1983=
406-1-irogers@google.com?part=3D9

