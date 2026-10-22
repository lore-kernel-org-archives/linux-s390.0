Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669719;
	b=q2oQTpeAiigv1ooBfnOgxOBuWPOlfNCvZtBqgbVlb278Hyipp9QPXbZztvXsj8QGHZ1q
	 Ygwn2SF+gC3ku5UAsmHMJWhjRWPPG+xTzjTnvkPBtOoFOCcmK3Q7XEt9oMOapb3zhomms
	 0rEzWsyBBFkvebbz+gBykv0DVAFSSb+0nw1nsLNU8/0fnGpgjK0Oej30wRny6GdlOvCRi
	 KRiVsLcOAEp+CzTB/rfKk73XdLfT4v19t3YkrBmTzOXEvanl+EdHbyLjbCRRI0y8zLP1r
	 DE/FH+9pdUOFgCQ7Jez60Jm0v3pE6Vah8uMvCVzDxjIAZc8O32lV+NrgWGLniSQgw+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669719;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eJNKescZXBo26KhwrkWxVPC43w5UAxNrIjM2H32oCv4=;
	b=g2CxgoOTLdBF3b9ZkZQFk4rBTPuiQD4TKWfOpUgwGFr24FrchAZeQyjrnzYFNCm1cQW4
	 +N8ZFP5dhxboOTFa23hzKB8mpngRHcTglhjd4TA+5lR0RQXerkvf7RK0kCfliOONsmed3
	 PArWYEEUrUSnoMeH1AnJaVX03jHIKrCoxBLej0K9TBqUJ3iKdleekX6pcbahgrw2DWmeH
	 CBouzR4G/SF2wZbNqdSGoSpWQHGohDISR82B7FjIwLxmd4ur6xa8bf3YE3z4DEFGwkxuM
	 u9zLJIzrVgZJUssQz6VLiyMMdO09qOTObeBCk3ZEe7DG6Nw7iDuvlzbdyoKIjoOQUqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSSfShkP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3270F606A31B
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSSfShkP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1161F000C1;
	Thu, 22 Oct 2026 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792669719;
	bh=eJNKescZXBo26KhwrkWxVPC43w5UAxNrIjM2H32oCv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kSSfShkPrDhhIjP8DonOKDn1TJmrkH3CBnAF/xkP/i1Ln9qsyD2ndkATlvDjKqCxY
	 8s2Ghv1qyDO8rkwNSkGsOtWzGLsimtIkoQB3gSd/sKcQ/KnvIe5RB+3Ba1TDJxQXq/
	 ntmnJtfgJGeVDP7xo4Qc8Ll036a0rU2CZZJXg+J/NRelVVnMNR3/v98vgBKnTkHOHE
	 i4GYv22glWMdrmGIZnAx8AsrFaTCxUtHviDX13YeaCC5SkCZLHklF11Y/1UD6z4gCC
	 iik35EMQqKvIV8GrOIin+k/7MlR8czYBCfLEIy7s1TSGKbZcKTsovWH51ZksYE4FrA
	 v0aalxK6DNCLw==
Message-ID: <sashiko-outbox-181390@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH slab/for-next 09/14] iommu: specify SLAB_MAY_ACCOUNT for
 slab-backed page table caches
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChNZXRhKQ==?= <harry@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-9-096800aa3330@kernel.org>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
 <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-9-096800aa3330@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 11:48:38 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> vfio, iommufd and vhost-vdpa call iommu_map() with GFP_KERNEL_ACCOUNT
> and the gfp is passed down to the drivers' page table allocations.
> Specify SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
> __GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.
>=20
> Paths:
>   VFIO_IOMMU_MAP_DMA -> iommu_map(GFP_KERNEL_ACCOUNT)
>     -> s390_iommu_map_pages() -> dma_walk_cpu_trans()
>     -> kmem_cache_alloc(dma_{region,page}_table_cache)
>   iommu_map(GFP_KERNEL_ACCOUNT) -> arm_v7s_map_pages()
>     -> __arm_v7s_alloc_table() -> kmem_cache_zalloc(data->l2_tables)
>   iommu_map(GFP_KERNEL_ACCOUNT) -> sun50i_iommu_map()
>     -> sun50i_dte_get_page_table() -> kmem_cache_zalloc(iommu->pt_pool)
>=20
> Assisted-by: LLM
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Chen-Yu Tsai <wens@kernel.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux.dev
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sunxi@lists.linux.dev
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-memalloc-p=
rof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org?part=3D9

