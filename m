Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855910;
	b=vMIJ9W+C5ypzOkCqDiv3Ox0cql+LQw46of7Th0gX95cDAT0JuPkZZG60vKOlqcoojdeq
	 JPhuzHeZd6b4BQ5n+hoDBm8/+bcwzGYqP7k4jRtWjvnnufTIujNO3Sw/K+g226UZFC0XC
	 XCdxmzS8HkqzfbssD09LZY7cTw0BzwbeDrIWhe0igEK1VBCb5/SF9x9Bw+rdrTFLFuB8I
	 Am0GQJwIhie8RHXVhPnqhdxtqgqm/irWert4pfKm6zlLQ46DcrqIwKM+omSqJe79W5mdI
	 5CtOKFE3BPnJdwCLBJc6ff196BTy3sjJrvR3Na/lDyeM/kQjlZLTLMIfMY+rExByX2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855910;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TXedyAp+59KVXk+PwY7QmUyek3gKtMyIl250R8bOwUI=;
	b=bGnqSmTo3ZeL4noZrQBjd2g3qXNxlOXr6HRNTvv2+NMLM6ePsj4+TuBXaInjg284aEaz
	 2gDp99s8S7ZunC6lPB5++lwcGUJK4p9O81FCbrDBGxj5q8ZaDwyri5Ae/igDh7OVKOeD1
	 YxFjIQ6f/Eip1Wxhui6wepuIY+hOz1Y4PPZhVFa7dofi5McC8CfH7TGqbtWgMNNwyfXAz
	 JFAPNWRPE1B5F5/owbBYD/4FIR9STNehyJU3ZvMCTQYjkBH7GVDeXAqUyInpehR/QTwvu
	 vxH4AR2JH0JJk8LHSrakm4SxiwfpMMn0tUXBcFaTmzStxy2JqEf9qq68AXBJojcY0xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXl8eP39;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1824606A337
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXl8eP39
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8361F000C4;
	Mon, 16 Nov 2026 19:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855910;
	bh=TXedyAp+59KVXk+PwY7QmUyek3gKtMyIl250R8bOwUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WXl8eP39Dejp5AUT72U7CeJ2X2MGmPmKai23eKB02aOr/9Qjk5SG0oFuQ+xuO8Hwp
	 AGlbnLTo05NYUbWxFYYipUeukSFzX4Lujn8kKDHO55c+q1GuiX6Yf03cTUjXcEmU2+
	 S8vAxgrGYSNJSQZp/ZApoRSz9tWuAoGUYe+bFx7y75/Es2WK/jtQ/cegpEVRErxKUp
	 mdh7iN1jDI7fj/TMthK33q2XWwFpx0hJtHehLP3iWks1YOlshxG1ErlMTpfDy9DDPB
	 2jisJLytjVGMAFu3Uys66qO+KnZ3RFx+R0R2aIDloO95M/PbqlbtyyGcPrM8+cheY/
	 VBA3LIYgUCL4g==
Message-ID: <sashiko-outbox-217533@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/15] mm/memfd: recheck the page cache before
 allocating a hugetlb folio
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-9-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-9-4dd9e94ea9ac@kernel.org>
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

> A concurrent fault or PIN request can populate the page cache
> after memfd_pin_folios() misses it in the page cache but before
> memfd_alloc_folio() takes the fault mutex. The latter still tries to
> allocate another folio and can return -ENOMEM even though the requested
> folio is already cached.
>=20
> In particular, hugetlb_reserve_pages() finds the existing reservation-map
> entry and reserves nothing. If no global reservations remain,
> alloc_hugetlb_folio_reserve() fails even when the pool has free pages,
> effectively failing memfd_pin_folios().
>=20
> Recheck the page cache before reserving or allocating. If the folio is
> present, drop the lookup reference and return -EEXIST so
> memfd_pin_folios() retries its lookup.
>=20
> This is probably not worth backporting to stable.
>=20
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning me=
mfd folios")
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D9

