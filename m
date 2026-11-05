Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863011;
	b=s5NkSiCY2iGCVV0n1BmATBmIJSLdPo4pr/JHbWVee5ApgaxhLRWGvjvnniz8S+uYHprU
	 1fARhyrW9R5DxCcZn4pR/GAkuIOTX1hlcpy9m40PviTiYDu8lflwm7aVtceJSzm+h8/D3
	 kwXwVpwo9RSqUNVSLsPFtlryHH/gygM6Rg9EK/cFTdfF64uP3zVVdN+McRTC9M3PS3HGm
	 F7VNQcRUIScMxsMzc997gekMXyDjQ/M7kjHSNscT7BIoHynFgCjlcqzpbHPpInhoOMQ3h
	 j097cAQojtsdGBqYHi8AlKpfyYRkVJZgCZ99XroCzH22rkDTUNKi1kyrFuHdOv1iJXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863011;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G21Lli93x8mrSkOFxBAc6fdSpFHvBC6pIp6Bi/pAWsQ=;
	b=qcnM9gGWRImhIIhnU4LclFLOYBxmA8r6hzrZeodJDsmBdJgw5n0hjXBaa/+eSTIZRvWg
	 1XpH1Mouo6g3ZMZnMtUiB55GhAesrap3FFwpH1hpRr8rvJd3XFZ6PXdYIfXIDB6/2BTNJ
	 1CLszNy6NwoqmqMg337qqVrD2/KfTYBLmo5mTFiyepWj1OPRl/2kxq6mhGwAfBTrKhICL
	 Y2HDqlUvn/U+RUUVQBRAd8A2qXt6Qytv2hGI4OE5JpYqIi7wUjkWQsnjNGW1bETixv6K0
	 iVuohaPT98rxZ8yfuBKjl+TOT+cuDV/8gA6glZYICdajPDvWrXHeHU/gKns5j/kJyIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRDfUM40;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED809606A328
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRDfUM40
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813471F000C1;
	Thu,  5 Nov 2026 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863010;
	bh=G21Lli93x8mrSkOFxBAc6fdSpFHvBC6pIp6Bi/pAWsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRDfUM40mP+MA3vbQUucldXOMJ2eSC/mZuBgzNvlK7I6N+bB4RMcDMqrmuccdNcfs
	 cbaTeSKlQ/+FzgPDSkocpSmLEFte5MSwmf/avn4hQ8MbXIo1vrO+vqaF3yakqAnzKI
	 09TvvsSKl4eTlEO6LXYm5ZB6DPlPbQhKdTv5opUkt+xwBokQoalbCSGpq04zNpVyLY
	 b9IKiUUjV38egHNkfuKNqB3VFsY5y+z0bqRUJI8HmhAl0TXaowpD4wCEMlYkMVz83y
	 AfFQdEazFdlmx8pC/zenlRIFVTTByBGcUi3+iodXe5cNGSzaerX0ghJlna1h0VZmWI
	 RA+t183IUQnfw==
Message-ID: <sashiko-outbox-198653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] loongarch/mm: disable device DAX vmemmap
 optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muchun Song" <songmuchun@bytedance.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105061217.13302-4-songmuchun@bytedance.com>
References: <20261105061217.13302-1-songmuchun@bytedance.com>
 <20261105061217.13302-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:16:50 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> LoongArch selects ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP but not
> ARCH_WANT_OPTIMIZE_DAX_VMEMMAP. Its vmemmap_free() implementation is also
> empty, so it cannot tear down optimized Device DAX mappings.
>=20
> A later change removes the generic Device DAX architecture gate and lets
> vmemmap_populate() decide whether a section can use optimization. Clear t=
he
> section compound order in the LoongArch path so Device DAX keeps using
> unoptimized mappings.
>=20
> This does not affect HugeTLB HVO: LoongArch does not support gigantic
> pages, so HugeTLB does not use section-based vmemmap optimization there.
>=20
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105061217.1330=
2-1-songmuchun@bytedance.com?part=3D3

