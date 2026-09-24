Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F73A48D9;
	Thu, 24 Sep 2026 03:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220515; cv=none; b=Yw5qQYCGi+7iNpZwNvSrWrKmYqwCd8krqhjc5xB9u2rp3duzWtSbU0jP/v+kkL+xbtpUMVw1GpKEu59EqjzX3Cgwq7gUmv0AODl+UUlvZUlgP88W29dy1uvZ7Y5QoapEwf/xpQds3SZJ1NDwwB03K3WpzrQA0D8cDcqoqkCuZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220515; c=relaxed/simple;
	bh=ApGqBebKLjgFzhSNUM7xIQ3yP5/hw3k2FpOoK1sAf5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKWAE1A6bq3iOhfidv27CtSWI4enF4+wGkdv9Untcvq1pFrm8SQcS0kEQ8idlP0cKKpeoqiHmc/CcTJ+ipoI0ejxXklulAsaAt2LzSJdObXZfK/MlwI2XgWWmHZh+vX76Rv3UVCYznigqBk/zSBSw9VUe9Mm7UHKx7TALizIJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K/WjFZkl; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K/WjFZkl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790220508; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CU0OqDp6nwpS3D+8EJdb+ofEYYwhoXq3LClu7tPE0EE=;
	b=K/WjFZklHLLceBT2SrZsRUps5Vz4TS7Fib8nichlvpMJ2OYw4tX/wUq6Kf6sQ4ZqSKAGR3L7QnGG8T1yGQDv4crAgrZAhFAOaoTlyOluY/IgOH2XJ7Ztv+tlo5/QESLWGAKL4lfGBM3y0NuSnUjpzvXPup+9xRuXwwUVC7+wMRE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=98;SR=0;TI=SMTPD_---0XBYP0rj_1790220500;
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XBYP0rj_1790220500 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 11:28:21 +0800
Message-ID: <bd6c18af-68dc-4565-a2e3-04dd21e7ea3a@linux.alibaba.com>
Date: Thu, 24 Sep 2026 11:28:19 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] mm/khugepaged: deposit a newly allocated page
 table on collapse
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen
 <dinguyen@kernel.org>, Simon Schuster <schuster.simon@siemens-energy.com>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>,
 Qi Zheng <qi.zheng@linux.dev>, linux-doc@vger.kernel.org
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-1-fe1ad1f1e303@kernel.org>
 <arN7q5nHz7iebA_e@gremlin>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <arN7q5nHz7iebA_e@gremlin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/26 3:14 PM, Lorenzo Stoakes (ARM) wrote:
> Andrew - would it be possible to make one quick fix up below?
> 
> On Tue, Sep 22, 2026 at 04:35:32PM +0100, Lorenzo Stoakes (ARM) wrote:
>> collapse_huge_page() deposits a PTE page table on PMD collapse in order
>> that it can be utilised for subsequent split operations, meaning that those
>> operations do not need to perform an allocation (as they are in a context
>> where it might be unwise).
>>
>> However the PTE page table which is deposited is the one which is currently
>> mapped by the PMD entry that is in the process of being collapsed.
>>
>> Once deposited, the PTE page table may be used in a split of any other
>> unrelated PMD entry.
>>
>> This is currently not an issue as this operation is performed with VMA/mmap
>> write lock + anon rmap locks held, so ordinary page table walkers will
>> never accidentally end up walking the wrong thing, and GUP-fast is
>> protected by an IPI via tlb_remove_table_sync_one().
>>
>> However, the series to which this commit belongs implements RCU-safe page
>> table traversal, at which point this becomes problematic.
>>
>> This can be resolved by using pte_offset_map_lock() which gates on a PTE
>> PTL and a pmd_same() check, but lockless walks are unsafe as things stand.
>>
>> Resolve this by simply allocating a new, zeroed, PTE page table to deposit
>> at the point of collapse.
>>
>> This path is already costly and an allocation has already been performed
>> for the huge folio, so this allocation is statistical noise in terms of
>> performance and memory usage at this point.
>>
>> With this PTE page table deposited, RCU-free the existing PTE page table
>> so it is safe for page table walkers to traverse within a grace period.
>>
>> This also brings this deposit case in line with all other page table
>> deposit logic which deposit a fresh page table.
>>
>> Additionally, this was the only place in the kernel that displaced a page
>> table like this, so eliminating it also helps consistency.
>>
>> An edge case for deposit exists for powerpc and its hash-based MMU - it
>> stores hash slot data in deposited page tables and zeroes them on withdraw,
>> so a zeroed deposited page table works correctly for it.
>>
>> Since khugepaged runs as a kernel thread, do a little dance in
>> alloc_deposit_pte() to correctly charge the allocation.
>>
>> This is already done for the folio allocation via alloc_charge_folio() but
>> no such wrapper exists for a page table allocation.
>>
>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> ---
>>   mm/khugepaged.c | 32 ++++++++++++++++++++++++++++++--
>>   1 file changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index f49a6710933b..dab421f8233e 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1278,6 +1278,23 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
>>   	return SCAN_SUCCEED;
>>   }
>>
>> +static pgtable_t alloc_deposit_pte(struct mm_struct *mm)
>> +{
>> +	/*
>> +	 * khugepaged is run from a kernel thread, so need to manually set the
>> +	 * correct memcg so the allocation gets charged correctly.
>> +	 */
>> +	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
>> +	struct mem_cgroup *old_memcg = set_active_memcg(memcg);
>> +	pgtable_t pgtable;
>> +
>> +	pgtable = pte_alloc_one(mm);
>> +
>> +	set_active_memcg(old_memcg);
>> +	mem_cgroup_put(memcg);
>> +	return pgtable;
>> +}
>> +
>>   /*
>>    * collapse_huge_page() expects the mmap_lock to be unlocked before entering and
>>    * will always return with the lock unlocked, to avoid holding the mmap_lock
>> @@ -1293,7 +1310,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
>>   	LIST_HEAD(compound_pagelist);
>>   	pmd_t *pmd, _pmd;
>>   	pte_t *pte = NULL;
>> -	pgtable_t pgtable;
>> +	pgtable_t pgtable = NULL;
>>   	struct folio *folio;
>>   	spinlock_t *pmd_ptl, *pte_ptl;
>>   	enum scan_result result = SCAN_FAIL;
>> @@ -1310,6 +1327,12 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
>>   		goto out_nolock;
>>   	}
>>
>> +	if (is_pmd_order(order)) {
>> +		pgtable = alloc_deposit_pte(mm);
>> +		if (!pgtable)
>> +			goto out_nolock;
> 
> Fixup is here:
> 
> -		if (!pgtable)
> -			goto out_nolock;
> +		if (!pgtable) {
> +			result = SCAN_ALLOC_HUGE_PAGE_FAIL;
> +			goto out_nolock;
> +		}

With the fix applied, LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
