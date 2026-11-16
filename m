Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855906;
	b=3luuM2FT9SkV9yOaGAtbiPEOVrSUEO/JfaGy+sNb7ML64GSARXCJolJXJpWMzHQ8F1of
	 tVDdsvxDl80QSu+j7VyAW/OOw3oRHph7EBogc5Wp6rUB5LT7sRkTCgsSZ/dZflRBQoWeF
	 uuLZJyZ+3ed0rOGU49nWDu+GylTPmy7Lr3ULw2fekYrWPprREWYg/RzBN3idp2/VrD9zd
	 dDl3gA91mYAYBwCMRZWKBefgzjMXsUH7xQA/Vv7BXY0xdNXryMfBoT6wWjAFIp3Ug/79C
	 QL3ccNCHVNgiQXJwGyYQA9CfH+niU07G8gAulTIN2K9nF43r3E+R6e021XINlzIHV+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855906;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DhDRC0RZ9+n7vvF7WkuaW6oJu+R2TI6O3mcFXwx2eBg=;
	b=ISvoyXok3x0PRJomV8PcAOlxH76zK5t/2R3B2CGYKkfapeDdatMqRnnBgPJESmsRpHd7
	 G1m5mn0JUWokVfg/OdduxwOSDWQekXOM9xMt1kWQv4CV1sJBneaIjQ2wQi5aw3M9zAjnA
	 W+zAoaBfF+JuSSgnnL9YZEEMgoFjjL9ZI5ixtxvSHj/N55EsxAhg6sl3OyXCOQ3NKigip
	 xekJHc066hjUY179g2Ihk+HmEA8eq4HHwbhwGkErOVsfd0ht8icj+ZQwFWyStvOv4E8Zg
	 Z5qobXDADEFvFxWrZwUt8ivohvBiEZQoYjm5R6W6TycDdRfClUCVYvBVNiRyta0EWdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eq2xx9ZW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767C606A339
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eq2xx9ZW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE5A1F000C4;
	Mon, 16 Nov 2026 19:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855906;
	bh=DhDRC0RZ9+n7vvF7WkuaW6oJu+R2TI6O3mcFXwx2eBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eq2xx9ZWbm4J9VgRUW0tWSO1eDK5brAG/E4rM9rFpzvb+GxUecc36VawFFAiaXn1a
	 fWmlO8wuyhoNocEbjdknqMn/U4kMZbVXcjX2M53r2i70z4V9GGiYMKvQwlqjsVkOk7
	 Zpv3bcbhugcWe1XRtYo9fPVHnIITDC4j83iOnZ2KmG2WA0uqeP+9nGfl6gjMSVQKnA
	 vCADVdOnZMi0BKV/U83nL1Sd1zsgElmzCIMgWEzWtuhi7F4JX3U4D47HrURAOPu5PG
	 N1GfmkPISNkyPfQJi2qtTKanOYOfhkfrHZBKkRjMJ1xSfpcldNVu+A3t5fdwWoCxV3
	 OI72k+Wj0YjeA==
Message-ID: <sashiko-outbox-217528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/15] mm/hugetlb: account temporary folios
 separately
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-4-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-4-4dd9e94ea9ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:05:05 +0000
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
> Fixes: ab5ac90aecf5 ("mm, hugetlb: do not rely on overcommit limit during=
 migration")
> Cc: stable@kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D4

