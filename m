Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7A55293C
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092238; cv=none; b=PcbAw/wLEsj0ibdBRSdJyjosG+6Kj9a21IEXeh00u4MLWYYCIauDIkbkZ+8XoiMVJSxc2VW7LsrH7VFIjhglnH4zvm/2q0LuXWFAi5R0kndfZnkz2bPDB9bZCmNxxxeJjfvwEk1fbn2a6Ry0WF0+0DoyikZhq8zBSnQdJZP9fXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092238; c=relaxed/simple;
	bh=fg3VziuPC6jgeYKcyVdQTLwuBTWrIHho1sQj8dtZbLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=svVyBXUDpDJQKKqdVmlxjTvYpFKYYJB9I9IWt8GNttFDMGiEYrdEDZld+d5Vg2SafWtkXNeHLkDnyvnxpUPoFZYEDnzVymfcJ+tpcTPq4YcHWjFXSGqVYS90IF+OzjsjvEn/P8F+wqfGRjuxcWGhq+W74cK2GIBm1xUzWTQnQZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqiuO7ZI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqiuO7ZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EBB1F000FF;
	Tue, 22 Sep 2026 15:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092237;
	bh=fg3VziuPC6jgeYKcyVdQTLwuBTWrIHho1sQj8dtZbLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WqiuO7ZI3jNOhnuIvQKUOETHzfko8YJ6LOzTCnk49Oqq47Nmqk/OgIs91dBhx75nW
	 qXccXg3U3pC0WYy9czKsAyr1x7QR7YLc9YAvVuqIrehWCu2c6nTTV8lqztht16Tj+F
	 ZE4mgckPbqWwZ4eWrrvQ9gP/NQf3C6GvIEgsaxSxlVcBCTikZb3MaVlm+59qyUQUD/
	 dOxHWAiIE22HDv9Dt5ZOQ28g6cKdAHG0BStzQ1bSo0fMMnL9/b2rQTnpuO94WtZuUs
	 BhHtIgboVES/UgUYiaTakaJJHLDSRQUrxS4QYluvs+gAgZb+do899vkzXVXlSs9niI
	 gNE3Gl0Q5rkvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 arm
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-4-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-4-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:50:36 +0000
Message-Id: <20260922155036.C3EBB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit a0ad5496b2b3 ("arm: mm: enable HAVE_RCU_TABLE_FREE logic") enabled
> CONFIG_MMU_GATHER_RCU_TABLE_FREE (then named HAVE_RCU_TABLE_FREE) for SMP
> arm architectures with LPAE enabled.
>=20
> Regardless of whether CONFIG_ARM_LPAE is enabled or not, the same page
> table freeing functions __pte_free_tlb() and __pmd_free_tlb() are used.
>=20
> Non-LPAE PMD page tables are folded into the PGD and freed by
> pgd_free() (PGD freeing is not part of mmu_gather page table freeing in a=
ny
> case), so this is a noop in this case.
>=20
> Since commit 358d1c39c82a ("arm: convert various functions to use ptdescs=
")
> both LPAE and non-LPAE PTE page table freeing uses tlb_remove_ptdesc().
>=20
> Thus all page table freeing is performed under RCU with
> [ ... ]
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rcu-pageta=
ble-freeing-v4-0-fe1ad1f1e303@kernel.org?part=3D4

