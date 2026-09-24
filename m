Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2C23AE190
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230932; cv=none; b=WNmfOyaZwp5zXrjr3LVsGwD5CYbYhSF3rfJ7xs4ZCLzN9GSLtQVD5mwPzCcdIyfD4QLp6lhB6S2ez6+UtvhF7lq7uCX8j44/QBPVi5NuA/VZVN3taodNbRmP8T61X4BtSfAbOZ23M+R1uXbYfPcDAvAWdo/0p1Ht9YBOEBVCCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230932; c=relaxed/simple;
	bh=LY5czBaAp7NEZeUTDhEFrZM+RMhcPbsKazv8Ub3o8MM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j5geYxjDxRbd3WZgtIJUEYczWpGAvI2RJScaIuLFyg/wpPVdhG1dxUL2KgXYoYt7PGpxhTbIM7myRmCtzbmvsd6PD665CSD4/trlcqvqzA2lH6HEJl4vhmfKKqGHTGA3ziLdl6ghXmEKHV6pkAFMVB8KJ0Nda83fdjz8pDRhqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRu6s8ML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRu6s8ML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B231F000FF;
	Thu, 24 Sep 2026 06:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230930;
	bh=LY5czBaAp7NEZeUTDhEFrZM+RMhcPbsKazv8Ub3o8MM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CRu6s8MLdQ5wPRz6rdl6SaZ3INJNLUQ1/igqTzi5CF9ihU7uZ2q3X35+prh8fb5Ga
	 XJKZAx5MxdTUigZhndMw9irrWDpfVGFGxQw3Wfsz+W5NAxpPv1sQKvzFk1GFJDUahU
	 /7riOeFjsWWXLrCuBkPm7mwDBWPtT5jpyJZ2lIlEU5bQ8Ch0K7neIHVMGuWKusoER4
	 LHdSTxkZ2DLR3ZiBawMnUxco/PPLEy/Evt7LSFgH/QXLjrpazccMUtSA+/CsMQQfCt
	 anUlwq+4ZO78/096dmTIiOPbou4DzQVm8/lYYArLXPNz7mlIFjE6lk3lQPkKpPoeVg
	 NHrt1usWhQnWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/8] dma: swiotlb: Centralize default pool policy
 selection
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260924060756.1325156-5-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-5-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:22:09 +0000
Message-Id: <20260924062210.45B231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The addressing_limited argument to swiotlb_init() describes only one
> reason for allocating a default SWIOTLB pool. A pool may also be needed
> for memory encryption, unaligned kmalloc bouncing, or swiotlb=3Dforce.
>=20
> Replace the boolean argument with the SWIOTLB_INIT_ADDRESSING_LIMIT flag
> and have architectures report their DMA addressing constraints through
> the initialization flags.
>=20
> Introduce SWIOTLB pool policies and select the policy in the core before
> allocating the default pool. This separates the decision to allocate a
> pool from the policy used to size it, allowing subsequent changes to
> centralize minimal and confidential-guest sizing.
>=20
> Set the shared-pool state before memory attributes are updated. Also move
> the pseries secure-guest setup before swiotlb_init() so its initialization
> [ ... ]
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924060756.1325=
156-1-aneesh.kumar@kernel.org?part=3D4

