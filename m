Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092047AF65
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039297; cv=none; b=cD+uKBgNmDsh4JylE7zgMEl0IYaoMbQioiHUQ4N2QRwSP1+5YzWnua4CpH52zMheFvu//QlB1bWGkQFY/JwU+x+6wTYdtJTyryRT6ggRAbiovcbG2O9NIAGDRO1M2+FLv7FsnbMXyX1DPl8mS9hlDEUMV4r6Lp8bcUXjO6gD5ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039297; c=relaxed/simple;
	bh=omCJ3FuGGSBWonLVq4aDuRGWgaUmEDTV9OQ7cHNgad4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J5O0wwQEm5t4cjbQMdA0ZGxwVzRs+fQttg+Bo0y6/zq+HA8EUQvDseDbvz4hLyiAV4oi9MjYiFsH5bDplt62y1/msNhNQBQL0hVqXS0jOrPjL+qAKp3UxPZ8NpY34jBZmZ7NCUGgas+Dq4RuCqE7HjC8iTJ32KMAyvorV9PVhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZspgHbs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZspgHbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743D41F000E9;
	Tue, 14 Jul 2026 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039295;
	bh=/keSP/pqwUYpSdZgOuHMbSl7I6F/eU8Xld9y+wzIX88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bZspgHbsB4ANHJv0xXe5XJeuueTt0vmjr7U3WTU4JTtu+UA/NWxDwORZJ09YgTzja
	 RNSbDykyJxsMtijEEP3wbS247q+nwxdEG1t1NNhGyolgX0rUc9HkgRLePdj6x5ye5S
	 8LQ4/VeU6rzurCzu28qJHJxP5NA/y4BUddZvTMmL6xnBozUayRTiuGvWR59wA6KLei
	 HiFe82WZNN4Hm5RqPer6ZxpJjBYeLHJr6GVOccjT+/DeqsbnqFxDsf/NQOUg0PwLua
	 W5ubU0MCPmSCYV7IFqgES6BogpKuQnq5SCFg2oRjpRwOc8HpuOv16FpKFrynukBXmq
	 LkJfmRryq+56Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/22] mm: use mm_is_kernel() in generic page table code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kevin Brodsky" <kevin.brodsky@arm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-4-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-4-44be8a7685d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 14:28:14 +0000
Message-Id: <20260714142815.743D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] apply_to_pte_range() routes all kernel MMs to pte_alloc_kernel_t=
rack(), which explicitly hardcodes &init_mm, leading to incorrect locking a=
nd mm attribution.
--

--- Patch [4]: [PATCH 04/22] mm: use mm_is_kernel() in generic page table c=
ode ---
commit 94fec0def7956a4362140e84c87769a3c5a046b2
Author: Kevin Brodsky <kevin.brodsky@arm.com>

mm: use mm_is_kernel() in generic page table code

Generic page-table allocation, constructor and walker code uses
init_mm comparisons to select kernel page table handling. Use
mm_is_kernel() instead so kernel-owned mm's can share that handling
once they are marked with MMF_KERNEL.

> diff --git a/mm/memory.c b/mm/memory.c
> index d5e87624f6920..c0244c0b07567 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
[ ... ]
> @@ -3394,13 +3394,13 @@ static int apply_to_pte_range(struct mm_struct *m=
m, pmd_t *pmd,
>  	spinlock_t *ptl;
> =20
>  	if (create) {
> -		mapped_pte =3D pte =3D (mm =3D=3D &init_mm) ?
> +		mapped_pte =3D pte =3D mm_is_kernel(mm) ?
>  			pte_alloc_kernel_track(pmd, addr, mask) :

[Severity: Medium]
If a non-init_mm kernel MM (like efi_mm) has MMF_KERNEL set in the future,
will this route it to pte_alloc_kernel_track() which hardcodes init_mm?

Looking at __pte_alloc_kernel() in mm/memory.c, which=20
pte_alloc_kernel_track() calls:

int __pte_alloc_kernel(pmd_t *pmd)
{
        pte_t *new =3D pte_alloc_one_kernel(&init_mm);
        if (!new)
                return -ENOMEM;

        spin_lock(&init_mm.page_table_lock);
...

Since __pte_alloc_kernel() drops the mm context and explicitly locks
init_mm.page_table_lock instead of the target MM's lock, would this
lead to data races during concurrent page table modifications for other
kernel MMs?

>  			pte_alloc_map_lock(mm, pmd, addr, &ptl);
>  		if (!pte)
>  			return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-remove_pgt=
able_cdtor-v1-0-44be8a7685d7@arm.com?part=3D4
