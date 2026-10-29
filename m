Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304988;
	b=MG1UM/0yPNiI/LLjg4B91YK1kvb65ekSWkrB513jDVTPMaB/yHp5B7wve7z+csl0nfFl
	 vQGv0Maqbt57eP6G5tAObuac+djPpcepJlmKAppeC/QkG+9ouDmtVvz5Wh3pb6MBcVETw
	 ZCDO9KE+kFjxn/BTllfNDm/52RANcl8JA6HB4O8B+EBEVO8xp7E/+50iKW/85feRL79jK
	 97dANJhq/bZ5f+rTNwDzgVe6HVBpexnryYSk+sd2F9EZBIRrMTozjQmV5obp0nKwE67oY
	 V9Ssqm/PYRnGuUGG2GJq172UX7DJKo2S1PDSQVhLGJkIwo1myLflLHnlu6JS1ZNZtwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304988;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UB3T+oYs4kvmKklIWXxvHFrG6X+jKzefieYwvazFcQM=;
	b=XPdw8QOQ4wmoxtmTxO1b21dxYsSVCVZV2Gti9m8a2pEucyfQkjSjn00jVkFTqicT+XJ5
	 fohAlYvP8y4qO1o+q06EF6rHdkRW9cdlGsNGBNGtcQb4AqKdc+aNn76+pljONgXD3SgbN
	 pYidJWZD1hYKM4EnmGvDzT/r7Dyh6z4cZ1zo9iiOoNvvjv7CUsetW47TYlz8SKBK0Pv/P
	 NRJTBlKnjHN6BjhJBuuWFO3NHpDDkOMLSqlJCV10vJoxtkqnGxP1xyP91Kyb9+OJJ3/W5
	 VZU/ylGmf7oO8TKN8+A6BqqzQIpraODSerD5P7+/L0GivI3bpXa7ohfc9AQSSRwcq2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1+1VKKf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B7606A31A
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1+1VKKf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD191F01816;
	Thu, 29 Oct 2026 20:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304987;
	bh=UB3T+oYs4kvmKklIWXxvHFrG6X+jKzefieYwvazFcQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V1+1VKKfV4pf/eJ5BiTuWIJvMSStuUThCEQQWr1WPrsR9/g5V+gJVdXgMY0zjLqNB
	 6jHVSEg+D05YpI0UMqL0XedFNl4vQzEOf7XLNnvjIk2VenOwFTp5+Ktc54EBbVDnXg
	 lwXCB13vC2Eo+Qme/JZTBCk3ojiINpwJzu5jafLHuzXxZp8aZOxQqM0GH9k8HiWsrQ
	 O4wieRUTn+YMxAZqQ0O6NMl5RRB+v21ET3L4zLETu5E3qFPHK9+IEMc02n3g+CCEar
	 Mip5g+5kWgFBakt2p/WMZcJfXx4wCtjxhAdG4TwPAfhBOPx5cBeauvnXOWz2Nm7Keh
	 EvlarEJBO6nvQ==
Message-ID: <sashiko-outbox-189901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/15] hugetlbfs: fix integer overflow in fallocate()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:16:26 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> hugetlbfs_fallocate() rounds the range end up by adding hpage_size - 1
> to offset + len. vfs_fallocate()'s existing overflow check only makes
> sure that offset + len does not overflow.
>=20
> Once we overflow for valid endpoints near LLONG_MAX, we can get a
> negative temporary result that is then converted to a very large
> huge page index.
>=20
> A one-byte allocation ending at LLONG_MAX can therefore consume all
> available huge pages. Pages added beyond LLONG_MAX are skipped during
> inode eviction, leaking them and triggering the BUG_ON() in clear_inode().
>=20
> To fix it, calculate the end index in a simpler way that cannot
> overflow. This also fixes the signed overflow reported by luojiajun in
> 2019.
>=20
> Backporting notes: without commit a08c7193e4f18 ("mm/filemap: remove
> hugetlb special casing in filemap.c"), remove_inode_hugepages() must
> include the final huge page during truncate and eviction.
>=20
> Reported-by: luojiajun <luojiajun3@huawei.com>
> Closes: https://lore.kernel.org/all/1554775226-67213-1-git-send-email-luo=
jiajun3@huawei.com/
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: 70c3547e36f5 ("hugetlbfs: add hugetlbfs_fallocate()")
> Cc: stable@kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-fixes_huge=
tlb-v1-0-a0a033db180f@kernel.org?part=3D1

