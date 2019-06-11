Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62859 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405412AbfFKKRh (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:37 -0400
Date: Tue, 11 Jun 2019 12:17:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 4/8] s390/airq: use DMA memory for adapter interrupts
Message-ID: <20190611121721.61bf09b4.cohuck@redhat.com>
In-Reply-To: <20190606115127.55519-5-pasic@linux.ibm.com>
References: <20190606115127.55519-1-pasic@linux.ibm.com>
        <20190606115127.55519-5-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>

On Thu,  6 Jun 2019 13:51:23 +0200
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
>  drivers/s390/cio/airq.c      | 32 ++++++++++++++++++++------------
>  drivers/s390/cio/cio.h       |  2 ++
>  drivers/s390/cio/css.c       |  1 +
>  4 files changed, 25 insertions(+), 12 deletions(-)
> 

(...)

> @@ -295,12 +303,12 @@ unsigned long airq_iv_scan(struct airq_iv *iv, unsigned long start,
>  }
>  EXPORT_SYMBOL(airq_iv_scan);
>  
> -static int __init airq_init(void)
> +int __init airq_init(void)
>  {
> -	airq_iv_cache = kmem_cache_create("airq_iv_cache", cache_line_size(),
> -					  cache_line_size(), 0, NULL);
> +	airq_iv_cache = dma_pool_create("airq_iv_cache", cio_get_dma_css_dev(),
> +					cache_line_size(),
> +					cache_line_size(), PAGE_SIZE);
>  	if (!airq_iv_cache)
>  		return -ENOMEM;

Sorry about not noticing that in the last iteration; but you may return
an error here if airq_iv_cache could not be allocated...

>  	return 0;
>  }
> -subsys_initcall(airq_init);

(...)

> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index 6fc91d534af1..7901c8ed3597 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -1182,6 +1182,7 @@ static int __init css_bus_init(void)
>  	ret = cio_dma_pool_init();
>  	if (ret)
>  		goto out_unregister_pmn;
> +	airq_init();

...but don't check the return code here. Probably a pathological case,
but shouldn't you handle that error as well?

>  	css_init_done = 1;
>  
>  	/* Enable default isc for I/O subchannels. */
