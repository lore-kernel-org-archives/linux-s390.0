Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855906;
	b=32vzgENjY110ojhMQ43MJ9DKJn+1hpdRhVPT+eoSD68vF7BRAkoZzt4xqfUtDVDGEBZA
	 PWBphDDTOuHXekslkafi6ozwvUW2qHPqFGnzKO39t9oh+3HDDZ/qnsKCinya6ZxQ4pSNx
	 sO+0/jrVGOH+b77hVqTdHUqOYX7cZN51BpmXBRBw38gNRXRpLNgp8xWZRZtBeupXh+QtB
	 8jJFg1ps2PW6KYeFZKadFKlPSZVIy92qGkPg+Kpan/0z3uaJcQO7Czkgng39vupFHox0r
	 TP1TcVQGvKM8Bg38jTzR6zQWLDiyqm+/uHipOQG5M6Oilzt1mSZT5bs6Ka1fwP71xVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855906;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GV1HLx7ZljATGImXTwWiJPhBNmA5UUZz8fR1l5KDsEE=;
	b=iiHvVLdSTe28MYOKrNdm4b3C/EqnLxH2quF63bw/fT6po7Hdkps1eI/SVz5DGFTv6ncK
	 hiWFQ2FlkEiG6nHgelsyGa2coZTEo1tlYk4u/fG26ynKHwkjZqRi/Ru7SqoHcflLFCBXQ
	 2VzgRom139UzME3TECka0LUzluYp2W595GIbN4ZeZdKLsliIVkCFEcgJc+Pf2b5E9wlxH
	 LXqmcQ1qdK8DKaK4/i1WqTDHycubpUigHcVh3dvsFdg+uD1q5/M6aiZeGlb23QaWOimZW
	 a8wRSbdzGDYgU8g8JnoNlcGxqFikZ7f6vg8ftIlCHNmkphNu9v/cWQwsj+hsyvEvp1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ham1kzdo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA8606A32A
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ham1kzdo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC8E1F000C4;
	Mon, 16 Nov 2026 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855905;
	bh=GV1HLx7ZljATGImXTwWiJPhBNmA5UUZz8fR1l5KDsEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ham1kzdop4yfecsGQIephvFXgCpPIFecwp24jg4LIoPzUZVw0OZKFCvYeyz9dvCO0
	 ZNdIet90Nv1hpAd68LLcFzyP/FGOsaSbq2tDxzy1uwsV23gS5GRPPmTeMmLrTG9e+S
	 kR2YZ/hiTrTy3EUj5Nnt9ywHxrkLlbIi875WAmUrqQEpk8VZ9ccWEo6/4nxZY3fa9C
	 3nEkuYYc0w5yhPXxbNV8cjqGaQeTlA1j/kF2t6p0CxB7QCPBHhdS7Amufs8ewh/Xci
	 /ui2Ldbuu5zgMYRjSbT2ZL2/RhfN4dklW5LKcGBbeLsVFoci3a2hEj11gL/80aoHfm
	 D0RehsW1VVIVA==
Message-ID: <sashiko-outbox-217527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/15] mm/hugetlb: preserve reservations when
 shrinking on HIGHMEM
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-3-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-3-4dd9e94ea9ac@kernel.org>
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

> try_to_free_low() drops the hugetlb_lock while freeing lowmem folios.
> set_max_huge_pages() then resumes freeing folios using the
> min_count computed before that unlock. Reservations created in between
> can consequently lose their backing.
>=20
> Collect lowmem folios on the caller's existing page_list instead. Keep
> the hugetlb_lock held through both selection passes, and free the combined
> list at the caller's existing unlock point.
>=20
> Likely not stable-worthy.
>=20
> Fixes: 1121828a0c21 ("hugetlb: call update_and_free_page without hugetlb_=
lock")
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D3

