Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2BE3939A5
	for <linux-s390@vger.kernel.org>; Sun, 16 Aug 2026 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878620; cv=none; b=X5/2u/mMR9R8RiYiXpFInbwxNiO6SdrHptmTWgKxCJ3+riCQDgF0fxbDFKCc9WR/6ubpxbT6ZLvh5y5ve44Qi3lLv1AHZz0MXBaFG/9WPrJbdBt3Krn1/mpZsVkmNHxkkrVsOLBVx52N2xqEcMKUuYFalOdjneJi11H009E3u48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878620; c=relaxed/simple;
	bh=mfP8bQxjMUOZ2wVdtg+u00Bos5sxBJIHhohTt/hKK4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q9g2NOQ5NxWqfl86Qgl9o1vZsZn86exrkGvpviwOzjgsSY9bvP0DTbNgknI7u+ulHRnJKJ6qBto27/obbVu9JKgqwUO/OCqwHEWcCQl6ifkEL5ignOX4OisUO6PmE+AF7VP+KBwnNW3qX6n1JL/o5G+rSm+0MUDe08D4K4rJdKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmtM58VI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmtM58VI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E581F000E9;
	Sun, 16 Aug 2026 11:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786878619;
	bh=mfP8bQxjMUOZ2wVdtg+u00Bos5sxBJIHhohTt/hKK4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BmtM58VINN/hWew+tgaVa6E8oHVbN6unLTAz38claz1RzXlJe+G3FlM5N2XScTlic
	 kfHKiH+fZI/MxB0YejWCIpWBzFIqvI+ZcBGE+Tljur5Nt39viPwOK/UKG5VWs5cWC9
	 kH/zAE28Sw5qacJRNWb7hyv7nHu8K2OPFpbOK43t3cezDG0BqtvHtQPmXm1l6ajJHa
	 7Bk7/5gQGxHIsWZd3IeZuNo4RMwaInNdF1z9wT3O5nhFUouBFIaESusuptROD7bfjF
	 6sJ6HdGFFhcjBHQ11Dt9NW8HgQ0XllSHKGmUYOn0ORY8I77z95REy+bWf49gZ7Qfif
	 GVNqP+rwo4jVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] mm/vmalloc: make set_area_direct_map HUGE_VMAP
 friendly
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-4-90944a3ad43f@kernel.org>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-4-90944a3ad43f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 11:10:18 +0000
Message-Id: <20260816111019.34E581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> set_area_direct_map() always updates direct map alias permissions in
> single page increments.
>=20
> For HUGE_VMAP areas it's suboptimal. Not only the loop in
> set_area_direct_map() needlessly has more iterations (e.g times 512 on
> x86), but it also causes fragmentation of the direct map that could be
> avoided for the HUGE_VMAP areas populated with large pages.
>=20
> All pages in an area are always of the same order: either same-order
> large pages when VM_ALLOW_HUGE_VMAP is set and all huge pages were
> successfully allocated, or order-0 page when VM_ALLOW_HUGE_VMAP is
> cleared or when huge pages allocation fails and fallback path is taken.
>=20
> Instead of updating the direct map permissions for every order-0 page in
> an area, use the area's page_order as the loop increment and update the
> large pages in one call to set_direct_map_{invalid,default}_noflush().
>=20
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816-execmem-se=
t-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org?part=3D4

