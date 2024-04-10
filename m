Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230661779B4
	for <linux-s390@vger.kernel.org>; Wed, 10 Apr 2024 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770132; cv=none; b=ciCLFkhfaB9vV4bZuovhQIa7M4tNUy14KxEXCccy9h94awaUMOr1pWW5r49x802RBBfo0KH23rP5RUF02mRF8LXEDsZohijwSzKO10dWkRTYrOBqqGYCQVIsnCH1509yPWpkY31pCSa1CT5TVyDuXVSC5Lvye9M30CVLRKX1lqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770132; c=relaxed/simple;
	bh=ETnQirs5fRm8m7RdYtYH9GJ6zgGe/Rx2orEadgmxkgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNYzycT/Cbn065Q4qCwGQKxjVBTXxbJAzqUwMz9baTzdmOMOoLIerzCGnFV6ilWhFBgDwD12v8a9hCuVw3ziJTHsoWrV84zMK63GvC+l81zlmOQDewryONp4ejz3s8Kyeb09mvHqDalLqnLQa0wYoHC2XwVAFVPrNIHz2a/chik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 376E7C0004;
	Wed, 10 Apr 2024 17:28:36 +0000 (UTC)
Message-ID: <3493a2f4-9cae-4773-a6a1-2eeb2d23f0c8@ghiti.fr>
Date: Wed, 10 Apr 2024 19:28:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] riscv: mm: accelerate pagefault when badaccess
Content-Language: en-US
To: Kefeng Wang <wangkefeng.wang@huawei.com>, akpm@linux-foundation.org
Cc: Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 surenb@google.com, linux-mm@kvack.org
References: <20240403083805.1818160-1-wangkefeng.wang@huawei.com>
 <20240403083805.1818160-6-wangkefeng.wang@huawei.com>
 <8fe1a53f-f031-4423-97e1-28d93d0cd59e@ghiti.fr>
 <ac978061-ce1a-40a4-8b0a-61883b42bea7@huawei.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ac978061-ce1a-40a4-8b0a-61883b42bea7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 10/04/2024 10:07, Kefeng Wang wrote:
>
>
> On 2024/4/10 15:32, Alexandre Ghiti wrote:
>> Hi Kefeng,
>>
>> On 03/04/2024 10:38, Kefeng Wang wrote:
>>> The access_error() of vma already checked under per-VMA lock, if it
>>> is a bad access, directly handle error, no need to retry with mmap_lock
>>> again. Since the page faut is handled under per-VMA lock, count it as
>>> a vma lock event with VMA_LOCK_SUCCESS.
>>>
>>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>   arch/riscv/mm/fault.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
>>> index 3ba1d4dde5dd..b3fcf7d67efb 100644
>>> --- a/arch/riscv/mm/fault.c
>>> +++ b/arch/riscv/mm/fault.c
>>> @@ -292,7 +292,10 @@ void handle_page_fault(struct pt_regs *regs)
>>>       if (unlikely(access_error(cause, vma))) {
>>>           vma_end_read(vma);
>>> -        goto lock_mmap;
>>> +        count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>>> +        tsk->thread.bad_cause = SEGV_ACCERR;
>>
>>
>> I think we should use the cause variable here instead of SEGV_ACCERR, 
>> as bad_cause is a riscv internal status which describes the real 
>> fault that happened.
>
> Oh, I see, it is exception causes on riscv, so it should be
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index b3fcf7d67efb..5224f3733802 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -293,8 +293,8 @@ void handle_page_fault(struct pt_regs *regs)
>         if (unlikely(access_error(cause, vma))) {
>                 vma_end_read(vma);
>                 count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> -               tsk->thread.bad_cause = SEGV_ACCERR;
> -               bad_area_nosemaphore(regs, code, addr);
> +               tsk->thread.bad_cause = cause;
> +               bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
>                 return;
>         }
>
> Hi Alex, could you help to check it?
>
> Hi Andrew, please help to squash it after Alex ack it.
>
> Thanks both.


So I have just tested Kefeng's fixup on my usual CI and with a simple 
program that triggers such bad access, everything went fine so with the 
fixup applied:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex



>
>
>>
>> Thanks,
>>
>> Alex
>>
>>
>>> +        bad_area_nosemaphore(regs, code, addr);
>>> +        return;
>>>       }
>>>       fault = handle_mm_fault(vma, addr, flags | 
>>> FAULT_FLAG_VMA_LOCK, regs);
