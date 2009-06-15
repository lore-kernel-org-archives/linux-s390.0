From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 15 Jun 2009 20:18:38 +0000
Subject: Re: [PATCH] qdio: add check index of input- and output_qs[]
Message-Id: <20090615201837.GA4788@osiris.boeblingen.de.ibm.com>
In-Reply-To: <4A36BEBC.6020503@gmail.com>
References: <4A36BEBC.6020503@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 15, 2009 at 11:35:56PM +0200, Roel Kluin wrote:
> Ensure that q_nr is within the bounds of array irq_ptr->input_qs[] and
> ->output_qs[].
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> I didn't notice this when writing my previous patch. Should bufnr and
> count be larger than 0 as well?
> 
> diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
> index d79cf5b..9dbc4b1 100644
> --- a/drivers/s390/cio/qdio_main.c
> +++ b/drivers/s390/cio/qdio_main.c
> @@ -1494,7 +1494,7 @@ int do_QDIO(struct ccw_device *cdev, unsigned int callflags,
> 
>  	if ((bufnr > QDIO_MAX_BUFFERS_PER_Q) ||
>  	    (count > QDIO_MAX_BUFFERS_PER_Q) ||
> -	    (q_nr >= QDIO_MAX_QUEUES_PER_IRQ))
> +	    (q_nr >= QDIO_MAX_QUEUES_PER_IRQ) || (q_nr < 0))
>  		return -EINVAL;

These are just sanity checks. I'd rather prefer to see all of them go away or
have them under an #ifdef DEBUG.
But it's Jan's call. He is the maintainer of the driver.
