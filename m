Return-Path: <SRS0=crtG=TI=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 8 May 2019 15:18:10 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 05/10] s390/cio: introduce DMA pools to cio
In-Reply-To: <20190426183245.37939-6-pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com> <20190426183245.37939-6-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1905081447280.1773@schleppi>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On Fri, 26 Apr 2019, Halil Pasic wrote:
> @@ -224,6 +228,9 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
>  	INIT_WORK(&sch->todo_work, css_sch_todo);
>  	sch->dev.release = &css_subchannel_release;
>  	device_initialize(&sch->dev);
> +	sch->dma_mask = css_dev_dma_mask;
> +	sch->dev.dma_mask = &sch->dma_mask;
> +	sch->dev.coherent_dma_mask = sch->dma_mask;

Could we do:
	sch->dev.dma_mask = &sch->dev.coherent_dma_mask;
	sch->dev.coherent_dma_mask = css_dev_dma_mask;
?

> +#define POOL_INIT_PAGES 1
> +static struct gen_pool *cio_dma_pool;
> +/* Currently cio supports only a single css */
> +#define  CIO_DMA_GFP (GFP_KERNEL | __GFP_ZERO)

__GFP_ZERO has no meaning with the dma api (since all implementations do
an implicit zero initialization) but let's keep it for the sake of
documentation.

We need GFP_DMA here (which will return addresses < 2G on s390)!

> +void cio_gp_dma_free(struct gen_pool *gp_dma, void *cpu_addr, size_t size)
> +{
> +	if (!cpu_addr)
> +		return;
> +	memset(cpu_addr, 0, size);

Hm, normally I'd do the memset during alloc not during free - but maybe
this makes more sense here with your usecase in mind.

> @@ -1063,6 +1163,7 @@ static int __init css_bus_init(void)
>  		unregister_reboot_notifier(&css_reboot_notifier);
>  		goto out_unregister;
>  	}
> +	cio_dma_pool_init();

This is too late for early devices (ccw console!).
