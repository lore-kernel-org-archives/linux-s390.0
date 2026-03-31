Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830F3D7D70;
	Tue, 31 Mar 2026 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991487; cv=none; b=O5oEulxG72aHu3u4IDv/yRioZl1ui9GjJlClRdTl5kgA4FMbNA3pcNo9ACEZ+nFIpoRVoLw8br6t4meGIvcBKO2/UU3loK1Khz1+o58mbHyOB7EOrMibx8P54qTgGwusZxdF+VuHZAi/ypEJQzsa8mN46SPVTrC5JkOSytcRoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991487; c=relaxed/simple;
	bh=2zPP+LmYtyi//uMOzgdQ8fnlTThEckhI+esz3lXXfZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvE6fEikxYCSp359+X/Tuo4UuthigmKXJDxUr1bCkBwDueDPPUA8oGF31drNt+FyZdrU3OAJcqEDt+fgiszI/6toJafPqY+MlErZORiq5dFBJ2zajfu6ARmrJOgE8lhB9q2vncQe+QeZJwLYvUEvszFNmpY1EF+whO7DQbXGkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+6BW5OP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+6BW5OP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FF9C19423;
	Tue, 31 Mar 2026 21:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991487;
	bh=2zPP+LmYtyi//uMOzgdQ8fnlTThEckhI+esz3lXXfZ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A+6BW5OPP6fq/QKr9cgbG4pDUJxtSVWOEP2jOYcgkXDRXC2M6VOrRTy0xdXOH5tc6
	 DZXet3mOOqFZ3TTXsM4k3brhMAd33l0+ACPzw0ETx4EDl5Yd9M4Nk1XjkwyoMizldD
	 muQqzHi3Mf5fbvq/Gy7m2Idm3tPgObuzN1km3ZSZkh7rW24eYdLSX41e+IAHkwRnG7
	 g/I/DrpgHad3VVIO3LWlyIJ0hy4UefQ/88lxbEphdhMSKYCoWYhGixnXRO+XmaVC5H
	 KpBTWfcA9NIUxVJmYnU84LnD4K+KUFY9p2AxuhRW2vGQZTcS7V4oqeP3caEZoLMHt8
	 SxRZrFIdRVj2A==
Message-ID: <665a19a0-47c2-404c-bd2b-482ab51b8f64@kernel.org>
Date: Tue, 31 Mar 2026 23:11:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm: make lazy MMU mode context-aware
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
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
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/26 17:20, Alexander Gordeev wrote:
> On Wed, Mar 25, 2026 at 10:55:23AM +0100, David Hildenbrand (Arm) wrote:
> 
> Hi David,
> 
>>> +/**
>>> + * lazy_mmu_mode_enable_pte() - Enable the lazy MMU mode with parameters
>>
>> You have to be a lot clearer about implications. For example, what
>> happens if we would bail out and not process all ptes? What are the
>> exact semantics.
> 
> The only implication is "only this address/PTE range could be updated
> and that range may span one page table at most".

Probably phrase it stronger. "No ptes outside of this range must be
updated" etc.

> 
> Whether all or portion of PTEs were actually updated is not defined,
> just like in case of lazy_mmu_mode_enable_pte().

Okay, then let's document that.

> 
> Makes sense?
> 

Yes.

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
>>
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
> 
> I will also change arch_enter_lazy_mmu_mode_pte() to
> arch_enter_lazy_mmu_mode_for_pte_range() then.
> 
>>> +}
>>
>> I'm wondering whether that could instead be some optional interface that
>> we trigger after the lazy_mmu_mode_enable. But looking at
> 
> To me just two separate and (as you put it) mouthful names appeal better
> than an optional follow-up interface.

Yes, probably better.

-- 
Cheers,

David
