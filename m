From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Sat, 22 Aug 2009 20:32:43 +0000
Subject: Re: [PATCH] s390: Reversed order of labels?
Message-Id: <20090822223243.0a667bd0@skybase>
In-Reply-To: <4A9006A1.7010706@gmail.com>
References: <4A9006A1.7010706@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 22 Aug 2009 16:54:25 +0200
Roel Kluin <roel.kluin@gmail.com> wrote:

> Fix the order of goto labels.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Is this correct? Please review.
> 
> diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
> index 1d420d9..7424d64 100644
> --- a/drivers/s390/char/tape_core.c
> +++ b/drivers/s390/char/tape_core.c
> @@ -358,11 +358,11 @@ tape_generic_online(struct tape_device *device,
> 
>  out_char:
>  	tapechar_cleanup_device(device);
> +out_minor:
> +	tape_remove_minor(device);
>  out_discipline:
>  	device->discipline->cleanup_device(device);
>  	device->discipline = NULL;
> -out_minor:
> -	tape_remove_minor(device);
>  out:
>  	module_put(discipline->owner);
>  	return rc;

Seems correct to me, if tape_assign_minor fails (e.g. because of too
many devices) then the function will try to remove the minor again
which is not registered. Nothing bad happens because tape_alloc_device
will initialize the list head but still. I'll add it to my patch queue.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
