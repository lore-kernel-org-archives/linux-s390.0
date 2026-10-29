Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304991;
	b=uNGfPQQobFgDpKa1U/OVlaYlxurFXDpuWoVDk7ikQwPOhX4qbS33r4lTlzOp4w9g8AzC
	 3zPtzVTisu21qLwJu36JpTyYIP6EDzHLFU2zY01mcY0pZG5khdabt65I4yr+J3L3lZ2HN
	 s1Mf4D6pyeEDQIDrcCIzyvWfcjZyrN0WiwPtFTUyqVOAF/+SNYKZGsnDdBABgme1mR8Pl
	 evGaYy9T5DxCeVt28/XcsSabi2HBTQR19eUYVt6xJ7yzfybe3XvEZqJN5pbDgt9z3pYmN
	 do7YacOi3bzw/YsIgUTyNIyA5xW8GW0hruN+fffwABmLH5lu3n5B+gYf8XeDSIMDGtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304991;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S+jj2gZqtPVRqQoHoOk6nk3OqzOSS4fq4g6Yr57jkqE=;
	b=4TaNwkpWvhiZE0nQPr0VqXWOg3aQGvethcVvntr9C9fXQ+pGaOSzob7UMYvRSbAjnEiC
	 ZmEIWl+wzGV3YzRcgCY8Dib/F5LP73X6KROT+UAMVvQ8iLmZB1esjfNHMadIE+ioau1hg
	 l2nz6B1STqGtwgUcjdh/tZE7S/+8eI+hlbJNf9mcQAcf1dEaQk/iSl+KYIAA3wLi08YJC
	 VwiUkUFqmwi6zYmhpr1iLHroXeqRRils6Ko0Um9VTixPtQleQKCSM72lZfqLWoDYr1IFJ
	 Aoak//al5K7ha7TrQqSlu0ZA0SIpvb0V7zOZ2lZ9CSHw7QJ5TIsECulmyYCXobiLj/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfTvwPev;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C8606A31D
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfTvwPev
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EA11F01824;
	Thu, 29 Oct 2026 20:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304991;
	bh=S+jj2gZqtPVRqQoHoOk6nk3OqzOSS4fq4g6Yr57jkqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QfTvwPev2hKglFpcxHjrpbMJKrT5Ey18qX3PkyVEAisORJaVkvMz+LAKujyT07wf6
	 GTxRc0aLHn5T/p232nD6aFWR9wjydnAo3+VWQnHcodJeKtaY1ygEgllNb/n71x/PC7
	 Lh94yzt9hsq9wLgdvz9IcLxugGsbF958cgU/TuGhSPJPLohaF/GYJtIIa46ldESlRf
	 iITzWUR+7IgUxhVvYFbHUZcOYcCpT7bPjT/k6upk4Zzx7+sVQRC+FKlL7Ppj/RduxT
	 VbJb2HmEbW2z0lgYqbFVrjeqgGitY/aHJslMAFmE/YKrAHHnSlK1znKskijGW6Oy2v
	 mQ5gkohazX3Ow==
Message-ID: <sashiko-outbox-189906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] mm/hugetlb: fix mremap() racing with page
 migration
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-6-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-6-a0a033db180f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:16:30 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Migration of anon hugetlb folios walks the anon_vma, so the file's
> i_mmap_rwsem does not serialize it against move_hugetlb_page_tables().
>=20
> There are various issues with that. Most importantly, move_huge_pte()
> releases both page table locks before the TLB is flushed. Migration can
> then find the destination entry and finish migration, reusing the old
> folio while the TLB still has entries cached.
>=20
> Hold the anon_vma write lock across the move and the final TLB flush.
> This also prevents concurrent rmap walks from missing entries moved
> during rollback.
>=20
> When we must allocate a destination page table, flush the TLB before
> dropping the anon_vma lock, then reacquire it after allocation.
>=20
> [ ... ]
>=20
> Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage ba=
cked vma")
> Cc: stable@kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-fixes_huge=
tlb-v1-0-a0a033db180f@kernel.org?part=3D6

