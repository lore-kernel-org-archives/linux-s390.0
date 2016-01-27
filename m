From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v3 2/3] x86: query dynamic DEBUG_PAGEALLOC setting
Date: Wed, 27 Jan 2016 14:17:05 -0800 (PST)
Message-ID: <alpine.DEB.2.10.1601271414180.23510@chino.kir.corp.google.com>
References: <1453889401-43496-1-git-send-email-borntraeger@de.ibm.com> <1453889401-43496-3-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1453889401-43496-3-git-send-email-borntraeger@de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
List-ID: <linux-s390.vger.kernel.org>

On Wed, 27 Jan 2016, Christian Borntraeger wrote:

> We can use debug_pagealloc_enabled() to check if we can map
> the identity mapping with 2MB pages. We can also add the state
> into the dump_stack output.
> 
> The patch does not touch the code for the 1GB pages, which ignored
> CONFIG_DEBUG_PAGEALLOC. Do we need to fence this as well?
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/dumpstack.c |  5 ++---
>  arch/x86/mm/init.c          |  7 ++++---
>  arch/x86/mm/pageattr.c      | 14 ++++----------
>  3 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 9c30acf..32e5699 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -265,9 +265,8 @@ int __die(const char *str, struct pt_regs *regs, long err)
>  #ifdef CONFIG_SMP
>  	printk("SMP ");
>  #endif
> -#ifdef CONFIG_DEBUG_PAGEALLOC
> -	printk("DEBUG_PAGEALLOC ");
> -#endif
> +	if (debug_pagealloc_enabled())
> +		printk("DEBUG_PAGEALLOC ");
>  #ifdef CONFIG_KASAN
>  	printk("KASAN");
>  #endif
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 493f541..39823fd 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -150,13 +150,14 @@ static int page_size_mask;
>  
>  static void __init probe_page_size_mask(void)
>  {
> -#if !defined(CONFIG_DEBUG_PAGEALLOC) && !defined(CONFIG_KMEMCHECK)
> +#if !defined(CONFIG_KMEMCHECK)
>  	/*
> -	 * For CONFIG_DEBUG_PAGEALLOC, identity mapping will use small pages.
> +	 * For CONFIG_KMEMCHECK or pagealloc debugging, identity mapping will
> +	 * use small pages.
>  	 * This will simplify cpa(), which otherwise needs to support splitting
>  	 * large pages into small in interrupt context, etc.
>  	 */
> -	if (cpu_has_pse)
> +	if (cpu_has_pse && !debug_pagealloc_enabled())
>  		page_size_mask |= 1 << PG_LEVEL_2M;
>  #endif
>  

I would have thought free_init_pages() would be modified to use 
debug_pagealloc_enabled() as well?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
