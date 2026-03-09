Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1911386C9
	for <linux-s390@vger.kernel.org>; Mon,  9 Mar 2026 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773092104; cv=none; b=GU9cCllqrYIxWtDAUmI2/Q1cAIHLpArN0u2BTLBx0klXiftIIY2/lceTw7QFK7gOBWfY7MMDZ/QXaR8d4uOe7T3B18W/xTHjKunrsvYVFbMc08RT0XXV8S3Wp2HfNLtTIq2z3rTua77L1ujrBzLyIicdeTPaUCW4SamH4Wh/CIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773092104; c=relaxed/simple;
	bh=uYcQXQANvQYncDdLBKUkt285zxtjr+wSPpd5cv6Jknc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROFRyWxpthCfFuzyDk9u7agOtyh8bX+6jtZTgizo5NtqT+gPPq2zTQlocoSqK6NyXQ6yllRqadLj9kP5bluLIUNor/H4PFUCd5Zn8XTqsVjhCkWXVcNw6wb3kEMgQqZj5IsWm7B4t6mBAa2vc5OSCWgGVAVthwkdTrJCIlzvuuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UfIiuqUj; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UfIiuqUj"
Message-ID: <de0dc7ec-7a8d-4b1a-a419-1d97d2e4d510@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773092101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Z89Z0CbGlfYyK9enL1aU6uEk1uYUJc2hi9of77FKCc=;
	b=UfIiuqUj5RN4OnUp4DNTD94bNDfHXU/WZAsxKKJI+0HRS89NtQj96WZrCoQLc2+MRaJK9s
	E3IB3pqneljaxU6hi6H97Os7emjBXks+52uiFFqGOY8CELSXzuwd1DUHfPtD1cG6LsElAj
	bpL91EN1nFg/AuG8ETeRKDtWEndcmAs=
Date: Tue, 10 Mar 2026 00:34:39 +0300
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC v2 12/21] mm: thp: handle split failure in device migration
Content-Language: en-GB
To: Nico Pache <npache@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 lorenzo.stoakes@oracle.com, willy@infradead.org, linux-mm@kvack.org,
 fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260226113233.3987674-1-usama.arif@linux.dev>
 <20260226113233.3987674-13-usama.arif@linux.dev>
 <CAA1CXcDyqPPwf_-W7B+PFQtL8HdoJGCEqVsVxq7DhOUB=L4PQA@mail.gmail.com>
 <6982e9fc-cc17-4d4f-b26e-83997c4bf070@linux.dev>
 <CAA1CXcCb6aZnjgtunEuwL380S-2re9N-AEjZUB+XO9G6gkrHQw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <CAA1CXcCb6aZnjgtunEuwL380S-2re9N-AEjZUB+XO9G6gkrHQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 09/03/2026 18:09, Nico Pache wrote:
> On Thu, Mar 5, 2026 at 9:55 AM Usama Arif <usama.arif@linux.dev> wrote:
>>
>>
>>
>> On 02/03/2026 21:20, Nico Pache wrote:
>>> On Thu, Feb 26, 2026 at 4:34 AM Usama Arif <usama.arif@linux.dev> wrote:
>>>>
>>>> Device memory migration has two call sites that split huge PMDs:
>>>>
>>>> migrate_vma_split_unmapped_folio():
>>>>   Called from migrate_vma_pages() when migrating a PMD-mapped THP to a
>>>>   destination that doesn't support compound pages.  It splits the PMD
>>>>   then splits the folio via folio_split_unmapped().
>>>>
>>>>   If the PMD split fails, folio_split_unmapped() would operate on an
>>>>   unsplit folio with inconsistent page table state.  Propagate -ENOMEM
>>>>   to skip this page's migration. This is safe as folio_split_unmapped
>>>>   failure would be propagated in a similar way.
>>>>
>>>> migrate_vma_insert_page():
>>>>   Called from migrate_vma_pages() when inserting a page into a VMA
>>>>   during migration back from device memory.  If a huge zero PMD exists
>>>>   at the target address, it must be split before PTE insertion.
>>>>
>>>>   If the split fails, the subsequent pte_alloc() and set_pte_at() would
>>>>   operate on a PMD slot still occupied by the huge zero entry.  Use
>>>>   goto abort, consistent with other allocation failures in this function.
>>>>
>>>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>>>> ---
>>>>  mm/migrate_device.c | 16 ++++++++++++++--
>>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>> index 78c7acf024615..bc53e06fd9735 100644
>>>> --- a/mm/migrate_device.c
>>>> +++ b/mm/migrate_device.c
>>>> @@ -909,7 +909,13 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
>>>>         int ret = 0;
>>>>
>>>>         folio_get(folio);
>>>
>>> Should we be concerned about this folio_get? Are we incrementing a
>>> reference that was already held if we back out of the split?
>>>
>>> -- Nico
>>
>>
>>
>> Hi Nico,
>>
>> Thanks for pointing this out. It spun out to an entire investigation for me [1].
> 
> Hey Usama,
> 
> I'm sorry my question lead you down a rabbit hole but I'm glad you did
> the proper investigation and found the correct answer :) Thanks for
> looking into it and for clearing that up via a comment!
> 
> Cheers,
> -- Nico
>

Thanks for the review! There is a need for folio_put in this patch
specifically for split_huge_pmd_address which I wouldnt have figured out
without your comment, so really appreciate it!

Usama
