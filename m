Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 10 Apr 2018 16:35:59 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: s390: defective uses of va_arg in __debug_sprintf_event
Message-ID: <20180410143559.wlt5sfb2t24q6g3g@pathway.suse.cz>
References: <1523041723.6127.33.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523041723.6127.33.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-ID: <linux-s390.vger.kernel.org>

On Fri 2018-04-06 12:08:43, Joe Perches wrote:
> And I found this when looking at another defect
> in debug_sprintf_event where a %p<foo> extension
> is unintentionally used via a string concatenation.
> as pointed out by Rasmus Villemoes
> ---
>  arch/s390/kernel/perf_cpum_sf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
> index 1c9ddd7aa5ec..1c449a6f841a 100644
> --- a/arch/s390/kernel/perf_cpum_sf.c
> +++ b/arch/s390/kernel/perf_cpum_sf.c
> @@ -212,9 +212,7 @@ static int realloc_sampling_buffer(struct sf_buffer *sfb,
>  	 * the sampling buffer origin.
>  	 */
>  	if (sfb->sdbt != get_next_sdbt(tail)) {
> -		debug_sprintf_event(sfdbg, 3, "realloc_sampling_buffer: "
> -				    "sampling buffer is not linked: origin=%p"
> -				    "tail=%p\n",
> +		debug_sprintf_event(sfdbg, 3, "realloc_sampling_buffer: sampling buffer is not linked: origin=%p tail=%p\n",
>  				    (void *) sfb->sdbt, (void *) tail);
>  		return -EINVAL;
>  	}

This concatenation fix is correct. %p has many possible specifiers.
The code takes a simple approach and substitute "%ptail" with the
pointer value. See the following code in vsnprintf():

		case FORMAT_TYPE_PTR:
			str = pointer(fmt, str, end, va_arg(args, void *),
				      spec);
			while (isalnum(*fmt))
				fmt++;
			break;

We might debate if vsprintf() should handle this better. Anyway, there
is a missing space in the above debug_sprintf_event() call.

Joe, are you going to send this as a separate patch, your SOB, ...?

Best Regards,
Petr
