Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E63386C3B;
	Fri, 29 May 2026 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076084; cv=none; b=KHJlNaxMwQlFetkRB8ZyM8AQMgF/efHwBQC2vmKWy66uB3N71mn/644FbGdW8Qg3tD/7epyTnWnEoSGXJc0FVfHVBF4mPpG+Ycjhv86vOJoUUlZEJiPIfjefEHd3hF5/6cwjsnYtuIOut4/cdVZIjLrsWJ1KZF16rEaOUdwvWnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076084; c=relaxed/simple;
	bh=gWE85iXQq0OMAav9N8JBZGImgsA0+NVC5ul9DghcUSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFKYbeX2yyExq0vlmSCgUKNhH8dtXMBvyQj06WCRgphjcOQx4CEGD1AHciI29zVAIChzRxm78AKL6Yt97ghQwX4hixiSaWb8zcp7a+haujbCc8GZWZUB9yWSqXoTk8KjvjeiCcrguVC9D4j2AZNEGrlfdPytTfd0yNVCu6ImuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIHMmeyl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIHMmeyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F57F1F00893;
	Fri, 29 May 2026 17:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780076083;
	bh=mA/wSXvnzaFLyBu6mpFQS3mrr4Pq4o/pVqTj7FF8Rpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dIHMmeylOq5MWUgqcV6cJduFvFXbZ9gggbTGpRsf8yqQofigkJGwMiMHUomt8BbwX
	 UTjpQ5OsQRm1SNtpYd4AwPyP2+yqhfQCBOJUws+zh1rpj26jP1ynwGsvt3sPMQxfaL
	 BKQo2ktSt/KGxbcgj55b8dYfG3ZSo4cqdO9S5ky1LFNDvtRFt7If6nC8TIeHtnPLni
	 +S02xVS28/9xA7StPjQp55zdHH68c1/Zg/7rkYe8jPVDRBFjW8lLWjv12ZO/dDiHql
	 EFGngsjnHjcLCoFnNVIisaJhz/qWPm61r7hfpFGBjubc8iSb5Fz3bXRgvJQ/XQrfCF
	 i4LsJ2ZwSmbQw==
Date: Fri, 29 May 2026 19:34:36 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Wei Yang <richard.weiyang@gmail.com>, linux-s390@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_vma_mapped_walk: Use ptep_get_lockless() for
 lockless access
Message-ID: <ahnOLCyOwGV1Yp5J@localhost.localdomain>
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
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

I see Andrew has picked up the patch with the amended changelog, so with
that:

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

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

-- 
Oscar Salvador
SUSE Labs
