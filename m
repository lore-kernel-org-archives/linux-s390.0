Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FB15D3;
	Thu,  4 Sep 2025 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946335; cv=none; b=ZZMm4i6xDWliIqJOhw4E8pL1WJvPCyged5hrLmsvhthak2OKNwHI/J9EMmNCPNNvdTf5G8rtzLsJRnrnBMwIvIWxDmZ7lRq1btiskyc8ZXOYf5SUAawewTbEDtFIk0quaP/0CI77Umf3MpHDRTQQN5hdOHFkZ5I9iqaM1kxK14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946335; c=relaxed/simple;
	bh=0U0Dsem90VQQK0B/tIbI+8P9Ceh8zzg7qRZcpK9Fp/0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Us1vVqRG4eMaGjP2X8FUsEXskfQwnDHDQOb3D9jqJ12e2RU77D4Z5tPtBSL06glXXEo6HAOIu7I1dhWNCrrZw5IFLf98V4byGkWSOtxGVj+gszvOeGIcPrRMnAiGaabelN+AzAMzlf7PUYeukGagzuRoZse8N1WjqjjkONaNfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN2QfXZJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN2QfXZJ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4717543ed9so245867a12.3;
        Wed, 03 Sep 2025 17:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756946333; x=1757551133; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M9wjahpjajRVdLTvLPg2jmwGdR+YAWepelf042yY0AY=;
        b=eN2QfXZJfv9zJ7QipqbfOn1DWD2byrkUgXk+EfVv8bvK4cN2oVx6WXQdrVhjPQsRoT
         kk0VU+eueSD5EASHjEB3Ry90GqyzWVq7FeI8qZubVHrWD+hv+eyuM4qLggImY8Hh1mgi
         AzlofWySunR3RALVlGAf9HcYkBJU10JtXQE2trfLZkGVY4hERJKY7EhouNZa82qBwpOE
         IsYWTGC9Yx1kDurMSR/eZodYeQonl6I7+FHiks6+Se3TZ1TU4hWyWSSPcz5XFpuElxVj
         +6fIKw04b698ExrVCfBkzYH3/YG8Qd17qF8bWga5intDkidfonsb7wZa1ZRjRf86XHJD
         T4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756946333; x=1757551133;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9wjahpjajRVdLTvLPg2jmwGdR+YAWepelf042yY0AY=;
        b=sk2331/w5Be6xJKndG+qEcynyDM8zK82iJ/lQzuNQtbgB6WVRVJ5lizo3YyQa2XguK
         rQMM6rn+671jSV/xn6vnVT3Hh0hQmsGlfU4TeSj92GsTLJcNE6dWXoC1OJsf85jzvePV
         8IGkbgH0BE215vhk34b2zVUhiN+5xPd1l00rfVLXNfQLMNU8RmxwXS5NQknUlDEME1ld
         tM1iCWdcxtml0archo68WQXSKbrnokcOmMMYk3oSB4xdWZ0iM5TFScNlWjxqmBUYDZns
         Xq04BeclQaR/nvVs0Y0Ba3uy+wzSJyyB19Hi428dF2apNBiwXnt01F0T6bHJuYv0Xwam
         58LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAfbvcsUB3etZfa+3es25bSVaNurT3QBvfF5kQ9jyKjvHgsnFMZXrYmuGmcsnbUzSx4tLObQG5QBtmmw==@vger.kernel.org, AJvYcCXl6wUYvmXYIJqZrVwEDgrV1pk3vXg47g9l3NEEFtwtFY+xpO51F0Jj3Do2KPPvL9T/o/bwO7tOshdp8DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrjWR/tAqXSmX5u3HXdvj4EGlX+6DYouyz95TMFHpDRJm4LzEw
	kaoetoiMqlrY1xlDmtfTs16SKs+RFAbH9qkmXz78qyddxdMbnzLLIihv
X-Gm-Gg: ASbGncumNlb8V8SxpGfnELG+9kkkLNv06KoGqua3CT8Jtumx66TmCxaGslX1v/rQiwz
	rN4EdiAw9QCSXnDIMu8rcOogOzMAoPg6AMLvHdaAZM70fs0f2Xc9qCc6ZC02cWfd6Z1uSMVeVrl
	KHPLLJMyHwd68ycXoIvPX2HNOZBCL1B8Gs1Ojo1SKOwjFqMoEFnG41DZ27taF2BAsjL5dd8Anuh
	eCZot2dsaX4AaHmpMSOTDcLagM2w3Cezar65a9wAMyeTwfmfIGFECctG1eLa5buCZjqRGg8rGKO
	5bm4jedfxGvTLaU4ZQqB52kyMhwcNkNV8pRRUL5Ry1YLuV3kLv87ywtCE0a7SU3GFVnQfVE0Wt8
	9AymsOqsJFsws+BrEq3tAl0w=
X-Google-Smtp-Source: AGHT+IF8fWb/70JgPLh7N7Xn466vomeY7twFDDtFD6ID6JfG4YJmNgXkQZrYmfFbnlzFyM4OYAuWoQ==
X-Received: by 2002:a17:90b:3811:b0:32b:6145:fa63 with SMTP id 98e67ed59e1d1-32b614601acmr4849866a91.4.1756946333006;
        Wed, 03 Sep 2025 17:38:53 -0700 (PDT)
Received: from dw-tp ([171.76.85.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fb98f9f6asm1185841a12.8.2025.09.03.17.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:38:52 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com, christophe.leroy@csgroup.eu, bhe@redhat.com, hca@linux.ibm.com, andreyknvl@gmail.com, akpm@linux-foundation.org, zhangqing@loongson.cn, chenhuacai@loongson.cn, davidgow@google.com, glider@google.com, dvyukov@google.com, alexghiti@rivosinc.com
Cc: alex@ghiti.fr, agordeev@linux.ibm.com, vincenzo.frascino@arm.com, elver@google.com, kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org, snovitoll@gmail.com
Subject: Re: [PATCH v6 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static key across modes
In-Reply-To: <20250810125746.1105476-2-snovitoll@gmail.com>
Date: Thu, 04 Sep 2025 05:54:04 +0530
Message-ID: <87ldmv6p5n.ritesh.list@gmail.com>
References: <20250810125746.1105476-1-snovitoll@gmail.com> <20250810125746.1105476-2-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Sabyrzhan Tasbolatov <snovitoll@gmail.com> writes:

> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures [1] that need
> to defer KASAN initialization until shadow memory is properly set up,
> and unify the static key infrastructure across all KASAN modes.
>
> [1] PowerPC, UML, LoongArch selects ARCH_DEFER_KASAN.
>
> The core issue is that different architectures haveinconsistent approaches
> to KASAN readiness tracking:
> - PowerPC, LoongArch, and UML arch, each implement own
>   kasan_arch_is_ready()
> - Only HW_TAGS mode had a unified static key (kasan_flag_enabled)
> - Generic and SW_TAGS modes relied on arch-specific solutions or always-on
>     behavior
>
> This patch addresses the fragmentation in KASAN initialization
> across architectures by introducing a unified approach that eliminates
> duplicate static keys and arch-specific kasan_arch_is_ready()
> implementations.
>
> Let's replace kasan_arch_is_ready() with existing kasan_enabled() check,
> which examines the static key being enabled if arch selects
> ARCH_DEFER_KASAN or has HW_TAGS mode support.
> For other arch, kasan_enabled() checks the enablement during compile time.
>
> Now KASAN users can use a single kasan_enabled() check everywhere.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes in v6:
> - Added more details in git commit message
> - Fixed commenting format per coding style in UML (Christophe Leroy)
> - Changed exporting to GPL for kasan_flag_enabled (Christophe Leroy)
> - Converted ARCH_DEFER_KASAN to def_bool depending on KASAN to avoid
>         arch users to have `if KASAN` condition (Christophe Leroy)
> - Forgot to add __init for kasan_init in UML
>
> Changes in v5:
> - Unified patches where arch (powerpc, UML, loongarch) selects
>     ARCH_DEFER_KASAN in the first patch not to break
>     bisectability
> - Removed kasan_arch_is_ready completely as there is no user
> - Removed __wrappers in v4, left only those where it's necessary
>     due to different implementations
>
> Changes in v4:
> - Fixed HW_TAGS static key functionality (was broken in v3)
> - Merged configuration and implementation for atomicity
> ---
>  arch/loongarch/Kconfig                 |  1 +
>  arch/loongarch/include/asm/kasan.h     |  7 ------
>  arch/loongarch/mm/kasan_init.c         |  8 +++----
>  arch/powerpc/Kconfig                   |  1 +
>  arch/powerpc/include/asm/kasan.h       | 12 ----------
>  arch/powerpc/mm/kasan/init_32.c        |  2 +-
>  arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
>  arch/powerpc/mm/kasan/init_book3s_64.c |  6 +----
>  arch/um/Kconfig                        |  1 +
>  arch/um/include/asm/kasan.h            |  5 ++--
>  arch/um/kernel/mem.c                   | 13 ++++++++---
>  include/linux/kasan-enabled.h          | 32 ++++++++++++++++++--------
>  include/linux/kasan.h                  |  6 +++++
>  lib/Kconfig.kasan                      | 12 ++++++++++
>  mm/kasan/common.c                      | 17 ++++++++++----
>  mm/kasan/generic.c                     | 19 +++++++++++----
>  mm/kasan/hw_tags.c                     |  9 +-------
>  mm/kasan/kasan.h                       |  8 ++++++-
>  mm/kasan/shadow.c                      | 12 +++++-----
>  mm/kasan/sw_tags.c                     |  1 +
>  mm/kasan/tags.c                        |  2 +-
>  21 files changed, 106 insertions(+), 70 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 93402a1d9c9f..4730c676b6bf 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -122,6 +122,7 @@ config PPC
>  	# Please keep this list sorted alphabetically.
>  	#
>  	select ARCH_32BIT_OFF_T if PPC32
> +	select ARCH_NEEDS_DEFER_KASAN		if PPC_RADIX_MMU
>  	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
>  	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
>  	select ARCH_ENABLE_MEMORY_HOTPLUG
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index b5bbb94c51f6..957a57c1db58 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -53,18 +53,6 @@
>  #endif
>  
>  #ifdef CONFIG_KASAN
> -#ifdef CONFIG_PPC_BOOK3S_64
> -DECLARE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
> -
> -static __always_inline bool kasan_arch_is_ready(void)
> -{
> -	if (static_branch_likely(&powerpc_kasan_enabled_key))
> -		return true;
> -	return false;
> -}
> -
> -#define kasan_arch_is_ready kasan_arch_is_ready
> -#endif
>  
>  void kasan_early_init(void);
>  void kasan_mmu_init(void);
> diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/init_32.c
> index 03666d790a53..1d083597464f 100644
> --- a/arch/powerpc/mm/kasan/init_32.c
> +++ b/arch/powerpc/mm/kasan/init_32.c
> @@ -165,7 +165,7 @@ void __init kasan_init(void)
>  
>  	/* At this point kasan is fully initialized. Enable error messages */
>  	init_task.kasan_depth = 0;
> -	pr_info("KASAN init done\n");
> +	kasan_init_generic();
>  }
>  
>  void __init kasan_late_init(void)
> diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/kasan/init_book3e_64.c
> index 60c78aac0f63..0d3a73d6d4b0 100644
> --- a/arch/powerpc/mm/kasan/init_book3e_64.c
> +++ b/arch/powerpc/mm/kasan/init_book3e_64.c
> @@ -127,7 +127,7 @@ void __init kasan_init(void)
>  
>  	/* Enable error messages */
>  	init_task.kasan_depth = 0;
> -	pr_info("KASAN init done\n");
> +	kasan_init_generic();
>  }
>  
>  void __init kasan_late_init(void) { }
> diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
> index 7d959544c077..dcafa641804c 100644
> --- a/arch/powerpc/mm/kasan/init_book3s_64.c
> +++ b/arch/powerpc/mm/kasan/init_book3s_64.c
> @@ -19,8 +19,6 @@
>  #include <linux/memblock.h>
>  #include <asm/pgalloc.h>
>  
> -DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
> -
>  static void __init kasan_init_phys_region(void *start, void *end)
>  {
>  	unsigned long k_start, k_end, k_cur;
> @@ -92,11 +90,9 @@ void __init kasan_init(void)
>  	 */
>  	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
>  
> -	static_branch_inc(&powerpc_kasan_enabled_key);
> -
>  	/* Enable error messages */
>  	init_task.kasan_depth = 0;
> -	pr_info("KASAN init done\n");
> +	kasan_init_generic();
>  }
>  

Only book3s64 needs static keys here because of radix v/s hash mode
selection during runtime. The changes in above for powerpc looks good to
me. It's a nice cleanup too.

So feel free to take:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> #powerpc

However I have few comments below...

...
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 9142964ab9c9..e3765931a31f 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -32,6 +32,15 @@
>  #include "kasan.h"
>  #include "../slab.h"
>  
> +#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
> +/*
> + * Definition of the unified static key declared in kasan-enabled.h.
> + * This provides consistent runtime enable/disable across KASAN modes.
> + */
> +DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +EXPORT_SYMBOL_GPL(kasan_flag_enabled);
> +#endif
> +
>  struct slab *kasan_addr_to_slab(const void *addr)
>  {
>  	if (virt_addr_valid(addr))
> @@ -246,7 +255,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
>  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>  				unsigned long ip)
>  {
> -	if (!kasan_arch_is_ready() || is_kfence_address(object))
> +	if (is_kfence_address(object))

For changes in mm/kasan/common.c.. you have removed !kasan_enabled()
check at few places. This seems to be partial revert of commit [1]:
  
  b3c34245756ada "kasan: catch invalid free before SLUB reinitializes the object" 

Can you please explain why this needs to be removed? 
Also the explaination of the same should be added in the commit msg too.

[1]: https://lore.kernel.org/all/20240809-kasan-tsbrcu-v8-1-aef4593f9532@google.com/

>  		return false;
>  	return check_slab_allocation(cache, object, ip);
>  }
> @@ -254,7 +263,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>  bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>  		       bool still_accessible)
>  {
> -	if (!kasan_arch_is_ready() || is_kfence_address(object))
> +	if (is_kfence_address(object))
>  		return false;
>  
>  	/*
> @@ -293,7 +302,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>  
>  static inline bool check_page_allocation(void *ptr, unsigned long ip)
>  {
> -	if (!kasan_arch_is_ready())
> +	if (!kasan_enabled())
>  		return false;
>  
>  	if (ptr != page_address(virt_to_head_page(ptr))) {
> @@ -522,7 +531,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
>  		return true;
>  	}
>  
> -	if (is_kfence_address(ptr) || !kasan_arch_is_ready())
> +	if (is_kfence_address(ptr))
>  		return true;
>  
>  	slab = folio_slab(folio);

-ritesh
