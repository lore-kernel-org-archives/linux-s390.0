Return-Path: <rdunlap@infradead.org>
Subject: Re: [PATCH 2/9] timers: provide a "modern" variant of timers
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-3-hch@lst.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cba2a61d-00cd-f4a1-d7ce-e7249a60fee8@infradead.org>
Date: Tue, 16 May 2017 12:29:16 -0700
MIME-Version: 1.0
In-Reply-To: <20170516114812.10660-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05/16/17 04:48, Christoph Hellwig wrote:

> diff --git a/include/linux/timer.h b/include/linux/timer.h
> index e6789b8757d5..87afe52c8349 100644
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h
		\
> @@ -126,6 +146,32 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
>  	init_timer_on_stack_key((_timer), (_flags), NULL, NULL)
>  #endif
>  
> +/**
> + * prepare_timer - initialize a timer before first use
> + * @timer:	timer structure to prepare
> + * @func:	callback to be called when the timer expires
> + * @flags	%TIMER_* flags that control timer behavior

missing ':' on @flags:

> + *
> + * This function initializes a timer_list structure so that it can
> + * be used (by calling add_timer() or mod_timer()).
> + */
> +static inline void prepare_timer(struct timer_list *timer,
> +		void (*func)(struct timer_list *timer), u32 flags)
> +{



-- 
~Randy
