Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2C121ABDD;
	Wed,  6 Aug 2025 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754509922; cv=none; b=Sxfvx2zCAfdZYVppGGp4xYQ/iEZYS3y0tZpGdpBFCWufPlLj74fXmI7zBx9X2ga4Kw4xQdcYA/HXUXqHtmjnZ4+e5w/H+LEn8P1P8G9ad+OsKtmgD/jH+hU1jVg8zPbWykwbMaBELFFKY0TIO3+g2CJBATSIMvHsmceWIsnJgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754509922; c=relaxed/simple;
	bh=OsNLdYEDPWVAYqJM7OPgFhWCLz6bTVMGHKwDcqf2sWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAt9VsiHqSfSr8w5duY9BLC5hNZJ5+pyJKq1219BMb9SWd0dAmRWjFwW/KACdjfM4gvfBYIxXgww1QrF+YjcuZQG+8XQ7xKRSJ7atLWAiMOlHIBaNqOqevDorJrbDJLwj3y/MkBU2YZ+CN4qvzdcek0/tlal6ATUhxQGSdfCKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrA2IT7u; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrA2IT7u"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e684d49270so1372785a.3;
        Wed, 06 Aug 2025 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754509919; x=1755114719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOJUufvksrkNMkhUfUMzFksoWwIudiaNrjydPYTPe/E=;
        b=UrA2IT7ufkialFpuRF8UWqnfv7jSGqsqvJjQJkLjguH8n3xFFPoOuu89gdLZVjzBji
         cT5hUDrbKxS1L0R/rOi0w2UWApwtUKaQTyJIS6MeQUIy9cCknNoQYSpw5xZSouXw+dhI
         0iT68UIxiv1+wz6e8FH/JxhxzdJ17ua3xe++kzUFXZcKj7NZIHR64Mmd9qBB7vL4VdhM
         eBeATxDS+sKHm/sxdYg703M3OMCOflHWKvWIz3ILL2gEZrsEE3Je/Uew802kaSQ7xURY
         sHFnUw8Wt9vw0YT0fUlP3ZJSyToSvp5o4yfDhoEr3FxjqScoxjAaF6AjhvDyXqIvmt5a
         bWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754509919; x=1755114719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOJUufvksrkNMkhUfUMzFksoWwIudiaNrjydPYTPe/E=;
        b=lQbcgpvRXa9z8tr2K/Dfcfwl3VcXjZXVmBI5/qX/7sGxnFSi317d9ZWGxfCOo9/btI
         ZxyUUO4FXTbsLLQdsc4rLNkE+adfNQTqm9UsbqkV9kIv5yhWaZleVQb/ExnLDsrHxgKA
         HM7NAPb7hSJH9GmrdlcWxdsxqiRfCAqOyi8inxM3gLkGmRdcFLHzROSa8FcDpuubIgvc
         b0I9y23dKXQoOegaNFnMX2iPyz4MUC37vaKS0zQwt6zhZGm9hNVTLQHsVl38R2UFx7BM
         RYd3bnoCNwUlnTWCQfY3B8BKxZq4XTyPZbWbja4vSX0Yi+fT8hst441L6/Z4S+V9YPmb
         Pcrg==
X-Forwarded-Encrypted: i=1; AJvYcCVooS9q4oVADQpcVGnGwDhPrNVRBDkCNkEAg4ygFLrBVPq+ONayIiuBy9FAb/JjQ/Gs+S0NvDSj52NgrQ==@vger.kernel.org, AJvYcCWHWVetCjlpdREU7W97CyBodH5Gmw2ttfT7TBnhQ0d+5QCC8Jmsb1I2TEYhiB2MrTgJ/r8aI/QBM38IwjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTGyzqVKdFYxX5gvSW6aATOyciefs4DOMsO7WRrFdEXEWcbw7
	sisVVvDqGFOVJZaKqm4rvT6Ghjceh35UGAPydiXjkLwm9+j5++LGtlel
X-Gm-Gg: ASbGncv25hd/OM+3v8U4QFAaiyvnUEDGZ4x/UFq9aXYS12h7WS3PBwsFwZRr+5sJXzH
	A0EzCHcMRwr84PccSfDv1rgJo09ZsHSbSpaNEXW7bhY1knj8kgagSsLxY1mkssXSZpxFkERqxFT
	CMSmhSxRC7QwKgtuZ2kgo+9vgbo5GeZ6qqV3Y//XBK6eKouO7u5B5GjKKnt9/OkCZXLn5DTbeGM
	5fS+/JHP6QUnFvRb+PF9Cf8NrNWVgeC9bKD+x7bVdX46mydepFc0magT1y268/yQpHNh5YozAVr
	Hl+FQADvmjBTcMC67KoBqwTNlz3ZKKo16MKrOA5q6vMFG30Hziy5NLAVc7ZM6DSHzvGt/7wIKD1
	aIB6PSTM4zXqTu5zTsncTd1JK1IBjslxBnBWgKcbAXiLE5T/R1Jk0uAh606Isb+MRyvP5
X-Google-Smtp-Source: AGHT+IFmzUMSDyUQoeXjvqgYHBfr+pQThJ0xtd5NGlSxIHAVfwgMAAXU9ZJsjUzM039DpZsjSBydog==
X-Received: by 2002:a05:620a:1a04:b0:7e2:6be2:38eb with SMTP id af79cd13be357-7e814d64573mr316228785a.4.1754509919359;
        Wed, 06 Aug 2025 12:51:59 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-140-132.dynamic.sbb.rs. [94.189.140.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5c55a2sm866617085a.36.2025.08.06.12.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 12:51:58 -0700 (PDT)
Message-ID: <dd25cb14-5df1-4b2c-bff7-0ca901dfd824@gmail.com>
Date: Wed, 6 Aug 2025 21:51:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
 agordeev@linux.ibm.com, akpm@linux-foundation.org, zhangqing@loongson.cn,
 chenhuacai@loongson.cn, trishalfonso@google.com, davidgow@google.com,
 glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250805142622.560992-1-snovitoll@gmail.com>
 <20250805142622.560992-2-snovitoll@gmail.com>
 <5a73e633-a374-47f2-a1e1-680e24d9f260@gmail.com>
 <CACzwLxg=zC-82sY6f-z0VOnmbpN2E8tQxe7RyOnynpbJEFP+NA@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CACzwLxg=zC-82sY6f-z0VOnmbpN2E8tQxe7RyOnynpbJEFP+NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/6/25 4:15 PM, Sabyrzhan Tasbolatov wrote:
> On Wed, Aug 6, 2025 at 6:35 PM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>
>>
>>
>> On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
>>> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
>>> to defer KASAN initialization until shadow memory is properly set up,
>>> and unify the static key infrastructure across all KASAN modes.
>>>
>>> Some architectures (like PowerPC with radix MMU) need to set up their
>>> shadow memory mappings before KASAN can be safely enabled, while others
>>> (like s390, x86, arm) can enable KASAN much earlier or even from the
>>> beginning.
>>>
>>> Historically, the runtime static key kasan_flag_enabled existed only for
>>> CONFIG_KASAN_HW_TAGS mode. Generic and SW_TAGS modes either relied on
>>> architecture-specific kasan_arch_is_ready() implementations or evaluated
>>> KASAN checks unconditionally, leading to code duplication.
>>>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
>>> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
>>> ---
>>> Changes in v4:
>>> - Fixed HW_TAGS static key functionality (was broken in v3)
>>
>> I don't think it fixed. Before you patch kasan_enabled() esentially
>> worked like this:
>>
>>  if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>>         return static_branch_likely(&kasan_flag_enabled);
>>  else
>>         return IS_ENABLED(CONFIG_KASAN);
>>
>> Now it's just IS_ENABLED(CONFIG_KASAN);
> 
> In v4 it is:
> 
>         #if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
>         static __always_inline bool kasan_shadow_initialized(void)
>         {
>                 return static_branch_likely(&kasan_flag_enabled);
>         }
>         #else
>         static __always_inline bool kasan_shadow_initialized(void)
>         {
>                 return kasan_enabled(); // which is IS_ENABLED(CONFIG_KASAN);
>         }
>         #endif
> 
> So for HW_TAGS, KASAN is enabled in kasan_init_hw_tags().

You are referring to  kasan_shadow_initialized(), but I was talking about kasan_enabled() specifically.
E.g. your patch changes behavior for kasan_init_slab_obj() which doesn't use kasan_shadow_initialized()
 (in the case of HW_TAGS=y && kasan_flag_enabled = false) :

static __always_inline void * __must_check kasan_init_slab_obj(
                                struct kmem_cache *cache, const void *object)
{
        if (kasan_enabled())
                return __kasan_init_slab_obj(cache, object);
        return (void *)object;
}



>>> +#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
>>> +/*
>>> + * Global runtime flag for KASAN modes that need runtime control.
>>> + * Used by ARCH_DEFER_KASAN architectures and HW_TAGS mode.
>>> + */
>>>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>>>
>>> -static __always_inline bool kasan_enabled(void)
>>> +/*
>>> + * Runtime control for shadow memory initialization or HW_TAGS mode.
>>> + * Uses static key for architectures that need deferred KASAN or HW_TAGS.
>>> + */
>>> +static __always_inline bool kasan_shadow_initialized(void)
>>
>> Don't rename it, just leave as is - kasan_enabled().
>> It's better name, shorter and you don't need to convert call sites, so
>> there is less chance of mistakes due to unchanged kasan_enabled() -> kasan_shadow_initialized().
> 
> I actually had the only check "kasan_enabled()" in v2, but went to
> double check approach in v3
> after this comment:
> https://lore.kernel.org/all/CA+fCnZcGyTECP15VMSPh+duLmxNe=ApHfOnbAY3NqtFHZvceZw@mail.gmail.com/

AFAIU the comment suggest that we need two checks/flags, one in kasan_enabled() which checks
whether kasan was enabled via cmdline (currently only for HW_TAGS)
 and one in kasan_arch_is_ready()(or kasan_shadow_initialized()) which checks if arch initialized KASAN.
And this not what v3/v4 does. v4 basically  have one check, just under different name. 

Separate checks might be needed if we have code paths that need 'kasan_arch_is_ready() && !kasan_enabled()'
and vise versa '!kasan_arch_is_ready() && kasan_enabled()'.

From the top of my head, I can't say if we have such cases.

> 
> Ok, we will have the **only** check kasan_enabled() then in
> kasan-enabled.h which
> 
>         #if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
>         static __always_inline bool kasan_enabled(void)
>         {
>                 return static_branch_likely(&kasan_flag_enabled);
>         }
>         #else
>         static inline bool kasan_enabled(void)
>         {
>                 return IS_ENABLED(CONFIG_KASAN);
>         }
> 
> And will remove kasan_arch_is_ready (current kasan_shadow_initialized in v4).
> 
> So it is the single place to check if KASAN is enabled for all arch
> and internal KASAN code.
> Same behavior is in the current mainline code but only for HW_TAGS.
> 
> Is this correct?
> 

Yep, that's what I meant.

>>
>>
>>>  {
>>>       return static_branch_likely(&kasan_flag_enabled);
>>>  }
>>>
>>> -static inline bool kasan_hw_tags_enabled(void)
>>> +static inline void kasan_enable(void)
>>> +{
>>> +     static_branch_enable(&kasan_flag_enabled);
>>> +}
>>> +#else
>>> +/* For architectures that can enable KASAN early, use compile-time check. */
>>> +static __always_inline bool kasan_shadow_initialized(void)
>>>  {
>>>       return kasan_enabled();
>>>  }
>>>
>>
>> ...
>>
>>>
>>>  void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
>>> -int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
>>> -void kasan_release_vmalloc(unsigned long start, unsigned long end,
>>> +
>>> +int __kasan_populate_vmalloc(unsigned long addr, unsigned long size);
>>> +static inline int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
>>> +{
>>> +     if (!kasan_shadow_initialized())
>>> +             return 0;
>>
>>
>> What's the point of moving these checks to header?
>> Leave it in C, it's easier to grep and navigate code this way.
> 
> Andrey Konovalov had comments [1] to avoid checks in C
> by moving them to headers under __wrappers.
> 
> : 1. Avoid spraying kasan_arch_is_ready() throughout the KASAN
> : implementation and move these checks into include/linux/kasan.h (and
> : add __wrappers when required).
> 
> [1] https://lore.kernel.org/all/CA+fCnZcGyTECP15VMSPh+duLmxNe=ApHfOnbAY3NqtFHZvceZw@mail.gmail.com/
> 

I think Andrey K. meant cases when we have multiple implementations of one function for each mode.
In such case it makes sense to merge multiple kasan_arch_is_ready() checks into one in the header.
But in case like with kasan_populate_vmalloc() we have only one implementation so I don't see any
value in adding wrapper/moving to header. 

>>
>>
>>> +     return __kasan_populate_vmalloc(addr, size);
>>> +}
>>> +
>>> +void __kasan_release_vmalloc(unsigned long start, unsigned long end,
>>>                          unsigned long free_region_start,
>>>                          unsigned long free_region_end,
>>>                          unsigned long flags);
>>> +static inline void kasan_release_vmalloc(unsigned long start,
>>> +                        unsigned long end,
>>> +                        unsigned long free_region_start,
>>> +                        unsigned long free_region_end,
>>> +                        unsigned long flags)
>>> +{
>>> +     if (kasan_shadow_initialized())
>>> +             __kasan_release_vmalloc(start, end, free_region_start,
>>> +                        free_region_end, flags);
>>> +}
>>>
>>
>> ...> @@ -250,7 +259,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
>>>  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>>>                               unsigned long ip)
>>>  {
>>> -     if (!kasan_arch_is_ready() || is_kfence_address(object))
>>> +     if (is_kfence_address(object))
>>>               return false;
>>>       return check_slab_allocation(cache, object, ip);
>>>  }
>>> @@ -258,7 +267,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>>>  bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>>>                      bool still_accessible)
>>>  {
>>> -     if (!kasan_arch_is_ready() || is_kfence_address(object))
>>> +     if (is_kfence_address(object))
>>>               return false;
>>>
>>>       poison_slab_object(cache, object, init, still_accessible);
>>> @@ -282,9 +291,6 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>>>
>>>  static inline bool check_page_allocation(void *ptr, unsigned long ip)
>>>  {
>>> -     if (!kasan_arch_is_ready())
>>> -             return false;
>>> -
>>
>>
>> Well, you can't do this yet, because no arch using ARCH_DEFER_KASAN yet, so this breaks
>> bisectability.
>> Leave it, and remove with separate patch only when there are no users left.
> 
> Will do in v5 at the end of patch series.
> 
>>
>>>       if (ptr != page_address(virt_to_head_page(ptr))) {
>>>               kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_FREE);
>>>               return true;
>>> @@ -511,7 +517,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
>>>               return true;
>>>       }
>>>
>>> -     if (is_kfence_address(ptr) || !kasan_arch_is_ready())
>>> +     if (is_kfence_address(ptr))
>>>               return true;
>>>
>>>       slab = folio_slab(folio);
>>
>>

