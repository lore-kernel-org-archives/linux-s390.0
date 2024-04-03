Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BB5645
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124824; cv=none; b=hL7yrbNf2IqJuFquLo3Cl0VIe9VxbZFWS9JKm4H9eYhS/1NvmVs3EUcVqoIASQct2nJaS0LLhWHlXq8SrKZw5Sh4ewupmHC59FvaXuIrzfwxklnxr2sWSXUed/UTvaGZEr69F5GtAOD1p45KLUEuVcKGqw3oNCBc3lkYEOcQrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124824; c=relaxed/simple;
	bh=TXH1iQj8NoW1q2/QIek7F4SFPD1a9Nw5xbFTy4C04NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f6knB+wBLfjmzMWusWxw2uRUW3UXWFLnKpS8ivZHYR8r9IQoSF4FjC375P7xwXkz7EbxAT+KU0JLnUOuOD/M4XRr9yYqCIqg1A8G1gnZWEiC01E5h27iP5WnOF4CYRDD893iqXo6qVUPKxu5AcGlXcRIlXI9zF+dTmDW1tlz3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V8ZBg2jZLz1JB3c;
	Wed,  3 Apr 2024 14:11:23 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id A9A6B1402C7;
	Wed,  3 Apr 2024 14:13:31 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 14:13:30 +0800
Message-ID: <bcfe8e2e-7ca9-44a8-b6ea-f4d9d789cc10@huawei.com>
Date: Wed, 3 Apr 2024 14:13:30 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] arm64: mm: accelerate pagefault when
 VM_FAULT_BADACCESS
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
CC: <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>
References: <20240402075142.196265-1-wangkefeng.wang@huawei.com>
 <20240402075142.196265-3-wangkefeng.wang@huawei.com>
 <CAJuCfpGpKup6AOPY08p35S2S+D4ch5XjEB=FM-n9-kU8dZXS5Q@mail.gmail.com>
 <CAJuCfpHkrwPp0X65BuYS2SKAkWPJDMNWYPDO+Jr4SmuxoCEsZg@mail.gmail.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAJuCfpHkrwPp0X65BuYS2SKAkWPJDMNWYPDO+Jr4SmuxoCEsZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/3 13:30, Suren Baghdasaryan wrote:
> On Tue, Apr 2, 2024 at 10:19 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Tue, Apr 2, 2024 at 12:53 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>
>>> The vm_flags of vma already checked under per-VMA lock, if it is a
>>> bad access, directly set fault to VM_FAULT_BADACCESS and handle error,
>>> no need to lock_mm_and_find_vma() and check vm_flags again, the latency
>>> time reduce 34% in lmbench 'lat_sig -P 1 prot lat_sig'.
>>
>> The change makes sense to me. Per-VMA lock is enough to keep
>> vma->vm_flags stable, so no need to retry with mmap_lock.
>>
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>>
>>> ---
>>>   arch/arm64/mm/fault.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>> index 9bb9f395351a..405f9aa831bd 100644
>>> --- a/arch/arm64/mm/fault.c
>>> +++ b/arch/arm64/mm/fault.c
>>> @@ -572,7 +572,9 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>
>>>          if (!(vma->vm_flags & vm_flags)) {
>>>                  vma_end_read(vma);
>>> -               goto lock_mmap;
>>> +               fault = VM_FAULT_BADACCESS;
>>> +               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>>
>> nit: VMA_LOCK_SUCCESS accounting here seems correct to me but
>> unrelated to the main change. Either splitting into a separate patch
>> or mentioning this additional fixup in the changelog would be helpful.
> 
> The above nit applies to all the patches after this one, so I won't
> comment on each one separately. If you decide to split or adjust the
> changelog please do that for each patch.

I will update the change log for each patch, thank for your review and 
suggestion.

> 
>>
>>> +               goto done;
>>>          }
>>>          fault = handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LOCK, regs);
>>>          if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
>>> --
>>> 2.27.0
>>>
