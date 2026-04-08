Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB923D1CAC
	for <linux-s390@vger.kernel.org>; Wed,  8 Apr 2026 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660809; cv=none; b=tEjO12tF3bEWaWUROQGymkyAoC2PBhN1ztA7UXHzJUHhTU8P3qvJCiSs6A6OD2AA2wdBadiWjXCRkCjKmxq9OwEL2JHKqaU5uO648cyFzeM7ZM+cs0BcDZHe31w+ko77xfxWGZumaMVBXb8NWoZFZZNM1o1RuMokMPfIr8JazjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660809; c=relaxed/simple;
	bh=nwCQJ1PQtlLZn8ps/8TYukl0slkv+apHmVCT0xgq8+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5oWestuWUGL5DwcscLm40BAHXjn90KqX9r7i2eLMxCcukbGKqag4n8CHffh4gvuwuvIBu7Fz0c6zRUGVuJps3Z+XpIj+K06s/PjqNSrxJXLcKO8AkIO5eb/7C1g4atUjZ0P9Xad40IvcMktpC6J7nKI3q8SzI+KZ3RCP3i65pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nce/YT8h; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nce/YT8h"
Message-ID: <3f9e8e12-2d51-4f2a-ada1-994ed24df284@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775660796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+VU8UBRdEVEeyiV4+aPbi7V4ANQswood2btwWC7W10=;
	b=nce/YT8hy0RDyIldhTyZu273O+IC+4lreKGHKqWJoK3qIW7bVWBVi0LDO0W3lmX0H16Zbp
	2j0OvnNTiosCwvyEbTE3/t2vJHMqme6LCCCV3xImTBLdUhG0DAWay2mblTf9uccqXFl8OC
	AexvCrHBe5xG29n0GcZSuslUwx11Dow=
Date: Wed, 8 Apr 2026 16:06:29 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>, willy@infradead.org, linux-mm@kvack.org,
 fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <6869b7f0-84e1-fb93-03f1-9442cdfe476b@google.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <6869b7f0-84e1-fb93-03f1-9442cdfe476b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 06/04/2026 00:34, Hugh Dickins wrote:
> On Thu, 26 Mar 2026, Usama Arif wrote:
> 
>> When the kernel creates a PMD-level THP mapping for anonymous pages, it
>> pre-allocates a PTE page table via pgtable_trans_huge_deposit(). This
>> page table sits unused in a deposit list for the lifetime of the THP
>> mapping, only to be withdrawn when the PMD is split or zapped. Every
>> anonymous THP therefore wastes 4KB of memory unconditionally. On large
>> servers where hundreds of gigabytes of memory are mapped as THPs, this
>> adds up: roughly 200MB wasted per 100GB of THP memory. This memory
>> could otherwise satisfy other allocations, including the very PTE page
>> table allocations needed when splits eventually occur.
>>
>> This series removes the pre-deposit and allocates the PTE page table
>> lazily — only when a PMD split actually happens. Since a large number
>> of THPs are never split (they are zapped wholesale when processes exit or
>> munmap the full range), the allocation is avoided entirely in the common
>> case.
>>
>> The pre-deposit pattern exists because split_huge_pmd was designed as an
>> operation that must never fail: if the kernel decides to split, it needs
>> a PTE page table, so one is deposited in advance. But "must never fail"
>> is an unnecessarily strong requirement. A PMD split is typically triggered
>> by a partial operation on a sub-PMD range — partial munmap, partial
>> mprotect, COW on a pinned folio, GUP with FOLL_SPLIT_PMD, and similar.
>> All of these operations already have well-defined error handling for
>> allocation failures (e.g., -ENOMEM, VM_FAULT_OOM). Allowing split to
>> fail and propagating the error through these existing paths is the natural
>> thing to do. Furthermore, if the system cannot satisfy a single order-0
>> allocation for a page table, it is under extreme memory pressure and
>> failing the operation is the correct response.
>>
>> Designing functions like split_huge_pmd as operations that cannot fail
>> has a subtle but real cost to code quality. It forces a pre-allocation
>> pattern - every THP creation path must deposit a page table, and every
>> split or zap path must withdraw one, creating a hidden coupling between
>> widely separated code paths.
>>
>> This also serves as a code cleanup. On every architecture except powerpc
>> with hash MMU, the deposit/withdraw machinery becomes dead code. The
>> series removes the generic implementations in pgtable-generic.c and the
>> s390/sparc overrides, replacing them with no-op stubs guarded by
>> arch_needs_pgtable_deposit(), which evaluates to false at compile time
>> on all non-powerpc architectures.
> 
> I see no mention of the big problem,
> which has stopped us all from trying this before.
> 
> Reclaim: the split_folio_to_list() in shrink_folio_list().
> 
> Imagine a process which has forked a thousand times, containing
> anon THPs, which should now be swapped out and reclaimed.
> 
> To swap out one of those THPs, it will have to allocate a
> thousand page tables, all with PF_MEMALLOC set (to give some
> access to reserves, while preventing recursion into reclaim).
> 
> Elsewhere, we go to great lengths (e.g. mempools) to give
> guaranteed access to the memory needed when freeing memory.
> In the case of an anon THP, the guaranteed pool has been the
> deposited page table. Now what?
> 
> And the worst is that when the 501st attempt to allocate a page
> table fails, it has allocated and is using 500 pages from reserve,
> without reaching the point of freeing any memory at all.
> 
> Maybe watermark boosting (I barely know whereof I speak) can help
> a bit nowadays.  Has anything else changed to solve the problem?
> 
> What would help a lot would be the implementation of swap entries
> at the PMD level.  Whether that would help enough, I'm sceptical:
> I do think it's foolish to depend upon the availability of huge
> contiguous swap extents, whatever the recent improvements there;
> but it would at least be an arguable justification.
> 
Thanks for pointing this out. I should have thought of this as I
have been thinking about fork a lot for 1G THP and for this series.

I am working on trying to make PMD level swap entires work. I hope
to have a RFC soon.



