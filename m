Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD1408617
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966990; cv=none; b=PKyw3STs3sN0f/lg/95Rb+fzkYTqBYfsiOIwR6/FSudvZrLpxSWfNpkqCJDlfNBnddmsgNYQ3tvrvyloyrbCIT8FXVbM843EgcYSZZc9EN/KeQ4UUUhiC6WIPB2Rek3ChCxUpWQdacR+/rf+TNw6Xxv/mqA+hXsqGyqC1jgfZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966990; c=relaxed/simple;
	bh=2s5NKSr1lSe9dGQxxzFtRAQ7KkJnBrkKLBI64QALjHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S/9l73JM4JsQzCq6A6AfuNa7YkQDjIFkzHUvubmu+w7ofOPKGYSbQyBXA0Gyv8y3emdqHPfsp0pyfScXfWnAosPCR/itlbEK1ILSo0znIYMvXYYxrVgPmFt09dBJfbiY/M/jgnV0+lhFcGDftrNRMExOMUHawIYTjWBFQ6iqYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDpKb/2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDpKb/2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8061F000E9;
	Mon, 17 Aug 2026 11:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786966988;
	bh=1mAlVnzQu4fc3OoGdkV9DuOyJ4nTTnWXa5yl+mA1i4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nDpKb/2/Gfm1sZJoI7RubthTT0+xsF93nyLL+CNnut7dtpc/CrJXzHlX+gGabNbMA
	 a27FB/8EeLAIxRpLOPr8du5VGOSECN5OqjLjoNceJi0jLBCdgGyCQqAkmviXk8s6Kh
	 0T6qccqetGFGDaXLzgKX4om8sNKTKD7gzarJn8IUI7TZmsQZqrC5TH6SNckwwwh4aj
	 ZHsBKGsz/dgoenUEmpXXovfHXInAepUjtj4Lqcye3/BLN5MCK9iIjmLlvrc+AJTXun
	 VkifKKlC+WK2PkxuyQK7JKIbkp9Koh/MqE0eOyJyoMDrLl6sR3XjnDl7PZoY1+T4ZD
	 FvpjDVqwcTqMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] mm/kasan: Introduce helpers for lazy MMU mode
 sanitizer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <52c9be0cf71a8896a5d76c148c38fb24a2005dd9.1786956464.git.agordeev@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <52c9be0cf71a8896a5d76c148c38fb24a2005dd9.1786956464.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 11:43:07 +0000
Message-Id: <20260817114308.1C8061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using KASAN to catch direct PTE accesses during per-CPU lazy MMU=
 mode will cause false positive BUG reports on valid concurrent accesses fr=
om other CPUs.
--

--- Patch [3]: [PATCH v7 3/4] mm/kasan: Introduce helpers for lazy MMU mode=
 sanitizer ---
commit 934c56df440d17dce73b955e4a04d2ffc114ef49
Author: Alexander Gordeev <agordeev@linux.ibm.com>

mm/kasan: Introduce helpers for lazy MMU mode sanitizer

This commit introduces helpers to allow architectures to use KASAN to catch
illegitimate direct PTE accesses while lazy MMU mode is enabled.

> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index b7d05c2a6d93d..94d1060949891 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c

[ ... ]

> @@ -163,6 +163,20 @@ void __kasan_poison_slab(struct slab *slab)
>  		     KASAN_SLAB_REDZONE, false);
>  }
> =20
> +void __kasan_poison_pte(pte_t *pte, int nr)
> +{
> +	if (IS_ALIGNED(sizeof(*pte), KASAN_GRANULE_SIZE))
> +		kasan_poison(pte, sizeof(*pte) * nr, KASAN_LAZY_MMU_PTE, false);
> +}

[Severity: Medium]
If this helper poisons the PTE in the global KASAN shadow memory, will it
cause false positive KASAN splats for valid concurrent lockless readers?

For example, if another CPU performs a lockless page table walk like
GUP-fast and executes ptep_get(), the instrumented READ_ONCE(*ptep) would
trigger a lazy-mmu-pte-access report because the shadow memory was poisoned
by the per-CPU lazy MMU mode.

Does this API design conflict with shared page tables?

> +EXPORT_SYMBOL_GPL(__kasan_poison_pte);
> +
> +void __kasan_unpoison_pte(pte_t *pte, int nr)
> +{
> +	if (IS_ALIGNED(sizeof(*pte), KASAN_GRANULE_SIZE))
> +		kasan_unpoison(pte, sizeof(*pte) * nr, false);
> +}
> +EXPORT_SYMBOL_GPL(__kasan_unpoison_pte);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786956464.gi=
t.agordeev@linux.ibm.com?part=3D3
