Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304995;
	b=FJdPj2+JEzHcy3liGz6XED7heO0ugZTxR+1kMZHjhQf5JxKIjxRRu3HA0WxPm87oVqEV
	 3iGEtqaWnAHNHnnYpoCPeg8rvYlW55dMPEVpK2ZtgX4KAM9U5OtmPtz7RcBlbjzTyGoBo
	 OYkUbdCxH+Nz9OtL3yl45QTHehMqpkwJ2A7ccbIHfr31oZdMXncAH+0PV3vBVUu0fQUcI
	 o+pvXcY+17XhRU0+7cy0Teb+xOQR2W9BGqXWdoHpge7OUCn6O45dGUU9fGwMMldsh1JIc
	 wO0lnZ3pgRLAPrOIJxFxWbSXqbPb51d06W42+lIOUNPAKRvaSx+kfo7aRtxQzvbL9PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304995;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ah4JjrQycs1bw45yuQ/dWmsH5WNsfeYvc+1NeFZnlx0=;
	b=smi0T/BsFf82XnOogChoj1qlResgJOyhoz5FGdjIqFJoeSPyrUCMt4wYoogialR02u36
	 vFjj53x7jEwlbNqTNRocEPWj4D2F2gkN2haj3F6IRBktplrS9s0QkwLNW4jD2bfDGyrO4
	 /9sqAGkEvomKld91TMeCokyZQG4fSzzemJlzy7QXDPN9Kvo9jHR4c19WlQh8AG9NXrstq
	 Y9qJrojsVqXLDQfTtNwvrcSPzw66tkohbwYAe1oPDWeDqokU96eIWVjCgT9NGE1NYLrmi
	 zYFjv65X+aV+Ua5W88JIejqG37mkSCG2EOXzwXpDBcFF/vGUHHUAakOSqUNkxZfY/rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k49be2/V";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA300606A31A
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k49be2/V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C751F01824;
	Thu, 29 Oct 2026 20:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304994;
	bh=Ah4JjrQycs1bw45yuQ/dWmsH5WNsfeYvc+1NeFZnlx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k49be2/VGEnvlmlijV4CS6FuwNh8ygBPdiohgfBLzRtUJfRG4XohbiuMEqsVSjnC+
	 rIh2Phd/9DAo77hINs9lzovAWrjKv26evhx4/ZX2DKAbCA4V0JrmEMQ9k+vyTnJQHG
	 83dFtCwBTKV3W1w2MwHZh9Y02un5AiBUsvkUZSDfeEQRSplmCRjIbOQ7CVM109PxgV
	 HtzqjmzUVigJHAvt1m0b1C9KsA38rwllfhEynFbIgp6+azZjA0x+llneppcGTKbwyb
	 JkZ7OWCG+dZwSbkq3+y3QflOmOTQChJ75L98yxxy0b2X+58/ZrDrscY1oojrqQe+i6
	 SH00/drNjHaEA==
Message-ID: <sashiko-outbox-189910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/15] mm/hugetlb: count again if the reserve map shrank
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-10-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-10-a0a033db180f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:16:33 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-fixes_huge=
tlb-v1-0-a0a033db180f@kernel.org?part=3D10

