Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A7D211A11
	for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750060758; cv=none; b=RjVQ0kdcd3m9mLfrRlPslO/fvfvCCa6e6WLzXCofEqmF6svfJuiRZnGZ3OpI6j2NvHqdPVhBn2n78m8Gl1nXDAoglAlBEw14evtWJKZnyN+YPyktKYrMB55qfGfNJ8hqaOIM2mjPKjSWtBMZE6HLX2tGEHFsvgiCGvpSJFQ0SMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750060758; c=relaxed/simple;
	bh=ye/cVHUb+/XM06uCV/jYyGRwdVIRV7jYj3qXBZggCI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsW2CrDXAkWFwr41lJNtZZtQzCDnSeocIwzJyY4fzH6pubhIaI/sD6bJRsCoLTaJxmYmh1nOdi5d8Ss5XPNbCBVvaIsBTGf/4po1U0o14tI04UIohnB0/qy4NvH9z04aFrxqsc+mFY2N41qiYHSW6ccFVkyhneEX26QcfbUin6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWb7Pzed; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWb7Pzed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750060755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fEKActVxmDRAhN91Wo9Z5KN9xWUaNtWdA2j7+c1SERk=;
	b=DWb7PzedsaBhRt4FnnLzQqQ4MAeEAvGMUp08oJ/3lAthXVrd1FXHdxzZbSVlJSU7SQwTVb
	ejuJxAE9NjuJko8XkvAdJ2UJzS88/4KQ+AfdkRf2eGdfMUQcrx8WdhVMSe6A/Vn36vsZAF
	Ib5DmIAXfT4hZGIJpt20Ez+P+JBxUe8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-yCK-bCgbM9SlqVYPj2nlUA-1; Mon, 16 Jun 2025 03:59:13 -0400
X-MC-Unique: yCK-bCgbM9SlqVYPj2nlUA-1
X-Mimecast-MFC-AGG-ID: yCK-bCgbM9SlqVYPj2nlUA_1750060752
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso1645514f8f.3
        for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 00:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750060752; x=1750665552;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fEKActVxmDRAhN91Wo9Z5KN9xWUaNtWdA2j7+c1SERk=;
        b=Mypa1LGPE0KFkiIFYBGOnS4iQEGMWuvVadGcbsDpFsVbBwReiQV7IynmMX81Wlqmco
         PPC5DxcHVlBCORFiMp4PV+Fwg1esfjSBaJlyMgGxVl23T3ITUpKwwB6GxMk6oyIrwSvg
         w2IukRn5Eob/dlDHmbbMxZGd/wtLEfO9JQqgThzdJNGzzV/0uCGdT2R0dCAxCM0EVrq+
         V5l6LqbPhlKIEOSWYrHC75BYPpwHWuWjGE4jLBr7cfjgf9QHAMd+M6UUbLZGXipyy94C
         m0yfBAvhlAURYUx6eZrgMPdRspiRcJlxnXn5WuA2hYWjPUmFzYVkuCfdyK4UcsExlebQ
         hsPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi6BcWTMxlCOViBZ6F5GQk1eJvB/piscyQqrImru/rFujemQ5ARy0l2Yl4Tv0VYmn6fQfYorGd4DCj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpvg+6f+i+trgfWUXYC+5Yl6eqGsLXlXrmzVWj8iBQhObIhfnA
	Pgpaq56JMNFGytxPTzI3f50TtymwvykhFiDhvmYDmmB49gmqRkPX23czrthCh0lz1QojuoKJ5u1
	M0Wx0jeAhtVLJfJPQ50BTNJ46vRp30jLy3EdgbQxMZAJ0vG51E0Sb2h+qYVQtYCE=
X-Gm-Gg: ASbGncsYkdPXRjJ6i8YdBuTZusz/Po/FjjFJDQvO8zSwnPbBF1Kk9toHsIhdEBTd+Yc
	syOoFzIleQNmhkd6AzdlPYNjTN7uV4euXvl/NrbpHJ0HG+Uq7X5DbDiYcqw+360SNPD+Lz9NsRV
	dvYh5OYNzjSANPm/BarzGROfXKcPJv1FluCo7XfZa35N1Q239Yv/HHHnQU2yLJWJZN2gtdcgyNi
	zx735C6JlB2UK/zdd4WwOpqakHcWc3oh08qv3xSHq8qmfFxbxXG2UPYys4U0K/nuGyTbYZvxPcE
	TvIASlTJam0mnlXMBdaLjcmxwTZfS14MLzCz/wR82eNWeGsZc/SYo1JsaZGOzy2ZZkTRjtoAazP
	5e4qM+3yH7Pz7dkyBCljzCnPJ4QGdCy9A+ANK/g43hSNm6b8=
X-Received: by 2002:a05:6000:2c0f:b0:3a4:e189:b685 with SMTP id ffacd0b85a97d-3a5723a18c3mr6720250f8f.19.1750060752401;
        Mon, 16 Jun 2025 00:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEltx2SfLsMyoI4NJL3TY/9DF1dwkAQbV+DWN0hBdmEK6JaeMqFoNwZTuy9nepdJUP6p5xtEQ==
X-Received: by 2002:a05:6000:2c0f:b0:3a4:e189:b685 with SMTP id ffacd0b85a97d-3a5723a18c3mr6720223f8f.19.1750060751898;
        Mon, 16 Jun 2025 00:59:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:bd00:949:b5a9:e02a:f265? (p200300d82f25bd000949b5a9e02af265.dip0.t-ipconnect.de. [2003:d8:2f25:bd00:949:b5a9:e02a:f265])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a73966sm10525942f8f.34.2025.06.16.00.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 00:59:11 -0700 (PDT)
Message-ID: <afcdc872-680e-40c6-98d0-6b6a43daedbf@redhat.com>
Date: Mon, 16 Jun 2025 09:59:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: Optimize the ARCH_NEEDS_WEAK_PER_CPU logic for
 s390/alpha architectures
To: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Mike Rapoport <rppt@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <cover.1750040317.git.gehao@kylinos.cn>
 <57e110be6d8387e403b4ef1f3b10714c36afbb51.1750040317.git.gehao@kylinos.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <57e110be6d8387e403b4ef1f3b10714c36afbb51.1750040317.git.gehao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.06.25 04:29, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>

subject is misleading: we are not optimizing anything in this patch, do we?

It should probably be called

"mm/percpu: rename ARCH_NEEDS_WEAK_PER_CPU to MODULE_NEED_WEAK_PER_CPU" 
or sth. like that.

> 
> Recently discovered this entry while checking kallsyms on ARM64:
> ffff800083e509c0 D _shared_alloc_tag
> 
> If ARCH_NEEDS_WEAK_PER_CPU is not defined((it is only defined for

"... is not defined (it is only defined for

> s390 and alpha architectures),there's no need to statically define
> the percpu variable _shared_alloc_tag.
 > > Therefore,we need to implement isolation for this purpose.

In general, throw in a space after "." and "," to make this easier to parse.

> 
> However,currently ARCH_NEEDS_WEAK_PER_CPU is a #define and
> is enclosed within the #if defined(MODULE) conditional block.
> 
> When building the core kernel code for s390 or alpha architectures,
> ARCH_NEEDS_WEAK_PER_CPU remains undefined (as it is gated
> by #if defined(MODULE)).However,when building modules for these
> architectures,the macro is explicitly defined.
> 
> Therefore,we need to make ARCH_NEEDS_WEAK_PER_CPU a Kconfig option.
> And replace all instances of ARCH_NEEDS_WEAK_PER_CPU in the kernel
> code with MODULE_NEEDS_WEAK_PER_CPU,MODULE_NEEDS_WEAK_PER_CPU might
> be a more accurate description,because it was only needed for modules.
> Then,when defining the percpu variable _shared_alloc_tag,wrap it
> with the CONFIG_ARCH_NEEDS_WEAK_PER_CPU condition.
> 
> Therefore, this patch does the following things:

"this patch" should be avoided.

"Therefore, let's ..."

> Add the ARCH_NEEDS_WEAK_PER_CPU option to the mm Kconfig file
> and enable it for the s390 and alpha architectures.
> And replace all instances of ARCH_NEEDS_WEAK_PER_CPU
> in the kernel code with MODULE_NEEDS_WEAK_PER_CPU.

Most of the description here should likely go to patch #2. See below.

> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>   arch/alpha/Kconfig              | 1 +
>   arch/alpha/include/asm/percpu.h | 2 +-
>   arch/s390/Kconfig               | 1 +
>   arch/s390/include/asm/percpu.h  | 2 +-
>   include/linux/alloc_tag.h       | 6 +++---
>   include/linux/percpu-defs.h     | 4 ++--
>   mm/Kconfig                      | 4 ++++
>   7 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 109a4cddcd13..ce9bc842e384 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -7,6 +7,7 @@ config ALPHA
>   	select ARCH_HAS_DMA_OPS if PCI
>   	select ARCH_MIGHT_HAVE_PC_PARPORT
>   	select ARCH_MIGHT_HAVE_PC_SERIO
> +	select ARCH_NEEDS_WEAK_PER_CPU
>   	select ARCH_NO_PREEMPT
>   	select ARCH_NO_SG_CHAIN
>   	select ARCH_USE_CMPXCHG_LOCKREF
> diff --git a/arch/alpha/include/asm/percpu.h b/arch/alpha/include/asm/percpu.h
> index 6923249f2d49..b164d3720e9e 100644
> --- a/arch/alpha/include/asm/percpu.h
> +++ b/arch/alpha/include/asm/percpu.h
> @@ -11,7 +11,7 @@
>    * Always use weak definitions for percpu variables in modules.
>    */
>   #if defined(MODULE) && defined(CONFIG_SMP)
> -#define ARCH_NEEDS_WEAK_PER_CPU
> +#define MODULE_NEEDS_WEAK_PER_CPU
>   #endif
>   
>   #include <asm-generic/percpu.h>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 0c16dc443e2f..716031d22346 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -132,6 +132,7 @@ config S390
>   	select ARCH_INLINE_WRITE_UNLOCK_IRQ
>   	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
>   	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> +	select ARCH_NEEDS_WEAK_PER_CPU
>   	select ARCH_STACKWALK
>   	select ARCH_SUPPORTS_ATOMIC_RMW
>   	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
> diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
> index 84f6b8357b45..0afc7ce9c26f 100644
> --- a/arch/s390/include/asm/percpu.h
> +++ b/arch/s390/include/asm/percpu.h
> @@ -18,7 +18,7 @@
>    * generate external references.
>    */
>   #if defined(MODULE)
> -#define ARCH_NEEDS_WEAK_PER_CPU
> +#define MODULE_NEEDS_WEAK_PER_CPU
>   #endif
>   
>   /*
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 8f7931eb7d16..f349cca0ebed 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -88,7 +88,7 @@ static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
>   	return container_of(ct, struct alloc_tag, ct);
>   }
>   
> -#ifdef ARCH_NEEDS_WEAK_PER_CPU
> +#ifdef MODULE_NEEDS_WEAK_PER_CPU
>   /*
>    * When percpu variables are required to be defined as weak, static percpu
>    * variables can't be used inside a function (see comments for DECLARE_PER_CPU_SECTION).
> @@ -102,7 +102,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
>   		.ct = CODE_TAG_INIT,						\
>   		.counters = &_shared_alloc_tag };
>   
> -#else /* ARCH_NEEDS_WEAK_PER_CPU */
> +#else /* MODULE_NEEDS_WEAK_PER_CPU */
>   
>   #ifdef MODULE
>   
> @@ -123,7 +123,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
>   
>   #endif /* MODULE */
>   
> -#endif /* ARCH_NEEDS_WEAK_PER_CPU */
> +#endif /* MODULE_NEEDS_WEAK_PER_CPU */
>   
>   DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
>   			mem_alloc_profiling_key);
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> index 0aeb0e276a3e..b4ecfc3a7b2b 100644
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -64,13 +64,13 @@
>    * 2. Static percpu variables cannot be defined inside a function.
>    *
>    * Archs which need weak percpu definitions should define
> - * ARCH_NEEDS_WEAK_PER_CPU in asm/percpu.h when necessary.
> + * MODULE_NEEDS_WEAK_PER_CPU in asm/percpu.h when necessary.
>    *
>    * To ensure that the generic code observes the above two
>    * restrictions, if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is set weak
>    * definition is used for all cases.
>    */
> -#if defined(ARCH_NEEDS_WEAK_PER_CPU) || defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
> +#if defined(MODULE_NEEDS_WEAK_PER_CPU) || defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
>   /*
>    * __pcpu_scope_* dummy variable is used to enforce scope.  It
>    * receives the static modifier when it's used in front of
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e113f713b493..2f55cc95cfcb 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -929,6 +929,10 @@ config ARCH_SUPPORTS_PUD_PFNMAP
>   	def_bool y
>   	depends on ARCH_SUPPORTS_HUGE_PFNMAP && HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>   
> +# s390 and alpha should be enabled,see comments for DECLARE_PER_CPU_SECTION
> +config ARCH_NEEDS_WEAK_PER_CPU
> +       bool

I agree with Willy that this commit is not ideal -- in particular the 
"s390 and alpha should be enabled" can get stale easily.

If you want to add a comment, rather give guidance why any architecture 
would want to set this, like:

/* Architectures that XXX should set this. */

XXX to be defined.

But the bigger problem with this patch is that XXX cannot even be 
properly defined, because this patch does not make use of 
CONFIG_ARCH_NEEDS_WEAK_PER_CPU at all.

... that is done in the second patch.


So what you could do is move the actual introduction of 
CONFIG_ARCH_NEEDS_WEAK_PER_CPU to patch #2, where it is actually used, 
and limit this patch to the rename.

Similarly, teak the patch description to reflect only that.

-- 
Cheers,

David / dhildenb

