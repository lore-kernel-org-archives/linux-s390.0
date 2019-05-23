Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] powerpc/power: Expose pfn_is_nosave prototype
References: <20190523114736.30268-1-malat@debian.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <11ffdbd5-60a9-b1fa-aa83-9d3c60e3d462@c-s.fr>
Date: Thu, 23 May 2019 14:02:05 +0200
MIME-Version: 1.0
In-Reply-To: <20190523114736.30268-1-malat@debian.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, linuxppc-dev@lists.ozlabs.org



Le 23/05/2019 à 13:47, Mathieu Malaterre a écrit :
> The declaration for pfn_is_nosave is only available in
> kernel/power/power.h. Since this function can be override in arch,
> expose it globally. Having a prototype will make sure to avoid warning
> (sometime treated as error with W=1) such as:
> 
>    arch/powerpc/kernel/suspend.c:18:5: error: no previous prototype for 'pfn_is_nosave' [-Werror=missing-prototypes]
> 
> This moves the declaration into a globally visible header file and add
> missing include to avoid a warning in powerpc.

Then you should also drop it from kernel/power/power.h and 
arch/s390/kernel/entry.h

Christophe

> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/kernel/suspend.c | 1 +
>   include/linux/suspend.h       | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/suspend.c b/arch/powerpc/kernel/suspend.c
> index a531154cc0f3..9e1b6b894245 100644
> --- a/arch/powerpc/kernel/suspend.c
> +++ b/arch/powerpc/kernel/suspend.c
> @@ -8,6 +8,7 @@
>    */
>   
>   #include <linux/mm.h>
> +#include <linux/suspend.h>
>   #include <asm/page.h>
>   #include <asm/sections.h>
>   
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 3f529ad9a9d2..2660bbdf5230 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -395,6 +395,7 @@ extern bool system_entering_hibernation(void);
>   extern bool hibernation_available(void);
>   asmlinkage int swsusp_save(void);
>   extern struct pbe *restore_pblist;
> +int pfn_is_nosave(unsigned long pfn);
>   #else /* CONFIG_HIBERNATION */
>   static inline void register_nosave_region(unsigned long b, unsigned long e) {}
>   static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
> 
