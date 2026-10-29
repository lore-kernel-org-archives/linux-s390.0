Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304988;
	b=aWtocjQIPnSDUdOGOAUK6ZSKFrQ5czhI8AVNnnH2RyCSefHtO0v9V7uVKl5HaGpWvgko
	 jMf1Z4hOmuoUm8V79CLC1JbXm5YQ+uj/5icTx3YK4pLgvSt5dyT9eELloYuklx7pTgNWp
	 JkNuQP8RpPQV2gPGZz7N9z665LVdJPcPG7zxap3JwwUHPrQ9AHzoN4Hqz1CIwFo+Z7BGs
	 E0b9F1f8qwvVTxApA4MbVdsOTkst/AP/RcraodbX64qrdJB28OmYgQsxmJx49NebmcMkb
	 l+QA5k7pwrGKQm4SdUAAyQkugW26YzBVT4FgM7SJ3aCPG797PvemLlL4DquMyCNjxCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304988;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k0riKDkmpB+NxHyZenG0wZNdZWzTCGXpo3AOeuZMly0=;
	b=B8TqOUEWl6MTQR6/35HwMahVesDG/uM3gDOHJj+mgEMlncYFmpsqlxmjnCSL1JQ2w8Ub
	 D9W+ZSjX9rduq8d0H4fXKoVNWlsCs/DaNaT7EwtMRE1joPr+Vpf4WRiQuJfU+jrBF5PlQ
	 nvDkWibuPKEtpYrvLeEO6Xy//4V7hKfnMwB8h6SbdXImKbKK1Ws5LQgq8icuFHG33iT4j
	 h2RRwyuW1pfrWTn1nMMwaRDvJbnLbz5+zC17uvFlMsQlWAoWxvM3XzkGYwmvkB05CiUGN
	 pbOu79StveMkaQWsyRBwnYAAhoq5lMkwGAfC89fJOyvatXB3SbU455MeJOAmKokeNPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mns3PMTV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71EB606A31A
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mns3PMTV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AB61F01824;
	Thu, 29 Oct 2026 20:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304988;
	bh=k0riKDkmpB+NxHyZenG0wZNdZWzTCGXpo3AOeuZMly0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mns3PMTVSvT74Pzw/23F8N/qinYCIJljca3No0lPyPWCZ8k08CnWqQAfRNnlWULsR
	 JYTcCixFkfQLqPrALk2bTR4b+T+u9ICpoNu6iBKEoRwxPYceJq+oMOU4LPpl8mxCtm
	 ND4norgxWDXO6t5OJJ3TpGWm1XR3AXZSpeSVdzVOSh0kSylfOm5GcErx3zAcGb1tz7
	 P0MlFAAy9UVMn/nd2QC5r3PcqRlU8FqyjwaeeV0/ea4WfypmjCuSKI3HbzbDkysaro
	 np7p+114ClEDdAykaywsit4UL7tZCq9AZFDIgOiiQ+IubAIejQi4PwGZoYvnKHM3ze
	 1FSQdP9/lisEQ==
Message-ID: <sashiko-outbox-189902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/15] mm/hugetlb: compare against persistent count when
 freeing lowmem folios
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-2-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-2-a0a033db180f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:16:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> try_to_free_low() gets a target number of persistent folios, but
> compares it with "nr_huge_pages", which includes surplus folios. As a
> result, it can free lowmem folios below that target.
>=20
> For example, with two persistent folios and one surplus folio, a target
> of two can still end up freeing one persistent folio.
>=20
> Compare against persistent_huge_pages() instead. Convert the macro to a
> helper function and place it before try_to_free_low().
>=20
> Fixes: 7893d1d505d5 ("hugetlb: Try to grow hugetlb pool for MAP_PRIVATE m=
appings")
> Cc: stable@kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-fixes_huge=
tlb-v1-0-a0a033db180f@kernel.org?part=3D2

