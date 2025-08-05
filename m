Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179191DE4E5;
	Tue,  5 Aug 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414295; cv=none; b=WcICaYM96TCbEKsseV0exYc7kkg0pVRokVS9HyDv4sg0bSje4Z5SgEtwrDmHnkySN/x/bV52naxhIQl0oEZiYTM0c2s+KtcgKnjB+YGFvYJXdbZblrHAsPjV2DbZ1FokEJC4N5plp9vYbwzkLEJnWMSPcCfnqh+mRyeRk5FYnIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414295; c=relaxed/simple;
	bh=Dp2GyHI4dzctyfp4h46cod7uoopNyhYVZ/lSu2yu7R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTihwvydfC0qNLPhbQc5XAehOc2BrVaUAEoz+Ozk5OzSkduzFsF6y0QhQILKz0jPmPQ1xM/cLWUlEnJVDviWeDuqrC3mAwnSWeSxiX4wGO1O256zlP1sXlKsn77akLVWJ4njgd9CHxoqVE/Lfi7Gj+BBryq6HLYEPMvzJ0CFbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DV8q45Zk; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV8q45Zk"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-332308477easo6581761fa.0;
        Tue, 05 Aug 2025 10:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754414292; x=1755019092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZ2R+1+DK7TrYxovSWYDOowvbSOnIqHJEfLqNkyHn6I=;
        b=DV8q45ZkvUMNCri6ZjyngdhxkZ2rC+bK3lHPcwzVdErPj7YEBK13ABfNtvQxB+kn2Q
         WggFL9OwiZhEiV7mJ18Qg8o+XSZAt+NTTQ0rJOq84ltSMJIsQ9JXaHh1W7/A8K2p86Dq
         GkSOPl1UDR1ifTWfZHAyO0udFQhkZ4DKcgukboHAngxRlIkIM9UExuNl/+SPIU4FxUkQ
         M5kK9F2Llr1QVLNep7XrZ50ygpafY7vAHRdAp5LGWn0blkjsyhCLS4U4TMpcwBK+CQY5
         V+tA+fFiAs9tstTk7XKNxerE3tUx97jWXxmkeazG/LiEHAH5Hjh67VBWdT7EFBkNX7BL
         SwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754414292; x=1755019092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ2R+1+DK7TrYxovSWYDOowvbSOnIqHJEfLqNkyHn6I=;
        b=dellUabMFG9gpX0a9OzReQERHInMiMj6oaV9dCOyPRdZmtdHGZz9CzCYQRVMXdACjd
         P9z4+dZGTYeWNd+pK1WLWAAWPOhKyIvv+hVR0HodWFA5lHu7e6TrOVH4ZF1T6GeYV/SB
         KUcsUP38K4RwZvR7tgtRsNDW/BTvBoh/kKAJgTge+Ej7wwVeL9A8FY4YEJjOtRg3poam
         WSz+8my56fvCUpzisLXIXOl7oa5VOKXOfzVdWQEfJRasRU4TXDSBU2gyTVtNZCDaK72Y
         FzTAz7qNqmIEzOnGezJp9PSofIfaJsFqk82yPGBDP1y9PR/jXBIuQpE21CnGHgXdNVJ8
         iQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCWHnGudijM0oLEsHHYubs+vvh3Jw2IT9atWXE+7dyJ8kUCOBcyGngRuG76PJDfb1U16I63zZdz1EhUegA==@vger.kernel.org, AJvYcCWaJT5WyAdc5BHpqlTSB1LyaCtgFpMvtamyk33WSIGmU+j1Kg/GRLb+20zAiOAqy2ma/frU4/nLOjS87oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZdy97ZH+9/25N2UeA32S+BEf+cZRRWkqmPPNgjHOsPu9B2GOe
	wHGacz3L6g0RUEjNEA+JCIYqLq1EnLvaOZqPIdNCBxD/qXtjgZaHFxyi
X-Gm-Gg: ASbGncudbOD8L72FJPJmyBydXGhxEt097gRdzPqW5oEH2MTK/0z9hnYb6Y/1KD9iFT0
	Pijdg3XucE9zUpv22t0OVIuVsnWYxo/B99A4ELBGezGYV/e0SsePE2RvXGkgg3LPxn2mj2qItpG
	YyP7QMFl9qYuKIo+9sN0ZJQaluyDkKVN69Clr+Av/A2SssYFAUQmszLdbwAtWT/xLG4tinagyOX
	MnikTRFifCMR1gNz8Iq/4hF+qg2AlQe87tXQo/WIUwVKWHWkYga/Xu1eLMEvSJDN/Np+Df+gPoA
	rYcJ+xpQCr2xXYMJuhUrZFzWG9HOLyGDXsNFF7bqxAVWd4lEHT0coXRC/GeFv3bm+Q7bNCfmFr2
	FsyHH8dcgDaI88VeUwkN2wOouS8rlWR79oaBDTOBlnGAberjrFQ==
X-Google-Smtp-Source: AGHT+IFS2HbTLqS5A/HgTtiIoYjwUumHARImAD+oD4FUxoQg3JqtFBL0/dOcC7iWrPVn65io3WaVpA==
X-Received: by 2002:a2e:be24:0:b0:32b:5a24:b9d8 with SMTP id 38308e7fff4ca-33256856534mr14686731fa.8.1754414291879;
        Tue, 05 Aug 2025 10:18:11 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382be4a7sm21072541fa.32.2025.08.05.10.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 10:18:11 -0700 (PDT)
Message-ID: <e15e1012-566f-45a7-81d5-fd504af780da@gmail.com>
Date: Tue, 5 Aug 2025 19:17:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] kasan/loongarch: select ARCH_DEFER_KASAN and call
 kasan_init_generic
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, zhangqing@loongson.cn, chenhuacai@loongson.cn,
 trishalfonso@google.com, davidgow@google.com
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250805142622.560992-1-snovitoll@gmail.com>
 <20250805142622.560992-6-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250805142622.560992-6-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
> LoongArch needs deferred KASAN initialization as it has a custom
> kasan_arch_is_ready() implementation that tracks shadow memory
> readiness via the kasan_early_stage flag.
> 
> Select ARCH_DEFER_KASAN to enable the unified static key mechanism
> for runtime KASAN control. Call kasan_init_generic() which handles
> Generic KASAN initialization and enables the static key.
> 
> Replace kasan_arch_is_ready() with kasan_enabled() and delete the
> flag kasan_early_stage in favor of the unified kasan_enabled()
> interface.
> 
> Note that init_task.kasan_depth = 0 is called after kasan_init_generic(),
> which is different than in other arch kasan_init(). This is left
> unchanged as it cannot be tested.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes in v4:
> - Replaced !kasan_enabled() with !kasan_shadow_initialized() in
>   loongarch which selects ARCH_DEFER_KASAN (Andrey Ryabinin)
> ---
>  arch/loongarch/Kconfig             | 1 +
>  arch/loongarch/include/asm/kasan.h | 7 -------
>  arch/loongarch/mm/kasan_init.c     | 8 ++------
>  3 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index f0abc38c40a..f6304c073ec 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -9,6 +9,7 @@ config LOONGARCH
>  	select ACPI_PPTT if ACPI
>  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>  	select ARCH_BINFMT_ELF_STATE
> +	select ARCH_DEFER_KASAN
>  	select ARCH_DISABLE_KASAN_INLINE
>  	select ARCH_ENABLE_MEMORY_HOTPLUG
>  	select ARCH_ENABLE_MEMORY_HOTREMOVE
> diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
> index 62f139a9c87..0e50e5b5e05 100644
> --- a/arch/loongarch/include/asm/kasan.h
> +++ b/arch/loongarch/include/asm/kasan.h
> @@ -66,7 +66,6 @@
>  #define XKPRANGE_WC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKPRANGE_WC_KASAN_OFFSET)
>  #define XKVRANGE_VC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKVRANGE_VC_KASAN_OFFSET)
>  
> -extern bool kasan_early_stage;
>  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
>  
>  #define kasan_mem_to_shadow kasan_mem_to_shadow
> @@ -75,12 +74,6 @@ void *kasan_mem_to_shadow(const void *addr);
>  #define kasan_shadow_to_mem kasan_shadow_to_mem
>  const void *kasan_shadow_to_mem(const void *shadow_addr);
>  
> -#define kasan_arch_is_ready kasan_arch_is_ready
> -static __always_inline bool kasan_arch_is_ready(void)
> -{
> -	return !kasan_early_stage;
> -}
> -
>  #define addr_has_metadata addr_has_metadata
>  static __always_inline bool addr_has_metadata(const void *addr)
>  {
> diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
> index d2681272d8f..57fb6e98376 100644
> --- a/arch/loongarch/mm/kasan_init.c
> +++ b/arch/loongarch/mm/kasan_init.c
> @@ -40,11 +40,9 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>  #define __pte_none(early, pte) (early ? pte_none(pte) : \
>  ((pte_val(pte) & _PFN_MASK) == (unsigned long)__pa(kasan_early_shadow_page)))
>  
> -bool kasan_early_stage = true;
> -
>  void *kasan_mem_to_shadow(const void *addr)
>  {
> -	if (!kasan_arch_is_ready()) {
> +	if (!kasan_shadow_initialized()) {
>  		return (void *)(kasan_early_shadow_page);
>  	} else {
>  		unsigned long maddr = (unsigned long)addr;
> @@ -298,8 +296,6 @@ void __init kasan_init(void)
>  	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
>  					kasan_mem_to_shadow((void *)KFENCE_AREA_END));
>  
> -	kasan_early_stage = false;
> -

There is a reason for this line to be here.
Your patch will change the result of the follow up kasan_mem_to_shadow() call and
feed the wrong address to kasan_map_populate()


>  	/* Populate the linear mapping */
>  	for_each_mem_range(i, &pa_start, &pa_end) {
>  		void *start = (void *)phys_to_virt(pa_start);
> @@ -329,5 +325,5 @@ void __init kasan_init(void)
>  
>  	/* At this point kasan is fully initialized. Enable error messages */
>  	init_task.kasan_depth = 0;
> -	pr_info("KernelAddressSanitizer initialized.\n");
> +	kasan_init_generic();
>  }

