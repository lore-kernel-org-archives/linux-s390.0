Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855907;
	b=0WDMgp5MvnVInT0aYpIEAlsSSLQ7fUYrHUCysQeufnzcNO5rX+3Q2e4Z5FCIg68xBtBL
	 KD4rjTV02MbXKy/rxR+QCUSp0s23TZujJ8SD9o53NKfdWHtOhKH0ktTU+VTMzuqLq0POA
	 lzR3imRQxrP7/1rAvjBU2DqFjszmWq3+nFxAjujTlgDhyXGYxajEfJjJoJciF94OQq3Cw
	 lus/3fHaRb+8K1n6ZtcaXzD0xnUlVVxqYKXaBOVlA+gh9LxCycSyG5lBO4std/K3EawHa
	 OX5XdPbJ2UnBGe6CqN4DQl/3ohrbCGsjypTUsIb9bt+hD60bv1fSZzG7QCNC1OXN4pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855907;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uLG2SC8maRAVzeS2eF90ChVZ+jl/9G6JnvLLF17H2G8=;
	b=MmbLvZVnZrA6eA1hnnvEA4E1HbL/T9Efk3ifHh9DfQ9jIiv+ehw3ytw8CEGOF8cy24ol
	 DKsWbVkpi8jKKeyTEbXH269zDu5MkwFe8E23EZuY80dvL/GTTaRPIRDncwBjKW3AKBn1/
	 7B0htOhwo8OY1Nz2gF7e/qzY+2gk1iWfD38SJeM9IgUrSruWFFNlWrJkj/eCfQFudrd57
	 AI7P6oyGcjHQ2vkconMhEa4gywjU4tAO6EqRfuXw9322LM1b8ROohpsjK63IVGHlmH1al
	 g7rLh+Css6EReJZcn/Q1xusP+iaU1XGJrv8g1kstwVlDg71M2v681SIQXehVTQ8YNOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3YWRF0p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D0606A333
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3YWRF0p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEFF1F000C4;
	Mon, 16 Nov 2026 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855907;
	bh=uLG2SC8maRAVzeS2eF90ChVZ+jl/9G6JnvLLF17H2G8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P3YWRF0pJdnThz1PcZU+qV6P5dzBKIYyEuHebl2Ok4ZkdLdSaAZplg8wVUt1jKj3p
	 Z1lc4tYmMB09Lk6oZs6Ukj+n1ZQZ8uowN/nWS25cxdSaFZWJ9bCefQrb9EKHTA4pwi
	 SPCXYOa+MikB8YqW2ICOcs8jssgBk9jxbAxHj1DE0dQ2UeSJW4F1mA5ygsB5c9N3AK
	 GotxqwhrTSv2ucKphjUnarzcPYz5OHhaVLe4aqe9NXCp/OAlXlFqmGfHkOMxaoP4Ri
	 2QVI31Yr1F+xQzhYIXlzpbfyJvZp5anb9Um1zxclJOFQ9efPv0GSQuloq/fVP7DddW
	 0pCGzk249l9QQ==
Message-ID: <sashiko-outbox-217529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/15] mm/hugetlb: keep surplus folios when the pool
 shrinks
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-5-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-5-4dd9e94ea9ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:05:06 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> Surplus folios are accounted per node. When shrinking the pool,
> set_max_huge_pages() removes free folios through
> remove_pool_hugetlb_folio() and accounts them as persistent folios.
>=20
> It can select a node whose folios are all surplus and leave its surplus
> count larger than its total count. Free surplus folios can back
> reservations created by gather_surplus_pages().
>=20
> For example, with nr_overcommit_hugepages =3D 8 on two nodes:
>=20
>   (node columns show total/free/surplus)
>=20
>                                       total free surp   node0   node1
> [ ... ]
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: cleanup code and description ]
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D5

