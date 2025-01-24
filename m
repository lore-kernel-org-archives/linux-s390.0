Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993A3156991;
	Fri, 24 Jan 2025 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737705495; cv=none; b=gjvspu3BPgycMRjuL+4WPMFg4zhKOlkyKo/mnmX2DerAPP4bfHZLTpX5diRiGTBdVffKyp34V3IppvirtaRc5a7yQ4Ovw7R+FhZot6JbrcDRhFMpCDiO+ADW8W0MuJpHzfCHNo+RZQB+sjHkUgNhv/1YrXto+U/d7SNNnzSwV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737705495; c=relaxed/simple;
	bh=dOOYMgxR5dJ6D6pdPdoRQuEu0PiWlbYN0Z4O2pdURPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlF8eAzr54frCfhDgA3P/lLJyjLUt5M4CgQvJrQ5VmzN/ZPMUBT5y3O5N+pP6BeYT/NyTHqx5cegxG1Ke1aC5T+Jj8SBMbX9mmooWtx2b6+vy55Mu8i3YeTS8fc/e9rBYomATC8kaEQGzfxZjau5hyeeDRcWr4goowQrVPqERRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2952497;
	Thu, 23 Jan 2025 23:58:40 -0800 (PST)
Received: from [10.57.95.170] (unknown [10.57.95.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9EAD3F5A1;
	Thu, 23 Jan 2025 23:58:10 -0800 (PST)
Message-ID: <f1ff18a2-1b5e-4e9a-869b-9785faabf24d@arm.com>
Date: Fri, 24 Jan 2025 08:58:07 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/mm: Add missing ctor/dtor on page table upgrade
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20250123160349.200154-1-agordeev@linux.ibm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20250123160349.200154-1-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2025 17:03, Alexander Gordeev wrote:
> Commit 78966b550289 ("s390: pgtable: add statistics for PUD and P4D
> level page table") misses the call to pagetable_p4d_ctor() against
> a newly allocated P4D table in crst_table_upgrade();
>
> Commit 68c601de75d8 ("mm: introduce ctor/dtor at PGD level") misses
> the call to pagetable_pgd_ctor() against a newly allocated PGD and
> the call to pagetable_dtor() against a newly allocated P4D that is
> about to be freed on crst_table_upgrade() PGD upgrade fail path.
>
> The missed constructors and destructor break (at least) the page
> table accounting when a process memory space is upgraded.
>
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Closes: https://lore.kernel.org/all/20250122074954.8685-A-hca@linux.ibm.com/
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Fixes: 78966b550289 ("s390: pgtable: add statistics for PUD and P4D level page table")
> Fixes: 68c601de75d8 ("mm: introduce ctor/dtor at PGD level")
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
> The patch is against:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git	next-20250123
>   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm			mm-stable

Thank you for putting together this patch! I was completely unaware of
this "upgrade" path on s390.

> ---
>  arch/s390/mm/pgalloc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index a4e761902093..d33f55b7ee98 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -88,12 +88,14 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
>  		if (unlikely(!p4d))
>  			goto err_p4d;
>  		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
> +		pagetable_p4d_ctor(virt_to_ptdesc(p4d));

This block seems to be equivalent to p4d_alloc_one(), maybe it would be
preferable to just call p4d_alloc_one() here to avoid further mismatches
in the future (and reduce duplication)?


>  	}
>  	if (end > _REGION1_SIZE) {
>  		pgd = crst_table_alloc(mm);
>  		if (unlikely(!pgd))
>  			goto err_pgd;
>  		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
> +		pagetable_pgd_ctor(virt_to_ptdesc(pgd));

I was hoping this might be equivalent to pgd_alloc() but it does not
include a call to crst_table_init(). Since adding it would be apparently
undesirable (having read the other thread), it seems reasonable to add
the explicit constructor call.

>  	}
>  
>  	spin_lock_bh(&mm->page_table_lock);
> @@ -130,6 +132,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
>  	return 0;
>  
>  err_pgd:
> +	pagetable_dtor(virt_to_ptdesc(p4d));
>  	crst_table_free(mm, p4d);

Similarly, this could be a call to p4d_free().

- Kevin

>  err_p4d:
>  	return -ENOMEM;

