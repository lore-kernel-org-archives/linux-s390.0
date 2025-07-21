Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DE1DED4C;
	Mon, 21 Jul 2025 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753138822; cv=none; b=PXOH21QCZMTcrzKmL/mM6NgEqCttTrdBH7PH2yyp5jzl3sciMWrWObVesTCpCD7gwS38GWLIhLQwS/pdFxdhM/5QlqsZIDAGCQfccyh8Rd1bb+ZOxEfyM12IKNjMrkm1tqEZzsLJIQcX1aoTht8r6qKK2GsiRpP/qzHD3biwtZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753138822; c=relaxed/simple;
	bh=B65sCoFaiHCK/8GSMjA44vvmKa4nvP6+C+DFiICR3ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZ2tfL1wR4otZJPyM0A/KFFyRsEc/WUBNJYpnD15Yh+kaoI31y6/fU859X7Th/+wmI6z+yjvmsXJUCgARxReMd3mL25tGKZ28TlXxP/9GPnQ3F7Sg9LnHVTtyIKZxFmAiiaZ6mT2UzVga549Eq1s0WT1DKQF6Svn66ooFPVj420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev+4/0T0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev+4/0T0"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-adb2bd27d8bso51550566b.1;
        Mon, 21 Jul 2025 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753138818; x=1753743618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qL9A0aUIl8Uddr//bj642F7utZi72l2outni4topsME=;
        b=Ev+4/0T0VLKjyccLxEQy4M/sX8pkt6SRwLJvRWBILClMrZrQ2+x3OcauWL0PZmZmit
         tRq3mvayfPF9kNVrOGLSxWrr4iuTv85OtE2bkDaQyWcdDTpSYzgkKcdP3VlmQ2PbvDjF
         pwvUKGWJEcDgZhhIV1NCFxzqbGyAfBpskw1p0nyrmMLUI19IOnvRwsrvHBj/ye+1aD8D
         zS8692s7IIyKhFQmeEC4vxZyqAMBlVMNapRXixDxi5AZCT8y4ucyCO5P2ES/A4zb/7w7
         gx445Hn15nqlzGR4+kEUR3pECLnt+jpXoF4OgYpYVziwX+a//RLfdZzOADq2e6EVwHeB
         qYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138818; x=1753743618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qL9A0aUIl8Uddr//bj642F7utZi72l2outni4topsME=;
        b=ErkUYa1/tWq7nrwZlmnBYZwC4AoBk8IVKvAAp+H/hmHXnmjpi7BAz5J/RWBHGv8M6S
         l4eh6ffA6/kGBU+728PUAxeZ/5woP1WZi4PmgZnoENDKgKkKlXwS/cknQOGxu+Sfcwg6
         GKqs+o61WtReNT4BBcmgvoi3R35t/NXnBr6MkaqhUE4r5nHWABLfc+Eof3fPQ1fAbvS3
         ge2G3I0RY7YuesXoMhLAfB0s0TdCttfu6BMDyIFQC/7DRuIYx2zoj41FLzZbU2zOoqJ/
         QkVlFIJ0+9fGrXvtfU20mEzjQNnTiDcuXWn/WuM6SnB6HvJS2FP4BoZYlv+eG6UbrSYU
         +Bjg==
X-Forwarded-Encrypted: i=1; AJvYcCX784jYpsRMXy/WR7OxAluaosmzjJp5prJjxj5cEAFnFtv6UTx1q0w+TI1Mu9Tk4sRpANKVKWuwRTVsIw==@vger.kernel.org, AJvYcCXfzogieMfUdZdREX+jS9I8j8D4NlZIDiAqlwobUyWkAnPf+TEyv3SCxN/kOJ8vVGpN5z9/2kUy7l0QKFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjYHCSo7GMuF89SCmErxLJWZm2N7fnqB5tEELu7HF6bgaBAV/j
	7TjQ6M+ifqW5ernEKhFaBjpLpCyV1JawuIzII+UHwYrePz65E0DLik7K
X-Gm-Gg: ASbGnctGDkKiWtjlolNV8zwvSSaC8u5JLS3Cpe99jHbZ6frdJZqH/TpGErfYHkqtfW5
	owztpURusoo1J0BTprQpl3hpPCsUCg0MujhL5uDZqlb30zdE6+7CHOL0W2BWEu1MlDpA9sPO2DH
	jdiX661Lj2Z5NcikoxxAsvziQ44sUl3lb/lpxqBrKQah6A/inq61WaaJrDn28i+Dw0h/mRaN9uI
	Fn6WLMDeWhyd7D+reaojoX/xbSOXloQXioiPSPFZTIkBDDwu2a6VuvU1yzHgfOoUy6kgTKgbNfp
	Mu16Z+VVjsBFtHxopOg3+jtD8hEDWij0B6T8PUy7vsEWAxAuYhRzNLGw16lSPCKdSo/cgHi+D69
	uQ+eYirIuDCN9V/E6nzWsM29ZS72JS9be6bQu/XChsujw+QagHdkjcEaSaRMelenNFV4E
X-Google-Smtp-Source: AGHT+IHckuXEWvfAMpSzjjL6pEsgi7MWI7yYCMOiqpAqEO5gMn0ATvaVtw0/vmnoItEaOlX4DlEKBQ==
X-Received: by 2002:a17:907:7fa1:b0:ae6:c555:8dbb with SMTP id a640c23a62f3a-ae9c9af98e3mr887526166b.11.1753138817353;
        Mon, 21 Jul 2025 16:00:17 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-142-142.dynamic.sbb.rs. [94.189.142.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d8357sm753164466b.52.2025.07.21.16.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 16:00:16 -0700 (PDT)
Message-ID: <c8b0be89-6c89-46ed-87c3-8905b6ccbbeb@gmail.com>
Date: Tue, 22 Jul 2025 00:59:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] kasan/loongarch: select ARCH_DEFER_KASAN and
 call kasan_init_generic
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-8-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250717142732.292822-8-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:

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
> index d2681272d8f..cf8315f9119 100644
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
> +	if (!kasan_enabled()) {

This doesn't make sense, !kasan_enabled() is compile-time check which is always false here.

>  		return (void *)(kasan_early_shadow_page);
>  	} else {
>  		unsigned long maddr = (unsigned long)addr;
