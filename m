Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855910;
	b=MxxZLCLiw5yBqqcenVyppoKo2a2JyXht42jXkcTlAiP69k1aUPGl7EOqqHD3ap6fTgPF
	 pobvDG4Asl0XpVH2Mq7nG4ZwfMki3hupQgKVQjCLQBQCiEk1720urocH3cO3Mwt7n72Ca
	 uN9axqDs+BdwvzbiY++TvUwMIKqr6zc/Q1QgPx8+Jo4fvpbQ2tKf5EvzLgLdnc5cV7nTY
	 lKfyR6AlUgvFCsjAN74bXdRSmvD9+wgrJclvvsTd5/BEZ0nlrQJnOx1chQ87RBDPz1umR
	 raM8Sga1m0RZoznMBrDi/L0Y6wLFaS6YsopscjUghZ+aaAokgWzxeQEw1BildH0AMnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855910;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KT8yIaRjozN51fJ+bZUALX+JI7kJpFBCmeV7THgmz0Y=;
	b=f5A+bKLWTT1o3Dzgl81kQO0qS3i+M00waK1XNTYWzl3sl9N4Gz+J+WDChN9OKpFLc9LT
	 QXqHm8G6Y4zt6fb/FR+e0+ZyhHocxbT9MlamkspgXI6dv+VrhAUnfyo8iIBMChCdb22iU
	 bG1r4IialwIX+Bw76PfgBQHqPug6ygb0CtUojwOzS2b1TXn1tKewCFjSDeVjGK0zU76hM
	 HfwITOIA4MgRbdCUZhU5npx78dIJEjGivAfhyVJD/bp6p4aqDmMjPOoD00/LxeeLpEVBc
	 CIKNC8E5qIsBmznMOX+CjO6imZSXpYkTzUrCV0/7OKXd2He5XI7lcBHh2za+oA5RAzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbRj0bSh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0A606A883
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbRj0bSh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9088D1F000C4;
	Mon, 16 Nov 2026 19:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855909;
	bh=KT8yIaRjozN51fJ+bZUALX+JI7kJpFBCmeV7THgmz0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jbRj0bShJAaOvKoIzmFgREoCtMs8pN8Zn+14OEPIaULNMgJV0o6X3MKMlo4+MZvYF
	 B2141HT2UwXd+1TqX8DaTLi+nO2DtoEmrwL3VSidivVzFpGkqbdujm7srUuyTpG1YU
	 mDzgg5f01h4MxdWuEudWfdhdavtA7n3Lt4al/j8KNivhYBqyp0jMUgrjx0vR7ySL0g
	 xMEpe+F6/8MAk0CSDjy5NTDb8C8thXhacmu9rEKqV/i4T2oIAUawtISEzv0oeMpGm1
	 /uUxtFYe5pXprIEiXy3QFCRT2Utm37epWrbAwtJi8enbE6+TRF6D1OUJzV7HHyo+gk
	 6KMz1PwyGbByA==
Message-ID: <sashiko-outbox-217532@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/15] mm/hugetlb: serialize page-cache allocations
 with truncation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-8-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-8-4dd9e94ea9ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:05:09 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Truncation can remove an inode reservation while a fault is still
> allocating its folio. UFFDIO_COPY and memfd pinning can also consume
> reservations beyond the new i_size. This can underflow resv_huge_pages
> and leave folios beyond EOF.
>=20
> The main issue is that truncation takes the fault mutex for folios in
> the page-cache, but it has no clue about faults that are still being
> processed concurrently.
>=20
> Matthew Wilcox raised mapping->invalidate_lock in a different upstream
> hugetlb locking discussion:
>=20
>   "although I wonder if we still need the fault mutex array, given that we
>    now have mapping->invalidate_lock?"
>=20
> [ ... ]
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning me=
mfd folios")
> Cc: stable@kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Link: https://lore.kernel.org/all/ajMfdQf-Fspwmstr@casper.infradead.org/
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D8

