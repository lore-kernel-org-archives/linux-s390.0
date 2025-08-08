Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189523C17;
	Fri,  8 Aug 2025 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754630436; cv=none; b=hOlyT+YAvSnE8QQGWeIx+f0KhxlV2f37xwdSL9Xl5lcU7n1Gw5mX016d0gk9dEs+wAIUh+DvieS+luCW/ukgJZ8CVr1qwmxzA4cuegY1P7Hj6gUDxmfdC8+p+UgQfzT1/V1zx6VY8lkEdRhyyGrbp8lE0u0HPeeY0A9A91g4XHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754630436; c=relaxed/simple;
	bh=X5n4kFa1Y07R3QNafbd9SAyDbCqixtJlEuzExt4eaXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJsKmM/7HD6Kuaa/3D9TTG0TQG0hAVWQ4/MM1kxepatO0JhV6zgdZKBJonX1Xz8mnEckh3Ex4RGFYQsn8rfx7lKqnuv79jHRsHiqX1Nu93AhezeNMjY/BZwpFghNtCEcbi0G+tifGtQfYZ1CB8w1OEXxXbB/yKlJtVRZVLadBfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4bysTv1SGvz9sRs;
	Fri,  8 Aug 2025 07:07:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 136VSEc6Znrg; Fri,  8 Aug 2025 07:07:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4bysTv0NP1z9sRk;
	Fri,  8 Aug 2025 07:07:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E9F118B770;
	Fri,  8 Aug 2025 07:07:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ibwVE1n70MLp; Fri,  8 Aug 2025 07:07:30 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E61968B763;
	Fri,  8 Aug 2025 07:07:28 +0200 (CEST)
Message-ID: <07ffb27c-3416-43c9-a50a-164a76e5ab60@csgroup.eu>
Date: Fri, 8 Aug 2025 07:07:28 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] kasan: call kasan_init_generic in kasan_init
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com,
 bhe@redhat.com, hca@linux.ibm.com, andreyknvl@gmail.com,
 akpm@linux-foundation.org, zhangqing@loongson.cn, chenhuacai@loongson.cn,
 davidgow@google.co, glider@google.com, dvyukov@google.com
Cc: alex@ghiti.fr, agordeev@linux.ibm.com, vincenzo.frascino@arm.com,
 elver@google.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20250807194012.631367-1-snovitoll@gmail.com>
 <20250807194012.631367-3-snovitoll@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250807194012.631367-3-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 07/08/2025 à 21:40, Sabyrzhan Tasbolatov a écrit :
> Call kasan_init_generic() which handles Generic KASAN initialization.
> For architectures that do not select ARCH_DEFER_KASAN,
> this will be a no-op for the runtime flag but will
> print the initialization banner.
> 
> For SW_TAGS and HW_TAGS modes, their respective init functions will
> handle the flag enabling, if they are enabled/implemented.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
> ---
> Changes in v5:
> - Unified arch patches into a single one, where we just call
> 	kasan_init_generic()
> - Added Tested-by tag for riscv (tested the same change in v4)
> - Added Acked-by tag for s390 (tested the same change in v4)
> ---
>   arch/arm/mm/kasan_init.c    | 2 +-
>   arch/arm64/mm/kasan_init.c  | 4 +---
>   arch/riscv/mm/kasan_init.c  | 1 +
>   arch/s390/kernel/early.c    | 3 ++-
>   arch/x86/mm/kasan_init_64.c | 2 +-
>   arch/xtensa/mm/kasan_init.c | 2 +-
>   6 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
> index 111d4f70313..c6625e808bf 100644
> --- a/arch/arm/mm/kasan_init.c
> +++ b/arch/arm/mm/kasan_init.c
> @@ -300,6 +300,6 @@ void __init kasan_init(void)
>   	local_flush_tlb_all();
>   
>   	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
> -	pr_info("Kernel address sanitizer initialized\n");
>   	init_task.kasan_depth = 0;
> +	kasan_init_generic();
>   }
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index d541ce45dae..abeb81bf6eb 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -399,14 +399,12 @@ void __init kasan_init(void)
>   {
>   	kasan_init_shadow();
>   	kasan_init_depth();
> -#if defined(CONFIG_KASAN_GENERIC)
> +	kasan_init_generic();
>   	/*
>   	 * Generic KASAN is now fully initialized.
>   	 * Software and Hardware Tag-Based modes still require
>   	 * kasan_init_sw_tags() and kasan_init_hw_tags() correspondingly.
>   	 */
> -	pr_info("KernelAddressSanitizer initialized (generic)\n");
> -#endif
>   }
>   
>   #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 41c635d6aca..ba2709b1eec 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -530,6 +530,7 @@ void __init kasan_init(void)
>   
>   	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
>   	init_task.kasan_depth = 0;
> +	kasan_init_generic();

I understood KASAN is really ready to function only once the csr_write() 
and local_flush_tlb_all() below are done. Shouldn't kasan_init_generic() 
be called after it ?

>   
>   	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
>   	local_flush_tlb_all();
> diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
> index 9adfbdd377d..544e5403dd9 100644
> --- a/arch/s390/kernel/early.c
> +++ b/arch/s390/kernel/early.c
> @@ -21,6 +21,7 @@
>   #include <linux/kernel.h>
>   #include <asm/asm-extable.h>
>   #include <linux/memblock.h>
> +#include <linux/kasan.h>
>   #include <asm/access-regs.h>
>   #include <asm/asm-offsets.h>
>   #include <asm/machine.h>
> @@ -65,7 +66,7 @@ static void __init kasan_early_init(void)
>   {
>   #ifdef CONFIG_KASAN
>   	init_task.kasan_depth = 0;
> -	pr_info("KernelAddressSanitizer initialized\n");
> +	kasan_init_generic();
>   #endif
>   }
>   
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index 0539efd0d21..998b6010d6d 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -451,5 +451,5 @@ void __init kasan_init(void)
>   	__flush_tlb_all();
>   
>   	init_task.kasan_depth = 0;
> -	pr_info("KernelAddressSanitizer initialized\n");
> +	kasan_init_generic();
>   }
> diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
> index f39c4d83173..0524b9ed5e6 100644
> --- a/arch/xtensa/mm/kasan_init.c
> +++ b/arch/xtensa/mm/kasan_init.c
> @@ -94,5 +94,5 @@ void __init kasan_init(void)
>   
>   	/* At this point kasan is fully initialized. Enable error messages. */
>   	current->kasan_depth = 0;
> -	pr_info("KernelAddressSanitizer initialized\n");
> +	kasan_init_generic();
>   }

