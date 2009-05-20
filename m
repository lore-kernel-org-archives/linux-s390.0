From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 20 May 2009 06:57:17 +0000
Subject: Re: [PATCH] s390: beyond ARRAY_SIZE of irq_ptr->{in,out}put_qs
Message-Id: <20090520085717.07847c5c@skybase>
In-Reply-To: <4A134C97.1020409@gmail.com>
References: <4A134C97.1020409@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 20 May 2009 02:19:35 +0200
Roel Kluin <roel.kluin@gmail.com> wrote:

> Do not go beyond ARRAY_SIZE of irq_ptr->{in,out}put_qs
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
> index accd957..758e4b1 100644
> --- a/drivers/s390/cio/qdio_main.c
> +++ b/drivers/s390/cio/qdio_main.c
> @@ -1514,7 +1514,7 @@ int do_QDIO(struct ccw_device *cdev, unsigned int callflags,
> 
>  	if ((bufnr > QDIO_MAX_BUFFERS_PER_Q) ||
>  	    (count > QDIO_MAX_BUFFERS_PER_Q) ||
> -	    (q_nr > QDIO_MAX_QUEUES_PER_IRQ))
> +	    (q_nr >= QDIO_MAX_QUEUES_PER_IRQ))
>  		return -EINVAL;
> 
>  	if (!count)

Nice find. I'll queue the patch to the git390 tree.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
