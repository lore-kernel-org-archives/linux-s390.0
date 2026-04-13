Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7095034F48D;
	Mon, 13 Apr 2026 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074479; cv=none; b=E9pYfqMvvUJnu2lih3Jt0VVYoFnmp72iagZhaZjKXUHHpD8n0j/kLbQqkAO/4G2iieM28WrIcUDh4wP03FyJsR9nR70o52xGxWEr1JNtOIlKM56GLa0cxvPWf0saVJ4ySfu5ejumypMoFcmaFbwgEEsf8ZisnYRbrz0GFnCcKSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074479; c=relaxed/simple;
	bh=VfA8RhsAOysYjLUfYem1mhkUwG7Eg8LbTrkQ0B9ZA5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7wgJ/Jmn7P6h9aa8IunzRz9N8aNpG+er/HszQETZoeE+KhKvg3HAwRLMuOPnCEb4vkYiPMOlCGlrxs7VenOfRprzDJzQMnM40WMmidVQcThsUk63HEY2qFkATtvdyXYZsYIa+hIxxhfvLs5djZXLgOw/pK1j9K0W1d0Tfg4LwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Jf/daWju; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Jf/daWju"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D15DD2BC3;
	Mon, 13 Apr 2026 03:01:10 -0700 (PDT)
Received: from [10.57.62.88] (unknown [10.57.62.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 437D63F93E;
	Mon, 13 Apr 2026 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776074476; bh=VfA8RhsAOysYjLUfYem1mhkUwG7Eg8LbTrkQ0B9ZA5I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jf/daWjupLaPbtHP/9QPzRRQx2LsU2h0EnB1m1NdswrK+Tj1s1zcYjBVTmPki3tdM
	 7gY2Gvut4emf1ojyvOanZa1i2jfuUo7ky4CBaE6ouf8gmcuLIGCZjQ2pU3LyrFgzxD
	 XG+KcXKif5eeNFnVo6KqtPcCuD7ql63VM3m8z5HY=
Message-ID: <4ac1d020-9aec-4584-a75c-225c6166c253@arm.com>
Date: Mon, 13 Apr 2026 12:01:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm: make lazy MMU mode context-aware
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1774420056.git.agordeev@linux.ibm.com>
 <de89fd353a8dcd5e3bef4d91e9b6682d132ed9a0.1774420057.git.agordeev@linux.ibm.com>
 <44dd86c0-1845-4dd9-b4b4-2cef6d1c6357@kernel.org>
 <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
 <c27cad07-bba4-472d-8853-fc6fc55e951f@arm.com>
 <630ce949-2f9c-43ce-9641-b9a4dc729323-agordeev@linux.ibm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <630ce949-2f9c-43ce-9641-b9a4dc729323-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2026 11:31, Alexander Gordeev wrote:
> On Tue, Mar 31, 2026 at 04:15:23PM +0200, Kevin Brodsky wrote:
>> On 25/03/2026 17:20, Alexander Gordeev wrote:
>>> On Wed, Mar 25, 2026 at 10:55:23AM +0100, David Hildenbrand (Arm) wrote:
>>>
>>> Hi David,
>>>
>>>>> +/**
>>>>> + * lazy_mmu_mode_enable_pte() - Enable the lazy MMU mode with parameters
>>>> You have to be a lot clearer about implications. For example, what
>>>> happens if we would bail out and not process all ptes? What are the
>>>> exact semantics.
>>> The only implication is "only this address/PTE range could be updated
>>> and that range may span one page table at most".
>>>
>>> Whether all or portion of PTEs were actually updated is not defined,
>>> just like in case of lazy_mmu_mode_enable_pte().
>>>
>>> Makes sense?
>> I also feel that the comment needs to be much more specific. From a
>> brief glance at patch 2, it seems that __ipte_batch_set_pte() assumes
>> that all PTEs processed after this function is called are contiguous.
> No, this is actually not the case. __ipte_batch_set_pte() just sets
> ceilings for later processing. The PTEs within the range could be
> updated in any order and not necessarily all of them.

Fair enough, I suppose what I tried to say is that all PTEs must be in a
certain range :)

>> This should be documented.
> Will do.
>
>>> I will also change arch_enter_lazy_mmu_mode_pte() to
>>> arch_enter_lazy_mmu_mode_for_pte_range() then.
>> Makes sense. The interface looks reasonable to me with this new name.
>>
>> One more comment though: in previous discussions you mentioned the need
>> for arch_{pause,resume} hooks, is that no longer necessary simply
>> because {pause,resume} are not used on the paths where you make use of
>> the new enable function?
> Yes. I did implement arch_pause|resume_lazy_mmu_mode() for a custom
> KASAN sanitizer to catch direct PTE dereferences - ones that bypass
> ptep_get()/set_pte() in lazy mode.

That sounds pretty useful!

> But that code is not upstreamed and therefore there is no need to
> introduce the hooks just right now.

Ack that makes sense.

>> - Kevin
> Thanks for the review, Kevin!

No problem :)

- Kevin
