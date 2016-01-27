From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 3/3] s390: query dynamic DEBUG_PAGEALLOC setting
Date: Wed, 27 Jan 2016 10:55:43 +0100
Message-ID: <20160127095543.GB4439@osiris>
References: <1453884618-33852-1-git-send-email-borntraeger@de.ibm.com>
 <1453884618-33852-4-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1453884618-33852-4-git-send-email-borntraeger@de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 27, 2016 at 09:50:18AM +0100, Christian Borntraeger wrote:
> We can use debug_pagealloc_enabled() to check if we can map
> the identity mapping with 1MB/2GB pages as well as to print
> the current setting in dump_stack.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kernel/dumpstack.c |  8 ++++----
>  arch/s390/mm/vmem.c          | 10 ++++------
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
> index dc8e204..3f352e9 100644
> --- a/arch/s390/kernel/dumpstack.c
> +++ b/arch/s390/kernel/dumpstack.c
> @@ -11,6 +11,7 @@
>  #include <linux/export.h>
>  #include <linux/kdebug.h>
>  #include <linux/ptrace.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  #include <asm/processor.h>
> @@ -184,10 +185,9 @@ void die(struct pt_regs *regs, const char *str)
>  #endif
>  #ifdef CONFIG_SMP
>  	printk("SMP ");
> -#endif
> -#ifdef CONFIG_DEBUG_PAGEALLOC
> -	printk("DEBUG_PAGEALLOC");
> -#endif
> +#endif	
> +if (debug_pagealloc_enabled())
> +		printk("DEBUG_PAGEALLOC");
>  	printk("\n");

Indentation is broken ("if").
Besides that

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
