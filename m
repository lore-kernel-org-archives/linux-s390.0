Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED8306B25;
	Mon, 15 Dec 2025 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765778809; cv=none; b=n5AR/zG2bCyhjKf9jjOWoorv+DxmFtyRiZR+iV61xh1Gs1DGutgV8P5kOJyN7IiNEauWpcjfCpPoE6rNdvHhw8kbf4CnL01t4hPosHZJnSK6GK1FxFGpTLIn25GRfddFs4i8osDwxVDqtbGv51QXxth7J9hSR7S9WvK5O4jDOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765778809; c=relaxed/simple;
	bh=LZhBjlTxoFNlhrByvEV/y6EF+GjXIZM8Cs2e+DsOYK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r2JwNSzf+SG7HSEPV9RpTl6+K7IwzNtizyz8o3wqCzTjSJZbDiwquTwsffpMSv9BTa/pnYy2UCeQGekIL2qZm6gXso3VdJgW29AJqB5ODEMXPlF/n5cS2uTjIhlpKYyMbtqjDApECN6qvo8cJtkmuvWlt61tpqNhef9srvrA1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsvGK6qE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsvGK6qE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAD2C4CEF5;
	Mon, 15 Dec 2025 06:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765778809;
	bh=LZhBjlTxoFNlhrByvEV/y6EF+GjXIZM8Cs2e+DsOYK0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dsvGK6qEbjcxkfXe4dgqGA+2gUZtLCGId9H7SRkUvCsYVOVSKyLW+oEIivRixBz+1
	 Z2Kkg2MWVahuSVvGlCjiAodOrZGvJJhqNY64Auk2gayogXzdCDIoc10dKd+5rCIJGp
	 g6OOehz+1Z3pGWYZQp2ltjP1V2ZMst0KhsfOTFkv9P4MH2bPqMG5DlMXRoUfSij6ub
	 e0vDR9gl0HQ/I0xH6yl3grXwGmyh32GJjZZfc5hMA9h56ccCrDeUdEezOPD+GB8JOK
	 WmtGBHDM9GXG3PrHDOf2iqrmzjJIALENh50UFXxhp5HRp0BST6R+FidCNs+EnUt6iK
	 76woTMbh/rMYA==
Message-ID: <686b85ff-6a5a-4608-af97-55aee1582c5c@kernel.org>
Date: Mon, 15 Dec 2025 07:06:34 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm/pgtable: use ptdesc for pmd_huge_pte
To: alexs@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Thomas Huth <thuth@redhat.com>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Magnus Lindholm <linmag7@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <20251214065546.156209-1-alexs@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20251214065546.156209-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/12/2025 à 07:55, alexs@kernel.org a écrit :
> From: Alex Shi <alexs@kernel.org>
> 
> 'pmd_huge_pte' are pgtable variables, but used 'pgtable->lru'
> instead of pgtable->pt_list in pgtable_trans_huge_deposit/withdraw
> functions, That's a bit weird.
> 
> So let's convert the pgtable_t to precise 'struct ptdesc *' for
> ptdesc->pmd_huge_pte, and mm->pmd_huge_pte, then convert function
> pgtable_trans_huge_deposit() to use correct ptdesc.
> 
> This convertion works for most of arch, but failed on s390/sparc/powerpc
> since they use 'pte_t *' as pgtable_t. Is there any suggestion for these
> archs? If we could have a solution, we may remove the pgtable_t for other
> archs.

The use of struct ptdesc * assumes that a pagetable is contained in one 
(or several) page(s).

On powerpc, there can be several page tables in one page. For instance, 
on powerpc 8xx the hardware require page tables to be 4k at all time, 
allthough page sizes can be either 4k or 16k. So in the 16k case there 
are 4 pages tables in one page.

There is some logic in arch/powerpc/mm/pgtable-frag.c to handle that but 
this is only for last levels (PTs and PMDs). For other levels 
kmem_cache_alloc() is used to provide a PxD of the right size. Maybe the 
solution is to convert all levels to using pgtable-frag, but this 
doesn't look trivial. Probably it should be done at core level not at 
arch level.

Christophe

> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> ---
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index aac8ce30cd3b..f10736af296d 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1320,11 +1320,11 @@ pud_t pudp_huge_get_and_clear_full(struct vm_area_struct *vma,
>   
>   #define __HAVE_ARCH_PGTABLE_DEPOSIT
>   static inline void pgtable_trans_huge_deposit(struct mm_struct *mm,
> -					      pmd_t *pmdp, pgtable_t pgtable)
> +					      pmd_t *pmdp, struct ptdesc *pgtable)
>   {
>   	if (radix_enabled())
> -		return radix__pgtable_trans_huge_deposit(mm, pmdp, pgtable);
> -	return hash__pgtable_trans_huge_deposit(mm, pmdp, pgtable);
> +		return radix__pgtable_trans_huge_deposit(mm, pmdp, page_ptdesc(pgtable));
> +	return hash__pgtable_trans_huge_deposit(mm, pmdp, page_ptdesc(pgtable));
>   }
>   

I can't understand this change.

pgtable is a pointer to a page table, and you want to replace it to 
something that returns a pointer to a struct page, how can it work ?

Christophe
