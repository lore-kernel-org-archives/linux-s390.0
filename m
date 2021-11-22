Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92A1C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 22 Nov 2021 12:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhKVM2r (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:28:47 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15849 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhKVM2r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Nov 2021 07:28:47 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HyRLK6hFsz91H2;
        Mon, 22 Nov 2021 20:25:13 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 20:25:39 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 20:25:38 +0800
Message-ID: <50a584a4-8164-2715-41a4-99468d50a0a0@huawei.com>
Date:   Mon, 22 Nov 2021 20:25:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm: Delay kmemleak object creation of module_alloc()
Content-Language: en-US
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
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
References: <20211122121742.142203-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20211122121742.142203-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 2021/11/22 20:17, Kefeng Wang wrote:
> Yongqiang reports a kmemleak panic when module ismod/rmmod with KASAN
> enabled[1] on x86.
>
> The module allocate memory, and it's kmemleak_object is created successfully,
> but the KASAN shadow memory of module allocation is not ready, when kmemleak
> scan the module's pointer, it will panic due to no shadow memory.
>
> module_alloc
>    __vmalloc_node_range
>      kmemleak_vmalloc
> 				kmemleak_scan
> 				  update_checksum
>    kasan_module_alloc
>      kmemleak_ignore
>
> The bug should exist on ARM64/S390 too, add a VM_DELAY_KMEMLEAK flags, delay
> vmalloc'ed object register of kmemleak in module_alloc().
>
> [1] https://lore.kernel.org/all/6d41e2b9-4692-5ec4-b1cd-cbe29ae89739@huawei.com/
> Reported-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   arch/arm64/kernel/module.c | 4 ++--
>   arch/s390/kernel/module.c  | 5 +++--
>   arch/x86/kernel/module.c   | 7 ++++---
>   include/linux/kasan.h      | 4 ++--
>   include/linux/vmalloc.h    | 7 +++++++
>   mm/kasan/shadow.c          | 9 +++++++--
>   mm/vmalloc.c               | 3 ++-
>   7 files changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index b5ec010c481f..e6da010716d0 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -36,7 +36,7 @@ void *module_alloc(unsigned long size)
>   		module_alloc_end = MODULES_END;
>   
>   	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
> -				module_alloc_end, gfp_mask, PAGE_KERNEL, 0,
> +				module_alloc_end, gfp_mask, PAGE_KERNEL, VM_DELAY_KMEMLEAK,
>   				NUMA_NO_NODE, __builtin_return_address(0));
>   
>   	if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
> @@ -58,7 +58,7 @@ void *module_alloc(unsigned long size)
>   				PAGE_KERNEL, 0, NUMA_NO_NODE,
>   				__builtin_return_address(0));
>   
> -	if (p && (kasan_module_alloc(p, size) < 0)) {
> +	if (p && (kasan_module_alloc(p, size, gfp_mask) < 0)) {
>   		vfree(p);
>   		return NULL;
>   	}
> diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> index b01ba460b7ca..8d66a93562ca 100644
> --- a/arch/s390/kernel/module.c
> +++ b/arch/s390/kernel/module.c
> @@ -37,14 +37,15 @@
>   
>   void *module_alloc(unsigned long size)
>   {
> +	gfp_t gfp_mask = GFP_KERNEL;
>   	void *p;
>   
>   	if (PAGE_ALIGN(size) > MODULES_LEN)
>   		return NULL;
>   	p = __vmalloc_node_range(size, MODULE_ALIGN, MODULES_VADDR, MODULES_END,
> -				 GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> +				 gfp_mask, PAGE_KERNEL_EXEC, VM_DELAY_KMEMLEAK, NUMA_NO_NODE,
>   				 __builtin_return_address(0));
> -	if (p && (kasan_module_alloc(p, size) < 0)) {
> +	if (p && (kasan_module_alloc(p, size, gfp_mask) < 0)) {
>   		vfree(p);
>   		return NULL;
>   	}
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index 169fb6f4cd2e..ff134d0f1ca1 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -67,6 +67,7 @@ static unsigned long int get_module_load_offset(void)
>   
>   void *module_alloc(unsigned long size)
>   {
> +	gfp_t gfp_mask = GFP_KERNEL;
>   	void *p;
>   
>   	if (PAGE_ALIGN(size) > MODULES_LEN)
> @@ -74,10 +75,10 @@ void *module_alloc(unsigned long size)
>   
>   	p = __vmalloc_node_range(size, MODULE_ALIGN,
>   				    MODULES_VADDR + get_module_load_offset(),
> -				    MODULES_END, GFP_KERNEL,
> -				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> +				    MODULES_END, gfp_mask,
> +				    PAGE_KERNEL, VM_DELAY_KMEMLEAK, NUMA_NO_NODE,
>   				    __builtin_return_address(0));
> -	if (p && (kasan_module_alloc(p, size) < 0)) {
> +	if (p && (kasan_module_alloc(p, size, gfp_mask) < 0)) {
>   		vfree(p);
>   		return NULL;
>   	}
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index d8783b682669..89c99e5e67de 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -474,12 +474,12 @@ static inline void kasan_populate_early_vm_area_shadow(void *start,
>    * allocations with real shadow memory. With KASAN vmalloc, the special
>    * case is unnecessary, as the work is handled in the generic case.
>    */
> -int kasan_module_alloc(void *addr, size_t size);
> +int kasan_module_alloc(void *addr, size_t size, gfp_t gfp_mask);
>   void kasan_free_shadow(const struct vm_struct *vm);
>   
>   #else /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
>   
> -static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
> +static inline int kasan_module_alloc(void *addr, size_t size, gfp_t gfp_mask) { return 0; }
>   static inline void kasan_free_shadow(const struct vm_struct *vm) {}
>   
>   #endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 6e022cc712e6..56d2b7828b31 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -28,6 +28,13 @@ struct notifier_block;		/* in notifier.h */
>   #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
>   #define VM_NO_HUGE_VMAP		0x00000400	/* force PAGE_SIZE pte mapping */
>   
> +#if defined(CONFIG_KASAN) && (defined(CONFIG_KASAN_GENERIC) || \
> +	defined(CONFIG_KASAN_SW_TAGS)) && !defined(CONFIG_KASAN_VMALLOC)
> +#define VM_DELAY_KMEMLEAK	0x00000800	/* delay kmemleak object create */
> +#else
> +#define VM_DELAY_KMEMLEAK	0
> +#endif
> +
>   /*
>    * VM_KASAN is used slightly differently depending on CONFIG_KASAN_VMALLOC.
>    *
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 4a4929b29a23..6ca43b43419b 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -498,7 +498,7 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>   
>   #else /* CONFIG_KASAN_VMALLOC */
>   
> -int kasan_module_alloc(void *addr, size_t size)
> +int kasan_module_alloc(void *addr, size_t size, gfp_mask)
>   {
>   	void *ret;
>   	size_t scaled_size;
> @@ -520,9 +520,14 @@ int kasan_module_alloc(void *addr, size_t size)
>   			__builtin_return_address(0));
>   
>   	if (ret) {
> +		struct vm_struct *vm = find_vm_area(addr);
>   		__memset(ret, KASAN_SHADOW_INIT, shadow_size);
> -		find_vm_area(addr)->flags |= VM_KASAN;
> +		vm->flags |= VM_KASAN;
>   		kmemleak_ignore(ret);
> +
> +		if (vm->flags | VM_DELAY_KMEMLEAK)

should    if (vm->flags & VM_DELAY_KMEMLEAK),  let's wait more comments, 
and will update.

> +			kmemleak_vmalloc(vm, size, gfp_mask);
> +
>   		return 0;
>   	}
>   
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d2a00ad4e1dd..23c595b15839 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3074,7 +3074,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>   	clear_vm_uninitialized_flag(area);
>   
>   	size = PAGE_ALIGN(size);
> -	kmemleak_vmalloc(area, size, gfp_mask);
> +	if (!(vm_flags & VM_DELAY_KMEMLEAK))
> +		kmemleak_vmalloc(area, size, gfp_mask);
>   
>   	return addr;
>   
