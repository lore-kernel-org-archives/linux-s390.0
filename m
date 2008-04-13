From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 13 Apr 2008 18:15:15 +0000
Subject: Re: BUG: soft lockup detected on CPU#0! Process swapper
Message-Id: <20080413181515.GB2182@cs181133002.pp.htv.fi>
In-Reply-To: <20080226092012.GB7114@osiris.boeblingen.de.ibm.com>
References: <20080226092012.GB7114@osiris.boeblingen.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 26, 2008 at 10:20:12AM +0100, Heiko Carstens wrote:
>...
> Adrian, would you please consider the patch below for your 2.6.16 stable
> series? Patch is for 2.6.16.60. Upstream commit id in Linus' tree is
> dea20a3fbdd08e5ae2a0b33d2577c794a3764a11 . Thanks!

Thanks, applied.

> Subject: [PATCH] Disable DETECT_SOFTLOCKUP for s390
>     
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> We got several false bug reports because of enabled
> CONFIG_DETECT_SOFTLOCKUP.  Disable soft lockup detection on s390, since it
> doesn't work on a virtualized architecture.
>     
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
> 
>  lib/Kconfig.debug |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.16.60/lib/Kconfig.debug
> ===================================================================
> --- linux-2.6.16.60.orig/lib/Kconfig.debug
> +++ linux-2.6.16.60/lib/Kconfig.debug
> @@ -48,7 +48,7 @@ config LOG_BUF_SHIFT
>  
>  config DETECT_SOFTLOCKUP
>  	bool "Detect Soft Lockups"
> -	depends on DEBUG_KERNEL
> +	depends on DEBUG_KERNEL && !S390
>  	default y
>  	help
>  	  Say Y here to enable the kernel to detect "soft lockups",

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
