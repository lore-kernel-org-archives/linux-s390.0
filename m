Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E39441619
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777300; cv=none; b=GCeZn7GDO6nHkxamBNemy+tgcLIYb8A3ymwZGcUdf2M5Cr79zg1e6u6g1clfdH49Sc1J8Iv1cUwjfQuOReAxGJlsMIJPit78+WFm8W/jKKiN3mVG20IqjVgDwqdw8D/P/fH4h1eeM8huCopl+rZgbykyV+5xbsIs6ix9lIspSsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777300; c=relaxed/simple;
	bh=MRKVUXItFU0CgfOxfua2qXxogvMOEHhHNbXkmBxzTC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kMvCuR0vOBDCLfxg3/8mu7Y75OAFvyWnFKegYz8d89V8BcWlYxmCYbZMSVyaY/PaZnY6eglGp4FBaJRLnJjw5IOVlXoZavQ/omVHCcxLdC4TujfdO0KcKoL1fa3iKaxv/BCAgOQ9YT9AROAr90gjioNxQVlEoBg4ltim3KktFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqSQT6wC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqSQT6wC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7201F00A3A;
	Mon,  7 Sep 2026 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777299;
	bh=MRKVUXItFU0CgfOxfua2qXxogvMOEHhHNbXkmBxzTC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mqSQT6wCrXS7Zz0eGIvveYH13rva5sbodxA4rvdhO/+2ZPuOMGESydObBg4jZdsa6
	 S7vFlha9vHTLvLfc98H7Y4lPl1d5z3uAxl3g80vJEcPZkwPogPXxcwExc3o2m8FNdp
	 /ntKpfjPXqLqwZOfx1t0WRDAXrEFRUFsFEn82r4ig5tvKV/TEoSgTXt3L3CgKT2jFp
	 C9UjytH41rP1ZBdfgb/IYMpP9H5FfRz4rrklQYsFLKOmWnmh/L5pHdmoFCWLdQGXz3
	 ukxPcgBabHF9+ZU1HkVtGlXIjCWK007FYnfTj7TlIx/GvwpvlJTxSEIW6F3DOCaOSY
	 2AVzJoxyj4WzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] s390/chsc: Use kzalloc() for the SEI work area
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260907-s390-cio-ready-v1-2-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-2-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:34:58 +0000
Message-Id: <20260907103458.BE7201F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> chsc_init() allocates the work area for store event information data.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D2

