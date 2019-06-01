Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 1 Jun 2019 12:55:35 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: mmap base does not depend on ADDR_NO_RANDOMIZE
 personality
References: <20190404061956.25507-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404061956.25507-1-alex@ghiti.fr>
Message-Id: <20190601105534.GG3600@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 04, 2019 at 02:19:56AM -0400, Alexandre Ghiti wrote:
> randomize_stack_top() checks for current task flag PF_RANDOMIZE in order
> to use stack randomization and PF_RANDOMIZE is set when
> ADDR_NO_RANDOMIZE is unset, so no need to check for ADDR_NO_RANDOMIZE
> in stack_maxrandom_size.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/s390/mm/mmap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index 687f2a4d3459..5185ed0a0463 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -24,8 +24,7 @@ static unsigned long stack_maxrandom_size(void)
>  {
>  	if (!(current->flags & PF_RANDOMIZE))
>  		return 0;
> -	if (current->personality & ADDR_NO_RANDOMIZE)
> -		return 0;
> +
>  	return STACK_RND_MASK << PAGE_SHIFT;

Applied, thanks.
