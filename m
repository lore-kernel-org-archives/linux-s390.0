Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF47262B;
	Thu, 28 May 2026 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967482; cv=none; b=Mpo8mnwWuR/JP1QjPM8TbJ4zvHP9IkD83MGPMl8S7Q3VeW2ILnK8++DYWbsfTYcYnW9wtLx7b3qGLTeRY64UVz1va+4BkrwApr1HQd5msBX+s+Iz0Xnng5WJJpx+RtkZ2T+xsXiLUSOqIPXZv5okUoJokB3F0Xd2UI9wJTRFOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967482; c=relaxed/simple;
	bh=gCfCYwr5O1HF8HrKGi8ZW5/6uQ751dyUj1fIPM1S+mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=griG3Org0/wAj3h2VkmGJ6C5FKxWCIypGmUTK/CfHsK+NQ1SNdOtyNllZJ99L+iobnURGtbhG+NWtpVQ6rzT/JegZ5Z1i25Ofa7uUrmANNvgHRqMRswT8SznD8bdrRLABYKf1w5QTTqFfgDs1Fmqq0WgTg84zECQdd6jqbnN7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5V4HWOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5V4HWOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4291F000E9;
	Thu, 28 May 2026 11:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779967481;
	bh=O5hCo12AieiEvQS5ItXa2ui3IkPos7/8NxeCJceX1Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m5V4HWOrNTniIGkD6RJ7hWNU512A5PG9HjVtLbsM6xvKMRcBua/iBKeDeVeuGX/nu
	 NKWYjAa4sxiU7gyqJYZ152vRl1uwKCu8bDG7ncq0ntCA0KbLJh12t1MwBHP03tIyKA
	 TZbffnMlqF+CqYGTA5tzi4z5SLhCCzred5iqDfNicDfgsE5uQrQvxXHCApZ/zNS3C2
	 aZt7Zv1LtigVX5KOGdBftiUdxxLOA4uwzskycZbd2CiK7NqfdWLp38Yyxw987Pobx5
	 ggoOISBudB3sVaEDjpiG1dBD4OKtqASqQSY7nLOb+0rGd3EXo664eI6x1L/x+NMWcM
	 Z91A0jRsVrWvw==
Date: Thu, 28 May 2026 12:24:35 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Oscar Salvador <osalvador@suse.de>, Wei Yang <richard.weiyang@gmail.com>, linux-s390@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_vma_mapped_walk: Use ptep_get_lockless() for
 lockless access
Message-ID: <ahglqif-I4TjFK9X@lucifer>
References: <20260528075507.1821939-1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528075507.1821939-1-agordeev@linux.ibm.com>

On Thu, May 28, 2026 at 09:55:07AM +0200, Alexander Gordeev wrote:
> Switch from ptep_get() to ptep_get_lockless() accessor for
> PTE reads when no lock is taken.

This is an insufficient commit message that's just saying what you're doing,
which isn't very useful.

Please explain why you're doing this and what the benefit is please.

Thanks, Lorenzo

>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  mm/page_vma_mapped.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index a4d52fdb3056..2ccbabfb2cc1 100644
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
> @@ -183,6 +183,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  	struct mm_struct *mm = vma->vm_mm;
>  	unsigned long end;
>  	spinlock_t *ptl;
> +	pte_t pteval;
>  	pgd_t *pgd;
>  	p4d_t *p4d;
>  	pud_t *pud;
> @@ -310,7 +311,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  				goto restart;
>  			}
>  			pvmw->pte++;
> -		} while (pte_none(ptep_get(pvmw->pte)));
> +			if (!pvmw->ptl)
> +				pteval = ptep_get_lockless(pvmw->pte);
> +			else
> +				pteval = ptep_get(pvmw->pte);
> +		} while (pte_none(pteval));
>
>  		if (!pvmw->ptl) {
>  			spin_lock(ptl);
> --
> 2.51.0
>
