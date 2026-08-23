Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBFF3655CE
	for <linux-s390@vger.kernel.org>; Sun, 23 Aug 2026 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787486310; cv=none; b=eoVFtZ6OlGoUAxkJ30KVBAmvuymBur9UEx87DHpDzyuTz3XU0Mat252k/HOLw0O78QAR53WdC2LEi9TIZ508WSrg7iMLM/DO27vjTTJs6k/gdhkD9GUCvdhw20XHvKvB9qVgdvEuz6mUyOo1sEGMEAt12jmfq80kG0vTwrbx7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787486310; c=relaxed/simple;
	bh=4/NJZuUBaM36PKUX5hYsz0UgR6GtYGKC3LFv++26mTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I2iXQypacpDHoaC5/NKWmEPxUTYoRvxZ9rTAmLpCaigQZuAu/1W5MaHwq0L9kX8NkkwRa6RLZMW9yXvY9vSQO+hDrMDBPzfRzkQzzoztfn1iV3uGdQ2h5mHnQvYCVoeAySWTQB/Pxfg/uiVkGNuxKTwxBtUDijp99N6KrP2cx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXsjuUjz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXsjuUjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920D21F000E9;
	Sun, 23 Aug 2026 11:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787486308;
	bh=4/NJZuUBaM36PKUX5hYsz0UgR6GtYGKC3LFv++26mTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BXsjuUjzV5pe6GGmkRGwsyqOd+jn3jeVX/xW3k1qTAKQTKPepwwgP+JtP5QKZ81j3
	 XYseRor8ZjtOB9dbFf1ocDSpbVs6YAxFXHFL++a2NznNbA2TBahLcBj9erVaxUZemO
	 7SmT0rpMs3DCoKI4r2sgRJIsjBxwBGyAxqqB6J0XuAXoAiNqoYoWXhD2UsFAdd/rvU
	 P0GTpDcVSAVKPE+YriZVv/HCQ2ezkz5/picUen3m2PtGXF4XlTAxYw6ZAYEiK6MSMt
	 L6nW6r3BdQ4XSCvCQB1GfZve2oJH3PsdGJ54vQIPhQQWRaZDNj7sp/iSlRdVrmFpfg
	 fx6xuOdZtGJOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] mm/vmalloc: make set_area_direct_map HUGE_VMAP
 friendly
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260823-execmem-set-vm-perms-v0-2-v2-4-b013a37d84b3@kernel.org>
References: <20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org>
 <20260823-execmem-set-vm-perms-v0-2-v2-4-b013a37d84b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 11:58:28 +0000
Message-Id: <20260823115828.920D21F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823-execmem-se=
t-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org?part=3D4

