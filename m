Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A072E267E
	for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169564; cv=none; b=AW5od9J3J5F3AOkfRBbmYbSDwjSr3XJhW+uWeRTY2CuweU6GS+o7lE92WGXsu0S1K7qUm7i0ak70l03cZXQogd7Xm3ntGkOPqD+u32RZbELpCXEwkAqG0VZdwUNaSWXjM/JNDmctkpVNCrIKac1W5LThzsLw41mJkZb01DAJy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169564; c=relaxed/simple;
	bh=7AiqZMlqv6fSBjLMUtNxmDJSBxsbv5usPDhRZ7n7TnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwqRRdGdBd/Y9Uub37OkDOHPh59UiMmWmbLcoaqltNXmJ8rvf+X5u1YHrpkgzZI594LMNp+EFxvP+n8HR4vSs2mpH0XZqs0MgKbkmxDxSKJYDVVdpQEScQLmWZcH2GFMN8BugmPm4vJ+LOSwgpXVTbUwNfuP7uK+QuPE/ODJRp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WzXUHqDP; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzXUHqDP"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso4195a12.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750169560; x=1750774360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF7JLfEW2Ok6RDv3Fa8Oa5+MUVfxwenFDl2rzHccing=;
        b=WzXUHqDPk9BY9CHeP85hUJ/bJ8yyhSTyv9CUBrGBFHGiRdDIe1oGlO84jjQiJLdmrD
         iENjBID+cel54jqG9YPCH2BcW0WtUpTK+3fNXO6mZMUf343UCSEGoMeU+rA6vj9qEQdJ
         5toAUzUhFjLFWvVpeVeyGCJmkbBaIecBQ29tHpL2Aiu0M5/mH832aI3EIdXzplm5QCE7
         XqrOCs+Y29MWyXLB7vcouTRbL45/PNieZcl8FybxjwnmpyNXrB2ue6L1iPoqMMos94Oh
         WhHdFgpW4U6TFSIIgVff4GFcD11BxsvQKEqvf9D240q9p/5Vdqhqu2VBlZGY9jwdjchk
         3X+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169560; x=1750774360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KF7JLfEW2Ok6RDv3Fa8Oa5+MUVfxwenFDl2rzHccing=;
        b=bBi6jOwCpRYvJUUNrVhaccRHBh0E+s5gJt6APuX2hTO2YZleFSvoR7HxikVJHv7XET
         /pKKg3xZSptEBQDJnK9Nkm6OYMgfOeZtfazjEGSGuybYD3GAmO0YidlsZ/jf4tLhtYwv
         +ltZSvTS4cJSsqeKU36gNvAQ1WxkGIhB9cylSOWuuStFSBLZC1kSQfgnsBozWPZfKC1V
         BhYROXT/kdd5FtHgJ5BdTXS60hKmJiF2Y4oMVYpZS7k6LcFap1mDkJV1F4sHpsbb6DOW
         j6CIxuV3Gst2fYK1I+1RxaICfeobUczo2g20VyogJv6d/x5IgQ3snUSO3EVB9lyDNonl
         aPZw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/j290jfmfbdtrRXsdffV0SH7dXHxMoh/sWF+eclMgfKYhekbTusnl1AcIdpX3FPngH2rcRebIJzk@vger.kernel.org
X-Gm-Message-State: AOJu0YwEusq8tMNL21z/8/6kcD71VMk3kehlgmsjqkAFgdPyScQIRv66
	zRgK/of2YK+MABy9c/3+D2XQL2s00Gqzy0ciee0vg1k5LRsiYXkVDLQe4zdMW9vadwwnl7C2bDQ
	8ftZTbkURauwdjXQObiR74rbUDa2BvlwJ2hPKx9/Z
X-Gm-Gg: ASbGnctJZhI4OZQWl5XuAY9itPKxjfPjqawF/I+guDusE9Rv+adDX6sM4jCIy365Sfc
	gU7JDopxpWStW6oMN7z5y80qX6xy3uBd7PRb3SAu08/dWJ0c/ixZsO2a3I2T4IFSIpCG2BMm7x6
	04KyMuegJBn7eYmdfEnwPMzftmCGiLmhS63fEabVsyVdao3BOagvAE5Up38cRfPXsCVdW4zj+ge
	g==
X-Google-Smtp-Source: AGHT+IGnrC0Lj/4j1PDVDiy9Id1Wk89W0aajZnn0jR2i0Q2yO0FHL3VfWMUYzn8i01LXbqpRxOa9nZFhg8zrn6JTpfM=
X-Received: by 2002:a05:6402:696:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-608da361bf3mr266061a12.7.1750169559771; Tue, 17 Jun 2025
 07:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750143986.git.gehao@kylinos.cn> <7b912b54cdc12a3437edbd50dbadfc45545641b7.1750143986.git.gehao@kylinos.cn>
In-Reply-To: <7b912b54cdc12a3437edbd50dbadfc45545641b7.1750143986.git.gehao@kylinos.cn>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 17 Jun 2025 07:12:26 -0700
X-Gm-Features: AX0GCFtZD4t3n_FzjcKaARgJmVBPl-3SI6UzJnMNp39YM1icLGT5jJ4oHkeaUKY
Message-ID: <CAJuCfpHp-TdXhqLN1rNvN+kYkGsvMeKDN6kpWxVwUM_fOKgfvg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm/percpu: Conditionally define _shared_alloc_tag
 via CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-s390@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 12:12=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> Recently discovered this entry while checking kallsyms on ARM64:
> ffff800083e509c0 D _shared_alloc_tag
>
> If ARCH_NEEDS_WEAK_PER_CPU is not defined(it is only defined for
> s390 and alpha architectures), there's no need to statically define
> the percpu variable _shared_alloc_tag.
>
> Therefore, we need to implement isolation for this purpose.
>
> When building the core kernel code for s390 or alpha architectures,
> ARCH_NEEDS_WEAK_PER_CPU remains undefined (as it is gated
> by #if defined(MODULE)). However, when building modules for these
> architectures, the macro is explicitly defined.
>
> Therefore, we remove all instances of ARCH_NEEDS_WEAK_PER_CPU from
> the code and introduced CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU to
> replace the relevant logic. We can now conditionally define the perpcu
> variable _shared_alloc_tag based on CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU=
.
> This allows architectures (such as s390/alpha) that require weak
> definitions for percpu variables in modules to include the definition,
> while others can omit it via compile-time exclusion.
>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  arch/alpha/Kconfig              | 1 +
>  arch/alpha/include/asm/percpu.h | 5 ++---
>  arch/s390/Kconfig               | 1 +
>  arch/s390/include/asm/percpu.h  | 5 ++---
>  include/linux/alloc_tag.h       | 6 +++---
>  include/linux/percpu-defs.h     | 7 ++++---
>  lib/alloc_tag.c                 | 2 ++
>  mm/Kconfig                      | 7 +++++++
>  8 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 109a4cddcd13..80367f2cf821 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -7,6 +7,7 @@ config ALPHA
>         select ARCH_HAS_DMA_OPS if PCI
>         select ARCH_MIGHT_HAVE_PC_PARPORT
>         select ARCH_MIGHT_HAVE_PC_SERIO
> +       select ARCH_MODULE_NEEDS_WEAK_PER_CPU if SMP
>         select ARCH_NO_PREEMPT
>         select ARCH_NO_SG_CHAIN
>         select ARCH_USE_CMPXCHG_LOCKREF
> diff --git a/arch/alpha/include/asm/percpu.h b/arch/alpha/include/asm/per=
cpu.h
> index 6923249f2d49..4383d66341dc 100644
> --- a/arch/alpha/include/asm/percpu.h
> +++ b/arch/alpha/include/asm/percpu.h
> @@ -9,10 +9,9 @@
>   * way above 4G.
>   *
>   * Always use weak definitions for percpu variables in modules.
> + * Therefore, we have enabled CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
> + * in the Kconfig.
>   */
> -#if defined(MODULE) && defined(CONFIG_SMP)
> -#define ARCH_NEEDS_WEAK_PER_CPU
> -#endif
>
>  #include <asm-generic/percpu.h>
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 0c16dc443e2f..b652cb952f31 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -132,6 +132,7 @@ config S390
>         select ARCH_INLINE_WRITE_UNLOCK_IRQ
>         select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
>         select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> +       select ARCH_MODULE_NEEDS_WEAK_PER_CPU
>         select ARCH_STACKWALK
>         select ARCH_SUPPORTS_ATOMIC_RMW
>         select ARCH_SUPPORTS_DEBUG_PAGEALLOC
> diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percp=
u.h
> index 84f6b8357b45..96af7d964014 100644
> --- a/arch/s390/include/asm/percpu.h
> +++ b/arch/s390/include/asm/percpu.h
> @@ -16,10 +16,9 @@
>   * For 64 bit module code, the module may be more than 4G above the
>   * per cpu area, use weak definitions to force the compiler to
>   * generate external references.
> + * Therefore, we have enabled CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
> + * in the Kconfig.
>   */
> -#if defined(MODULE)
> -#define ARCH_NEEDS_WEAK_PER_CPU
> -#endif
>
>  /*
>   * We use a compare-and-swap loop since that uses less cpu cycles than
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 8f7931eb7d16..9ef2633e2c08 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -88,7 +88,7 @@ static inline struct alloc_tag *ct_to_alloc_tag(struct =
codetag *ct)
>         return container_of(ct, struct alloc_tag, ct);
>  }
>
> -#ifdef ARCH_NEEDS_WEAK_PER_CPU
> +#if defined(CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU) && defined(MODULE)
>  /*
>   * When percpu variables are required to be defined as weak, static perc=
pu
>   * variables can't be used inside a function (see comments for DECLARE_P=
ER_CPU_SECTION).
> @@ -102,7 +102,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_al=
loc_tag);
>                 .ct =3D CODE_TAG_INIT,                                   =
         \
>                 .counters =3D &_shared_alloc_tag };
>
> -#else /* ARCH_NEEDS_WEAK_PER_CPU */
> +#else /* CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU && MODULE */
>
>  #ifdef MODULE
>
> @@ -123,7 +123,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_al=
loc_tag);
>
>  #endif /* MODULE */
>
> -#endif /* ARCH_NEEDS_WEAK_PER_CPU */
> +#endif /* CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU && MODULE */
>
>  DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
>                         mem_alloc_profiling_key);
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> index 0aeb0e276a3e..5931fcad9a91 100644
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -63,14 +63,15 @@
>   * 1. The symbol must be globally unique, even the static ones.
>   * 2. Static percpu variables cannot be defined inside a function.
>   *
> - * Archs which need weak percpu definitions should define
> - * ARCH_NEEDS_WEAK_PER_CPU in asm/percpu.h when necessary.
> + * Archs which need weak percpu definitions should set
> + * CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU when necessary.
>   *
>   * To ensure that the generic code observes the above two
>   * restrictions, if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is set weak
>   * definition is used for all cases.
>   */
> -#if defined(ARCH_NEEDS_WEAK_PER_CPU) || defined(CONFIG_DEBUG_FORCE_WEAK_=
PER_CPU)
> +#if defined(CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU) && defined(MODULE) ||=
 \
> +       defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)

Please enclose defined(CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU) &&
defined(MODULE) part of the condition in parentheses.

>  /*
>   * __pcpu_scope_* dummy variable is used to enforce scope.  It
>   * receives the static modifier when it's used in front of
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index c7f602fa7b23..ab0936ebf38e 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -24,8 +24,10 @@ static bool mem_profiling_support;
>
>  static struct codetag_type *alloc_tag_cttype;
>
> +#ifdef CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
>  DEFINE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
>  EXPORT_SYMBOL(_shared_alloc_tag);
> +#endif
>
>  DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
>                         mem_alloc_profiling_key);
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e113f713b493..00514df3eae4 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -929,6 +929,13 @@ config ARCH_SUPPORTS_PUD_PFNMAP
>         def_bool y
>         depends on ARCH_SUPPORTS_HUGE_PFNMAP && HAVE_ARCH_TRANSPARENT_HUG=
EPAGE_PUD
>
> +#
> +# Architectures that always use weak definitions for percpu
> +# variables in modules should set this.
> +#
> +config ARCH_MODULE_NEEDS_WEAK_PER_CPU
> +       bool
> +
>  #
>  # UP and nommu archs use km based percpu allocator
>  #
> --
> 2.25.1
>
