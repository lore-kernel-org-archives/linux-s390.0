Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18D0C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 23 Nov 2021 19:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhKWTry (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234047AbhKWTrx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Nov 2021 14:47:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FE6160F26;
        Tue, 23 Nov 2021 19:44:39 +0000 (UTC)
Date:   Tue, 23 Nov 2021 19:44:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Yongqiang Liu <liuyongqiang13@huawei.com>
Subject: Re: [PATCH v2] mm: Delay kmemleak object creation of module_alloc()
Message-ID: <YZ1Eo2m3VKZTfthA@arm.com>
References: <20211123143220.134361-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123143220.134361-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 23, 2021 at 10:32:20PM +0800, Kefeng Wang wrote:
> Yongqiang reports a kmemleak panic when module insmod/rmmod with KASAN
> enabled on x86[1].
> 
> When the module allocates memory, it's kmemleak_object is created successfully,
> but the KASAN shadow memory of module allocation is not ready, so when kmemleak
> scan the module's pointer, it will panic due to no shadow memory with KASAN.
> 
> module_alloc
>   __vmalloc_node_range
>     kmemleak_vmalloc
> 				kmemleak_scan
> 				  update_checksum
>   kasan_module_alloc
>     kmemleak_ignore

Can you share the .config and the stack trace you get on arm64?

I have a suspicion there is no problem if KASAN_VMALLOC is enabled.

> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 4a4929b29a23..2ade2f484562 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -498,7 +498,7 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  
>  #else /* CONFIG_KASAN_VMALLOC */
>  
> -int kasan_module_alloc(void *addr, size_t size)
> +int kasan_module_alloc(void *addr, size_t size, gfp_t gfp_mask)
>  {
>  	void *ret;
>  	size_t scaled_size;
> @@ -520,9 +520,14 @@ int kasan_module_alloc(void *addr, size_t size)
>  			__builtin_return_address(0));
>  
>  	if (ret) {
> +		struct vm_struct *vm = find_vm_area(addr);
>  		__memset(ret, KASAN_SHADOW_INIT, shadow_size);
> -		find_vm_area(addr)->flags |= VM_KASAN;
> +		vm->flags |= VM_KASAN;
>  		kmemleak_ignore(ret);
> +
> +		if (vm->flags & VM_DELAY_KMEMLEAK)
> +			kmemleak_vmalloc(vm, size, gfp_mask);
> +
>  		return 0;
>  	}

This function only exists if CONFIG_KASAN_VMALLOC=n.

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d2a00ad4e1dd..23c595b15839 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3074,7 +3074,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	clear_vm_uninitialized_flag(area);
>  
>  	size = PAGE_ALIGN(size);
> -	kmemleak_vmalloc(area, size, gfp_mask);
> +	if (!(vm_flags & VM_DELAY_KMEMLEAK))
> +		kmemleak_vmalloc(area, size, gfp_mask);

So with KASAN_VMALLOC enabled, we'll miss the kmemleak allocation.

You could add an IS_ENABLED(CONFIG_KASAN_VMALLOC) check but I'm not
particularly fond of the delay approach (also think DEFER is probably a
better name).

A quick fix would be to make KMEMLEAK depend on !KASAN || KASAN_VMALLOC.
We'll miss KASAN_SW_TAGS with kmemleak but I think vmalloc support could
be enabled for this as well.

What does KASAN do with other vmalloc() allocations when !KASAN_VMALLOC?
Can we not have a similar approach. I don't fully understand why the
module vmalloc() is a special case.

-- 
Catalin
