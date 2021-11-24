Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B26C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 24 Nov 2021 05:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhKXFQC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 24 Nov 2021 00:16:02 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28171 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhKXFQB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 Nov 2021 00:16:01 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HzTcN0v8kz8vYr;
        Wed, 24 Nov 2021 13:11:00 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 13:12:50 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 13:12:50 +0800
Message-ID: <9f25b098-0253-4721-3b91-b7d3a79776c6@huawei.com>
Date:   Wed, 24 Nov 2021 13:12:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] mm: Delay kmemleak object creation of module_alloc()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Yongqiang Liu <liuyongqiang13@huawei.com>
References: <20211123143220.134361-1-wangkefeng.wang@huawei.com>
 <YZ1Eo2m3VKZTfthA@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YZ1Eo2m3VKZTfthA@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 2021/11/24 3:44, Catalin Marinas wrote:
> On Tue, Nov 23, 2021 at 10:32:20PM +0800, Kefeng Wang wrote:
>> Yongqiang reports a kmemleak panic when module insmod/rmmod with KASAN
>> enabled on x86[1].
>>
>> When the module allocates memory, it's kmemleak_object is created successfully,
>> but the KASAN shadow memory of module allocation is not ready, so when kmemleak
>> scan the module's pointer, it will panic due to no shadow memory with KASAN.
>>
>> module_alloc
>>    __vmalloc_node_range
>>      kmemleak_vmalloc
>> 				kmemleak_scan
>> 				  update_checksum
>>    kasan_module_alloc
>>      kmemleak_ignore
> Can you share the .config and the stack trace you get on arm64?

My gcc could not support CC_HAS_KASAN_SW_TAGS, so no repoduced on ARM64

>
> I have a suspicion there is no problem if KASAN_VMALLOC is enabled.

Yes,  if KASAN_VMALLOC enabled, the memory of vmalloc shadow has been 
populated in arch's kasan_init(),

there is no issue. but x86/arm64/s390 support dynamic allocation of 
module area per module load by

kasan_module_alloc(), and this leads the above concurrent issue.

>> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
>> index 4a4929b29a23..2ade2f484562 100644
>> --- a/mm/kasan/shadow.c
>> +++ b/mm/kasan/shadow.c
>> @@ -498,7 +498,7 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>>   
>>   #else /* CONFIG_KASAN_VMALLOC */
>>   
>> -int kasan_module_alloc(void *addr, size_t size)
>> +int kasan_module_alloc(void *addr, size_t size, gfp_t gfp_mask)
>>   {
>>   	void *ret;
>>   	size_t scaled_size;
>> @@ -520,9 +520,14 @@ int kasan_module_alloc(void *addr, size_t size)
>>   			__builtin_return_address(0));
>>   
>>   	if (ret) {
>> +		struct vm_struct *vm = find_vm_area(addr);
>>   		__memset(ret, KASAN_SHADOW_INIT, shadow_size);
>> -		find_vm_area(addr)->flags |= VM_KASAN;
>> +		vm->flags |= VM_KASAN;
>>   		kmemleak_ignore(ret);
>> +
>> +		if (vm->flags & VM_DELAY_KMEMLEAK)
>> +			kmemleak_vmalloc(vm, size, gfp_mask);
>> +
>>   		return 0;
>>   	}
> This function only exists if CONFIG_KASAN_VMALLOC=n.
yes.
>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index d2a00ad4e1dd..23c595b15839 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -3074,7 +3074,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>>   	clear_vm_uninitialized_flag(area);
>>   
>>   	size = PAGE_ALIGN(size);
>> -	kmemleak_vmalloc(area, size, gfp_mask);
>> +	if (!(vm_flags & VM_DELAY_KMEMLEAK))
>> +		kmemleak_vmalloc(area, size, gfp_mask);
> So with KASAN_VMALLOC enabled, we'll miss the kmemleak allocation.

See the definination, if KASAN_VMALLOC enabled, VM_DELAY_KMEMLEAK  is 0, 
so kmemleak allocation

still works.

  
+#if defined(CONFIG_KASAN) && (defined(CONFIG_KASAN_GENERIC) || \
+	defined(CONFIG_KASAN_SW_TAGS)) && !defined(CONFIG_KASAN_VMALLOC)
+#define VM_DELAY_KMEMLEAK	0x00000800	/* delay kmemleak object create */
+#else
+#define VM_DELAY_KMEMLEAK	0
+#endif
+

>
> You could add an IS_ENABLED(CONFIG_KASAN_VMALLOC) check but I'm not
> particularly fond of the delay approach (also think DEFER is probably a
> better name).
Will use DEFER instead.
>
> A quick fix would be to make KMEMLEAK depend on !KASAN || KASAN_VMALLOC.
> We'll miss KASAN_SW_TAGS with kmemleak but I think vmalloc support could
> be enabled for this as well.
>
> What does KASAN do with other vmalloc() allocations when !KASAN_VMALLOC?
> Can we not have a similar approach. I don't fully understand why the
> module vmalloc() is a special case.

Only the shadow of module area is dynamic allocation , this exists on 
ARM64 too.

if no KASAN_VMALLOC, no shadow area for vmalloc,  other vmalloc 
allocation is

no problem. Correct me if I'm wrong.

Thanks.

>
