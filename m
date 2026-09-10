Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733E745D90A
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038917; cv=none; b=B9FWpttck1uzY7ru7i0iI63+PmtzSMIZymbpSoBQ8bggSwgywREMjC93EyUH6LQMEZlkPKRR0vUrk5m2DcpwkMxWwuSI0Wq5Yb6CkRzO0KfEAclcSibNXkpC2AFegaJqJFohHw9k/wXx7YJ2FX0+Ncw8AHZJq2XDU8sVE7O94WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038917; c=relaxed/simple;
	bh=pUDRGTVrwT7ncSTxJwxSrcOD0ERx+5fwpUJgSXaDeVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MUB4IAoDPdmhiq2xX8j9tMrv6vomeUXkPLy1FMVbnJEp+XBDjlchV73IJUtZB0EHtAax2JrI+5sGRT+cxirR4rtqazM9/GyugMCTU+Z6XcHR2ej/J+iehTu0L4PA/ctR9Px7Glau8onWQMDGCIFYf0hjEoYepYOh84324P0+nPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqMErAuO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqMErAuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1EA1F000FF;
	Thu, 10 Sep 2026 11:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038916;
	bh=pUDRGTVrwT7ncSTxJwxSrcOD0ERx+5fwpUJgSXaDeVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IqMErAuO7ufi6QX9QOZlZltS2OIURwHuHiX6OTAK2dsaQY4EYyT9LcmH1tlggVT2Y
	 TK1i4KudzYgrKT60wO83cVZAqVC1O9VRwggJ9p3wr0xaNkutIxa0kwYEaXmI30YWq2
	 9BzFGKVrqFM9kBmLK3i/SV4as7Zzca6o8WAADrLFtldhq0jf/z6phJpEs6M9/vraQa
	 WZwBN3dijKM954VM9wWJgAMBQryNy199DeuCTepZfygZ1UUmDjD+Sd07sN8KRC5NeZ
	 lIxU0a+Hxa5ejTCVjil7MSnT6TNMmKIHW7DK07BO9TySkXcLjpYIL/SGMJ5MM/msZS
	 1TJUGuCUNiD0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/13] s390/qdio_setup: Use kzalloc() for QDIO
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260910-s390-cio-ready-v2-10-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-10-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:15:15 +0000
Message-Id: <20260910111516.0C1EA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> qdio_alloc_buffers() allocates the QDIO buffers.
>=20
> This memory can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-s390-cio-r=
eady-v2-0-e931086fdde1@kernel.org?part=3D10

