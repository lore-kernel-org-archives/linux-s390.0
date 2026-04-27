Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6003540DFDC;
	Mon, 27 Apr 2026 05:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268867; cv=none; b=HeaBCjS9xO2BmORBXthHhyLz9zjVf6YWxp7RFqreAIkhw6jNPy9LFTF/zjQlqg9hh+y83WDDiPDergtYvxaDpb5CyLDl5EjyVxUrE+1Da0sGvSYpC++HfNMxkLpExejRMj5CP6nTNpkBXOfYi/0lPn5hpbm7Y/kd56qomCyN3Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268867; c=relaxed/simple;
	bh=ngRPe+T8+pfMcyU8uwuNPQvzrwRnanR3vGyANQFeZgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7OeqESNuxc2iwJ0SBXrjiB4P3Q1bWoQp3vCRHaAXvpufISztUZ4ZpGX4L3nKjMEb8Tg8dEVtP18m0hLB792Q7jvFg40k4wOCjqkuyUl8l7t7igftEFyEjzDGBxPk8jV2enxPlIISBQY4BZUB5dgd9ePbCjHrfMpfpmLYjfzDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pef69yLT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pef69yLT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B8E6201B;
	Sun, 26 Apr 2026 22:47:39 -0700 (PDT)
Received: from [10.164.18.48] (unknown [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 964703F763;
	Sun, 26 Apr 2026 22:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777268864; bh=ngRPe+T8+pfMcyU8uwuNPQvzrwRnanR3vGyANQFeZgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pef69yLTqmqAHGJ71C93lPlB3Su8jASuYyUAC2fCmHsuHgLe9jDusMtbS5I9SKGPc
	 36hXyuk7pVOs4J03x9phVIpvlzkpLz/F4HScu7DBaZ0WkFBgrf8mG0D8+t49bDN903
	 eJhc1vifL1Tr4x71vI6SyZPddxbFoe68Iyk4+m7Q=
Message-ID: <c132e0b3-ff1f-496e-aac5-3d65848dc324@arm.com>
Date: Mon, 27 Apr 2026 11:17:38 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_vma_mapped_walk: add missing pgtable entry
 accessors
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260427052000.196402-1-agordeev@linux.ibm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260427052000.196402-1-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/04/26 10:50 AM, Alexander Gordeev wrote:
> Convert pgtable direct entry dereferences to the corresponding
> pXdp_get() accessors. Use ptep_get_lockless() variant for PTE
> reads when no lock is taken.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  mm/page_vma_mapped.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index b38a1d00c971..a4520bb10d2a 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -41,7 +41,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>  	if (!pvmw->pte)
>  		return false;
>  
> -	ptent = ptep_get(pvmw->pte);
> +	ptent = ptep_get_lockless(pvmw->pte);
>  
>  	if (pte_none(ptent)) {
>  		return false;
> @@ -219,17 +219,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  restart:
>  	do {
>  		pgd = pgd_offset(mm, pvmw->address);
> -		if (!pgd_present(*pgd)) {
> +		if (!pgd_present(pgdp_get(pgd))) {
>  			step_forward(pvmw, PGDIR_SIZE);
>  			continue;
>  		}
>  		p4d = p4d_offset(pgd, pvmw->address);
> -		if (!p4d_present(*p4d)) {
> +		if (!p4d_present(p4dp_get(p4d))) {
>  			step_forward(pvmw, P4D_SIZE);
>  			continue;
>  		}
>  		pud = pud_offset(p4d, pvmw->address);
> -		if (!pud_present(*pud)) {
> +		if (!pud_present(pudp_get(pud))) {
>  			step_forward(pvmw, PUD_SIZE);
>  			continue;
>  		}
> @@ -244,7 +244,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  
>  		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>  			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> -			pmde = *pvmw->pmd;
> +			pmde = pmdp_get(pvmw->pmd);
>  			if (!pmd_present(pmde)) {
>  				softleaf_t entry;
>  
> @@ -317,7 +317,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  				goto restart;
>  			}
>  			pvmw->pte++;
> -		} while (pte_none(ptep_get(pvmw->pte)));
> +		} while (pte_none(ptep_get_lockless(pvmw->pte)));
>  
>  		if (!pvmw->ptl) {
>  			spin_lock(ptl);

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
