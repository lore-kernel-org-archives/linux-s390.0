Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595267;
	b=CxdTWDlWcEJP6A9rMF7hZh4Wel+8q0jHbkXEvQFIKSOxD3AGi90XAfOyy2Heg4CkNqIz
	 8LPapM4GWXk1qmACBxUHjOJiHb/8xUpeRsw6LSgbv424eeiqcLj6IyaIS7GtSnL60W3XB
	 ZDsvX1OXkCI73xmAU6uA4F1iySYRjNakmq5QA8EwyNJ0BdUBQNkBLylu1AojP0cOvWkPP
	 8OkD3zg/cSPbIKVnaVzSOYf6r08wLyn6LUiYbEC478CZvz+Td3YK1fklGve+Fue0vxDgv
	 xOazKQ219UT/eDO5QWUnci4JJ2MP8xxFqTylV8onls5pqBXhhsSNo8FiLSvqQxaRNpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595267;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XpptrgK2l80VgLjm5xpa2pL7+GMcRlYHRpTi5z7EAjU=;
	b=1jnBwPn/aMtY6THcM29mqClR8vPH5BQioBoFUncfsIRMJvFzR+4wR5FneJ3uqhxvFWaK
	 agjDtTgoLWBdgWMvyhoVwkbNzTfyoBUjSEikF6nmsbv52+7lIc6xqqELnWj7kGxny9FMh
	 fTuWzoYZWFpklX/Qb2sRZqk4gu0lGEO6nor6BrZ3mlYHtTLehj6Xu4OFumDbWnZ1fCsZ+
	 7N6zZzU4qFbG4KFn9iiyRi9honipb44C37NNM5JBeETPVCljVdrI9QTmauIKXnxwbrdAH
	 czSbl1SjoBE0rCHWs7z1g82gcz7cZ6D0BJJZrVJ1acJ+KscddbTjbm7H+kyRbJ0knWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPltpBH5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CD0606A33F;
	Fri, 13 Nov 2026 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPltpBH5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050CF1F000C5;
	Fri, 13 Nov 2026 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794595266;
	bh=XpptrgK2l80VgLjm5xpa2pL7+GMcRlYHRpTi5z7EAjU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=UPltpBH5YLh1QQnrefheBr7BYwXIXoWGQCLJA1Zdq5XfCsvRTcbVSjBjmckRpr6gj
	 p1mSYPsTCxeL93RU9a6/RHPQeqqwzwr71lDQiLJigcyNIASreO27Us2sljcDA/txMt
	 l9bN2KgqB0xysRCnnIH+h6RnzBFZZAb6oDHgThHQMshrJd32N32hC55ooTjVb5ir1K
	 J+cJ2azt+UXtcfuPAbjFaH4x3AFFdzQWl02/ZP8G92warfRjI97NymrClN1xsJeVkn
	 AWqDLNOI8WVqN8AUUxubqgV9rG1I2dgahcOH4WA8R5GfCoTQQfmm+rFiJ99iLkA16e
	 J64/nx+9hlzyQ==
Message-ID: <8b186ea8-7a3b-4bb6-9354-de4b8892799f@kernel.org>
Date: Fri, 13 Nov 2026 19:40:55 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] mm/mprotect: keep writable entries writable on
 permission upgrades
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, kvm@vger.kernel.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-riscv@lists.infradead.org, seanjc@google.com, pbonzini@redhat.com,
 akpm@linux-foundation.org, peterx@redhat.com, ljs@kernel.org,
 imbrenda@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <20261105165004.2663799-4-clopez@suse.de>
 <20261105165004.2663799-9-clopez@suse.de>
 <60c4f0a0-e3c9-42dc-b2e0-0860ab6e30f0@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <60c4f0a0-e3c9-42dc-b2e0-0860ab6e30f0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/5/26 18:06, David Hildenbrand (Arm) wrote:
> On 11/5/26 17:50, Carlos López wrote:
>> change_protection() applies vma->vm_page_prot, which lacks the write bit
>> for CoW and write-notified mappings, so it write-protects every entry
>> in them. When an entry would simply be made writable on fault without
>> further checks (e.g. dirty PTEs in shared mappings, exclusive anonymous
>> pages), MM_CP_TRY_CHANGE_WRITABLE makes the entry writable again to
>> avoid the future fault.
>>
>> However, writable entries in shared mappings that are not dirty still
>> become read-only. For example, a uffd-wp unprotect makes clean shmem
>> PTEs read-only even if they were never write-protected, e.g. when they
>> were mapped by a read fault before uffd-wp was registered. The next
>> write to each of them causes a fault that only restores the write bit.
>>
>> Now that MM_CP_PERM_UPGRADE indicates whether mprotect() only adds
>> permissions, change_protection() can tell, together with the
>> userfaultfd unprotect flags, when a change revokes no access. Keep
>> writable entries writable in these cases, at the PTE, PMD and PUD
>> levels. This is consistent with the write fault handler, as an entry
>> that is already writable needs no write fault.
>>
>> Signed-off-by: Carlos López <clopez@suse.de>
>> ---
>>  mm/huge_memory.c | 7 +++++++
>>  mm/internal.h    | 7 +++++++
>>  mm/mprotect.c    | 4 ++++
>>  3 files changed, 18 insertions(+)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 506e1e61c0fd..6e23d0e4ae66 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2809,6 +2809,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  	if (userfaultfd_rwp(vma) && pmd_uffd(entry))
>>  		entry = pmd_modify(entry, PAGE_NONE);
>>  
>> +	/* See change_present_ptes(). */
>> +	if (mm_cp_is_perm_upgrade(cp_flags) && pmd_write(oldpmd))
>> +		entry = pmd_mkwrite(entry, vma);
>> +
>>  	/* See change_pte_range(). */
>>  	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pmd_write(entry) &&
>>  	    can_change_pmd_writable(vma, addr, entry))
>> @@ -2885,6 +2889,9 @@ int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  	 */
>>  	oldpud = pudp_invalidate(vma, addr, pudp);
>>  	entry = pud_modify(oldpud, newprot);
>> +	/* See change_present_ptes(). */
>> +	if (mm_cp_is_perm_upgrade(cp_flags) && pud_write(oldpud))
>> +		entry = pud_mkwrite(entry);
> 
> That looks completely hacked on. We do have can_change_pud_writable() below to
> make such decisions.
> 
> Whaatever you propose here is either wrong or way too shaky, sorry.
For some reason, your reply neither reached my inbox through CC nor the
mailing list folder through the mailing list.

I see that you send a v3 where you keep it simple for now, good.

>> 
>> That looks completely hacked on. We do have can_change_pud_writable() below to
>> make such decisions.
>
> Okay, for v3 I can pass the old entry to can_change_{pmd,pud}_writable()
> and return true if it was writable, after the existing write-tracking
> checks (uffd-wp/soft-dirty). For PTEs, can_change_pte_writable() is not
> used on the change_protection() path, so the same check would go in
> set_write_prot_commit_flush_ptes().
>
> Does that sound more reasonable?

Let's keep it simple for now. Whenever we mess with protection changes
there is the chance that we mess up and cause more trouble, either now
or in the future when we change calling code.

>
> Whaatever you propose here is either wrong or way too shaky, sorry.
>
> The idea is that MM_CP_TRY_CHANGE_WRITABLE relies on the dirty bit to
> make entries in shared mappings writable, which misses clean entries
> that were already writable (e.g. shmem read-faulted before uffd-wp
> registration). Such entries can stay writable, as anything that relies
> on write faults write-protects the entry first.

Right, but that should be optimized separately with a clear motivation why
we even care about optimizing this.

Not hidden in a patch set that tries to achieve something completely different.

-- 
Cheers,

David

