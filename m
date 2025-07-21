Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D991F4C8D;
	Mon, 21 Jul 2025 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753138828; cv=none; b=VkX0tOksyF3PGtRsADqJtUTzJPgje1VeyGWkM2DW3gkzsVodrNuAXDRL1LWBor3hpermYuNsWtK450CvPoga5Km2Y1U5Wjco0mmN5tjOhlo21mnm9KoYf01qBQfjUA89xwuEz8LzrRloeG3fFLSSyWglAlVmvYK+c/FnDvB3C/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753138828; c=relaxed/simple;
	bh=xTMsJ9+du2bTbDmw13ndPneOXOsiwavi94TF2rx5D0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzeKcDvvuerBbyaQGDpyubmFjCmWkFQHiIvEkvjF9nu/6VuU/akLvA/md8TG8u7hfFVTaCJF/R6CEnK8nAervW+2h/DMiRR/tWcIHV7SSkIoOK4N1oFyxk8d4fCs3eE+2Nlr19fJZHQFdOX0hWIie5NRzlks+9DG+NFdO+ouQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2p1mzXa; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2p1mzXa"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3521a129aso85903766b.3;
        Mon, 21 Jul 2025 16:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753138823; x=1753743623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I50g8CBYTAJgx5jeL63ocp0XmC4ojzYZYl9cwyXAxL0=;
        b=j2p1mzXa1gG9EgaazrGM8iyNeaqkrlMlNr31Qxjt1QGSrA3yjZLKTRgvLqyorl+ihi
         6BpZ26AuH+uJ3J5a94XIpPFTHZbQQ2mzgoC8HNO/HPLTd5nPL1v/qtcnUVT+4p2PSzDy
         c3F172ykRzNm8qz94LCgtXDGuukO469ytZUBblQxh6U4EztkP+2FpGBBmlVjRDvPnRYi
         rDdegF4X5p06MVPax9ODORsTBrsFrCCM5EmNZ3tpWjRSL41TULsNqaL/O5ZO4TOEfo0J
         /R3b+pXPuQYUe6GM5G39qxC9GEVky0CqX681Va76LGoDO+FjlZd4VDvafj15J2/aUnVH
         N0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138823; x=1753743623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I50g8CBYTAJgx5jeL63ocp0XmC4ojzYZYl9cwyXAxL0=;
        b=lfM4Ed3jIJW6NmVLH1OfFIfOYcaczuDXT+vauvR/SL10NL8QQm9pgDy6bGkq+q/dNz
         +Y/QfB5GukDQ7b4wpgxA7vVFEu3Zf5p6lBR3U2+UytNLirKdrn17djE/6cfmVkyHtwve
         O8yAcYZ8cHvtG5ys+iAZWkOc8ykOO0jOD4sn/5R7GASf5B6Gh5wy+kmF3P/MBZvbHWRy
         yYaxN80thZwdzMRqnvLAaSNHXrCiJivgDNt7PFBGnmElgAyW0PAZS5pDLhsT9vfz9LO+
         zyAihnb+lN0CAaOV68do0aI27tecpoMWCSZm2lkcNcf2TOXRhcE29d9upmW++VzlsNRg
         QhRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw9kQtsdMUmj/7RZgDt4+V0sVLNaSXNrS3bD0LBxAQDtqMYQeLdQETKccAzYd5pjQErXzRAE/dXuLM+A==@vger.kernel.org, AJvYcCWYd31zQqF9Jic9wJR2MQa1dUkHAyC8kGW0nCK4fBrlM2gM2cjIq8XFEqsxp1PLYkSSaDnFQk46o6zXy28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQFN9h2jUFBzskE1xX1/wpcKV47K17pESp05UGngb99iEaX1J
	T+9wyr7meyZrivY7GI2XT5AK+dWpE7HJCKBDRuXvQWL83jHYnug4IyEL
X-Gm-Gg: ASbGnctuYwwerypuzQmOxWMULr01JmE4+p74C5h/5u73AdREuO0Bba1V4IGzldeaSZm
	pVmfNBfmBzYOeiKrL/Rs2LBK7BWRMgPo30iIotFLV28D8dq3FxYtDNH+C13tXwACJE2vQTXtTxu
	XAmJE//Cbj41bvpoBkjVC6ryTd/QpIiJmp0omWARuwOy7uKZcyhhU60hTwFS4doZNyKPFwRKTbN
	q0MAzrjj3t+RRM9oVBP6V4cHBXRUD8Ma0kGB8onQt1+iKsH+6OJcHJz2sx8LtQeoV0KwjoDmDkd
	0+KCwtnOrF3Vtrg+g7kCtSpCsp60EOeyYWmQCqqHBbktEgXleLRXQhRVw2s6WzTzxn8CgLk5AE1
	rZM1M+7Qzjtt3yIYSeqqi/sdgo9HlUxkYjmLRqijYE4zTuyQPFJAMQTgDQaTFg2+TP+Z1
X-Google-Smtp-Source: AGHT+IGYzqj0kH8wn480kr3FBbj99pmKP5/Eu4pwQHjyBRT16VOhkTt/2Q3FevKH1201wdR/kcGe2g==
X-Received: by 2002:a17:907:db15:b0:ad8:882e:38a with SMTP id a640c23a62f3a-ae9c9b8e572mr853708966b.14.1753138823178;
        Mon, 21 Jul 2025 16:00:23 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-142-142.dynamic.sbb.rs. [94.189.142.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d8357sm753164466b.52.2025.07.21.16.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 16:00:22 -0700 (PDT)
Message-ID: <85de2e1f-a787-4862-87e4-2681e749cef0@gmail.com>
Date: Tue, 22 Jul 2025 01:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] kasan/um: select ARCH_DEFER_KASAN and call
 kasan_init_generic
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-9-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250717142732.292822-9-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:
> UserMode Linux needs deferred KASAN initialization as it has a custom
> kasan_arch_is_ready() implementation that tracks shadow memory readiness
> via the kasan_um_is_ready flag.
> 
> Select ARCH_DEFER_KASAN to enable the unified static key mechanism
> for runtime KASAN control. Call kasan_init_generic() which handles
> Generic KASAN initialization and enables the static key.
> 
> Delete the key kasan_um_is_ready in favor of the unified kasan_enabled()
> interface.
> 
> Note that kasan_init_generic has __init macro, which is called by
> kasan_init() which is not marked with __init in arch/um code.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes in v3:
> - Added CONFIG_ARCH_DEFER_KASAN selection for proper runtime control
> ---
>  arch/um/Kconfig             | 1 +
>  arch/um/include/asm/kasan.h | 5 -----
>  arch/um/kernel/mem.c        | 4 ++--
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index f08e8a7fac9..fd6d78bba52 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -8,6 +8,7 @@ config UML
>  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  	select ARCH_HAS_CPU_FINALIZE_INIT
>  	select ARCH_HAS_FORTIFY_SOURCE
> +	select ARCH_DEFER_KASAN
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_STRNCPY_FROM_USER
> diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
> index f97bb1f7b85..81bcdc0f962 100644
> --- a/arch/um/include/asm/kasan.h
> +++ b/arch/um/include/asm/kasan.h
> @@ -24,11 +24,6 @@
>  
>  #ifdef CONFIG_KASAN
>  void kasan_init(void);
> -extern int kasan_um_is_ready;
> -
> -#ifdef CONFIG_STATIC_LINK
> -#define kasan_arch_is_ready() (kasan_um_is_ready)
> -#endif
>  #else
>  static inline void kasan_init(void) { }
>  #endif /* CONFIG_KASAN */
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 76bec7de81b..058cb70e330 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -21,9 +21,9 @@
>  #include <os.h>
>  #include <um_malloc.h>
>  #include <linux/sched/task.h>
> +#include <linux/kasan.h>
>  
>  #ifdef CONFIG_KASAN
> -int kasan_um_is_ready;
>  void kasan_init(void)
>  {
>  	/*
> @@ -32,7 +32,7 @@ void kasan_init(void)
>  	 */
>  	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
>  	init_task.kasan_depth = 0;
> -	kasan_um_is_ready = true;
> +	kasan_init_generic();

I think this runs before jump_label_init(), and static keys shouldn't be switched before that.>  }
>  
>  static void (*kasan_init_ptr)(void)

