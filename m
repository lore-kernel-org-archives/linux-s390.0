Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405C2C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 25 Nov 2021 16:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbhKYQW5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356312AbhKYQU4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 Nov 2021 11:20:56 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A64EC0619FF;
        Thu, 25 Nov 2021 08:07:25 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c3so8112608iob.6;
        Thu, 25 Nov 2021 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShBwsoBhPdOA1WTiDFm7VC0m3oxnPMz059B7sCZmM1Y=;
        b=jRJnFJtnaBTxds5pMGmXdxketR6XAv3tNgA4YkjAGLQpoUBFmw5UXvp8sS+C6Cih7p
         PFig+85wUAKPKG209i/CQUujXZialPTDnHOCgtGAp616Ivgbaw0TyPMr0b8o7bKlw3R6
         WOV9oIm85CnZtwHR8sHgNX8OvDI0BWPJY4GHr6664TYOySWLeHVxQxSumJ+HYiqkRD18
         6TKPWbdC409gtNqp9cUX69/eR4MV3fNGJIi84sgcdk7oyBLZ6TbowoHY99b+xr8EcZiN
         ZlzdxySKYxnDWrAUE6qB4E+xzWYL7r6geFoEaXUusjC5ofXncvw+UQq4NX3n3VN5Q/VT
         HC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShBwsoBhPdOA1WTiDFm7VC0m3oxnPMz059B7sCZmM1Y=;
        b=jCqpWm7sYWRV0/OwNWSOjodCbYz6F9Uj3z4aBnZNsbxT6sDww092hTUmGwKeI9pifN
         pkOONFTFSJ0u7vkhZWx9M1uWfd1jruhCPnLzK3WCVkCOneRAGAcX4e1U0fOlr0ZM5OEw
         +sCnPrxJwy4KDhrmO/bF/lb9fY5WUSaYU2KNAmbZa4Kd61DiFg33KXfOtbeKutWjAm29
         A1Jca1xOYwy8NF+eoH3ln7kZiDr90MbKmzTyeOJLKzHul2f5Wodj80wi/n3WsSTK5YvC
         BAlhdJlgJn2A4uLH2bgukmhz44YbuqVe3OQIRkAtFobHDqhRAoETVBpoSfnFYg5YThVP
         5YEw==
X-Gm-Message-State: AOAM531PCh36KYY5J93mC9FKIy8vCkW3UXPO5tXah4Gc6GK0QcGy6lt8
        cnsCJM4fjI9VgAEMm21qfywWN+IGdbN/ox0/cX8=
X-Google-Smtp-Source: ABdhPJzjoxM3AI45QXLfP/Lc/7OjF590zweLS/9VrMQo94I+CZcP8AkNmq5cGvHi+LL/wK5NECG8hERSNJrFaNnWdBM=
X-Received: by 2002:a02:7053:: with SMTP id f80mr29604175jac.28.1637856443318;
 Thu, 25 Nov 2021 08:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20211125080307.27225-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20211125080307.27225-1-wangkefeng.wang@huawei.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 25 Nov 2021 17:07:12 +0100
Message-ID: <CA+fCnZcnwJHUQq34VuRxpdoY6_XbJCDJ-jopksS5Eia4PijPzw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Defer kmemleak object creation of module_alloc()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 25, 2021 at 8:52 AM 'Kefeng Wang' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Yongqiang reports a kmemleak panic when module insmod/rmmod
> with KASAN enabled(without KASAN_VMALLOC) on x86[1].
>
> When the module area allocates memory, it's kmemleak_object
> is created successfully, but the KASAN shadow memory of module
> allocation is not ready, so when kmemleak scan the module's
> pointer, it will panic due to no shadow memory with KASAN check.
>
> module_alloc
>   __vmalloc_node_range
>     kmemleak_vmalloc
>                                 kmemleak_scan
>                                   update_checksum
>   kasan_module_alloc
>     kmemleak_ignore
>
> Note, there is no problem if KASAN_VMALLOC enabled, the modules
> area entire shadow memory is preallocated. Thus, the bug only
> exits on ARCH which supports dynamic allocation of module area
> per module load, for now, only x86/arm64/s390 are involved.
>
>
> Add a VM_DEFER_KMEMLEAK flags, defer vmalloc'ed object register
> of kmemleak in module_alloc() to fix this issue.
>
> [1] https://lore.kernel.org/all/6d41e2b9-4692-5ec4-b1cd-cbe29ae89739@huawei.com/
>
> Fixes: 793213a82de4 ("s390/kasan: dynamic shadow mem allocation for modules")
> Fixes: 39d114ddc682 ("arm64: add KASAN support")
> Fixes: bebf56a1b176 ("kasan: enable instrumentation of global variables")
> Reported-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> V4:
> - add fix tag
> - fix missing change about VM_DELAY_KMEMLEAK
> v3:
> - update changelog to add more explanation
> - use DEFER instead of DELAY sugguested by Catalin.
> v2:
> - fix type error on changelog and kasan_module_alloc()
>
>  arch/arm64/kernel/module.c | 4 ++--
>  arch/s390/kernel/module.c  | 5 +++--
>  arch/x86/kernel/module.c   | 7 ++++---
>  include/linux/kasan.h      | 4 ++--
>  include/linux/vmalloc.h    | 7 +++++++
>  mm/kasan/shadow.c          | 9 +++++++--
>  mm/vmalloc.c               | 3 ++-
>  7 files changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index b5ec010c481f..309a27553c87 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -36,7 +36,7 @@ void *module_alloc(unsigned long size)
>                 module_alloc_end = MODULES_END;
>
>         p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
> -                               module_alloc_end, gfp_mask, PAGE_KERNEL, 0,
> +                               module_alloc_end, gfp_mask, PAGE_KERNEL, VM_DEFER_KMEMLEAK,
>                                 NUMA_NO_NODE, __builtin_return_address(0));
>
>         if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
> @@ -58,7 +58,7 @@ void *module_alloc(unsigned long size)
>                                 PAGE_KERNEL, 0, NUMA_NO_NODE,
>                                 __builtin_return_address(0));
>
> -       if (p && (kasan_module_alloc(p, size) < 0)) {
> +       if (p && (kasan_module_alloc(p, size, gfp_mask) < 0)) {
>                 vfree(p);
>                 return NULL;
>         }
> diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> index b01ba460b7ca..d52d85367bf7 100644
> --- a/arch/s390/kernel/module.c
> +++ b/arch/s390/kernel/module.c
> @@ -37,14 +37,15 @@
>
>  void *module_alloc(unsigned long size)
>  {
> +       gfp_t gfp_mask = GFP_KERNEL;
>         void *p;
>
>         if (PAGE_ALIGN(size) > MODULES_LEN)
>                 return NULL;
>         p = __vmalloc_node_range(size, MODULE_ALIGN, MODULES_VADDR, MODULES_END,
> -                                GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> +                                gfp_mask, PAGE_KERNEL_EXEC, VM_DEFER_KMEMLEAK, NUMA_NO_NODE,
>                                  __builtin_return_address(0));
> -       if (p && (kasan_module_alloc(p, size) < 0)) {
> +       if (p && (kasan_module_alloc(p, size, gfp_mask) < 0)) {
>                 vfree(p);
>                 return NULL;
>         }
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index 169fb6f4cd2e..95fa745e310a 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -67,6 +67,7 @@ static unsigned long int get_module_load_offset(void)
>
>  void *module_alloc(unsigned long size)
>  {
> +       gfp_t gfp_mask = GFP_KERNEL;
>         void *p;
>
>         if (PAGE_ALIGN(size) > MODULES_LEN)
> @@ -74,10 +75,10 @@ void *module_alloc(unsigned long size)
>
>         p = __vmalloc_node_range(size, MODULE_ALIGN,
>                                     MODULES_VADDR + get_module_load_offset(),
> -                                   MODULES_END, GFP_KERNEL,
> -                                   PAGE_KERNEL, 0, NUMA_NO_NODE,
> +                                   MODULES_END, gfp_mask,
> +                                   PAGE_KERNEL, VM_DEFER_KMEMLEAK, NUMA_NO_NODE,
>                                     __builtin_return_address(0));
> -       if (p && (kasan_module_alloc(p, size) < 0)) {
> +       if (p && (kasan_module_alloc(p, size, gfp_mask) < 0)) {
>                 vfree(p);
>                 return NULL;
>         }
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index d8783b682669..89c99e5e67de 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -474,12 +474,12 @@ static inline void kasan_populate_early_vm_area_shadow(void *start,
>   * allocations with real shadow memory. With KASAN vmalloc, the special
>   * case is unnecessary, as the work is handled in the generic case.
>   */
> -int kasan_module_alloc(void *addr, size_t size);
> +int kasan_module_alloc(void *addr, size_t size, gfp_t gfp_mask);
>  void kasan_free_shadow(const struct vm_struct *vm);
>
>  #else /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
>
> -static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
> +static inline int kasan_module_alloc(void *addr, size_t size, gfp_t gfp_mask) { return 0; }
>  static inline void kasan_free_shadow(const struct vm_struct *vm) {}
>
>  #endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 6e022cc712e6..506fc6e6a126 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -28,6 +28,13 @@ struct notifier_block;               /* in notifier.h */
>  #define VM_MAP_PUT_PAGES       0x00000200      /* put pages and free array in vfree */
>  #define VM_NO_HUGE_VMAP                0x00000400      /* force PAGE_SIZE pte mapping */
>
> +#if defined(CONFIG_KASAN) && (defined(CONFIG_KASAN_GENERIC) || \
> +       defined(CONFIG_KASAN_SW_TAGS)) && !defined(CONFIG_KASAN_VMALLOC)
> +#define VM_DEFER_KMEMLEAK      0x00000800      /* defer kmemleak object creation */
> +#else
> +#define VM_DEFER_KMEMLEAK      0
> +#endif

No need for CONFIG_KASAN check: CONFIG_KASAN_GENERIC ||
CONFIG_KASAN_SW_TAGS implies CONFIG_KASAN.



> +
>  /*
>   * VM_KASAN is used slightly differently depending on CONFIG_KASAN_VMALLOC.
>   *
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
>         void *ret;
>         size_t scaled_size;
> @@ -520,9 +520,14 @@ int kasan_module_alloc(void *addr, size_t size)
>                         __builtin_return_address(0));
>
>         if (ret) {
> +               struct vm_struct *vm = find_vm_area(addr);
>                 __memset(ret, KASAN_SHADOW_INIT, shadow_size);
> -               find_vm_area(addr)->flags |= VM_KASAN;
> +               vm->flags |= VM_KASAN;
>                 kmemleak_ignore(ret);
> +
> +               if (vm->flags & VM_DEFER_KMEMLEAK)
> +                       kmemleak_vmalloc(vm, size, gfp_mask);
> +
>                 return 0;
>         }
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d2a00ad4e1dd..bf3c2fe8f528 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3074,7 +3074,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>         clear_vm_uninitialized_flag(area);
>
>         size = PAGE_ALIGN(size);
> -       kmemleak_vmalloc(area, size, gfp_mask);
> +       if (!(vm_flags & VM_DEFER_KMEMLEAK))
> +               kmemleak_vmalloc(area, size, gfp_mask);
>
>         return addr;
>
> --
> 2.26.2
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20211125080307.27225-1-wangkefeng.wang%40huawei.com.
