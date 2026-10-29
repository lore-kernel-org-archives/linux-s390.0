Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304991;
	b=ZwMJ5MDM8Qx47aHWBvGCbidbwWPT9YRSYbv6CQV2u7FZCyS3Bz2/M0BsGPLiJ6SwAiNq
	 Pa7dZBaiybYEfJaT7+RNG0ivct2HdapL4roEdvBUaZYrJ1TjfxAXbCydVQKYrXSPSq5d0
	 72ofTPEjzZv7nru4mO0ZyPaT0VlBwDfJD80YDWBfZNu7Mro/gc1bWEn4wGRfoSyoxYJjR
	 SqqMBG7EX0masqhlLP8bGju+xE1K3nMnuBciCS5zPY/z2MkJvkXi5ZTB/fIa6mn1lLGFI
	 knlXRJSReNFhL6L+t/ap71Bz2yDmfmxypU+fJxkCDTr5IQyeOCL5PfUsX/cJ7+XnZKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304991;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P5KmbTIcunc+hY+AWIDMTftm6i43a2ZOTDQbcyUxcvY=;
	b=g/S/Yx3otdcM7RkkwC9s3wLVZKdU/AQ58Bx4hd6C7mzxxJRxafVE/DH0TkOZHrCsMJ4m
	 Kk3MmNa7z02Vu2MQ+SN25mieh4TXMpe8ltV4AON7bxYsCsbq9H9VbWMt2xYrlpOwWtZsU
	 dKZ4sGKb7RFKZzcseNLBOdwIJrKI3m24TVxNtyZKr0tTTZgIH3PIwDPfgtJYT1wN1m5w+
	 Ah8byYqZTXN0yFchFy9gjgQyfa3U5ShhRvGCwB0KvEAQlmc13GozJ56itASaxe5c2+CHw
	 blJkV3jd38e8mgGR8ozHLJBcOohfAzRt7kZTxVd/kzVeEoQk+NrwrjAbTQky6ByCnJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZUwTFlI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A6606A321
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZUwTFlI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759D51F01816;
	Thu, 29 Oct 2026 20:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304990;
	bh=P5KmbTIcunc+hY+AWIDMTftm6i43a2ZOTDQbcyUxcvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZUwTFlIYHbH0nLYE6+q0yIbH0M3ZYEr/825IcDku1+0CuLxgVUo/BvfMVMCmnhFI
	 FcZT3+osLxD22MW9/NDUq/q3hMi5qLbnzu7imRBbv1B/2G5k+P7dVb4reJIko0lOw+
	 TNPldM41ig1GRuSAJdLOZoebfvmI1Vli+ZOObqLa4U3AK6xaEvYF+8DGrAiv7cLKvR
	 EVW6Sv6TglsFNO79pKMPSIHbvx4cGyEOVaHElZFWr4iAv7/QvQvINaxdwh42JwulST
	 pB86js+w5ch/qDdNEjDbyAVW40NVoSjOb1Ko9k8QBVa/r567JmJEQbhVNW7emhw7Yj
	 Ll7lsx+M2PjGA==
Message-ID: <sashiko-outbox-189905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/15] mm/hugetlb: keep surplus folios when the pool
 shrinks
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-5-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-5-a0a033db180f@kernel.org>
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
> Fixes: e4e574b767ba ("hugetlb: Try to grow hugetlb pool for MAP_SHARED ma=
ppings")
> Cc: stable@kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: cleanup code and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-fixes_huge=
tlb-v1-0-a0a033db180f@kernel.org?part=3D5

