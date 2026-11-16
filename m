Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855908;
	b=FpWzVKpY52uXUuPfunh4tdGSCdTsu+zuq/jpheAg/PyJciaqx9cYzWB8s6E8PwdMbUDL
	 TOmohuhab8sZa1rJVX03czMuhPlij9RHpT7gHae024mfxWCjMkf+n1otlW5nFd7qoGv0o
	 cHTDplX31Lx8RV0xf1g743DYNHfrhi6i91N7pGRylHusdTDygpMD3u38P/sDsnIElX9pz
	 EYQDSJacLyYoQKv/cpQKohTI7Tz7yh5eVKnVIQ1dxmvfohee0EHAfd4DCXXlitbCNRptn
	 /KTO6XGOE6u8mijRAYpjDr8X7xldstav5BcC/cx/+Pj+L87O7gjRzXLVxTymV/Y8zUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855908;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=etsNdCtYox+XdHGXsjW7R40I11WDtmltl2JmB6I0bA8=;
	b=nkWWePWmB+MYFBb92DP5eBRazT7GOZeKmLOVIPfgD6nTVYJVxzkuVu2csIMwFpKX2eK2
	 Hytbcc7oa+c4dyjDegdX/uqCHz9LjQkWEhTcHMvSEEpuEzNuuw+eh6k73OUgrlWxUIcIz
	 EeSXs33AFLhU5YpPAG9EQ4BRI4coIVIKKQnixghHRkVyshCkjGdg6oBYPMxlaAxlSbtrS
	 sf6wPuypf1Z/FeI6XBqVjJmTpQsMgRny8RECEDe0ZhMBx4ImGma2dhTXKhjKoIIARRwpE
	 zabBGotRSRGdjkEiJOUleOgQ3VCdZvFDuHOktG96GIdMdMrC0k5ZuPuilR1R2lQB4zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCJt69pU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E45606A32C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCJt69pU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0F81F000C4;
	Mon, 16 Nov 2026 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855908;
	bh=etsNdCtYox+XdHGXsjW7R40I11WDtmltl2JmB6I0bA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OCJt69pUo4qVKY7bOlxdqzjToIKQNuAFSL4DaHph0IZSEErYE1KHtPAtxmxwIuUaO
	 XUHFVb/kg4R0FPJH6VAz/Dvd55lj64hcUwdR+BQBaEe/WS98ju7po6/yooTHOGtuUg
	 gLEF/ntMYViOlrk8NzTT3oHNvnj7+2skNxiu2yOyDFTxmlAkxzg8+n6Gir/P3PrJ6q
	 IFwQb+d4bnY+VlDBlPqJfm0Sn0fqdWE6a/UJbtVB4aKEhpeEaMBKf+gPgzeq+kGmjZ
	 koCARILQGRF87d9F+XbDsKBlp49/794PpIcyCQRT5G8bACc7jPGEDAjy4yhbV/toIj
	 Yu9FlV5+lokfQ==
Message-ID: <sashiko-outbox-217530@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/15] mm/hugetlb: fix mremap() racing with page
 migration
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-6-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-6-4dd9e94ea9ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:05:07 +0000
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
> Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage ba=
cked vma")
> Cc: stable@kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D6

