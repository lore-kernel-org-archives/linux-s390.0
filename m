Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91E13D2BE
	for <linux-s390@vger.kernel.org>; Wed, 10 Apr 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736468; cv=none; b=OviL2hVLBRDSUaMIvNpO8T1mD/Q97rzGzB7/P5nu5G1+gNH/PMJT26rvtocHN/LGEVyjG9JRQGMSGQ2IbMUcDG+1VF0qrohCQ23NPg0Wc79YK9NyZK40ppxkHfTdsLvDYnZLS00gw7QPfqkp+EO6dj/b4x++Te2HMCgn+fed5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736468; c=relaxed/simple;
	bh=J+9jHPPZnaGAqbU9SOun1HNMT3G5kN9OX86Mz4IV5ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JEG/N0ZX83av8x2/Pl/utL1SiE30jBT57x5JP+WDHoHjNGuE10+3sGN1SWbD2LyplKnG4jYOxkatMwRgfc7H0S4sZ7i0mnYd4L+FLLplHkmNc4uU03a5WaRsacpLSYoSmShjQXCD6vkrLv/rRcF7VHrLVH7mMmVYq7mjOiMNsVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VDwQn2tqGz1GGhl;
	Wed, 10 Apr 2024 16:06:57 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D373140154;
	Wed, 10 Apr 2024 16:07:43 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 16:07:42 +0800
Message-ID: <ac978061-ce1a-40a4-8b0a-61883b42bea7@huawei.com>
Date: Wed, 10 Apr 2024 16:07:41 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] riscv: mm: accelerate pagefault when badaccess
Content-Language: en-US
To: Alexandre Ghiti <alex@ghiti.fr>, <akpm@linux-foundation.org>
CC: Russell King <linux@armlinux.org.uk>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <surenb@google.com>, <linux-mm@kvack.org>
References: <20240403083805.1818160-1-wangkefeng.wang@huawei.com>
 <20240403083805.1818160-6-wangkefeng.wang@huawei.com>
 <8fe1a53f-f031-4423-97e1-28d93d0cd59e@ghiti.fr>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <8fe1a53f-f031-4423-97e1-28d93d0cd59e@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/10 15:32, Alexandre Ghiti wrote:
> Hi Kefeng,
> 
> On 03/04/2024 10:38, Kefeng Wang wrote:
>> The access_error() of vma already checked under per-VMA lock, if it
>> is a bad access, directly handle error, no need to retry with mmap_lock
>> again. Since the page faut is handled under per-VMA lock, count it as
>> a vma lock event with VMA_LOCK_SUCCESS.
>>
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   arch/riscv/mm/fault.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
>> index 3ba1d4dde5dd..b3fcf7d67efb 100644
>> --- a/arch/riscv/mm/fault.c
>> +++ b/arch/riscv/mm/fault.c
>> @@ -292,7 +292,10 @@ void handle_page_fault(struct pt_regs *regs)
>>       if (unlikely(access_error(cause, vma))) {
>>           vma_end_read(vma);
>> -        goto lock_mmap;
>> +        count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>> +        tsk->thread.bad_cause = SEGV_ACCERR;
> 
> 
> I think we should use the cause variable here instead of SEGV_ACCERR, as 
> bad_cause is a riscv internal status which describes the real fault that 
> happened.

Oh, I see, it is exception causes on riscv, so it should be

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index b3fcf7d67efb..5224f3733802 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -293,8 +293,8 @@ void handle_page_fault(struct pt_regs *regs)
         if (unlikely(access_error(cause, vma))) {
                 vma_end_read(vma);
                 count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
-               tsk->thread.bad_cause = SEGV_ACCERR;
-               bad_area_nosemaphore(regs, code, addr);
+               tsk->thread.bad_cause = cause;
+               bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
                 return;
         }

Hi Alex, could you help to check it?

Hi Andrew, please help to squash it after Alex ack it.

Thanks both.


> 
> Thanks,
> 
> Alex
> 
> 
>> +        bad_area_nosemaphore(regs, code, addr);
>> +        return;
>>       }
>>       fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, 
>> regs);
