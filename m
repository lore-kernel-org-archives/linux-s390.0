Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71135A3AD;
	Fri,  1 May 2026 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662074; cv=none; b=nnXGwfmziNrorTVJpKabSfHFgtDziA6EaA3n0TRNquAtfhWk4jU1dIlfutjvTPpep1MVg0QRYYM63tc12+9PC0ZmvJvw1YNfA8uDMOaNpgKkr2QyxGAha3ycWx7BIdRgRImk5SVaSVoOSMYDC6LHBFBlSTfhTIX/7ybzJFyQrlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662074; c=relaxed/simple;
	bh=bGN+GuXKLt8BkjsU+fTyN3JEqVQmZxPi1LhFItNPdDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5/TII8v0a5vGoKXRniLRmzbwaIJJsV5nrin9cFsWzZeMLEVaa0J3ViAauL9Mzy8bzgo5s40WvFU0GMH82L6/wcdkumw1X7lPXN/2n4ippW02YG1lxG3xuNWuPtkpRvVrrwcVYd/tvUvuoa6YLzUyUyqTR+hBxT0mXTwYA+4qM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYMuspBM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYMuspBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39200C2BCB4;
	Fri,  1 May 2026 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777662074;
	bh=bGN+GuXKLt8BkjsU+fTyN3JEqVQmZxPi1LhFItNPdDc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EYMuspBM5/RFx2O2cUQIAmnFfT8rY+UfcrOAaqxbDyIsmHDOfYzOpSURXYENSWldi
	 fSXRA8CGtzePoDQJnzHOEhIHRY8llLl17U8+32V5YZz+xyNq3Z4oRn3aifz0Q6VDFq
	 BziQhEiooZPEGX7WDaZNmduLow6vAD+vYFPwIpgYT+Wdw8qKSi56scx9NIwzS+molL
	 zrwnRnK+RXlTKOWWGBMU9AmUZI8sXYlq+TvKDjgHXtMuLwEJ1JgzC08ViIlADDBxCC
	 ZJ6lRJy9fGOsAerc8zYDvbY1FucwCBzv9mI5v9IJKdWPTPkFqPjKkhm4QYZeNUtdBf
	 ensB43tRLW6Ag==
Message-ID: <109bc59e-1308-4505-b8c6-3376aed74585@kernel.org>
Date: Fri, 1 May 2026 21:01:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_vma_mapped_walk: add missing pgtable entry
 accessors
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260427052000.196402-1-agordeev@linux.ibm.com>
 <69c4c12c-7cdc-4a17-9eb7-6fb1a61f9834@kernel.org>
 <f3140daa-9a7d-440e-a448-35aa8797357a-agordeev@linux.ibm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <f3140daa-9a7d-440e-a448-35aa8797357a-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/26 15:47, Alexander Gordeev wrote:
> On Mon, Apr 27, 2026 at 11:02:50AM +0200, David Hildenbrand (Arm) wrote:
>> On 4/27/26 07:20, Alexander Gordeev wrote:
>>> Convert pgtable direct entry dereferences to the corresponding
>>> pXdp_get() accessors. Use ptep_get_lockless() variant for PTE
>>> reads when no lock is taken.
>>>
>>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>>> ---
>>>  mm/page_vma_mapped.c | 12 ++++++------
>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>> index b38a1d00c971..a4520bb10d2a 100644
>>> --- a/mm/page_vma_mapped.c
>>> +++ b/mm/page_vma_mapped.c
>>> @@ -41,7 +41,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>>>  	if (!pvmw->pte)
>>>  		return false;
>>>  
>>> -	ptent = ptep_get(pvmw->pte);
>>> +	ptent = ptep_get_lockless(pvmw->pte);
> 
> (*)
> 
>>>  	if (pte_none(ptent)) {
>>>  		return false;
>>> @@ -219,17 +219,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>  restart:
>>>  	do {
>>>  		pgd = pgd_offset(mm, pvmw->address);
>>> -		if (!pgd_present(*pgd)) {
>>> +		if (!pgd_present(pgdp_get(pgd))) {
>>>  			step_forward(pvmw, PGDIR_SIZE);
>>>  			continue;
>>>  		}
>>>  		p4d = p4d_offset(pgd, pvmw->address);
>>> -		if (!p4d_present(*p4d)) {
>>> +		if (!p4d_present(p4dp_get(p4d))) {
>>>  			step_forward(pvmw, P4D_SIZE);
>>>  			continue;
>>>  		}
>>>  		pud = pud_offset(p4d, pvmw->address);
>>> -		if (!pud_present(*pud)) {
>>> +		if (!pud_present(pudp_get(pud))) {
>>>  			step_forward(pvmw, PUD_SIZE);
>>>  			continue;
>>
>> Wasn't there a problem with folded page tables, where we would no longer be able
>> to optimize out the folded page table accesses?
> 
> Ok, that is a different topic. I actually tried to resolve the lockless
> issue(s) in (*) while the direct dereferences just seemed to be relevant
> to go along (similarly to the GUP patch).
> 
> But I would rather resend ptep_get() => ptep_get_lockless() fixes for
> this patch.
> 
> Would it work?

You mean only sending {*) ?

-- 
Cheers,

David
