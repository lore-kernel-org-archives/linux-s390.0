Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C41A0BE0;
	Mon, 30 Jun 2025 04:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751257099; cv=none; b=Dlc04b/8caKNzdg6IkLx6geytB7cry+Kjvw6AMdA5qjdN+FEgmdffpVLLEie1NsKrHxjJ48yrMuZ12fCS8ostq46xSrpizEUWxbmBmaFLtkbtznt6fgJKWmMw0k8GOO7t80dpEDIj9LVMM3PDVr6KBG3rq93Aag5gSouoId3uvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751257099; c=relaxed/simple;
	bh=BB9ldwwmhQ6qsTGTQmSmbS2RMinxLObrzW6LV6RLqPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkxnY+p11rWuqU+kADzCAdaVkGaCNz75x9EQFgUR9jfJP4AXDvquiNfx+xc5hNUwRCjFQFb/vGXka6RdzvX84g4Bnltjcg569o482+pHhQOHaiR/nHxJX2G4x4ZVDTs9ozzSgl8JXYTQrcX9FbHdRIYLG8uug5QSXGUHEIgLiwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E4AD1F60;
	Sun, 29 Jun 2025 21:17:54 -0700 (PDT)
Received: from [10.163.39.2] (unknown [10.163.39.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC4BF3F58B;
	Sun, 29 Jun 2025 21:18:07 -0700 (PDT)
Message-ID: <e60539ab-e319-4a7c-a7ee-493df3f7f833@arm.com>
Date: Mon, 30 Jun 2025 09:48:04 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] mm/debug_vm_pgtable: Use a swp_entry_t input
 value for swap tests
To: David Hildenbrand <david@redhat.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, linux-s390@vger.kernel.org
References: <20250623184321.927418-1-gerald.schaefer@linux.ibm.com>
 <20250623184321.927418-2-gerald.schaefer@linux.ibm.com>
 <9fb04185-5b71-46c0-b62c-0e0e6ee59e6e@arm.com>
 <20250625182846.5bce1aaf@thinkpad-T15>
 <db8ab8d0-20f5-4922-a1e2-6f7409747664@redhat.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <db8ab8d0-20f5-4922-a1e2-6f7409747664@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25/06/25 10:17 PM, David Hildenbrand wrote:
>> [...]
>>>> @@ -1166,6 +1173,7 @@ static void __init init_fixed_pfns(struct pgtable_debug_args *args)
>>>>     static int __init init_args(struct pgtable_debug_args *args)
>>>>   {
>>>> +    unsigned long max_swap_offset;
>>>>       struct page *page = NULL;
>>>>       int ret = 0;
>>>>   @@ -1248,6 +1256,11 @@ static int __init init_args(struct pgtable_debug_args *args)
>>>>         init_fixed_pfns(args);
>>>>   +    /* See generic_max_swapfile_size(): probe the maximum offset */
>>>> +    max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
>>> Why not directly use generic_max_swapfile_size() which is doing exact same thing.
>>>
>>> unsigned long generic_max_swapfile_size(void)
>>> {
>>>     return swp_offset(pte_to_swp_entry(
>>>             swp_entry_to_pte(swp_entry(0, ~0UL)))) + 1;
>>> }
>>
>> Good question. I just moved this code here from pte_swap_exclusive_tests(),
>> see above, and did not think about that. Now I also wonder why
>> generic_max_swapfile_size() wasn't used before.
>>
>> But it is not exactly the same thing, there is an extra "+ 1" there.
>> Maybe that is the reason, but I don't really understand the details /
>> difference, and therefore would not want to change it.
>>
>> David, do you remember why you didn't use generic_max_swapfile_size()
>> in your pte_swap_exclusive_tests()?
> 
> Excellent question. If only I would remember :)
> 
> generic_max_swapfile_size() resides in mm/swapfile.c, which is only around with CONFIG_SWAP.
> 
> It makes sense to have that function only if there are ... actual swapfiles.
> 
> These checks here are independent of CONFIG_SWAP (at least in theory -- for migration entries etc we don't need CONFIG_SWAP), and we simply want to construct a swap PTE with all possible bits set.

After this modification of PMD based swap test - there will be now
two uses for generic_max_swapfile_size(). Rather than refactoring
these into a similar helper in mm/debug_vm_pgtable.c - should the
existing helper just be moved outside of CONFIG_SWAP, thus making
it available in general ?
