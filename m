Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 May 2015 11:07:15 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH RFC] s390/sclp: pass timeout as HZ independent value
Message-ID: <20150529090715.GA4169@osiris>
References: <1432746283-8068-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432746283-8068-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Nicholas Mc Guire <hofrat@osadl.org>, Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 27, 2015 at 07:04:43PM +0200, Nicholas Mc Guire wrote:
> schedule_timeout takes a timeout in jiffies but the code currently is
> passing in a constant SDIAS_SLEEP_TICKS which sounds like it should be
> in jiffies but it is actually not and thus makes this timeout HZ
> dependent, to fix this it is passed through msecs_to_jiffies().
> 
> patch was not even compile tested as s390 toolchain from kernel.org 
> failed for me (on a debian wheezy x86_64) with:
> cc1: error: unrecognized command line option '-mtune=zEC12'
> 
> Patch is against 4.0-rc5 (localversion-next is -next-20150527)
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> As there is no documentation of the intended timeout it might be wrong
> to convert it with msecs_to_jiffies() since the effective timeout is 
> at least a factor 10 smaller than it is now - so someone that knows this
> driver needs to check on the actual value - but in any case it needs to
> be passed in a HZ independent way.

Yes, the orginal code seems to be broken. Since I've no idea what the intended
timeout value should be, let's simply ask Michael, who wrote this code eight
years ago ;)
While these lines get touched anyway, it would make sense to use
schedule_timeout_interruptible() instead, and get rid of set_current_state().


>  drivers/s390/char/sclp_sdias.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/char/sclp_sdias.c b/drivers/s390/char/sclp_sdias.c
> index eb7cb07..ab92a75 100644
> --- a/drivers/s390/char/sclp_sdias.c
> +++ b/drivers/s390/char/sclp_sdias.c
> @@ -68,7 +68,7 @@ static int sdias_sclp_send(struct sclp_req *req)
>  			/* not initiated, wait some time and retry */
>  			set_current_state(TASK_INTERRUPTIBLE);
>  			TRACE("add request failed: rc = %i\n",rc);
> -			schedule_timeout(SDIAS_SLEEP_TICKS);
> +			schedule_timeout(msecs_to_jiffies(SDIAS_SLEEP_TICKS));
>  			continue;
>  		}
>  		/* initiated, wait for completion of service call */
> -- 

Thanks,
Heiko
