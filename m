Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855911;
	b=pnZ5j1B7eOlpPeX2rCLDJcS675F6/a8sk1O8hPrl+7iltKgH1WsjyWfxPxIvqXPJ/H3n
	 RaO+O9jnomhCHDWcbRMwTbkd7J7xeSV9SszECAyG4+qXpZlV7zyTY+XLLtY7Yz4hJ2H9y
	 gomgyLUupGhIq/MLAiWDmgG65GXrqddcMXtIddYUzLwtqTHRzNdAjl/VF+coEx3VJIqAG
	 SkjT6KtwZJ63j5Bcfu7kpusC8Ap5qjneEQXcFzm+gVGA0n78jd1AtQ0arLBE4a7aBMZow
	 YqWIseazAFXX6Wb2C4kRSoSvl0oAhomuyamar3Sf1mWJZ1LUSrGStcQqRAG4AA9zIKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855911;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PRoXZAyVz4x5LOtte/0i7+AJy4XD6nKEa0RgBRRr8Wk=;
	b=kFZcbr1IEuWaspqoWQ8hMb7mJv+3FYyxknS/3fhtsjSXIxyr8JsO5Zv0YdtplIVLizne
	 Z4V9mE0G90EPObM8umrFK1n2NXIGjgYbRvWsrzd1Xdae42zwS/nuhXJoOsc48XPsjnn4q
	 6uj7lLVxx9z0YOFkNx201qH8UadTqigVu2IsK4IK5TIIyUoTSOiEQTJ1OTNrRielXpFqP
	 gR5cIRCYpaf6tw0Ptg7cl9/JC4dabK2nAyqHwmWzC+g1gnmNDQJuYIF3AG93dkat5rtS6
	 VX71YM2ZaWxe49QBnd2hJq2lc4EKJfERpnmM7YQuQkW453zEx5I6V0PnybdtRnJ/pPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q/9RXJhI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F5606A339
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q/9RXJhI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB7E1F000C4;
	Mon, 16 Nov 2026 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855911;
	bh=PRoXZAyVz4x5LOtte/0i7+AJy4XD6nKEa0RgBRRr8Wk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q/9RXJhIaI/wwyovUrpcfZRYAok09XZSxYLDU1OE3LD/sxLswHbgMWagZ9DnoKmOj
	 z9qSZ8xuHQH4yKmtIH4fsk0HeyyWZqA9nroD4/8dFrBWh/OeVP5SREsQk6ylbGSy4u
	 R/zzHy/WXIaaHhkso9eAMKPQyQ1Ep3nAHIanSblxMahJXxESYlaBUdizLsbRwY9elm
	 /7LY3geKwSuhyX+geTxlVYrJWuWBVbN2dYyt0+D/nPJ+G/6ZTNUYdtnaRYLeuVaaFy
	 QM3u2jBoylKvF89EKlPGzzPTW71dF9el7sS4MC8N2t6Hv/TF9ZYM4vd9tJVOALNzNM
	 n42A2PFWSTz/A==
Message-ID: <sashiko-outbox-217534@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/15] mm/hugetlb: count again if the reserve map
 shrank
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-10-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-10-4dd9e94ea9ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:05:10 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> hugetlb_reserve_pages() asks region_chg() how many pages of the range are
> missing in the reserve map, charges the cgroup, the subpool and the pool
> for that many, and then lets region_add() fill the gaps.
>=20
> It copes with region_add() adding less, because a concurrent fault added
> an entry in the meantime; however, it does not expect it to add more.
>=20
> Since restore_reserve_on_error() can delete the entry of an allocation
> that failed later on, entries also disappear without the inode lock that
> mmap() holds. For a previously unreserved page, UFFDIO_COPY can do this
> when the source is not resident: it allocates a folio, which adds the
> entry, fails to copy with page faults disabled, and takes both back.
> memfd_alloc_folio() does it when it has made a reservation and gets no
> folio it may pin.
>=20
> [ ... ]
>=20
> Fixes: 846be08578ed ("mm/hugetlb: expand restore_reserve_on_error functio=
nality")
> Cc: stable@kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D10

