Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D3433F8A2;
	Tue, 31 Mar 2026 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966533; cv=none; b=N2xKPNKfrBg7e3tR7RffNnkE5GB+xxY/IAxxhPwYlYuwZfLS3xSN0kUKrYUQb07pQVJpuFvxCMEWj2ZsUeBQgwRWscloj5M+apBe6t/Xubp7ZDrm8IXGd3ea/0RCarbi3rj2klP3ZWWm8pGwUK5uIDfh2NBnqjsbdTGHlomSw/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966533; c=relaxed/simple;
	bh=9z2MXKM/ZiMSqPeqkaUKxlawR2frF3py0x92yErvlU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUqLqTFEHwlyXOPXYPVPjBa7+JJXbstBhPfSdCoIyef7If68c3e9s+HxZLmwPuT8xXkCA9KsHrKlMoEE+UHl07AAjanE0grr0dD8FQLLTrNaBZZEMXXqcHkJlUPy5+HfKypKqGabKG084XjeJNeIhdSthiz8IPzZRBoWeH/1l+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oJM7vb4P; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oJM7vb4P"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79392497F;
	Tue, 31 Mar 2026 07:15:25 -0700 (PDT)
Received: from [10.57.56.98] (unknown [10.57.56.98])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83F593F641;
	Tue, 31 Mar 2026 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774966531; bh=9z2MXKM/ZiMSqPeqkaUKxlawR2frF3py0x92yErvlU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oJM7vb4PMFH8u1/9y2halmmZt6v/lBq8nRr1CQtr07dScwz8NKTR7nvLEVsrXHI2M
	 klGmCUswAwUvGwr1LljNzFRndxJf6Rv0el6JfhfIv57auBJK1/WHKBPEasmO4dMZd5
	 Vvs9SSp1PkrOXybInOopmh2rYwurpfgXCLuo9QcQ=
Message-ID: <c27cad07-bba4-472d-8853-fc6fc55e951f@arm.com>
Date: Tue, 31 Mar 2026 16:15:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm: make lazy MMU mode context-aware
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1774420056.git.agordeev@linux.ibm.com>
 <de89fd353a8dcd5e3bef4d91e9b6682d132ed9a0.1774420057.git.agordeev@linux.ibm.com>
 <44dd86c0-1845-4dd9-b4b4-2cef6d1c6357@kernel.org>
 <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2026 17:20, Alexander Gordeev wrote:
> On Wed, Mar 25, 2026 at 10:55:23AM +0100, David Hildenbrand (Arm) wrote:
>
> Hi David,
>
>>> +/**
>>> + * lazy_mmu_mode_enable_pte() - Enable the lazy MMU mode with parameters
>> You have to be a lot clearer about implications. For example, what
>> happens if we would bail out and not process all ptes? What are the
>> exact semantics.
> The only implication is "only this address/PTE range could be updated
> and that range may span one page table at most".
>
> Whether all or portion of PTEs were actually updated is not defined,
> just like in case of lazy_mmu_mode_enable_pte().
>
> Makes sense?

I also feel that the comment needs to be much more specific. From a
brief glance at patch 2, it seems that __ipte_batch_set_pte() assumes
that all PTEs processed after this function is called are contiguous.
This should be documented.

>>> + * Enters a new lazy MMU mode section; if the mode was not already enabled,
>>> + * enables it and calls arch_enter_lazy_mmu_mode_pte().
>>> + *
>>> + * Must be paired with a call to lazy_mmu_mode_disable().
>>> + *
>>> + * Has no effect if called:
>>> + * - While paused - see lazy_mmu_mode_pause()
>>> + * - In interrupt context
>>> + */
>>> +static inline void lazy_mmu_mode_enable_pte(struct mm_struct *mm,
>>> +					    unsigned long addr,
>>> +					    unsigned long end,
>>> +					    pte_t *ptep)
>> It can be multiple ptes, so should this be some kind of "pte_range"/
>>
>> lazy_mmu_mode_enable_for_pte_range()
>>
>> A bit mouthful but clearer.
>>
>>> +{
>>> +	struct lazy_mmu_state *state = &current->lazy_mmu_state;
>>> +
>>> +	if (in_interrupt() || state->pause_count > 0)
>>> +		return;
>>> +
>>> +	VM_WARN_ON_ONCE(state->enable_count == U8_MAX);
>>> +
>>> +	if (state->enable_count++ == 0)
>>> +		arch_enter_lazy_mmu_mode_pte(mm, addr, end, ptep);
> I will also change arch_enter_lazy_mmu_mode_pte() to
> arch_enter_lazy_mmu_mode_for_pte_range() then.

Makes sense. The interface looks reasonable to me with this new name.

One more comment though: in previous discussions you mentioned the need
for arch_{pause,resume} hooks, is that no longer necessary simply
because {pause,resume} are not used on the paths where you make use of
the new enable function?

- Kevin
