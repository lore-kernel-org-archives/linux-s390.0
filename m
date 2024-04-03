Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3025BAD7
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131115; cv=none; b=cm4Nv6Vkus81Z1PtoPYMwnjtBHVRD0C9rkxNEV6d/pTv2GvhzZlV1D1aGU2911K0PW+vX9ps2u8sSkSf/AiDmasbrQJqXjcrtfG5cC5DQfmSyIG042Ajg3yo3TR8dodJTbyAiSM3tJo+55+QXwxirB3rJ01cyIJHiD3mKFG9ge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131115; c=relaxed/simple;
	bh=ZHb1qyBfd+eoZoSn4KW7h1lW5l18kh7WGJ0NVJV7P5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JRQAshzQgH9t5HYzQHX9ZYB++6ONgB+lCq9b179cFY6iKz02hmJctYXLlig5qXMt//RvMpSs5nOvMN/6PsSKDZJ9ess0lRRhVBnnDOhZEZJHIa6ZWaR78TPosTiy+JpNsU7MShK4wau7nlZSVU198gOaftgUT7jViYCAKnuTdtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V8cVx6sv3z29lcf;
	Wed,  3 Apr 2024 15:55:37 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 9387D180063;
	Wed,  3 Apr 2024 15:58:23 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 15:58:22 +0800
Message-ID: <d5177b0f-db4e-4c78-81f1-5761f08f076d@huawei.com>
Date: Wed, 3 Apr 2024 15:58:22 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] x86: mm: accelerate pagefault when badaccess
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
 <20240402075142.196265-8-wangkefeng.wang@huawei.com>
 <CAJuCfpFoxP78+P1+4WQcCqMzGv7jpC9V8pR_-R8t8zPUg-t+aA@mail.gmail.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAJuCfpFoxP78+P1+4WQcCqMzGv7jpC9V8pR_-R8t8zPUg-t+aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/3 13:59, Suren Baghdasaryan wrote:
> On Tue, Apr 2, 2024 at 12:53 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> The vm_flags of vma already checked under per-VMA lock, if it is a
>> bad access, directly handle error and return, there is no need to
>> lock_mm_and_find_vma() and check vm_flags again.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Looks safe to me.
> Using (mm != NULL) to indicate that we are holding mmap_lock is not
> ideal but I guess that works.
> 

Yes, I will add this part it into change too,

The access_error() of vma already checked under per-VMA lock, if it
is a bad access, directly handle error, no need to retry with mmap_lock
again. In order to release the correct lock, pass the mm_struct into
bad_area_access_error(), if mm is NULL, release vma lock, or release
mmap_lock. Since the page faut is handled under per-VMA lock, count it
as a vma lock event with VMA_LOCK_SUCCESS.

Thanks.


> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> 
>> ---
>>   arch/x86/mm/fault.c | 23 ++++++++++++++---------
>>   1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index a4cc20d0036d..67b18adc75dd 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -866,14 +866,17 @@ bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>>
>>   static void
>>   __bad_area(struct pt_regs *regs, unsigned long error_code,
>> -          unsigned long address, u32 pkey, int si_code)
>> +          unsigned long address, struct mm_struct *mm,
>> +          struct vm_area_struct *vma, u32 pkey, int si_code)
>>   {
>> -       struct mm_struct *mm = current->mm;
>>          /*
>>           * Something tried to access memory that isn't in our memory map..
>>           * Fix it, but check if it's kernel or user first..
>>           */
>> -       mmap_read_unlock(mm);
>> +       if (mm)
>> +               mmap_read_unlock(mm);
>> +       else
>> +               vma_end_read(vma);
>>
>>          __bad_area_nosemaphore(regs, error_code, address, pkey, si_code);
>>   }
>> @@ -897,7 +900,8 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
>>
>>   static noinline void
>>   bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
>> -                     unsigned long address, struct vm_area_struct *vma)
>> +                     unsigned long address, struct mm_struct *mm,
>> +                     struct vm_area_struct *vma)
>>   {
>>          /*
>>           * This OSPKE check is not strictly necessary at runtime.
>> @@ -927,9 +931,9 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
>>                   */
>>                  u32 pkey = vma_pkey(vma);
>>
>> -               __bad_area(regs, error_code, address, pkey, SEGV_PKUERR);
>> +               __bad_area(regs, error_code, address, mm, vma, pkey, SEGV_PKUERR);
>>          } else {
>> -               __bad_area(regs, error_code, address, 0, SEGV_ACCERR);
>> +               __bad_area(regs, error_code, address, mm, vma, 0, SEGV_ACCERR);
>>          }
>>   }
>>
>> @@ -1357,8 +1361,9 @@ void do_user_addr_fault(struct pt_regs *regs,
>>                  goto lock_mmap;
>>
>>          if (unlikely(access_error(error_code, vma))) {
>> -               vma_end_read(vma);
>> -               goto lock_mmap;
>> +               bad_area_access_error(regs, error_code, address, NULL, vma);
>> +               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>> +               return;
>>          }
>>          fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
>>          if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
>> @@ -1394,7 +1399,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>>           * we can handle it..
>>           */
>>          if (unlikely(access_error(error_code, vma))) {
>> -               bad_area_access_error(regs, error_code, address, vma);
>> +               bad_area_access_error(regs, error_code, address, mm, vma);
>>                  return;
>>          }
>>
>> --
>> 2.27.0
>>
