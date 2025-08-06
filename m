Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FD2750FE;
	Wed,  6 Aug 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487308; cv=none; b=JaBjDDuXtODQ5CzDLrbhwFRxASzYiTMYzLQugBi0WGs2Lu70DdIjJkvPmUH0NVJ8FoWXSkwILWpPmtIViPVfOI5AMPjik5jGCl8kyZuUPZnBkBfdQOVCiV+XSCNYTSzktqEtusS8MzTwIMX5i7gDteKExqSjp3oxAE+v0tz/sKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487308; c=relaxed/simple;
	bh=4pdWS84KRZO1SXuKgGgyD1aaqPQhqa/LVwQApBfPiyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7Yj6F8X5tL6hzN9EMZgPwIablReKYCmpnHWtekEW5rZKdA+NStw5RHMzLhSC7B7/QqzsOx6toMMYbRinihR2zdTbsZEKENZ7gB9Eo97YUstmMJp1NMRcBbLzVjH5P1GDJzbGi3NohX8gj6lKk7qyRpgv87EPlKkjX0KGrb1f/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJRKyXVC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJRKyXVC"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b9dfd4020so642105e87.2;
        Wed, 06 Aug 2025 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754487304; x=1755092104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkBywKSK+jarcaDEWkMpZ6690o3qyLvHV2Ljs5N+BnY=;
        b=MJRKyXVCh0SF/8Fy904H0EaxJhr99pqiIcHWziSSDlvBROjGuvhD4yKS930sGh6TkH
         VqfoxAJjKm03B2ENfoeEkuPboOu9+qseR65WFhR98Z1Z/5gAIuQMwmNwcssf5jpVqvM7
         IAFQajPwm+Em+cx+z91X9s0ZvW58t7qKZeyNOiNNW5ru4XfWH+fGSUhJLXzkJ6DPlLMK
         rXpZo7f0Hqr5AowQ3a2JCrazPZAXJb1WUlB/5pERqzVDVKeFsYKYXrBRXt3KaCAsHgW7
         tH+Ira4TFTsFGcJq6XRKU9Hxlmti5STmoz/UabeYAoHpvIFLUaDnGHGh8jUHZ2jWJsBv
         qmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754487304; x=1755092104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkBywKSK+jarcaDEWkMpZ6690o3qyLvHV2Ljs5N+BnY=;
        b=RRkxEMrndSGeZWqmeYAIB8oov2GDbNlsjX4f1HxYI74M4w8v9YF6nmky4PJ4HWo2qT
         qPf+AF7PXzWxHtwylX6cM7URjvXRdL1BsdJE2Vd88xMf+0jzAsHeoUoxHiGXX3rlzSpX
         hVhMcKZiVAHnnrQwCrMJ7s6O2nLwfCdFJz+8h/jcT9xs0Qh9vJiWgjO8wGpeD8SSBMkZ
         9eSwFk6nxezZnDJOT5Ng19Mkf9NmviMzbtlbNkUaSMFmdFmvrRwtNzuSXXr7GSn4sJXy
         wYnBK1cbBTa0xGCi/cRX4ua22l8BtWD+S5LzPGSHRn2KCpJo5S1M0Pr0VU0daNntoA8V
         GMpw==
X-Forwarded-Encrypted: i=1; AJvYcCUtxEfql+780Rajto1zU5YhrDoGSsOkUZEjWnkEJWhLBPfP018g5181UQgKLRO5Jm0Hv59hgRMjghXTJr8=@vger.kernel.org, AJvYcCXSWvsYgd1g/HIQ5KMNksqkaZDJukHVzeCQvx5VBznIH8bmlqoQe0OYaDaIACVI66p5jZYI1Ew2DZVWzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8vg1CkROWZnQD9GVLuWOINaudTZ5QE98a/vTQ2PKvA7OhEpgu
	BLC3ZUTiB/UTSKoDTvCcm65uTiKlfBWV2eIIMJkgPVhIvcGPmk1GGdCCxxnilIxc5Is=
X-Gm-Gg: ASbGncuXy+4QUZ+5beK0WBRXRf3q7by843UFd8nJtCTt/vJOnuZyz7EG0dtFusmc0s5
	Ytf0mqaV7ZwQPSRQBxOM5phpOhTLQF6eNbIHM3MQIVhf/ycwrYQJdXpp7dNdYa23IYgZoK/TBqV
	YlD471fKnjlB+Pmm35liVIosHcks98yBH2ZimFou562qgagkBwQ21owm1jDFXrE5FKpHPmAB/dj
	7aptzdtMlGBaFviOG4bUHjskgB725Scwvnv/VUziXPtP+53IuY9q/NGCfd9DMmpiDigI9maL8MO
	N3W3egEBa3wyZIDmhe7PPAJJnBj1QuHtT2Jr6hknBcYLv44IQtDeTeX8OiVg+oPRnKxUB2+v+t9
	bohnDJ+iTCCpHNWXuKcVA1ICa7auO
X-Google-Smtp-Source: AGHT+IG/+xV14jPScIlu8zUGGDD+ajQ7/dFSreWgfNZ5pS9U8lvRiqBw989XNjNOSP9y7GWZ8ScIMA==
X-Received: by 2002:a05:6512:ad1:b0:55a:4d9e:6536 with SMTP id 2adb3069b0e04-55caf2f956dmr417291e87.2.1754487304191;
        Wed, 06 Aug 2025 06:35:04 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8899ebd2sm2302283e87.42.2025.08.06.06.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 06:35:03 -0700 (PDT)
Message-ID: <5a73e633-a374-47f2-a1e1-680e24d9f260@gmail.com>
Date: Wed, 6 Aug 2025 15:34:15 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, zhangqing@loongson.cn, chenhuacai@loongson.cn,
 trishalfonso@google.com, davidgow@google.com
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250805142622.560992-1-snovitoll@gmail.com>
 <20250805142622.560992-2-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250805142622.560992-2-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
> to defer KASAN initialization until shadow memory is properly set up,
> and unify the static key infrastructure across all KASAN modes.
> 
> Some architectures (like PowerPC with radix MMU) need to set up their
> shadow memory mappings before KASAN can be safely enabled, while others
> (like s390, x86, arm) can enable KASAN much earlier or even from the
> beginning.
> 
> Historically, the runtime static key kasan_flag_enabled existed only for
> CONFIG_KASAN_HW_TAGS mode. Generic and SW_TAGS modes either relied on
> architecture-specific kasan_arch_is_ready() implementations or evaluated
> KASAN checks unconditionally, leading to code duplication.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes in v4:
> - Fixed HW_TAGS static key functionality (was broken in v3)

I don't think it fixed. Before you patch kasan_enabled() esentially
worked like this:

 if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))
        return static_branch_likely(&kasan_flag_enabled);
 else
        return IS_ENABLED(CONFIG_KASAN);

Now it's just IS_ENABLED(CONFIG_KASAN);

And there are bunch of kasan_enabled() calls left whose behavior changed for
no reason.


> - Merged configuration and implementation for atomicity
> ---
>  include/linux/kasan-enabled.h | 36 +++++++++++++++++++++++-------
>  include/linux/kasan.h         | 42 +++++++++++++++++++++++++++--------
>  lib/Kconfig.kasan             |  8 +++++++
>  mm/kasan/common.c             | 18 ++++++++++-----
>  mm/kasan/generic.c            | 23 +++++++++++--------
>  mm/kasan/hw_tags.c            |  9 +-------
>  mm/kasan/kasan.h              | 36 +++++++++++++++++++++---------
>  mm/kasan/shadow.c             | 32 ++++++--------------------
>  mm/kasan/sw_tags.c            |  4 +++-
>  mm/kasan/tags.c               |  2 +-
>  10 files changed, 133 insertions(+), 77 deletions(-)
> 
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> index 6f612d69ea0..52a3909f032 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -4,32 +4,52 @@
>  
>  #include <linux/static_key.h>
>  
> -#ifdef CONFIG_KASAN_HW_TAGS
> +/* Controls whether KASAN is enabled at all (compile-time check). */
> +static __always_inline bool kasan_enabled(void)
> +{
> +	return IS_ENABLED(CONFIG_KASAN);
> +}
>  
> +#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
> +/*
> + * Global runtime flag for KASAN modes that need runtime control.
> + * Used by ARCH_DEFER_KASAN architectures and HW_TAGS mode.
> + */
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>  
> -static __always_inline bool kasan_enabled(void)
> +/*
> + * Runtime control for shadow memory initialization or HW_TAGS mode.
> + * Uses static key for architectures that need deferred KASAN or HW_TAGS.
> + */
> +static __always_inline bool kasan_shadow_initialized(void)

Don't rename it, just leave as is - kasan_enabled().
It's better name, shorter and you don't need to convert call sites, so
there is less chance of mistakes due to unchanged kasan_enabled() -> kasan_shadow_initialized().


>  {
>  	return static_branch_likely(&kasan_flag_enabled);
>  }
>  
> -static inline bool kasan_hw_tags_enabled(void)
> +static inline void kasan_enable(void)
> +{
> +	static_branch_enable(&kasan_flag_enabled);
> +}
> +#else
> +/* For architectures that can enable KASAN early, use compile-time check. */
> +static __always_inline bool kasan_shadow_initialized(void)
>  {
>  	return kasan_enabled();
>  }
>  

...

>  
>  void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
> -int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> -void kasan_release_vmalloc(unsigned long start, unsigned long end,
> +
> +int __kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> +static inline int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
> +{
> +	if (!kasan_shadow_initialized())
> +		return 0;


What's the point of moving these checks to header?
Leave it in C, it's easier to grep and navigate code this way.


> +	return __kasan_populate_vmalloc(addr, size);
> +}
> +
> +void __kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			   unsigned long free_region_start,
>  			   unsigned long free_region_end,
>  			   unsigned long flags);
> +static inline void kasan_release_vmalloc(unsigned long start,
> +			   unsigned long end,
> +			   unsigned long free_region_start,
> +			   unsigned long free_region_end,
> +			   unsigned long flags)
> +{
> +	if (kasan_shadow_initialized())
> +		__kasan_release_vmalloc(start, end, free_region_start,
> +			   free_region_end, flags);
> +}
>  

...> @@ -250,7 +259,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
>  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>  				unsigned long ip)
>  {
> -	if (!kasan_arch_is_ready() || is_kfence_address(object))
> +	if (is_kfence_address(object))
>  		return false;
>  	return check_slab_allocation(cache, object, ip);
>  }
> @@ -258,7 +267,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>  bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>  		       bool still_accessible)
>  {
> -	if (!kasan_arch_is_ready() || is_kfence_address(object))
> +	if (is_kfence_address(object))
>  		return false;
>  
>  	poison_slab_object(cache, object, init, still_accessible);
> @@ -282,9 +291,6 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>  
>  static inline bool check_page_allocation(void *ptr, unsigned long ip)
>  {
> -	if (!kasan_arch_is_ready())
> -		return false;
> -


Well, you can't do this yet, because no arch using ARCH_DEFER_KASAN yet, so this breaks
bisectability.
Leave it, and remove with separate patch only when there are no users left.

>  	if (ptr != page_address(virt_to_head_page(ptr))) {
>  		kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_FREE);
>  		return true;
> @@ -511,7 +517,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
>  		return true;
>  	}
>  
> -	if (is_kfence_address(ptr) || !kasan_arch_is_ready())
> +	if (is_kfence_address(ptr))
>  		return true;
>  
>  	slab = folio_slab(folio);


