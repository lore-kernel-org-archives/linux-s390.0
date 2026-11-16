Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855915;
	b=LeCKmZ7ecdZuQQUH7xmPgguL69QaU/YZJ7uey385kxe4VHa6lXssHADpPgMdpZjcwQES
	 2cr3QjAViWvolft6tsvTBywSh4qzVu4YPeQU8wQ0AUPpip5blUm4XR9Nf10audQoxOwvM
	 m+C/1fhXN6BHVX8cWMYeb7dWpssnuVhQv/3z2GBLyiALy5ekf3iG/lyhW4oOvNd8Kw9N5
	 MLLpvQgUu0uNbpCQsIEbWIEIE3t/IcoBUf0fBerh+E4xTk1P9o1Zes1OprN8KtcTnMOI5
	 UDdag626hpdYVntGdEK6IcVBQglUY+eG8QDsl1fof+NvIUFCaNiQ0MgU59YxCFtYIsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pm4TS8OcCIHbNL9lCyS5yC/Is7ktO29O75N9j2v8c+k=;
	b=aw00mqehGYRO1V3UIT4ph+/mTn9yDdYlzYilkkFtmgSM19ywVJxkLRlgZcMGD0J0Ufqs
	 AZyiWv2jvMqgaWG+Dta1e4uBHppTSgtJi5ab3dNgoRU5WC44A9gvZv+jZN3dvNyN5GRK3
	 j/lqEjnBl73KQnbeyDsKCsqzoqr5tMe+0kAv5w+JfLPXHVdADP71kinoL+xDvVqMhDqrC
	 h55FJeIxveccW7Ho9623YUl7tMPlBAgL6Dmgg62tdbhiZ/ZW8bM02EljmECFxe35Lflb8
	 UJou/HognZvyfdHehpOvQkeMDKWwgbV3tM26cTORAsZ9YD2dvrmji2QznNDIu1DaJ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMg4VnI2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D9606A31C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMg4VnI2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3440A1F000C4;
	Mon, 16 Nov 2026 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855915;
	bh=pm4TS8OcCIHbNL9lCyS5yC/Is7ktO29O75N9j2v8c+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JMg4VnI2fvcFQqREY2yKM+hbt9xGfoMDoVogn6yFX2aPvTeK/KC9L4zc8ln3H599+
	 G8xlGB/f9AjfZ4qG99K+aCv1bsDM6uIxZNRb+uLFdgTZOL0/7D/kKj11LuaeoUiYNq
	 GychK5uyxT17VOwXkvGgbF5FlKH26EE5H2d4iGNrC9BZ/w9dyueheFBQWL8etJ50dg
	 e3J5f1oYE0cVZeyiRLCHYOHLI7HvD7869vYMYW20MVvlAkh0iD4ebF/2kYnAI5MP4/
	 nGugq+M+q9FkDFlBouTjJ3DiCcebKSeC/0jlY69XTodDIgDZT6uAV3S3Ssu2MD9gB9
	 kf7epFJDVheHA==
Message-ID: <sashiko-outbox-217539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/15] mm/hugetlb: delay anon folio rmap removal
 until after the TLB flush
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-15-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-15-4dd9e94ea9ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:05:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> After fork(), parent and child map anonymous folios read-only shared
> by CoW. On a write fault, hugetlb_wp() reuses an anonymous page instead of
> copying it if its mapcount is 1. As documented, switching to the safer
> refcount would cause more harm than help with these scarce resources.
>=20
> munmap() and MADV_DONTNEED unmap such folios and decrement the mapcount
> before the TLB is flushed. Until then, another thread of the process can
> still read the page through a stale TLB entry:
>=20
>     child: reader        child: munmap()       parent: writer
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     reads the page
>                          clears the entry
>                          mapcount drops to 1
>                                                store to the page
> [ ... ]
> for applications with different parent vs. child trust boundaries.
>=20
> Fixes: 24669e58477e ("hugetlb: use mmu_gather instead of a temporary link=
ed list for accumulating pages")
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D15

