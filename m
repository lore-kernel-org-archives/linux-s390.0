From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 06 Sep 2012 08:26:02 +0000
Subject: Re: [PATCH] [S390] 3270 console: Drop unused spinlock
Message-Id: <20120906102602.147f2359@de.ibm.com>
In-Reply-To: <20120906082156.GB4324@osiris.de.ibm.com>
References: <20120906082156.GB4324@osiris.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 6 Sep 2012 09:55:56 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> I was checking why this spinlock was never initialized, but it turns
> out it's not used anywhere, so we can drop it.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
> I can't even build-test this.
> 
>  drivers/s390/char/con3270.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- linux-3.6-rc4.orig/drivers/s390/char/con3270.c	2012-07-21 22:58:29.000000000 +0200
> +++ linux-3.6-rc4/drivers/s390/char/con3270.c	2012-09-06 09:52:43.801881092 +0200
> @@ -35,7 +35,6 @@ static struct raw3270_fn con3270_fn;
>   */
>  struct con3270 {
>  	struct raw3270_view view;
> -	spinlock_t lock;
>  	struct list_head freemem;	/* list of free memory for strings. */
> 
>  	/* Output stuff. */
> 
>  

That is true, the code always uses the view->lock. I'll add this to the queue. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
