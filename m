Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855914;
	b=Ws2q1qwaHA+C+Fluvd7GwM8V8PUGnJJ5PN/ItvzWWdpjPGFHuHSPjj1T22um2EoIz1zb
	 q6bW7hpcRSzpKLC0EPkN0ws0LIG/i1xK8qQmbGXPobIvKFtuogFIJ4twAbjO8zGfQZdvc
	 z3xH6NxfXwTGEqDfMeHHfi/DRoYNPvVzFiib8AhzVuOlTxLzejMwo2oSi6TKfYdSx/gOy
	 KXefCHkZR1OVwcYuZtsFhtOQZwlmwJbTvyb8+k4EY/ni3yyKv1/k9r7ONQq3mLz42xfOw
	 2+2ZbbMi3FWfp50RBtJqE2v1SDn8Di/rEY1NNx1wjk6OUfOhGC7nlhJ0YfJ+Q/aWFkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZR02BRqXA2Gpn1JMTf2YUYUTL+6PYlgAEiim+xg50Lo=;
	b=r7ttg1WzGP11yyT187hzF359pt8TonQidTBffTgZoKJVpfkJ5gfBh4urJkqbwRLsrk/M
	 +ZWowZYimjkiJ8m4hBX1sPaOJltsiXG7OiiN+nK6GcteoUdTszHzIXkQImb68+wUgjG0k
	 5OLsbpm11mUp/Yc76s9nEcNSAfUSl8RQvhYDROftCziiZlJ9lO8ofM5fOH4Qka59rozUe
	 10PlpOv2c8Yhzul1W/qmMp4ikq5tY/BbX0NX6V6w6XTOEVqGYsh89gNYbCUgKTTJ/0ZGa
	 dTScu4s8nt08jvisdnMroiB+TSTtAwp30ehHn7FxhNdh8oA+7SBiJjUmFaIWvO/tY2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZWZrIVa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2E606A33D
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZWZrIVa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C801F000C4;
	Mon, 16 Nov 2026 19:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855913;
	bh=ZR02BRqXA2Gpn1JMTf2YUYUTL+6PYlgAEiim+xg50Lo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RZWZrIVafvM7R13myifOOxMXLgfGicn8m1ie/C9bhddc1NCmIMRCSAfrPW+801P97
	 5kSanWaWmE8HoAXtB6j0ey/QW/zd/EBkvHdMYsKW76NsXozcaDvwd/IYuxjV/2xm2r
	 t62evfJpdMtOyw3OCbNlV64/fq5EwWB4qbNIpj7i+FtQ9HntbonH5EFmlzjg+Q5cgu
	 pNdwhNu105c2dMQuu2O9Mx4K9bn9Luq2tlpKMCwkbsz4Vukk3AM3onJHq5w4l1NM4g
	 GjCkrYiIdLLbZX+ZOY9hGlJJPhZ9hugRzO1IfRZdn75HQsl6mbzPeV6Pjor8zyLNh5
	 6EJ4VzyM+nkZw==
Message-ID: <sashiko-outbox-217537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/15] mm/hugetlb: fix reservation leak on min_size=
 mounts
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-13-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-13-4dd9e94ea9ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:05:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Chris Mason <mason@kernel.org>
>=20
> Failed allocations for CoW mappings can leak reservations on hugetlbfs
> mounts with min_size=3D and no size=3D. The leaked reservations survive
> unmount.
>=20
> Note that this is only an accounting error and not a memory leak.
>=20
> HPG_restore_reserve makes free_huge_folio() restore the global
> reservation without returning it to the subpool. This assumes the
> reserve map holds the reservation. However, a CoW mapping may have no
> reserve map, or the map may already account for another folio at the
> same index.
>=20
> Commit 58db7c5fbe7d ("mm/hugetlb: fix avoid_reserve to allow taking
> [ ... ]
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify comments and improve description; updated Fixes ]
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D13

