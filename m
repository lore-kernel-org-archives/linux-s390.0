From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 19 Mar 2012 10:41:44 +0000
Subject: Re: [PATCH] s390: Remove unncessary export of arch_pick_mmap_layout
Message-Id: <20120319114144.33abbb95@de.ibm.com>
In-Reply-To: <1332038996.31699.8.camel@deadeye>
References: <1332038996.31699.8.camel@deadeye>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 18 Mar 2012 02:49:56 +0000
Ben Hutchings <ben@decadent.org.uk> wrote:

> This function is defined for use in exec, not in modules.
> No other architecture exports its implementation.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  arch/s390/mm/mmap.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index a0155c0..2857c48 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -100,7 +100,6 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
>  		mm->unmap_area = arch_unmap_area_topdown;
>  	}
>  }
> -EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
> 
>  #else
> 
> @@ -175,6 +174,5 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
>  		mm->unmap_area = arch_unmap_area_topdown;
>  	}
>  }
> -EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
> 
>  #endif

Added the my patch queue. Thanks Ben.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
