Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBFC583ABD
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156425; cv=none; b=DdVxs2tE97+GvVKxvcE33YLeUxcCERp0JAOHY3GFOt4MAUl+a/Y7YaQPB+oA1mwUA5sLgNlhb/IloVxiMVxt9EjtmSWgIGh195iUqqUHHz9OR9zwK4Jr18061PeURO6quBGlx0/1F3zvkB3AaCUD9b+wWeEdh2u6MOXFQ+pLkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156425; c=relaxed/simple;
	bh=I02Gs8KE/zOz51M/rWIkSRDN7+w9qUM34zyGH1prNSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hqdaaZPDEGcxBnYEfF0GNHNQVJfCYDFSt91pC6Nt8h1VWg5EopJHclP6NYTTdyvCJLbqyjF4cnkb04mNpPNWd75vbvOX6CL/jRgvj9pXe2krFyrmfmNRxbFiFS/cckieCtnJBzEPPCReTX4EcVFDklrfb+Eh4ZOSAkdxyzhnpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7MqFsWv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7MqFsWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ADE1F00898;
	Fri, 11 Sep 2026 19:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789156414;
	bh=I02Gs8KE/zOz51M/rWIkSRDN7+w9qUM34zyGH1prNSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T7MqFsWvviasD8IXb2wJbAh+IkkLNItFsuIfkbqgCn1dVphQzAz9tbH/0QQfOFrqK
	 SAQH2U0++ciV9GX90PYHanUH+qD1+iw9ZAooUADo7NQj4e9SF0C6vmBjGNz5gjVuh3
	 b2l5hSXIfEJowkMUUGI2+P+9oe+/jihkYD6rBRSF+6pItuQ9Tjyel4K1cdBYnZZb9w
	 Cou/LnuPXf/0ER3ZdWVjKueiWhv4LyMWU0QmMTwusE46G5rEcMwaugipqvITnkN8Fs
	 2GpmYGhwhm/jUe/0ZyA4UIbcgIN8i1siH3TuRuv+3BX4LDbCNXdZH63M+p6syVZGoP
	 DvePHGD/j/OCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 arm
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-4-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-4-7b8c86103821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:53:34 +0000
Message-Id: <20260911195334.87ADE1F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-rcu-pageta=
ble-freeing-v3-0-7b8c86103821@kernel.org?part=3D4

