Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 19 Aug 2011 08:16:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: fix _TIF_SINGLE_STEP definition
Message-ID: <20110819081637.76e52a6a@mschwide>
In-Reply-To: <20110818163702.GF20085@htj.dyndns.org>
References: <20110818163702.GF20085@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 18 Aug 2011 18:37:02 +0200
Tejun Heo <tj@kernel.org> wrote:

> _TIF_SINGLE_STEP is incorrectly defined as 1<<TIF_FREEZE.  Fix it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  arch/s390/include/asm/thread_info.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: work/arch/s390/include/asm/thread_info.h
> ===================================================================
> --- work.orig/arch/s390/include/asm/thread_info.h
> +++ work/arch/s390/include/asm/thread_info.h
> @@ -117,7 +117,7 @@ static inline struct thread_info *curren
>  #define _TIF_SIE		(1<<TIF_SIE)
>  #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
>  #define _TIF_31BIT		(1<<TIF_31BIT)
> -#define _TIF_SINGLE_STEP	(1<<TIF_FREEZE)
> +#define _TIF_SINGLE_STEP	(1<<TIF_SINGLE_STEP)
>  #define _TIF_FREEZE		(1<<TIF_FREEZE)
> 
>  #ifdef CONFIG_64BIT

Whoa, that has been "unfixed" by git commit 5e9a26928f550157..
Nice catch!

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
