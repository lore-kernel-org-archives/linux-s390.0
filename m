Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfFLOfM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 10:35:12 -0400
Date: Wed, 12 Jun 2019 16:35:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 4/8] s390/airq: use DMA memory for adapter interrupts
Message-ID: <20190612163501.45a050b0.cohuck@redhat.com>
In-Reply-To: <20190612111236.99538-5-pasic@linux.ibm.com>
References: <20190612111236.99538-1-pasic@linux.ibm.com>
        <20190612111236.99538-5-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>

On Wed, 12 Jun 2019 13:12:32 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Protected virtualization guests have to use shared pages for airq
> notifier bit vectors, because hypervisor needs to write these bits.
> 
> Let us make sure we allocate DMA memory for the notifier bit vectors by
> replacing the kmem_cache with a dma_cache and kalloc() with
> cio_dma_zalloc().
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> ---
>  arch/s390/include/asm/airq.h |  2 ++
>  drivers/s390/cio/airq.c      | 37 ++++++++++++++++++++++--------------
>  drivers/s390/cio/cio.h       |  2 ++
>  drivers/s390/cio/css.c       |  1 +
>  4 files changed, 28 insertions(+), 14 deletions(-)
> 

(...)

>  /**
>   * airq_iv_create - create an interrupt vector
>   * @bits: number of bits in the interrupt vector
> @@ -132,17 +139,19 @@ struct airq_iv *airq_iv_create(unsigned long bits, unsigned long flags)
>  		goto out;
>  	iv->bits = bits;
>  	iv->flags = flags;
> -	size = BITS_TO_LONGS(bits) * sizeof(unsigned long);
> +	size = iv_size(bits);
>  
>  	if (flags & AIRQ_IV_CACHELINE) {
> -		if ((cache_line_size() * BITS_PER_BYTE) < bits)
> +		if ((cache_line_size() * BITS_PER_BYTE) < bits
> +				|| !airq_iv_cache)

I still think squashing this into the same if statement is a bit ugly,
but not really an issue.

>  			goto out_free;
>  
> -		iv->vector = kmem_cache_zalloc(airq_iv_cache, GFP_KERNEL);
> +		iv->vector = dma_pool_zalloc(airq_iv_cache, GFP_KERNEL,
> +					     &iv->vector_dma);
>  		if (!iv->vector)
>  			goto out_free;
>  	} else {
> -		iv->vector = kzalloc(size, GFP_KERNEL);
> +		iv->vector = cio_dma_zalloc(size);
>  		if (!iv->vector)
>  			goto out_free;
>  	}

(...)

> diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
> index 06a91743335a..4d6c7d16416e 100644
> --- a/drivers/s390/cio/cio.h
> +++ b/drivers/s390/cio/cio.h
> @@ -135,6 +135,8 @@ extern int cio_commit_config(struct subchannel *sch);
>  int cio_tm_start_key(struct subchannel *sch, struct tcw *tcw, u8 lpm, u8 key);
>  int cio_tm_intrg(struct subchannel *sch);
>  
> +extern int __init airq_init(void);
> +
>  /* Use with care. */
>  #ifdef CONFIG_CCW_CONSOLE
>  extern struct subchannel *cio_probe_console(void);
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index e0f19f1e82a0..1b867c941b86 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -1184,6 +1184,7 @@ static int __init css_bus_init(void)
>  	ret = cio_dma_pool_init();
>  	if (ret)
>  		goto out_unregister_pmn;
> +	airq_init();

Ignoring the return code here does not really hurt right now, but we
probably want to change that if we want to consider failures in css
initialization to be fatal.

>  	css_init_done = 1;
>  
>  	/* Enable default isc for I/O subchannels. */

On the whole, not really anything that needs changes right now, so have
a

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
