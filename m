Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 2 Mar 2017 12:07:09 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCHv2 01/14] treewide: Move set_memory_* functions away from
 cacheflush.h
Message-ID: <20170302120709.GL21222@n2100.armlinux.org.uk>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-2-git-send-email-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488413706-9739-2-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170302120709.yMrr2zQMWtWNdfRn62NAIAJGl08xHEMMSxpY_ElkVQs@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 01, 2017 at 04:14:53PM -0800, Laura Abbott wrote:
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 02454fa..1cb9d11 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -16,6 +16,7 @@
>  #include <asm/shmparam.h>
>  #include <asm/cachetype.h>
>  #include <asm/outercache.h>
> +#include <asm/set_memory.h>
>  
>  #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
>  
> @@ -478,26 +479,6 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
>  	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
>  	      "r9","r10","lr","memory" )
>  
> -#ifdef CONFIG_MMU
> -int set_memory_ro(unsigned long addr, int numpages);
> -int set_memory_rw(unsigned long addr, int numpages);
> -int set_memory_x(unsigned long addr, int numpages);
> -int set_memory_nx(unsigned long addr, int numpages);
> -#else
> -static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
> -static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
> -static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
> -static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
> -#endif
> -
> -#ifdef CONFIG_STRICT_KERNEL_RWX
> -void set_kernel_text_rw(void);
> -void set_kernel_text_ro(void);
> -#else
> -static inline void set_kernel_text_rw(void) { }
> -static inline void set_kernel_text_ro(void) { }
> -#endif
> -
>  void flush_uprobe_xol_access(struct page *page, unsigned long uaddr,
>  			     void *kaddr, unsigned long len);
>  
> diff --git a/arch/arm/include/asm/set_memory.h b/arch/arm/include/asm/set_memory.h
> new file mode 100644
> index 0000000..5aa4315
> --- /dev/null
> +++ b/arch/arm/include/asm/set_memory.h
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (C) 1999-2002 Russell King
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _ASMARM_SET_MEMORY_H
> +#define _ASMARM_SET_MEMORY_H
> +
> +#ifdef CONFIG_MMU
> +int set_memory_ro(unsigned long addr, int numpages);
> +int set_memory_rw(unsigned long addr, int numpages);
> +int set_memory_x(unsigned long addr, int numpages);
> +int set_memory_nx(unsigned long addr, int numpages);
> +#else
> +static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
> +static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
> +static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
> +static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
> +#endif
> +
> +#ifdef CONFIG_STRICT_KERNEL_RWX
> +void set_kernel_text_rw(void);
> +void set_kernel_text_ro(void);
> +#else
> +static inline void set_kernel_text_rw(void) { }
> +static inline void set_kernel_text_ro(void) { }
> +#endif
> +
> +#endif

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
