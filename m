Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855905;
	b=F6p+YZGJ5Lrl6tW10+9Q5R+9UXU3ey+pxYczoz9I0BtJtA3BBvwuTEhV8M8InJZTw+dB
	 aNl+Z5BH5aZy8cL2jiDCFXgYN2rcIhnv3vt24yimUen27pLC2NDBYXOk+AUAqwTVAAQ+m
	 AcGHuQGUopZzm9fdnz4rB9MGwAJdq5I1XFV+6Fp9poHz2evOlqhTqa/twhqIqqOGqOJvw
	 xoCyIVg8MLDJwP3lMEaZBaKhChVDayn+hQTBzAxViniBmFgxIFWrzC6x7eETec6v5RHTK
	 6k+TAhVTRnKu5vDry9491wdPx0/Uesnm/SfBtrj5ODz0IYjUDiaeYV+4rcS2QCTQNqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855905;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yXiVf2qwKnNxdQOD3Du4YHmz+V6nZrV7GjapDJM8u/A=;
	b=bf83GphP8lHPHQgNhp7t3O7I4dj+QbPY5+GEibaL2h9U+nhzVdZHQxnC+yIyNeVC+eU3
	 gZEh46aMZNjPjeZy+kAvWa/JB7ihhm1/OWR/wdEzZVGEpy3K5pdyAEjVc/j3cGOx7m50C
	 JHqPdoBKG/Hn4uEzNitlY5n91ct+J1t2ByG//vbb4li1mbF9UHFHQsWs2G5VlasMcaHGH
	 8xACdDbpv4KKcqahJeAIvv/vHB7wfqlqk7BzwviYgsxVz+bUIRirZwCJi9+bzI8T3XAmM
	 ifEVfM4dfQEQbFY2crYJ0Ts7OF+/W3181boZE6TnUNMjd68AE9NC0RaPG/n42i6lGDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRTi4rIw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB4606A336
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRTi4rIw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FC71F000C9;
	Mon, 16 Nov 2026 19:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855905;
	bh=yXiVf2qwKnNxdQOD3Du4YHmz+V6nZrV7GjapDJM8u/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRTi4rIwVF6LE5zN4nf4uDRv+TZmr9U7+5d/dQ5+H8nJQscmjr2dJDtzEERSZahMc
	 m9WszOTYK6jSqZc8pFiF8AL0aFkqoQC2TwUZGBcWGidWTSLh98SsAhpxPZrgtNHESD
	 +t8l9RivPOrvQOl74r6aAgR6PGHccaehtUxeJaAJ2a0glD4+xfByJsOZRQyt20Hkys
	 MbScFzbc37rsgnSo3IBs06cMWomNYMVt1cnIWgKAUnXN1Sus/75wWi93RCZTj/ygRZ
	 QhJOgX/44GCc3diYB4nKVw1tVCVyH2PyQ/YQGVdbxlT8aNXXD4jhvAOl1p2Rm4U1tt
	 K2aGVacTl+Xzg==
Message-ID: <sashiko-outbox-217526@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/15] mm/hugetlb: compare against persistent count
 when freeing lowmem folios
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-2-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-2-4dd9e94ea9ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:05:04 +0000
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
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D2

