Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304990;
	b=YOdnuymWJqrgSQfgcm2hHPmTHTYEVWNZLKTV9Mxem4LKJVySIIi0um6NQDelFE6vK0hA
	 oP0OJ0vJcYvgmObZXoWWOIYmzhltga8INt+eOcdUOW6TyTA/GlZrg8Gy/LTm6PazfMcBR
	 JSIaK1q1Q4nsIbd3cofIAJvdXZwvLmXxnyOGAY1ur5DyZ9r+q3nMYbPEbRXOUFITkVOAY
	 +ze15TWIA9ofYCdybDRKsCuP3WR0Ek0s9qunlJ6F5m4RJKGXwviUEyOn8kUVzMxmUlSb0
	 3iea1O7B0iwIxcmUhqMyJ6E5A5rlzexHxfzqEVfyzstnV2pvJNGzry4JDiXnPA60M/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304990;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oboaRRI56d8Ju7znG5XcYnqzTy/13vyUiakjbBPxjOE=;
	b=0Y+n7QZiMnlzYx17p2pzc8bYL5i41tmgA5azqNVXkLXw/A77SBzfFHswW4cC5fR3R4+Y
	 Q9bX8bclY4V+UWVfmnfBAiqJJEpbJiFxucQOYlAmCzIKf76kfDeR2Woh/CCL2+wFsgj10
	 gwdDsfupAm4+udzntiaJNEjcLYKtJFXhBgyXMGfwwtjxA0YYBVH0fmkci0tOO2BG2hPCI
	 W4SnodPjtoTtj/ByPvJEfwHdRfIicvWq9iknwyEjkUC/Urv00uazFeAFSHpVFo3jkuJG4
	 Wbtv/cXfjWqYRuEuTvec/8cW77i+m72p+s17Er6mhZ84cluAwJamG+RuO/t7Eg8yJmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwvFcu6S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720A606A31A
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwvFcu6S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5FD1F01824;
	Thu, 29 Oct 2026 20:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304990;
	bh=oboaRRI56d8Ju7znG5XcYnqzTy/13vyUiakjbBPxjOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UwvFcu6S9nsLPKGjZpfCRtBqOQ4SDSJu0PP0VKl+xreBTObWFNNESdZ+36C/4MyCi
	 nNRQx3De88WgrwdB0ACMiL7+qDowDjdOwu8ZZeTZl5YMjbrqQ4uqs9sc8ITHgQuYkT
	 aUsOdSjA4xlu1YDTsFxR9RoeTVuP4wsHzbOFS5XKlUSv/JXLuDIvbvRnvy7wk9U66S
	 aix1FgmBrh5J3ju57eG2bZ5K9Bm8bWksTcp/YpiNftO0hRGsv3b8BAjIalSWZkVyL+
	 +SQbsY6IBY9CTQPJjpRbnwfx8mIVTpUozobCKipeHdoh3WuhBaHsradFyNdLXU02HG
	 m/s/ZPisQnFow==
Message-ID: <sashiko-outbox-189904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/15] mm/hugetlb: account temporary folios separately
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-4-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-4-a0a033db180f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:16:29 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Hugetlb migration might have to allocate a temporary folio through
> alloc_migrate_hugetlb_folio(). Such folios are currently accounted in
> "nr_huge_pages" but not in "surplus_huge_pages". persistent_huge_pages()
> can mistake them as persistent huge pages, as it merely calculates the
> difference.
>=20
> If set_max_huge_pages() shrinks the pool at the wrong time, it will turn
> hugetlb folios into surplus folios until persistent_huge_pages() returns
> the desired number.
>=20
> After the migration (successful or unsuccessful) either the new (temporar=
y)
> folio or the old folio gets freed: this will reduce "nr_huge_pages" but
> not "surplus_huge_pages", to undo what was done when allocating a
> temporary folio.
>=20
> [ ... ]
>=20
> Fixes: ab5ac90aecf5 ("mm, hugetlb: do not rely on overcommit limit during=
 migration")
> Cc: stable@kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-fixes_huge=
tlb-v1-0-a0a033db180f@kernel.org?part=3D4

